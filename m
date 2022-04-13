Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E43C43219
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Apr 2022 19:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbiDMTOf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbiDMTOF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Apr 2022 15:14:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F0A6F487
        for <linux-cxl@vger.kernel.org>; Wed, 13 Apr 2022 12:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649877078; x=1681413078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yukFXjtKghoFlUoXiuDPBIrZ2U5q37JGuwsxhdnHNAg=;
  b=EnytHRWUwUaXG1zcvbnPIOmBNfM6XdsZLnprY4pQpNargYcuVm9PlzDA
   qw+sNQssCPRIvNbknLxYVwRW/tfZ5eSavW/w4yl2DTf7aeKpClealGYoZ
   ROgBNHuow3SSswyXLzZmuo6FOJxfEZ6pvOtYvzZgADROIDsxWNJWPawsf
   hMO31yZu3XZtWa54obIUQwOQSVRtxVd7JK/ONq7juGMzgzoMEZXOdguOk
   0aIGJV9tnJqf0nb5/9EaLb96xVuMZR5SzQ5paw/w1cH/03qh1CAMMIWCd
   B5WRgBw8/yEG5N4juNTKvVgXoXUXSeWNHFHTGcZDupyuMDdOCy4HZPyc6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="244638731"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="244638731"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 12:11:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="573408631"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 12:11:17 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] cxl/mbox: Restore signedness to a mailbox payload variable
Date:   Wed, 13 Apr 2022 12:13:11 -0700
Message-Id: <20220413191311.1242361-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

A mailbox command output size value of (-1) means that a device
may return a variable sized output to that command. The device
defines a maximum payload size, so the driver will allocate enough
memory to receive that maximum payload for variable size mailbox
commands.

A recent code refactoring discarded the signedness on 'out_size'
before checking it, thereby breaking the handling of mailbox
commands with variable sized output. Pass along both in_size and
out_size with signedness, and only discard the signedness when
building the cxl_mbox_cmd structure.

Smatch warn: unsigned 'out_size' is never less than 0

Fixes: be0d0ce77aa3 ("cxl/mbox: Move build of user mailbox cmd to a helper funct
ions")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
- Pass the payload sizes as signed rather than move the check (Dan)
- Signedness is now discarded on ssize_t to size_t assignment.
- Update commit msg. Was 'Handle variable size output while still
  signed'
- Update commit log.

 drivers/cxl/core/mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 8a8388599a85..6c6f6a157485 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -253,7 +253,7 @@ static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
 
 static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
 			     struct cxl_dev_state *cxlds, u16 opcode,
-			     size_t in_size, size_t out_size, u64 in_payload)
+			     ssize_t in_size, ssize_t out_size, u64 in_payload)
 {
 	*mbox = (struct cxl_mbox_cmd) {
 		.opcode = opcode,

base-commit: 7dc1d11d7abae52aada5340fb98885f0ddbb7c37
-- 
2.31.1

