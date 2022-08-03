Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ED0C19F28
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 07:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiHCHYn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 03:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiHCHYk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 03:24:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088401CFF8
        for <linux-cxl@vger.kernel.org>; Wed,  3 Aug 2022 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659511480; x=1691047480;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=insGid9yE2zTq/BmuOBxwZ6Po+yLXOnN7+jiObbMdt4=;
  b=hRXGSZA3elmmlroK25NlI/ejHF88gD5kSgjnItrAc3Jkp84gf2nGYLlL
   IUJdfH5M8T6WKrnrNozcNg2koyM6N36ru2UkHC05jG2LFUlLn6Di8BMPQ
   8IHOglpvkq0AdPdNniZuqnPrMgT1/2FSu4B5npPlwkLbd7PQ/QBEnIN6t
   CefUc/9WLqCDLXnnlZ23GNgWQanbtDbIHzdcR34sB7P9EcS0c7TgkPT9W
   zmfZBGpPLEoKDolB0UlZ5BCOZD0NL1l5ORBokqT9CjGHR+Xs83dmq0AfQ
   Xhh35BqRNIGGvdOdRE7We6N0TRKTB80RKY4B4yh+mS+eJZ1D0kP6na21u
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="353611061"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="353611061"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 00:24:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="670766068"
Received: from jplumb-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.28.212])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 00:24:35 -0700
Subject: [PATCH 3/4] cxl/region: Fix port setup uninitialized variable
 warnings
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        dave.jiang@intel.com
Date:   Wed, 03 Aug 2022 00:24:34 -0700
Message-ID: <165951147487.967013.929590444907251028.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
References: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

0day robot reports:

drivers/cxl/core/region.c:1068 cxl_port_setup_targets() error: uninitialized symbol 'eiw'.
drivers/cxl/core/region.c:1068 cxl_port_setup_targets() error: uninitialized symbol 'peig'.
drivers/cxl/core/region.c:1068 cxl_port_setup_targets() error: uninitialized symbol 'peiw'.

...which are all valid reports. Add debug statement to consume the,
albeit unexpected, errors.

Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a073f16355ca..5c931b6eb4e7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1059,8 +1059,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		parent_iw = parent_cxld->interleave_ways;
 	}
 
-	granularity_to_cxl(parent_ig, &peig);
-	ways_to_cxl(parent_iw, &peiw);
+	rc = granularity_to_cxl(parent_ig, &peig);
+	if (rc) {
+		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
+			dev_name(parent_port->uport),
+			dev_name(&parent_port->dev), parent_ig);
+		return rc;
+	}
+
+	rc = ways_to_cxl(parent_iw, &peiw);
+	if (rc) {
+		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
+			dev_name(parent_port->uport),
+			dev_name(&parent_port->dev), parent_iw);
+		return rc;
+	}
 
 	iw = cxl_rr->nr_targets;
 	ways_to_cxl(iw, &eiw);

