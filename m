Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C457219EB
	for <linux-cxl@vger.kernel.org>; Thu, 22 May 2025 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904421; cv=none; b=WGClETG5azBdi5d0TYNrapwN3O9/bwVvSHdH82WKYeylnbAdny4vywuxBssMAOy+ryqqEWLprIpxqJv7xh5wTxOItAfMHB7DtfaxoCsQ+3B1DwGhlbocKam7zutK50GpiEawuAl68bp01Ym/8GMVWoMnbieT3918M/KE5eN66AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904421; c=relaxed/simple;
	bh=dhgjP6Cm5vdP23PNuSsT5B/IfTsMxUyBsq38MkGHAuo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X2FKJvx3LM/QVF6WIOPeMHQx23dzZkPnM4D0VaIE9i4/ZlTQ4zS8JVHkeNHxEmVHbfQvNq/NO6EvDTAU+lgtjt5/0eZttjY0SzD+zX4aO0s6o02cnwgOnCRhFCpfL8rluAlcvEqLywue28JSNH6SEYGHsYknOc3cZhzVD2FXTjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b32Gf58q8z6DKp1;
	Thu, 22 May 2025 16:56:58 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id BD74C140119;
	Thu, 22 May 2025 17:00:12 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.154.113) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 May 2025 11:00:11 +0200
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <nifan.cxl@gmail.com>, <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 1/1] cxl/events: Update Common Event Record to CXL spec rev 3.2
Date: Thu, 22 May 2025 10:00:01 +0100
Message-ID: <20250522090002.831-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
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
Changes
=======
v1 -> v2
1. Feedback from Alison on v1
  https://lore.kernel.org/all/aCTq7IX49iLBiwJL@aschofie-mobl2.lan/
 - Update commit message to describe the new fields.
 - Removed a spurious change with HARDWARE_REPLACEMENT_NEEDED.
 - In CXL_EVT_TP_printk(), add __entry->hdr_ld_id and __entry->hdr_head_id
   to new line.  
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

