Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E7FC4321E
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 23:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiK3XVG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiK3XUs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 18:20:48 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F602B033C
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 15:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669850010; x=1701386010;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GK2UGDGHO1BsuakgcQiTXroGCuH/wCMhZZtPFwFmKPg=;
  b=AB3A57K6JYChqpu0gk5nu3ouOvichYQSL1sKPSXNrf2O5xeMh7DDrm+R
   95Z4iUiKJBtp5bWmDxbeKV4Tf+UUt29/ycaDUuwKiy12p6JpwPwQXoW4E
   35nyogzzZBySTXTri3R2y53PxbxpMvPNO5gg51rBPLAQgc00hwAPsoRjy
   173bNp3+UBWctmeNh6ExoU4iHjYl6VPAoC406Z7A0DwQuny8Gc1OGDFKb
   1ggvfa0Ol8pUh/iZ0D+Hmj+m+8NYBFgvbMxp0WD4JuCXoxD94Kk/1lpoA
   y4kV26O1o34BziPWXIx2dq8mX24PSFUsQcjn2QPJDpsXok8ixbuNvE9Ur
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="379812112"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="379812112"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:13:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="733171169"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="733171169"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:13:01 -0800
Subject: [RFC PATCH 8/8] cxl: remove locked check for dvsec_range_allowed()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rrichter@amd.com, terry.bowman@amd.com
Date:   Wed, 30 Nov 2022 16:13:01 -0700
Message-ID: <166984998110.2805382.13413879869123517058.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

There is no reason that the CFMWS will always set the "Fixed Device
Configuration" bit in the "Window Restrictions" field. Remove the
CXL_DECODER_F_LOCK check.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 009c11b43303..d92fb757e495 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -229,8 +229,6 @@ static int dvsec_range_allowed(struct device *dev, void *arg)
 
 	cxld = to_cxl_decoder(dev);
 
-	if (!(cxld->flags & CXL_DECODER_F_LOCK))
-		return 0;
 	if (!(cxld->flags & CXL_DECODER_F_RAM))
 		return 0;
 


