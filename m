Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E59C77B78
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 17:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDRRjQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDRRjQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 13:39:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA3A98
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681839555; x=1713375555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qpft6Mc0bklr3Y/gNd+lJsaTCMj2csP3GQUVz5TrZwU=;
  b=Lnx+egI25OwmQxHA19KrfHRlXlwLiULFesUwjIaxjgq0auqdzm0uueu9
   QeA2vf6IPLyIphyri1TAu1YRfLIV0sRILhFfUHiJDQgauAMkYXwmtjk3C
   eqwthNqbLFY0KWxtRe8NEYaOAmxUMqpIiIqDpN2hDosAAndk116vNbMJC
   1qZtBTIjdWEK/l5y6E3s8rzQOLaHOVXyKrgKhzdrwgvx4602pu+ZJ+6T1
   uxJU4o1Fz0+uvHXzgObk3Mjwen2AnAK33naMH/XfP3TGTol/CvQzCsFb3
   0xsUob9mlkKpsRBnVcUeo4ZQfmdD0nkYURM2iXzbTkDXNbOzotZTHf91X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="410470701"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="410470701"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:39:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="865505411"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="865505411"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:39:14 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v13 2/9] cxl/mbox: Restrict poison cmds to debugfs cxl_raw_allow_all
Date:   Tue, 18 Apr 2023 10:39:02 -0700
Message-Id: <0e5cb41ffae2bab800957d3b9003eedfd0a2dfd5.1681838291.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1681838291.git.alison.schofield@intel.com>
References: <cover.1681838291.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The Get, Inject, and Clear poison commands are not available for
direct user access because they require kernel driver controls to
perform safely.

Further restrict access to these commands by requiring the selection
of the debugfs attribute 'cxl_raw_allow_all' to enable in raw mode.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 938cff2c948e..fd1026970d3a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -82,6 +82,9 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
  *
  * CXL_MBOX_OP_[GET_]SCAN_MEDIA: The kernel provides a native error list that
  * is kept up to date with patrol notifications and error management.
+ *
+ * CXL_MBOX_OP_[GET_,INJECT_,CLEAR_]POISON: These commands require kernel
+ * driver orchestration for safety.
  */
 static u16 cxl_disabled_raw_commands[] = {
 	CXL_MBOX_OP_ACTIVATE_FW,
@@ -90,6 +93,9 @@ static u16 cxl_disabled_raw_commands[] = {
 	CXL_MBOX_OP_SET_SHUTDOWN_STATE,
 	CXL_MBOX_OP_SCAN_MEDIA,
 	CXL_MBOX_OP_GET_SCAN_MEDIA,
+	CXL_MBOX_OP_GET_POISON,
+	CXL_MBOX_OP_INJECT_POISON,
+	CXL_MBOX_OP_CLEAR_POISON,
 };
 
 /*
-- 
2.37.3

