Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEgniwqt"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6D310EF
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 14:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701989999; x=1733525999;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gbn963V0stoaIsWkf0jKIjG8QUw0TRTJ4hCw/mZaFD8=;
  b=eEgniwqtSrbLQO/gcD/GXxtDPWJcII2y1UR0ZgInu/h7ywMh/dxJFA3u
   uHPRYGYYv89eYCdpU59OldTMvxQQTpSNPPBZmVZAu8mY+Q1Lu+Kwr1UFS
   L5RIA6St1ZfJNaWcmquZZ57uvRj+38ifwb5v6AxRe4jXlnHk8uvsLbLGA
   VAx7DStvRJhNWmeNAWL4xY/SpmIZEpYyOm0XkomjbJ7hEk8oTaEMJ6ujT
   37Iade7tDvesjFHCubtbTf62Qc05gQSCGZJq8Dp6aRdC9x9O+U5PL7sVa
   /ZnhccdDPjHDKMa/N+ibVngOG1ZIZwun7fsgMnao7uKD9zT81NzMCH8Uj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="397107801"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="397107801"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:59:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="895312888"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="895312888"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:59:55 -0800
Subject: [PATCH v13 15/19] cxl: Add helper function that calculate performance
 data for downstream ports
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 15:59:54 -0700
Message-ID: <170198999460.3522351.3292955606506384639.stgit@djiang5-mobl3>
In-Reply-To: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
References: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
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
index e4995cfa6822..dbf2a1e601bf 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -884,6 +884,9 @@ int cxl_cdat_endpoint_process(struct cxl_port *port, struct xarray *dsmas_xa);
 void cxl_cdat_dsmas_xa_destroy(struct xarray *dsmas_xa);
 int cxl_cdat_switch_process(struct cxl_port *port);
 
+int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
+				      struct access_coordinate *coord);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.


