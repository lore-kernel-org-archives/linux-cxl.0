Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668AAC433FE
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Nov 2022 23:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiKFXrj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Nov 2022 18:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiKFXrj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Nov 2022 18:47:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93665D2C8
        for <linux-cxl@vger.kernel.org>; Sun,  6 Nov 2022 15:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667778458; x=1699314458;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NJHZn6/cXtZFPw8koUObH+vbAw1TMznWvoJVYXV7BeE=;
  b=LXEUQvvOXGHKeNeIR4llq1kyrgcCy3YOjg1OCOv/qXo5+3xXNL7Z3Ue9
   jO6Rb2U2mOTOqInm5GjinNU79DvuNEBqp1SE3eb0Fz3zTLu7GzIgsWphA
   I5RqY+yKbzy+BcmY3jVcqBXj6lKW7TL7TsxmF151kxzuHKz+Qvk+qm85u
   gKCAziI0qiUDKADxYnyzLrA4n2e8YUN3RrZEd8xTWVFHaQ03EtN+S6L9D
   db5pmTF1IOaFoD3UnrdkgtXYRdyhojKFl1v0OMj82D2R5ufP97aPY2qjF
   pMbhqSilhMHU5RMM3qFmvAyO/xsXKHHMQaaMXcduS5tBGgHhfgxw59/oY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="337007956"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="337007956"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:47:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="704674769"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="704674769"
Received: from durgasin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.240.219])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:47:37 -0800
Subject: [ndctl PATCH 09/15] cxl/region: Make ways an integer argument
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 06 Nov 2022 15:47:37 -0800
Message-ID: <166777845733.1238089.4849744927692588680.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
References: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Since --ways does not take a unit value like --size, just make it an
integer argument directly and skip the hand coded conversion.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/region.c |   41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/cxl/region.c b/cxl/region.c
index 334fcc291de7..494da5139c05 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -21,21 +21,23 @@
 static struct region_params {
 	const char *bus;
 	const char *size;
-	const char *ways;
 	const char *granularity;
 	const char *type;
 	const char *root_decoder;
 	const char *region;
+	int ways;
 	bool memdevs;
 	bool force;
 	bool human;
 	bool debug;
-} param;
+} param = {
+	.ways = INT_MAX,
+};
 
 struct parsed_params {
 	u64 size;
 	u64 ep_min_size;
-	unsigned int ways;
+	int ways;
 	unsigned int granularity;
 	const char **targets;
 	int num_targets;
@@ -63,9 +65,8 @@ OPT_BOOLEAN(0, "debug", &param.debug, "turn on debug")
 OPT_STRING('s', "size", &param.size, \
 	   "size in bytes or with a K/M/G etc. suffix", \
 	   "total size desired for the resulting region."), \
-OPT_STRING('w', "ways", &param.ways, \
-	   "number of interleave ways", \
-	   "number of memdevs participating in the regions interleave set"), \
+OPT_INTEGER('w', "ways", &param.ways, \
+	    "number of memdevs participating in the regions interleave set"), \
 OPT_STRING('g', "granularity", \
 	   &param.granularity, "interleave granularity", \
 	   "granularity of the interleave set"), \
@@ -126,15 +127,11 @@ static int parse_create_options(int argc, const char **argv,
 		}
 	}
 
-	if (param.ways) {
-		unsigned long ways = strtoul(param.ways, NULL, 0);
-
-		if (ways == ULONG_MAX || (int)ways <= 0) {
-			log_err(&rl, "Invalid interleave ways: %s\n",
-				param.ways);
-			return -EINVAL;
-		}
-		p->ways = ways;
+	if (param.ways <= 0) {
+		log_err(&rl, "Invalid interleave ways: %d\n", param.ways);
+		return -EINVAL;
+	} else if (param.ways < INT_MAX) {
+		p->ways = param.ways;
 	} else if (argc) {
 		p->ways = argc;
 	} else {
@@ -155,13 +152,13 @@ static int parse_create_options(int argc, const char **argv,
 	}
 
 
-	if (argc > (int)p->ways) {
+	if (argc > p->ways) {
 		for (i = p->ways; i < argc; i++)
 			log_err(&rl, "extra argument: %s\n", p->targets[i]);
 		return -EINVAL;
 	}
 
-	if (argc < (int)p->ways) {
+	if (argc < p->ways) {
 		log_err(&rl,
 			"too few target arguments (%d) for interleave ways (%u)\n",
 			argc, p->ways);
@@ -253,7 +250,7 @@ static bool validate_memdev(struct cxl_memdev *memdev, const char *target,
 
 static int validate_config_memdevs(struct cxl_ctx *ctx, struct parsed_params *p)
 {
-	unsigned int i, matched = 0;
+	int i, matched = 0;
 
 	for (i = 0; i < p->ways; i++) {
 		struct cxl_memdev *memdev;
@@ -393,7 +390,8 @@ static int cxl_region_determine_granularity(struct cxl_region *region,
 					    struct parsed_params *p)
 {
 	const char *devname = cxl_region_get_devname(region);
-	unsigned int granularity, ways;
+	unsigned int granularity;
+	int ways;
 
 	/* Default granularity will be the root decoder's granularity */
 	granularity = cxl_decoder_get_interleave_granularity(p->root_decoder);
@@ -408,7 +406,7 @@ static int cxl_region_determine_granularity(struct cxl_region *region,
 		return granularity;
 
 	ways = cxl_decoder_get_interleave_ways(p->root_decoder);
-	if (ways == 0 || ways == UINT_MAX) {
+	if (ways == 0 || ways == -1) {
 		log_err(&rl, "%s: unable to determine root decoder ways\n",
 			devname);
 		return -ENXIO;
@@ -436,12 +434,11 @@ static int create_region(struct cxl_ctx *ctx, int *count,
 {
 	unsigned long flags = UTIL_JSON_TARGETS;
 	struct json_object *jregion;
-	unsigned int i, granularity;
 	struct cxl_region *region;
+	int i, rc, granularity;
 	u64 size, max_extent;
 	const char *devname;
 	uuid_t uuid;
-	int rc;
 
 	rc = create_region_validate_config(ctx, p);
 	if (rc)

