Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93522C4708E
	for <linux-cxl@archiver.kernel.org>; Mon,  5 Dec 2022 19:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiLETs2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 14:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiLETry (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 14:47:54 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98768262A
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 11:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670269482; x=1701805482;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OtLNDO9TsI9+kRZmX6a+qJFF+FH9pfSqdQa4ex1RF50=;
  b=Epq1kK+hc9EZdZKTDWgBv9XuXA1+ZrquwVk79PHSCxYL1TLZgzT5ZFVQ
   4r7ZTgpL0iw/om7BMhahK1UKpB9dcqJy9PYjulkoimQmetN8GK+hazRNH
   1eis+VbQQpdp5Oa74rsAR3FpMpE9y+7LT8d418+T75dIvMSrc0xYSd+DX
   wTDQNlN9znbJzZZH1bRvYxpKy9MYft9PScQ/1oTFUETdg2RE4ClV1LJK1
   bMU9Tbjb1eVdjuptYYWt25P0fDmJQ7IyfshlOaTWJykePkLzGBn62QcTa
   yC1TgnVphcbCJR3qcfE9PLkxKOEZRnas4saCjK33DFKnIDbzuMgSBTaUF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="314096219"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="314096219"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 11:44:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="752328560"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="752328560"
Received: from bmnebren-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.114.171])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 11:44:42 -0800
Subject: [PATCH] tools/testing/cxl: Require cache invalidation bypass
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Alison Schofield <alison.schofield@intel.com>, dave.jiang@intel.com
Date:   Mon, 05 Dec 2022 11:44:41 -0800
Message-ID: <167026948179.3527561.4535373655515827457.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The typical environment where cxl_test is run, QEMU, does not support
cpu_cache_invalidate_memregion(). Add the 'test' bypass symbols to the
configuration check.

Reported-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/config_check.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/cxl/config_check.c b/tools/testing/cxl/config_check.c
index de5e5b3652fd..c4c457e59841 100644
--- a/tools/testing/cxl/config_check.c
+++ b/tools/testing/cxl/config_check.c
@@ -10,4 +10,6 @@ void check(void)
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_BUS));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_ACPI));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_PMEM));
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST));
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_NVDIMM_SECURITY_TEST));
 }

