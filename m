Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F018C20F5C9;
	Wed, 16 Oct 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096465; cv=none; b=sRuomU6W43XTrSyGACeRLsEI6QW2CcaicA48aEnkf6zM5qHXNlXn9nGpVn0MdrjGJkOo0A03+dBKQJ/e5t+UTLfgE7mdfbOthKMop0fcB3CzuvdgM1P91mAy5PuTKZxpTrc+4ge7BsZN6QlyuFc2Sh0MglxcUO5y8K/GnKA84ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096465; c=relaxed/simple;
	bh=7nWupcQusxMlB/7NA/2xIDW3Uph5w+i8kcv+CV988+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AU+hNjFgTSxqke09N6/AsDFmoXCqjZC+rWpRhEd/6JGq30rcSax4ENNyyMYvOcpYdQs6LWkkzmaphSzQvBWNY4Qd3KXniHOhkRXWhGgrbVyKjHOtWSk9FRozTh+Vp71m+tpMMgFf92byyBft2YARJF1Seq3VKEDbmw3vwVJWL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTGdp3JX3z6D91K;
	Thu, 17 Oct 2024 00:29:50 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id A6E0B1400DB;
	Thu, 17 Oct 2024 00:34:20 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.158.191) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 18:34:19 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 2/4] cxl/events: Updates for CXL General Media Event Record
Date: Wed, 16 Oct 2024 17:33:47 +0100
Message-ID: <20241016163349.1210-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241016163349.1210-1-shiju.jose@huawei.com>
References: <20241016163349.1210-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec rev 3.1 section 8.2.9.2.1.1 Table 8-45, General Media Event
Record has updated with following new fields and new types for Memory
Event Type and Transaction Type fields.
1. Advanced Programmable Corrected Memory Error Threshold Event Flags
2. Corrected Memory Error Count at Event
3. Memory Event Sub-Type

The component identifier format has changed (CXL spec 3.1 section
8.2.9.2.1 Table 8-44).

Add updates for the above spec changes in the CXL events record and CXL
general media trace event implementations.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
Question:
Want more abbreviations for the long lines of code in
show_mem_event_sub_type() and for similar in other patches?
 drivers/cxl/core/trace.h | 96 ++++++++++++++++++++++++++++++++++++----
 include/cxl/event.h      |  5 ++-
 2 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 7305974e2301..e638e82429bc 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -268,9 +268,29 @@ TRACE_EVENT(cxl_generic_event,
 	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
 )
 
+/*
+ * Component ID Format
+ * CXL 3.1 section 8.2.9.2.1; Table 8-44
+ */
+#define CXL_PLDM_COMPONENT_ID_ENTITY_VALID	BIT(0)
+#define CXL_PLDM_COMPONENT_ID_RES_VALID		BIT(1)
+#define cxl_print_component_id(flags, valid_comp_id, valid_id_format, comp_id) \
+	if (flags & valid_comp_id && flags & valid_id_format) { \
+		if (comp_id[0] & CXL_PLDM_COMPONENT_ID_ENTITY_VALID) { \
+			__print("PLDM Entity ID = "); \
+			__print_hex(&comp_id[1], 6); \
+		} \
+		if (comp_id[0] & CXL_PLDM_COMPONENT_ID_RES_VALID) { \
+			__print("Resource ID = "); \
+			__print_hex(&comp_id[7], 4); \
+		} \
+	} else { \
+		__print_hex(comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE); \
+	}
+
 /*
  * General Media Event Record - GMER
- * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ * CXL rev 3.1 Section 8.2.9.2.1.1; Table 8-45
  */
 #define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT		BIT(0)
 #define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
