Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A98C4332F
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Nov 2022 00:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiKDAa4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 20:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiKDAao (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 20:30:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7A011C29
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 17:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667521844; x=1699057844;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LgAOwqvIRFKi4SrHwaUgT2CkgNCoQGdB/X7b0DMyCkw=;
  b=XDCMUojcfBXJUTrdHUGgWXWhHd94ubYhETwnsH/ftYETZT12y+Z0gHLQ
   Ma9gGmRkMRwQC3dW+vwDg8SVObtAJk2nI5PNJWri29BjaSExM189hiUv4
   rNQlKi/N4WQaIjIHJUrmt+dBLEhsKLJirOQvJBSaU+eq3NlMVFXhxgq3v
   JWEak+keFWW8FTYcWEYXXlUq1Zi9Tsg/Fft9ucxQXP/pWfpfDInxHUV79
   G9hZQmm0+mIGH4tmQv8j1KHBP2YFQPpnAEtQaY67AvDbh69uYbdXYdVQD
   L7I3vgAIIFdHqEvAVqh7DnQCg1SKtug4X/TcaDtni+HqUsRUhv5rEhyhn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="374077889"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="374077889"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 17:30:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="964151690"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="964151690"
Received: from arunvasu-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.53.48])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 17:30:43 -0700
Subject: [PATCH 4/7] tools/testing/cxl: Fix some error exits
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        dave.jiang@intel.com
Date:   Thu, 03 Nov 2022 17:30:42 -0700
Message-ID: <166752184255.947915.16163477849330181425.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166752181697.947915.744835334283138352.stgit@dwillia2-xfh.jf.intel.com>
References: <166752181697.947915.744835334283138352.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fix a few typos where 'goto err_port' was used rather than the object
specific cleanup.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/cxl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index a072b2d3e726..133e4c73d370 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -695,7 +695,7 @@ static __init int cxl_test_init(void)
 
 		pdev = platform_device_alloc("cxl_switch_uport", i);
 		if (!pdev)
-			goto err_port;
+			goto err_uport;
 		pdev->dev.parent = &root_port->dev;
 
 		rc = platform_device_add(pdev);
@@ -713,7 +713,7 @@ static __init int cxl_test_init(void)
 
 		pdev = platform_device_alloc("cxl_switch_dport", i);
 		if (!pdev)
-			goto err_port;
+			goto err_dport;
 		pdev->dev.parent = &uport->dev;
 
 		rc = platform_device_add(pdev);

