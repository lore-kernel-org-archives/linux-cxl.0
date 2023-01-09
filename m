Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325F0C54EBD
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Jan 2023 21:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbjAIVoW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 9 Jan 2023 16:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbjAIVoQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 9 Jan 2023 16:44:16 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B2860E1
        for <linux-cxl@vger.kernel.org>; Mon,  9 Jan 2023 13:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673300655; x=1704836655;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E/trlT13ETI3YmJPANL0iuM/1+/cvraUbIuYEE/imag=;
  b=hF4x41GChaTYTMircpuarWyM80JYjKx/y47z4fiXB0vCjP8MfzgGXuJd
   pJbfTRk6/JL8lWa1VU+iGUbyuNQ6S8qKqg5kwzAjevKgameUK58nrM6UF
   wj5haIsyS09hBM8ZA3FJy7xKnruGm5qsW2fTAx9yuBzIwKI4gmHvpgetN
   mESfVq770AORTMVf601lOWe31aQKfCXjfJI7/CVuqKChohmXLRULCXZMv
   pKvSbVM7f09d7p5eC4q469G3M/N9fL2PsJhPnrExqgZyYeiQ/ZKpyPaxv
   BCr4+h6Z/iybBOhGT1Hd+jrSW2UKLEae5XCRuTGnCSSeCNDnVhj38SDvc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324996149"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="324996149"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:44:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="780833670"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="780833670"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.37.174])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:44:15 -0800
Subject: [PATCH v2 8/8] cxl: remove locked check for dvsec_range_allowed()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        jonathan.cameron@huawei.com
Date:   Mon, 09 Jan 2023 14:44:13 -0700
Message-ID: <167330065180.975161.18302590071676919347.stgit@djiang5-mobl3.local>
In-Reply-To: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
References: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c6d6d7b720c5..931ac4be539a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -228,8 +228,6 @@ static int dvsec_range_allowed(struct device *dev, void *arg)
 
 	cxld = to_cxl_decoder(dev);
 
-	if (!(cxld->flags & CXL_DECODER_F_LOCK))
-		return 0;
 	if (!(cxld->flags & CXL_DECODER_F_RAM))
 		return 0;
 


