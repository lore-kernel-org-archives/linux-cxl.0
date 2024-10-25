Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455491E1308;
	Fri, 25 Oct 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856795; cv=none; b=eFQ8cM87Aeu9ehUtehfUnJiSxv329GIrfZccUJVyCL67YeduYB2OwK/3NpEW5KL+Xcn4wHw2V+yPrnJ3L3uGmpm+3z5aWx0QQJCLxeTkpZytR2crE5QU+yZfY7TQna0XKqPrNRu8jiOSJnd23+LFLqmt1Hh5Svm9bGuQo0TUuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856795; c=relaxed/simple;
	bh=DvA5v5F4ASxXnCV/DMhrrTo7ZWjH9z+bWKqwUHtFhak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYS3ZHku5UjDoFgDJev4i40DMAtzI82EJdqgEesJiUM+VYIDVLhve362N7MztThSGc7jUl402a51Rl5FADBkoKP3YD6M0GUal4tgUhv521yST0Q2mVNbLFpELbQZi9g4rN+wp77BMSO2SYYVdMV/X7IRunzozHQUs1qWbs4Y1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZgtF0Q12z6K6tC;
	Fri, 25 Oct 2024 19:44:21 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CA42140A86;
	Fri, 25 Oct 2024 19:46:30 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.104) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 13:46:29 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 4/6] cxl/events: Update DRAM Event Record to CXL spec rev 3.1
Date: Fri, 25 Oct 2024 12:45:53 +0100
Message-ID: <20241025114555.1363-5-shiju.jose@huawei.com>
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

CXL spec 3.1 section 8.2.9.2.1.2 Table 8-46, DRAM Event Record has updated
with following new fields and new types for Memory Event Type, Transaction
Type and Validity Flags fields.
1. Component Identifier
2. Sub-channel
3. Advanced Programmable Corrected Memory Error Threshold Event Flags
4. Corrected Memory Error Count at Event
5. Memory Event Sub-Type

Update DRAM events record and DRAM trace event for the above spec
changes. The new fields are inserted in logical places.
Includes trivial consistency of white space improvements.

Example for cxl_dram trace event,

