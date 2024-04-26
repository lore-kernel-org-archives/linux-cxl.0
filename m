Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8D778C73
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 03:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714103192; cv=none; b=Z0LhwjKxzcyeefQ1a6kCq8FCscveO9papDTMmL1tfDjLP5MATQnuI2fI33xHDrsCfoxkUMeOdD5/S0J2J5vfmZldQTf6sYylMMtUE98HyhD2RL3+8K8KxXFigtTF7UnYd4SfKjvSZGAJwc60ow6hUh9bmvzvLUwbcppZ14Iqm8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714103192; c=relaxed/simple;
	bh=i0g7U7XfQovjH1T2QzgeqNTocs+ZhtGH4opjKZs/ppQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OH7FAfLHXB5TE2Aq8OG5uTKpKk5vuD49Aj7aviRjyAn1uvdHOMnnqMYaLhejDJoYL15oLV80kddVJP1ZEPc+wbFvCGKVFk7M/UFi5hE1w3DbOMpxbLan94os3lxaits+zHJ6+IIaJwu6+Y1iKBDpzFq1KdS+1IFfauNwdVqcPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8MZtmOS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8MZtmOS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714103191; x=1745639191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i0g7U7XfQovjH1T2QzgeqNTocs+ZhtGH4opjKZs/ppQ=;
  b=j8MZtmOSGOhkPpsq6pV7TGoG4bFCL9IGf2kWVBBDaKOe49PsLjWs+ukX
   AiWQdojSzqjNm8W4AJPE9HFt94gVLmPYF3JvG7lpLPjtyhcggNTsgOWmB
   RzjmeuxZejLC1doxsXwGXf0OJ5FCyY68i6w50fRu9wl+vwdsPIsBP+1Mh
   DKVJM3sKdcTGULPW9yHT4mjF0wsIF+adVffLff9/lCTiMZZCbPDmF1BFn
   8GL5KTGH3Cb6tn5i4dVul0DTMM9+LDsQytmsROXoGQd4CMjvz22VyZJpB
   QHldUguGhTWVDIfMiFLp5+x/iqtdinriNg0M/J2hDYR0X/jwzLrD33Zq3
   A==;
X-CSE-ConnectionGUID: CBHXqfgMSJW9SORHa4o0VA==
X-CSE-MsgGUID: 0BHX9s1fQS+cNGguUUxcLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20381469"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="20381469"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 20:46:30 -0700
X-CSE-ConnectionGUID: tRGfr+UJR6urkcYZZFyzYA==
X-CSE-MsgGUID: ZRFuvAsnTmCx8vHhN38sog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="29738235"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.128.24])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 20:46:29 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v4 3/3] cxl/core: Add region info to cxl_general_media and cxl_dram events
Date: Thu, 25 Apr 2024 20:46:25 -0700
Message-Id: <a45eef6938944be3a21e862d238ba65921f07a42.1714102202.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1714102202.git.alison.schofield@intel.com>
References: <cover.1714102202.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

User space may need to know which region, if any, maps the DPAs
(device physical addresses) reported in a cxl_general_media or
cxl_dram event. Since the mapping can change, the kernel provides
this information at the time the event occurs. This informs user
space that at event <timestamp> this <region> mapped this <DPA>
to this <HPA>.

Add the same region info that is included in the cxl_poison trace
event: the DPA->HPA translation, region name, and region uuid.

The new fields are inserted in the trace event and no existing
fields are modified. If the DPA is not mapped, user will see:
hpa=ULLONG_MAX, region="", and uuid=0

This work must be protected by dpa_rwsem & region_rwsem since
it is looking up region mappings.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c   | 36 ++++++++++++++++++++++++++------
 drivers/cxl/core/trace.h  | 44 +++++++++++++++++++++++++++++++--------
 include/linux/cxl-event.h | 10 +++++++++
 3 files changed, 75 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9adda4795eb7..df0fc2a4570f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -842,14 +842,38 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt)
 {
-	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
-		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
-	else if (event_type == CXL_CPER_EVENT_DRAM)
-		trace_cxl_dram(cxlmd, type, &evt->dram);
-	else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
+	if (event_type == CXL_CPER_EVENT_MEM_MODULE) {
 		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
-	else
+		return;
+	}
+	if (event_type == CXL_CPER_EVENT_GENERIC) {
 		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
+		return;
+	}
+
+	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
+		u64 dpa, hpa = ULLONG_MAX;
+		struct cxl_region *cxlr;
+
+		/*
+		 * These trace points are annotated with HPA and region
+		 * translations. Take topology mutation locks and lookup
+		 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
+		 */
+		guard(rwsem_read)(&cxl_region_rwsem);
+		guard(rwsem_read)(&cxl_dpa_rwsem);
+
+		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
+		cxlr = cxl_dpa_to_region(cxlmd, dpa);
+		if (cxlr)
+			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
+
+		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
+			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
+						&evt->gen_media);
+		else if (event_type == CXL_CPER_EVENT_DRAM)
+			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
 
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 161bdb5734b0..790686a8a443 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -316,9 +316,9 @@ TRACE_EVENT(cxl_generic_event,
 TRACE_EVENT(cxl_general_media,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_event_gen_media *rec),
+		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_gen_media *rec),
 
