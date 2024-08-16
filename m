Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE43A1C0DD9;
	Fri, 16 Aug 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817325; cv=none; b=eNWDxaOpsdHEqpoKfJEKZsGvE4cyatPRSamt0MZVP/tBKEhoXVJH01gDUx8rrXT/1QFvxL/hI3+0zAgEUO4SbWyslioUyaLnX98IXJ90wXHYY8A1dN1GmBmDlfy2LwAxRhaZd3I74YWPIakaVBYJs04JzdYkr7ml/xS8B5qkXKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817325; c=relaxed/simple;
	bh=iqYi9qGKpsi4OQyYti2iKVMKe9GZTq7Nj4Xoy5LIsbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0uZ6WBpea1848ry3w4kHouPxSxxVUkkiM4JneuqrHiX2Qi/26jozk8jmvsgH0zIqp8OHLpF+Xvo93w5O+oeKRC75jsrfPUzv4u4e5/Iq6Z8yhbrRRvMCTu5mSkmK6G8Vad2L9sTez4sbcvWscJFM8pJG0DYsRrbc9NHuiVS2XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBPFJbbQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBPFJbbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817324; x=1755353324;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iqYi9qGKpsi4OQyYti2iKVMKe9GZTq7Nj4Xoy5LIsbs=;
  b=TBPFJbbQEXPMiE00LhZZ1t7/3wKVLdQd3yUwJpYzBf69zn1GSdsbcnoB
   FVVE8FcP/GBCf+RSEARvEL2yLArDCipDYwbimT72L9fngl6uEU2S8aNVH
   QAzAIB9bEfGbKzeNySAJ4h+EDAg4Lo1rriQMB1Vs3zrKSHdWRGuZHv+d0
   HsZxRgwZ7bvDgc19hEMR/wW0Zz0b6QTD7+V7n8I27sf7TP0jUUyTlDV/1
   gFh3uHIVUc6z9oGscxiE/S6BqrtUYKx8paVLE7XamhcTNsbfw5t8wEYoP
   kMHKvuz1fB0V6/rIWOregcglwSx7k5LCsgtmbanT6TP9qDx9AlVUgjRBx
   w==;
X-CSE-ConnectionGUID: gy/+ewHtTmaWy4poI81AVg==
X-CSE-MsgGUID: u4YN8rCYRVyFCNudJJfhag==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22085305"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22085305"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:44 -0700
X-CSE-ConnectionGUID: ed7KPw+SS8+JW2zSKxbX9Q==
X-CSE-MsgGUID: IX6xieblTj+10ZR+3nE3IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64571661"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:42 -0700
From: ira.weiny@intel.com
Date: Fri, 16 Aug 2024 09:08:20 -0500
Subject: [PATCH RESEND v2 15/18] cxl/mem: Trace Dynamic capacity Event
 Record
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-15-b4044aadf2bd@intel.com>
References: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Navneet Singh <navneet.singh@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723817288; l=3471;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=btVbiwQ2WtrSPeA40kJolneVn+Xb13ZFysp+2MD41iM=;
 b=+Yzp3uQiwuAJVqveRVoNIKrZ6Ayuc3xYtCV4149AsyAopQ+vhzA3kdtAjfmBoLT6zwa1+F3co
 nvAzYCCpJu4D6/ID4I1CDYCR2ID+aYRHMO1wVzsd6gblkw4C5aC3X7M
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

CXL rev 3.0 section 8.2.9.2.1.5 defines the Dynamic Capacity Event Record
Determine if the event read is a Dynamic capacity event record and
if so trace the record for the debug purpose.

Add DC trace points to the trace log.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
[iweiny: fixups]
---
 drivers/cxl/core/mbox.c  |  5 ++++
 drivers/cxl/core/trace.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9d9c13e13ecf..9462c34aa1dc 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -939,6 +939,11 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 				(struct cxl_event_mem_module *)record;
 
 		trace_cxl_memory_module(cxlmd, type, rec);
+	} else if (uuid_equal(id, &dc_event_uuid)) {
+		struct dcd_event_dyn_cap *rec =
+				(struct dcd_event_dyn_cap *)record;
+
+		trace_cxl_dynamic_capacity(cxlmd, type, rec);
 	} else {
 		/* For unknown record types print just the header */
 		trace_cxl_generic_event(cxlmd, type, record);
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a0b5819bc70b..1899c5cc96b9 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -703,6 +703,71 @@ TRACE_EVENT(cxl_poison,
 	)
 );
 
+/*
+ * DYNAMIC CAPACITY Event Record - DER
+ *
+ * CXL rev 3.0 section 8.2.9.2.1.5 Table 8-47
+ */
+
+#define CXL_DC_ADD_CAPACITY			0x00
+#define CXL_DC_REL_CAPACITY			0x01
+#define CXL_DC_FORCED_REL_CAPACITY		0x02
+#define CXL_DC_REG_CONF_UPDATED			0x03
+#define show_dc_evt_type(type)	__print_symbolic(type,		\
+	{ CXL_DC_ADD_CAPACITY,	"Add capacity"},		\
+	{ CXL_DC_REL_CAPACITY,	"Release capacity"},		\
+	{ CXL_DC_FORCED_REL_CAPACITY,	"Forced capacity release"},	\
+	{ CXL_DC_REG_CONF_UPDATED,	"Region Configuration Updated"	} \
+)
+
+TRACE_EVENT(cxl_dynamic_capacity,
+
+	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
+		 struct dcd_event_dyn_cap  *rec),
+
+	TP_ARGS(cxlmd, log, rec),
+
+	TP_STRUCT__entry(
+		CXL_EVT_TP_entry
+
+		/* Dynamic capacity Event */
+		__field(u8, event_type)
+		__field(u16, hostid)
+		__field(u8, region_id)
+		__field(u64, dpa_start)
+		__field(u64, length)
+		__array(u8, tag, CXL_DC_EXTENT_TAG_LEN)
+		__field(u16, sh_extent_seq)
+	),
+
+	TP_fast_assign(
+		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+
+		/* Dynamic_capacity Event */
+		__entry->event_type = rec->data.event_type;
+
+		/* DCD event record data */
+		__entry->hostid = le16_to_cpu(rec->data.host_id);
+		__entry->region_id = rec->data.region_index;
+		__entry->dpa_start = le64_to_cpu(rec->data.extent.start_dpa);
+		__entry->length = le64_to_cpu(rec->data.extent.length);
+		memcpy(__entry->tag, &rec->data.extent.tag, CXL_DC_EXTENT_TAG_LEN);
+		__entry->sh_extent_seq = le16_to_cpu(rec->data.extent.shared_extn_seq);
+	),
+
+	CXL_EVT_TP_printk("event_type='%s' host_id='%d' region_id='%d' " \
+		"starting_dpa=%llx length=%llx tag=%s " \
+		"shared_extent_sequence=%d",
+		show_dc_evt_type(__entry->event_type),
+		__entry->hostid,
+		__entry->region_id,
+		__entry->dpa_start,
+		__entry->length,
+		__print_hex(__entry->tag, CXL_DC_EXTENT_TAG_LEN),
+		__entry->sh_extent_seq
+	)
+);
+
 #endif /* _CXL_EVENTS_H */
 
 #define TRACE_INCLUDE_FILE trace

-- 
2.45.2

