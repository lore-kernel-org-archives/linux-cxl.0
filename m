Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71704C74A4B
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Mar 2023 18:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCJSte (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Mar 2023 13:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjCJStd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Mar 2023 13:49:33 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E2E122389
        for <linux-cxl@vger.kernel.org>; Fri, 10 Mar 2023 10:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678474172; x=1710010172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kFyu2vqlFHUZvKFHwe4SPyjiSc9vLazrgoQorD5ju9E=;
  b=ewbToUwVS5Py8vjgzgarCQJu2v9bR7zN7d12wwWojmKUR4a1j8d8tNq2
   IY2e2ptV4FUqRwBfCC4GqdNLjbwsuDdfIdqMRriLKo19babCj9Fi8J3wl
   ysR36fsDr7yC6uouTTt6cwJdA5RZM53CqraH/5hYdLaAAxMzD/yOXvrd3
   h0ponQI1rsGH4odbPEO+eDgD9bOJW9NX3quyLsRVvLLaufkSE4z+djzw0
   iE8Az691gb1kFUESno8pGKkb3XMzO2nEKWpt+lxG49WQQPMN6M1c69red
   RwvVX194kAGu4mgxxfBMvs+g3dhX3g6FIkUa6opin9PZtwbLpGLjArkR3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="336824188"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="336824188"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 10:49:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="627906792"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="627906792"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.255.228.62])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 10:49:31 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v4 8/8] cxl/mbox: Block inject and clear poison opcodes in raw mode
Date:   Fri, 10 Mar 2023 10:49:09 -0800
Message-Id: <6952da15b164e18e7f26fb26631839837d9797b3.1678471465.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1678471465.git.alison.schofield@intel.com>
References: <cover.1678471465.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Inject and clear poison are commands intended for debug environments,
and can cause data corruption if issued without validation. They are
kernel exclusive commands not available to userspace through ioctls,
but could be submitted via the raw mode ioctl.

Add inject and clear poison to the cxl_disabled_raw_commands[] list.
Attempts by userspace to issue either command via the RAW ioctl fail
with -EPERM.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 77fc811bdfed..4b5e65edbc71 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -89,6 +89,10 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
  *
  * CXL_MBOX_OP_[GET_]SCAN_MEDIA: The kernel provides a native error list that
  * is kept up to date with patrol notifications and error management.
+ *
+ * CXL_MBOX_OP_[INJECT|CLEAR]_POISON: The kernel provides a sysfs interface
+ * to these commands that ensures data protection of mapped resources.
+ * See: Documentation/ABI/testing/sysfs-bus-cxl
  */
 static u16 cxl_disabled_raw_commands[] = {
 	CXL_MBOX_OP_ACTIVATE_FW,
@@ -97,6 +101,8 @@ static u16 cxl_disabled_raw_commands[] = {
 	CXL_MBOX_OP_SET_SHUTDOWN_STATE,
 	CXL_MBOX_OP_SCAN_MEDIA,
 	CXL_MBOX_OP_GET_SCAN_MEDIA,
+	CXL_MBOX_OP_INJECT_POISON,
+	CXL_MBOX_OP_CLEAR_POISON,
 };
 
 /*
-- 
2.37.3

