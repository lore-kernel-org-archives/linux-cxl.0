Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21869C74A5B
	for <linux-cxl@archiver.kernel.org>; Wed, 29 Mar 2023 21:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjC2Vgn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 29 Mar 2023 17:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjC2Vgm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 29 Mar 2023 17:36:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BA92681
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 14:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680125801; x=1711661801;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fl3vUCS6X8oyifTLXUxkJO1LQZ1fzfaX1G8NA9etXko=;
  b=l8ElDY23TYyrxk1diZVz7M/kvu5z539udOTP6K0O4qD5sHb1+gBfvn8V
   GEZzqYqz4n3zPAvyksoOmW4djI5ULY4HNKwyOTI3E9qZd690NbKmvx9/o
   V/UXlZjR3we0ffAq2itVI+OejfjQw3eD0LH1OWz6t0thizThR+KunD0UF
   UjB4UTGAioczGlJ//Oq/aJrj+6mTop30g9Of3+n6LNEQ8hqc0vQ6TA+NK
   rksCHFuAXePLojBeWpAp33O7lzdhKvkzRVcLHfKIGDJPfx52nAe4ys116
   53Xn0FdSpogjPYEEGTqXxGpzgl7xb0eeAFxsDdFk5pbus7+EJb33R2FJD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="321391384"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="321391384"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 14:35:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="753754470"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="753754470"
Received: from zmutlu-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.176.100])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 14:35:44 -0700
Subject: [PATCH] cxl/hdm: Avoid NULL deref when component registers are
 missing
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>
Date:   Wed, 29 Mar 2023 14:35:43 -0700
Message-ID: <168012574357.221280.5001364964799725366.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The cxl_port driver attempts to support endpoint devices that do not
advertise a component register block, but by inspection
devm_cxl_setup_hdm() passes a NULL @crb to helper functions that should
be skipped.

Return early and skip setting target_count since that is only relevant
for switch decoders, not endpoint decoders.

Fixes: 757f6448b100 ("cxl/hdm: Fix double allocation of @cxlhdm")
Tested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 5293fe13fce3..cc123996b1a4 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -123,7 +123,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
 	if (!crb && info && info->mem_enabled) {
 		cxlhdm->decoder_count = info->ranges;
-		cxlhdm->target_count = info->ranges;
+		return cxlhdm;
 	} else if (!crb) {
 		dev_err(dev, "No component registers mapped\n");
 		return ERR_PTR(-ENXIO);

