Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126ECC32774
	for <linux-cxl@archiver.kernel.org>; Tue, 23 Aug 2022 07:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbiHWHVX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 Aug 2022 03:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240654AbiHWHVV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 Aug 2022 03:21:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDC061D9D
        for <linux-cxl@vger.kernel.org>; Tue, 23 Aug 2022 00:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661239281; x=1692775281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Jo0M7JLkpca4mmJEMDx0p2jux4rGpK3VNeWC/VQ7yw=;
  b=mYuFdwQihnYljvhv+bb5DLFNeIia7h5a++QCraj6XQmIk4023P6NmrZX
   lsYCvQXm/SOpvxzXMyeujM4/S2R20GgohfcxSU0X8XkLLAKU1QMDkCtAw
   S7pgD9ARjl49+c0nxxzvEgmoDyj+sK9Qsr4U+HfCiBeIXvHcbZLeiYnsO
   cLuuB3bmBV2uV0EONLh0HiOcR7Ipbqj3AHn2q9+pU9+tr1ydU5SRbeC0o
   egOTMgT6lc/ejFT3DUxBrg1o/27H6iZJ1K+fYaA5tDm8ibaQcODs1Y0OI
   6cqz5y4YWryrDcusDKYoe42yjf7qdQD5gDllQeeL+Wl4APhocPUNOo06s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="273366244"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="273366244"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:21:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="735388584"
Received: from skummith-mobl1.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.54.206])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:21:10 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 1/3] cxl/region: fix a dereferecnce after NULL check
Date:   Tue, 23 Aug 2022 01:21:04 -0600
Message-Id: <20220823072106.398076-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823072106.398076-1-vishal.l.verma@intel.com>
References: <20220823072106.398076-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; h=from:subject; bh=5Jo0M7JLkpca4mmJEMDx0p2jux4rGpK3VNeWC/VQ7yw=; b=owGbwMvMwCXGf25diOft7jLG02pJDMks9Q/vFNl6f34hmd2mvmcNY2JsUeXKykN/+idtltedUO/F e+haRykLgxgXg6yYIsvfPR8Zj8ltz+cJTHCEmcPKBDKEgYtTACYScJrhD9+ehh/CqvfVONjkfbT3st 1INxBqdxd6cHprX0v6a6HTqQz/PWtf5HlzJDyfJx/1Sr9IybKqQDe3uudrmNM0AYdtLvlMAA==
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A NULL check in region_action() implies that 'decoder' might be NULL, but
later we dereference it during cxl_decoder_foreach().

Since cxl_decoder_foreach() won't ever enter the loop with a NULL decoder,
the check was superfluous. Remove it.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/region.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/cxl/region.c b/cxl/region.c
index a30313c..9372d6b 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -688,8 +688,6 @@ static int region_action(int argc, const char **argv, struct cxl_ctx *ctx,
 		cxl_decoder_foreach (port, decoder) {
 			decoder = util_cxl_decoder_filter(decoder,
 							  param.root_decoder);
-			if (!decoder)
-				continue;
 			rc = decoder_region_action(p, decoder, action, count);
 			if (rc)
 				err_rc = rc;
-- 
2.37.2

