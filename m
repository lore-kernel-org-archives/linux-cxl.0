Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D50EB64D8
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 21:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjFPVmh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 17:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFPVmf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 17:42:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C091330F7
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686951753; x=1718487753;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hzd5xhioFJTRbCqmK6Y0sJk54FYAZAG0fIkUxvYrPdg=;
  b=WrD5RqGnI9BqLF1wBw1r03sVK2JJsRCgD7LwwUxWY/veg6QQyZyAbCAo
   sBs4aBAHPDECAnlxUbiA7extTdaofaS5pRpO2135w77oLXArz3wRqFFVm
   utyQ63jOFCR00m/l86yXIcwU5eFcjRnUwWdaQRMohdRBYFRMTLTEmaB0b
   ZLeYC4d42RLS4rlWJ610qNsx7w7wuP2yBCtvGfBXFGgxBUg5GMiyKQgZi
   clGfwb0AqMbHOMbq0CU6E4ji4BJVeZlb4wM2gfa6+Het2mC8b2J7jLt7i
   sYRgOpQCZQXngw2l+BAdaAs4p7Usnk2T0pfoWMGutNFZyQ12fGFzGqcXL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="422973228"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="422973228"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="663326953"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="663326953"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.91])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:42:26 -0700
Subject: [PATCH v7 08/11] cxl: Compute the entire CXL path latency and
 bandwidth data
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 16 Jun 2023 14:42:25 -0700
Message-ID: <168695174591.3031571.6462488730394994238.stgit@djiang5-mobl3>
In-Reply-To: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
References: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL Memory Device SW Guide [1] rev1.0 2.11.2 provides instruction on how to
calculate latency and bandwidth for CXL memory device. Calculate minimum
bandwidth and total latency for the path from the CXL device to the root
port. The QTG id is retrieved by providing the performance data as input
and calling the root port callback ->get_qos_class(). The retrieved id is
stored with the cxl_port of the CXL device.

For example for a device that is directly attached to a host bus:
Total Latency = Device Latency (from CDAT) + Dev to Host Bus (HB) Link
		Latency + Generic Port Latency
Min Bandwidth = Min bandwidth for link bandwidth between HB
		and CXL device, device CDAT bandwidth, and Generic Port
		Bandwidth

For a device that has a switch in between host bus and CXL device:
Total Latency = Device (CDAT) Latency + Dev to Switch Link Latency +
		Switch (CDAT) Latency + Switch to HB Link Latency +
		Generic Port Latency
Min Bandwidth = Min bandwidth for link bandwidth between CXL device
		to CXL switch, CXL device CDAT bandwidth, CXL switch CDAT
		bandwidth, CXL switch to HB bandwidth, and Generic Port
		Bandwidth.

[1]: https://cdrdv2-public.intel.com/643805/643805_CXL%20Memory%20Device%20SW%20Guide_Rev1p0.pdf

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v5:
- Use new API call cxl_endpoint_get_perf_coordinates().
- Use root_port->get_qos_class() (Dan)
- Add endieness handling to DSM input.
---
 drivers/cxl/core/cdat.c |    1 +
 drivers/cxl/cxl.h       |    1 +
 drivers/cxl/port.c      |   57 +++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index f233cebca37a..1a6b4aeacb0c 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -148,6 +148,7 @@ void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list)
 
 	list_for_each_entry_safe(dentry, n, dsmas_list, list) {
 		list_del(&dentry->list);
+		kfree(dentry->qos_class);
 		kfree(dentry);
 	}
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 580f44587ab0..5255edc3fe32 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -844,6 +844,7 @@ struct dsmas_entry {
 	struct range dpa_range;
 	u8 handle;
 	struct access_coordinate coord;
+	struct qos_class *qos_class;
 };
 
 #ifdef CONFIG_FIRMWARE_TABLE
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 8b36a8633a15..4f2828caba7b 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -57,6 +57,53 @@ static int discover_region(struct device *dev, void *root)
 	return 0;
 }
 
+static int cxl_port_perf_data_calculate(struct cxl_port *port,
+					struct list_head *dsmas_list)
+{
+	struct qos_class *qos_class;
+	struct access_coordinate c;
+	struct qtg_dsm_input input;
+	struct cxl_port *root_port;
+	struct cxl_root *cxl_root;
+	struct dsmas_entry *dent;
+	int rc;
+
+	rc = cxl_endpoint_get_perf_coordinates(port, &c);
+	if (rc) {
+		dev_dbg(&port->dev, "Failed to retrieve perf coordinates.\n");
+		return rc;
+	}
+
+	root_port = find_cxl_root(port);
+	cxl_root = to_cxl_root(root_port);
+	if (!cxl_root->ops || !cxl_root->ops->get_qos_class)
+		return -EOPNOTSUPP;
+
+	list_for_each_entry(dent, dsmas_list, list) {
+		dent->coord.read_latency = dent->coord.read_latency +
+					   c.read_latency;
+		dent->coord.write_latency = dent->coord.write_latency +
+					    c.write_latency;
+		dent->coord.read_bandwidth = min_t(int, c.read_bandwidth,
+						   dent->coord.read_bandwidth);
+		dent->coord.write_bandwidth = min_t(int, c.write_bandwidth,
+						    dent->coord.write_bandwidth);
+
+		input.rd_lat = cpu_to_le32(dent->coord.read_latency);
+		input.wr_lat = cpu_to_le32(dent->coord.write_latency);
+		input.rd_bw = cpu_to_le32(dent->coord.read_bandwidth);
+		input.wr_bw = cpu_to_le32(dent->coord.write_bandwidth);
+
+		qos_class = cxl_root->ops->get_qos_class(root_port, &input);
+		if (IS_ERR(qos_class))
+			continue;
+
+		dent->qos_class = qos_class;
+	}
+
+	return 0;
+}
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
@@ -147,10 +194,14 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		LIST_HEAD(dsmas_list);
 
 		rc = cxl_cdat_endpoint_process(port, &dsmas_list);
-		if (rc < 0)
+		if (rc < 0) {
 			dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
-
-		/* Performance data processing */
+		} else {
+			rc = cxl_port_perf_data_calculate(port, &dsmas_list);
+			if (rc)
+				dev_dbg(&port->dev,
+					"Failed to do perf coord calculations.\n");
+		}
 
 		cxl_cdat_dsmas_list_destroy(&dsmas_list);
 	}


