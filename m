Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1719C566;
	Wed, 20 Nov 2024 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095490; cv=none; b=RAI6rxwcIF/sk/+aPZ7EhtQnynBSS2VzHqNqZ4rME4Bl7t8h/FgQh2x8xmDougZfcFNaJ02XmPojYZ39bXu4+jEX83rK8ujgBqGhI5LGU5eoN/pRPXJ+jNviMjlXJ3HKMDj/p0dDTUuQd/K1BWs6C+XjzxLhIUSAXOdlbQQoA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095490; c=relaxed/simple;
	bh=5GREuyV5vnoo4glNQCV+eVC2LjPR3FX2G8ZII65Sm4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSb3ATTr1XfDfzrE8yc2xEZWktXBn5jH+0+A2knaRY0ugNLyejgytIBiGnrj/y26JAblzaYBDQf4mxorN2vvttcDVHHcbq91hTMtt+WgdUkhfEGwnh4GPsq2aJIbmUkvKuvdU/J7Q/Lw2YFTfALwwfz5h48kohkYhE8F17eCumg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xtbnq0VxYz6K98S;
	Wed, 20 Nov 2024 17:35:43 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 917B1140932;
	Wed, 20 Nov 2024 17:37:59 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.247.212) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 10:37:58 +0100
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v4 3/6] cxl/events: Update General Media Event Record to CXL spec rev 3.1
Date: Wed, 20 Nov 2024 09:37:42 +0000
Message-ID: <20241120093745.1847-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241120093745.1847-1-shiju.jose@huawei.com>
References: <20241120093745.1847-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
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

Example trace log of cxl_general_media trace event,

cxl_general_media: memdev=mem0 host=0000:0f:00.0 serial=3 log=Fatal : \
time=45104947948 uuid=fbcd0a77-c260-417f-85a9-088b1621eba6 len=128 \
flags='0x1' handle=1 related_handle=0 maint_op_class=2 \
maint_op_sub_class=4 : dpa=0x30d40 dpa_flags=0x0 \
descriptor='UNCORRECTABLE_EVENT|THRESHOLD_EVENT|POISON_LIST_OVERFLOW' \
type='TE State Violation' sub_type=0x2 transaction_type=0x4 channel=3 \
rank=33 device=0x5 validity_flags=0x1f \
comp_id=03 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
pldm_entity_id=74 c5 08 9a 1a 0b pldm_resource_id=fc d2 7e 2f \
hpa=0xffffffffffffffff region= region_uuid=00000000-0000-0000-0000-000000000000 \
cme_threshold_ev_flags=0x3 cme_count=0x78

