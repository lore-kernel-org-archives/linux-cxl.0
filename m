Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AA4155728
	for <linux-cxl@vger.kernel.org>; Thu, 25 Apr 2024 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714087543; cv=none; b=XXpMLAB8X6nwPGTu3dzCTfctrvmInTGmQwwLX1VPvVp4qPVbfAlKOaPeRN2//F27YYFIfzO9KF9QC4CAHMbVp/y3gA6Rtc22cotKgRqtWc9vFwS4/5htuf1AZhs57btBcoHe0vrmKjfsmZ/P+GhHH7bJ1YFYYwsNwH5aqrfk8eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714087543; c=relaxed/simple;
	bh=5erW+o1SnQjK8+l++MVASowNlOUlwWnPqm8tTE2e9VY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0s4PJQERCxcEVFzoP+kvuZF9jlLwz+vC5WjNETq/d+zDhpUEim+AleI9VTYw6ZfcNfliw0ikGNtR61FwQNQFjOjl6Zkh+wyB1/lzKGXYfYjjuus6tMGN4IXD/Qai8i+/aQFPKl1JAc50ekd6KH3wueQWhdTb/3YcQrvLZNU1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YU608t6/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YU608t6/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714087543; x=1745623543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5erW+o1SnQjK8+l++MVASowNlOUlwWnPqm8tTE2e9VY=;
  b=YU608t6/OoMz/kzf6czBcWQH2le7NFRRCFvZx17mYzxOTbS810/u7HMM
   vJLA/g8mmHC7XZGsPFaUIV6Wk+IVMXEHFgNUHfeOUv0kMfOS2WzwjX/cD
   rQxPkCrztzrpfgCmKoCENG2OWmM+qQw61FXZVRo2HwiW/REb5iVyXiCgK
   UQ5YYygovE/eFch4BNOKW77YqDlBm/ylvoPhRNdquLB7Dt2ypQ8e3Eru6
   Inneb9bluZOf5Hs1njr0pj1IAIJoFSx8Kn6K9kqHCMjnT0cpSVLu6rlkQ
   UIuY9HAvHK8buMsTiwQZHjhbTOFQ5ixaEOYUbce4vv+rJdbzu4L/iWDcm
   w==;
X-CSE-ConnectionGUID: bjoIsIrwSy+2iXj1OfW00w==
X-CSE-MsgGUID: M+ytxVBeREWfQhb4k1tluw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="21230615"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="21230615"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 16:25:41 -0700
X-CSE-ConnectionGUID: d84wLAXcSrCq94Is/JypnA==
X-CSE-MsgGUID: Vn8QhGrWTTWDQDudFrlIqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25249845"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.128.24])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 16:25:40 -0700
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
Subject: [PATCH v3 3/3] cxl/core: Add region info to cxl_general_media and cxl_dram events
Date: Thu, 25 Apr 2024 16:25:35 -0700
Message-Id: <8d27092f7314db76d9c8730ff45b5c9026a87df5.1714085857.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1714085857.git.alison.schofield@intel.com>
References: <cover.1714085857.git.alison.schofield@intel.com>
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
 drivers/cxl/core/mbox.c  | 30 ++++++++++++++++++++------
 drivers/cxl/core/trace.h | 46 ++++++++++++++++++++++++++++++++--------
 2 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9adda4795eb7..d43ce772d030 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -842,14 +842,32 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
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
+	/* Protect trace events that do DPA->HPA translations */
+	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_dpa_rwsem);
+
+	if (event_type == CXL_CPER_EVENT_GEN_MEDIA &&
+	    trace_cxl_general_media_enabled()) {
+		u64 dpa = le64_to_cpu(evt->gen_media.phys_addr) & CXL_DPA_MASK;
+		struct cxl_region *cxlr = cxl_dpa_to_region(cxlmd, dpa);
+
+		trace_cxl_general_media(cxlmd, type, &evt->gen_media, cxlr);
+	} else if (event_type == CXL_CPER_EVENT_DRAM &&
+		   trace_cxl_dram_enabled()) {
+		u64 dpa = le64_to_cpu(evt->dram.phys_addr) & CXL_DPA_MASK;
+		struct cxl_region *cxlr = cxl_dpa_to_region(cxlmd, dpa);
+
+		trace_cxl_dram(cxlmd, type, &evt->dram, cxlr);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
 
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 161bdb5734b0..106cf00c9a48 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -316,9 +316,9 @@ TRACE_EVENT(cxl_generic_event,
 TRACE_EVENT(cxl_general_media,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_event_gen_media *rec),
+		 struct cxl_event_gen_media *rec, struct cxl_region *cxlr),
 
-	TP_ARGS(cxlmd, log, rec),
+	TP_ARGS(cxlmd, log, rec, cxlr),
 
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
@@ -354,18 +357,29 @@ TRACE_EVENT(cxl_general_media,
 		memcpy(__entry->comp_id, &rec->component_id,
 			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
 		__entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
+		if (cxlr) {
+			__assign_str(region_name, dev_name(&cxlr->dev));
+			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
+			__entry->hpa = cxl_trace_hpa(cxlr, cxlmd, __entry->dpa);
+		} else {
+			__assign_str(region_name, "");
+			uuid_copy(&__entry->region_uuid, &uuid_null);
+			__entry->hpa = ULLONG_MAX;
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
 
@@ -400,9 +414,9 @@ TRACE_EVENT(cxl_general_media,
 TRACE_EVENT(cxl_dram,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_event_dram *rec),
+		 struct cxl_event_dram *rec, struct cxl_region *cxlr),
 
-	TP_ARGS(cxlmd, log, rec),
+	TP_ARGS(cxlmd, log, rec, cxlr),
 
 	TP_STRUCT__entry(
 		CXL_EVT_TP_entry
@@ -417,10 +431,13 @@ TRACE_EVENT(cxl_dram,
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
@@ -444,12 +461,22 @@ TRACE_EVENT(cxl_dram,
 		__entry->column = get_unaligned_le16(rec->column);
 		memcpy(__entry->cor_mask, &rec->correction_mask,
 			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
+		if (cxlr) {
+			__assign_str(region_name, dev_name(&cxlr->dev));
+			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
+			__entry->hpa = cxl_trace_hpa(cxlr, cxlmd, __entry->dpa);
+		} else {
+			__assign_str(region_name, "");
+			uuid_copy(&__entry->region_uuid, &uuid_null);
+			__entry->hpa = ULLONG_MAX;
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
@@ -458,7 +485,8 @@ TRACE_EVENT(cxl_dram,
 		__entry->bank_group, __entry->bank,
 		__entry->row, __entry->column,
 		__print_hex(__entry->cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE),
-		show_dram_valid_flags(__entry->validity_flags)
+		show_dram_valid_flags(__entry->validity_flags),
+		__entry->hpa, __get_str(region_name), &__entry->region_uuid
 	)
 );
 
-- 
2.37.3

