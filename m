Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7619B5B2;
	Tue, 22 Oct 2024 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594761; cv=none; b=eqEsWPA4bkL45jW/Su7WNoD3fjyll1pxzInS5xI3VzBpTykLt6qbxQqq/YcA7AOmXYRddgm1X3dC1tW6Q3DhJpb/A643IrZ6WeE2flL5hxrEi3EL1AIIR1XFQ68ZIKmSEREtCwxrtgscVUVWBq/CNXkiY597PkAwWrbQvGoJzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594761; c=relaxed/simple;
	bh=lBeJJSHA7kMjd+Tl5j8uasmI6e7quks+V/0dQfyEfQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNdaCSqQw4/V4xkwu0dIHiB7yPpeptTaDFLvJeR2Ux/wGYIouksBkMyiYVbGruMivCZ523fr0eCK60xIkhIaa9OVnp07PF8UdoDidg7aw0h8EWDohiH0YAcgkR0Cfxs+GMRNSVH+lwP7gzorDT1fafXgFGl8KQ6EJNLqVAmumBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XXpzC5TMkz6GBWF;
	Tue, 22 Oct 2024 18:57:11 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 7148A140680;
	Tue, 22 Oct 2024 18:59:11 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.246.16) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 12:59:10 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 3/6] cxl/events: Update General Media Event Record to CXL spec rev 3.1
Date: Tue, 22 Oct 2024 11:58:46 +0100
Message-ID: <20241022105849.1272-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241022105849.1272-1-shiju.jose@huawei.com>
References: <20241022105849.1272-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec rev 3.1 section 8.2.9.2.1.1 Table 8-45, General Media Event
Record has updated with following new fields and new types for Memory
Event Type and Transaction Type fields.
1. Advanced Programmable Corrected Memory Error Threshold Event Flags
2. Corrected Memory Error Count at Event
3. Memory Event Sub-Type

The format of component identifier has changed (CXL spec 3.1 section
8.2.9.2.1 Table 8-44).

