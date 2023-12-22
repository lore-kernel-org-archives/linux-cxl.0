Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69427D2E0
	for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo8frDS/"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c6839373f8so1151132a12.0
        for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 01:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703235669; x=1703840469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pze2Cv/T1AorC9TH3ggyhouTOliDmqm2cL056dpXiT8=;
        b=Lo8frDS/KtPs0i4o93skisg2u3sZFjlt79JtHBcyOPSGyCW6WOUpDQZUN1u8rB15EX
         nKjOwUScYSTfcxz8K1ItRDa9KCbo4yCijn3BBPbUCnaNUHYEMVV4UaNMB9zbORtVLmm7
         RkWQt8+Syr8VjmDyWh1i3L1lB0WFgI1gPHE3K3yN01LCa4UGcI+IqwoNQX4KJyr/iO8q
         YRPs/PGV7zxx9f5faOjNpphE7PnP7uKivDV6qcdxrAlCXb2f+4jFqYli1OS0q2i6ZOpA
         fo+ORv4EAFH9ocmdOYA4RclJ2TPH2Aa18G+6rYutXCBP42va9/1KdUtaTPGCwlQ4VMDi
         MgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703235669; x=1703840469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pze2Cv/T1AorC9TH3ggyhouTOliDmqm2cL056dpXiT8=;
        b=i6PyQ0hAhkrr/Bh0FjjA7RhE9cSLD8C8P+/1/EapgOZddT40pIpbYKf+J5RcGw/CBm
         BXsmce9tR7wJC+f0e4ykNhvGbZrTp27xkGf3HjKAzIlV7/rftpPaoPIbQzttyIRcblU0
         9omTrxWhzu7swsym6Nw8oRMFde7czXQomsxat7JyXlXYpFQjn32uqb9UA4Fiqj4W5rja
         eWFnoRPpvt7pmC3V7pGpb9LfQ8tdaRNdY7dfpxLEJmdzo047zJjUpT1Mcb96KMW1FMHa
         ehlT0vqsv0apRK9kG9qYLIN8aP8P/GQ6pacXNdBaKgfdIqJArXWCwKLB8cu+DlAUtBfE
         7fbg==
X-Gm-Message-State: AOJu0YwEgo26VzJMFMsQySxHh1xqoF8SudfJipkOnfWfR5zduhOGa2jh
	edUUkABFTBkcqNuFf3uBEws=
X-Google-Smtp-Source: AGHT+IFugj/FMKrijP+kRxUM50nlGrQTcMl7Fd4knps99Pd2Lf7vMloX5ys0XXcnF4fFb4l4YI2U5g==
X-Received: by 2002:a05:6a20:8814:b0:194:ffaa:a2c3 with SMTP id c20-20020a056a20881400b00194ffaaa2c3mr966439pzf.1.1703235668571;
        Fri, 22 Dec 2023 01:01:08 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id f23-20020a056a000b1700b006d990040342sm400560pfu.155.2023.12.22.01.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 01:01:07 -0800 (PST)
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Fan Ni <fan.ni@samsung.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] hw/cxl/mbox: replace sanitize_running() with cxl_dev_media_disabled()
Date: Fri, 22 Dec 2023 18:00:50 +0900
Message-Id: <20231222090051.3265307-4-42.hyeyoo@gmail.com>
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

The spec states that reads/writes should have no effect and a part of
commands should be ignored when the media is disabled, not when the
sanitize command is running.

Introduce cxl_dev_media_disabled() to check if the media is disabled and
replace sanitize_running() with it.

Make sure that the media has been correctly disabled during sanitation
by adding an assert to __toggle_media(). Now, enabling when already
enabled or vice versa results in an assert() failure.

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  6 ++++--
 hw/mem/cxl_type3.c          |  4 ++--
 include/hw/cxl/cxl_device.h | 11 ++++++-----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 11ec8b648b..efeb5f8174 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2248,6 +2248,8 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     int ret;
     const struct cxl_cmd *cxl_cmd;
     opcode_handler h;
+    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->intf)->cxl_dstate;
+
 
     *len_out = 0;
     cxl_cmd = &cci->cxl_cmd_set[set][cmd];
@@ -2268,8 +2270,8 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
         return CXL_MBOX_BUSY;
     }
 
-    /* forbid any selected commands while overwriting */
-    if (sanitize_running(cci)) {
+    /* forbid any selected commands while the media is disabled */
+    if (cxl_dev_media_disabled(cxl_dstate)) {
         if (h == cmd_events_get_records ||
             h == cmd_ccls_get_partition_info ||
             h == cmd_ccls_set_lsa ||
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 85fc08f118..ecb525a608 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1286,7 +1286,7 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&ct3d->cci)) {
+    if (cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
         qemu_guest_getrandom_nofail(data, size);
         return MEMTX_OK;
     }
@@ -1314,7 +1314,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&ct3d->cci)) {
+    if (cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
         return MEMTX_OK;
     }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index b318d94b36..5618061ebe 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -411,6 +411,7 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
     dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
     dev_status_reg = FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS,
                                 val);
+    assert(dev_status_reg != cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS]);
     cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
 }
 #define cxl_dev_disable_media(cxlds)                    \
@@ -418,14 +419,14 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 #define cxl_dev_enable_media(cxlds)                     \
         do { __toggle_media((cxlds), 0x1); } while (0)
 
-static inline bool scan_media_running(CXLCCI *cci)
+static inline bool cxl_dev_media_disabled(CXLDeviceState *cxl_dstate)
 {
-    return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
+    uint64_t dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
+    return FIELD_EX64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS) == 0x3;
 }
-
-static inline bool sanitize_running(CXLCCI *cci)
+static inline bool scan_media_running(CXLCCI *cci)
 {
-    return !!cci->bg.runtime && cci->bg.opcode == 0x4400;
+    return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
 }
 
 typedef struct CXLError {
-- 
2.39.3

