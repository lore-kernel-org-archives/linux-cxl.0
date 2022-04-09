Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7F4C433EF
	for <linux-cxl@archiver.kernel.org>; Sat,  9 Apr 2022 03:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiDIDNX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Apr 2022 23:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiDIDNW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Apr 2022 23:13:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26040DF36
        for <linux-cxl@vger.kernel.org>; Fri,  8 Apr 2022 20:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649473876; x=1681009876;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UTeRAG924w9LUM0nE3iyY47p5IXJl+KBCDdy6zTgXd0=;
  b=nvivG41i8nA5dRRaXW4UQUGULSINYyI+VYwWjKfuVoDV+aeo5pZp/omw
   dYmmKduV4HUDthfTSjQ6qBXxC37hPpRuZgbZ2ma6li3uTGEmw9fQkGL5j
   Q83k0VPPNFpUT8P/jnClqgAbCVNQhg2YxttZtpGvWrCu0q+MwgrpgVF1p
   QsUzKWS8AIvK3FlVZ/vXWfm9+8UDyvzVfvC/y0qsAcg49BWYHEwpeLAh7
   xyWhUhC+DWZAIB683u0BDD87nFhnhB4hTqfqR9SCo5/AhuNmLM0BriH/G
   UV27zc9piFJC4aBfJqe9JWYkPgFQyXEhK5Jw2fHWVqgyKRADaxcSrDooS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="260595229"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="260595229"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 20:11:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="698465707"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 20:11:15 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] cxl/mbox: Handle variable size output while still signed
Date:   Fri,  8 Apr 2022 20:13:12 -0700
Message-Id: <20220409031312.1220512-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

A mailbox command output size value of (-1) means that a device
may return a variable sized output for that command. The device
defines a maximum payload size, so the driver will allocate enough
memory to receive that maximum payload for these commands.

A recent code refactoring moved the check for variable sized output
to occur after the signedness is discarded from the output size.
Move the check to occur while still operating on the signed output
size variable.

Smatch warn: unsigned 'out_size' is never less than 0

Fixes: be0d0ce77aa3 ("cxl/mbox: Move build of user mailbox cmd to a helper funct
ions")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 8a8388599a85..987703ae1fe3 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -258,6 +258,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
 	*mbox = (struct cxl_mbox_cmd) {
 		.opcode = opcode,
 		.size_in = in_size,
+		.size_out = out_size,
 	};
 
 	if (in_size) {
@@ -274,12 +275,6 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
 		}
 	}
 
-	/* Prepare to handle a full payload for variable sized output */
-	if (out_size < 0)
-		mbox->size_out = cxlds->payload_size;
-	else
-		mbox->size_out = out_size;
-
 	if (mbox->size_out) {
 		mbox->payload_out = kvzalloc(mbox->size_out, GFP_KERNEL);
 		if (!mbox->payload_out) {
@@ -320,7 +315,6 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
 		.info = {
 			.id = CXL_MEM_COMMAND_ID_RAW,
 			.size_in = send_cmd->in.size,
-			.size_out = send_cmd->out.size,
 		},
 		.opcode = send_cmd->raw.opcode
 	};
@@ -365,7 +359,6 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
 			.id = info->id,
 			.flags = info->flags,
 			.size_in = send_cmd->in.size,
-			.size_out = send_cmd->out.size,
 		},
 		.opcode = c->opcode
 	};
@@ -417,6 +410,12 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
 	if (rc)
 		return rc;
 
+	/* Prepare to handle a full payload for variable sized output */
+	if (send_cmd->out.size < 0)
+		mem_cmd.info.size_out = cxlds->payload_size;
+	else
+		mem_cmd.info.size_out = send_cmd->out.size;
+
 	/* Sanitize and construct a cxl_mbox_cmd */
 	return cxl_mbox_cmd_ctor(mbox_cmd, cxlds, mem_cmd.opcode,
 				 mem_cmd.info.size_in, mem_cmd.info.size_out,

base-commit: 7dc1d11d7abae52aada5340fb98885f0ddbb7c37
-- 
2.31.1

