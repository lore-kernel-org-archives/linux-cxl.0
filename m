Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9AA198838;
	Tue, 22 Oct 2024 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594760; cv=none; b=J+jlIxrBbpOWhq1THByp67AEKjVZP0Z6gWSYF0DnB7qQHKpUlVMLMhkc22Ku0Tq4icIhvEhfJVNqh3fZ1ig+N8o0XYYfBhfqfyPet7AY6XXyBxjaKSLOarN3Xf0hJNlAVPdE3XaA2vrtZtJM2PBQPi8T48u3HyKXU2J5HIo8qbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594760; c=relaxed/simple;
	bh=77yUUqtS5qwAKpLQsFr8XruHvpn3wC9iSU2mQKXm8To=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElEcmcDZO4yD1AlxpfyZjzoQVoh6/V2/InKruU2icmWC69b7+AFMltr0ejN+9nOzhgUr6kL5MoEqKEsbq+ZIUD1l2PHfg3YQNiLFXUD5bPctrgrsf36dcyb0ykgF7Sd3XyG4QJIVFoM8u3DKWDyr+i31pQCF1F+AKLdIvivAC0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XXpz94Z2nz67K7y;
	Tue, 22 Oct 2024 18:57:09 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 52082140B30;
	Tue, 22 Oct 2024 18:59:09 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.246.16) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 12:59:08 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 1/6] cxl/events: Update Common Event Record to CXL spec rev 3.1
Date: Tue, 22 Oct 2024 11:58:44 +0100
Message-ID: <20241022105849.1272-2-shiju.jose@huawei.com>
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

CXL spec 3.1 section 8.2.9.2.1 Table 8-42, Common Event Record format has
updated with Maintenance Operation Subclass information.

Add updates for the above spec change in the CXL events record and CXL
common trace event implementations.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/trace.h | 13 +++++++++----
 include/cxl/event.h      |  3 ++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 8389a94adb1a..7305974e2301 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -166,11 +166,13 @@ TRACE_EVENT(cxl_overflow,
 #define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
 #define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
 #define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
+#define CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID	BIT(6)
 #define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
 	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"PERMANENT_CONDITION"		}, \
 	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"MAINTENANCE_NEEDED"		}, \
 	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"PERFORMANCE_DEGRADED"		}, \
-	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	}  \
+	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	},  \
+	{ CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID,	"MAINT_OP_SUB_CLASS_VALID" }	\
 )
 
 /*
@@ -197,7 +199,8 @@ TRACE_EVENT(cxl_overflow,
 	__field(u16, hdr_related_handle)			\
 	__field(u64, hdr_timestamp)				\
 	__field(u8, hdr_length)					\
-	__field(u8, hdr_maint_op_class)
+	__field(u8, hdr_maint_op_class)				\
+	__field(u8, hdr_maint_op_sub_class)
 
 #define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
 	__assign_str(memdev);				\
@@ -209,17 +212,19 @@ TRACE_EVENT(cxl_overflow,
 	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
 	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
 	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
-	__entry->hdr_maint_op_class = (hdr).maint_op_class
+	__entry->hdr_maint_op_class = (hdr).maint_op_class;			\
+	__entry->hdr_maint_op_sub_class = (hdr).maint_op_sub_class
 
 #define CXL_EVT_TP_printk(fmt, ...) \
 	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
 		"len=%d flags='%s' handle=%x related_handle=%x "		\
-		"maint_op_class=%u : " fmt,					\
+		"maint_op_class=%u maint_op_sub_class=%u : " fmt,		\
 		__get_str(memdev), __get_str(host), __entry->serial,		\
 		cxl_event_log_type_str(__entry->log),				\
 		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
 		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
 		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
+		__entry->hdr_maint_op_sub_class,	\
 		##__VA_ARGS__)
 
 TRACE_EVENT(cxl_generic_event,
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 0bea1afbd747..e1d485ad376b 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -18,7 +18,8 @@ struct cxl_event_record_hdr {
 	__le16 related_handle;
 	__le64 timestamp;
 	u8 maint_op_class;
-	u8 reserved[15];
+	u8 maint_op_sub_class;
+	u8 reserved[14];
 } __packed;
 
 struct cxl_event_media_hdr {
-- 
2.34.1

