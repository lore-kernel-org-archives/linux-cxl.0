Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88376C4167B
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Dec 2022 00:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbiLNA0D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Dec 2022 19:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbiLNAZq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Dec 2022 19:25:46 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB096C771
        for <linux-cxl@vger.kernel.org>; Tue, 13 Dec 2022 16:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670977543; x=1702513543;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m7jbLM0XghqsToxyKzyLdUFEETSZIgZS6zF4ttJpczw=;
  b=cZgclYGCRIuGarA3G/hgbA5tU9EPmmZWJKLborI79QQxCZeJeU0QUlSj
   ck5er689r5Z7WTW8FLkRqDAeN1uGvHR2Qe1XGGHhWq9SW5cx3eXHicQqS
   zfRhZ4KmffebgGcmLGAOwZf0ieq8QQj1jdxR01IF12/6+WTgygUJlucd2
   XPmuInzb6qlaeGszuopPIgzYbxRy8Fc0+3UMiuQ1P/Lpt4BYEQd8nTOmq
   HkIryksNJvr30RNZFQAPN7MzV6t3ij63NAUAIGdrG+sEW3NwXUgBhDUqj
   n+b4BnaqNwHNgl0FLdLj7z0czNbcs0sJBReLOhoJHEQnVOJ4cllaDOqQf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="404540184"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="404540184"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 16:25:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="823084723"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="823084723"
Received: from mesplin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.37.170])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 16:25:27 -0800
Subject: [ndctl PATCH 1/5] cxl/list: include --endpoints in -v listings
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Matthew Ho <sunfishho12@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        vishal.l.verma@intel.com, patches@lists.linux.dev
Date:   Tue, 13 Dec 2022 16:25:27 -0800
Message-ID: <167097752718.1189953.16557353877320313731.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167097752151.1189953.3189708700022130101.stgit@dwillia2-xfh.jf.intel.com>
References: <167097752151.1189953.3189708700022130101.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Vishal Verma <vishal.l.verma@intel.com>

The first level of -v (--verbose) for cxl-list is meant to include all
topological details of the CXL hierarchy on a platform. The endpoints
listing was missing from the first level, and also wasn't added at a
higher verbosity level. Fix this omission by adding endpoints to the -v
verbosity level.

Fixes: 8b61e8e75443 ("cxl: Add list verbose option to the cxl command")
Cc: Matthew Ho <sunfishho12@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/list.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/cxl/list.c b/cxl/list.c
index 2f5e83d86578..e3ef1fb533c9 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -123,6 +123,7 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 	case 1:
 		param.buses = true;
 		param.ports = true;
+		param.endpoints = true;
 		param.decoders = true;
 		param.targets = true;
 		/*fallthrough*/