The number of decoded strings in TP_printk() caused  parsing error when
libtraceevent in userspace parses the CXL general media trace event for
rasdaemon. It was found that long decoded strings of field values in the
TP_printk() caused the issue. As a solution, decoding of some fields
in the TP_printk() were removed to accommodate the new fields.
Decoding of all these fields is added in the userspace tool rasdaemon.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/trace.h | 58 +++++++++++++++++++++++++++++-----------
 include/cxl/event.h      |  7 +++--
 2 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 8e9d80e34a28..77055d66b56e 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -287,7 +287,7 @@ TRACE_EVENT(cxl_generic_event,
 
 /*
  * General Media Event Record - GMER
- * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ * CXL rev 3.1 Section 8.2.9.2.1.1; Table 8-45
  */
 #define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT		BIT(0)
 #define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
@@ -301,10 +301,18 @@ TRACE_EVENT(cxl_generic_event,
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
@@ -314,6 +322,8 @@ TRACE_EVENT(cxl_generic_event,
 #define CXL_GMER_TRANS_HOST_INJECT_POISON		0x04
 #define CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB		0x05
 #define CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT	0x06
+#define CXL_GMER_TRANS_INTERNAL_MEDIA_ECS		0x07
+#define CXL_GMER_TRANS_MEDIA_INITIALIZATION		0x08
 #define show_trans_type(type)	__print_symbolic(type,					\
 	{ CXL_GMER_TRANS_UNKNOWN,			"Unknown" },			\
 	{ CXL_GMER_TRANS_HOST_READ,			"Host Read" },			\
@@ -321,18 +331,22 @@ TRACE_EVENT(cxl_generic_event,
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
 )
 
 TRACE_EVENT(cxl_general_media,
@@ -348,6 +362,7 @@ TRACE_EVENT(cxl_general_media,
 		__field(u64, dpa)
 		__field(u8, descriptor)
 		__field(u8, type)
+		__field(u8, sub_type)
 		__field(u8, transaction_type)
 		__field(u8, channel)
 		__field(u32, device)
@@ -359,6 +374,8 @@ TRACE_EVENT(cxl_general_media,
 		__field(u8, rank)
 		__field(u8, dpa_flags)
 		__string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
+		__field(u8, cme_threshold_ev_flags)
+		__field(u32, cme_count)
 	),
 
 	TP_fast_assign(
@@ -372,6 +389,7 @@ TRACE_EVENT(cxl_general_media,
 		__entry->dpa &= CXL_DPA_MASK;
 		__entry->descriptor = rec->media_hdr.descriptor;
 		__entry->type = rec->media_hdr.type;
+		__entry->sub_type = rec->sub_type;
 		__entry->transaction_type = rec->media_hdr.transaction_type;
 		__entry->channel = rec->media_hdr.channel;
 		__entry->rank = rec->media_hdr.rank;
@@ -380,6 +398,8 @@ TRACE_EVENT(cxl_general_media,
 			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
 		__entry->validity_flags = get_unaligned_le16(&rec->media_hdr.validity_flags);
 		__entry->hpa = hpa;
+		__entry->cme_threshold_ev_flags = rec->cme_threshold_ev_flags;
+		__entry->cme_count = get_unaligned_le24(rec->cme_count);
 		if (cxlr) {
 			__assign_str(region_name);
 			uuid_copy(&__entry->region_uuid, &cxlr->params.uuid);
@@ -389,18 +409,26 @@ TRACE_EVENT(cxl_general_media,
 		}
 	),
 
-	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
-		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
-		"device=%x comp_id=%s validity_flags='%s' " \
-		"hpa=%llx region=%s region_uuid=%pUb",
-		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
+	CXL_EVT_TP_printk("dpa=0x%llx dpa_flags=0x%x " \
+		"descriptor='%s' type='%s' sub_type=0x%x " \
+		"transaction_type=0x%x channel=%u rank=%u " \
+		"device=0x%x validity_flags=0x%x " \
+		"comp_id=%s pldm_entity_id=%s pldm_resource_id=%s " \
+		"hpa=0x%llx region=%s region_uuid=%pUb " \
+		"cme_threshold_ev_flags=0x%x cme_count=0x%x ",
+		__entry->dpa, __entry->dpa_flags,
 		show_event_desc_flags(__entry->descriptor),
 		show_gmer_mem_event_type(__entry->type),
-		show_trans_type(__entry->transaction_type),
+		__entry->sub_type, __entry->transaction_type,
 		__entry->channel, __entry->rank, __entry->device,
+		__entry->validity_flags,
 		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
-		show_valid_flags(__entry->validity_flags),
-		__entry->hpa, __get_str(region_name), &__entry->region_uuid
+		show_pldm_entity_id(__entry->validity_flags, CXL_GMER_VALID_COMPONENT,
+				    CXL_GMER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
+		show_pldm_resource_id(__entry->validity_flags, CXL_GMER_VALID_COMPONENT,
+				      CXL_GMER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
+		__entry->hpa, __get_str(region_name), &__entry->region_uuid,
+		__entry->cme_threshold_ev_flags, __entry->cme_count
 	)
 );
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index e1d485ad376b..2b07adf39010 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -45,14 +45,17 @@ struct cxl_event_generic {
 
 /*
  * General Media Event Record
- * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ * CXL rev 3.1 Section 8.2.9.2.1.1; Table 8-45
  */
 #define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
 struct cxl_event_gen_media {
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
2.43.0

