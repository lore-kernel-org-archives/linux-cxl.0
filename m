Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C387CC77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 17:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjESRJa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 13:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjESRJD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 13:09:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8620A18F
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684516120; x=1716052120;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lnwjzWJBwpZEUaH7obwI9lyJo1Yvgd3Hs8oNYc9ZqcM=;
  b=EZDO+Vm+Mmx+XhuUp/i8bFB5sQxQH70QDohd9ZdEt6WrabaYOgUh9s4j
   /UwvQ1UjoBpBeDt/p7JrWtak1vRlV8Abipb1u7oQbXLZeF24MmR0djTc1
   l7vhcYwL/S7c4MYYyqaoXVWArFV1JUYffDk8VYFr5wyEXhbHUGe1pj3Rq
   uV8yeD47s7kz7vYochFQPX+AMZxmjywci1oEqN2K72G1RT+3RY33VxyzO
   t+JoF2O//ECXQfpA/42uq6WWFoKeSodBicFmxeNx35tuoquzBg4oeYXvh
   /EFG1soa63uwzYWmTzCefUtNmxBDz/Ozu6o2KA+fdUpHg0x3vZ9TbWQ4B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="337018596"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="337018596"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:07:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="846951202"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="846951202"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.29.189])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:07:23 -0700
Subject: [PATCH v6 08/11] cxl: Compute the entire CXL path latency and
 bandwidth data
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 19 May 2023 10:07:22 -0700
Message-ID: <168451604218.3470703.3152270825986749312.stgit@djiang5-mobl3>
In-Reply-To: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
References: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
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
index 73ac96e754a0..3ddb2629515f 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -147,6 +147,7 @@ void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list)
 
 	list_for_each_entry_safe(dentry, n, dsmas_list, list) {
 		list_del(&dentry->list);
+		kfree(dentry->qos_class);
 		kfree(dentry);
 	}
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f5c152eb55c0..495b6271d9a5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -843,6 +843,7 @@ struct dsmas_entry {
 	struct range dpa_range;
 	u8 handle;
 	struct access_coordinate coord;
+	struct qos_class *qos_class;
 };
 
 #ifdef CONFIG_ACPI_TABLES_LIB
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 0f9c25645e1d..03af92217192 100644
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
@@ -143,10 +190,14 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
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


