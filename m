Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A3022259E
	for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750981869; cv=none; b=fNd8iDKVr7Lwr5Bze0xCGLtiQohVEojzoOTsYKsJCTKWcK2N1d27qPf2R+9vrcnRXDYixQfg3/kX70jiUtmbMf1avXutAbdamVs6tM492M9mJeq0/7a1InH77BxShM/v71vQWA/8gTgV8V2xRZe0ljlzB6nbVkl41pY2qKq/blc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750981869; c=relaxed/simple;
	bh=mtK0JDjXA+lf60BcaW2kc9TLD6Xi2XD5r27NGVOBifE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXFfwy8QQOj+VqsSUy2dE0c7TbG1mZMLis/m+oCH2bD1Nrij8jNx87o4NRwJ+JMXPZ7ZhFkyjSbw9eiCEIKzD/VGY7ME3HSqFsBIjBdtRcipjJUxi2GkgwZe1KLdzumWszOg78M7rgYPrSUfbK/HICrQaqfj32R69zmjX7XJ1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KspcJXdu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KspcJXdu"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234fcadde3eso24032935ad.0
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750981867; x=1751586667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+mRXGA+oZiP4fjp2MK0XrnzBc/2v3Dfz4xLuPxj0Xk=;
        b=KspcJXduRzNp+vjoWEwDkXkc979APpSewsfBkVH4P9t9porf5E0pGIu94WKsBF2/aB
         cNmXvxv8QQvBDluJgsMRGrSkWR2ReVTWxqc4+3LW++BrKSTH88mrl0fzhYymyEXNuC4S
         GPh+mYAcaVGhq4F9lXdo17lusFpjGJuRYrjEpt83Pz3+LXA6zIZE9zIODrJd9+bxEjcr
         hKXGwJP9IStXxcz4OiQgs7OytByGB0Lp5qqhGh1LXnEeq5VfPW0yeyLSSKxYHSwGZ9/A
         /gi76qmur+U/apJLgL+9yH8Q2mSdcgx9RX0k3NUEusz0qPXZx9fh9RceqzHLkGU8D/2l
         4YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750981867; x=1751586667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+mRXGA+oZiP4fjp2MK0XrnzBc/2v3Dfz4xLuPxj0Xk=;
        b=NKH1r836TAkIaxceTQcaNP/1lgllP4rFA6NgG+es/spGzlRWJ/CHSnaI7mg9abc7ok
         eO/A4TmnCvP5t+wf+MckAxspv5nNZjiliSD7/N4lQxkNbdV22ovSfvdCGAUvDAJlA8pc
         9nZu6upmSjCM0aD+3bpbZhqTm1LAaHohZJpNIiKgUA+olCVqhmpl93dn2pLSdHFklCDR
         2DYOyGbzoWT3sfhcf4C9zWmRZZZu8wabyj27bFseoS6mfLEyzWt89Rjhr5sLl/73+dCm
         iXQn391ztEoGm7xsBRkaRe2fcnCnRwGHrhsuIgOEst0yPJN/Y+XLF31+SCY6CKBilmtO
         biyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqyGWlnSfVw/IQdv+R+98Z28qMYyfOyNAE3A7bb0rNg9sNS/oJSUIifrvLbY2ezz2mUiwu33H7NhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGca6tX5W4+y2pJN+f4FHfjYZsGKXmMQZpwRpS/9nHLNMuGYbB
	g0rd0C5CPR+7CbIead319EXYLfDD43uCofZ4LpowfffgC79FIZ/dmopj
