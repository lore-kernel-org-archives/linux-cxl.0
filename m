Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165FCC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 24 Mar 2022 01:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbiCXBKX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347072AbiCXBKW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Mar 2022 21:10:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B84152B2D
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 18:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648084132; x=1679620132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dqWVQe8t0ikOTnqchTFGMznJIuaK5choZ5faTnHtzAM=;
  b=mDdHb3LGcc76ZJxz42GRuXa+09pkOP/z/WrK/p4z4YZsaqe1EXv9Fe/6
   mkoFrabz9WR0ucYyI1/Hs0kKGFu8hhFtA1ECS+PbARNoGoYNNvQKVdmYo
   y8vydOsaDepwOak07XeMVeacJ5j4oo41unfxBFdrcQf44AAX3G6jRE0CH
   yu9ltPvQMftseLk5ZXlecxDF5tV1jIwFWMa5vef9UcU1XDwFOFM0cZ1d6
   NT9EeQL8psGXvl+HhsgoG5XUufeE6Y3hAj2qEXyewyTgjlNwLUT/6KEFQ
   03hblu4A2soLeV3QcIrARyMhkG2zcxV5lZweMNh9xGPhesGZGSmyV+Zfo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258215000"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258215000"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="693142810"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:50 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3 2/9] cxl/mbox: Move raw command warning to raw command validation
Date:   Wed, 23 Mar 2022 18:11:19 -0700
Message-Id: <20220324011126.1144504-3-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324011126.1144504-1-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
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
---
 drivers/cxl/core/mbox.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 6612d73c37a8..28131c6f7fcf 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -224,6 +224,8 @@ static int cxl_to_mem_cmd_raw(struct cxl_dev_state *cxlds,
 	if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
 		return -EPERM;
 
+	dev_WARN_ONCE(cxlds->dev, true, "raw command path used\n");
+
 	*mem_cmd = (struct cxl_mem_command) {
 		.info = {
 			.id = CXL_MEM_COMMAND_ID_RAW,
@@ -424,9 +426,6 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
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