-	TP_ARGS(cxlmd, log, rec),
+	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -330,10 +330,13 @@ TRACE_EVENT(cxl_general_media,
 		__field(u8, channel)
 		__field(u32, device)
 		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
-		__field(u16, validity_flags)
 		/* Following are out of order to pack trace record */
+		__field(u64, hpa)
+		__field_struct(uuid_t, region_uuid)
+		__field(u16, validity_flags)
 		__field(u8, rank)
 		__field(u8, dpa_flags)
+		__string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
 	),
 
 	TP_fast_assign(
@@ -354,18 +357,28 @@ TRACE_EVENT(cxl_general_media,
 		memcpy(__entry->comp_id, &rec->component_id,
 			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
 		__entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
+		__entry->hpa = hpa;
+		if (cxlr) {
+			__assign_str(region_name, dev_name(&cxlr->dev));
+			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
+		} else {
+			__assign_str(region_name, "");
+			uuid_copy(&__entry->region_uuid, &uuid_null);
+		}
 	),
 
 	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
 		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
-		"device=%x comp_id=%s validity_flags='%s'",
+		"device=%x comp_id=%s validity_flags='%s' " \
+		"hpa=%llx region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
 		show_mem_event_type(__entry->type),
 		show_trans_type(__entry->transaction_type),
 		__entry->channel, __entry->rank, __entry->device,
 		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
-		show_valid_flags(__entry->validity_flags)
+		show_valid_flags(__entry->validity_flags),
+		__entry->hpa, __get_str(region_name), &__entry->region_uuid
 	)
 );
 
@@ -400,9 +413,9 @@ TRACE_EVENT(cxl_general_media,
 TRACE_EVENT(cxl_dram,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_event_dram *rec),
+		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_dram *rec),
 
-	TP_ARGS(cxlmd, log, rec),
+	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -417,10 +430,13 @@ TRACE_EVENT(cxl_dram,
 		__field(u32, nibble_mask)
 		__field(u32, row)
 		__array(u8, cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE)
+		__field(u64, hpa)
+		__field_struct(uuid_t, region_uuid)
 		__field(u8, rank)	/* Out of order to pack trace record */
 		__field(u8, bank_group)	/* Out of order to pack trace record */
 		__field(u8, bank)	/* Out of order to pack trace record */
 		__field(u8, dpa_flags)	/* Out of order to pack trace record */
+		__string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
 	),
 
 	TP_fast_assign(
@@ -444,12 +460,21 @@ TRACE_EVENT(cxl_dram,
 		__entry->column = get_unaligned_le16(rec->column);
 		memcpy(__entry->cor_mask, &rec->correction_mask,
 			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
+		__entry->hpa = hpa;
+		if (cxlr) {
+			__assign_str(region_name, dev_name(&cxlr->dev));
+			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
+		} else {
+			__assign_str(region_name, "");
+			uuid_copy(&__entry->region_uuid, &uuid_null);
+		}
 	),
 
 	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' descriptor='%s' type='%s' " \
 		"transaction_type='%s' channel=%u rank=%u nibble_mask=%x " \
 		"bank_group=%u bank=%u row=%u column=%u cor_mask=%s " \
-		"validity_flags='%s'",
+		"validity_flags='%s' " \
+		"hpa=%llx region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
 		show_mem_event_type(__entry->type),
@@ -458,7 +483,8 @@ TRACE_EVENT(cxl_dram,
 		__entry->bank_group, __entry->bank,
 		__entry->row, __entry->column,
 		__print_hex(__entry->cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE),
-		show_dram_valid_flags(__entry->validity_flags)
+		show_dram_valid_flags(__entry->validity_flags),
+		__entry->hpa, __get_str(region_name), &__entry->region_uuid
 	)
 );
 
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 03fa6d50d46f..5342755777cc 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -91,11 +91,21 @@ struct cxl_event_mem_module {
 	u8 reserved[0x3d];
 } __packed;
 
+/*
+ * General Media or DRAM Event Common Fields
+ * - provides common access to phys_addr
+ */
+struct cxl_event_common {
+	struct cxl_event_record_hdr hdr;
+	__le64 phys_addr;
+} __packed;
+
 union cxl_event {
 	struct cxl_event_generic generic;
 	struct cxl_event_gen_media gen_media;
 	struct cxl_event_dram dram;
 	struct cxl_event_mem_module mem_module;
+	struct cxl_event_common common;
 } __packed;
 
 /*
-- 
2.37.3

