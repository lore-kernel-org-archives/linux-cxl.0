Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8609F1EF926;
	Tue,  5 Nov 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831978; cv=none; b=pwZ1QkisNIF7pkPQjMTKwkKe/XzaFYE36aSTF6s8txrPuu/LgZtubigEieajNScbRRwcxPdWMwBjrwr6Ii22R8ypOmQjLcYMITBzMBkaonq/I2521A4XhokG0G1wrRuziciZdQiJoQsbDd+WvtxhVbYv1VdMTHTJ/Tk7LGJxc10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831978; c=relaxed/simple;
	bh=69kpvMo/qqrfJKCdLHRA+0wnbBiTg0aMGLtWRtXCDdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+Q4XWa2fj3MgfCJy1HP6fdiAfvIiWEC0JW6gmwGbZpVia7cw8Fiu/xnWyOiiQAfN9Qa0vDBEIAszwE1ieeCZM9oYshb53HuIT1harUXPR6BqvkNz2k0/kXKl8MObuNIcJ0GUxxerEbBdUqSz4gluLiErfuAIsJDnQiPFVoA8mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5jb5S/e; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5jb5S/e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730831976; x=1762367976;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=69kpvMo/qqrfJKCdLHRA+0wnbBiTg0aMGLtWRtXCDdw=;
  b=c5jb5S/e59osl+XSGvLuCgCtnyILVewlVVuUVH253G9DfP6FdUxcN/3P
   6jJnfWipnVPd1gy405jcMH3E+lpjkaE66dpVndljmWH5z8mlmoyYVla5u
   YP7Royq/Fz3Dvy92+UgNAoGl2IFkk6e2/UBXaKqzD4wrFf6md7eFhk9m/
   DYR/OYuT6nOp3ffTK3bat0nA4CIvCbkyQzGlts51iCKsMEeEMxukh40A+
   zZUP3gJuL7c15OPXmpioIx6f+ui0yCJ8nlqOmj+XEOR50BnD0OJDRGFjF
   3gKKYsn9MfbIxLvzWH1i4iyR/Xuv8tpUtqEK57nGZTbkboa2PMshpVwbc
   w==;
X-CSE-ConnectionGUID: tnkCTAldRyGvKmVA3CySBA==
X-CSE-MsgGUID: asK1T5DBRRucXiGRhfnWiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30771343"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30771343"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:39:35 -0800
X-CSE-ConnectionGUID: t/SNS49PRPWFdMvOgHekEA==
X-CSE-MsgGUID: j3P0tCC9SLuotkzsVdbORw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="88916719"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO localhost) ([10.125.109.247])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:39:33 -0800
From: ira.weiny@intel.com
Date: Tue, 05 Nov 2024 12:38:47 -0600
Subject: [PATCH v6 25/27] cxl/mem: Trace Dynamic capacity Event Record
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-dcd-type2-upstream-v6-25-85c7fa2140fe@intel.com>
References: <20241105-dcd-type2-upstream-v6-0-85c7fa2140fe@intel.com>
In-Reply-To: <20241105-dcd-type2-upstream-v6-0-85c7fa2140fe@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730831904; l=3591;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=TYOq64I8qkKSVOGn325NARnZKxDyfxBG23jeqn25Zeg=;
 b=yk4z7GQ1oBn5VRVTp6/xGkq+NHcBzxfZDw0x9lU0cLSKUZO0bX+B6GldyJ21mdoPKUr4vpnYi
 DgidZ/1V8byCB//1IRztoQlycNaCMRBV40ZXX3X2snsqUT+pSQCZZaZ
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

CXL rev 3.1 section 8.2.9.2.1 adds the Dynamic Capacity Event Records.
User space can use trace events for debugging of DC capacity changes.

Add DC trace points to the trace log.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c  |  4 +++
 drivers/cxl/core/trace.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4d476f149c82c0b6ee61cf7f4e71b206cf19ac7f..c2c641e172a1094c7c129ae11ce1ad6692fbad25 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -995,6 +995,10 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		ev_type = CXL_CPER_EVENT_DRAM;
 	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
 		ev_type = CXL_CPER_EVENT_MEM_MODULE;
+	else if (uuid_equal(uuid, &CXL_EVENT_DC_EVENT_UUID)) {
+		trace_cxl_dynamic_capacity(cxlmd, type, &record->event.dcd);
+		return;
+	}
 
 	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
 }
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 8672b42ee4d1b376063b09d29922fcce83a70168..d4526f06cf2a2d0a4b4bc5f9e00238aa43a16e35 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -731,6 +731,71 @@ TRACE_EVENT(cxl_poison,
 	)
 );
 
+/*
+ * Dynamic Capacity Event Record - DER
+ *
+ * CXL rev 3.1 section 8.2.9.2.1.6 Table 8-50
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
+		 struct cxl_event_dcd *rec),
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
+		__array(u8, tag, CXL_EXTENT_TAG_LEN)
+		__field(u16, sh_extent_seq)
+	),
+
+	TP_fast_assign(
+		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+
+		/* Dynamic_capacity Event */
+		__entry->event_type = rec->event_type;
+
+		/* DCD event record data */
+		__entry->hostid = le16_to_cpu(rec->host_id);
+		__entry->region_id = rec->region_index;
+		__entry->dpa_start = le64_to_cpu(rec->extent.start_dpa);
+		__entry->length = le64_to_cpu(rec->extent.length);
+		memcpy(__entry->tag, &rec->extent.tag, CXL_EXTENT_TAG_LEN);
+		__entry->sh_extent_seq = le16_to_cpu(rec->extent.shared_extn_seq);
+	),
+
+	CXL_EVT_TP_printk("event_type='%s' host_id='%d' region_id='%d' " \
+		"starting_dpa=%llx length=%llx tag=%pU " \
+		"shared_extent_sequence=%d",
+		show_dc_evt_type(__entry->event_type),
+		__entry->hostid,
+		__entry->region_id,
+		__entry->dpa_start,
+		__entry->length,
+		__entry->tag,
+		__entry->sh_extent_seq
+	)
+);
+
 #endif /* _CXL_EVENTS_H */
 
 #define TRACE_INCLUDE_FILE trace

-- 
2.47.0

