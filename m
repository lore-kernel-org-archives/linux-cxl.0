Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9396DC636D3
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 19:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBHTWX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Feb 2023 14:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjBHTWP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Feb 2023 14:22:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A791BD1
        for <linux-cxl@vger.kernel.org>; Wed,  8 Feb 2023 11:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675884132; x=1707420132;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZJQuizj0iVj+k2xIEA8xPNDClVKThPUqu/YuCHqnb8A=;
  b=KDznIjns0eJWgumQEWmF+i3kaHexTEEkIpBRkwC2lqSNRBE4MkVrTlSX
   ak6CjNpKWGZK0soLfpUuHhKVJRwG4FKMFGcDsRNxaWOVK5Zczh1WCTOgW
   VH/G7A5iYfwAV+45GXBjTBHa61gtteswrP6X2NzvqmhzV7HiEYmA42/3x
   H/uM228kj0LLq08RXUK9vRkXRLWxqHZjnugjPLIIAXwIKoPng1USnG1rw
   IwHk2Y1t5RSPDrfoq89sVKntG9T9YyckV14CK2fhfhvwF6HFdlmG34jkg
   D7v4ojgbslswH1qJLIXtgweWZDucrwLwBlaw+MpbuOrAmaIlIPMV8XM1w
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="416119925"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="416119925"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 11:21:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="912825275"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="912825275"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.48.215])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 11:21:49 -0800
Subject: [PATCH v4 7/7] cxl: remove locked check for dvsec_range_allowed()
From:   Dave Jiang <dave.jiang@intel.com>
To:     dan.j.williams@intel.com
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Date:   Wed, 08 Feb 2023 12:21:47 -0700
Message-ID: <167588410599.1155956.845452402773138048.stgit@djiang5-mobl3.local>
In-Reply-To: <167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local>
References: <167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Remove the CXL_DECODER_F_LOCK check to be permissive of platform BIOSes
that allow CXL.mem to be remapped.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v4:
- Change commit log for more clarity. (Dan)
---
 drivers/cxl/core/pci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index cfd869a1fa93..f18262cbe82a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -228,8 +228,6 @@ static int dvsec_range_allowed(struct device *dev, void *arg)
 
 	cxld = to_cxl_decoder(dev);
 
-	if (!(cxld->flags & CXL_DECODER_F_LOCK))
-		return 0;
 	if (!(cxld->flags & CXL_DECODER_F_RAM))
 		return 0;
 


