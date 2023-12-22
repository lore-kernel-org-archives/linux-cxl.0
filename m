Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D8D2F4
	for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRPmkEbI"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d939e2f594so1536201b3a.3
        for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 01:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703235665; x=1703840465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boKgDX4Lvl1vtOxGhAvwh9bjFCyA3++fBUjABFhAblo=;
        b=FRPmkEbI/O6c2H6qGxHngBuMT4m9oC7gIsLPUefO6KtfRYnxjaDOoBV5LN4zPC+P9/
         0yesOSAumxx0pqBl9GxXZzJPH60YrLlbkiFa66sPkabYBvz8MAA9qL1nOEhA0VvnXn8C
         pcZEv8iDldqbHaC038LPZzXUXNoVxy1xu1Q/M0SafR20l81Ixw6oNz84Qwb//vGoqi2m
         fT39mrT42ZulrKTksPqtZktPX2X3w1CCunIrFag2GoEgKUKWrEf2MCKfFlKJc/YrUgRR
         HCmkDPny2aelZM5lGksrIzepPqglp8QMp8XPwRs3LRvmV8XB6ao2XJOVWsRtvM//1sv/
         XKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703235665; x=1703840465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boKgDX4Lvl1vtOxGhAvwh9bjFCyA3++fBUjABFhAblo=;
        b=K5FmkO3gjjTg6dkEy1jny2IEJNYrCOj7a2voFQ5lnHOi7M/tvutMDcB3d/hNG8U+3w
         q8WyvC+xgU1AHqejweTAEC9Mc0gPu7KWPiYYsW4ZFslNhE/wrq4R0dr4pm34SEdjezws
         0UuvnQ9osGpKPNOsjUlfD6qOAQpkcCqYqOGLx4BRvbkEX25lUng5sa1Cbdjt3XopwISC
         tBivOXvfpm9KRskgLWwHkThlMCT9cqJ1M8pzh5mpCMsPuV2ku0Af4xsCdwkBdRpKHWwH
         qpjlr+HTwsHqdSmuZGWSpWT5BtvVvoEXy18el2a6Q6GNwKNu6VA2q5JSXfQj+M6triJ9
         gSIA==
X-Gm-Message-State: AOJu0Ywyb5vZMna4RhCuWH1+LqOPlo736qhRxEAFEaXK1NgIhvHzazDx
	wrrjQtfYIXrQnOT2mvF9YBc=
X-Google-Smtp-Source: AGHT+IETskAy68zOVeR/Q/Oxdx5/PrTDs3S/QqTI7jdFInnq4s3g5TIrI8rTadDT8T3mGuNny9GHng==
X-Received: by 2002:aa7:84d0:0:b0:6d9:5d0f:bee8 with SMTP id x16-20020aa784d0000000b006d95d0fbee8mr1106915pfn.10.1703235665406;
        Fri, 22 Dec 2023 01:01:05 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id f23-20020a056a000b1700b006d990040342sm400560pfu.155.2023.12.22.01.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 01:01:04 -0800 (PST)
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Fan Ni <fan.ni@samsung.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] hw/cxl/device: read from register values in mdev_reg_read()
Date: Fri, 22 Dec 2023 18:00:49 +0900
Message-Id: <20231222090051.3265307-3-42.hyeyoo@gmail.com>
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

In the current mdev_reg_read() implementation, it consistently returns
that the Media Status is Ready (01b). This was fine until commit
25a52959f99d ("hw/cxl: Add support for device sanitation") because the
media was presumed to be ready.

However, as per the CXL 3.0 spec "8.2.9.8.5.1 Sanitize (Opcode 4400h)",
during sanitation, the Media State should be set to Disabled (11b). The
mentioned commit correctly sets it to Disabled, but mdev_reg_read()
still returns Media Status as Ready.

To address this, update mdev_reg_read() to read register values instead
of returning dummy values.

Fixes: commit 25a52959f99d ("hw/cxl: Add support for device sanitation")
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
 include/hw/cxl/cxl_device.h |  4 +++-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 29de298117..ba3f80e6e7 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -229,12 +229,9 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
 
 static uint64_t mdev_reg_read(void *opaque, hwaddr offset, unsigned size)
 {
-    uint64_t retval = 0;
-
-    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
-    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MBOX_READY, 1);
+    CXLDeviceState *cxl_dstate = opaque;
 
-    return retval;
+    return cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
 }
 
 static void ro_reg_write(void *opaque, hwaddr offset, uint64_t value,
@@ -371,7 +368,15 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
     cxl_dstate->mbox_msi_n = msi_n;
 }
 
-static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
+static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
+{
+    uint64_t memdev_status_reg;
+
+    memdev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
+    memdev_status_reg = FIELD_DP64(memdev_status_reg, CXL_MEM_DEV_STS,
+                                   MBOX_READY, 1);
+    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = memdev_status_reg;
+}
 
 void cxl_device_register_init_t3(CXLType3Dev *ct3d)
 {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index b2cb280e16..b318d94b36 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -408,7 +408,9 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 {
     uint64_t dev_status_reg;
 
-    dev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
+    dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
+    dev_status_reg = FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS,
+                                val);
     cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
 }
 #define cxl_dev_disable_media(cxlds)                    \
-- 
2.39.3

