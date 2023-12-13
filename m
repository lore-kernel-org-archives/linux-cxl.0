Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJupIlde"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07BA8E
	for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 08:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702485772; x=1734021772;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RvQ6LyCi716J/UPcYQW6pakBRjfvohrek26+1bUD1yo=;
  b=iJupIlderdcpHpCGzIW4zQknHdcQ13Wf0GlJI8DCIGCqFsBMwRz/rjKl
   5ktGuyrVJeD07ga9p2+8kmzfcKdTmQ3TfDJoEq5WC22fAAhPwGOM11Upw
   /z/o+FhaSWu7e/2cMpDIHdyWAZPxWTtL5W2e9wXSccAh4LjBcA1jdSkUo
   rmkCphjZe2MtLyTZTa0HF8+IOSp4K9xk05UIPCZmR3F+GKKCkpoBF6nyQ
   xku8cC7Nz8YQI7zwOom0G3mRS8fiEY3G2lc12JEnEEQCCwdH2y7SMcfVV
   obMOJ8mf2i0BbzZBoP4PFgmCAqjBPtxRViRJROQpbaLO47ZoyacllIrFj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="394745600"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="394745600"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:42:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="808218656"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="808218656"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.76.225])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:42:51 -0800
Subject: [PATCH v14 15/19] cxl: Add helper function that calculate performance
 data for downstream ports
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Wed, 13 Dec 2023 09:42:51 -0700
Message-ID: <170248577109.801570.2947835968617698751.stgit@djiang5-mobl3>
In-Reply-To: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
References: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
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


