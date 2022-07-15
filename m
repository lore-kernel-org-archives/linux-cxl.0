Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951BEC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Jul 2022 06:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiGOG0P (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Jul 2022 02:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiGOG0O (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Jul 2022 02:26:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953604199F
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 23:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657866373; x=1689402373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ec1UsofLsT2zBzMmelAJpaxsmG95QiYW6WxxL7sD3Wk=;
  b=GS1eLInFLs67BMEw76PCld4h3Ee3MJU1aTN/b9htmb8oqnT0DNL8sMHl
   JoE6QVbvxNHfvY3oxPAJ5iNknU4VhzlVjL/qpZASErcF2e9z9Fa0iO/rl
   SnD7Drtys/r0/enNQr7QDtcpvBi0bNo1Ykz/fURDayLNW9D0pKzZfcQrA
   6/a4Na+d0kyee9XAj69M+T5XVrLdgRGwMY2d2ngpcs+MkOWIfjSVkS2S4
   svPpeU5pivS6Cv1+pCstJ591NGP/8mm5U6QWQCeBJVNMqMsNIiWFpH/jU
   5+d61ZdJWQfI2N7Ex5meMYUXkuy+NMW/AtO6ukSRHxBbPUfZIj4TpUP//
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286852224"
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="286852224"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 23:26:13 -0700
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="546544634"
Received: from saseiper-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.71.32])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 23:26:12 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 8/8] cxl/list: make memdevs and regions the default listing
Date:   Fri, 15 Jul 2022 00:25:50 -0600
Message-Id: <20220715062550.789736-9-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220715062550.789736-1-vishal.l.verma@intel.com>
References: <20220715062550.789736-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; h=from:subject; bh=Ec1UsofLsT2zBzMmelAJpaxsmG95QiYW6WxxL7sD3Wk=; b=owGbwMvMwCXGf25diOft7jLG02pJDEkXOfIay+rvFuTq6XM01bqe9TjCcYj9kJrFXI6QxRJnZJum fvDvKGVhEONikBVTZPm75yPjMbnt+TyBCY4wc1iZQIYwcHEKwETSLjMy/HK5Z/YgdYLbv5j85iNps+ /t9Y6v6/d78rOyO5LDobHtJyPDvhU/S9NzOUyOL4s8FGI50fFDH9MW2zrd9Ttzs07MkTjADwA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Instead of only listing regions by default (which can often be empty if
no regions have been configured), change the default listing mode to
both memdevs and regions. This will allow a plain 'cxl-list' to be a
quick health check of whether all the expected memdevs have enumerated
correctly, and see any regions that have been configured.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/list.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cxl/list.c b/cxl/list.c
index 88ca9d9..5f604ec 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -100,9 +100,10 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 			param.regions = true;
 	}
 
-	/* List regions by default */
+	/* List regions and memdevs by default */
 	if (num_list_flags() == 0) {
 		param.regions = true;
+		param.memdevs = true;
 	}
 
 	log_init(&param.ctx, "cxl list", "CXL_LIST_LOG");
-- 
2.36.1

