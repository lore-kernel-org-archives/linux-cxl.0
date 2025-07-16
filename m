Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D3C2F3C25
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664871; cv=none; b=QnU7UqJwqNxukf0pWaMvSP0Cfl/2LSSOyBK1aqYDBM12ZkRkdiiljfAWsYM9ZdCLCQHEQkGzGqyQupJgfzExchZew3I/Frqw70eBaXhkZGWR9Pl2xs6GImFZHlOiIKM8poHNYZMxlc5mr1EorzpwRy2En6mqFIzkX7yoYP+rAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664871; c=relaxed/simple;
	bh=ikB4YVL0TDaJ7x0SfbK2D6Y8Nqoe4qv3nqJDoAiyzF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIasvso1SmiTWXz1f0Dsofl5lga3n6JEXlF3oG2ktucwUz+5gXZ4iXVWhgeCE0cKstreiU5blACTSTh3xysx72k9a9YSzdkVE1idglXRpwKuzCWli/0smyo5hvCR5JxqBeIugloS2+CYd+eQ9qPkjYPpKu+Wu63YzJp9bG0U7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhtr63dBZz6M4qV;
	Wed, 16 Jul 2025 19:19:50 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id CDCBD14033C;
	Wed, 16 Jul 2025 19:21:05 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.173.168) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Jul 2025 13:21:05 +0200
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
CC: <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 1/4] cxl/events: Update Common Event Record to CXL spec rev 3.2
Date: Wed, 16 Jul 2025 11:49:42 +0100
Message-ID: <20250716104945.2002-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250716104945.2002-1-shiju.jose@huawei.com>
References: <20250716104945.2002-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.2 section 8.2.10.2.1 Table 8-55, Common Event Record format
defined new fields LD-ID and Head ID.

LD-ID: ID of logical device from where the event originated, which is
valid only if LD-ID valid flag is set to 1.
CXL spec 3.2 Section 2.4 describes, a Type 3 Multi-Logical Device (MLD)
can partition its resources into up to 16 isolated Logical Devices.
Each Logical Device is identified by a Logical Device Identifier (LD-ID)
in CXL.mem and CXL.io protocols. LD-ID is a 16-bit Logical Device
identifier applicable for CXL.io and CXL.mem requests and responses.
CXL.mem supports only the lower 4 bits of LD-ID and therefore can support
up to 16 unique LD-ID values over the link. Requests and responses
forwarded over an MLD Port are tagged with LD-ID.

Head ID: ID of the device head, from where the event originated, which is
valid only if head valid flag is set to 1.

Add updates for the above spec changes in the CXL events record and CXL
common trace event implementation.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/trace.h | 18 ++++++++++++++----
 include/cxl/event.h      |  4 +++-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 25ebfbc1616c..a77487a257b3 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -214,12 +214,16 @@ TRACE_EVENT(cxl_overflow,
 #define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
 #define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
 #define CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID	BIT(6)
+#define CXL_EVENT_RECORD_FLAG_LD_ID_VALID	BIT(7)
+#define CXL_EVENT_RECORD_FLAG_HEAD_ID_VALID	BIT(8)
 #define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
 	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"PERMANENT_CONDITION"		}, \
 	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"MAINTENANCE_NEEDED"		}, \
 	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"PERFORMANCE_DEGRADED"		}, \
 	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	},  \
-	{ CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID,	"MAINT_OP_SUB_CLASS_VALID" }	\
+	{ CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID,	"MAINT_OP_SUB_CLASS_VALID" }, \
+	{ CXL_EVENT_RECORD_FLAG_LD_ID_VALID,	"LD_ID_VALID" }, \
+	{ CXL_EVENT_RECORD_FLAG_HEAD_ID_VALID,	"HEAD_ID_VALID" } \
 )
 
 /*
@@ -247,7 +251,9 @@ TRACE_EVENT(cxl_overflow,
 	__field(u64, hdr_timestamp)				\
 	__field(u8, hdr_length)					\
 	__field(u8, hdr_maint_op_class)				\
-	__field(u8, hdr_maint_op_sub_class)
+	__field(u8, hdr_maint_op_sub_class)			\
+	__field(u16, hdr_ld_id)					\
+	__field(u8, hdr_head_id)
 
 #define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
 	__assign_str(memdev);				\
@@ -260,18 +266,22 @@ TRACE_EVENT(cxl_overflow,
 	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
 	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
 	__entry->hdr_maint_op_class = (hdr).maint_op_class;			\
-	__entry->hdr_maint_op_sub_class = (hdr).maint_op_sub_class
+	__entry->hdr_maint_op_sub_class = (hdr).maint_op_sub_class;		\
+	__entry->hdr_ld_id = le16_to_cpu((hdr).ld_id);				\
+	__entry->hdr_head_id = (hdr).head_id
 
 #define CXL_EVT_TP_printk(fmt, ...) \
 	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
 		"len=%d flags='%s' handle=%x related_handle=%x "		\
-		"maint_op_class=%u maint_op_sub_class=%u : " fmt,		\
+		"maint_op_class=%u maint_op_sub_class=%u "			\
+		"ld_id=%x head_id=%x : " fmt,					\
 		__get_str(memdev), __get_str(host), __entry->serial,		\
 		cxl_event_log_type_str(__entry->log),				\
 		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
 		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
 		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
 		__entry->hdr_maint_op_sub_class,	\
+		__entry->hdr_ld_id, __entry->hdr_head_id,			\
 		##__VA_ARGS__)
 
 TRACE_EVENT(cxl_generic_event,
diff --git a/include/cxl/event.h b/include/cxl/event.h
index f9ae1796da85..f4cb8568566b 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -19,7 +19,9 @@ struct cxl_event_record_hdr {
 	__le64 timestamp;
 	u8 maint_op_class;
 	u8 maint_op_sub_class;
-	u8 reserved[14];
+	__le16 ld_id;
+	u8 head_id;
+	u8 reserved[11];
 } __packed;
 
 struct cxl_event_media_hdr {
-- 
2.43.0

