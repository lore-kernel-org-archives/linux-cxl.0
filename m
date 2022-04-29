Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35705C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Apr 2022 14:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377784AbiD2Oth (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Apr 2022 10:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377855AbiD2OtJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Apr 2022 10:49:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C35780720
        for <linux-cxl@vger.kernel.org>; Fri, 29 Apr 2022 07:45:49 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KqZtp0cyPz67Q6Z;
        Fri, 29 Apr 2022 22:41:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 16:45:47 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 15:45:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <k.jensen@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v10 09/45] hw/cxl/device: Timestamp implementation (8.2.9.3)
Date:   Fri, 29 Apr 2022 15:40:34 +0100
Message-ID: <20220429144110.25167-10-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
References: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Errata F4 to CXL 2.0 clarified the meaning of the timer as the
sum of the value set with the timestamp set command and the number
of nano seconds since it was last set.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/cxl/cxl-mailbox-utils.c  | 42 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  6 ++++++
 2 files changed, 48 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index fb1f53f48e..4584aa31f7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -44,6 +44,9 @@ enum {
         #define CLEAR_RECORDS   0x1
         #define GET_INTERRUPT_POLICY   0x2
         #define SET_INTERRUPT_POLICY   0x3
+    TIMESTAMP   = 0x03,
+        #define GET           0x0
+        #define SET           0x1
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -106,9 +109,46 @@ DEFINE_MAILBOX_HANDLER_NOP(events_clear_records);
 DEFINE_MAILBOX_HANDLER_ZEROED(events_get_interrupt_policy, 4);
 DEFINE_MAILBOX_HANDLER_NOP(events_set_interrupt_policy);
 
+/* 8.2.9.3.1 */
+static ret_code cmd_timestamp_get(struct cxl_cmd *cmd,
+                                  CXLDeviceState *cxl_dstate,
+                                  uint16_t *len)
+{
+    uint64_t time, delta;
+    uint64_t final_time = 0;
+
+    if (cxl_dstate->timestamp.set) {
+        /* First find the delta from the last time the host set the time. */
+        time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        delta = time - cxl_dstate->timestamp.last_set;
+        final_time = cxl_dstate->timestamp.host_set + delta;
+    }
+
+    /* Then adjust the actual time */
+    stq_le_p(cmd->payload, final_time);
+    *len = 8;
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* 8.2.9.3.2 */
+static ret_code cmd_timestamp_set(struct cxl_cmd *cmd,
+                                  CXLDeviceState *cxl_dstate,
+                                  uint16_t *len)
+{
+    cxl_dstate->timestamp.set = true;
+    cxl_dstate->timestamp.last_set = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    cxl_dstate->timestamp.host_set = le64_to_cpu(*(uint64_t *)cmd->payload);
+
+    *len = 0;
+    return CXL_MBOX_SUCCESS;
+}
+
 static QemuUUID cel_uuid;
 
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
+#define IMMEDIATE_POLICY_CHANGE (1 << 3)
 #define IMMEDIATE_LOG_CHANGE (1 << 4)
 
 static struct cxl_cmd cxl_cmd_set[256][256] = {
@@ -120,6 +160,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_events_get_interrupt_policy, 0, 0 },
     [EVENTS][SET_INTERRUPT_POLICY] = { "EVENTS_SET_INTERRUPT_POLICY",
         cmd_events_set_interrupt_policy, 4, IMMEDIATE_CONFIG_CHANGE },
+    [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
+    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8, IMMEDIATE_POLICY_CHANGE },
 };
 
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 954205653e..797a22ddb4 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -111,6 +111,12 @@ typedef struct cxl_device_state {
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

