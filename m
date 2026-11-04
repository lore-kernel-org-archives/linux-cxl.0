Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833410;
	b=bL3J/X2ko4gzKMLpMMlafyjyfuqj/FRtltGalINOjA3/NzehmBWN5qz+pTFCpeyEojj0
	 YtWXoLsdQGpCrvFPpVDUmy/fTGodA/GU8EGbBA+p65JbmXUwH9IwvV7XHLlFzIKtKic9/
	 E9ezJwALOBClAuFVJ93IPiFy1j0JlPV5lBcGlhgurMREYAH0Ih/LSEf8w3IdrHOewnhgX
	 LKOowJcxVpkLaDO7egwL+LLOYua+sAw8ojMdZVIT2dGqgECLxdklFo1NrXQbr6ZRigB+O
	 T4wpajGr+7ywmHbCxM1PVBAk4cAYjch1ZTTPD0qTw+nZS60Dq+UQ/3BvBPKc7lF4Jsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JheZtoBiAYlT2jI3FTLiO1Qwu06oef/SS/C/KJIK8ZU=;
	b=Ls2fBzYc4zk+Z+gvhALEVJDvQf91hYMmTCIsexyjMQYcDfH9P+OphOow5Iqs04GS5+fw
	 W3B63PGjElq3IxDVP5iwM9sXv4FkbDcbtMh8WFe4WtSLlTCL3bODser5n+blDTEHgd/Mw
	 qcypbOIMc8osDzlu3o65zDiWztcsjBLa/anxKw5d9cxUYbhsY5yEzr8HFXeap4m1wkCyA
	 b+JzOJ1P8qJordnUhjAnE8v2yOq4ZgS6ANAZoi2i02PyTJ4BGt00RDbwaH6pTZe48/qgz
	 dH2lo7FE61TsmtRt0wyUs9KvfoiCUBhk7ZarlJNRwPaw8gjWIFkwZfkhic3ahuFoDHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AKXjinT/";
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBF4606EE93
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 23:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FBF4606EE93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AKXjinT/
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ed2b4348fcso815ad.2
        for <linux-cxl@vger.kernel.org>; Wed, 04 Nov 2026 15:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833395; x=1794438195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JheZtoBiAYlT2jI3FTLiO1Qwu06oef/SS/C/KJIK8ZU=;
        b=AKXjinT/IN5dD5KMqtpAd7333JAl3cBRxVNNUV9bfOv8vfwHlpgfWk5PMA+/JD1e4p
         +fA9BsO1qv/htHJQCmT+1DgSoC34T8r44cXwHiQr6EgrO3oHxZdAtsFMcCVMYQa3tx0S
         tcfctxGODhB1X28MBjHezcAgQbg3B25t0Nb1wdKZN5Xxcnme4YYY1wZrjZhD7U9PP3Q0
         c2xJjv/vqAZpXoAsGBHmXQkS4aBwEaasUSjKvr8XS1wBTJosuAl4RqX4e8y36hurQuUX
         lgnhyGauV5OofxoEtwW0/9272B15PYvaNsF1u3cI71j/ZO5Lb0wSEsf0YTCijjcD+bUu
         3dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833395; x=1794438195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JheZtoBiAYlT2jI3FTLiO1Qwu06oef/SS/C/KJIK8ZU=;
        b=QuJUSnHkpKQVsv9AFxw/7vUCD2ko8SL2tS76UoZC/pUrBDJsjYGzh/Cp7k1FlpjzvG
         KKWbTzlNzXeYDML2h9S3z9a4XGa4qWldzY+BvvQpUt+pww7SAR6I9FiU9t7zkCmQl44M
         dl2XhxuOQ15583mUuUHP9od2cA5EpedcFipRSssEWfWtqMJ0VE3VG8oq57fFS6Pyrl8m
         aKYZvihqi8QKz6NrBxxEGp1hP79h46vSZZcmqx3JZ58/Z/9nhcUQS/ESZ/seUnlAxXrS
         JSkJXRh4xJtfZmcxek3U5e2BhBPyNaojUMU/gQR/oCvHi6FuidoMAAbAXth34h/WODxC
         41sw==
X-Gm-Message-State: APuU4Z8u152kyLhkDjBtuSB4U2Zhvxt7q5dVzdsdXPx0D668XV0swRsk
	7P9rj3mlv/0YhUz7dZD0339oBln69D0ObicrKWcQzh0X0y2r3xyKDC3EJg4FcIEP
X-Gm-Gg: AYBFou1H+fVbOlARf/X33umGkopK3jnpb3ceSww5KICHM/+aJPDlhRbFzQWFkbTjVFs
	nEuuj6xmA0erghp0WLrOYTXDrhSDg1troSOrwd9hYIswX+zqkjbkPZ5LEEtfuKlIislmxuBWZJa
	a8oJPzhjG+AAjto0L3RSSxN7Ng9n7rOdEt7uqyqcUxO/c6Wi6qWn6imBr6/6GL47rdz9EABkaOf
	6B8qU27HWooTRFMK5/7FCSKdabqepZSblKQgUQy39+aPB+fERtuT92HXIyoCeIbXfKeGTCZcgUG
	PwvuQf12mx7SHlK5HzDJZtxUiVVjXYUi0pv9bDPAgAMcr/9gvFlAo5c9YdPmUCxge8RV6m/zcGA
	UvLiRfSOr1QWHLk1uioXNcGq8d1yGSH1dR7epPVXowJs/GmBX5jervVa1fLk+Q3XoSnylK6PkPh
	Tdsd9ILyqsUcnWo6UQM6zYybQESuMitUFvzh3czqozkskpEBfUmPttpNdbaT5ptL/zggeBhLNCq
	b/7eDGdSGXZ1u4ik4BfFJQfx9RTlfQM5iPn7ucgXSLdTjdinjnj1trXeLgE0Z6gQnbnahAkPfoy
	oW/gFv1wP07fxeInKAATM3ZosQ5YPQ==
