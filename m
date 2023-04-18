Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442B7C77B75
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 17:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjDRRjP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDRRjP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 13:39:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084F230C0
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681839554; x=1713375554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NeVZEx8WxqGy/+UHe2o++Dti6QUcTwltEJ0RkB7Sgb8=;
  b=hOht+UBWvZ5IDHM4gnaPOQJ2fZK6hwvly/k70Uzp0hECNmlg6ZBnOgSw
   uN8C6I/N8XahkPDtLRGO01j63mNtRxMkqGdH9C7cKBwC8d4UETZsUzjUc
   W34y+6PPzGI6SLtEi4cMfcJnntZ1zxWBlAl2oHlsrfoPgLBDsuVo7jf6W
   rezYoFTTCrecLdGTDViby53AkxeYlFR6RytUxZkyKg1tZf0wAIU5R/iUr
   bLUGfQ42gPrjLxsiNzieamCSVDa1PDThChZ/h/kS8LyOLRG+ZAFz2Fd94
   suuN5d7dvObLPmQfE5Ujsz3uyI8bCjKXetcGd7NMYu5bQ5r+5n9fdnYFe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="410470697"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="410470697"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:39:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="865505404"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="865505404"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:39:12 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v13 1/9] cxl/mbox: Deprecate poison commands
Date:   Tue, 18 Apr 2023 10:39:01 -0700
Message-Id: <652197e9bc8885e6448d989405b9e50ee9d6b0a6.1681838291.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1681838291.git.alison.schofield@intel.com>
References: <cover.1681838291.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

The CXL subsystem is adding formal mechanisms for managing device
poison. Minimize the maintenance burden going forward, and maximize
the investment in common tooling by deprecating direct user access
to poison commands outside of CXL_MEM_RAW_COMMANDS debug scenarios.

A new cxl_deprecated_commands[] list is created for querying which
command ids defined in previous kernels are now deprecated.

CXL Media and Poison Management commands, opcodes 0x43XX, defined in
CXL 3.0 Spec, Table 8-93 are deprecated with one exception: Get Scan
Media Capabilities. Keep Get Scan Media Capabilities as it simply
provides information and has no impact on the device state.

Effectively all of the commands defined in:

commit 87815ee9d006 ("cxl/pci: Add media provisioning required commands")

...were defined prematurely and should have waited until the kernel
implementation was decided. To my knowledge there are no shipping
devices with poison support and no known tools that would regress with
this change.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Co-developed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c      |  5 -----
 include/uapi/linux/cxl_mem.h | 35 ++++++++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f2addb457172..938cff2c948e 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -61,12 +61,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(SET_ALERT_CONFIG, 0xc, 0, 0),
 	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
 	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
-	CXL_CMD(GET_POISON, 0x10, CXL_VARIABLE_PAYLOAD, 0),
-	CXL_CMD(INJECT_POISON, 0x8, 0, 0),
-	CXL_CMD(CLEAR_POISON, 0x48, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
-	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
-	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
 };
 
 /*
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 86bbacf2a315..14bc6e742148 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -40,19 +40,22 @@
 	___C(SET_ALERT_CONFIG, "Set Alert Configuration"),                \
 	___C(GET_SHUTDOWN_STATE, "Get Shutdown State"),                   \
 	___C(SET_SHUTDOWN_STATE, "Set Shutdown State"),                   \
-	___C(GET_POISON, "Get Poison List"),                              \
-	___C(INJECT_POISON, "Inject Poison"),                             \
-	___C(CLEAR_POISON, "Clear Poison"),                               \
+	___DEPRECATED(GET_POISON, "Get Poison List"),                     \
+	___DEPRECATED(INJECT_POISON, "Inject Poison"),                    \
+	___DEPRECATED(CLEAR_POISON, "Clear Poison"),                      \
 	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
-	___C(SCAN_MEDIA, "Scan Media"),                                   \
-	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
+	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
+	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
+#define ___DEPRECATED(a, b) CXL_MEM_DEPRECATED_ID_##a
 enum { CXL_CMDS };
 
 #undef ___C
+#undef ___DEPRECATED
 #define ___C(a, b) { b }
+#define ___DEPRECATED(a, b) { "Deprecated " b }
 static const struct {
 	const char *name;
 } cxl_command_names[] __attribute__((__unused__)) = { CXL_CMDS };
@@ -68,6 +71,28 @@ static const struct {
  */
 
 #undef ___C
+#undef ___DEPRECATED
+#define ___C(a, b) (0)
+#define ___DEPRECATED(a, b) (1)
+
+static const __u8 cxl_deprecated_commands[]
+	__attribute__((__unused__)) = { CXL_CMDS };
+
+/*
+ * Here's how this actually breaks out:
+ * cxl_deprecated_commands[] = {
+ *	[CXL_MEM_COMMAND_ID_INVALID] = 0,
+ *	[CXL_MEM_COMMAND_ID_IDENTIFY] = 0,
+ *	...
+ *	[CXL_MEM_DEPRECATED_ID_GET_POISON] = 1,
+ *	[CXL_MEM_DEPRECATED_ID_INJECT_POISON] = 1,
+ *	[CXL_MEM_DEPRECATED_ID_CLEAR_POISON] = 1,
+ *	...
+ * };
+ */
+
+#undef ___C
+#undef ___DEPRECATED
 
 /**
  * struct cxl_command_info - Command information returned from a query.
-- 
2.37.3

