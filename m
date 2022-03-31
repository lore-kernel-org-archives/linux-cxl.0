Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348E6C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Mar 2022 01:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiCaB0t (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352306AbiCaB0s (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Mar 2022 21:26:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5B742EC9
        for <linux-cxl@vger.kernel.org>; Wed, 30 Mar 2022 18:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648689899; x=1680225899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BYYr3eMw9BahCCBcvX9Gw2x8VqWYGCgrfvU6CPo/qfU=;
  b=kXHiXfzMiZjyYeIt3dVD4hSabGgu1Ror/xy11aHa2Rowz60ri51YPPg1
   +XpiCYaEE6Qzg+0U8omSeKjp5Ym5Zrs0uYauB2luopeD0Z+fzjv3zsWNf
   7YTh3L9ydO2YMPp966swab4rzzhMEvTPul3MDpwYZ+/Nv2mUlJRXmy0/+
   LOktt14ocHvyyzcl2I4EEpjGU36Ikw0Rc8SK3ZP4oUnulghFH4nh87Wju
   6Jrp6LQm81ikhlwWysJr5CK8m9XPI8S2qOC7zsmzY1ocqLraBOf7lFEC3
   +BhiFJq2M1aqrb64OJGYKcE6Vu6dvS+iOUFBCA01tcU5PFI3QrQ3tKu5D
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247186022"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="247186022"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:24:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="838664533"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:24:58 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 2/9] cxl/mbox: Move raw command warning to raw command validation
Date:   Wed, 30 Mar 2022 18:27:12 -0700
Message-Id: <df5f0e0ec8afa1f75299aa86b4226ab4479ef325.1648687552.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648687552.git.alison.schofield@intel.com>
References: <cover.1648687552.git.alison.schofield@intel.com>
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 1f2175f0f687..39c8f6ded175 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -225,6 +225,8 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
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

