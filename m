Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2ACC54E94
	for <linux-cxl@archiver.kernel.org>; Wed, 25 Jan 2023 18:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjAYSNm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 25 Jan 2023 13:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjAYSNl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 25 Jan 2023 13:13:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A704D2BF25
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 10:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674670420; x=1706206420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XwONVhVnd7Y+VigG17bj+apS44gMGyNvlzs10LT5UUY=;
  b=bO1S1mh3Cu8HarpdGWGY5fEVqxuRzOftuOgEzi9L/b7fslw5bjgDYIBU
   NtMR5BkdpJvvS7jKeNiVSg5FbLMjMyLezzqvv6njgoIHBXkdc8ctms3zp
   TAnETL20HFKxy6co0LbPXQMB40cLJut96HgLSo3GcqygFXJoF9frBj9ae
   32nyIqx3PvdOWitXKp+0XGQ4sDu226bY/IHeCWApeS19sXa+c5Nkf8+sa
   NGVL+nUzf34fjGW5G4Qs91Si9Keu3StVz5B5tgsC2fX3o+1qwiNwjLcvK
   G3Ogz/ob50y3e17IthI601xa6pSgsgZxUqgRhYunpN4fgl9IQA1zNyDnS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="306292183"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="306292183"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 10:13:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="612518460"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="612518460"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.71.142])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 10:13:39 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2] tools/testing/cxl: Remove cxl_test module math loading message
Date:   Wed, 25 Jan 2023 10:13:36 -0800
Message-Id: <20230125181336.667448-1-alison.schofield@intel.com>
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

That "(NULL device *)" has raised needless user concern and the info
emitted can be discovered elsewhere.

Remove the dev_dbg() messages and make the module_param readable via
sysfs in case a lookup is wanted.

Fixes: Fixes: 7a7e6edfca85 ("tools/testing/cxl: Add XOR Math support to cxl_test")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

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

base-commit: 589c3357370a596ef7c99c00baca8ac799fce531
-- 
2.37.3

