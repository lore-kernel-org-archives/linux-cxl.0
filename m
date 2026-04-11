Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF48A26F29B
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871652; cv=none; b=I4/tMIybgXslspxBRWJTtXHMUK+U/+zZhI9bKyn7uqEK2aak9ElQI5IBf2YIiLMVUNUnQe7ZpMrwev+53n66/06TFRWTNJhTBWQK4IPbKWw86mIv/C3oFKMshUtCQAuHZbQFwOHm+VMgDAsUSZC+Rcs23V4mhEFtuPzg26srbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871652; c=relaxed/simple;
	bh=i21AVULlTN62l0hIhpn5Ogvgdh3NtzlHjwCRIgWWmJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LO+LMMG5L0dHV8PwV49JxQ+Vf4mP2cCQRjosYLweRkoWWlV3fZAjS08KyexvIX40Ythi34oqKXQaxuD1J3DCFZuCkQIkcMi0F1V0xesfSTVg1Jh11l8DPC3y1ebNbp9xxDwkCfqVOFc0NGwgUm7NxfZc1laEfmE5HLCUeAwFvDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGPXOaRN; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGPXOaRN"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7927261a3acso26516437b3.0
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871650; x=1776476450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P3yL7nIC1jIx731UyWEM8aG70CFzX7A2ATjkYSgGx0=;
        b=OGPXOaRNr8dsJeGcWvhPyTrU0Nr+gVkfr60BXsLXwF/Li5YLV3aIrt8HcCXjUY4vBv
         31+BtAu3qiP6mUNPXGCHCNMBbNkuY2Gycu1EUUxOT/wVPwfCBMDE/vU2mASw5PnMIYLQ
         qRg9uzgDmOrXx1YaYv8/xVTg1SZrSzbP8AGV0dX6pHUo4u/xwxYiGFoduHAsBT50VkZh
         PzeqRMTFqL9FZXUOcNYj1Hm6evdipmRQCdtocvaB2APUivfWwRffu9bXrJJHYGYLd8z2
         hkVTQFCenG6thqgkj/keOEPIU2rTpadfTfTUoSlgAIlsc4Oqv/I4Cnkhdhz1XBZFo5Zw
         QNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871650; x=1776476450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6P3yL7nIC1jIx731UyWEM8aG70CFzX7A2ATjkYSgGx0=;
        b=UFF3ALOlvVpFUorILOb0Ddc/5/yc4+RkTIzyi1Zn6NrPTmgg1RCiT7S9pUlEwe9j6a
         /1dyhaUUx31AL3gqgR6QGg2fHxBj+2jMUW+XLx7yedGuSNHEh9eneOifct+xq1/PIKRM
         IVxDdoSPzRqgSpUWcxaCJYapb7Hz6deGUmD9dKTpwd4g9WubquocCFRSD0TYsM2NZ1Tq
         Pfc/29BjcdL51X9cQN435yxi6+sBXEEcVHqscVJ+sOX94HUorz32RaDhB6iWZMDoNpP8
         JnCTBr7Qh12zyDTghmT5pA+4vJvZL42WKDDHGmtvzEQDV3sXQ1T3maFYSvcjssjx4RGk
         IybQ==
X-Gm-Message-State: AOJu0YyUW24mtKQq99kopcyqbXAJX5kR/Rpz/sHIuIdAvQtRwoc1gWA/
	q99E/IGwJPsqFxu/fl4FP6unZ9I1l02biNlVQIJZcNMURrv/AyDuZ1X+YfNeBw==
X-Gm-Gg: AeBDievf8WmkJvDYsSuYzNuMAtquD8ul1bj8ZSDxeETHkGupLCV7ymJhjH71vmH7JJe
	eAboqkFkDq2KvC7wRajUsF0mx1yY40CVKdEtsaIA+OQONIfyqahMhq4DUbsNmbCnhLzA3iMBNun
	Q+pu3xBCK+bZyp+urrL1+ecESYDtjOqTA6Ktw+hkt93JVrVO9W2x5fHismjGERTj1IhYPCeWKKb
	cIrtrBjUkYPUBhpOtMqviJa7ToOrtpeHySNOCLxfajTPjKT0C5ZJbmxB62SV5eHehYiRMG5EPXo
	Q5H7uG3xLNpgv3T7jD8CL/fARTYgoB02zmUY+4jGa7TChC/qHRbTbBOTQ18kk+1OsbRjBemtuFN
	XdfnM6h743c1UI2ylDdedZDnKUoDB8DctfgjVnPGZ9ib0xzifYblbuReaRftdJ18e/N5GHXIItU
	WJgZh9xAkxps3NXlFiDLdzZdaEqNjc5R3YrhUYieZy+w==
X-Received: by 2002:a05:690c:8d05:b0:799:198d:8c78 with SMTP id 00721157ae682-7af71e4792cmr50025927b3.46.1775871649935;
        Fri, 10 Apr 2026 18:40:49 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:49 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: john@groves.net,
	dave.jiang@intel.com,
	gourry@gourry.net,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 17/20] cxl/mem: Trace Dynamic capacity Event Record
Date: Fri, 10 Apr 2026 18:23:12 -0700
Message-ID: <20260411013958.47422-18-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
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
Changes:
[djbw: s/region/partition/]
[iweiny: s/tag/uuid/]
---
 drivers/cxl/core/mbox.c  |  5 ++++
 drivers/cxl/core/trace.h | 65 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9ef38a81933d..81a1d7afced9 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1097,6 +1097,11 @@ static void __cxl_event_trace_record(struct cxl_memdev *cxlmd,
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

