Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6320DC433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 17:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbiAXR3x (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:29:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4470 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiAXR3x (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 12:29:53 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjH6L52mPz687Q6;
        Tue, 25 Jan 2022 01:29:30 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:29:51 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:29:50 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v4 25/42] hw/cxl/device: Add some trivial commands
Date:   Mon, 24 Jan 2022 17:16:48 +0000
Message-ID: <20220124171705.10432-26-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
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
 hw/cxl/cxl-mailbox-utils.c | 66 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c03ba00912..cbda963d8c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -43,6 +43,8 @@ enum {
         #define CLEAR_RECORDS   0x1
         #define GET_INTERRUPT_POLICY   0x2
         #define SET_INTERRUPT_POLICY   0x3
+    FIRMWARE_UPDATE = 0x02,
+        #define GET_INFO      0x0
     TIMESTAMP   = 0x03,
         #define GET           0x0
         #define SET           0x1
@@ -51,6 +53,8 @@ enum {
         #define GET_LOG       0x1
     IDENTIFY    = 0x40,
         #define MEMORY_DEVICE 0x0
+    CCLS        = 0x41,
+        #define GET_PARTITION_INFO     0x0
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -125,11 +129,13 @@ define_mailbox_handler_zeroed(EVENTS_GET_RECORDS, 0x20);
 define_mailbox_handler_nop(EVENTS_CLEAR_RECORDS);
 define_mailbox_handler_zeroed(EVENTS_GET_INTERRUPT_POLICY, 4);
 define_mailbox_handler_nop(EVENTS_SET_INTERRUPT_POLICY);
+declare_mailbox_handler(FIRMWARE_UPDATE_GET_INFO);
 declare_mailbox_handler(TIMESTAMP_GET);
 declare_mailbox_handler(TIMESTAMP_SET);
 declare_mailbox_handler(LOGS_GET_SUPPORTED);
 declare_mailbox_handler(LOGS_GET_LOG);
 declare_mailbox_handler(IDENTIFY_MEMORY_DEVICE);
+declare_mailbox_handler(CCLS_GET_PARTITION_INFO);
 
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -143,15 +149,50 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     CXL_CMD(EVENTS, CLEAR_RECORDS, ~0, IMMEDIATE_LOG_CHANGE),
     CXL_CMD(EVENTS, GET_INTERRUPT_POLICY, 0, 0),
     CXL_CMD(EVENTS, SET_INTERRUPT_POLICY, 4, IMMEDIATE_CONFIG_CHANGE),
+    CXL_CMD(FIRMWARE_UPDATE, GET_INFO, 0, 0),
     CXL_CMD(TIMESTAMP, GET, 0, 0),
     CXL_CMD(TIMESTAMP, SET, 8, IMMEDIATE_POLICY_CHANGE),
     CXL_CMD(LOGS, GET_SUPPORTED, 0, 0),
     CXL_CMD(LOGS, GET_LOG, 0x18, 0),
     CXL_CMD(IDENTIFY, MEMORY_DEVICE, 0, 0),
+    CXL_CMD(CCLS, GET_PARTITION_INFO, 0, 0),
 };
 
 #undef CXL_CMD
 
+/*
+ * 8.2.9.2.1
+ */
+define_mailbox_handler(FIRMWARE_UPDATE_GET_INFO)
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
+    } __attribute__((packed)) *fw_info;
+    _Static_assert(sizeof(*fw_info) == 0x50, "Bad firmware info size");
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
+    snprintf(fw_info->fw_rev1, 0x10, "BWFW VERSION %02d", 0);
+
+    *len = sizeof(*fw_info);
+    return CXL_MBOX_SUCCESS;
+}
+
 /*
  * 8.2.9.3.1
  */
@@ -299,6 +340,31 @@ define_mailbox_handler(IDENTIFY_MEMORY_DEVICE)
     return CXL_MBOX_SUCCESS;
 }
 
+define_mailbox_handler(CCLS_GET_PARTITION_INFO)
+{
+    struct {
+        uint64_t active_vmem;
+        uint64_t active_pmem;
+        uint64_t next_vmem;
+        uint64_t next_pmem;
+    } __attribute__((packed)) *part_info = (void *)cmd->payload;
+    _Static_assert(sizeof(*part_info) == 0x20, "Bad get partition info size");
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
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
 {
     uint16_t ret = CXL_MBOX_SUCCESS;
-- 
2.32.0