@@ -284,10 +304,18 @@ TRACE_EVENT(cxl_generic_event,
 #define CXL_GMER_MEM_EVT_TYPE_ECC_ERROR			0x00
 #define CXL_GMER_MEM_EVT_TYPE_INV_ADDR			0x01
 #define CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x02
-#define show_gmer_mem_event_type(type)	__print_symbolic(type,			\
-	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },		\
-	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },	\
-	{ CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,	"Data Path Error" }	\
+#define CXL_GMER_MEM_EVT_TYPE_TE_STATE_VIOLATION	0x03
+#define CXL_GMER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR	0x04
+#define CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE	0x05
+#define CXL_GMER_MEM_EVT_TYPE_CKID_VIOLATION		0x06
+#define show_gmer_mem_event_type(type)	__print_symbolic(type,				\
+	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },			\
+	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },		\
+	{ CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,	"Data Path Error" },		\
+	{ CXL_GMER_MEM_EVT_TYPE_TE_STATE_VIOLATION,	"TE State Violation" },		\
+	{ CXL_GMER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR,	"Scrub Media ECC Error" },	\
+	{ CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE,	"Adv Prog CME Counter Expiration" },	\
+	{ CXL_GMER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" }		\
 )
 
 #define CXL_GMER_TRANS_UNKNOWN				0x00
@@ -297,6 +325,8 @@ TRACE_EVENT(cxl_generic_event,
 #define CXL_GMER_TRANS_HOST_INJECT_POISON		0x04
 #define CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB		0x05
 #define CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT	0x06
+#define CXL_GMER_TRANS_INTERNAL_MEDIA_ECS		0x07
+#define CXL_GMER_TRANS_MEDIA_INITIALIZATION		0x08
 #define show_trans_type(type)	__print_symbolic(type,					\
 	{ CXL_GMER_TRANS_UNKNOWN,			"Unknown" },			\
 	{ CXL_GMER_TRANS_HOST_READ,			"Host Read" },			\
@@ -304,13 +334,16 @@ TRACE_EVENT(cxl_generic_event,
 	{ CXL_GMER_TRANS_HOST_SCAN_MEDIA,		"Host Scan Media" },		\
 	{ CXL_GMER_TRANS_HOST_INJECT_POISON,		"Host Inject Poison" },		\
 	{ CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,		"Internal Media Scrub" },	\
-	{ CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT,	"Internal Media Management" }	\
+	{ CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT,	"Internal Media Management" },	\
+	{ CXL_GMER_TRANS_INTERNAL_MEDIA_ECS,		"Internal Media Error Check Scrub" },	\
+	{ CXL_GMER_TRANS_MEDIA_INITIALIZATION,		"Media Initialization" }	\
 )
 
 #define CXL_GMER_VALID_CHANNEL				BIT(0)
 #define CXL_GMER_VALID_RANK				BIT(1)
 #define CXL_GMER_VALID_DEVICE				BIT(2)
 #define CXL_GMER_VALID_COMPONENT			BIT(3)
+#define CXL_GMER_VALID_COMPONENT_ID_FORMAT		BIT(4)
 #define show_valid_flags(flags)	__print_flags(flags, "|",		   \
 	{ CXL_GMER_VALID_CHANNEL,			"CHANNEL"	}, \
 	{ CXL_GMER_VALID_RANK,				"RANK"		}, \
@@ -318,6 +351,41 @@ TRACE_EVENT(cxl_generic_event,
 	{ CXL_GMER_VALID_COMPONENT,			"COMPONENT"	}  \
 )
 
+#define CXL_GMER_CME_EV_FLAG_CME_MULTIPLE_MEDIA		BIT(0)
+#define CXL_GMER_CME_EV_FLAG_THRESHOLD_EXCEEDED		BIT(1)
+#define show_cme_threshold_ev_flags(flags)	__print_symbolic(flags,	\
+	{								\
+		CXL_GMER_CME_EV_FLAG_CME_MULTIPLE_MEDIA,		\
+		"Corrected Memory Errors in Multiple Media Components"	\
+	}, {								\
+		CXL_GMER_CME_EV_FLAG_THRESHOLD_EXCEEDED,		\
+		"Exceeded Programmable Threshold"			\
+	}								\
+)
+
+#define CXL_GMER_MEM_EVT_SUB_TYPE_NOT_REPORTED				0x00
+#define CXL_GMER_MEM_EVT_SUB_TYPE_INTERNAL_DATAPATH_ERROR		0x01
+#define CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_COMMAND_TRAINING_ERROR	0x02
+#define CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_CONTROL_TRAINING_ERROR	0x03
+#define CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_DATA_TRAINING_ERROR	0x04
+#define CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_CRC_ERROR			0x05
+#define show_mem_event_sub_type(sub_type)	__print_symbolic(sub_type, \
+	{ CXL_GMER_MEM_EVT_SUB_TYPE_NOT_REPORTED, "Not Reported" }, \
+	{ CXL_GMER_MEM_EVT_SUB_TYPE_INTERNAL_DATAPATH_ERROR, "Internal Datapath Error" }, \
+	{ \
+		CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_COMMAND_TRAINING_ERROR, \
+		"Media Link Command Training Error" \
+	}, { \
+		CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_CONTROL_TRAINING_ERROR, \
+		"Media Link Control Training Error" \
+	}, { \
+		CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_DATA_TRAINING_ERROR, \
+		"Media Link Data Training Error" \
+	}, { \
+		CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_CRC_ERROR, "Media Link CRC Error" \
+	} \
+)
+
 TRACE_EVENT(cxl_general_media,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
@@ -341,6 +409,9 @@ TRACE_EVENT(cxl_general_media,
 		__field(u16, validity_flags)
 		__field(u8, rank)
 		__field(u8, dpa_flags)
+		__field(u8, cme_threshold_ev_flags)
+		__field(u32, cme_count)
+		__field(u8, sub_type)
 		__string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
 	),
 
@@ -363,6 +434,9 @@ TRACE_EVENT(cxl_general_media,
 			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
 		__entry->validity_flags = get_unaligned_le16(&rec->media_hdr.validity_flags);
 		__entry->hpa = hpa;
+		__entry->cme_threshold_ev_flags = rec->cme_threshold_ev_flags;
+		__entry->cme_count = get_unaligned_le24(rec->cme_count);
+		__entry->sub_type = rec->sub_type;
 		if (cxlr) {
 			__assign_str(region_name);
 			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
@@ -375,15 +449,19 @@ TRACE_EVENT(cxl_general_media,
 	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
 		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
 		"device=%x comp_id=%s validity_flags='%s' " \
-		"hpa=%llx region=%s region_uuid=%pUb",
+		"hpa=%llx cme_threshold_ev_flags='%s' cme_count=%x " \
+		"sub_type='%s' region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
 		show_gmer_mem_event_type(__entry->type),
 		show_trans_type(__entry->transaction_type),
 		__entry->channel, __entry->rank, __entry->device,
-		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
+		cxl_print_component_id(__entry->validity_flags, CXL_GMER_VALID_COMPONENT,
+				       CXL_GMER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
 		show_valid_flags(__entry->validity_flags),
-		__entry->hpa, __get_str(region_name), &__entry->region_uuid
+		__entry->hpa, show_cme_threshold_ev_flags(__entry->cme_threshold_ev_flags),
+		__entry->cme_count, show_mem_event_sub_type(__entry->sub_type),
+		__get_str(region_name), &__entry->region_uuid
 	)
 );
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index e1d485ad376b..ea8cd44a52e9 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -52,7 +52,10 @@ struct cxl_event_gen_media {
 	struct cxl_event_media_hdr media_hdr;
 	u8 device[3];
 	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
-	u8 reserved[46];
+	u8 cme_threshold_ev_flags;
+	u8 cme_count[3];
+	u8 sub_type;
+	u8 reserved[41];
 } __packed;
 
 /*
-- 
2.34.1

