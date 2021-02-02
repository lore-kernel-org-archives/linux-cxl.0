Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30099C4332D
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB6264EDB
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBBBBH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:01:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:21898 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhBBBBG (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:01:06 -0500
IronPort-SDR: /dsx27HAdkOa4Inz80t2+xxOxE94LIhRdEuseBqxZM7vmWJ30wWAOofa12DsZ1o/a9fS1cKc/1
 JqlCCBgsgX6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294605"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294605"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:01 -0800
IronPort-SDR: fYUZo2NQT8l1vaRAfsED29X/QgKuTjllbLSRVh17fDsH3Ir0DQyZHgGu1r8ZfjYNWk/Y2G2h7X
 VBLOllaF3p1A==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764084"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:00 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     qemu-devel@nongnu.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH v3 08/31] hw/cxl/device: Timestamp implementation (8.2.9.3)
Date:   Mon,  1 Feb 2021 16:59:25 -0800
Message-Id: <20210202005948.241655-9-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Per spec, timestamp appears to be a free-running counter from a value
set by the host via the Set Timestamp command (0301h). There are
references to the epoch, which seem like a red herring. Therefore, the
implementation implements the timestamp as freerunning counter from the
last value that was issued by the Set Timestamp command.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 53 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  6 +++++
 2 files changed, 59 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 7c939a1851..3d36614c0c 100644
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
index 0cc5354ba4..ca5328a581 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -107,6 +107,12 @@ typedef struct cxl_device_state {
         size_t cel_size;
     };
 
+    struct {
+        bool set;
+        uint64_t last_set;
+        uint64_t host_set;
+    } timestamp;
+
     /* memory region for persistent memory, HDM */
     MemoryRegion *pmem;
 
-- 
2.30.0

