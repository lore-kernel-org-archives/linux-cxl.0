Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC74C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 21:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJKVnj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJKVng (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 17:43:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D7AA02F4
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665524614; x=1697060614;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+xF0GeZ6i9sxENbtnG0ovgpULGRkkplOU4hEVjzMX/o=;
  b=GDNII7z3Px5J0NBBR1TebmdWZRTmfAaFjPvTbqtvijg7kFQgd8LEdicg
   CdASi+D/bMq8G7u7XHlUwzNBbkETzPvL0ck7UZrpt/PA3kdrgXJ/7/HkG
   VNJDsQR4BxocwpoanRnum1phG2bvZZDCLLcMG6xI9G69g5lG+zaz2nSfS
   //WMBQSuh/XIlDGmfmIUK8sbYsfTU/NzilmvoUVcD5Xms6JW6pgQT2Tyd
   056yprk1vKoaJ0Bd/2GDJMpY+Db3jfTDyGfLUciXeESJxaPAWbS3iR+DM
   /zhlSAQlQ63rm04jRaygpwxrLYEAe8RG2iRXykO41zFm8MLa2viLGBF4t
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="285014591"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="285014591"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 14:43:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="768960893"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="768960893"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 14:43:34 -0700
Subject: [PATCH] cxl: update var names for interleave ways conversion macros
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Tue, 11 Oct 2022 14:43:33 -0700
Message-ID: <166552461397.1940763.17766745890158322847.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Change var names for interleave ways macros to clearly indicate which
variable is encoded and which is the actual ways value.

iw == interleave ways
eniw == encoded interleave ways

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxl.h |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7a4f740d710c..c0d826084465 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -78,14 +78,14 @@ static inline int cxl_to_granularity(u16 enig, unsigned int *ig)
 }
 
 /* Encode defined in CXL ECN "3, 6, 12 and 16-way memory Interleaving" */
-static inline int cxl_to_ways(u8 eniw, unsigned int *val)
+static inline int cxl_to_ways(u8 eniw, unsigned int *iw)
 {
 	switch (eniw) {
 	case 0 ... 4:
-		*val = 1 << eniw;
+		*iw = 1 << eniw;
 		break;
 	case 8 ... 10:
-		*val = 3 << (eniw - 8);
+		*iw = 3 << (eniw - 8);
 		break;
 	default:
 		return -EINVAL;
@@ -102,20 +102,20 @@ static inline int granularity_to_cxl(int ig, u16 *enig)
 	return 0;
 }
 
-static inline int ways_to_cxl(unsigned int ways, u8 *iw)
+static inline int ways_to_cxl(unsigned int iw, u8 *eniw)
 {
-	if (ways > 16)
+	if (iw > 16)
 		return -EINVAL;
-	if (is_power_of_2(ways)) {
-		*iw = ilog2(ways);
+	if (is_power_of_2(iw)) {
+		*eniw = ilog2(iw);
 		return 0;
 	}
-	if (ways % 3)
+	if (iw % 3)
 		return -EINVAL;
-	ways /= 3;
-	if (!is_power_of_2(ways))
+	iw /= 3;
+	if (!is_power_of_2(iw))
 		return -EINVAL;
-	*iw = ilog2(ways) + 8;
+	*eniw = ilog2(iw) + 8;
 	return 0;
 }
 