X-Gm-Gg: ASbGnctgnpNLdwc5GdqYOg/9MFk+I1mnSnuLaIGB6w6v42Y9jV3yWDbrv12zhjL69pj
	SC5t6v6Kn3wYaQP8ycA1utBs2ApRlj18wA0UTLvBhTXG5uek3HKnUBHBB3iqF1W9QFZ+U948IoS
	jE06tEwQlqLfreA8FkIO78OxFlmYeKKBD6hWvUAIxGYdNlz/vbMctoevlsCqYCEd5VP5Ef8vbrG
	kOoMybGwLotEk8zFHiZzDWYyyVX7ePbwT37dIHA8j/uexVvkMc1VddeHSKn5LuQqlrZ9+5crWMV
	9UzhEkpQv8NJYXh807F/YUGDtH1uxsviiU0SCH0L0ZHCaVJc0orWE1j4Dg0AO/xk5rvylDCJZTU
	VOZ8SVnY=
X-Google-Smtp-Source: AGHT+IFk1j3vtXbBWNlT2vcqJ5ZknXNg0xSy5kSmp6B//qv1X7OMGPGbO60HZ9QiizvCOo2uKxsY4w==
X-Received: by 2002:a17:903:1aac:b0:234:db06:ac0 with SMTP id d9443c01a7336-23ac46835b6mr15381595ad.45.1750981867096;
        Thu, 26 Jun 2025 16:51:07 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f1845sm2081055ad.70.2025.06.26.16.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:51:06 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [HACK QEMU PATCH v1 1/1] hw/cxl: Fix MCTP Binding Check
Date: Thu, 26 Jun 2025 23:41:15 +0000
Message-ID: <20250626235102.1902427-2-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626235102.1902427-1-anisa.su887@gmail.com>
References: <20250626235102.1902427-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

Per the spec, FMAPI commands (0x51-0x59) must be bound with
MCTP_MT_CXL_FMAPI. Fix the conditions ensuring this in i2c_mctp_cxl.c
and dev-mctp.c

Move the opcode enum from cxl-mailbox-utils.c to cxl_mailbox.h to
allow i2c_mctp_cxl.c and dev-mctp.c to use the enum instead of
hardcoding the values.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 74 +-----------------------------------
 hw/cxl/i2c_mctp_cxl.c        |  6 ++-
 hw/usb/dev-mctp.c            |  6 ++-
 include/hw/cxl/cxl_mailbox.h | 73 +++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 77 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4c01b25110..7f84e147f7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -37,7 +37,7 @@
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
- *  1. Add the command set and cmd to the enum.
+ *  1. Add the command set and cmd to the enum in cxl_mailbox.h.
  *     FOO    = 0x7f,
  *          #define BAR 0
  *  2. Implement the handler
@@ -60,78 +60,6 @@
  *  a register interface that already deals with it.
  */
 
