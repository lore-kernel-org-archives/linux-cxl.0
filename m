Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D46EC4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Dec 2022 21:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLHV3N (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Dec 2022 16:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiLHV3K (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Dec 2022 16:29:10 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F618E593
        for <linux-cxl@vger.kernel.org>; Thu,  8 Dec 2022 13:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670534949; x=1702070949;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wH0kGeai/cpvOxG0zFKnev7rIw6TBDR69wboanX1i7Q=;
  b=nWc6OBmrb6oPn2FH1t2ezHsuLfjwP19n/Mi2EnAfZhhHb98XmzKM9Jzu
   /Wf/nXp7VzaKxR+goZJ3xB48Qd5+Fuv5Fan1X2orlU2e87WixkaJ9s2ic
   znV2S87UuWHhT+QDZT7IJ32rnbIpamuQGATfPlGoCH3nIFlEnCzFm4VwO
   RP61nnvCFPqdLYptpcK0HekcLhF3xyoDtkTSre87PYaUwo14mU2yX1Ly3
   8gITNwIH4yxBJgvrA++h6cc6FaPDpXhmWiAOpH2ZL9u15dJxSXOynsXGy
   7CdgYMJHlYtFKxn0CU8jZlwdFEO3IWtImEgutdL8H8kJ+P/uREAWHxmIx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="304950740"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="304950740"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 13:29:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="649323091"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="649323091"
Received: from kputnam-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.251.25.149])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 13:29:09 -0800
Subject: [ndctl PATCH v2 12/18] cxl/region: Make granularity an integer
 argument
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, alison.schofield@intel.com,
        nvdimm@lists.linux.dev, vishal.l.verma@intel.com
Date:   Thu, 08 Dec 2022 13:29:08 -0800
Message-ID: <167053494873.582963.9998892394422308576.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167053487710.582963.17616889985000817682.stgit@dwillia2-xfh.jf.intel.com>
References: <167053487710.582963.17616889985000817682.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Since --granularity does not take a unit value like --size, just make it an
integer argument directly and skip the hand coded conversion.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/region.c |   26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/cxl/region.c b/cxl/region.c
index 494da5139c05..c6d7d1a973a8 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -21,24 +21,25 @@
 static struct region_params {
 	const char *bus;
 	const char *size;
-	const char *granularity;
 	const char *type;
 	const char *root_decoder;
 	const char *region;
 	int ways;
+	int granularity;
 	bool memdevs;
 	bool force;
 	bool human;
 	bool debug;
 } param = {
 	.ways = INT_MAX,
+	.granularity = INT_MAX,
 };
 
 struct parsed_params {
 	u64 size;
 	u64 ep_min_size;
 	int ways;
-	unsigned int granularity;
+	int granularity;
 	const char **targets;
 	int num_targets;
 	struct cxl_decoder *root_decoder;
@@ -67,9 +68,8 @@ OPT_STRING('s', "size", &param.size, \
 	   "total size desired for the resulting region."), \
 OPT_INTEGER('w', "ways", &param.ways, \
 	    "number of memdevs participating in the regions interleave set"), \
-OPT_STRING('g', "granularity", \
-	   &param.granularity, "interleave granularity", \
-	   "granularity of the interleave set"), \
+OPT_INTEGER('g', "granularity", &param.granularity,  \
+	    "granularity of the interleave set"), \
 OPT_STRING('t', "type", &param.type, \
 	   "region type", "region type - 'pmem' or 'ram'"), \
 OPT_BOOLEAN('m', "memdevs", &param.memdevs, \
@@ -140,18 +140,15 @@ static int parse_create_options(int argc, const char **argv,
 		return -EINVAL;
 	}
 
-	if (param.granularity) {
-		unsigned long granularity = strtoul(param.granularity, NULL, 0);
-
-		if (granularity == ULONG_MAX || (int)granularity <= 0) {
-			log_err(&rl, "Invalid interleave granularity: %s\n",
+	if (param.granularity < INT_MAX) {
+		if (param.granularity <= 0) {
+			log_err(&rl, "Invalid interleave granularity: %d\n",
 				param.granularity);
 			return -EINVAL;
 		}
-		p->granularity = granularity;
+		p->granularity = param.granularity;
 	}
 
-
 	if (argc > p->ways) {
 		for (i = p->ways; i < argc; i++)
 			log_err(&rl, "extra argument: %s\n", p->targets[i]);
@@ -390,12 +387,11 @@ static int cxl_region_determine_granularity(struct cxl_region *region,
 					    struct parsed_params *p)
 {
 	const char *devname = cxl_region_get_devname(region);
-	unsigned int granularity;
-	int ways;
+	int granularity, ways;
 
 	/* Default granularity will be the root decoder's granularity */
 	granularity = cxl_decoder_get_interleave_granularity(p->root_decoder);
-	if (granularity == 0 || granularity == UINT_MAX) {
+	if (granularity == 0 || granularity == -1) {
 		log_err(&rl, "%s: unable to determine root decoder granularity\n",
 			devname);
 		return -ENXIO;

