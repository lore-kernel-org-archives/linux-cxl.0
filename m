Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69531C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 17:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiAXRVs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:21:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4454 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244445AbiAXRVl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 12:21:41 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjGrQ1T3sz67DqF;
        Tue, 25 Jan 2022 01:17:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:21:39 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:21:39 +0000
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
Subject: [PATCH v4 09/42] hw/cxl/device: Timestamp implementation (8.2.9.3)
Date:   Mon, 24 Jan 2022 17:16:32 +0000
Message-ID: <20220124171705.10432-10-Jonathan.Cameron@huawei.com>
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

Per spec, timestamp appears to be a free-running counter from a value
set by the host via the Set Timestamp command (0301h). There are
references to the epoch, which seem like a red herring. Therefore, the
implementation implements the timestamp as freerunning counter from the
last value that was issued by the Set Timestamp command.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 53 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  6 +++++
 2 files changed, 59 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1a87846356..cea4b2a59c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -43,6 +43,9 @@ enum {
         #define CLEAR_RECORDS   0x1
         #define GET_INTERRUPT_POLICY   0x2
         #define SET_INTERRUPT_POLICY   0x3
+    TIMESTAMP   = 0x03,
+        #define GET           0x0
+        #define SET           0x1
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -117,8 +120,11 @@ define_mailbox_handler_zeroed(EVENTS_GET_RECORDS, 0x20);
 define_mailbox_handler_nop(EVENTS_CLEAR_RECORDS);
 define_mailbox_handler_zeroed(EVENTS_GET_INTERRUPT_POLICY, 4);
 define_mailbox_handler_nop(EVENTS_SET_INTERRUPT_POLICY);
+declare_mailbox_handler(TIMESTAMP_GET);
+declare_mailbox_handler(TIMESTAMP_SET);
 
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
+#define IMMEDIATE_POLICY_CHANGE (1 << 3)
 #define IMMEDIATE_LOG_CHANGE (1 << 4)
 
 #define CXL_CMD(s, c, in, cel_effect) \
@@ -129,10 +135,57 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     CXL_CMD(EVENTS, CLEAR_RECORDS, ~0, IMMEDIATE_LOG_CHANGE),
     CXL_CMD(EVENTS, GET_INTERRUPT_POLICY, 0, 0),
     CXL_CMD(EVENTS, SET_INTERRUPT_POLICY, 4, IMMEDIATE_CONFIG_CHANGE),
+    CXL_CMD(TIMESTAMP, GET, 0, 0),
+    CXL_CMD(TIMESTAMP, SET, 8, IMMEDIATE_POLICY_CHANGE),
 };
 
 #undef CXL_CMD
 
+/*
+ * 8.2.9.3.1
+ */
+define_mailbox_handler(TIMESTAMP_GET)
+{
+    struct timespec ts;
+    uint64_t delta;
+
+    if (!cxl_dstate->timestamp.set) {
+        *(uint64_t *)cmd->payload = 0;
+        goto done;
+    }
+
+    /* First find the delta from the last time the host set the time. */
+    clock_gettime(CLOCK_REALTIME, &ts);
+    delta = (ts.tv_sec * NANOSECONDS_PER_SECOND + ts.tv_nsec) -
+            cxl_dstate->timestamp.last_set;
+
+    /* Then adjust the actual time */
+    stq_le_p(cmd->payload, cxl_dstate->timestamp.host_set + delta);
+
+done:
+    *len = 8;
+    return CXL_MBOX_SUCCESS;
+}
+
+/*
+ * 8.2.9.3.2
+ */
+define_mailbox_handler(TIMESTAMP_SET)
+{
+    struct timespec ts;
+
+    clock_gettime(CLOCK_REALTIME, &ts);
+
+    cxl_dstate->timestamp.set = true;
+    cxl_dstate->timestamp.last_set =
+        ts.tv_sec * NANOSECONDS_PER_SECOND + ts.tv_nsec;
+
+    cxl_dstate->timestamp.host_set = le64_to_cpu(*(uint64_t *)cmd->payload);
+
+    *len = 0;
+    return CXL_MBOX_SUCCESS;
+}
+
 QemuUUID cel_uuid;
 
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index f88f844cb6..3dde7fb1fb 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -114,6 +114,12 @@ typedef struct cxl_device_state {
         size_t cel_size;
     };
 
+    struct {
+        bool set;
+        uint64_t last_set;
+        uint64_t host_set;
+    } timestamp;
+
     /* memory region for persistent memory, HDM */
     uint64_t pmem_size;
 } CXLDeviceState;
-- 
2.32.0

