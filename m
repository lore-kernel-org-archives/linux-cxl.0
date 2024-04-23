Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D71C687
	for <linux-cxl@vger.kernel.org>; Tue, 23 Apr 2024 03:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844094; cv=none; b=sSf8/GyCIbinkG4Grze9eNbH3XBvbLN8cBl1hOBhYBk1Tz5LqSKPL1ZTfFtLH4XN095xfbuW74c2DXcBJOMbLcGgLGoq+0reOvIVA7xaUsEIJpWPJmK5JWzixM4/z4Sy0Im3DayuLQKBzoGGD3uchF8/uFskoSRZVNfp12gLSGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844094; c=relaxed/simple;
	bh=Pc5feEYKcNb02XEg051Cu+r+KgAQ7eV6ik2KQhwtbpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tDHcGE37c8ZmkmD3ArscUxtzuaKO6UGmfPxxYOv85wE+AjguLe7Y7+MdGyl3BIumZ0v3uoY/GhdxY6z6lFIfWzVmmBOG4qYzwA8FZsOkLrNkGK6AA1M+npR8MF3gSbjB0msex+rrrZAtf7lhlZlWlgl2RYs8Smfp/Tp6n1KWErw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfUH5wIw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfUH5wIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713844093; x=1745380093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pc5feEYKcNb02XEg051Cu+r+KgAQ7eV6ik2KQhwtbpM=;
  b=mfUH5wIwPxmRH0z/PFP4tfaXc/fmMIVGs1mgOr/8urp+veCEImJS8GNA
   AsVNZEgxsM0X+rSzZTyTaBNzsrK8x9TcnXAbE6VQnpAcMHiJQwJdrZqwf
   bzNE5q7d9qLAUL9o8HHPL6bQ7w5RjS5OybmgZdBT5IhPZOg9hQ0o+okqb
   fAI6V0Qs85b4eociIva7tY9+2RKg9UWpN0S2c9zw0+fDfsyOrdNzSwRhp
   6pitwBL2KLXUdkUk5ikRNctoNfsAB/p4PyKU3sCjSMYLYePJluMJQDK9q
   MnLfM/8qDHUYomrq4MLOK9rVFKMO4sZlP3FD/BfSg/t4hPUbi46pEYElP
   w==;
X-CSE-ConnectionGUID: zNstFMgwQHuN28laqr1vlA==
X-CSE-MsgGUID: qJFBvu+EQRStj6ZRvPRjXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="26925899"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26925899"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 20:48:11 -0700
X-CSE-ConnectionGUID: dTGt7U+PQqytymIkhfIrtA==
X-CSE-MsgGUID: oI7pF/91SXCYOwDaPYr6dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28884706"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.73.120])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 20:48:11 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 3/4] cxl/core: Add region info to cxl_general_media and cxl_dram events
Date: Mon, 22 Apr 2024 20:48:05 -0700
Message-Id: <800328a3fdffa0f3ece709be337bd64a07089bff.1713842838.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713842838.git.alison.schofield@intel.com>
References: <cover.1713842838.git.alison.schofield@intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h   |  6 +++++
 drivers/cxl/core/mbox.c   | 17 ++++++++++---
 drivers/cxl/core/region.c |  8 ++++++
 drivers/cxl/core/trace.h  | 52 +++++++++++++++++++++++++++++++++++----
 4 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 625394486459..2fd8d9797f36 100644
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
+	return "";
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
index 161bdb5734b0..2e24364b2b8d 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -14,6 +14,28 @@
 #include <cxlmem.h>
 #include "core.h"
 
+#ifndef __CXL_EVENTS_DECLARE_ONCE_ONLY
+#define __CXL_EVENTS_DECLARE_ONCE_ONLY
+static inline
+void store_region_info(const struct cxl_memdev *cxlmd, u64 dpa, uuid_t *uuid,
+		       u64 *hpa)
+{
+	struct cxl_region *cxlr;
+
+	cxlr = cxl_dpa_to_region(cxlmd, dpa);
+	if (cxlr) {
+		uuid_copy(uuid, &cxlr->params.uuid);
+		*hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
+	} else {
+		uuid_copy(uuid, &uuid_null);
+		*hpa = ULLONG_MAX;
+	}
+}
+#endif /* __CXL_EVENTS_DECLARE_ONCE_ONLY */
+
+#define rec_pa_to_dpa(record)						\
+	(le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK)
+
 #define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
 #define CXL_RAS_UC_CACHE_ADDR_PARITY	BIT(1)
 #define CXL_RAS_UC_CACHE_BE_PARITY	BIT(2)
@@ -330,10 +352,14 @@ TRACE_EVENT(cxl_general_media,
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
+		__string(region_name,
+			 cxl_trace_to_region_name(cxlmd, rec_pa_to_dpa(record)))
 	),
 
 	TP_fast_assign(
@@ -354,18 +380,24 @@ TRACE_EVENT(cxl_general_media,
 		memcpy(__entry->comp_id, &rec->component_id,
 			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
 		__entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
+		__assign_str(region_name,
+			     cxl_trace_to_region_name(cxlmd, __entry->dpa));
+		store_region_info(cxlmd, __entry->dpa, &__entry->region_uuid,
+				  &__entry->hpa);
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
 
@@ -417,10 +449,14 @@ TRACE_EVENT(cxl_dram,
 		__field(u32, nibble_mask)
 		__field(u32, row)
 		__array(u8, cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE)
+		__field(u64, hpa)
+		__field_struct(uuid_t, region_uuid)
 		__field(u8, rank)	/* Out of order to pack trace record */
 		__field(u8, bank_group)	/* Out of order to pack trace record */
 		__field(u8, bank)	/* Out of order to pack trace record */
 		__field(u8, dpa_flags)	/* Out of order to pack trace record */
+		__string(region_name,
+			 cxl_trace_to_region_name(cxlmd, rec_pa_to_dpa(record)))
 	),
 
 	TP_fast_assign(
@@ -444,12 +480,17 @@ TRACE_EVENT(cxl_dram,
 		__entry->column = get_unaligned_le16(rec->column);
 		memcpy(__entry->cor_mask, &rec->correction_mask,
 			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
+		__assign_str(region_name,
+			     cxl_trace_to_region_name(cxlmd, __entry->dpa));
+		store_region_info(cxlmd, __entry->dpa, &__entry->region_uuid,
+				  &__entry->hpa);
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
@@ -458,7 +499,8 @@ TRACE_EVENT(cxl_dram,
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