-enum {
-    INFOSTAT    = 0x00,
-        #define IS_IDENTIFY   0x1
-        #define BACKGROUND_OPERATION_STATUS    0x2
-        #define GET_RESPONSE_MSG_LIMIT         0x3
-        #define SET_RESPONSE_MSG_LIMIT         0x4
-        #define BACKGROUND_OPERATION_ABORT     0x5
-    EVENTS      = 0x01,
-        #define GET_RECORDS   0x0
-        #define CLEAR_RECORDS   0x1
-        #define GET_INTERRUPT_POLICY   0x2
-        #define SET_INTERRUPT_POLICY   0x3
-    FIRMWARE_UPDATE = 0x02,
-        #define GET_INFO      0x0
-        #define TRANSFER      0x1
-        #define ACTIVATE      0x2
-    TIMESTAMP   = 0x03,
-        #define GET           0x0
-        #define SET           0x1
-    LOGS        = 0x04,
-        #define GET_SUPPORTED 0x0
-        #define GET_LOG       0x1
-        #define GET_LOG_CAPABILITIES   0x2
-        #define CLEAR_LOG     0x3
-        #define POPULATE_LOG  0x4
-    FEATURES    = 0x05,
-        #define GET_SUPPORTED 0x0
-        #define GET_FEATURE   0x1
-        #define SET_FEATURE   0x2
-    IDENTIFY    = 0x40,
-        #define MEMORY_DEVICE 0x0
-    CCLS        = 0x41,
-        #define GET_PARTITION_INFO     0x0
-        #define GET_LSA       0x2
-        #define SET_LSA       0x3
-    HEALTH_INFO_ALERTS = 0x42,
-        #define GET_ALERT_CONFIG 0x1
-        #define SET_ALERT_CONFIG 0x2
-    SANITIZE    = 0x44,
-        #define OVERWRITE     0x0
-        #define SECURE_ERASE  0x1
-        #define MEDIA_OPERATIONS 0x2
-    PERSISTENT_MEM = 0x45,
-        #define GET_SECURITY_STATE     0x0
-    MEDIA_AND_POISON = 0x43,
-        #define GET_POISON_LIST        0x0
-        #define INJECT_POISON          0x1
-        #define CLEAR_POISON           0x2
-        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
-        #define SCAN_MEDIA             0x4
-        #define GET_SCAN_MEDIA_RESULTS 0x5
-    DCD_CONFIG  = 0x48,
-        #define GET_DC_CONFIG          0x0
-        #define GET_DYN_CAP_EXT_LIST   0x1
-        #define ADD_DYN_CAP_RSP        0x2
-        #define RELEASE_DYN_CAP        0x3
-    PHYSICAL_SWITCH = 0x51,
-        #define IDENTIFY_SWITCH_DEVICE      0x0
-        #define GET_PHYSICAL_PORT_STATE     0x1
-    TUNNEL = 0x53,
-        #define MANAGEMENT_COMMAND     0x0
-    MHD = 0x55,
-        #define GET_MHD_INFO 0x0
-    FMAPI_DCD_MGMT = 0x56,
-        #define GET_DCD_INFO    0x0
-        #define GET_HOST_DC_REGION_CONFIG   0x1
-        #define SET_DC_REGION_CONFIG        0x2
-        #define GET_DC_REGION_EXTENT_LIST   0x3
-        #define INITIATE_DC_ADD             0x4
-        #define INITIATE_DC_RELEASE         0x5
-};
-
 /* CCI Message Format CXL r3.1 Figure 7-19 */
 typedef struct CXLCCIMessage {
     uint8_t category;
diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
index 1714f36e8e..3f17779562 100644
--- a/hw/cxl/i2c_mctp_cxl.c
+++ b/hw/cxl/i2c_mctp_cxl.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
+#include "hw/cxl/cxl_mailbox.h"
 
 #define TYPE_I2C_MCTP_CXL "i2c_mctp_cxl"
 
@@ -198,9 +199,10 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
          */
 
         if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
-              msg->command_set < 0x51) &&
+              msg->command_set < PHYSICAL_SWITCH) &&
             !(msg->message_type == MCTP_MT_CXL_FMAPI &&
-              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
+              msg->command_set >= PHYSICAL_SWITCH &&
+              msg->command_set < GLOBAL_MEM_ACCESS_EP_MGMT)) {
             buf->rc = CXL_MBOX_UNSUPPORTED;
             st24_le_p(buf->pl_length, len_out);
             s->len = s->pos;
diff --git a/hw/usb/dev-mctp.c b/hw/usb/dev-mctp.c
index aafb9e7e96..b82a269561 100644
--- a/hw/usb/dev-mctp.c
+++ b/hw/usb/dev-mctp.c
@@ -25,6 +25,7 @@
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 #include "net/mctp.h"
+#include "hw/cxl/cxl_mailbox.h"
 
 /* TODO: Move to header */
 
@@ -504,9 +505,10 @@ static void usb_cxl_mctp_handle_data(USBDevice *dev, USBPacket *p)
          * onwards.
          */
         if (!(req->message_type == MCTP_MT_CXL_TYPE3 &&
-              req->command_set < 0x51) &&
+              req->command_set < PHYSICAL_SWITCH) &&
             !(req->message_type == MCTP_MT_CXL_FMAPI &&
-              req->command_set >= 0x51 && req->command_set < 0x56)) {
+              req->command_set >= PHYSICAL_SWITCH &&
+              req->command_set < GLOBAL_MEM_ACCESS_EP_MGMT)) {
             len_out = 0;
             usb_pkt_len = sizeof(MCTPUSBPacket) + sizeof(CXLMCTPMessage) +
                 len_out;
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index 820c411cbb..209a11ecbc 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -27,4 +27,77 @@
 #define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
 #define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
 
+enum {
+    INFOSTAT    = 0x00,
+        #define IS_IDENTIFY   0x1
+        #define BACKGROUND_OPERATION_STATUS    0x2
+        #define GET_RESPONSE_MSG_LIMIT         0x3
+        #define SET_RESPONSE_MSG_LIMIT         0x4
+        #define BACKGROUND_OPERATION_ABORT     0x5
+    EVENTS      = 0x01,
+        #define GET_RECORDS   0x0
+        #define CLEAR_RECORDS   0x1
+        #define GET_INTERRUPT_POLICY   0x2
+        #define SET_INTERRUPT_POLICY   0x3
+    FIRMWARE_UPDATE = 0x02,
+        #define GET_INFO      0x0
+        #define TRANSFER      0x1
+        #define ACTIVATE      0x2
+    TIMESTAMP   = 0x03,
+        #define GET           0x0
+        #define SET           0x1
+    LOGS        = 0x04,
+        #define GET_SUPPORTED 0x0
+        #define GET_LOG       0x1
+        #define GET_LOG_CAPABILITIES   0x2
+        #define CLEAR_LOG     0x3
+        #define POPULATE_LOG  0x4
+    FEATURES    = 0x05,
+        #define GET_SUPPORTED 0x0
+        #define GET_FEATURE   0x1
+        #define SET_FEATURE   0x2
+    IDENTIFY    = 0x40,
+        #define MEMORY_DEVICE 0x0
+    CCLS        = 0x41,
+        #define GET_PARTITION_INFO     0x0
+        #define GET_LSA       0x2
+        #define SET_LSA       0x3
+    HEALTH_INFO_ALERTS = 0x42,
+        #define GET_ALERT_CONFIG 0x1
+        #define SET_ALERT_CONFIG 0x2
+    SANITIZE    = 0x44,
+        #define OVERWRITE     0x0
+        #define SECURE_ERASE  0x1
+        #define MEDIA_OPERATIONS 0x2
+    PERSISTENT_MEM = 0x45,
+        #define GET_SECURITY_STATE     0x0
+    MEDIA_AND_POISON = 0x43,
+        #define GET_POISON_LIST        0x0
+        #define INJECT_POISON          0x1
+        #define CLEAR_POISON           0x2
+        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
+        #define SCAN_MEDIA             0x4
+        #define GET_SCAN_MEDIA_RESULTS 0x5
+    DCD_CONFIG  = 0x48,
+        #define GET_DC_CONFIG          0x0
+        #define GET_DYN_CAP_EXT_LIST   0x1
+        #define ADD_DYN_CAP_RSP        0x2
+        #define RELEASE_DYN_CAP        0x3
+    PHYSICAL_SWITCH = 0x51,
+        #define IDENTIFY_SWITCH_DEVICE      0x0
+        #define GET_PHYSICAL_PORT_STATE     0x1
+    TUNNEL = 0x53,
+        #define MANAGEMENT_COMMAND     0x0
+    MHD = 0x55,
+        #define GET_MHD_INFO 0x0
+    FMAPI_DCD_MGMT = 0x56,
+        #define GET_DCD_INFO    0x0
+        #define GET_HOST_DC_REGION_CONFIG   0x1
+        #define SET_DC_REGION_CONFIG        0x2
+        #define GET_DC_REGION_EXTENT_LIST   0x3
+        #define INITIATE_DC_ADD             0x4
+        #define INITIATE_DC_RELEASE         0x5
+    GLOBAL_MEM_ACCESS_EP_MGMT = 0X59,
+};
+
 #endif
-- 
2.47.2

