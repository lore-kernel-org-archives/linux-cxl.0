Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE62628D
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486521; cv=none; b=ckBwt/0J7tOEcL6HvD60jPxqY7w2/Zteg97B5o994HVltHmpcVjWDwVPWkZLefyncV1XQ+s3T2yDwqMDN0VAHFQaHTDZZErHSAFuXkmWrqq3MJN7gjwqhX9pJ0hWlnwyJ0KOz6wHpNoW5F7fWOuDI8AydV2rfLU7uc5tP3Bo8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486521; c=relaxed/simple;
	bh=9BqIh49efz41KHoAmmUpXftiWUSfCVPvxmlbEJDrjCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DblQ7UqUqhSajkOOqkMoUX7VPRuEXaWU7gcKRflkHg3DR0Rc/oA716AvQfqUYB4Ycb/9jQhYtD8Q9x6Wknt9CiTwEVJQCgdTLR7LKPL3q7bQ5k8sW7lLG9C2ikhAsQxJcC3IiqSg6unSRWZQQIoFM1SS8MM6S9L7D9bOujOKXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IllHGysV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IllHGysV"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f332511457so6149155ad.2
        for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486519; x=1717091319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUY+tVIrLXlBWDYAZLBMIzgstxLzMinOnAd95xKbspQ=;
        b=IllHGysV6/H8Q4DPvtGu0jbUbcTQsugkkYtYzwSNCtiAcPSwG3cR3vOCCZLGY5UVte
         MKhik4zx/eBkAw4U8K6CjgAaSEOFtcD4vb6yfJkuS7eNnly1Q8zWTrmqcwOA/ZrfAu4u
         XvQLOrGixg2YEFF1iU+G5ePYGSdhu5UiIo701nA91vVN6vFrtFkzvNLZcKULJUULlaK9
         kNDG/J3Q4UAYY0kQxEhDDafKrdaVRfX21HSYLy+o6G/ETPDFU/DgCxW38eEeLe/sqeeb
         X1LQ8IvRdWy/cPgsjQMuVtIT/AaygXHOQ+zAeWIoZYgu870KBWY4WblC3L3B2fOhIQ0y
         Z48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486519; x=1717091319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUY+tVIrLXlBWDYAZLBMIzgstxLzMinOnAd95xKbspQ=;
        b=RgHROlqTZDkXa71Kxk/gHffKAbW50UDqMlAlZ/io7bmSmGqZZMjEp8ddeTZyC8/uc4
         KyMNhx/myQaZqqE2gvaIfSH0QwduIP+/Qs3P5FN8xc+MzX4TkTGsf8WbHQKWFj6Xo6BH
         Ri37mNLQnKhJbAMH+TQ4CkiUHJ340umyzsluQ8NH2S642QXiUy7YDzjOFPu0vMVRgWlt
         16AKB5XbStnDNbubuT1PuK9igrT7DVY3rsUpbtRIHifHdnE/Q3o8OrnFG7AvJKMT6CsZ
         xTdvePeCAONI9Cqz+GoxYbBw2N2kb4n67T/Pw2mR15XvOs5dUGYA/gEyyii+ndCv/so6
         hscg==
X-Forwarded-Encrypted: i=1; AJvYcCXKG0SrIxuEyvrMstTigd8Y1fBUcZfeA/3T8SOzc5I4I1J4mzgONqoohe4V0VXy1i6rH51KUlvX0Fz5Nv/q2Pobr2wsLdMu/o7d
X-Gm-Message-State: AOJu0Yz6EjqP3AOo3rBbbjyvlqEidUXoet6iA/qyW0JTBziVAH/MbA/o
	NLAWlzTIvAdVDNpbyDtwyRSSlKKbacwQTxJr7jbokryvwrljfCaV
X-Google-Smtp-Source: AGHT+IFf20NX3YEVB79xFwOa3YX1k2qEZb8NgiEQW9xioF3Hrc65GPKe5k6j4CXoBHvaPjkpWIscPA==
X-Received: by 2002:a17:903:22c6:b0:1ec:e3c2:790e with SMTP id d9443c01a7336-1f4486fe183mr792505ad.19.1716486519218;
        Thu, 23 May 2024 10:48:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:48:38 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	gregory.price@memverge.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com,
	wj28.lee@gmail.com,
	armbru@redhat.com,
	mst@redhat.com,
	Gregory Price <gourry.memverge@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v8 01/14] hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
Date: Thu, 23 May 2024 10:44:41 -0700
Message-ID: <20240523174651.1089554-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gregory Price <gourry.memverge@gmail.com>

This allows devices to have fully customized CCIs, along with complex
devices where wrapper devices can override or add additional CCI
commands without having to replicate full command structures or
pollute a base device with every command that might ever be used.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 19 +++++++++++++++----
 include/hw/cxl/cxl_device.h |  2 +-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e5eb97cb91..2c9f50f0f9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1447,10 +1447,21 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
                                  bg_timercb, cci);
 }
 
+static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256])
+{
+    for (int set = 0; set < 256; set++) {
+        for (int cmd = 0; cmd < 256; cmd++) {
+            if (cxl_cmds[set][cmd].handler) {
+                cci->cxl_cmd_set[set][cmd] = cxl_cmds[set][cmd];
+            }
+        }
+    }
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set_sw;
+    cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
@@ -1458,7 +1469,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set;
+    cxl_copy_cci_commands(cci, cxl_cmd_set);
     cci->d = d;
 
     /* No separation for PCI MB as protocol handled in PCI device */
@@ -1476,7 +1487,7 @@ static const struct cxl_cmd cxl_cmd_set_t3_ld[256][256] = {
 void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
                                size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set_t3_ld;
+    cxl_copy_cci_commands(cci, cxl_cmd_set_t3_ld);
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
@@ -1496,7 +1507,7 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
                                            DeviceState *intf,
                                            size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set_t3_fm_owned_ld_mctp;
+    cxl_copy_cci_commands(cci, cxl_cmd_set_t3_fm_owned_ld_mctp);
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 279b276bda..ccc4611875 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -164,7 +164,7 @@ typedef struct CXLEventLog {
 } CXLEventLog;
 
 typedef struct CXLCCI {
-    const struct cxl_cmd (*cxl_cmd_set)[256];
+    struct cxl_cmd cxl_cmd_set[256][256];
     struct cel_log {
         uint16_t opcode;
         uint16_t effect;
-- 
2.43.0

