Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48A1C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  5 Jan 2022 21:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244484AbiAEVdc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 5 Jan 2022 16:33:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:55456 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244446AbiAEVcX (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 5 Jan 2022 16:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641418343; x=1672954343;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WkNyoqOkNabsNshuJHnilc0Rs1nFAMTQqMLYayXSN9Q=;
  b=lLmF2MyZ6BMiUZ+AAHAWhwma3vyXcQwJrUq72j1+xsHHfr8sg3y1dI0h
   Xe1hhKaJ4PsbsvjQbtH42bWNvLi+gFVC1+WNCEi1tckqqMD/KS92a447d
   MQHH496L9pO4wgUnmKoCgVJ2W0jecu8FI6IPY+6nnQbuH9g1AgcaKZgU3
   rNL8OHj0mabSDZq86e9F5+NDWDY+vuVzS66fSNOV5X5JskITLHlmkN+Qn
   1Tk/y9opct5o9tSu1iAa9jqgxSXQjvMyX6/3fRoaf3SwbIYNU1Q6551vD
   TBNYMmpcImVfTjWtyMS+7RDAjonXBYcrresgXsqcOCTRQXClX4ceMeBwC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241358755"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="241358755"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:32:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="574526373"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:32:21 -0800
Subject: [ndctl PATCH v3 08/16] ndctl/test: Fix support for missing
 dax_pmem_compat module
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Date:   Wed, 05 Jan 2022 13:32:21 -0800
Message-ID: <164141834155.3990253.5388773351209410262.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164141829899.3990253.17547886681174580434.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164141829899.3990253.17547886681174580434.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The kernel is moving to drop CONFIG_DEV_DAX_PMEM_COMPAT. Update
ndctl_test_init() to not error out if dax_pmem_compat is missing. It seems
that the original implementation of support for missing dax_pmem_compat was
broken, or since that time newer versions of kmod_module_new_from_name() no
longer fail when the module is missing.

Fixes: b7991dbc22f3 ("ndctl/test: Relax dax_pmem_compat requirement")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/core.c |   25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/test/core.c b/test/core.c
index dc1405d75c49..5d1aa23723f1 100644
--- a/test/core.c
+++ b/test/core.c
@@ -120,7 +120,6 @@ int ndctl_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 		"nfit",
 		"device_dax",
 		"dax_pmem",
-		"dax_pmem_core",
 		"dax_pmem_compat",
 		"libnvdimm",
 		"nd_btt",
@@ -180,29 +179,27 @@ int ndctl_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 		/*
 		 * Skip device-dax bus-model modules on pre-v5.1
 		 */
-		if ((strcmp(name, "dax_pmem_core") == 0
-				|| strcmp(name, "dax_pmem_compat") == 0)
-				&& !ndctl_test_attempt(test,
-					KERNEL_VERSION(5, 1, 0)))
+		if ((strcmp(name, "dax_pmem_compat") == 0) &&
+		    !ndctl_test_attempt(test, KERNEL_VERSION(5, 1, 0)))
 			continue;
 
 retry:
 		rc = kmod_module_new_from_name(*ctx, name, mod);
-
-		/*
-		 * dax_pmem_compat is not required, missing is ok,
-		 * present-but-production is not ok.
-		 */
-		if (rc && strcmp(name, "dax_pmem_compat") == 0)
-			continue;
-
 		if (rc) {
-			log_err(&log_ctx, "%s.ko: missing\n", name);
+			log_err(&log_ctx, "failed to interrogate %s.ko\n",
+				name);
 			break;
 		}
 
 		path = kmod_module_get_path(*mod);
 		if (!path) {
+			/*
+			 * dax_pmem_compat is not required, missing is
+			 * ok, present-but-production is not ok.
+			 */
+			if (strcmp(name, "dax_pmem_compat") == 0)
+				continue;
+
 			if (family != NVDIMM_FAMILY_INTEL &&
 			    (strcmp(name, "nfit") == 0 ||
 			     strcmp(name, "nd_e820") == 0))

