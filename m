Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A539C7EE2D
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 17:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjESRJa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 13:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjESRJG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 13:09:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FAF10DD
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 10:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684516125; x=1716052125;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mc/8fniOlq92Ar//AdNTCWxqpnwvSxBw30oA/VqtSGo=;
  b=Eg3EEi8Q/sxjuZJNQEtaNaUBLSQwG8noylKrytUFRm1OHWLWMQrOVNe1
   3mvXFS0kEAlKNQPDa5jy35ndM4LazEy2TrjfzZNv3YTaeTih4Po370e8i
   GEFT/SwZWqKqgV+dw82K2gp+9jMHdUHLfES28Bqacwu46vNGL7WkPkeKZ
   CqBPHs3ENRpP4yoZl4UrfYq0YWqQMiZxezZo0YDw5GzLWlbrfKo2rXinN
   GQQEpPMjja80V7h5UOFo5mX5kK5HaElFM0EAjYyz0swbKGgJBaHhqqUyQ
   dfj0fwMiApPcM8mQG3AmUKUMBwIXds+W6jY7USljt8OTZPE9UcaxL/wfs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="337018603"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="337018603"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="846951221"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="846951221"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.29.189])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:07:29 -0700
Subject: [PATCH v6 09/11] cxl: Store QTG IDs and related info to the CXL
 memory device context
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 19 May 2023 10:07:28 -0700
Message-ID: <168451604884.3470703.10173844932484539394.stgit@djiang5-mobl3>
In-Reply-To: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
References: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
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
v6:
- Store entire QTG ID list
v4:
- Remove unused qos_list from cxl_md
v3:
- Move back to QTG ID per partition
---
 drivers/cxl/core/mbox.c |    1 +
 drivers/cxl/cxlmem.h    |   23 +++++++++++++++++++++++
 drivers/cxl/port.c      |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2c8dc7e2b84d..35941a306ea8 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1260,6 +1260,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 	mutex_init(&cxlds->mbox_mutex);
 	mutex_init(&cxlds->event.log_lock);
 	cxlds->dev = dev;
+	INIT_LIST_HEAD(&cxlds->perf_list);
 
 	return cxlds;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a2845a7a69d8..708d60c5ffe1 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -5,6 +5,7 @@
 #include <uapi/linux/cxl_mem.h>
 #include <linux/cdev.h>
 #include <linux/uuid.h>
+#include <linux/node.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -254,6 +255,21 @@ struct cxl_poison_state {
 	struct mutex lock;  /* Protect reads of poison list */
 };
 
+/**
+ * struct perf_prop - performance property entry
+ * @list - list entry
+ * @dpa_range - range for DPA address
+ * @coord - QoS performance data (i.e. latency, bandwidth)
+ * @qos_class - QoS Class cookies
+ */
+struct perf_prop_entry {
+	struct list_head list;
+	struct range dpa_range;
+	struct access_coordinate coord;
+	/* Do not add members below this, contains flex array */
+	struct qos_class qos_class;
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -292,6 +308,9 @@ struct cxl_poison_state {
  * @event: event log driver state
  * @poison: poison driver state info
  * @mbox_send: @dev specific transport for transmitting mailbox commands
+ * @ram_qos_class: QoS class cookies for volatile region
+ * @pmem_qos_class: QoS class cookies for persistent region
+ * @perf_list: performance data entries list
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -325,6 +344,10 @@ struct cxl_dev_state {
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
 
+	struct qos_class *ram_qos_class;
+	struct qos_class *pmem_qos_class;
+	struct list_head perf_list;
+
 	resource_size_t component_reg_phys;
 	u64 serial;
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 03af92217192..e5d7ad5b1e16 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -104,6 +104,42 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
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
+		perf = devm_kzalloc(cxlds->dev,
+				    sizeof(*perf) + dent->qos_class->nr * sizeof(int),
+				    GFP_KERNEL);
+		if (!perf)
+			return;
+
+		perf->dpa_range = dent->dpa_range;
+		perf->coord = dent->coord;
+		perf->qos_class = *dent->qos_class;
+		list_add_tail(&perf->list, &cxlds->perf_list);
+
+		if (resource_size(&cxlds->ram_res) &&
+		    range_contains(&ram_range, &dent->dpa_range) &&
+		    !cxlds->ram_qos_class)
+			cxlds->ram_qos_class = &perf->qos_class;
+		else if (resource_size(&cxlds->pmem_res) &&
+			 range_contains(&pmem_range, &dent->dpa_range) &&
+			 !cxlds->pmem_qos_class)
+			cxlds->pmem_qos_class = &perf->qos_class;
+	}
+}
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
@@ -197,6 +233,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 			if (rc)
 				dev_dbg(&port->dev,
 					"Failed to do perf coord calculations.\n");
+			else
+				cxl_memdev_set_qtg(cxlds, &dsmas_list);
 		}
 
 		cxl_cdat_dsmas_list_destroy(&dsmas_list);


