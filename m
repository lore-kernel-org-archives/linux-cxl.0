Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77966C433E9
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E3B64EE0
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhBBBBC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:01:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:21927 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhBBBBC (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:01:02 -0500
IronPort-SDR: +fIwtrynx/VyHS14UQV5IbePsKfKzihWAhleGf87jwcUxySG2JmNz1Skxx6oRfiqm6PmyKDTLm
 ZDXJj9l1At8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294604"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294604"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:00 -0800
IronPort-SDR: mmUmXCN6J2aJPC/ijizScyMOh8a5yeq8Jfhd/bSRJrt5lPYT6Uovz6ZiY4ubdqmo2Xo6wUVAgU
 HCUDzXSmFCYw==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764074"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 16:59:59 -0800
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
Subject: [RFC PATCH v3 07/31] hw/cxl/device: Add cheap EVENTS implementation (8.2.9.1)
Date:   Mon,  1 Feb 2021 16:59:24 -0800
Message-Id: <20210202005948.241655-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Using the previously implemented stubbed helpers, it is now possible to
easily add the missing, required commands to the implementation.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 466055b01a..7c939a1851 100644
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
2.30.0

