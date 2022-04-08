Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBC3C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Apr 2022 19:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiDHTez (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Apr 2022 15:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiDHTey (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Apr 2022 15:34:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B1476281
        for <linux-cxl@vger.kernel.org>; Fri,  8 Apr 2022 12:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649446370; x=1680982370;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UqpuCDRMqTGrbo+7vsjCvCjuyic7SWH+nLSK8qTpE8k=;
  b=VqFdLC/tdmhX8MLrp4yPOHD6WHWAz1Vuy0XNqKlualgMviG14jLle3TG
   714mzQXFs3qN1e/7Nl5S5oooJfp9BBL1i30f9pYm2OmDFlqtwA0XJi7Z9
   fTyQvAyeDCe1orSFP/VIgSEW0tVe2G2SMJqNd8DINM/LdNXNGtCgR/cGH
   hXgVWzrccpVagzfZEdhvF5oUFvVCRb/do5fhHvSoUZ2Ozxtf3yjpMygbh
   HwMrgI+uqv4ccz8Ap/di1PdMDv5Ky3AYl+XllreP+RgHo0LWYcauaJpf6
   MuAYlig6TwkNwYBO5iGRpaNSsUExy9p4hoiabgEYq/2Sy5CBoqewwNTMK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="286670592"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="286670592"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:32:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="571601739"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:32:49 -0700
Subject: [PATCH] cxl/pci: Drop shadowed variable
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Date:   Fri, 08 Apr 2022 12:32:49 -0700
Message-ID: <164944636936.455177.14136200464724208233.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

0day notices that wait_for_media_ready() declares an @rc variable twice.


>> drivers/cxl/pci.c:439:7: warning: Local variable 'rc' shadows outer variable [shadowVariable]
     int rc;
         ^
   drivers/cxl/pci.c:431:6: note: Shadowed declaration
    int rc, i;
        ^
   drivers/cxl/pci.c:439:7: note: Shadow variable
     int rc;
         ^

Cc: Randy Dunlap <rdunlap@infradead.org>
Fixes: 523e594d9cc0 ("cxl/pci: Implement wait for media active")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 077ea064bddd..e7ab9a34d718 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -437,7 +437,6 @@ static int wait_for_media_ready(struct cxl_dev_state *cxlds)
 
 	for (i = mbox_ready_timeout; i; i--) {
 		u32 temp;
-		int rc;
 
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);