cxl_dram: memdev=mem3 host=0000:0f:00.0 serial=3 log=Informational : \
time=293360302809 uuid=601dcbb3-9c06-4eab-b8af-4e9bfb5c9624 len=128 \
flags='0x1' handle=1 related_handle=0 maint_op_class=0 \
maint_op_sub_class=0 : dpa=18680 dpa_flags='' \
descriptor='UNCORRECTABLE_EVENT|THRESHOLD_EVENT' \
type='Data Path Error' sub_type='Media Link CRC Error' \
transaction_type='Internal Media Scrub' channel=3 rank=17 \
nibble_mask=3b00b2 bank_group=7 bank=11 row=2 column=77 \
cor_mask=21 00 00 00 00 00 00 00 2c 00 00 00 00 00 00 00 37 00 00 00 00 \
00 00 00 42 00 00 00 00 00 00 00 \
validity_flags='CHANNEL|RANK|NIBBLE|BANK GROUP|BANK|ROW|COLUMN|CORRECTION \
MASK|COMPONENT|COMPONENT PLDM FORMAT' \
comp_id=01 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
comp_id_pldm_valid_flags='PLDM Entity ID' \
pldm_entity_id=74 c5 08 9a 1a 0b pldm_resource_id=0x00 \
hpa=ffffffffffffffff sub_channel=5 cme_threshold_ev_flags='Corrected \
Memory Errors in Multiple Media Components|Exceeded Programmable \
Threshold' cvme_count=94 region= region_uuid=00000000-0000-0000

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/trace.h | 71 ++++++++++++++++++++++++++++++----------
 include/cxl/event.h      |  7 +++-
 2 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 91c81b371373..6f201ad93388 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -478,7 +478,7 @@ TRACE_EVENT(cxl_general_media,
 /*
  * DRAM Event Record - DER
  *
- * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ * CXL rev 3.1 section 8.2.9.2.1.2; Table 8-46
  */
 /*
  * DRAM Event Record defines many fields the same as the General Media Event
@@ -488,11 +488,17 @@ TRACE_EVENT(cxl_general_media,
 #define CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR	0x01
 #define CXL_DER_MEM_EVT_TYPE_INV_ADDR			0x02
 #define CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x03
-#define show_dram_mem_event_type(type)  __print_symbolic(type,				\
-	{ CXL_DER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },			\
-	{ CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR,	"Scrub Media ECC Error" },	\
-	{ CXL_DER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },		\
-	{ CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR,		"Data Path Error" }		\
+#define CXL_DER_MEM_EVT_TYPE_TE_STATE_VIOLATION	0x04
+#define CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE	0x05
+#define CXL_DER_MEM_EVT_TYPE_CKID_VIOLATION		0x06
+#define show_dram_mem_event_type(type)	__print_symbolic(type,					\
+	{ CXL_DER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },				\
+	{ CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR,	"Scrub Media ECC Error" },		\
+	{ CXL_DER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },			\
+	{ CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR,		"Data Path Error" },			\
+	{ CXL_DER_MEM_EVT_TYPE_TE_STATE_VIOLATION,	"TE State Violation" },			\
+	{ CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE,	"Adv Prog CME Counter Expiration" },	\
+	{ CXL_DER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" }			\
 )
 
 #define CXL_DER_VALID_CHANNEL				BIT(0)
@@ -503,15 +509,21 @@ TRACE_EVENT(cxl_general_media,
 #define CXL_DER_VALID_ROW				BIT(5)
 #define CXL_DER_VALID_COLUMN				BIT(6)
 #define CXL_DER_VALID_CORRECTION_MASK			BIT(7)
-#define show_dram_valid_flags(flags)	__print_flags(flags, "|",			   \
-	{ CXL_DER_VALID_CHANNEL,			"CHANNEL"		}, \
-	{ CXL_DER_VALID_RANK,				"RANK"			}, \
-	{ CXL_DER_VALID_NIBBLE,				"NIBBLE"		}, \
-	{ CXL_DER_VALID_BANK_GROUP,			"BANK GROUP"		}, \
-	{ CXL_DER_VALID_BANK,				"BANK"			}, \
-	{ CXL_DER_VALID_ROW,				"ROW"			}, \
-	{ CXL_DER_VALID_COLUMN,				"COLUMN"		}, \
-	{ CXL_DER_VALID_CORRECTION_MASK,		"CORRECTION MASK"	}  \
+#define CXL_DER_VALID_COMPONENT				BIT(8)
+#define CXL_DER_VALID_COMPONENT_ID_FORMAT		BIT(9)
+#define CXL_DER_VALID_SUB_CHANNEL			BIT(10)
+#define show_dram_valid_flags(flags)	__print_flags(flags, "|",			\
+	{ CXL_DER_VALID_CHANNEL,			"CHANNEL"		},	\
+	{ CXL_DER_VALID_RANK,				"RANK"			},	\
+	{ CXL_DER_VALID_NIBBLE,				"NIBBLE"		},	\
+	{ CXL_DER_VALID_BANK_GROUP,			"BANK GROUP"		},	\
+	{ CXL_DER_VALID_BANK,				"BANK"			},	\
+	{ CXL_DER_VALID_ROW,				"ROW"			},	\
+	{ CXL_DER_VALID_COLUMN,				"COLUMN"		},	\
+	{ CXL_DER_VALID_CORRECTION_MASK,		"CORRECTION MASK"	},	\
+	{ CXL_DER_VALID_COMPONENT,			"COMPONENT"		},	\
+	{ CXL_DER_VALID_COMPONENT_ID_FORMAT,		"COMPONENT PLDM FORMAT"	},	\
+	{ CXL_DER_VALID_SUB_CHANNEL,			"SUB CHANNEL"		}	\
 )
 
 TRACE_EVENT(cxl_dram,
@@ -527,6 +539,7 @@ TRACE_EVENT(cxl_dram,
 		__field(u64, dpa)
 		__field(u8, descriptor)
 		__field(u8, type)
+		__field(u8, sub_type)
 		__field(u8, transaction_type)
 		__field(u8, channel)
 		__field(u16, validity_flags)
@@ -540,6 +553,10 @@ TRACE_EVENT(cxl_dram,
 		__field(u8, bank_group)	/* Out of order to pack trace record */
 		__field(u8, bank)	/* Out of order to pack trace record */
 		__field(u8, dpa_flags)	/* Out of order to pack trace record */
+		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
+		__field(u8, sub_channel)
+		__field(u8, cme_threshold_ev_flags)
+		__field(u32, cvme_count)
 		__string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
 	),
 
