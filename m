Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7000AD2E7
	for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmt9VmVA"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d7f1109abcso1069339b3a.3
        for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 01:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703235672; x=1703840472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2onsigAzJZV8OA9wsWeUj+BIGS+8SDO0C+tc8HGOhY=;
        b=lmt9VmVAaeVUuBDp6cGGmDiom88QTP9/UDAwhWEy7l7W74hzs74dWAmLAgqOD7IWLF
         czZTQawvwwbnRH0A87zmDpu61ww/GUVIsU3NNYqMGD6my3Kn7ZJFGLxRNNdMhwGmXdR7
         qVnSlSFBW03uFvmidlA6vTTSBrfhKrilhOXZFY859gSRvh6D6OjC5PGAsg5k/RigyBDm
         d2AEteml15U9xufbxTqjPcR2x1mQJgOesKwnQgvlE9Hr7UEk93nxJNXW0S9mtk69/oJR
         3M8maR4WYKVY4sM5bAjYorVK+1h900Gbz73mAEV+ZUgZmOq7biEmqv5uZ4yXkm1PLLhL
         RBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703235672; x=1703840472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2onsigAzJZV8OA9wsWeUj+BIGS+8SDO0C+tc8HGOhY=;
        b=ekV9jC959UesXco1wKZQwjqaGhQi0RmoKH1ea0C13G1U7nkZnD+AgEIdlT4WQM0F5H
         WVfoiUvEqt8PsARDUDtM5swp7sOcTKJc57BVjSbeLwJ3g0JHXpt0Ge1TQtC/6WNJbLLJ
         o91n+V2dvZjLxoH4ekLWZzAQu8swfDY4izXL74VzDcOXWFKfNsRF/MXhRtWsc2lm9nAE
         JI7Y3GnCr6hqMa+iyYL9aiy/0mRnXIJmOA+KmbCrRuCMF2D97VwI4clkZUnI1G0/7bjr
         IGBlxqVHACAKML/hXpgzBibcX3yWEK7fQeVJPCiRZ2/0SbDCcnJyrn1M0x99GTlyQqZ5
         mlIg==
X-Gm-Message-State: AOJu0Yy0aXb38k4CA0BbG+PKpOtBhv1svO+HN/ltjgYbSCfBfEuy31JI
	JISzqWdcJOPCNt96DbnZ1Go=
X-Google-Smtp-Source: AGHT+IEQy6RlE35SipM9nNEMtU2PXXoNbifceNoOLuT+BPwv1mrmvRkw2/FTJSVF4OtWawIMnyR29g==
X-Received: by 2002:a05:6a00:e07:b0:6d0:89be:e4a8 with SMTP id bq7-20020a056a000e0700b006d089bee4a8mr834227pfb.37.1703235671523;
        Fri, 22 Dec 2023 01:01:11 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id f23-20020a056a000b1700b006d990040342sm400560pfu.155.2023.12.22.01.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 01:01:10 -0800 (PST)
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Fan Ni <fan.ni@samsung.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] hw/cxl/events: discard all event records during sanitation
Date: Fri, 22 Dec 2023 18:00:51 +0900
Message-Id: <20231222090051.3265307-5-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per spec 8.2.9.9.5.1 Sanitize (Opcode 4400h), sanitize command should
delete all event logs. Introduce cxl_discard_all_event_logs() and call
this in __do_sanitization().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 hw/cxl/cxl-events.c         | 13 +++++++++++++
 hw/cxl/cxl-mailbox-utils.c  |  1 +
 include/hw/cxl/cxl_device.h |  1 +
 3 files changed, 15 insertions(+)

diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index bee6dfaf14..837b18ab47 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -141,6 +141,19 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
     return cxl_event_count(log) == 1;
 }
 
+void cxl_discard_all_event_records(CXLDeviceState *cxlds)
+{
+    CXLEventLogType log_type;
+    CXLEventLog *log;
+
+    for (log_type = 0; log_type < CXL_EVENT_TYPE_MAX; log_type++) {
+        log = &cxlds->event_logs[log_type];
+        while (!cxl_event_empty(log)) {
+            cxl_event_delete_head(cxlds, log_type, log);
+        }
+    }
+}
+
 CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
                                  uint8_t log_type, int max_recs,
                                  size_t *len)
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index efeb5f8174..2ade351d82 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1150,6 +1150,7 @@ static void __do_sanitization(CXLType3Dev *ct3d)
             memset(lsa, 0, memory_region_size(mr));
         }
     }
+    cxl_discard_all_event_records(&ct3d->cxl_dstate);
 }
 
 /*
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 5618061ebe..8f05dd9beb 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -604,6 +604,7 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
                                  size_t *len);
 CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
                                    CXLClearEventPayload *pl);
+void cxl_discard_all_event_records(CXLDeviceState *cxlds);
 
 void cxl_event_irq_assert(CXLType3Dev *ct3d);
 
-- 
2.39.3

