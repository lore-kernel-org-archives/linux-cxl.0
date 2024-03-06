Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1393E135418
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747546; cv=none; b=URWvC+WDNmAVPVDLT45oRGhWUxLSD0LQMN/fgxzF4ZgeptZuEynYVmuYXFJgSIKUm9yMvw62Q0NIH5zL/6Kt52YMpmCiS+KUNErK6n4CWLP3fnPsbWV3cCwQkGRRr1FHHbqPpJ7hp0hM31OJz8IBlMiLmHBrJVYharfRErZPlNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747546; c=relaxed/simple;
	bh=27c1Z3IXoNCQ4Ul1FxanNAG8X+ZVfbZ7tDwnCsdRMDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I91Qw+rs4vwcPeQDE4GgnGncCQio4UVcL/24XG8XVgR5FDZq6lVAj2EyWYGLI0I76N2HlvP5jfMhGY0ThFpV9aw21Nd9bwddIPMvPzc4ptqU72oNvAo745zaT7j/G7j+y0SYMDaCI+0FE9Ncx/Z7q+oteUT7CqOC18X6yiFvtaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7E3C433C7;
	Wed,  6 Mar 2024 17:52:24 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v3 3/3] cxl: Add checks to access_coordinate calculation to fail missing data
Date: Wed,  6 Mar 2024 10:52:04 -0700
Message-ID: <20240306175204.1906538-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306175204.1906538-1-dave.jiang@intel.com>
References: <20240306175204.1906538-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jonathan noted that when the coordinates for host bridge and switches
can be 0s if no actual data are retrieved and the calculation continues.
The resulting number would be inaccurate. Add checks to ensure that the
calculation would complete only if the numbers are valid.

While not seen in the wild, issue may show up with a BIOS that reported
CXL root ports via Generic Ports (via a PCI handle in the SRAT entry).

Fixes: 14a6960b3e92 ("cxl: Add helper function that calculate performance data for downstream ports")
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Simplify iteration loop in cxl_endpoint_get_perf_coordinates(). (Jonathan)
---
 drivers/cxl/core/port.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6fa273677963..baaaeddae775 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2110,6 +2110,20 @@ static void combine_coordinates(struct access_coordinate *c1,
 		c1->read_latency += c2->read_latency;
 }
 
+static bool coordinates_invalid(struct access_coordinate *c)
+{
+	if (!c->read_bandwidth && !c->write_bandwidth &&
+	    !c->read_latency && !c->write_latency)
+		return true;
+
+	return false;
+}
+
+static bool parent_port_is_cxl_root(struct cxl_port *port)
+{
+	return is_cxl_root(to_cxl_port(port->dev.parent));
+}
+
 /**
  * cxl_endpoint_get_perf_coordinates - Retrieve performance numbers stored in dports
  *				   of CXL path
@@ -2133,23 +2147,22 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
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
+	do {
+		dport = iter->parent_dport;
+		if (coordinates_invalid(&dport->coord))
+			return -EINVAL;
 		combine_coordinates(&c, &dport->coord);
 		c.write_latency += dport->link_latency;
 		c.read_latency += dport->link_latency;
 
 		iter = to_cxl_port(iter->dev.parent);
-		dport = iter->parent_dport;
-	}
+	} while (!parent_port_is_cxl_root(iter));
 
 	/* Get the calculated PCI paths bandwidth */
 	pdev = to_pci_dev(port->uport_dev->parent);
-- 
2.43.0