Update the general media event record and general media trace event for
the above spec changes. The new fields are inserted in logical places.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/trace.h | 84 ++++++++++++++++++++++++++++++++++------
 include/cxl/event.h      |  5 ++-
 2 files changed, 76 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 81908072c6f3..ef70fc37660f 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -290,7 +290,7 @@ TRACE_EVENT(cxl_generic_event,
 
 /*
  * General Media Event Record - GMER
- * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ * CXL rev 3.1 Section 8.2.9.2.1.1; Table 8-45
  */
 #define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT		BIT(0)
 #define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
@@ -304,10 +304,18 @@ TRACE_EVENT(cxl_generic_event,
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
@@ -317,6 +325,8 @@ TRACE_EVENT(cxl_generic_event,
 #define CXL_GMER_TRANS_HOST_INJECT_POISON		0x04
 #define CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB		0x05
 #define CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT	0x06
+#define CXL_GMER_TRANS_INTERNAL_MEDIA_ECS		0x07
+#define CXL_GMER_TRANS_MEDIA_INITIALIZATION		0x08
 #define show_trans_type(type)	__print_symbolic(type,					\
 	{ CXL_GMER_TRANS_UNKNOWN,			"Unknown" },			\
 	{ CXL_GMER_TRANS_HOST_READ,			"Host Read" },			\
@@ -324,13 +334,16 @@ TRACE_EVENT(cxl_generic_event,
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
@@ -338,6 +351,41 @@ TRACE_EVENT(cxl_generic_event,
 	{ CXL_GMER_VALID_COMPONENT,			"COMPONENT"	}  \
 )
 
+#define CXL_GMER_CME_EV_FLAG_CME_MULTIPLE_MEDIA		BIT(0)
+#define CXL_GMER_CME_EV_FLAG_THRESHOLD_EXCEEDED		BIT(1)
+#define show_cme_threshold_ev_flags(flags)	__print_flags(flags, "|",	\
+	{									\
+		CXL_GMER_CME_EV_FLAG_CME_MULTIPLE_MEDIA,			\
+		"Corrected Memory Errors in Multiple Media Components"		\
+	}, {									\
+		CXL_GMER_CME_EV_FLAG_THRESHOLD_EXCEEDED,			\
+		"Exceeded Programmable Threshold"				\
+	}									\
+)
+
+#define CXL_GMER_MEM_EVT_SUB_TYPE_NOT_REPORTED				0x00
+#define CXL_GMER_MEM_EVT_SUB_TYPE_INTERNAL_DATAPATH_ERROR		0x01
+#define CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_COMMAND_TRAINING_ERROR	0x02
+#define CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_CONTROL_TRAINING_ERROR	0x03
+#define CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_DATA_TRAINING_ERROR	0x04
+#define CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_CRC_ERROR			0x05
+#define show_mem_event_sub_type(sub_type)	__print_symbolic(sub_type,			\
+	{ CXL_GMER_MEM_EVT_SUB_TYPE_NOT_REPORTED, "Not Reported" },				\
+	{ CXL_GMER_MEM_EVT_SUB_TYPE_INTERNAL_DATAPATH_ERROR, "Internal Datapath Error" },	\
+	{											\
+		CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_COMMAND_TRAINING_ERROR,			\
+		"Media Link Command Training Error"						\
+	}, {											\
+		CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_CONTROL_TRAINING_ERROR,			\
+		"Media Link Control Training Error"						\
+	}, {											\
+		CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_DATA_TRAINING_ERROR,			\
+		"Media Link Data Training Error"						\
+	}, {											\
+		CXL_GMER_MEM_EVT_SUB_TYPE_MEDIA_LINK_CRC_ERROR, "Media Link CRC Error"		\
+	}											\
+)
+
 TRACE_EVENT(cxl_general_media,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
@@ -351,6 +399,7 @@ TRACE_EVENT(cxl_general_media,
 		__field(u64, dpa)
 		__field(u8, descriptor)
 		__field(u8, type)
+		__field(u8, sub_type)
 		__field(u8, transaction_type)
 		__field(u8, channel)
 		__field(u32, device)
@@ -361,6 +410,8 @@ TRACE_EVENT(cxl_general_media,
 		__field(u16, validity_flags)
 		__field(u8, rank)
 		__field(u8, dpa_flags)
+		__field(u8, cme_threshold_ev_flags)
+		__field(u32, cme_count)
 		__string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
 	),
 
@@ -375,6 +426,7 @@ TRACE_EVENT(cxl_general_media,
 		__entry->dpa &= CXL_DPA_MASK;
 		__entry->descriptor = rec->media_hdr.descriptor;
 		__entry->type = rec->media_hdr.type;
+		__entry->sub_type = rec->sub_type;
 		__entry->transaction_type = rec->media_hdr.transaction_type;
 		__entry->channel = rec->media_hdr.channel;
 		__entry->rank = rec->media_hdr.rank;
@@ -383,6 +435,8 @@ TRACE_EVENT(cxl_general_media,
 			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
 		__entry->validity_flags = get_unaligned_le16(&rec->media_hdr.validity_flags);
 		__entry->hpa = hpa;
+		__entry->cme_threshold_ev_flags = rec->cme_threshold_ev_flags;
+		__entry->cme_count = get_unaligned_le24(rec->cme_count);
 		if (cxlr) {
 			__assign_str(region_name);
 			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
@@ -393,17 +447,23 @@ TRACE_EVENT(cxl_general_media,
 	),
 
 	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
-		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
-		"device=%x comp_id=%s validity_flags='%s' " \
-		"hpa=%llx region=%s region_uuid=%pUb",
+		"descriptor='%s' type='%s' sub_type='%s' " \
+		"transaction_type='%s' channel=%u rank=%u " \
+		"device=%x comp_id=%s%s validity_flags='%s' " \
+		"hpa=%llx cme_threshold_ev_flags='%s' cme_count=%x " \
+		"region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
 		show_gmer_mem_event_type(__entry->type),
+		show_mem_event_sub_type(__entry->sub_type),
 		show_trans_type(__entry->transaction_type),
 		__entry->channel, __entry->rank, __entry->device,
-		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
-		show_valid_flags(__entry->validity_flags),
-		__entry->hpa, __get_str(region_name), &__entry->region_uuid
+		comp_id_pldm_flags(__entry->comp_id[0]),
+		cxl_print_component_id(__entry->validity_flags, CXL_GMER_VALID_COMPONENT,
+				       CXL_GMER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
+		show_valid_flags(__entry->validity_flags), __entry->hpa,
+		show_cme_threshold_ev_flags(__entry->cme_threshold_ev_flags),
+		__entry->cme_count, __get_str(region_name), &__entry->region_uuid
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

