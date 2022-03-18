Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0627C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Mar 2022 15:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbiCRPRb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Mar 2022 11:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbiCRPRb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Mar 2022 11:17:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E4B89CD6
        for <linux-cxl@vger.kernel.org>; Fri, 18 Mar 2022 08:16:12 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KKnbl3mbtz67KX2;
        Fri, 18 Mar 2022 23:14:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 18 Mar 2022 16:16:10 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 15:16:09 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v8 19/46] hw/cxl/device: Add some trivial commands
Date:   Fri, 18 Mar 2022 15:06:08 +0000
Message-ID: <20220318150635.24600-20-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

GET_FW_INFO and GET_PARTITION_INFO, for this emulation, is equivalent to
info already returned in the IDENTIFY command. To have a more robust
implementation, add those.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 7ed9606c6b..fcd41d9a9d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/cxl/cxl.h"
 #include "hw/pci/pci.h"
+#include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/uuid.h"
 
@@ -44,6 +45,8 @@ enum {
         #define CLEAR_RECORDS   0x1
         #define GET_INTERRUPT_POLICY   0x2
         #define SET_INTERRUPT_POLICY   0x3
+    FIRMWARE_UPDATE = 0x02,
+        #define GET_INFO      0x0
     TIMESTAMP   = 0x03,
         #define GET           0x0
         #define SET           0x1
@@ -52,6 +55,8 @@ enum {
         #define GET_LOG       0x1
     IDENTIFY    = 0x40,
         #define MEMORY_DEVICE 0x0
+    CCLS        = 0x41,
+        #define GET_PARTITION_INFO     0x0
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -114,6 +119,39 @@ DEFINE_MAILBOX_HANDLER_NOP(events_clear_records);
 DEFINE_MAILBOX_HANDLER_ZEROED(events_get_interrupt_policy, 4);
 DEFINE_MAILBOX_HANDLER_NOP(events_set_interrupt_policy);
 
+/* 8.2.9.2.1 */
+static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
+                                             CXLDeviceState *cxl_dstate,
+                                             uint16_t *len)
+{
+    struct {
+        uint8_t slots_supported;
+        uint8_t slot_info;
+        uint8_t caps;
+        uint8_t rsvd[0xd];
+        char fw_rev1[0x10];
+        char fw_rev2[0x10];
+        char fw_rev3[0x10];
+        char fw_rev4[0x10];
+    } QEMU_PACKED *fw_info;
+    QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
+
+    if (cxl_dstate->pmem_size < (256 << 20)) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    fw_info = (void *)cmd->payload;
+    memset(fw_info, 0, sizeof(*fw_info));
+
+    fw_info->slots_supported = 2;
+    fw_info->slot_info = BIT(0) | BIT(3);
+    fw_info->caps = 0;
+    pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
+
+    *len = sizeof(*fw_info);
+    return CXL_MBOX_SUCCESS;
+}
+
 /* 8.2.9.3.1 */
 static ret_code cmd_timestamp_get(struct cxl_cmd *cmd,
                                   CXLDeviceState *cxl_dstate,
@@ -258,6 +296,33 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
+                                           CXLDeviceState *cxl_dstate,
+                                           uint16_t *len)
+{
+    struct {
+        uint64_t active_vmem;
+        uint64_t active_pmem;
+        uint64_t next_vmem;
+        uint64_t next_pmem;
+    } QEMU_PACKED *part_info = (void *)cmd->payload;
+    QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
+    uint64_t size = cxl_dstate->pmem_size;
+
+    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    /* PMEM only */
+    part_info->active_vmem = 0;
+    part_info->next_vmem = 0;
+    part_info->active_pmem = size / (256 << 20);
+    part_info->next_pmem = part_info->active_pmem;
+
+    *len = sizeof(*part_info);
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
 #define IMMEDIATE_LOG_CHANGE (1 << 4)
@@ -271,12 +336,16 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_events_get_interrupt_policy, 0, 0 },
     [EVENTS][SET_INTERRUPT_POLICY] = { "EVENTS_SET_INTERRUPT_POLICY",
         cmd_events_set_interrupt_policy, 4, IMMEDIATE_CONFIG_CHANGE },
+    [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
+        cmd_firmware_update_get_info, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8, IMMEDIATE_POLICY_CHANGE },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
     [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
         cmd_identify_memory_device, 0, 0 },
+    [CCLS][GET_PARTITION_INFO] = { "CCLS_GET_PARTITION_INFO",
+        cmd_ccls_get_partition_info, 0, 0 },
 };
 
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
-- 
2.32.0