@@ -553,6 +570,7 @@ TRACE_EVENT(cxl_dram,
 		__entry->dpa &= CXL_DPA_MASK;
 		__entry->descriptor = rec->media_hdr.descriptor;
 		__entry->type = rec->media_hdr.type;
+		__entry->sub_type = rec->sub_type;
 		__entry->transaction_type = rec->media_hdr.transaction_type;
 		__entry->validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
 		__entry->channel = rec->media_hdr.channel;
@@ -564,7 +582,12 @@ TRACE_EVENT(cxl_dram,
 		__entry->column = get_unaligned_le16(rec->column);
 		memcpy(__entry->cor_mask, &rec->correction_mask,
 			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
+		memcpy(__entry->comp_id, &rec->component_id,
+		       CXL_EVENT_GEN_MED_COMP_ID_SIZE);
 		__entry->hpa = hpa;
+		__entry->sub_channel = rec->sub_channel;
+		__entry->cme_threshold_ev_flags = rec->cme_threshold_ev_flags;
+		__entry->cvme_count = get_unaligned_le24(rec->cvme_count);
 		if (cxlr) {
 			__assign_str(region_name);
 			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
@@ -574,21 +597,33 @@ TRACE_EVENT(cxl_dram,
 		}
 	),
 
-	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' descriptor='%s' type='%s' " \
+	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' descriptor='%s' type='%s' sub_type='%s' " \
 		"transaction_type='%s' channel=%u rank=%u nibble_mask=%x " \
 		"bank_group=%u bank=%u row=%u column=%u cor_mask=%s " \
 		"validity_flags='%s' " \
-		"hpa=%llx region=%s region_uuid=%pUb",
+		"comp_id=%s comp_id_pldm_valid_flags='%s' " \
+		"pldm_entity_id=%s pldm_resource_id=%s " \
+		"hpa=%llx sub_channel=%u cme_threshold_ev_flags='%s' cvme_count=%x " \
+		"region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
 		show_dram_mem_event_type(__entry->type),
+		show_mem_event_sub_type(__entry->sub_type),
 		show_trans_type(__entry->transaction_type),
 		__entry->channel, __entry->rank, __entry->nibble_mask,
 		__entry->bank_group, __entry->bank,
 		__entry->row, __entry->column,
 		__print_hex(__entry->cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE),
 		show_dram_valid_flags(__entry->validity_flags),
-		__entry->hpa, __get_str(region_name), &__entry->region_uuid
+		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
+		show_comp_id_pldm_flags(__entry->comp_id[0]),
+		show_pldm_entity_id(__entry->validity_flags, CXL_DER_VALID_COMPONENT,
+				    CXL_DER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
+		show_pldm_resource_id(__entry->validity_flags, CXL_DER_VALID_COMPONENT,
+				      CXL_DER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
+		__entry->hpa, __entry->sub_channel,
+		show_cme_threshold_ev_flags(__entry->cme_threshold_ev_flags),
+		__entry->cvme_count, __get_str(region_name), &__entry->region_uuid
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

