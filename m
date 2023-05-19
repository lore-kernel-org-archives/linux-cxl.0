Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4590C77B75
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 17:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjESRKA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 13:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjESRJ2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 13:09:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C305B1BC
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684516160; x=1716052160;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aE5miGtJG8jKLnDMya5ffMgbV588qPbaGaXeSjWleXs=;
  b=Er2v82lsXqhm7x9VuPrgi0KyymRnLAEOr+Vsn4MPqoJT7Sy0fHkLhvx2
   FmpgWG8cKhZ56bIHF1QE5qyExey6S+w1ScLkbq6VophaFWW5SBiamFzGt
   qbKBGYSfOu7FGAc59XKfqaZzAd6ym3fAmI1tOdjtcZ5VVB2eocpjPeS7n
   CujhZHFF+f/KMan4fI2s7PK9tG4YasRqAjnqK9dYdNxt7RFc99rz81CMS
   jwc0ga+Pu4Moi8R5RayqqbW/i8kjQxhzQ2AIUU+iISLwBhgzc46xiiMuG
   cRgh1EsbYHVfumhUY/2wGdd3Ut25sglhLE5RGkzA3151hp1ZyULmYtgK9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="438778354"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="438778354"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="876911075"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="876911075"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.29.189])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:07:16 -0700
Subject: [PATCH v6 07/11] cxl: Add helper function that calculate performance
 data for downstream ports
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 19 May 2023 10:07:16 -0700
Message-ID: <168451603625.3470703.5688640606970207460.stgit@djiang5-mobl3>
In-Reply-To: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
References: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The CDAT information from the switch, Switch Scoped Latency and Bandwidth
Information Strucutre (SSLBIS), is parsed and stored under a cxl_dport
based on the correlated downstream port id from the SSLBIS entry. Walk
the entire CXL port paths and collect all the performance data. Also
pick up the link latency number that's stored under the dports. The
entire path PCIe bandwidth can be retrieved using the
pcie_bandwidth_available() call.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v6:
- Change min_t() to min(). (Jonathan)
---
 drivers/cxl/core/port.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    3 ++
 2 files changed, 69 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index cd7c22e7e387..c051c48f835f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
+#include <linux/node.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
@@ -1949,6 +1950,71 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
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
+	while (iter && !is_cxl_root(iter)) {
+		combine_coordinates(&c, &dport->coord);
+		c.write_latency += dport->link_latency;
+		c.read_latency += dport->link_latency;
+
+		combine_coordinates(&c, &dport->hb_access);
+
+		iter = to_cxl_port(iter->dev.parent);
+		dport = iter->parent_dport;
+	}
+
+	/* Get the calculated PCI paths bandwidth */
+	pdev = to_pci_dev(port->uport->parent);
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
index 2369e91add63..f5c152eb55c0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -866,6 +866,9 @@ static inline int cxl_cdat_switch_process(struct cxl_port *port)
 }
 #endif
 
+int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
+				      struct access_coordinate *coord);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.


