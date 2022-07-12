Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C9FC43334
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Jul 2022 19:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiGLTbz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Jul 2022 15:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiGLTbh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Jul 2022 15:31:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AF5E4760
        for <linux-cxl@vger.kernel.org>; Tue, 12 Jul 2022 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657652852; x=1689188852;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3XEEQ2shlsXB1UcMa1ofYK+LWnGEANhuw7/bWmk4khg=;
  b=kKhhiffNPiMieoFJ0kEmVWXadL0r+BqplHvvhfwhI+QDwF3KPYFNu07W
   P0RN0kTYsbZkKK3BLm9LnSPBSk0kYetPWW7frvhQ4IabQs5Q0Psz5wpKU
   yf7r6SE8u2kGa+JgzeIFH6FZtXUjNe7Gs3Kj/GvzcBnFx3NvtdVdZXD8J
   TjSPC2gwVNP9QBgNOaE/MCD2zbjwHEydtn8OFzF1sFQCVbeWRzaK2yese
   JzGWQMseIPoP/15CASx4h0eyFrbVJonOptAeagvZzhKnW4uZRoNHErV5O
   R74fR87jb9BVGZOQp8PR5zP5lineLQq2VAt6j9wdPbR3rA7NwT38bs6oy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="265433500"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="265433500"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:07:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="922326367"
Received: from sheyting-mobl3.amr.corp.intel.com (HELO [192.168.1.117]) ([10.212.147.156])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:07:30 -0700
Subject: [ndctl PATCH 01/11] cxl/list: Reformat option list
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     alison.schofield@intel.com, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org
Date:   Tue, 12 Jul 2022 12:07:29 -0700
Message-ID: <165765284992.435671.17218875214208199972.stgit@dwillia2-xfh>
In-Reply-To: <165765284365.435671.13173937566404931163.stgit@dwillia2-xfh>
References: <165765284365.435671.13173937566404931163.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Cleanup some spurious spaces and let clang-format re-layout the options.

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

