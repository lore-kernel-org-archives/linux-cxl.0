Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10185EB64D8
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jun 2023 19:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjFNTUA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjFNTTy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 15:19:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8142682
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686770393; x=1718306393;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to;
  bh=ID0J+3Kp49Mg9ETt5IT049MYB4ZipCCxdK/sLh9D2L4=;
  b=CG+KJzi22mS01DFpzfBS4EnhSJo250f7ydkRrIIaRSZGbnZIh7FdtiS2
   uSA7x12AJFiWt3KoHT4sQIvWcHzl0EWPDp4Klw75bA17PFkfktn3Blnvd
   2ac28y6gVKJHq2J/jBXFADypmPTDrVQLYY4dIXtbNdoSo6qFRLRGQt5ta
   mW91hZDWB6mOmBEN05H6Si7KQZbzDUIypfpUMGSakZFZqfpzycEdIMT57
   hlYOXdBtxzHg6wa80hGbxpHz9RtzNhtAo9E59QB1WlmAXxv/g4MnXipk1
   lJNswwzTf34PSx6fAsfzTPYFJqtO5jd0J2Y7PsMFOu3f6PykW0g6sju0b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338347383"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="338347383"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 12:19:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="886384309"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="886384309"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.116.198])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 12:19:51 -0700
From:   ira.weiny@intel.com
Date:   Wed, 14 Jun 2023 12:16:32 -0700
Subject: [PATCH 5/5] cxl/mem: Trace Dynamic capacity Event Record
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230604-dcd-type2-upstream-v1-5-71b6341bae54@intel.com>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
To:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686770367; l=3458;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=o0Z/5qX3MI+qx48VNONUHgNMI4ceicmOt0MHT01Dktc=;
 b=KYQ5/LY/WR+yPSOWA4ld4H+appCY+HtJAG0jy3X+Ef/PWNXcHHsKEvhX7GEGFiGqCNNiI8Zjj
 Tu0TkfdSbJTB/jW6X7SwAX7SsZ48WL/6d9GKmgJ71mg60rwyI4Gn3iB
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Navneet Singh <navneet.singh@intel.com>

CXL rev 3.0 section 8.2.9.2.1.5 defines the Dynamic Capacity Event Record
Determine if the event read is a Dynamic capacity event record and
if so trace the record for the debug purpose.

Add DC trace points to the trace log.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>

---
[iweiny: fixups]
[djbw: no sign-off: preview only]
---
 drivers/cxl/core/mbox.c  |  5 ++++
 drivers/cxl/core/trace.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index db9295216de5..802dacd09772 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -888,6 +888,11 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 				(struct cxl_event_mem_module *)record;
 
 		trace_cxl_memory_module(cxlmd, type, rec);
+	} else if (uuid_equal(id, &dc_event_uuid)) {
+		struct dcd_event_dyn_cap *rec =
+				(struct dcd_event_dyn_cap *)record;
+
+		trace_cxl_dynamic_capacity(cxlmd, type, rec);
 	} else {
 		/* For unknown record types print just the header */
 		trace_cxl_generic_event(cxlmd, type, record);
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index e11651255780..468c2c8b4347 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -704,6 +704,71 @@ TRACE_EVENT(cxl_poison,
 	)
 );
 
+/*
+ * DYNAMIC CAPACITY Event Record - DER
+ *
+ * CXL rev 3.0 section 8.2.9.2.1.5 Table 8-47
+ */
+
+#define CXL_DC_ADD_CAPACITY			0x00
+#define CXL_DC_REL_CAPACITY			0x01
+#define CXL_DC_FORCED_REL_CAPACITY		0x02
+#define CXL_DC_REG_CONF_UPDATED			0x03
+#define show_dc_evt_type(type)	__print_symbolic(type,		\
+	{ CXL_DC_ADD_CAPACITY,	"Add capacity"},		\
+	{ CXL_DC_REL_CAPACITY,	"Release capacity"},		\
+	{ CXL_DC_FORCED_REL_CAPACITY,	"Forced capacity release"},	\
+	{ CXL_DC_REG_CONF_UPDATED,	"Region Configuration Updated"	} \
+)
+
+TRACE_EVENT(cxl_dynamic_capacity,
+
+	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
+		 struct dcd_event_dyn_cap  *rec),
+
+	TP_ARGS(cxlmd, log, rec),
+
+	TP_STRUCT__entry(
+		CXL_EVT_TP_entry
+
+		/* Dynamic capacity Event */
+		__field(u8, event_type)
+		__field(u16, hostid)
+		__field(u8, region_id)
+		__field(u64, dpa_start)
+		__field(u64, length)
+		__array(u8, tag, CXL_EVENT_DC_TAG_SIZE)
+		__field(u16, sh_extent_seq)
+	),
+
+	TP_fast_assign(
+		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+
+		/* Dynamic_capacity Event */
+		__entry->event_type = rec->data.event_type;
+
+		/* DCD event record data */
+		__entry->hostid = le16_to_cpu(rec->data.host_id);
+		__entry->region_id = rec->data.region_index;
+		__entry->dpa_start = le64_to_cpu(rec->data.extent.start_dpa);
+		__entry->length = le64_to_cpu(rec->data.extent.length);
+		memcpy(__entry->tag, &rec->data.extent.tag, CXL_EVENT_DC_TAG_SIZE);
+		__entry->sh_extent_seq = le16_to_cpu(rec->data.extent.shared_extn_seq);
+	),
+
+	CXL_EVT_TP_printk("event_type='%s' host_id='%d' region_id='%d' " \
+		"starting_dpa=%llx length=%llx tag=%s " \
+		"shared_extent_sequence=%d",
+		show_dc_evt_type(__entry->event_type),
+		__entry->hostid,
+		__entry->region_id,
+		__entry->dpa_start,
+		__entry->length,
+		__print_hex(__entry->tag, CXL_EVENT_DC_TAG_SIZE),
+		__entry->sh_extent_seq
+	)
+);
+
 #endif /* _CXL_EVENTS_H */
 
 #define TRACE_INCLUDE_FILE trace

-- 
2.40.0

