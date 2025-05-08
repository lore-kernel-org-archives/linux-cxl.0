Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC514431
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 00:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663513; cv=none; b=J1ZMbYEPeBaRKyPtJCQS6lLtuscCXdhdyGuHmAR1f8F8m95yZmwR2NR4+qvfrW/Am1fqM5RlElffe4Ttc0buifhCfiBQmuQxPmPMTDpwhSpGn/HAHFKI/6V+NVUZs5KKGUYzuwkQ/acbxHZocs4dRcJmDuClmihuwv0I00SN49g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663513; c=relaxed/simple;
	bh=kMUxZxO8+5rDSfAmt0PAi5EPA/csnu84/COe1kF+mF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/lB/d5eHjxILhfzugW5cv8cxAWb/bZTOTFIsUStxyQcdnxCuLFeQ9n2kud2PNAsaZtzU4lKWJYCdEUFIcMK9tkjodxT5pSAA2ZYFxt/oWc+51BR2AvzjJTE2l7Uzy0mWMoTxEbhZria0tuEQm0ajkZ1bh68whpapD3b9200VLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBsxJCn0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBsxJCn0"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so499061b3a.0
        for <linux-cxl@vger.kernel.org>; Wed, 07 May 2025 17:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746663511; x=1747268311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtEEVlKYAZUHq7Shr6BrNfaI6Zksrz2ZJCjIoSnfhyM=;
        b=BBsxJCn0rTfZLMgS9wh/1LILByYowRLj3TFD9bfJ/83UsuZCy2xTHXzQDdwEqi0KMJ
         gfH4LLjzUi4mmNK65wEOIhxV+8UtuOTDlEb5TDoeCaSASonr0G7E0zLTQwratzQKSibh
         ErGlg9lCTPqUWD9Tid80JFSOiE/4d+2PkmyHHIyfwshhx0BcgvE99Sr8+iz/YKtvn8IL
         YZZpmwga7IYPIUHzNldeWnFIqK8jHyLrjLdZkMsYa1yahy0mJ8tMn7O8HByn2tb3ifrb
         OrZaCwnsCNwEySQIe7ID4lwozer9WjL/qLbo1D8S7lANl7EDbPZQIuqC6YmwyBBE8kHk
         Ac4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746663511; x=1747268311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtEEVlKYAZUHq7Shr6BrNfaI6Zksrz2ZJCjIoSnfhyM=;
        b=bMiLa/PyGDigFyf/nlOIPAt4sahCpgKEX1cN2eVr1yQNqGHxYOESx/igi7FaBn0bVL
         XU4e6/GvTFu649LggbX3tc+5FUho0LZJeLKQj/DUvHjz7FnAdFBTMe6Q0sr8lMLIYGUt
         yE+qEOvgKMPGueCpIxGeamWHDIDm/vnEM8J850QBR6bnpofBK35WxD+Q01Hv678aYyUc
         Qc9TH6qDPY/mHbehoUwJtKiuH6a2cmf1Umkd9w4aRrI73MOSM/s+JNRUQvcalLUfLrdd
         0xxzHvjVb1ht3QZU/3KcuSzz0n8UZF9SuXjZ2yVTwpwc7pkbbQNQsIOMdNHx6zvplYLm
         KL/A==
X-Forwarded-Encrypted: i=1; AJvYcCUS1HVGyKr3RvTRuG7bDdKYq4jOeBFo9tReJqQu3sWNg4kj5tzholfAowky+G047JJBKhltSZ4jA5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMdK3ENTQVRu1RuKZY7Hmd+oZpwYZt1dyi/wZtW+Z5hn4nkEUJ
	HW/SVqho2Om0Mt0yVrDYn4FKlEVpQDQKRvBJZBUCPb2vbVV7AYW2
X-Gm-Gg: ASbGnctwNXeR+5TzRj8IvHQVC93BTbRC14VAZTDqX4QoOBo3VUjQRubus+vYrx5/XVs
	dv+GX/8hVla8zWVhNm5v6Thgz2YP+C5GV223jtmq7LunZproKtIWBjqVaIEnb254f4/VsxaV60/
	0M/uz9eipk3fHF4KOIBtcTDpZXmpTya8ptZNNNl5URVqw0hRLmTShCLpCXJE7xIWSROviSkRrRK
	UNvzDZCeRYiWggxOE7nZ2n/r3Y2a6ch92NHGqFkpllVw8raxW8YlBpNiftumJL0rRj/jwsctw+u
	GYO/2EwPEQnk32r8O1dr3ZjdnLTSfJsQcmEXfzuyqpn1Jun7BF/F83g8vm2dAQ==
X-Google-Smtp-Source: AGHT+IEW+VcDLQ+BTFni2xASg6piEcd9nEWvsN+hdF4hLFkmHHJBC95JTvHPmo5Nv1xuzxcW6oC33A==
X-Received: by 2002:a05:6a00:3927:b0:740:9d5f:f542 with SMTP id d2e1a72fcca58-7409d5ff567mr6956625b3a.10.1746663510741;
        Wed, 07 May 2025 17:18:30 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 17:18:30 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 01/10] cxl-mailbox-utils: Move opcodes enum to new header file
Date: Thu,  8 May 2025 00:00:57 +0000
Message-ID: <20250508001754.122180-2-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

In preparation for the next patch, move opcodes enum to new cxl_opcodes.h file
for visibility from mailbox-utils.c and i2c_mctp_cxl.c, which checks that
certain command sets are bound with the correct MCTP binding.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 68 ++----------------------------------
 include/hw/cxl/cxl_opcodes.h | 64 +++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 66 deletions(-)
 create mode 100644 include/hw/cxl/cxl_opcodes.h

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a02d130926..ed3294530f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -23,6 +23,7 @@
 #include "qemu/uuid.h"
 #include "system/hostmem.h"
 #include "qemu/range.h"
+#include "hw/cxl/cxl_opcodes.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
@@ -36,7 +37,7 @@
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
- *  1. Add the command set and cmd to the enum.
+ *  1. Add the command set and cmd to the enum in cxl_opcodes.h.
  *     FOO    = 0x7f,
  *          #define BAR 0
  *  2. Implement the handler
@@ -59,71 +60,6 @@
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
-};
-
 /* CCI Message Format CXL r3.1 Figure 7-19 */
 typedef struct CXLCCIMessage {
     uint8_t category;
diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
new file mode 100644
index 0000000000..26d3a99e8a
--- /dev/null
+++ b/include/hw/cxl/cxl_opcodes.h
@@ -0,0 +1,64 @@
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
+};
-- 
2.47.2

