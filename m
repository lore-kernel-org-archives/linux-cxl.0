Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CA32C11CF
	for <linux-cxl@vger.kernel.org>; Tue, 29 Sep 2026 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660231; cv=none; b=inYD7EZnjP0YQ/4srhwNoogWJ4SYcf2UkaS1YxoA0HlArZRllCO8sN1xVzeCJXPmZYHhR+d0/Y8MiC/ohrLEiKwp6bnj5L3yCccObhar2mJlIaYiGRK4BlHP+i92mwKs6xhWL8FfRh7GiO89b07gFIOkDXdzu1pQA8pAEFWxTag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660231; c=relaxed/simple;
	bh=Tx+BpZtleJ3iyeci4TFtZJsyQU8zBp5DmChVSHZgyHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwK1leQli3ZubeubvYLUXghkDPWUwZpbV2KLS4UnUPNe+7UXHEcddaDsZQVEKEJ0+P6Nx4tTnBzYkjF75EmnZS+9dEZItmggRq0NK9yIOS0u7mS34HbZlMmxbDdGd2p7LYuPDxqca7pqv9OB1w7Ip9/DkUkXHqsjByah/HzBkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cG1xHypq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cG1xHypq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790660229; x=1822196229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tx+BpZtleJ3iyeci4TFtZJsyQU8zBp5DmChVSHZgyHA=;
  b=cG1xHypqKDFDuGRz3PHwrkh5OI6shRdzVQY6istLVgdXPWDa/BVmfdcg
   qmqPWYkeIS0rQFA/19v8agUIj04Q/E11b0hzeFf4e1oOGgbPINDWNz8+B
   sbAPfjKg3HxIyI3y98PUzx+xsJwZOvVq2Kf1W/WZR42Uaw3GvtWV205h3
   nDgTEgx8LcBtS8GfD9DCOCxLJ78JTLyIf5Pn5xHCGgTnDOnVMIjGj/H1P
   yZh3uANmf0AnCYLtxIEVjzrzIShSeDS3xQFTcHfIEAUh4FPyVWKBVuAAC
   iNuAuNFpINk1LNvfQWfuAYdT0jbs9ZB7vQEJR5UDwZ2t+cZp24j9UyPFW
   Q==;
X-CSE-ConnectionGUID: Yj0mQXZpTn68zarcT9MmKw==
X-CSE-MsgGUID: 3u6uuAtgRVutuSga0rG40Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="100700079"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="100700079"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 22:37:09 -0700
X-CSE-ConnectionGUID: w/0lDpBpQkmiXLapNHJ1pw==
X-CSE-MsgGUID: pUArpG5fSBiHNgUKoSQ8Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="304767490"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.149])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 22:37:09 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>
Subject: [ndctl PATCH 6/7] cxl/region: validate granularity before region creation
Date: Mon, 28 Sep 2026 22:36:58 -0700
Message-ID: <d5773b082d9dc27441076658f84427f3f1f7a8bd.1790658549.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1790658549.git.alison.schofield@intel.com>
References: <cover.1790658549.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The root decoder and requested granularity are known before region
creation, so cxl create-region can determine whether the request is valid
before sending it to the kernel.

Currently that check happens only after the region device is created,
requiring the failed request to be cleaned up afterward.

Validate encodable values during option parsing and resolve the effective
granularity before creating the region.

Fixes: 21b089025178 ("cxl: add a 'create-region' command")
Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 cxl/region.c              | 22 ++++++++++++----------
 test/cxl-create-region.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/cxl/region.c b/cxl/region.c
index e4fc8bb2942c..2e62e3faace2 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -407,8 +407,11 @@ static int parse_create_options(struct cxl_ctx *ctx, int count,
 		p->ways = p->num_memdevs;
 
 	if (param.granularity < INT_MAX) {
-		if (param.granularity <= 0) {
-			log_err(&rl, "Invalid interleave granularity: %d\n",
+		/* HDM granularity is a power of two from 256B through 16KiB. */
+		if (param.granularity < 256 || param.granularity > 16384 ||
+		    !is_power_of_2(param.granularity)) {
+			log_err(&rl,
+				"Invalid interleave granularity: %d, expected a power of 2 from 256 to 16384\n",
 				param.granularity);
 			goto err;
 		}
@@ -670,10 +673,9 @@ do { \
 	} \
 } while (0)
 
-static int cxl_region_determine_granularity(struct cxl_region *region,
-					    struct parsed_params *p)
+static int cxl_region_determine_granularity(struct parsed_params *p)
 {
-	const char *devname = cxl_region_get_devname(region);
+	const char *devname = cxl_decoder_get_devname(p->root_decoder);
 	int granularity, ways;
 
 	/* Default granularity will be the root decoder's granularity */
@@ -769,6 +771,11 @@ static int create_region(struct cxl_ctx *ctx, int *count,
 	if (size > max_extent)
 		size = ALIGN_DOWN(max_extent, SZ_256M * p->ways);
 
+	rc = cxl_region_determine_granularity(p);
+	if (rc < 0)
+		return rc;
+	granularity = rc;
+
 	if (p->mode == CXL_DECODER_MODE_PMEM) {
 		region = cxl_decoder_create_pmem_region(p->root_decoder);
 		if (!region) {
@@ -797,11 +804,6 @@ static int create_region(struct cxl_ctx *ctx, int *count,
 		goto out;
 	}
 
-	rc = cxl_region_determine_granularity(region, p);
-	if (rc < 0)
-		goto out;
-	granularity = rc;
-
 	try(cxl_region, set_interleave_granularity, region, granularity);
 	try(cxl_region, set_interleave_ways, region, p->ways);
 	if (p->mode == CXL_DECODER_MODE_PMEM) {
diff --git a/test/cxl-create-region.sh b/test/cxl-create-region.sh
index 02358af7837a..0d98b61a7e13 100644
--- a/test/cxl-create-region.sh
+++ b/test/cxl-create-region.sh
@@ -240,6 +240,16 @@ setup_interleave_shape()
 		return 1
 	fi
 
+	x2_granularity=$($CXL list -b cxl_test -D -d "$x2_decoder" |
+			 jq -r ".[0].interleave_granularity")
+
+	# Pick a valid granularity different from the x2 root's.
+	if [[ $x2_granularity -eq 256 ]]; then
+		other_granularity=512
+	else
+		other_granularity=256
+	fi
+
 	pos0=$(find_memdev "$x2_decoder" 0 0)
 	pos1=$(find_memdev "$x2_decoder" 1 0)
 	pos2=$(find_memdev "$x2_decoder" 0 1)
@@ -391,6 +401,21 @@ release_dpa_on_failure()
 	destroy_regions "$filler"
 }
 
+# Reject invalid encodings and granularities incompatible with the root.
+refuse_bad_granularity()
+{
+	if ! setup_interleave_shape; then
+		echo "skipping granularity refusals"
+		return
+	fi
+
+	create_expect_fail "Invalid interleave granularity: 1000" \
+		-d "$x2_decoder" -m "$pos0 $pos1" -g 1000
+
+	create_expect_fail "only root decoder granularity ($x2_granularity)" \
+		-d "$x2_decoder" -m "$pos0 $pos1" -g "$other_granularity"
+}
+
 # test region creation on devices behind a single-port host-bridge
 create_single
 
@@ -407,6 +432,7 @@ done
 create_csv_targets
 refuse_bad_target_list
 release_dpa_on_failure
+refuse_bad_granularity
 
 # Repeat x1/x2/x3/x4 region creation with XOR interleave arithmetic.
 load_cxl_test interleave_arithmetic=1
-- 
2.37.3

