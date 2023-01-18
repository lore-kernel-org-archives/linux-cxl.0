Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1412EC678DC
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 18:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjARSKQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 Jan 2023 13:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjARSJx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 Jan 2023 13:09:53 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADD75AB53
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 10:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674065372; x=1705601372;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cwsHvAVBw7GdaIpvRk0WkAmTe2YI+XapQdfAGXMg4Hk=;
  b=DywtrrdaBWp904trXNeA7ZHPe5JZBJ8JfLMYL98MbLn1WTCepfu5n18p
   16pr0f19VcZTLwhRLm0w/KI91mY5LOJ65Hlnw95dTgi3jYoW6Tc6DLx5I
   oUSih6PpQ21a4EyFGl5Vjn6r5aQqQH9CMj4XfLc0tkz6KphemWAfOyTgp
   xzx4YsYByTzTT2SrSQ5RSYa5JRM2D6glOLUHOgfyHpzX3kX6WcIh8lQYD
   7YkJ7Yi/G2mvy1U+fwVg2Quczw7bXzxFM6sXsClxWQFWu6q3lP1rixn8a
   DKcuWKVnT2UgvTriiEEH9CWFLHpFMvPP2MPc/H+M+4SOKaN/SEhDUOaEN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="387406258"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="387406258"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:09:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="905195604"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="905195604"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.213.179.103])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:09:31 -0800
Subject: [PATCH v3 8/8] cxl: remove locked check for dvsec_range_allowed()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        jonathan.cameron@huawei.com
Date:   Wed, 18 Jan 2023 11:09:29 -0700
Message-ID: <167406536836.1455071.374208676614721474.stgit@djiang5-mobl3.local>
In-Reply-To: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

There is no reason that the CFMWS will always set the "Fixed Device
Configuration" bit in the "Window Restrictions" field. Remove the
CXL_DECODER_F_LOCK check.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index be59f7271f62..e1aadb411f2f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -228,8 +228,6 @@ static int dvsec_range_allowed(struct device *dev, void *arg)
 
 	cxld = to_cxl_decoder(dev);
 
-	if (!(cxld->flags & CXL_DECODER_F_LOCK))
-		return 0;
 	if (!(cxld->flags & CXL_DECODER_F_RAM))
 		return 0;
 


