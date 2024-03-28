Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F613ACC
	for <linux-cxl@vger.kernel.org>; Thu, 28 Mar 2024 04:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711600602; cv=none; b=mOTfA9X+JXChTza1kd9rtB5FGUu+Ogg+gMq0b2bnWB6ByVQzxkKnzAulA8ZOl6RDHHSMLCiaYpZskh5WTt0iQfCXHsWP6XTJmzZf2QC9qHY0WNyrm5fFRXtK6W8ShVvKtiMdA5Ejqqf2t2qXPSal+43jo4ybtw8gYYKFRR7WD9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711600602; c=relaxed/simple;
	bh=Rl79zw2+PSSHQmG+m6o00VDrK6T5syk9Agzu3bgF69U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PY92jlYF8+WevEndqDlzid+UiMlDiZBeDnOdVKW8S5JEr1XfEfSp4i4TJBeweuYwftD9G1PZKEC53KcVr4s1Qjrca6O1QhteNWO1zF3accvnSDawS7xDs1PolCaGEqW47srIZW088FveISxP8dsoBoMegaCrPe3WjhPaB6fLF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkVz02tl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkVz02tl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711600600; x=1743136600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rl79zw2+PSSHQmG+m6o00VDrK6T5syk9Agzu3bgF69U=;
  b=HkVz02tlE2GTmlVRS7CHlpxau3g5pnFCsya1DAacOM5/PYoj2WPkA2UP
   QVH1gjxBOoBPKSY0wYlUB56Us3y1ERScFMjPtVw8ZXvqSxPxdhaz7CJcG
   6qYp19bqVAP/tvcJnyJQwSvGCIygerXlmaeWVe5MLvJmw8IEiqFinfaFV
   GzoAuq6nIua/Q1dej2Z87UgyzzEOBUHLNkMBQX2rpjzb5rlZaLLi3M0CW
   27AZaX1BcD/gtk9zgOjCP3NveKaa+UM//RY4d3bpAq1MW0kThP6qFS2JL
   gCAz1PRKLtL81BK9NbKj/1CImBKTtCy5VD9AoEQwBF+8CBQTTZWhLtt7B
   w==;
X-CSE-ConnectionGUID: 6UDq3CVSRvCrcSdBIDh5kQ==
X-CSE-MsgGUID: 0K12HuQ3QrCLtokm9fiWyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10542219"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="10542219"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 21:36:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21184500"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.82.250])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 21:36:38 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 3/4] cxl/core: Add region info to cxl_general_media and cxl_dram events
Date: Wed, 27 Mar 2024 21:36:32 -0700
Message-Id: <061d1eac5d4e270337911199f0b0633c0ff230b4.1711598777.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711598777.git.alison.schofield@intel.com>
References: <cover.1711598777.git.alison.schofield@intel.com>
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
Introduce and use new helpers that lookup that region info using
the struct cxl_memdev and a DPA.

The new fields are inserted in the trace event and no existing
fields are modified. If the DPA is not mapped, user will see:
hpa=ULLONG_MAX, region="", and uuid=0

This work must be protected by dpa_rwsem & region_rwsem since
it is looking up region mappings.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/core.h   |  6 +++++
 drivers/cxl/core/mbox.c   | 17 ++++++++++----
 drivers/cxl/core/region.c |  8 +++++++
 drivers/cxl/core/trace.h  | 47 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 24454a1cb250..848ef6904beb 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -30,8 +30,14 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
 u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		  u64 dpa);
+const char *cxl_trace_to_region_name(const struct cxl_memdev *cxlmd, u64 dpa);
 
 #else
+static inline
+const char *cxl_trace_to_region_name(const struct cxl_memdev *cxlmd, u64 dpa)
+{
+	return NULL;
+}
 static inline u64
 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd, u64 dpa)
 {
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9adda4795eb7..3c1c37d5fcb0 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -842,14 +842,23 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt)
 {
+	if (event_type == CXL_CPER_EVENT_MEM_MODULE) {
+		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
+		return;
+	}
+	if (event_type == CXL_CPER_EVENT_GENERIC) {
+		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
+		return;
+	}
+
+	/* Protect trace events that do DPA->HPA translations */
+	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_dpa_rwsem);
+
 	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
 		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
 	else if (event_type == CXL_CPER_EVENT_DRAM)
 		trace_cxl_dram(cxlmd, type, &evt->dram);
