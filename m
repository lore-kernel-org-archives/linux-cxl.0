Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8D720FABD;
	Wed, 16 Oct 2024 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096467; cv=none; b=aNAr1FhbwS7Cr+fImM/u22OV51Z1wn3eM3DpPbC9iO7cpgYHR08ADAVrjKFwdG6OjYb1QBjJ5Al6lmYoYre2Gf998gKwOiiL1Z0Nxa1e22lFLCy8YwZ2E7m5LaMkVojinwTqFC+p3sTeTLlpvj91LQRvOKptCXjvJ5WTc1NANko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096467; c=relaxed/simple;
	bh=9rEU84IE61kr7WP4HCBrvhB0XkVtpuTBbmQyt2fLFaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6+UxE719ojgf8uUII90i+y6B0vRk27/QfzG6hdGsanIvfLmFeEJF0CXLvIXB8msL0edi+ET1r1ZJQXF5fIsy+CtK16SsDSyYzFmhtJARK+Z69vbWcatfpnyjVeLttKSv3SAzMt1W3q/lm45rrXnEGvl260yY6ZlwVBqXtX3pDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTGj42rlpz6J6CZ;
	Thu, 17 Oct 2024 00:32:40 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id A8D83140134;
	Thu, 17 Oct 2024 00:34:21 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.158.191) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 18:34:20 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 3/4] cxl/events: Updates for CXL DRAM Event Record
Date: Wed, 16 Oct 2024 17:33:48 +0100
Message-ID: <20241016163349.1210-4-shiju.jose@huawei.com>
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

CXL spec 3.1 section 8.2.9.2.1.2 Table 8-46, DRAM Event Record has updated
with following new fields and new types for Memory Event Type, Transaction
Type and Validity Flags fields.
1. Component Identifier
2. Sub-channel
3. Advanced Programmable Corrected Memory Error Threshold Event Flags
4. Corrected Memory Error Count at Event
5. Memory Event Sub-Type

Add updates for the above spec changes in the CXL events record and CXL
DRAM trace event implementations.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/trace.h | 44 ++++++++++++++++++++++++++++++++--------
 include/cxl/event.h      |  7 ++++++-
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index e638e82429bc..20790dffa2b4 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -468,7 +468,7 @@ TRACE_EVENT(cxl_general_media,
 /*
  * DRAM Event Record - DER
  *
- * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ * CXL rev 3.1 section 8.2.9.2.1.2; Table 8-46
  */
 /*
  * DRAM Event Record defines many fields the same as the General Media Event
@@ -478,11 +478,17 @@ TRACE_EVENT(cxl_general_media,
 #define CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR	0x01
 #define CXL_DER_MEM_EVT_TYPE_INV_ADDR			0x02
 #define CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x03
-#define show_dram_mem_event_type(type)  __print_symbolic(type,				\
+#define CXL_DER_MEM_EVT_TYPE_TE_STATE_VIOLATION	0x04
+#define CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE	0x05
+#define CXL_DER_MEM_EVT_TYPE_CKID_VIOLATION		0x06
+#define show_dram_mem_event_type(type)	__print_symbolic(type,				\
 	{ CXL_DER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },			\
 	{ CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR,	"Scrub Media ECC Error" },	\
 	{ CXL_DER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },		\
-	{ CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR,		"Data Path Error" }		\
+	{ CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR,		"Data Path Error" },		\
+	{ CXL_DER_MEM_EVT_TYPE_TE_STATE_VIOLATION,	"TE State Violation" },		\
+	{ CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE,	"Adv Prog CME Counter Expiration" },	\
+	{ CXL_DER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" }		\
 )
 
 #define CXL_DER_VALID_CHANNEL				BIT(0)
@@ -493,7 +499,10 @@ TRACE_EVENT(cxl_general_media,
 #define CXL_DER_VALID_ROW				BIT(5)
 #define CXL_DER_VALID_COLUMN				BIT(6)
 #define CXL_DER_VALID_CORRECTION_MASK			BIT(7)
-#define show_dram_valid_flags(flags)	__print_flags(flags, "|",			   \
+#define CXL_DER_VALID_COMPONENT				BIT(8)
+#define CXL_DER_VALID_COMPONENT_ID_FORMAT		BIT(9)
+#define CXL_DER_VALID_SUB_CHANNEL			BIT(10)
+#define show_dram_valid_flags(flags)	__print_flags(flags, "|",		   \
 	{ CXL_DER_VALID_CHANNEL,			"CHANNEL"		}, \
 	{ CXL_DER_VALID_RANK,				"RANK"			}, \
 	{ CXL_DER_VALID_NIBBLE,				"NIBBLE"		}, \
@@ -501,7 +510,9 @@ TRACE_EVENT(cxl_general_media,
 	{ CXL_DER_VALID_BANK,				"BANK"			}, \
 	{ CXL_DER_VALID_ROW,				"ROW"			}, \
 	{ CXL_DER_VALID_COLUMN,				"COLUMN"		}, \
-	{ CXL_DER_VALID_CORRECTION_MASK,		"CORRECTION MASK"	}  \
+	{ CXL_DER_VALID_CORRECTION_MASK,		"CORRECTION MASK"	}, \
+	{ CXL_DER_VALID_COMPONENT,			"COMPONENT"		}, \
+	{ CXL_DER_VALID_SUB_CHANNEL,			"SUB CHANNEL"		}  \
 )
 
 TRACE_EVENT(cxl_dram,
@@ -530,6 +541,11 @@ TRACE_EVENT(cxl_dram,
 		__field(u8, bank_group)	/* Out of order to pack trace record */
 		__field(u8, bank)	/* Out of order to pack trace record */
 		__field(u8, dpa_flags)	/* Out of order to pack trace record */
+		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
+		__field(u32, cvme_count)
+		__field(u8, sub_channel)
+		__field(u8, cme_threshold_ev_flags)
+		__field(u8, sub_type)
 		__string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
 	),
 
