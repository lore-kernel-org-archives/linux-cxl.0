Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9984D1DD0FB;
	Fri, 25 Oct 2024 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856794; cv=none; b=WZSWuZ+KNYnn4CmPoMle+8FmnYOc3cuQJeq7jGHn/uu2yX0Hn3xqDzfF/fHeCFPL63fhuClSnrl0oiGihRhpyj5qW/x3JoqByambTWzxBb/BFq8RPuPghi11FAkoJiqUTbTG95IAQiOaEJpfZ7S9/MsEPzXbvyac++GeaO3w3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856794; c=relaxed/simple;
	bh=gdywmuRyizeaMf6yvAMgr9oqcpm3u4cbmNKF7ftFg/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qx5kZUBLFSoo0WrsFJup00iDV13LLaYxl5YH+20A+0oiaai//w6COCfjx8xuvpd8p1562xJgqSa41FriNv/kpYz7xdRiNio0AEU5+23QA5Bartbmru8mTAm94ZQ+dJLApXpoQtLkUxoe9O7CNDlMsGD61hPYhn2Lak5c4HJpwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZgtD1Ssvz6K6pb;
	Fri, 25 Oct 2024 19:44:20 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 9022A1408F9;
	Fri, 25 Oct 2024 19:46:29 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.104) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 13:46:28 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 3/6] cxl/events: Update General Media Event Record to CXL spec rev 3.1
Date: Fri, 25 Oct 2024 12:45:52 +0100
Message-ID: <20241025114555.1363-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241025114555.1363-1-shiju.jose@huawei.com>
References: <20241025114555.1363-1-shiju.jose@huawei.com>
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

Example for cxl_general_media trace event,

