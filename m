Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7CAC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 01:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241629AbiC3B3u (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241627AbiC3B3s (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 21:29:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6783624B0AB
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 18:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648603683; x=1680139683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ykp22DrCZCA7V0szcG07t9M1HR62K5K/zKklNrArUMk=;
  b=Fyar9W3x9wgLWrHlFYC+q/zHAdaqn58SuXtPak60ssNv/7wsBFXDsshi
   Ev/Syf0Uy4Kxs9zz4qLYQo4QbAA4XnQJCx1bn/QY3mX90O0YLmUOfYoYG
   oLwBiCiNxO3SdvWIMWQeqPsccsJ+UixnKOQDFtby5J69rk0Yz8gggO3Nh
   psIpZfJQCdZ79zqe1hya6Op0HgCWc2yl2nIN1KLqJv+SM4X6jOPZLEo/l
   0dGwqAllv3dblequNretfXfoTCxI8Ge14ymOhdxrRCw3w3V1JN/tJfpgi
   kVs5TwbT/sG+hNfUmEAjkW/8nT+XIgIkfQINnZgty3DZi8pVM27CAy/79
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322601856"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="322601856"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:28:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="719776937"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:28:01 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 2/9] cxl/mbox: Move raw command warning to raw command validation
Date:   Tue, 29 Mar 2022 18:30:17 -0700
Message-Id: <019101a518b00407aaa19a497e8d973c364e1d12.1648601710.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648601710.git.alison.schofield@intel.com>
References: <cover.1648601710.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

This move serves two purposes: 1) Emit the warning in the raw
command validation path, and 2) Remove the dependency on the
struct cxl_mem_command in handle_mailbox_cmd_from_user() in
preparation for a refactor of that function.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/mbox.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 0b5bec7b8b5a..ae9aeb6c20f7 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -225,6 +225,8 @@ static int cxl_to_mem_cmd_raw(struct cxl_dev_state *cxlds,
 	if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
 		return -EPERM;
 
+	dev_WARN_ONCE(cxlds->dev, true, "raw command path used\n");
+
 	*mem_cmd = (struct cxl_mem_command) {
 		.info = {
 			.id = CXL_MEM_COMMAND_ID_RAW,
@@ -417,9 +419,6 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
 		cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
 		cmd->info.size_in);
 
-	dev_WARN_ONCE(dev, cmd->info.id == CXL_MEM_COMMAND_ID_RAW,
-		      "raw command path used\n");
-
 	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
 	if (rc)
 		goto out;
-- 
2.31.1

