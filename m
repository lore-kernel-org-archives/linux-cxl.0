Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B50AC52D11
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 17:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjAZRGB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 12:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjAZRGA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 12:06:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E0B9EE2
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 09:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674752760; x=1706288760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MWjf16lWWbhUuNrv55S6RxW/d0rZp8zZPrYD7SZ39bo=;
  b=bKPtlcvRFylFiGxpsyqHdDtK6/0MeQtEITBJNnZDQJK1UFKrRi68ZQr7
   3dSGRaXx3K+/gHnAL9fOLKMU9fsBNMUWGjkXX9c6zJfU3e5/p73gDiUnu
   PsrfS3bVBwQODufLM2EyI3XPb9b+vWzCDtdI3gGXPADd+xDyN0MHikV7/
   UCOqAW5zpPa2Qwut9mnvJdZC1ooavj28BGP3gek8TQiR4ZZVNdJ5fKRA5
   AfTK+rZrOC5brkYPvwLz9VcohJ7puXEehL/Bp6gnKp8tMB3r/UBeS1yQF
   2iAE5qXwt/gi4jAH134DjF570x9u1FQb/lVTjv6Z9F0W8Yj76hA1rUtKa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="328137272"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="328137272"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 09:05:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="805435848"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="805435848"
Received: from cgibbiso-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.132.52])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 09:05:57 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3] tools/testing/cxl: Remove cxl_test module math loading message
Date:   Thu, 26 Jan 2023 09:05:55 -0800
Message-Id: <20230126170555.701240-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Commit "tools/testing/cxl: Add XOR Math support to cxl_test" added
a module parameter to cxl_test for the interleave_arithmetic option.

In doing so, it also added this dev_dbg() message describing which
option cxl_test used during load:
"[  111.743246] (NULL device *): cxl_test loading modulo math option"
That "(NULL device *)" has raised needless user concern.

Remove the dev_dbg() message and make the module_param readable via
sysfs for users that need to know which math option is active.

Fixes: Fixes: 7a7e6edfca85 ("tools/testing/cxl: Add XOR Math support to cxl_test")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
---

Changes in v3:
- New base commit 6.2-rc5.  Suggest for 6.3, not a 6.2 fix.
- Update Commit log: explain why permission change is needed (DaveJ)
- Add Vishal's Reviewed-by Tag (Vishal)
- No change in code

Changes in v2:
- Use correct Fixes Tag in commit log. (Ira)
- Param always appears in sysfs. Don't say otherwise in commit log. (Ira)
- Commit msg: s/modulo/module, s/messages/message
- No change in code

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

base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
-- 
2.37.3

