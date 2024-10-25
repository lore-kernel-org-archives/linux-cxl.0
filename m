Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3191202F63;
	Fri, 25 Oct 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856796; cv=none; b=nkTVt+HdZkXDvIv6PuhyASKBfZQcr6PtJnEOaBor54tDz4lAyl+scPauwLdobWWcOwHFjzJbDmSyd+BLLIo5CajcQJ5Iqk4jdbQ/T3kFLHqReDVpj4/ABtJSH/Jwi806fBei3ZKckYc0qJdWbJMuAh7juMUa4YQyrDFXk+I0uMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856796; c=relaxed/simple;
	bh=DT17qkYZ7c9sEgD4IcotLR0Qu/qMGk8tAvhzy3NsXKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EaqT5/bLe5w6yVwd5aktvlDcWgy4ashVfmDAaMXFdKDoyuLLRgTLga0lxok1P2AW4r52HTzsweV1zeXcfmEzNPhOIsusJJP3r7XKmrBAIojXFdf8MbU74QrtNnX3mW6ZXC52f54cUC2QxqKCLFOoPlmXhpbxuO1vJWylEQoeKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZgqJ1J9lz6LD3Y;
	Fri, 25 Oct 2024 19:41:48 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B8F01400F4;
	Fri, 25 Oct 2024 19:46:31 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.104) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 13:46:30 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 5/6] cxl/events: Update Memory Module Event Record to CXL spec rev 3.1
Date: Fri, 25 Oct 2024 12:45:54 +0100
Message-ID: <20241025114555.1363-6-shiju.jose@huawei.com>
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

CXL spec 3.1 section 8.2.9.2.1.3 Table 8-47, Memory Module Event Record
has updated with following new fields and new info for Device Event Type
and Device Health Information fields.
1. Validity Flags
2. Component Identifier
3. Device Event Sub-Type

Update the Memory Module event record and Memory Module trace event for
the above spec changes. The new fields are inserted in logical places.

Example of cxl_memory_module trace event,

cxl_memory_module: memdev=mem3 host=0000:0f:00.0 serial=3 log=Fatal : \
time=371709344709 uuid=fe927475-dd59-4339-a586-79bab113b774 len=128 \
flags='0x1' handle=2 related_handle=0 maint_op_class=0 \
maint_op_sub_class=0 : event_type='Temperature Change' \
event_sub_type='Unsupported Config Data' \
health_status='MAINTENANCE_NEEDED|REPLACEMENT_NEEDED' \
media_status='All Data Loss in Event of Power Loss' as_life_used=0x3 \
as_dev_temp=Normal as_cor_vol_err_cnt=Normal as_cor_per_err_cnt=Normal \
life_used=8 device_temp=3 dirty_shutdown_cnt=33 cor_vol_err_cnt=25 \
cor_per_err_cnt=45 validity_flags='COMPONENT|COMPONENT PLDM FORMAT' \
comp_id=03 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
comp_id_pldm_valid_flags='Resource ID' \
pldm_entity_id=0x00 pldm_resource_id=fc d2 7e 2f

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/trace.h | 62 ++++++++++++++++++++++++++++++++++------
 include/cxl/event.h      |  5 +++-
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 6f201ad93388..d51ac4b9c53b 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -630,7 +630,7 @@ TRACE_EVENT(cxl_dram,
 /*
  * Memory Module Event Record - MMER
  *
- * CXL res 3.0 section 8.2.9.2.1.3; Table 8-45
+ * CXL res 3.1 section 8.2.9.2.1.3; Table 8-47
  */
 #define CXL_MMER_HEALTH_STATUS_CHANGE		0x00
 #define CXL_MMER_MEDIA_STATUS_CHANGE		0x01
@@ -638,27 +638,35 @@ TRACE_EVENT(cxl_dram,
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
@@ -712,6 +720,26 @@ TRACE_EVENT(cxl_dram,
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
@@ -724,6 +752,7 @@ TRACE_EVENT(cxl_memory_module,
 
 		/* Memory Module Event */
 		__field(u8, event_type)
+		__field(u8, event_sub_type)
 
 		/* Device Health Info */
 		__field(u8, health_status)
@@ -734,6 +763,8 @@ TRACE_EVENT(cxl_memory_module,
 		__field(u32, cor_per_err_cnt)
 		__field(s16, device_temp)
 		__field(u8, add_status)
+		__field(u16, validity_flags)
+		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
 	),
 
 	TP_fast_assign(
@@ -742,6 +773,7 @@ TRACE_EVENT(cxl_memory_module,
 
 		/* Memory Module Event */
 		__entry->event_type = rec->event_type;
+		__entry->event_sub_type = rec->event_sub_type;
 
 		/* Device Health Info */
 		__entry->health_status = rec->info.health_status;
@@ -752,13 +784,20 @@ TRACE_EVENT(cxl_memory_module,
 		__entry->cor_per_err_cnt = get_unaligned_le32(rec->info.cor_per_err_cnt);
 		__entry->device_temp = get_unaligned_le16(rec->info.device_temp);
 		__entry->add_status = rec->info.add_status;
+		__entry->validity_flags = get_unaligned_le16(rec->validity_flags);
+		memcpy(__entry->comp_id, &rec->component_id,
+		       CXL_EVENT_GEN_MED_COMP_ID_SIZE);
 	),
 
-	CXL_EVT_TP_printk("event_type='%s' health_status='%s' media_status='%s' " \
-		"as_life_used=%s as_dev_temp=%s as_cor_vol_err_cnt=%s " \
+	CXL_EVT_TP_printk("event_type='%s' event_sub_type='%s' health_status='%s' " \
+		"media_status='%s' as_life_used=%s as_dev_temp=%s as_cor_vol_err_cnt=%s " \
 		"as_cor_per_err_cnt=%s life_used=%u device_temp=%d " \
-		"dirty_shutdown_cnt=%u cor_vol_err_cnt=%u cor_per_err_cnt=%u",
+		"dirty_shutdown_cnt=%u cor_vol_err_cnt=%u cor_per_err_cnt=%u " \
+		"validity_flags='%s' " \
+		"comp_id=%s comp_id_pldm_valid_flags='%s' " \
+		"pldm_entity_id=%s pldm_resource_id=%s ",
 		show_dev_evt_type(__entry->event_type),
+		show_dev_event_sub_type(__entry->event_sub_type),
 		show_health_status_flags(__entry->health_status),
 		show_media_status(__entry->media_status),
 		show_two_bit_status(CXL_DHI_AS_LIFE_USED(__entry->add_status)),
@@ -767,7 +806,14 @@ TRACE_EVENT(cxl_memory_module,
 		show_one_bit_status(CXL_DHI_AS_COR_PER_ERR_CNT(__entry->add_status)),
 		__entry->life_used, __entry->device_temp,
 		__entry->dirty_shutdown_cnt, __entry->cor_vol_err_cnt,
-		__entry->cor_per_err_cnt
+		__entry->cor_per_err_cnt,
+		show_mem_module_valid_flags(__entry->validity_flags),
+		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
+		show_comp_id_pldm_flags(__entry->comp_id[0]),
+		show_pldm_entity_id(__entry->validity_flags, CXL_MMER_VALID_COMPONENT,
+				    CXL_MMER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id),
+		show_pldm_resource_id(__entry->validity_flags, CXL_MMER_VALID_COMPONENT,
+				      CXL_MMER_VALID_COMPONENT_ID_FORMAT, __entry->comp_id)
 	)
 );
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 7e98492c85df..8ee93e146b5b 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -102,7 +102,10 @@ struct cxl_event_mem_module {
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
2.34.1

