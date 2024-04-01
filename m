Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B255C3B
	for <linux-cxl@vger.kernel.org>; Mon,  1 Apr 2024 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014492; cv=none; b=aESdIuuYWyVlLugVPUhFI7t17RCtAuqLeqFEs/0e0d+RO4ROMLdE+kXefnQ1H8pRgXMuH/s6DidPtz4a5HaPxH/TdQ33fOemlH9gEjumWdTJgzPWnmYfBMYVILri2CYmRxh75l65Hz2MzIbwc2YH9Ge4OnG4aqKbjFAIFx5B7L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014492; c=relaxed/simple;
	bh=68xj1q4amFWAsKsZ0OPdxDiJwkrbAw1XYh3gdk4bPTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOb17pWEBBbzbYHdV5QdWo4blrle88/ruaKjW8HEtfTsKCqySm5Ts4ZJ4uiYCI5o2wgkrlz2Pvjqd1RHhOea2+9uJB/XBFls9d18uGtW8IA0YH277bOvsFO4K58YYzyZzlJfFfF/Y/5fidLEshoNYYQo0FMpa7vRWCrAeQ8sO+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAA5C433F1;
	Mon,  1 Apr 2024 23:34:52 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v6 4/4] cxl: Add checks to access_coordinate calculation to fail missing data
Date: Mon,  1 Apr 2024 16:33:02 -0700
Message-ID: <20240401233445.3057332-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401233445.3057332-1-dave.jiang@intel.com>
References: <20240401233445.3057332-1-dave.jiang@intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e388f50675f8..ca5bc9ed6d2f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2141,6 +2141,18 @@ static void add_latency(struct access_coordinate *c, long latency)
 	}
 }
 
+static bool coordinates_valid(struct access_coordinate *c)
+{
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
+		if (c[i].read_bandwidth && c[i].write_bandwidth &&
+		    c[i].read_latency && c[i].write_latency)
+			continue;
+		return false;
+	}
+
+	return true;
+}
+
 static void set_min_bandwidth(struct access_coordinate *c, unsigned int bw)
 {
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
@@ -2156,6 +2168,11 @@ static void set_access_coordinates(struct access_coordinate *out,
 		out[i] = in[i];
 }
 
+static bool parent_port_is_cxl_root(struct cxl_port *port)
+{
+	return is_cxl_root(to_cxl_port(port->dev.parent));
+}
+
 /**
  * cxl_endpoint_get_perf_coordinates - Retrieve performance numbers stored in dports
  *				   of CXL path
@@ -2185,21 +2202,20 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
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
-		iter = to_cxl_port(iter->dev.parent);
+	do {
+		dport = iter->parent_dport;
+		if (!coordinates_valid(dport->coord))
+			return -EINVAL;
 		cxl_coordinates_combine(c, c, dport->coord);
 		add_latency(c, dport->link_latency);
-		dport = iter->parent_dport;
-	}
+		iter = to_cxl_port(iter->dev.parent);
+	} while (!parent_port_is_cxl_root(iter));
 
 	/* Get the calculated PCI paths bandwidth */
 	pdev = to_pci_dev(port->uport_dev->parent);
-- 
2.44.0

