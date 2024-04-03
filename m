Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA1C14A090
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159333; cv=none; b=hbIvQBNmZt99hd//gpi04MZ5Rhz119tYF3/x/HhRM1C5eZhEmHSt1sX4HWEi4MKIooBzUlZSx3x6u7dPnkkii/OBX/aoVcyNyJ+OoZWfGAr8ROrjlWygMXVcEkSvqQtsWMMuGRHd1LLj6UIBM5USsLnCKP378Ls6XDDyyEWAZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159333; c=relaxed/simple;
	bh=uhFpLlWx4ZnvXt7OtDjitVLeo5hBFp887ClmHB5WCbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dkyc1DEJ5wTBiRYT02ivnOXDTeYS8P/8sinWKMiAgzBpjvK28PF2fFiz+lMujTWUm7MTzVOv7gR15zJzcVuqIjT7k4btcWCBXK62SvLXufqQTZfLpUOdS2EVBI63MMdT8OpNUFsk+x9gg+OjieIuDVhYuXr+pn+n5ksI+B9MFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B61C43390;
	Wed,  3 Apr 2024 15:48:52 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v7 2/5] cxl: Fix retrieving of access_coordinates in PCIe path
Date: Wed,  3 Apr 2024 08:47:13 -0700
Message-ID: <20240403154844.3403859-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403154844.3403859-1-dave.jiang@intel.com>
References: <20240403154844.3403859-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current loop in cxl_endpoint_get_perf_coordinates() incorrectly assumes
the Root Port (RP) dport is the one with generic port access_coordinate.
However those coordinates are one level up in the Host Bridge (HB).
Current code causes the computation code to pick up 0s as the coordinates
and cause minimal bandwidth to result in 0.

Add check to skip RP when combining coordinates.

Fixes: 4d59ba915318 ("cxl: Fix retrieving of access_coordinates in PCIe path")
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6cbde50a742b..7aadcec4fc64 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2165,6 +2165,11 @@ int cxl_hb_get_perf_coordinates(struct cxl_port *port,
 	return 0;
 }
 
+static bool parent_port_is_cxl_root(struct cxl_port *port)
+{
+	return is_cxl_root(to_cxl_port(port->dev.parent));
+}
+
 /**
  * cxl_endpoint_get_perf_coordinates - Retrieve performance numbers stored in dports
  *				   of CXL path
@@ -2184,27 +2189,31 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 	struct cxl_dport *dport;
 	struct pci_dev *pdev;
 	unsigned int bw;
+	bool is_cxl_root;
 
 	if (!is_cxl_endpoint(port))
 		return -EINVAL;
 
-	dport = iter->parent_dport;
-
 	/*
-	 * Exit the loop when the parent port of the current port is cxl root.
-	 * The iterative loop starts at the endpoint and gathers the
-	 * latency of the CXL link from the current iter to the next downstream
-	 * port each iteration. If the parent is cxl root then there is
-	 * nothing to gather.
+	 * Exit the loop when the parent port of the current iter port is cxl
+	 * root. The iterative loop starts at the endpoint and gathers the
+	 * latency of the CXL link from the current device/port to the connected
+	 * downstream port each iteration.
 	 */
-	while (!is_cxl_root(to_cxl_port(iter->dev.parent))) {
-		cxl_coordinates_combine(&c, &c, &dport->sw_coord);
+	do {
+		dport = iter->parent_dport;
+		iter = to_cxl_port(iter->dev.parent);
+		is_cxl_root = parent_port_is_cxl_root(iter);
+
+		/*
+		 * There's no valid access_coordinate for a root port since RPs do not
+		 * have CDAT and therefore needs to be skipped.
+		 */
+		if (!is_cxl_root)
+			cxl_coordinates_combine(&c, &c, &dport->sw_coord);
 		c.write_latency += dport->link_latency;
 		c.read_latency += dport->link_latency;
-
-		iter = to_cxl_port(iter->dev.parent);
-		dport = iter->parent_dport;
-	}
+	} while (!is_cxl_root);
 
 	/* Get the calculated PCI paths bandwidth */
 	pdev = to_pci_dev(port->uport_dev->parent);
-- 
2.44.0

