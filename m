Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197BEC6FD18
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Apr 2023 03:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjDSD1Z (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjDSD1X (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 23:27:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C938A6F
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 20:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681874831; x=1713410831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ToQDOnutOc1gc4/fwdqNj8gZ1tRWG65U+XwlMDddB9s=;
  b=QXz9EqOoGpK77/P17yvKnyw4DkmmgBgXNMbNospka87mH1pKwauCQTqE
   I5OY3A8Tj5uP64Q5CzPw9AYN6eSXBjRVhKtXZZroPGZcHFLJqWlp4yEDP
   OWfCfpgtFGpsqgUwPZIHwh55Q8XFB/xW9S2qN7u0pR07+KOZNH2iWCUqu
   NSDDJbGglznLa24DwlflwZuzH7+4Mpz0r+Jnizoz0US9EX1jsWyMNALD6
   w3o8B2mvwF5JPnMO9eaB2pXASxNUf6n5hIdfxrGpnXRlIQM13xOtWY2UF
   n3zhtPweHzprV1kvJ0hPQc0Mc1dY/lLYH1Fv0ryaJeWFPErwPlZ1yN0Az
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431621758"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="431621758"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780711162"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="780711162"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:55 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v6 10/10] tools/testing/cxl: Require CONFIG_DEBUG_FS
Date:   Tue, 18 Apr 2023 20:26:34 -0700
Message-Id: <4f3aab57fbf1cc3ccde2eb887c5d90566c8d0e90.1681874357.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1681874357.git.alison.schofield@intel.com>
References: <cover.1681874357.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The cxl_mem driver uses debugfs to support poison inject and clear.
Add debugfs to the list of required symbols so that cxl_test can
emulate those poison operations.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/config_check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/cxl/config_check.c b/tools/testing/cxl/config_check.c
index 99b56b5f6edf..0902c5d6e410 100644
--- a/tools/testing/cxl/config_check.c
+++ b/tools/testing/cxl/config_check.c
@@ -13,4 +13,5 @@ void check(void)
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_PMEM));
 	BUILD_BUG_ON(!IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST));
 	BUILD_BUG_ON(!IS_ENABLED(CONFIG_NVDIMM_SECURITY_TEST));
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_DEBUG_FS));
 }
-- 
2.37.3