cxl_general_media: memdev=mem3 host=0000:0f:00.0 serial=3 log=Fatal : \
time=88752009264 uuid=fbcd0a77-c260-417f-85a9-088b1621eba6 len=128 \
flags='0x1' handle=1 related_handle=0 maint_op_class=0 \
maint_op_sub_class=0 : dpa=30d40 dpa_flags='' \
descriptor='UNCORRECTABLE_EVENT|THRESHOLD_EVENT|POISON_LIST_OVERFLOW' \
type='TE State Violation' sub_type='Media Link Command Training Error' \
transaction_type='Host Inject Poison' channel=3 rank=33 device=5 \
validity_flags='CHANNEL|RANK|DEVICE|COMPONENT|COMPONENT PLDM FORMAT' \
comp_id=03 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
comp_id_pldm_valid_flags='PLDM Entity ID | Resource ID' \
pldm_entity_id=74 c5 08 9a 1a 0b pldm_resource_id=fc d2 7e 2f \
hpa=ffffffffffffffff cme_threshold_ev_flags='Corrected Memory Errors in \
Multiple Media Components|Exceeded Programmable Threshold' cme_count=78 \
region= region_uuid=00000000-0000-0000-0000-000000000000

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/trace.h | 90 ++++++++++++++++++++++++++++++++++------
 include/cxl/event.h      |  5 ++-
 2 files changed, 82 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index b508873ce426..91c81b371373 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -292,7 +292,7 @@ TRACE_EVENT(cxl_generic_event,
 
 /*
  * General Media Event Record - GMER
- * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ * CXL rev 3.1 Section 8.2.9.2.1.1; Table 8-45
  */
 #define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT		BIT(0)
 #define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
@@ -306,10 +306,18 @@ TRACE_EVENT(cxl_generic_event,
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
@@ -319,6 +327,8 @@ TRACE_EVENT(cxl_generic_event,
 #define CXL_GMER_TRANS_HOST_INJECT_POISON		0x04
 #define CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB		0x05
 #define CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT	0x06
+#define CXL_GMER_TRANS_INTERNAL_MEDIA_ECS		0x07
+#define CXL_GMER_TRANS_MEDIA_INITIALIZATION		0x08
 #define show_trans_type(type)	__print_symbolic(type,					\
 	{ CXL_GMER_TRANS_UNKNOWN,			"Unknown" },			\
 	{ CXL_GMER_TRANS_HOST_READ,			"Host Read" },			\
@@ -326,18 +336,57 @@ TRACE_EVENT(cxl_generic_event,
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
 	{ CXL_GMER_VALID_DEVICE,			"DEVICE"	}, \
-	{ CXL_GMER_VALID_COMPONENT,			"COMPONENT"	}  \
+	{ CXL_GMER_VALID_COMPONENT,			"COMPONENT"	}, \
+	{ CXL_GMER_VALID_COMPONENT_ID_FORMAT,		"COMPONENT PLDM FORMAT"	} \
+)
+
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
 )
 
 TRACE_EVENT(cxl_general_media,
@@ -353,6 +402,7 @@ TRACE_EVENT(cxl_general_media,
 		__field(u64, dpa)
 		__field(u8, descriptor)
 		__field(u8, type)
+		__field(u8, sub_type)
 		__field(u8, transaction_type)
 		__field(u8, channel)
 		__field(u32, device)
@@ -363,6 +413,8 @@ TRACE_EVENT(cxl_general_media,
 		__field(u16, validity_flags)
 		__field(u8, rank)
 		__field(u8, dpa_flags)
+		__field(u8, cme_threshold_ev_flags)
+		__field(u32, cme_count)
 		__string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
 	),
 
@@ -377,6 +429,7 @@ TRACE_EVENT(cxl_general_media,
 		__entry->dpa &= CXL_DPA_MASK;
 		__entry->descriptor = rec->media_hdr.descriptor;
 		__entry->type = rec->media_hdr.type;
+		__entry->sub_type = rec->sub_type;
 		__entry->transaction_type = rec->media_hdr.transaction_type;
 		__entry->channel = rec->media_hdr.channel;
 		__entry->rank = rec->media_hdr.rank;
@@ -385,6 +438,8 @@ TRACE_EVENT(cxl_general_media,
 			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
 		__entry->validity_flags = get_unaligned_le16(&rec->media_hdr.validity_flags);
 		__entry->hpa = hpa;
+		__entry->cme_threshold_ev_flags = rec->cme_threshold_ev_flags;
+		__entry->cme_count = get_unaligned_le24(rec->cme_count);
 		if (cxlr) {
 			__assign_str(region_name);
 			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
@@ -395,17 +450,28 @@ TRACE_EVENT(cxl_general_media,
 	),
 
 	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
-		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
-		"device=%x comp_id=%s validity_flags='%s' " \
-		"hpa=%llx region=%s region_uuid=%pUb",
+		"descriptor='%s' type='%s' sub_type='%s' " \
+		"transaction_type='%s' channel=%u rank=%u " \
+		"device=%x validity_flags='%s' " \
+		"comp_id=%s comp_id_pldm_valid_flags='%s' " \
+		"pldm_entity_id=%s pldm_resource_id=%s " \
+		"hpa=%llx cme_threshold_ev_flags='%s' cme_count=%x " \
+		"region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
 		show_gmer_mem_event_type(__entry->type),
+		show_mem_event_sub_type(__entry->sub_type),
 		show_trans_type(__entry->transaction_type),
 		__entry->channel, __entry->rank, __entry->device,
-		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
 		show_valid_flags(__entry->validity_flags),
-		__entry->hpa, __get_str(region_name), &__entry->region_uuid
+		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
+		show_comp_id_pldm_flags(__entry->comp_id[0]),
+		show_pldm_entity_id(__entry->validity_flags, CXL_GMER_VALID_COMPONENT,
+				    CXL_GMER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
+		show_pldm_resource_id(__entry->validity_flags, CXL_GMER_VALID_COMPONENT,
+				      CXL_GMER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
+		__entry->hpa, show_cme_threshold_ev_flags(__entry->cme_threshold_ev_flags),
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

