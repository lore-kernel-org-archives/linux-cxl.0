Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE83BC433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbiAXAyC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:54:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:17142 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240666AbiAXAyB (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985641; x=1674521641;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JxQHq++cKcwYuG64L4PjCHaXOd/DYu1/ChwrclgFe10=;
  b=JzqlTkWada0K65Rt7+QAbYzlY/unMH7z1lBB0NNnCXpntJJkvf6knK0t
   hU6z3W8dtUOjnYyRVxe9UFEj0P1pXjdwLQot6029KFkJmPjt5em9VsQW8
   n9bTps1Oi3XGokW1TIXg39+5mph2mDXqpRdOg/NPDZzBYa+ltfbwkE3r5
   NcHP+idLQkxfjx1roSaFFUDE7xzjjUMc6iO/aO38FNgydKm3UbpMeOzmT
   glJhpo4ZLaciOR3NLbQ9X7W15c7LdB7ZhZapg/J8KNxxUc9TtIspAtOV2
   oePZkJZLUSsWLxHe20DUlNjMd7WsrtWTyWTv/CU+LZYAnb2j0b1d2u4RL
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306652180"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306652180"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:54:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="623906052"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:54:01 -0800
Subject: [ndctl PATCH 25/37] cxl/memdev: Cleanup memdev filter
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:54:01 -0800
Message-ID: <164298564100.3021641.9410483964085163708.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

util_cxl_memdev_filter() already handles the difference between 'mem%d',
'%d', and 'all' for the identifier format. Drop the duplicate / incomplete
format checking.

If the checking for bad formats was dropped too then this command could
support "0,1,2" syntax in addition to "0 1 2" like 'cxl list'. However, it is
not clear that's worthwhile since 'list' is ok to be imprecise, but memdev
commands need to be stricter.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/memdev.c |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/cxl/memdev.c b/cxl/memdev.c
index 327c2608f179..4cca8b8c10be 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -191,16 +191,16 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 		usage_with_options(u, options);
 	for (i = 0; i < argc; i++) {
 		if (strcmp(argv[i], "all") == 0) {
-			argv[0] = "all";
 			argc = 1;
 			break;
 		}
+		if (sscanf(argv[i], "mem%lu", &id) == 1)
+			continue;
+		if (sscanf(argv[i], "%lu", &id) == 1)
+			continue;
 
-		if (sscanf(argv[i], "mem%lu", &id) != 1) {
-			log_err(&ml, "'%s' is not a valid memdev name\n",
-				argv[i]);
-			err++;
-		}
+		log_err(&ml, "'%s' is not a valid memdev name\n", argv[i]);
+		err++;
 	}
 
 	if (err == argc) {
@@ -243,11 +243,7 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 	count = 0;
 
 	for (i = 0; i < argc; i++) {
-		if (sscanf(argv[i], "mem%lu", &id) != 1
-				&& strcmp(argv[i], "all") != 0)
-			continue;
-
-		cxl_memdev_foreach (ctx, memdev) {
+		cxl_memdev_foreach(ctx, memdev) {
 			if (!util_cxl_memdev_filter(memdev, argv[i], NULL))
 				continue;
 

