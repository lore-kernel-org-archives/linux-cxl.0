Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990CF81AB0
	for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407763; cv=none; b=Bxkfib14hAEqxxxE0b7x4U/N6GCU772LYOtWTNd7k0wzC4PPvEKaxMW2MZJa2YNOvcY9hvt5AoH97PtVzrBKbC/Kndxmf2k6r0pAvBjPNAsJJyBtqe5eb+1WAINnW5oDBDHTYtjz70KLwbvwftR8+G7CWt6Y4FRzHoOuQwHtJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407763; c=relaxed/simple;
	bh=lYuWpvs+vn3H9j4stA5DH+CKvqxSgZIug3jBixHW3pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRBbyJVd0Z2wRqeggysuFol6OZwGM1izKT52mGN2uxyo9Ji+ul4Zv/G1DTG2N4g0KvUiJLUh6YJnN3Xz2LdsR9rjmEj+Oziqzz/sK/CV6mJSXHXwAQT3UqWnC3d7MOn2RfsZi86z5syy2qrMP46ZvYRyvo03IdZ0YbQW3knTy88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246CEC433F1;
	Mon, 25 Mar 2024 23:02:43 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v5 4/4] cxl: Add checks to access_coordinate calculation to fail missing data
Date: Mon, 25 Mar 2024 16:00:51 -0700
Message-ID: <20240325230234.1847525-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325230234.1847525-1-dave.jiang@intel.com>
References: <20240325230234.1847525-1-dave.jiang@intel.com>
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
v5:
- Adjust for multiple access classes.
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

