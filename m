Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A85C05027
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 18:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBQSSh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 13:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQSSg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 13:18:36 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1E14D616
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 10:18:35 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PJKh255Rnz67ZcT;
        Sat, 18 Feb 2023 02:13:54 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Feb 2023 18:18:33 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>, <alison.schofield@intel.com>
Subject: [PATCH 1/6] hw/cxl: Move enum ret_code definition to cxl_device.h
Date:   Fri, 17 Feb 2023 18:18:07 +0000
Message-ID: <20230217181812.26995-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230217181812.26995-1-Jonathan.Cameron@huawei.com>
References: <20230217181812.26995-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Needs tidy up and rename to something more generic now it is
in a header.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 28 ----------------------------
 include/hw/cxl/cxl_device.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index cc9c8b7380..d9bd5daa0d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -64,34 +64,6 @@ enum {
         #define SET_LSA       0x3
 };
 
-/* 8.2.8.4.5.1 Command Return Codes */
-typedef enum {
-    CXL_MBOX_SUCCESS = 0x0,
-    CXL_MBOX_BG_STARTED = 0x1,
-    CXL_MBOX_INVALID_INPUT = 0x2,
-    CXL_MBOX_UNSUPPORTED = 0x3,
-    CXL_MBOX_INTERNAL_ERROR = 0x4,
-    CXL_MBOX_RETRY_REQUIRED = 0x5,
-    CXL_MBOX_BUSY = 0x6,
-    CXL_MBOX_MEDIA_DISABLED = 0x7,
-    CXL_MBOX_FW_XFER_IN_PROGRESS = 0x8,
-    CXL_MBOX_FW_XFER_OUT_OF_ORDER = 0x9,
-    CXL_MBOX_FW_AUTH_FAILED = 0xa,
-    CXL_MBOX_FW_INVALID_SLOT = 0xb,
-    CXL_MBOX_FW_ROLLEDBACK = 0xc,
-    CXL_MBOX_FW_REST_REQD = 0xd,
-    CXL_MBOX_INVALID_HANDLE = 0xe,
-    CXL_MBOX_INVALID_PA = 0xf,
-    CXL_MBOX_INJECT_POISON_LIMIT = 0x10,
-    CXL_MBOX_PERMANENT_MEDIA_FAILURE = 0x11,
-    CXL_MBOX_ABORTED = 0x12,
-    CXL_MBOX_INVALID_SECURITY_STATE = 0x13,
-    CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
-    CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
-    CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
-    CXL_MBOX_MAX = 0x17
-} ret_code;
-
 struct cxl_cmd;
 typedef ret_code (*opcode_handler)(struct cxl_cmd *cmd,
                                    CXLDeviceState *cxl_dstate, uint16_t *len);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index edb9791bab..d01c6b29c5 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -82,6 +82,34 @@
     (CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_STATUS_REGISTERS_LENGTH +     \
      CXL_MAILBOX_REGISTERS_LENGTH + CXL_MEMORY_DEVICE_REGISTERS_LENGTH)
 
+/* 8.2.8.4.5.1 Command Return Codes */
+typedef enum {
+    CXL_MBOX_SUCCESS = 0x0,
+    CXL_MBOX_BG_STARTED = 0x1,
+    CXL_MBOX_INVALID_INPUT = 0x2,
+    CXL_MBOX_UNSUPPORTED = 0x3,
+    CXL_MBOX_INTERNAL_ERROR = 0x4,
+    CXL_MBOX_RETRY_REQUIRED = 0x5,
+    CXL_MBOX_BUSY = 0x6,
+    CXL_MBOX_MEDIA_DISABLED = 0x7,
+    CXL_MBOX_FW_XFER_IN_PROGRESS = 0x8,
+    CXL_MBOX_FW_XFER_OUT_OF_ORDER = 0x9,
+    CXL_MBOX_FW_AUTH_FAILED = 0xa,
+    CXL_MBOX_FW_INVALID_SLOT = 0xb,
+    CXL_MBOX_FW_ROLLEDBACK = 0xc,
+    CXL_MBOX_FW_REST_REQD = 0xd,
+    CXL_MBOX_INVALID_HANDLE = 0xe,
+    CXL_MBOX_INVALID_PA = 0xf,
+    CXL_MBOX_INJECT_POISON_LIMIT = 0x10,
+    CXL_MBOX_PERMANENT_MEDIA_FAILURE = 0x11,
+    CXL_MBOX_ABORTED = 0x12,
+    CXL_MBOX_INVALID_SECURITY_STATE = 0x13,
+    CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
+    CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
+    CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
+    CXL_MBOX_MAX = 0x17
+} ret_code;
+
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
-- 
2.37.2

