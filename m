Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F5C212EF9;
	Wed, 16 Oct 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096470; cv=none; b=fnMpPC7RRp0GeE1ZfOtgsbfT2FDpLpwFrW7ILPHjIRCbLLdZS6e8aKBWPr54i2KZlySGUB/nwrX409oRHy2oJmmzwWVJiY2QccCjT3tq58v1khqPTdNfGhzjS8Vx5ioXVOQq2Y4A+UX6yevpJ2vi3awWuXHeeUYIYu4q/S0+Srw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096470; c=relaxed/simple;
	bh=dHzs/QnRReAbZIRMGawvbaWH1HjGnyWPITuLKP0SIVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ino6pZkkmea4fcFokaPM60tq1/kAQqd72F/nH/tV7WV7FZh0nvLyRfjjrhj0L/XyiYZlsGHTEIyADFWs6CRn0SMSSjopeHtwVSUdsDse2my4uit/9gDs+cHLmSyC0j2JvYpIuLktYTfzZZ6ytVeB5zDagCHXu3MdK8Wk7dz5+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTGkJ6cLYz67vyB;
	Thu, 17 Oct 2024 00:33:44 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id A850F1400DB;
	Thu, 17 Oct 2024 00:34:22 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.158.191) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 18:34:21 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 4/4] cxl/events: Updates for CXL Memory Module Event Record
Date: Wed, 16 Oct 2024 17:33:49 +0100
Message-ID: <20241016163349.1210-5-shiju.jose@huawei.com>
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

CXL spec 3.1 section 8.2.9.2.1.3 Table 8-47, Memory Module Event Record
has updated with following new fields and new info for Device Event Type
and Device Health Information fields.
1. Validity Flags
2. Component Identifier
3. Device Event Sub-Type

Add updates for the above spec changes in the CXL events record and CXL
Memory Module trace event implementations.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/trace.h | 48 +++++++++++++++++++++++++++++++++++-----
 include/cxl/event.h      |  5 ++++-
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 20790dffa2b4..1ce43bff49c7 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -613,7 +613,7 @@ TRACE_EVENT(cxl_dram,
 /*
  * Memory Module Event Record - MMER
  *
- * CXL res 3.0 section 8.2.9.2.1.3; Table 8-45
+ * CXL res 3.1 section 8.2.9.2.1.3; Table 8-47
  */
 #define CXL_MMER_HEALTH_STATUS_CHANGE		0x00
 #define CXL_MMER_MEDIA_STATUS_CHANGE		0x01
@@ -621,27 +621,35 @@ TRACE_EVENT(cxl_dram,
 #define CXL_MMER_TEMP_CHANGE			0x03
 #define CXL_MMER_DATA_PATH_ERROR		0x04
 #define CXL_MMER_LSA_ERROR			0x05
+#define CXL_MMER_UNRECOV_SIDEBAND_BUS_ERROR	0x06
+#define CXL_MMER_MEMORY_MEDIA_FRU_ERROR		0x07
+#define CXL_MMER_POWER_MANAGEMENT_FAULT		0x08
 #define show_dev_evt_type(type)	__print_symbolic(type,			   \
 	{ CXL_MMER_HEALTH_STATUS_CHANGE,	"Health Status Change"	}, \
 	{ CXL_MMER_MEDIA_STATUS_CHANGE,		"Media Status Change"	}, \
 	{ CXL_MMER_LIFE_USED_CHANGE,		"Life Used Change"	}, \
 	{ CXL_MMER_TEMP_CHANGE,			"Temperature Change"	}, \
 	{ CXL_MMER_DATA_PATH_ERROR,		"Data Path Error"	}, \
-	{ CXL_MMER_LSA_ERROR,			"LSA Error"		}  \
+	{ CXL_MMER_LSA_ERROR,			"LSA Error"		}, \
+	{ CXL_MMER_UNRECOV_SIDEBAND_BUS_ERROR,	"Unrecoverable Internal Sideband Bus Error"	}, \
+	{ CXL_MMER_MEMORY_MEDIA_FRU_ERROR,	"Memory Media FRU Error"	}, \
+	{ CXL_MMER_POWER_MANAGEMENT_FAULT,	"Power Management Fault"	}  \
 )
 
 /*
  * Device Health Information - DHI
  *
- * CXL res 3.0 section 8.2.9.8.3.1; Table 8-100
+ * CXL res 3.1 section 8.2.9.9.3.1; Table 8-133
  */
 #define CXL_DHI_HS_MAINTENANCE_NEEDED				BIT(0)
 #define CXL_DHI_HS_PERFORMANCE_DEGRADED				BIT(1)
 #define CXL_DHI_HS_HW_REPLACEMENT_NEEDED			BIT(2)
+#define CXL_DHI_HS_MEM_CAPACITY_DEGRADED			BIT(3)
 #define show_health_status_flags(flags)	__print_flags(flags, "|",	   \
 	{ CXL_DHI_HS_MAINTENANCE_NEEDED,	"MAINTENANCE_NEEDED"	}, \
 	{ CXL_DHI_HS_PERFORMANCE_DEGRADED,	"PERFORMANCE_DEGRADED"	}, \
-	{ CXL_DHI_HS_HW_REPLACEMENT_NEEDED,	"REPLACEMENT_NEEDED"	}  \
+	{ CXL_DHI_HS_HW_REPLACEMENT_NEEDED,	"REPLACEMENT_NEEDED"	}, \
+	{ CXL_DHI_HS_MEM_CAPACITY_DEGRADED,	"MEM_CAPACITY_DEGRADED"	}  \
 )
 
 #define CXL_DHI_MS_NORMAL							0x00