@@ -554,7 +570,13 @@ TRACE_EVENT(cxl_dram,
 		__entry->column = get_unaligned_le16(rec->column);
 		memcpy(__entry->cor_mask, &rec->correction_mask,
 			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
+		memcpy(__entry->comp_id, &rec->component_id,
+		       CXL_EVENT_GEN_MED_COMP_ID_SIZE);
 		__entry->hpa = hpa;
+		__entry->sub_channel = rec->sub_channel;
+		__entry->cme_threshold_ev_flags = rec->cme_threshold_ev_flags;
+		__entry->cvme_count = get_unaligned_le24(rec->cvme_count);
+		__entry->sub_type = rec->sub_type;
 		if (cxlr) {
 			__assign_str(region_name);
 			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
@@ -567,8 +589,9 @@ TRACE_EVENT(cxl_dram,
 	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' descriptor='%s' type='%s' " \
 		"transaction_type='%s' channel=%u rank=%u nibble_mask=%x " \
 		"bank_group=%u bank=%u row=%u column=%u cor_mask=%s " \
-		"validity_flags='%s' " \
-		"hpa=%llx region=%s region_uuid=%pUb",
+		"comp_id=%s validity_flags='%s' " \
+		"hpa=%llx sub_channel=%u cme_threshold_ev_flags='%s' " \
+		"cvme_count=%x sub_type='%s' region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
 		show_dram_mem_event_type(__entry->type),
@@ -577,8 +600,13 @@ TRACE_EVENT(cxl_dram,
 		__entry->bank_group, __entry->bank,
 		__entry->row, __entry->column,
 		__print_hex(__entry->cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE),
+		cxl_print_component_id(__entry->validity_flags, CXL_DER_VALID_COMPONENT,
+				       CXL_DER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
 		show_dram_valid_flags(__entry->validity_flags),
-		__entry->hpa, __get_str(region_name), &__entry->region_uuid
+		__entry->hpa, __entry->sub_channel,
+		show_cme_threshold_ev_flags(__entry->cme_threshold_ev_flags),
+		__entry->cvme_count, show_mem_event_sub_type(__entry->sub_type),
+		__get_str(region_name), &__entry->region_uuid
 	)
 );
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index ea8cd44a52e9..7e98492c85df 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -71,7 +71,12 @@ struct cxl_event_dram {
 	u8 row[3];
 	u8 column[2];
 	u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
-	u8 reserved[0x17];
+	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+	u8 sub_channel;
+	u8 cme_threshold_ev_flags;
+	u8 cvme_count[3];
+	u8 sub_type;
+	u8 reserved;
 } __packed;
 
 /*
-- 
2.34.1

