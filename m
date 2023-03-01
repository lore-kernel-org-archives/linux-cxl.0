Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D53C7EE36
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 21:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCAVgs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 16:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCAVgs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 16:36:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104B8305EB
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 13:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677706607; x=1709242607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kFyu2vqlFHUZvKFHwe4SPyjiSc9vLazrgoQorD5ju9E=;
  b=dbkdwnKJQqEDQJ5XB1OTQf63wEFAkYEA6lElVqr5lyv/+UouEqQ6G6K0
   zHPqSaoPNMS6nPi5/jVHBbvrZNmhG1Coo8bqC9ao0DPS03lEGIsxn0CMr
   9UofiQfmAbdh1KwQtRWMj6JdZSdtTOmFUiM74uRO+LfZVK1C1Lr9HHFlc
   iiK0tiRVcW23R7TL5U/kAPWQ55H84rGWSjg740xB91NeoK9XxKm0AnYHW
   WNUvRR0WBlbmD+9rsK9X+qaAHws5vvpCSvHwBhpy/tNwhjdHzd1I3joy0
   I9PK4B+TRwcisGJd0OFqbJ1+e4VOHU01ubM6zGQ/EQpypr24K34RzQk3u
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397094710"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="397094710"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 13:36:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="784520846"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="784520846"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.70.38])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 13:36:46 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3 8/8] cxl/mbox: Block inject and clear poison opcodes in raw mode
Date:   Wed,  1 Mar 2023 13:36:33 -0800
Message-Id: <95d2f7ac1884801148a07f791ba0f03af7770d7e.1677704994.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1677704994.git.alison.schofield@intel.com>
References: <cover.1677704994.git.alison.schofield@intel.com>
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

