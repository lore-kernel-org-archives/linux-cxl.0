Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D977F04
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8qVOCva"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703196240; x=1734732240;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RvQ6LyCi716J/UPcYQW6pakBRjfvohrek26+1bUD1yo=;
  b=m8qVOCvaKyfGhRb+Xp4DPMy1Azr/DN7sjPZkJ2X59X3shH1ews1b3Xpl
   0wSg+HcJnr9BURUANilhGQcZLGfQnBhRKk6oz4PNu0L4GwnTipUgrYB4U
   anluit8n9XGhoXZ6p/3haPOLqQY4KMuQMaFIQ8flXTTbp9GYOyzrn4Hmb
   yb0x6470NNxnHyQ38ybchEi2huhzFXl8+wk3FDch+sNao5tsMRPw7nBE5
   uiow2qFdFVRhYa9UML+VChz6Psi5V98hT3Tcp1PLW1rR/7lV+unOW7v2X
   pAtiPfV8F8WEwRbEOgP7kMqZwjTr8Ny2fwvxiBC3CoyVbwcolAKCV4ReN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="376184549"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="376184549"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:03:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="25116365"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.31.86])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:03:59 -0800
Subject: [PATCH v15 15/19] cxl: Add helper function that calculate performance
 data for downstream ports
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 21 Dec 2023 15:03:58 -0700
Message-ID: <170319623824.2212653.10302079766473698427.stgit@djiang5-mobl3>
In-Reply-To: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
References: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
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
index dd234f3b9ed4..492dbf63935f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -876,6 +876,9 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 void cxl_endpoint_parse_cdat(struct cxl_port *port);
 void cxl_switch_parse_cdat(struct cxl_port *port);
 
+int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
+				      struct access_coordinate *coord);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.


