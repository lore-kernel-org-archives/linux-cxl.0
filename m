Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D279BECAAD8
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Sep 2022 21:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiIUVCv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Sep 2022 17:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIUVCt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Sep 2022 17:02:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0560CA5728
        for <linux-cxl@vger.kernel.org>; Wed, 21 Sep 2022 14:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663794169; x=1695330169;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZhWQONEsjwWmD5xXRq7QVScsHxlSfo61SS3x1MMKs5c=;
  b=Ir7cTC1TPKYo2zBMWIyowjivAZrqf+dRDoHQhncKrl2wNgxwB1Q3cF+K
   4QwYxqQ7Qsn62tVbRecZzVoAs6MT1re0MNxL2bSH1MUUxEFiGcw/NsASI
   2Rd9mivy+V9W1i++AN2NhZkvHvru70Z91PjY63gkpAr2VsZU1N/ylTqQp
   G8Hx//IVODqbkCztBrUrWLaQnH++VKDuvmouYP7YdBg6LWl9weNTr/K/u
   neorhm12LPyNfdvwgI8RFOFbOj39MSjkjnWar4i5kEwwkEu9oPfWJpGtI
   Glbd6bGtJv1AuRM25i2JVeFL7Gq6ggU4zJ/FP4EmPpfSsliaG8ywzob9A
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="361886317"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="361886317"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 14:02:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="681934786"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 14:02:48 -0700
Subject: [PATCH 2/4] ndctl/libndctl: Add bus_prefix for cxl
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     vishal.l.verma@intel.com
Date:   Wed, 21 Sep 2022 14:02:47 -0700
Message-ID: <166379416797.433612.11380777795382753298.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166379397620.433612.13099557870939895846.stgit@djiang5-desk3.ch.intel.com>
References: <166379397620.433612.13099557870939895846.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

With support of being able to detect the cxl bus, setup the bus_prefix
for cxl bus.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 ndctl/lib/libndctl.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 10422e24d38b..d2e800bc840a 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -2012,6 +2012,12 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 			goto out;
 		}
 		rc =  add_papr_dimm(dimm, dimm_base);
+	} else if (ndctl_bus_has_cxl(bus)) {
+		dimm->bus_prefix = strdup("cxl");
+		if (!dimm->bus_prefix) {
+			rc = -ENOMEM;
+			goto out;
+		}
 	}
 
 	if (rc == -ENODEV) {


