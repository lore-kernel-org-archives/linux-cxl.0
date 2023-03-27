Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8BEC77B6C
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 05:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjC0FD3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjC0FD0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 01:03:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB9111A
        for <linux-cxl@vger.kernel.org>; Sun, 26 Mar 2023 22:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679893405; x=1711429405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ySw8/GLL85kpC+W0xz+lZay3AUC3XnDwpCMTSxIlXxs=;
  b=M+VHSMx9HidUxyiAhrs70Mm95x5/sH1buC6KA7Ri2oaN8apheY7TSnuA
   4NSny6gEpHF/YvJD6mjL3LREt8wufvHXhxLRvL7XKlgMS7igBb6cmprfF
   8wSD21iLebhaAuFSaCh6PHVd/zexzR1wbGMiJrzMqCffuciyL1PyZ3VMy
   +krcMU1H6F+6ZWUwsC8hkN3Jj1DE2VnHPXoMGWjwXd7XihKNDYxQe8Pez
   yJkOlhgocIP6HwCNIUetZFYwFLMxEZ7Klzyrn4I6ic5DBTNyH8KQmRP+8
   /x7qr7pwlWNcGBCiZT0k4F/PH4ipkNSmTn9Uku6YJY4WZhPp5pmeSnAkt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367920200"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="367920200"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="633492275"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="633492275"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.227.2])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:24 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 07/12] cxl/mbox: Block inject and clear poison opcodes in raw mode
Date:   Sun, 26 Mar 2023 22:03:13 -0700
Message-Id: <0ca99f94e976a776b5ab7af86b75a556354daab7.1679892337.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679892337.git.alison.schofield@intel.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/mbox.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a8369ef56f61..b380208f85c2 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -89,6 +89,9 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
  *
  * CXL_MBOX_OP_[GET_]SCAN_MEDIA: The kernel provides a native error list that
  * is kept up to date with patrol notifications and error management.
+ *
+ * CXL_MBOX_OP_[INJECT|CLEAR]_POISON: The kernel provides a debugfs interface
+ * to these commands. See: Documentation/ABI/testing/debugfs-cxl
  */
 static u16 cxl_disabled_raw_commands[] = {
 	CXL_MBOX_OP_ACTIVATE_FW,
@@ -97,6 +100,8 @@ static u16 cxl_disabled_raw_commands[] = {
 	CXL_MBOX_OP_SET_SHUTDOWN_STATE,
 	CXL_MBOX_OP_SCAN_MEDIA,
 	CXL_MBOX_OP_GET_SCAN_MEDIA,
+	CXL_MBOX_OP_INJECT_POISON,
+	CXL_MBOX_OP_CLEAR_POISON,
 };
 
 /*
-- 
2.37.3

