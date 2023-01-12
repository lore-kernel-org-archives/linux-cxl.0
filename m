Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AC4C54EBD
	for <linux-cxl@archiver.kernel.org>; Thu, 12 Jan 2023 10:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbjALKhH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 Jan 2023 05:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjALKgY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 Jan 2023 05:36:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC90159D28
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jan 2023 02:30:50 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nt13G4SGTz686rg;
        Thu, 12 Jan 2023 18:28:10 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 12 Jan 2023 10:30:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 8/8] hw/cxl/mailbox: Use new UUID network order define for cel_uuid
Date:   Thu, 12 Jan 2023 10:26:44 +0000
Message-ID: <20230112102644.27830-9-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230112102644.27830-1-Jonathan.Cameron@huawei.com>
References: <20230112102644.27830-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The cel_uuid was programatically generated previously because there was
no static initializer for network order UUIDs.

Use the new network order initializer for cel_uuid.  Adjust
cxl_initialize_mailbox() because it can't fail now.

Update specification reference.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2:
Make it const (Philippe)

 hw/cxl/cxl-device-utils.c   |  2 +-
 hw/cxl/cxl-mailbox-utils.c  | 13 ++++++-------
 include/hw/cxl/cxl_device.h |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 83ce7a8270..4c5e88aaf5 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -267,5 +267,5 @@ void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000);
     memdev_reg_init_common(cxl_dstate);
 
-    assert(cxl_initialize_mailbox(cxl_dstate) == 0);
+    cxl_initialize_mailbox(cxl_dstate);
 }
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3f67b665f5..206e04a4b8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -193,7 +193,11 @@ static ret_code cmd_timestamp_set(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static QemuUUID cel_uuid;
+/* CXL 3.0 8.2.9.5.2.1 Command Effects Log (CEL) */
+static const QemuUUID cel_uuid = {
+    .data = UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
+                 0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
+};
 
 /* 8.2.9.4.1 */
 static ret_code cmd_logs_get_supported(struct cxl_cmd *cmd,
@@ -458,11 +462,8 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
                      DOORBELL, 0);
 }
 
-int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate)
+void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate)
 {
-    /* CXL 2.0: Table 169 Get Supported Logs Log Entry */
-    const char *cel_uuidstr = "0da9c0b5-bf41-4b78-8f79-96b1623b3f17";
-
     for (int set = 0; set < 256; set++) {
         for (int cmd = 0; cmd < 256; cmd++) {
             if (cxl_cmd_set[set][cmd].handler) {
@@ -476,6 +477,4 @@ int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate)
             }
         }
     }
-
-    return qemu_uuid_parse(cel_uuidstr, &cel_uuid);
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 250adf18b2..7e5ad65c1d 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -170,7 +170,7 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
                                       CXL_DEVICE_CAP_HDR1_OFFSET +
                                           CXL_DEVICE_CAP_REG_SIZE * 2)
 
-int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate);
+void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate);
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
 
 #define cxl_device_cap_init(dstate, reg, cap_id)                           \
-- 
2.37.2

