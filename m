Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761F6C43381
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466CB64E93
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhBBBCG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:02:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:21927 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhBBBCF (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:02:05 -0500
IronPort-SDR: V/hvqJVzvAtOWP0fVQyf8Y55iQqZpYxrd3jGN6PEDqgplazHP9A1WuSUWKSAsVtU7O/RGHHDmM
 1yYwbMprUYPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294667"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294667"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:21 -0800
IronPort-SDR: o8unHbL+Q7kfvn/BzE0nugN5IyABc3t75wJiLb2iU2DkxyzQ0LnwUzjx0UOP8+XpHs3E6r/8pq
 h8tnnGZoP38Q==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764272"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:20 -0800
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
Subject: [RFC PATCH v3 27/31] hw/cxl/device: Add some trivial commands
Date:   Mon,  1 Feb 2021 16:59:44 -0800
Message-Id: <20210202005948.241655-28-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

GET_FW_INFO and GET_PARTITION_INFO, for this emulation, is equivalent to
info already returned in the IDENTIFY command. To have a more robust
implementation, add those.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c | 65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f92dfad882..dc8e0eb08e 100644
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
+    if (memory_region_size(cxl_dstate->pmem) < (256 << 20)) {
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
@@ -296,6 +337,30 @@ define_mailbox_handler(IDENTIFY_MEMORY_DEVICE)
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
+
+    if (memory_region_size(cxl_dstate->pmem) < (256 << 20)) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    /* PMEM only */
+    part_info->active_vmem = 0;
+    part_info->next_vmem = 0;
+    part_info->active_pmem = memory_region_size(cxl_dstate->pmem);
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
2.30.0