@@ -695,6 +703,22 @@ TRACE_EVENT(cxl_dram,
 #define CXL_DHI_AS_COR_VOL_ERR_CNT(as)			((as & 0x10) >> 4)
 #define CXL_DHI_AS_COR_PER_ERR_CNT(as)			((as & 0x20) >> 5)
 
+#define CXL_MMER_VALID_COMPONENT			BIT(0)
+#define CXL_MMER_VALID_COMPONENT_ID_FORMAT		BIT(1)
+#define show_mem_module_valid_flags(flags)	__print_flags(flags, "|",	\
+	{ CXL_MMER_VALID_COMPONENT,	"COMPONENT"	}			\
+)
+#define CXL_MMER_DEV_EVT_SUB_TYPE_NOT_REPORTED			0x00
+#define CXL_MMER_DEV_EVT_SUB_TYPE_INVALID_CONFIG_DATA		0x01
+#define CXL_MMER_DEV_EVT_SUB_TYPE_UNSUPP_CONFIG_DATA		0x02
+#define CXL_MMER_DEV_EVT_SUB_TYPE_UNSUPP_MEM_MEDIA_FRU		0x03
+#define show_dev_event_sub_type(sub_type)	__print_symbolic(sub_type,	  \
+	{ CXL_MMER_DEV_EVT_SUB_TYPE_NOT_REPORTED,		"Not Reported" }, \
+	{ CXL_MMER_DEV_EVT_SUB_TYPE_INVALID_CONFIG_DATA,	"Invalid Config Data" }, \
+	{ CXL_MMER_DEV_EVT_SUB_TYPE_UNSUPP_CONFIG_DATA,		"Unsupported Config Data" }, \
+	{ CXL_MMER_DEV_EVT_SUB_TYPE_UNSUPP_MEM_MEDIA_FRU,	"Unsupported Memory Media FRU" } \
+)
+
 TRACE_EVENT(cxl_memory_module,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
@@ -717,6 +741,9 @@ TRACE_EVENT(cxl_memory_module,
 		__field(u32, cor_per_err_cnt)
 		__field(s16, device_temp)
 		__field(u8, add_status)
+		__field(u16, validity_flags)
+		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
+		__field(u8, sub_type)
 	),
 
 	TP_fast_assign(
@@ -735,12 +762,17 @@ TRACE_EVENT(cxl_memory_module,
 		__entry->cor_per_err_cnt = get_unaligned_le32(rec->info.cor_per_err_cnt);
 		__entry->device_temp = get_unaligned_le16(rec->info.device_temp);
 		__entry->add_status = rec->info.add_status;
+		__entry->validity_flags = get_unaligned_le16(rec->validity_flags);
+		memcpy(__entry->comp_id, &rec->component_id,
+		       CXL_EVENT_GEN_MED_COMP_ID_SIZE);
+		__entry->sub_type = rec->sub_type;
 	),
 
 	CXL_EVT_TP_printk("event_type='%s' health_status='%s' media_status='%s' " \
 		"as_life_used=%s as_dev_temp=%s as_cor_vol_err_cnt=%s " \
 		"as_cor_per_err_cnt=%s life_used=%u device_temp=%d " \
-		"dirty_shutdown_cnt=%u cor_vol_err_cnt=%u cor_per_err_cnt=%u",
+		"dirty_shutdown_cnt=%u cor_vol_err_cnt=%u cor_per_err_cnt=%u " \
+		"validity_flags='%s' comp_id=%s sub_type='%s'",
 		show_dev_evt_type(__entry->event_type),
 		show_health_status_flags(__entry->health_status),
 		show_media_status(__entry->media_status),
@@ -750,7 +782,11 @@ TRACE_EVENT(cxl_memory_module,
 		show_one_bit_status(CXL_DHI_AS_COR_PER_ERR_CNT(__entry->add_status)),
 		__entry->life_used, __entry->device_temp,
 		__entry->dirty_shutdown_cnt, __entry->cor_vol_err_cnt,
-		__entry->cor_per_err_cnt
+		__entry->cor_per_err_cnt,
+		show_mem_module_valid_flags(__entry->validity_flags),
+		cxl_print_component_id(__entry->validity_flags, CXL_MMER_VALID_COMPONENT,
+				       CXL_MMER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
+		show_dev_event_sub_type(__entry->sub_type)
 	)
 );
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 7e98492c85df..18b7f96dea77 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -102,7 +102,10 @@ struct cxl_event_mem_module {
 	struct cxl_event_record_hdr hdr;
 	u8 event_type;
 	struct cxl_get_health_info info;
-	u8 reserved[0x3d];
+	u8 validity_flags[2];
+	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+	u8 sub_type;
+	u8 reserved[0x2a];
 } __packed;
 
 union cxl_event {
-- 
2.34.1

