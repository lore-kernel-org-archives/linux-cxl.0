Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7246026AC0
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwTJu6u8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCB1D1
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 15:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700003135; x=1731539135;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ddt1BWi+ig5l73cyygQuKU9DwzXBxkNRRq0hoGUrw6k=;
  b=dwTJu6u8y8Dysa78YpIv3GhYJQ4WZmvga7hWV6aspsnbuSYWYwg0NPt8
   T41tbbaqU4B/D3mSfLg6J+qYFj4CISZucUoPlSgIm1r/ExXyTb1svkOmm
   0/zfOQSUlk8hJCQOaFqpuXXBZas1kNQfCcYh05e4LdtGitANTrf1Qs47W
   SxNeP7ejLaDkNxeBJUds0kDBupzRADluBIZ7R/B16A+/fi/QkzypkKpdR
   1EIGbrmkp7sZhxl7nOTfW3AC5+nAejvSUloLuTIy+X9ExFL9oh23JvNuZ
   k0hHgpe9bfoZhAblUeOh4PfpA8BHC9+ONiBa7kb9ebQewR9V2WSLFUyYj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12308479"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="12308479"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="12586003"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.87.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:33 -0800
Subject: [PATCH v12 14/18] cxl: Add helper function that calculate performance
 data for downstream ports
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 14 Nov 2023 16:05:32 -0700
Message-ID: <170000313272.1974471.5394138466060564535.stgit@djiang5-mobl3>
In-Reply-To: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
References: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The CDAT information from the switch, Switch Scoped Latency and Bandwidth
Information Structure (SSLBIS), is parsed and stored under a cxl_dport
based on the correlated downstream port id from the SSLBIS entry. Walk
the entire CXL port paths and collect all the performance data. Also
pick up the link latency number that's stored under the dports. The
entire path PCIe bandwidth can be retrieved using the
pcie_bandwidth_available() call.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v12:
- Adjust iteration loop to check for cxl_root as parent of iter
- Move combine_coordinates() of host bridge perf data outside the loop
---
 drivers/cxl/core/port.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    3 ++
 2 files changed, 78 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 9829f95ed77e..fd636c9e731b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -9,6 +9,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
+#include <linux/node.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
@@ -2096,6 +2097,80 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
 
+static void combine_coordinates(struct access_coordinate *c1,
+				struct access_coordinate *c2)
+{
+		if (c2->write_bandwidth)
+			c1->write_bandwidth = min(c1->write_bandwidth,
+						  c2->write_bandwidth);
+		c1->write_latency += c2->write_latency;
+
+		if (c2->read_bandwidth)
+			c1->read_bandwidth = min(c1->read_bandwidth,
+						 c2->read_bandwidth);
+		c1->read_latency += c2->read_latency;
+}
+
+/**
+ * cxl_endpoint_get_perf_coordinates - Retrieve performance numbers stored in dports
+ *				   of CXL path
+ * @port: endpoint cxl_port
+ * @coord: output performance data
+ *
+ * Return: errno on failure, 0 on success.
+ */
+int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
+				      struct access_coordinate *coord)
+{
+	struct access_coordinate c = {
+		.read_bandwidth = UINT_MAX,
+		.write_bandwidth = UINT_MAX,
+	};
+	struct cxl_port *iter = port;
+	struct cxl_dport *dport;
+	struct pci_dev *pdev;
+	unsigned int bw;
+
+	if (!is_cxl_endpoint(port))
+		return -EINVAL;
+
+	dport = iter->parent_dport;
+
+	/*
+	 * Exit the loop when the parent port of the current port is cxl root.
+	 * The iterative loop starts at the endpoint and gathers the
+	 * latency of the CXL link from the current iter to the next downstream
+	 * port each iteration. If the parent is cxl root then there is
+	 * nothing to gather.
+	 */
+	while (iter && !is_cxl_root(to_cxl_port(iter->dev.parent))) {
+		combine_coordinates(&c, &dport->sw_coord);
+		c.write_latency += dport->link_latency;
+		c.read_latency += dport->link_latency;
+
+		iter = to_cxl_port(iter->dev.parent);
+		dport = iter->parent_dport;
+	}
+
+	/* Augment with the generic port (host bridge) perf data */
+	combine_coordinates(&c, &dport->hb_coord);
+
+	/* Get the calculated PCI paths bandwidth */
+	pdev = to_pci_dev(port->uport_dev->parent);
+	bw = pcie_bandwidth_available(pdev, NULL, NULL, NULL);
+	if (bw == 0)
+		return -ENXIO;
+	bw /= BITS_PER_BYTE;
+
+	c.write_bandwidth = min(c.write_bandwidth, bw);
+	c.read_bandwidth = min(c.read_bandwidth, bw);
+
+	*coord = c;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_get_perf_coordinates, CXL);
+
 /* for user tooling to ensure port disable work has completed */
 static ssize_t flush_store(const struct bus_type *bus, const char *buf, size_t count)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 77db32a95215..912bde059666 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -886,6 +886,9 @@ int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list);
 void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list);
 int cxl_cdat_switch_process(struct cxl_port *port);
 
+int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
+				      struct access_coordinate *coord);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.


