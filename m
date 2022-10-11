Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9878CC4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 21:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJKVnc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJKVna (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 17:43:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D004C63B
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665524609; x=1697060609;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EBc0NToQFGRTKBB2LGqGhgOm1PdM45s+l5cGleDEzTQ=;
  b=kZJ8EkRK6woPC2VMSW9OkQrVrfOnCYrPu2/6VfMk74B6MeITPdMTyZgu
   sQOOIbcACjwi1L0GC/5oaahtiLyBDWo5xko2SBd9ZpATcmY1k4C6h2NkD
   0sCj6gCtVQM8TjoQxEz9wxX7bxEjV248dLHsR0bF7SNBC4bVOHMOOvP3o
   r6XRYErshWl88p+gPs0CfkNyABBP5qMoVFeGfebSHfUHCGfB47hcvQCZG
   Y681g54jI5ZHaGMv+sp7aW8drTi15r6YNkoCZ8DRm4r2LP17ah2bbOY98
   TlNj+Tza3ve4XgQg7irp18xEveSLwAFW6IOaYXX5qScxZip30V+o3cG8f
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="305690344"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="305690344"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 14:43:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="768960870"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="768960870"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 14:43:28 -0700
Subject: [PATCH] cxl: update var names for interleave granularity conversion
 macros
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Tue, 11 Oct 2022 14:43:28 -0700
Message-ID: <166552460832.1940763.12713460501172006832.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Change var names for granularity macros to clearly indicate which
variable is encoded and which is the actual granularity.

ig == interleave granularity
enig == encoded interleave granularity

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxl.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f680450f0b16..7a4f740d710c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -69,11 +69,11 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 }
 
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
-static inline int cxl_to_granularity(u16 ig, unsigned int *val)
+static inline int cxl_to_granularity(u16 enig, unsigned int *ig)
 {
-	if (ig > 6)
+	if (enig > 6)
 		return -EINVAL;
-	*val = 256 << ig;
+	*ig = 256 << enig;
 	return 0;
 }
 
@@ -94,11 +94,11 @@ static inline int cxl_to_ways(u8 eniw, unsigned int *val)
 	return 0;
 }
 
-static inline int granularity_to_cxl(int g, u16 *ig)
+static inline int granularity_to_cxl(int ig, u16 *enig)
 {
-	if (g > SZ_16K || g < 256 || !is_power_of_2(g))
+	if (ig > SZ_16K || ig < 256 || !is_power_of_2(ig))
 		return -EINVAL;
-	*ig = ilog2(g) - 8;
+	*enig = ilog2(ig) - 8;
 	return 0;
 }
 


