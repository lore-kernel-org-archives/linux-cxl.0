Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4F1C67871
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Oct 2022 23:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJXXfh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Oct 2022 19:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJXXfQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Oct 2022 19:35:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8727F40039
        for <linux-cxl@vger.kernel.org>; Mon, 24 Oct 2022 14:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666648547; x=1698184547;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GdyD709FYtjA2p8ZXZg420AjPhsyHtoYBOzfUjPUoLM=;
  b=maUg9bO6EOWZUIs/B1eSTm86QqYCKwZKnsvKJ0I+4/VHDqO2n5bFSuJL
   Mbx13jNYw1NDJjIjQasMPK7C2lpR5IjPK8VwdUUnMYTCE5TLhUnBifC/h
   SbfynyaWshy8vEDjYTNY4jyZG3RwquirK7hFgj91MQ2RLxpw0+lroAQgO
   p8uEGuDvPpntHG+KNNOSd+De4RsNSQv88lWuxnnJGLS44UjBC/ljg81Q/
   mIpamjv1ERZfoYqEI6b87W5IEzC0FUlxv6ev5SUJcG14DdCsi65nllFBK
   CaQ/BOhkowS+nrl7Vi36CACYdbwA5Gq+SHG5r/nq6U2eXeEbzbOVVvRSh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="334122710"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="334122710"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 14:55:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="662577696"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="662577696"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 14:55:07 -0700
Subject: [PATCH] cxl: update eiw_to_ways() comment referring to cxl spec
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 24 Oct 2022 14:55:07 -0700
Message-ID: <166664850753.511468.15931290944330812647.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Change comment pointing to CLX ECN to the releveant released rev3 spec.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index e2a1a7523a2b..512ba28a6349 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -77,7 +77,7 @@ static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
 	return 0;
 }
 
-/* Encode defined in CXL ECN "3, 6, 12 and 16-way memory Interleaving" */
+/* Encode defined in CXL rev3.0 8.2.4.19.7 CXL HDM Decoder n Control Register */
 static inline int eiw_to_ways(u8 eiw, unsigned int *ways)
 {
 	switch (eiw) {


