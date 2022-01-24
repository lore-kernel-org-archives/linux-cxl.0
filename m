Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0A6C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 17:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244547AbiAXRVk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:21:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4453 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244574AbiAXRVL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 12:21:11 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjGrp46Rgz67bS4;
        Tue, 25 Jan 2022 01:17:46 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:21:09 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:21:08 +0000
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
Subject: [PATCH v4 08/42] hw/cxl/device: Add cheap EVENTS implementation (8.2.9.1)
Date:   Mon, 24 Jan 2022 17:16:31 +0000
Message-ID: <20220124171705.10432-9-Jonathan.Cameron@huawei.com>
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

Using the previously implemented stubbed helpers, it is now possible to
easily add the missing, required commands to the implementation.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2854682cbe..1a87846356 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -37,6 +37,14 @@
  *  a register interface that already deals with it.
  */
 
+enum {
+    EVENTS      = 0x01,
+        #define GET_RECORDS   0x0
+        #define CLEAR_RECORDS   0x1
+        #define GET_INTERRUPT_POLICY   0x2
+        #define SET_INTERRUPT_POLICY   0x3
+};
+
 /* 8.2.8.4.5.1 Command Return Codes */
 typedef enum {
     CXL_MBOX_SUCCESS = 0x0,
@@ -105,10 +113,23 @@ struct cxl_cmd {
         return CXL_MBOX_SUCCESS;                                          \
     }
 
+define_mailbox_handler_zeroed(EVENTS_GET_RECORDS, 0x20);
+define_mailbox_handler_nop(EVENTS_CLEAR_RECORDS);
+define_mailbox_handler_zeroed(EVENTS_GET_INTERRUPT_POLICY, 4);
+define_mailbox_handler_nop(EVENTS_SET_INTERRUPT_POLICY);
+
+#define IMMEDIATE_CONFIG_CHANGE (1 << 1)
+#define IMMEDIATE_LOG_CHANGE (1 << 4)
+
 #define CXL_CMD(s, c, in, cel_effect) \
     [s][c] = { stringify(s##_##c), cmd_##s##_##c, in, cel_effect }
 
-static struct cxl_cmd cxl_cmd_set[256][256] = {};
+static struct cxl_cmd cxl_cmd_set[256][256] = {
+    CXL_CMD(EVENTS, GET_RECORDS, 1, 0),
+    CXL_CMD(EVENTS, CLEAR_RECORDS, ~0, IMMEDIATE_LOG_CHANGE),
+    CXL_CMD(EVENTS, GET_INTERRUPT_POLICY, 0, 0),
+    CXL_CMD(EVENTS, SET_INTERRUPT_POLICY, 4, IMMEDIATE_CONFIG_CHANGE),
+};
 
 #undef CXL_CMD
 
-- 
2.32.0

