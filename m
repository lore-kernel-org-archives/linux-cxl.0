Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0F1C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Jul 2022 17:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiGNRCD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiGNRCC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Jul 2022 13:02:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A59509DC
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657818121; x=1689354121;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EpKSZRUg6s+nHr80Ig7EQknua3MGIHFjqj++oJFMvrE=;
  b=bsM53VRmGUjBSPY1XJqZea7YTv0bdXwSkyWduynr/LipKASDVT6YlDvd
   9PgFK649AnPApoVQkVwfLBBuTCeHuVc4bHoyDv25Njeo5p0ydOZFBqvnr
   jtxotXz49PDQrQhSFARLSzKmGQnJoCDkMgGlb3ZTjEiRecZK3WruMsfca
   xwJ3Iae2yyJwdeTKU/ZwRCGX1tQ+DqeqrYKySh3IhwKsvQUynHY+Hsjw7
   ajHsN+eowEZjs0lG50+XNeYzlsBVKNyIqjGM+C8zZ25PspVzgtxM9h0rj
   QAYzBMTphWMFcfOuJskqYmTdlJKdvSGOidMYrNakVwtrRZf23Cte+VtrP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="265987121"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="265987121"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:01:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="772693773"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:01:53 -0700
Subject: [ndctl PATCH v2 01/12] cxl/list: Reformat option list
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Davidlohr Bueso <dave@stgolabs.net>, alison.schofield@intel.com,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Date:   Thu, 14 Jul 2022 10:01:52 -0700
Message-ID: <165781811294.1555691.6271986101970794441.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com>
References: <165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Cleanup some spurious spaces and let clang-format re-layout the options.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/list.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/cxl/list.c b/cxl/list.c
index 940782d33a10..1b5f58328047 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -36,8 +36,7 @@ static const struct option options[] = {
 		   "filter by CXL endpoint device name(s)"),
 	OPT_BOOLEAN('E', "endpoints", &param.endpoints,
 		    "include CXL endpoint info"),
-	OPT_STRING('d', "decoder", &param.decoder_filter,
-		   "decoder device name",
+	OPT_STRING('d', "decoder", &param.decoder_filter, "decoder device name",
 		   "filter by CXL decoder device name(s) / class"),
 	OPT_BOOLEAN('D', "decoders", &param.decoders,
 		    "include CXL decoder info"),
@@ -45,11 +44,11 @@ static const struct option options[] = {
 		    "include CXL target data with decoders or ports"),
 	OPT_BOOLEAN('i', "idle", &param.idle, "include disabled devices"),
 	OPT_BOOLEAN('u', "human", &param.human,
-		    "use human friendly number formats "),
+		    "use human friendly number formats"),
 	OPT_BOOLEAN('H', "health", &param.health,
-		    "include memory device health information "),
+		    "include memory device health information"),
 	OPT_BOOLEAN('I', "partition", &param.partition,
-		    "include memory device partition information "),
+		    "include memory device partition information"),
 #ifdef ENABLE_DEBUG
 	OPT_BOOLEAN(0, "debug", &debug, "debug list walk"),
 #endif

