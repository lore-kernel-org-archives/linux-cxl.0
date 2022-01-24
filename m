Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F41EC433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 17:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbiAXRWN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:22:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4455 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbiAXRWM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 12:22:12 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjGs12znqz6FGWt;
        Tue, 25 Jan 2022 01:17:57 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:22:10 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:22:09 +0000
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
Subject: [PATCH v4 10/42] hw/cxl/device: Add log commands (8.2.9.4) + CEL
Date:   Mon, 24 Jan 2022 17:16:33 +0000
Message-ID: <20220124171705.10432-11-Jonathan.Cameron@huawei.com>
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

CXL specification provides for the ability to obtain logs from the
device. Logs are either spec defined, like the "Command Effects Log"
(CEL), or vendor specific. UUIDs are defined for all log types.

The CEL is a mechanism to provide information to the host about which
commands are supported. It is useful both to determine which spec'd
optional commands are supported, as well as provide a list of vendor
specified commands that might be used. The CEL is already created as
part of mailbox initialization, but here it is now exported to hosts
that use these log commands.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 67 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index cea4b2a59c..0ab0592e6c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -46,6 +46,9 @@ enum {
     TIMESTAMP   = 0x03,
         #define GET           0x0
         #define SET           0x1
+    LOGS        = 0x04,
+        #define GET_SUPPORTED 0x0
+        #define GET_LOG       0x1
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -122,6 +125,8 @@ define_mailbox_handler_zeroed(EVENTS_GET_INTERRUPT_POLICY, 4);
 define_mailbox_handler_nop(EVENTS_SET_INTERRUPT_POLICY);
 declare_mailbox_handler(TIMESTAMP_GET);
 declare_mailbox_handler(TIMESTAMP_SET);
+declare_mailbox_handler(LOGS_GET_SUPPORTED);
+declare_mailbox_handler(LOGS_GET_LOG);
 
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -137,6 +142,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     CXL_CMD(EVENTS, SET_INTERRUPT_POLICY, 4, IMMEDIATE_CONFIG_CHANGE),
     CXL_CMD(TIMESTAMP, GET, 0, 0),
     CXL_CMD(TIMESTAMP, SET, 8, IMMEDIATE_POLICY_CHANGE),
+    CXL_CMD(LOGS, GET_SUPPORTED, 0, 0),
+    CXL_CMD(LOGS, GET_LOG, 0x18, 0),
 };
 
 #undef CXL_CMD
@@ -188,6 +195,66 @@ define_mailbox_handler(TIMESTAMP_SET)
 
 QemuUUID cel_uuid;
 
+/* 8.2.9.4.1 */
+define_mailbox_handler(LOGS_GET_SUPPORTED)
+{
+    struct {
+        uint16_t entries;
+        uint8_t rsvd[6];
+        struct {
+            QemuUUID uuid;
+            uint32_t size;
+        } log_entries[1];
+    } __attribute__((packed)) *supported_logs = (void *)cmd->payload;
+    _Static_assert(sizeof(*supported_logs) == 0x1c, "Bad supported log size");
+
+    supported_logs->entries = 1;
+    supported_logs->log_entries[0].uuid = cel_uuid;
+    supported_logs->log_entries[0].size = 4 * cxl_dstate->cel_size;
+
+    *len = sizeof(*supported_logs);
+    return CXL_MBOX_SUCCESS;
+}
+
+/* 8.2.9.4.2 */
+define_mailbox_handler(LOGS_GET_LOG)
+{
+    struct {
+        QemuUUID uuid;
+        uint32_t offset;
+        uint32_t length;
+    } __attribute__((packed, __aligned__(16))) *get_log = (void *)cmd->payload;
+
+    /*
+     * 8.2.9.4.2
+     *   The device shall return Invalid Parameter if the Offset or Length
+     *   fields attempt to access beyond the size of the log as reported by Get
+     *   Supported Logs.
+     *
+     * XXX: Spec is wrong, "Invalid Parameter" isn't a thing.
+     * XXX: Spec doesn't address incorrect UUID incorrectness.
+     *
+     * The CEL buffer is large enough to fit all commands in the emulation, so
+     * the only possible failure would be if the mailbox itself isn't big
+     * enough.
+     */
+    if (get_log->offset + get_log->length > cxl_dstate->payload_size) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (!qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /* Store off everything to local variables so we can wipe out the payload */
+    *len = get_log->length;
+
+    memmove(cmd->payload, cxl_dstate->cel_log + get_log->offset,
+           get_log->length);
+
+    return CXL_MBOX_SUCCESS;
+}
+
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
 {
     uint16_t ret = CXL_MBOX_SUCCESS;
-- 
2.32.0