X-Received: by 2002:a17:902:d510:b0:2ea:1b9b:b938 with SMTP id d9443c01a7336-2eb364852abmr160514515ad.55.1793833395260;
        Wed, 04 Nov 2026 15:03:15 -0800 (PST)
Received: from cxlqual.. ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed0908587dsm10999175ad.36.2026.11.04.15.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:03:14 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v1 13/14] cxl/mem: Trace Dynamic capacity Event Record
Date: Thu,  5 Nov 2026 08:02:37 +0900
Message-ID: <20261104230445.66625-14-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104230445.66625-1-anisa.su@samsung.com>
References: <20261104230445.66625-1-anisa.su@samsung.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

CXL r4.0 section 8.2.10.2.1.6 defines the Dynamic Capacity Event Record.
User space can use trace events for debugging of DC capacity changes.

Add DC trace points to the trace log.

Based on an original patch by Navneet Singh.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Co-developed-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
---
 drivers/cxl/core/mbox.c  |  4 +++
 drivers/cxl/core/trace.h | 76 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a18b41ff5d23..c60c10d7bd31 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1041,6 +1041,10 @@ static void __cxl_event_trace_record(struct cxl_memdev *cxlmd,
 		ev_type = CXL_CPER_EVENT_MEM_MODULE;
 	else if (uuid_equal(uuid, &CXL_EVENT_MEM_SPARING_UUID))
 		ev_type = CXL_CPER_EVENT_MEM_SPARING;
+	else if (uuid_equal(uuid, &CXL_EVENT_DC_EVENT_UUID)) {
+		trace_cxl_dynamic_capacity(cxlmd, type, &record->event.dcd);
+		return;
+	}
 
 	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
 }
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 64c6ce0878e2..d7b237203bb5 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -1108,6 +1108,82 @@ TRACE_EVENT(cxl_poison,
 	)
 );
 
+/*
+ * Dynamic Capacity Event Record - DER
+ *
+ * CXL r4.0 section 8.2.10.2.1.6 Table 8-229
+ */
+
+TRACE_DEFINE_ENUM(DCD_ADD_CAPACITY);
+TRACE_DEFINE_ENUM(DCD_RELEASE_CAPACITY);
+TRACE_DEFINE_ENUM(DCD_FORCED_CAPACITY_RELEASE);
+TRACE_DEFINE_ENUM(DCD_REGION_CONFIGURATION_UPDATED);
+
+#define show_dc_evt_type(type)	__print_symbolic(type,				\
+	{ DCD_ADD_CAPACITY,			"Add capacity" },		\
+	{ DCD_RELEASE_CAPACITY,			"Release capacity" },		\
+	{ DCD_FORCED_CAPACITY_RELEASE,		"Forced capacity release" },	\
+	{ DCD_REGION_CONFIGURATION_UPDATED,	"Region Configuration Updated" } \
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
+		__field(u8, updated_region_index)
+		__field(u64, dpa_start)
+		__field(u64, length)
+		__array(u8, uuid, UUID_SIZE)
+		__field(u16, sh_extent_seq)
+	),
+
+	TP_fast_assign(
+		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		__entry->hdr_uuid = CXL_EVENT_DC_EVENT_UUID;
+
+		/* Dynamic_capacity Event */
+		__entry->event_type = rec->event_type;
+
+		/* DCD event record data */
+		__entry->hostid = le16_to_cpu(rec->host_id);
+		/*
+		 * The Updated Region Index is only defined for Region
+		 * Configuration Updated events (Table 8-229); report U8_MAX
+		 * (not a valid index) for other event types where the field
+		 * is reserved.
+		 */
+		if (rec->event_type == DCD_REGION_CONFIGURATION_UPDATED)
+			__entry->updated_region_index = rec->updated_region_index;
+		else
+			__entry->updated_region_index = U8_MAX;
+		__entry->dpa_start = le64_to_cpu(rec->extent.start_dpa);
+		__entry->length = le64_to_cpu(rec->extent.length);
+		memcpy(__entry->uuid, &rec->extent.uuid, UUID_SIZE);
+		__entry->sh_extent_seq = le16_to_cpu(rec->extent.shared_extn_seq);
+	),
+
+	CXL_EVT_TP_printk("event_type='%s' host_id='%d' updated_region_index='%d' " \
+		"starting_dpa=%llx length=%llx tag=%pU " \
+		"shared_extent_sequence=%d",
+		show_dc_evt_type(__entry->event_type),
+		__entry->hostid,
+		__entry->updated_region_index,
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

