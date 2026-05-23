Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD073921D0
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529474; cv=none; b=J5LkGV466zNAfYM3tBdXS4ckeJuWxXA7CkfXT1FbamlgmkRCE2YS/+x6+i3e6m45XET3jnLm0I1r1UCITExnLmROuCxG4h+KoD/AD8FRcg41kITSCs8qlgEmNRiCoBcreJf/HkAYyQmyvz+KZNp3VJVcWbcAZYsBAmlVXbHWWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529474; c=relaxed/simple;
	bh=9Vatsa44EJ16grZ7fWkxrmMrz8YLYk1hyZyIQz21lpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDXKFi1rrMD/a3bMdgTKEco1SxpgMwCAfIqcjDFid+hE8VWDcN0ek2tRoyjeCx4xCHwG+74Np2h6G1ui32/FbQ/cyiNrOTC5SvuItdVx0eQUT9No64dIvYZmdBHOO4DsqAXKaYcakNN/n8C/Gt7idvpIwjUkaAtOsU15KMJrSvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaepYzQ/; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaepYzQ/"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-134ac81c445so10219234c88.1
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529472; x=1780134272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVlxVqb/noEE3wo4FJD/Az4q6LLE6ik5ntk4peDmfoE=;
        b=IaepYzQ/ma7R79pvLb8r5QefnuDhui5FXVhIxsOWZH0LsH7HphQG78iDwP8lgSvK1k
         h4w5Ub+RusMjtF1L9V9Sc4iqxzTSufPNflDbzZIOt52Yige0OpgsrXJFTXJYUaQZb1Ms
         DlPBW6IRHATxCYz1Acep95fcVB85rvR9umhLaoS/db9o2zPFvbvWOswpEh009Q3bqFEc
         8auQI2ZglvxKazJfrs3qEzhIQwmbMHFBTbwjkk5/sTCY4S2C9idq8HI8PCTzLj4YOpp1
         neNIHWPdggh27CaY6mIrkQlsGHC4KympXDgyF/M1ljrBc92lXhzNeb32rZOF2hhtwYwC
         hdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529472; x=1780134272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZVlxVqb/noEE3wo4FJD/Az4q6LLE6ik5ntk4peDmfoE=;
        b=HzJX/rD8XySPlkT2ZnzgJ44esmPTB+lwa++R+Cu2FByuZf3RYY5VIAJs4bUPyjhD37
         BZgoNIKSI6Kix3MhFzLwd8D/y74UYdXQF0K13u638VZ/TIZPCewO0WipPK67b35xck4z
         AOl9LR2TEAYM0W/zfdexlXnJ+ChMPRFG7etmSvaCV0JyrCih0fo7WDJtbxScHTG1CMN7
         mFC0bY/dEU/8DmhSkHnICpg3xH0C9s2RGWPygyRH02WkZJ7Q3SUjIgtuj/QQAQxHTKdd
         jwiVGYe6NK7e2NtJ9QKY4br6xWs9/g0XK9ckS9DcE9aoVIlAlwWwILpeXiDjzFwp7lkm
         y7iw==
X-Gm-Message-State: AOJu0YztLtP91gYLmprtGqIXzXeXhO39pFjnUkSLIPfcWWhdELX/z+0K
	FzjjR2A7WSwBLEmQ92hbn3Wlh1O585IxdIMujT2rdQE+5a6knYREUZ/RfAQCKA==
X-Gm-Gg: Acq92OGTlfPImIfC2F3pG1D7PCDhLlMcDqpRgKKZNALy/pHEL9E5SMo6r21LcFWOgfG
	k51e+zxzRmz1a2JVV8i3QSAkJVgvyJD/ASpF9QceGfNYq4wCDhIolXL8GIlw/qkBrFMA7NDKw/r
	xGKfbjhjHpf+6LeqhizaVUX8K5Mq8OyFS44hjBN+0SrqyLy5OKSmYtPMQJzWUPMVOAMbw2stkab
	ngNYL+oHGY5+FLVp7xU+NYFyD13MNF5xxofWni4wyHXRrs8xCjnPZBFdmkc6zQRq7pYH3B6ZlRi
	KQ6cWwUv5D+7iXzKqbd7IypUiQiNuI6qMofJ9KqzxrI1We2wbhX+vJQDtEwwZINTVBWQ3lUe6c3
	kMQc55ZWnl1z8f1C8deaLYmLpapVsIhqn4kQgDGo/msZP8W1CW9evePXHJEh9186oB8v5CsWj0N
	jv+LPDnHr42yPl3R3YxStyaKqMxnjKGQdMkDNjvdPVIC1iUTYGu5jSBesFCIo9CpPDhjlgiBsgV
	rAn8qUf9vyIstPefw==
X-Received: by 2002:a05:7022:ff45:b0:12d:b7e5:a691 with SMTP id a92af1059eb24-1365f80f603mr2633678c88.7.1779529471639;
        Sat, 23 May 2026 02:44:31 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm2376358c88.7.2026.05.23.02.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:44:30 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v10 28/31] cxl/mem: Trace Dynamic capacity Event Record
Date: Sat, 23 May 2026 02:43:22 -0700
Message-ID: <54f9e863fac7a9c040267a13cd36aa7415e29f4f.1779528761.git.anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779528761.git.anisa.su@samsung.com>
References: <cover.1779528761.git.anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

CXL rev 3.1 section 8.2.9.2.1 adds the Dynamic Capacity Event Records.
User space can use trace events for debugging of DC capacity changes.

Add DC trace points to the trace log.

Based on an original patch by Navneet Singh.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c  |  5 ++++
 drivers/cxl/core/trace.h | 65 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 486110e1c03d..271f4556db85 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1030,6 +1030,11 @@ static void __cxl_event_trace_record(struct cxl_memdev *cxlmd,
 		ev_type = CXL_CPER_EVENT_MEM_MODULE;
 	else if (uuid_equal(uuid, &CXL_EVENT_MEM_SPARING_UUID))
 		ev_type = CXL_CPER_EVENT_MEM_SPARING;
+	else if (uuid_equal(uuid, &CXL_EVENT_DC_EVENT_UUID)) {
+/* FIXME still valid? */
+		trace_cxl_dynamic_capacity(cxlmd, type, &record->event.dcd);
+		return;
+	}
 
 	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
 }
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a972e4ef1936..421e492d1b3f 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -1099,6 +1099,71 @@ TRACE_EVENT(cxl_poison,
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
+		__field(u8, partition_id)
+		__field(u64, dpa_start)
+		__field(u64, length)
+		__array(u8, uuid, UUID_SIZE)
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
+		__entry->partition_id = rec->partition_index;
+		__entry->dpa_start = le64_to_cpu(rec->extent.start_dpa);
+		__entry->length = le64_to_cpu(rec->extent.length);
+		memcpy(__entry->uuid, &rec->extent.uuid, UUID_SIZE);
+		__entry->sh_extent_seq = le16_to_cpu(rec->extent.shared_extn_seq);
+	),
+
+	CXL_EVT_TP_printk("event_type='%s' host_id='%d' partition_id='%d' " \
+		"starting_dpa=%llx length=%llx tag=%pU " \
+		"shared_extent_sequence=%d",
+		show_dc_evt_type(__entry->event_type),
+		__entry->hostid,
+		__entry->partition_id,
+		__entry->dpa_start,
+		__entry->length,
+		__entry->uuid,
+		__entry->sh_extent_seq
+	)
+);
+
 #endif /* _CXL_EVENTS_H */
 
 #define TRACE_INCLUDE_FILE trace
-- 
2.43.0

