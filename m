Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB77188717;
	Wed, 20 Nov 2024 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095491; cv=none; b=Psj+0hsbSwCaBBUe7xF926Bc0AE3/ZOgH5hLz5l9fflNIZ3iakHTMJAJdCvh2gXuQ6N7MmzJ4MrfC+oETOk9MQRBiiv2FdwUblDzG+rPikbpgVi3veU8dxoNnGtqqYHL1pqBqmAxotXM4iL/kfST85PL5qknCL2uB7qlqq4wah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095491; c=relaxed/simple;
	bh=g91HaH96WJrh7HYTPA6vsZuyIJ2IY3G9XSdIirg6md0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hpt4oBmmvTYVjdsh/NNqjCUONaJn7aqybHSMRL/8CL4Uor9jRyteSX92TRgoMARsFTTiLGaAJBl1xRnz9toAqslD8LJX4CoXA2PrtWzq9sjYreAAJK15UrBxZg1fN0ZnHZN6dD5zBzY8808PTB5/5mMK9qHlpq6CZzK7H3Yq23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtbmQ6D6qz6K6CH;
	Wed, 20 Nov 2024 17:34:30 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CF95140AB8;
	Wed, 20 Nov 2024 17:38:01 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.247.212) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 10:38:00 +0100
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v4 5/6] cxl/events: Update Memory Module Event Record to CXL spec rev 3.1
Date: Wed, 20 Nov 2024 09:37:44 +0000
Message-ID: <20241120093745.1847-6-shiju.jose@huawei.com>
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

CXL spec 3.1 section 8.2.9.2.1.3 Table 8-47, Memory Module Event Record
has updated with following new fields and new info for Device Event Type
and Device Health Information fields.
1. Validity Flags
2. Component Identifier
3. Device Event Sub-Type

Update the Memory Module event record and Memory Module trace event for
the above spec changes. The new fields are inserted in logical places.

Example trace print of cxl_memory_module trace event,

cxl_memory_module: memdev=mem0 host=0000:0f:00.0 serial=3 log=Fatal : \
time=46654654941 uuid=fe927475-dd59-4339-a586-79bab113b774 len=128 \
flags='0x1' handle=1 related_handle=0 maint_op_class=0 \
maint_op_sub_class=1 : event_type='Temperature Change' event_sub_type=0x2 \
health_status=0x5 media_status=0x7 as_life_used=0x3 as_dev_temp=Normal \
as_cor_vol_err_cnt=Normal as_cor_per_err_cnt=Normal life_used=8 \
device_temp=3 dirty_shutdown_cnt=33 cor_vol_err_cnt=25 cor_per_err_cnt=45 \
validity_flags=0x3 comp_id=02 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
pldm_entity_id=0x00 pldm_resource_id=fc d2 7e 2f

