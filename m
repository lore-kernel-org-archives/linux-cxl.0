Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6B6C6FA8E
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Mar 2023 10:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCBKSO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Mar 2023 05:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCBKSO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Mar 2023 05:18:14 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8036DD52C
        for <linux-cxl@vger.kernel.org>; Thu,  2 Mar 2023 02:18:12 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PS6Vt0Qmpz6J72j;
        Thu,  2 Mar 2023 18:17:58 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 10:18:09 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 2/6] hw/cxl: Introduce cxl_device_get_timestamp() utility function
Date:   Thu, 2 Mar 2023 10:17:06 +0000
Message-ID: <20230302101710.1652-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230302101710.1652-1-Jonathan.Cameron@huawei.com>
References: <20230302101710.1652-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

There are new users of this functionality coming shortly so factor
it out from the GET_TIMESTAMP mailbox command handling.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v8:
Picked up tag from Fan Ni
---
 hw/cxl/cxl-device-utils.c   | 15 +++++++++++++++
 hw/cxl/cxl-mailbox-utils.c  | 11 +----------
 include/hw/cxl/cxl_device.h |  2 ++
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 4c5e88aaf5..86e1cea8ce 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -269,3 +269,18 @@ void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
 
     cxl_initialize_mailbox(cxl_dstate);
 }
+
+uint64_t cxl_device_get_timestamp(CXLDeviceState *cxl_dstate)
+{
+    uint64_t time, delta;
+    uint64_t final_time = 0;
+
+    if (cxl_dstate->timestamp.set) {
+        /* Find the delta from the last time the host set the time. */
+        time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        delta = time - cxl_dstate->timestamp.last_set;
+        final_time = cxl_dstate->timestamp.host_set + delta;
+    }
+
+    return final_time;
+}
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 7b2aef0d67..702e16ca20 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -163,17 +163,8 @@ static CXLRetCode cmd_timestamp_get(struct cxl_cmd *cmd,
                                     CXLDeviceState *cxl_dstate,
                                     uint16_t *len)
 {
-    uint64_t time, delta;
-    uint64_t final_time = 0;
-
-    if (cxl_dstate->timestamp.set) {
-        /* First find the delta from the last time the host set the time. */
-        time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        delta = time - cxl_dstate->timestamp.last_set;
-        final_time = cxl_dstate->timestamp.host_set + delta;
-    }
+    uint64_t final_time = cxl_device_get_timestamp(cxl_dstate);
 
-    /* Then adjust the actual time */
     stq_le_p(cmd->payload, final_time);
     *len = 8;
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index edb9791bab..02befda0f6 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -287,4 +287,6 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs);
 
+uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
+
 #endif
-- 
2.37.2

