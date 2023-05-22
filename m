Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7554C77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 15:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjEVPK6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 11:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbjEVPKx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 11:10:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCD9CE
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 08:10:50 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QQ17873xDz67tlm;
        Mon, 22 May 2023 23:08:52 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 16:10:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: [PATCH v7 2/7] hw/cxl: Move CXLRetCode definition to cxl_device.h
Date:   Mon, 22 May 2023 16:09:42 +0100
Message-ID: <20230522150947.11546-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Following patches will need access to the mailbox return code
type so move it to the header.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h | 28 ++++++++++++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c  | 28 ----------------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 16993f7098..9f8ee85f8a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -83,6 +83,34 @@
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
+} CXLRetCode;
+
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e3401b6be8..d7e114aaae 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -68,34 +68,6 @@ enum {
         #define CLEAR_POISON           0x2
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
-} CXLRetCode;
-
 struct cxl_cmd;
 typedef CXLRetCode (*opcode_handler)(struct cxl_cmd *cmd,
                                    CXLDeviceState *cxl_dstate, uint16_t *len);
-- 
2.39.2