The number of decoded strings in TP_printk() cause parsing error when
libtraceevent in userspace parses the CXL memory module trace event for
rasdaemon. It was found that long decoded strings of field values in the
TP_printk() caused the issue. As a solution, decoding of some of the
fields in the TP_printk() were removed to accommodate the new fields.
Decoding of all these fields is added in the userspace tool rasdaemon.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/trace.h | 63 +++++++++++++++++++++++++++++++++-------
 include/cxl/event.h      |  9 ++++--
 2 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index f4f3d49166cd..d0b8f35ae09f 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -582,7 +582,7 @@ TRACE_EVENT(cxl_dram,
 /*
  * Memory Module Event Record - MMER
  *
- * CXL res 3.0 section 8.2.9.2.1.3; Table 8-45
+ * CXL res 3.1 section 8.2.9.2.1.3; Table 8-47
  */
 #define CXL_MMER_HEALTH_STATUS_CHANGE		0x00
 #define CXL_MMER_MEDIA_STATUS_CHANGE		0x01
@@ -590,27 +590,35 @@ TRACE_EVENT(cxl_dram,
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
@@ -664,6 +672,26 @@ TRACE_EVENT(cxl_dram,
 #define CXL_DHI_AS_COR_VOL_ERR_CNT(as)			((as & 0x10) >> 4)
 #define CXL_DHI_AS_COR_PER_ERR_CNT(as)			((as & 0x20) >> 5)
 
+#define CXL_MMER_VALID_COMPONENT			BIT(0)
+#define CXL_MMER_VALID_COMPONENT_ID_FORMAT		BIT(1)
+#define show_mem_module_valid_flags(flags)	__print_flags(flags, "|",	\
+	{ CXL_MMER_VALID_COMPONENT,		"COMPONENT" },			\
+	{ CXL_MMER_VALID_COMPONENT_ID_FORMAT,	"COMPONENT PLDM FORMAT"	}	\
+)
+#define CXL_MMER_DEV_EVT_SUB_TYPE_NOT_REPORTED			0x00
+#define CXL_MMER_DEV_EVT_SUB_TYPE_INVALID_CONFIG_DATA		0x01
+#define CXL_MMER_DEV_EVT_SUB_TYPE_UNSUPP_CONFIG_DATA		0x02
+#define CXL_MMER_DEV_EVT_SUB_TYPE_UNSUPP_MEM_MEDIA_FRU		0x03
+#define show_dev_event_sub_type(sub_type)	__print_symbolic(sub_type,			\
+	{ CXL_MMER_DEV_EVT_SUB_TYPE_NOT_REPORTED,		"Not Reported" },		\
+	{ CXL_MMER_DEV_EVT_SUB_TYPE_INVALID_CONFIG_DATA,	"Invalid Config Data" },	\
+	{ CXL_MMER_DEV_EVT_SUB_TYPE_UNSUPP_CONFIG_DATA,		"Unsupported Config Data" },	\
+	{											\
+		CXL_MMER_DEV_EVT_SUB_TYPE_UNSUPP_MEM_MEDIA_FRU,					\
+		"Unsupported Memory Media FRU"							\
+	}											\
+)
+
 TRACE_EVENT(cxl_memory_module,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
@@ -676,6 +704,7 @@ TRACE_EVENT(cxl_memory_module,
 
 		/* Memory Module Event */
 		__field(u8, event_type)
+		__field(u8, event_sub_type)
 
 		/* Device Health Info */
 		__field(u8, health_status)
@@ -686,6 +715,8 @@ TRACE_EVENT(cxl_memory_module,
 		__field(u32, cor_per_err_cnt)
 		__field(s16, device_temp)
 		__field(u8, add_status)
+		__field(u16, validity_flags)
+		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
 	),
 
 	TP_fast_assign(
@@ -694,6 +725,7 @@ TRACE_EVENT(cxl_memory_module,
 
 		/* Memory Module Event */
 		__entry->event_type = rec->event_type;
+		__entry->event_sub_type = rec->event_sub_type;
 
 		/* Device Health Info */
 		__entry->health_status = rec->info.health_status;
@@ -704,22 +736,31 @@ TRACE_EVENT(cxl_memory_module,
 		__entry->cor_per_err_cnt = get_unaligned_le32(rec->info.cor_per_err_cnt);
 		__entry->device_temp = get_unaligned_le16(rec->info.device_temp);
 		__entry->add_status = rec->info.add_status;
+		__entry->validity_flags = get_unaligned_le16(rec->validity_flags);
+		memcpy(__entry->comp_id, &rec->component_id,
+		       CXL_EVENT_GEN_MED_COMP_ID_SIZE);
 	),
 
-	CXL_EVT_TP_printk("event_type='%s' health_status='%s' media_status='%s' " \
-		"as_life_used=%s as_dev_temp=%s as_cor_vol_err_cnt=%s " \
+	CXL_EVT_TP_printk("event_type='%s' event_sub_type=0x%x health_status=0x%x " \
+		"media_status=0x%x as_life_used=%s as_dev_temp=%s as_cor_vol_err_cnt=%s " \
 		"as_cor_per_err_cnt=%s life_used=%u device_temp=%d " \
-		"dirty_shutdown_cnt=%u cor_vol_err_cnt=%u cor_per_err_cnt=%u",
-		show_dev_evt_type(__entry->event_type),
-		show_health_status_flags(__entry->health_status),
-		show_media_status(__entry->media_status),
+		"dirty_shutdown_cnt=%u cor_vol_err_cnt=%u cor_per_err_cnt=%u " \
+		"validity_flags=0x%x " \
+		"comp_id=%s pldm_entity_id=%s pldm_resource_id=%s ",
+		show_dev_evt_type(__entry->event_type), __entry->event_sub_type,
+		__entry->health_status, __entry->media_status,
 		show_two_bit_status(CXL_DHI_AS_LIFE_USED(__entry->add_status)),
 		show_two_bit_status(CXL_DHI_AS_DEV_TEMP(__entry->add_status)),
 		show_one_bit_status(CXL_DHI_AS_COR_VOL_ERR_CNT(__entry->add_status)),
 		show_one_bit_status(CXL_DHI_AS_COR_PER_ERR_CNT(__entry->add_status)),
 		__entry->life_used, __entry->device_temp,
 		__entry->dirty_shutdown_cnt, __entry->cor_vol_err_cnt,
-		__entry->cor_per_err_cnt
+		__entry->cor_per_err_cnt, __entry->validity_flags,
+		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
+		show_pldm_entity_id(__entry->validity_flags, CXL_MMER_VALID_COMPONENT,
+				    CXL_MMER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
+		show_pldm_resource_id(__entry->validity_flags, CXL_MMER_VALID_COMPONENT,
+				      CXL_MMER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id)
 	)
 );
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index dd85aa9beddf..f44c9487ca39 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -81,7 +81,7 @@ struct cxl_event_dram {
 
 /*
  * Get Health Info Record
- * CXL rev 3.0 section 8.2.9.8.3.1; Table 8-100
+ * CXL rev 3.1 section 8.2.9.9.3.1; Table 8-133
  */
 struct cxl_get_health_info {
 	u8 health_status;
@@ -96,13 +96,16 @@ struct cxl_get_health_info {
 
 /*
  * Memory Module Event Record
- * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
+ * CXL rev 3.1 section 8.2.9.2.1.3; Table 8-47
  */
 struct cxl_event_mem_module {
 	struct cxl_event_record_hdr hdr;
 	u8 event_type;
 	struct cxl_get_health_info info;
-	u8 reserved[0x3d];
+	u8 validity_flags[2];
+	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+	u8 event_sub_type;
+	u8 reserved[0x2a];
 } __packed;
 
 union cxl_event {
-- 
2.43.0