-	else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
-		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
-	else
-		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 45eb9c560fd6..a5b1eaee1e58 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2723,6 +2723,14 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 	return ctx.cxlr;
 }
 
+const char *cxl_trace_to_region_name(const struct cxl_memdev *cxlmd, u64 dpa)
+{
+	struct cxl_region *cxlr = cxl_dpa_to_region(cxlmd, dpa);
+
+	/* trace __string() assignment requires "", not NULL */
+	return cxlr ? dev_name(&cxlr->dev) : "";
+}
+
 static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
 {
 	struct cxl_region_params *p = &cxlr->params;
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 161bdb5734b0..6ad4998aeb9a 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -14,6 +14,22 @@
 #include <cxlmem.h>
 #include "core.h"
 
+#define to_region_name(cxlmd, dpa)					\
+	(cxl_trace_to_region_name(cxlmd, dpa))
+
+#define store_region_info(cxlmd, dpa, entry_uuid, entry_hpa)		\
+	do {								\
+		struct cxl_region *cxlr;				\
+									\
+		cxlr = cxl_dpa_to_region(cxlmd, dpa);			\
+		if (cxlr) {						\
+			uuid_copy(&(entry_uuid), &cxlr->params.uuid);	\
+			entry_hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);	\
+		} else {						\
+			entry_hpa = ULLONG_MAX;				\
+		}							\
+	} while (0)
+
 #define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
 #define CXL_RAS_UC_CACHE_ADDR_PARITY	BIT(1)
 #define CXL_RAS_UC_CACHE_BE_PARITY	BIT(2)
@@ -313,6 +329,9 @@ TRACE_EVENT(cxl_generic_event,
 	{ CXL_GMER_VALID_COMPONENT,			"COMPONENT"	}  \
 )
 
+#define to_gm_dpa(record)						\
+	(le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK)
+
 TRACE_EVENT(cxl_general_media,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
@@ -330,10 +349,13 @@ TRACE_EVENT(cxl_general_media,
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
+		__string(region_name, to_region_name(cxlmd, to_gm_dpa(record)))
 	),
 
 	TP_fast_assign(
@@ -354,18 +376,23 @@ TRACE_EVENT(cxl_general_media,
 		memcpy(__entry->comp_id, &rec->component_id,
 			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
 		__entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
+		__assign_str(region_name, to_region_name(cxlmd, to_gm_dpa(record)));
+		store_region_info(cxlmd, to_gm_dpa(record),
+				  __entry->region_uuid, __entry->hpa);
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
 
@@ -396,6 +423,8 @@ TRACE_EVENT(cxl_general_media,
 	{ CXL_DER_VALID_COLUMN,				"COLUMN"		}, \
 	{ CXL_DER_VALID_CORRECTION_MASK,		"CORRECTION MASK"	}  \
 )
+#define to_dram_dpa(record)						\
+	(le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK)
 
 TRACE_EVENT(cxl_dram,
 
@@ -417,10 +446,13 @@ TRACE_EVENT(cxl_dram,
 		__field(u32, nibble_mask)
 		__field(u32, row)
 		__array(u8, cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE)
+		__field(u64, hpa)
+		__field_struct(uuid_t, region_uuid)
 		__field(u8, rank)	/* Out of order to pack trace record */
 		__field(u8, bank_group)	/* Out of order to pack trace record */
 		__field(u8, bank)	/* Out of order to pack trace record */
 		__field(u8, dpa_flags)	/* Out of order to pack trace record */
+		__string(region_name, to_region_name(cxlmd, to_dram_dpa(record)))
 	),
 
 	TP_fast_assign(
@@ -444,12 +476,16 @@ TRACE_EVENT(cxl_dram,
 		__entry->column = get_unaligned_le16(rec->column);
 		memcpy(__entry->cor_mask, &rec->correction_mask,
 			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
+		__assign_str(region_name, to_region_name(cxlmd, to_dram_dpa(record)));
+		store_region_info(cxlmd, __entry->dpa, __entry->region_uuid,
+				  __entry->hpa);
 	),
 
 	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' descriptor='%s' type='%s' " \
 		"transaction_type='%s' channel=%u rank=%u nibble_mask=%x " \
 		"bank_group=%u bank=%u row=%u column=%u cor_mask=%s " \
-		"validity_flags='%s'",
+		"validity_flags='%s'" \
+		"hpa=%llx region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
 		show_mem_event_type(__entry->type),
@@ -458,7 +494,8 @@ TRACE_EVENT(cxl_dram,
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

