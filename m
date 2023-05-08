Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5FCC7EE22
	for <linux-cxl@archiver.kernel.org>; Mon,  8 May 2023 20:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjEHUsH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 May 2023 16:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjEHUsH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 May 2023 16:48:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E102558B
        for <linux-cxl@vger.kernel.org>; Mon,  8 May 2023 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683578886; x=1715114886;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l+H8Xn5/n4gPpCIp2jHgUiu2YY0BIMBGrDMySvrhMbY=;
  b=cjyUNvg6cwmsPpNlETzCllGLkg5yK7iqkWTnwJPB8iNB8uCqJZ8G6u4a
   sqTiTzLz3rPRxNNVTuZSD0NTEMAsbGD/PqTm9B0Iv8dFNJoYKwo4rvfQz
   AyCU1777Y1VxKutgXxibChu9Cb2YMMcRy2gOjNVuEtwm/6vuLR5dwAHku
   J57QPwlwr8NVKmU8Teq3px+TB+T1l45TJ94HKERTCWkhWbJTdPOfsvWXn
   TBm5LH9z5YqCCbctC+W09VKJQlG66rGqLtf0wdNOjchq/7RCdvja6SMQP
   6J4zUK+ZqbSR63gDkYQj7+WO1yeKsmtL3BO5bv0ECQGWF4UPn8mLgXyDd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="436072452"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="436072452"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:48:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="944996818"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="944996818"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.172.228])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:48:05 -0700
Subject: [PATCH v5 12/14] cxl: Store QTG IDs and related info to the CXL
 memory device context
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 08 May 2023 13:48:05 -0700
Message-ID: <168357888523.2756219.11912716889990252182.stgit@djiang5-mobl3>
In-Reply-To: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Once the QTG ID _DSM is executed successfully, the QTG ID is retrieved from
the return package. Create a list of entries in the cxl_memdev context and
store the QTG ID and the associated DPA range. This information can be
exposed to user space via sysfs in order to help region setup for
hot-plugged CXL memory devices.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v4:
- Remove unused qos_list from cxl_md
v3:
- Move back to QTG ID per partition
---
 drivers/cxl/core/mbox.c |    3 +++
 drivers/cxl/cxlmem.h    |   21 +++++++++++++++++++++
 drivers/cxl/port.c      |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f2addb457172..9c363060e5c1 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1120,6 +1120,9 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 	mutex_init(&cxlds->mbox_mutex);
 	mutex_init(&cxlds->event.log_lock);
 	cxlds->dev = dev;
+	INIT_LIST_HEAD(&cxlds->perf_list);
+	cxlds->ram_qos_class = CXL_QOS_CLASS_INVALID;
+	cxlds->pmem_qos_class = CXL_QOS_CLASS_INVALID;
 
 	return cxlds;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 001dabf0231b..9d77b7e420ce 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -5,6 +5,7 @@
 #include <uapi/linux/cxl_mem.h>
 #include <linux/cdev.h>
 #include <linux/uuid.h>
+#include <linux/node.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -215,6 +216,19 @@ struct cxl_event_state {
 	struct mutex log_lock;
 };
 
+/**
+ * struct perf_prop - performance property entry
+ * @list - list entry
+ * @dpa_range - range for DPA address
+ * @qos_class - QoS Class cookie
+ */
+struct perf_prop_entry {
+	struct list_head list;
+	struct range dpa_range;
+	u16 qos_class;
+	struct access_coordinate coord;
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -251,6 +265,9 @@ struct cxl_event_state {
  * @serial: PCIe Device Serial Number
  * @event: event log driver state
  * @mbox_send: @dev specific transport for transmitting mailbox commands
+ * @ram_qos_class: QTG ID for volatile region
+ * @pmem_qos_class: QTG ID for persistent region
+ * @perf_list: performance data entries list
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -283,6 +300,10 @@ struct cxl_dev_state {
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
 
+	int ram_qos_class;
+	int pmem_qos_class;
+	struct list_head perf_list;
+
 	resource_size_t component_reg_phys;
 	u64 serial;
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 1d55c460e1ab..c8c37dd79ecc 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -113,6 +113,40 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 	return 0;
 }
 
+static void cxl_memdev_set_qtg(struct cxl_dev_state *cxlds, struct list_head *dsmas_list)
+{
+	struct range pmem_range = {
+		.start = cxlds->pmem_res.start,
+		.end = cxlds->pmem_res.end,
+	};
+	struct range ram_range = {
+		.start = cxlds->ram_res.start,
+		.end = cxlds->ram_res.end,
+	};
+	struct perf_prop_entry *perf;
+	struct dsmas_entry *dent;
+
+	list_for_each_entry(dent, dsmas_list, list) {
+		perf = devm_kzalloc(cxlds->dev, sizeof(*perf), GFP_KERNEL);
+		if (!perf)
+			return;
+
+		perf->dpa_range = dent->dpa_range;
+		perf->qos_class = dent->qos_class;
+		perf->coord = dent->coord;
+		list_add_tail(&perf->list, &cxlds->perf_list);
+
+		if (resource_size(&cxlds->ram_res) &&
+		    range_contains(&ram_range, &dent->dpa_range) &&
+		    cxlds->ram_qos_class == CXL_QOS_CLASS_INVALID)
+			cxlds->ram_qos_class = dent->qos_class;
+		else if (resource_size(&cxlds->pmem_res) &&
+			 range_contains(&pmem_range, &dent->dpa_range) &&
+			 cxlds->pmem_qos_class == CXL_QOS_CLASS_INVALID)
+			cxlds->pmem_qos_class = dent->qos_class;
+	}
+}
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
@@ -216,6 +250,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 			if (rc)
 				dev_dbg(&port->dev,
 					"Failed to do perf coord calculations.\n");
+			else
+				cxl_memdev_set_qtg(cxlds, &dsmas_list);
 		}
 
 		dsmas_list_destroy(&dsmas_list);


