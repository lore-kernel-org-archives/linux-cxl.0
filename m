Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF5BEB64D7
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 21:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjFPVml (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 17:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFPVmk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 17:42:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F5430F9
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 14:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686951759; x=1718487759;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HjOlmuc0XHZEKBw9dXQq9UZRCLYtxq+PMpCQJUwLt/w=;
  b=OZa/2v6fRJq3QwtG1BusAwBDKxv27y200Q4/b1H8qG8MxAc6qvoTJB9e
   9cea1LWEcVYjnlbd3kpoAJ1ZncqCJ7l779bJrpYK+xKKyW9x309khD6hG
   C5dB52y3FPEPgSSeIs7siovqq8A0RzNcvdvgBoq0gpSiPfkyONDs9GCIy
   f5LbNAFVW47HTkOrOljiqP9bPfH3krLWFqJN5CAG5kRdU3cnMiamTFHmK
   MxdyB/rtFkoxPJd4LFI1B3GWJQKg4Jldnu/8IDPH0VaeXjF3zPIObbs4p
   nGWPTKtvunWcAHYjQy7op56On23Mfi1QaFmAEDhrle025mQcV9e++t+q0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="422973264"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="422973264"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:42:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="663326975"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="663326975"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.91])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:42:32 -0700
Subject: [PATCH v7 09/11] cxl: Store QTG IDs and related info to the CXL
 memory device context
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 16 Jun 2023 14:42:32 -0700
Message-ID: <168695175231.3031571.13756779117408507641.stgit@djiang5-mobl3>
In-Reply-To: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
References: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
index bea9cf31a12d..da998c05766e 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1265,6 +1265,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
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
index 4f2828caba7b..57876ed4dbd4 100644
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
@@ -201,6 +237,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 			if (rc)
 				dev_dbg(&port->dev,
 					"Failed to do perf coord calculations.\n");
+			else
+				cxl_memdev_set_qtg(cxlds, &dsmas_list);
 		}
 
 		cxl_cdat_dsmas_list_destroy(&dsmas_list);


