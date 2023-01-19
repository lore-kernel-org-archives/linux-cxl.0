Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48138C46467
	for <linux-cxl@archiver.kernel.org>; Thu, 19 Jan 2023 23:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjASXaI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjASXaF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 19 Jan 2023 18:30:05 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2510D8A0EB
        for <linux-cxl@vger.kernel.org>; Thu, 19 Jan 2023 15:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674171004; x=1705707004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4DO048Av4ufPRMCoKJpKsKtLvANfLLV1utcU4iygsB4=;
  b=kuQw0Mq/+U5/2+arch8BOrWNHHXQ7Mm0TL3smqdoAxUQ8ZrdnLPG7qeQ
   c1Yt9YCK5yqoDBhEQj/Bzr2dQ8hYL3xOEZT0InYR930gxkVUvNZd4qMFe
   sW3OAb6695oqLuo5D0Xq6vPLeX9coJLvd+tZ/br7kO6tRbhYcDrOezwxO
   W2nRujuITeHwd3Y39bWonSLWhFtKNzCMqoCW166onIS8nZWJ1cbfFLSGz
   tcS12wCuZrwpyC26C5BGptW0ARmGMnRzyddT5gOMGEQO40Tx+j++pswYQ
   YhEXvFqULerY6DTh8MsPz2LqBQv8KxgsKOQ0L1AZKtfA1BFt63fHB+nf6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326738191"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="326738191"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 15:30:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="768442917"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="768442917"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.1.72])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 15:29:46 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH] tools/testing/cxl: Remove cxl_test modulo math loading messages
Date:   Thu, 19 Jan 2023 15:29:37 -0800
Message-Id: <20230119232937.533986-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Commit "cxl/acpi: Support CXL XOR Interleave Math (CXIMS)" added
a module parameter to cxl_test for the interleave_arithmetic option.
In doing so, it also added this dev_dbg() message describing which
option cxl_test used during load:
"[  111.743246] (NULL device *): cxl_test loading modulo math option"

That "(NULL device *)" has raised needless user concern and the info
emitted can be discovered elsewhere.

Remove the dev_dbg() messages and make the module_param readable via
sysfs in case a lookup is wanted.

The default option is for standard modulo arithmetic, so when the
interleave_arithmetic param is not present in sysfs, the cxl_test
module is using standard modulo arithmetic.

Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 30ee680d38ff..ede84de69f59 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1135,11 +1135,9 @@ static __init int cxl_test_init(void)
 	if (interleave_arithmetic == 1) {
 		cfmws_start = CFMWS_XOR_ARRAY_START;
 		cfmws_end = CFMWS_XOR_ARRAY_END;
-		dev_dbg(NULL, "cxl_test loading xor math option\n");
 	} else {
 		cfmws_start = CFMWS_MOD_ARRAY_START;
 		cfmws_end = CFMWS_MOD_ARRAY_END;
-		dev_dbg(NULL, "cxl_test loading modulo math option\n");
 	}
 
 	rc = populate_cedt();
@@ -1326,7 +1324,7 @@ static __exit void cxl_test_exit(void)
 	unregister_cxl_mock_ops(&cxl_mock_ops);
 }
 
-module_param(interleave_arithmetic, int, 0000);
+module_param(interleave_arithmetic, int, 0444);
 MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);

base-commit: 589c3357370a596ef7c99c00baca8ac799fce531
-- 
2.37.3

