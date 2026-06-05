Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741502BB13
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 04:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632490; cv=none; b=HOCGeGkuow7npJDC7+/X71Yyj+KCRCZJgSIRd/b3BF6pz6b/BBNAYLRQguIBsrEqNu1VNFF7+SaVTkn/BrNk/ED+qv0/HZXwQH3qwrnviIXw2rKozt8gHNVJJiFGHAv7VZqLNEPh9/iiQGN8DKy4uOh+4rWcPyaMeXBPyRZaZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632490; c=relaxed/simple;
	bh=zBKrmjq9LNsS598PPuXWhxUKq3qLBuOvMJss07nTesc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JrFAKawTC9+d0gfRkbQ1/ZNZqVbJdAQX+JVxmqZLdBoc6/C2wVj1oWWMg5yXufC2/HiPPXIUAAvY95dzqGNC41K01VAG5e1qILa/SR8DYktGrBAYrg7N7cLmSFgSCnk/qgX8ihbuUB9K6WpHhDE9RigCgcjwmvBgTAL0+hLv1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ep6WChom; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ep6WChom"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780632488; x=1812168488;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zBKrmjq9LNsS598PPuXWhxUKq3qLBuOvMJss07nTesc=;
  b=ep6WChomyw+O7U+ddfn1RVxQM/uDZ/aKVEIgSUtfeVUTKvgm/BJFSCc8
   25j/SvoJmRcg8k66LAs+dQwbJss5e0ONpgJq4VEtAm/MuBtIByh7b10kp
   60w1KhR7/zFU66c2LLJAOMpOKlB6ERq07PCz8pyagLOOvezEfgFumbIiX
   RmzNy9zqUJty9qpys7tIqwHhkmk5GcNSlsIofNzLIajAaEcLkMmKSJVbf
   xEbCw0W65Akb1y8/4MDmEaiTMa0wVJeUxFcZJ7chRcWMGBjNiQXLxFS30
   XO5PgGoT6+U2t4SXqACdSUOHY8UhMMtQEnqLfqniGpObSZd7/xb25b2Mw
   g==;
X-CSE-ConnectionGUID: k5ZzC5vaTdGPDMDM/Pg/Mw==
X-CSE-MsgGUID: QKdKxuGOTIC/xGBqz8oi+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92951916"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="92951916"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 21:08:07 -0700
X-CSE-ConnectionGUID: fjZOA6JvS8GN8v80bg5D7w==
X-CSE-MsgGUID: iTvRkebASxmpiK7cbAuT6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="243650735"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.175])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 21:08:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] cxl: Align interleave decode/encode helpers with their callers
Date: Thu,  4 Jun 2026 21:07:59 -0700
Message-ID: <20260605040801.865965-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interleave conversion helpers translate between encoded HDM
interleave values and the granularity and way values used by the
driver.

These helpers have been a recurring source of static analysis
complaints that expose type mismatches and potentially uninitialized
outputs. Fix those issues in the helpers so callers inherit the
consistent behavior automatically.

The decode and encode helpers have different interface issues.

The decode helpers return values through unsigned int pointers, but
the decoded values are ultimately represented as int throughout the
driver. Align the helper interfaces with their callers by changing
the out-parameters to int * and updating the handful of affected
locals to match.

The encode helpers leave their out-parameters unchanged on error. That
means callers that ignore the return value may observe uninitialized
encoded values. Initialize the outputs so failed conversions leave
defined values. This issue was originally reported by Purva and the
helper-side fix was suggested by Dan [1].

Tidy up a related, pre-existing, printk format specifier mismatch in
cxl_validate_translation_params().

No functional change for valid interleave parameters.

[1] https://lore.kernel.org/linux-cxl/20250419203530.45594-1-purvayeshi550@gmail.com/

Reported-by: Purva Yeshi <purvayeshi550@gmail.com>
Suggested-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/acpi.c        | 10 +++++-----
 drivers/cxl/core/region.c |  4 ++--
 drivers/cxl/cxl.h         |  6 ++++--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 127537628817..3b818adbd38b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -101,8 +101,8 @@ static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct device *dev = ctx->dev;
 	struct cxl_cxims_data *cximsd;
-	unsigned int hbig, nr_maps;
-	int rc;
+	unsigned int nr_maps;
+	int hbig, rc;
 
 	rc = eig_to_granularity(cxims->hbig, &hbig);
 	if (rc)
@@ -160,7 +160,7 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
 				 struct acpi_cedt_cfmws *cfmws)
 {
 	int rc, expected_len;
-	unsigned int ways;
+	int ways;
 
 	if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO &&
 	    cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
@@ -405,7 +405,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	struct cxl_cxims_context cxims_ctx;
 	struct device *dev = ctx->dev;
 	struct cxl_decoder *cxld;
-	unsigned int ways, i, ig;
+	int ways, i, ig;
 	int rc;
 
 	rc = cxl_acpi_cfmws_verify(dev, cfmws);
@@ -464,7 +464,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 			if (rc < 0)
 				return rc;
 			if (!cxlrd->platform_data) {
-				dev_err(dev, "No CXIMS for HBIG %u\n", ig);
+				dev_err(dev, "No CXIMS for HBIG %d\n", ig);
 				return -EINVAL;
 			}
 		}
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..61877483cbcd 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3060,7 +3060,7 @@ int cxl_validate_translation_params(u8 eiw, u16 eig, int pos)
 		return -EINVAL;
 	}
 	if (pos < 0 || pos >= ways) {
-		pr_debug("%s: invalid pos=%d for ways=%u\n", __func__, pos,
+		pr_debug("%s: invalid pos=%d for ways=%d\n", __func__, pos,
 			 ways);
 		return -EINVAL;
 	}
@@ -3106,7 +3106,7 @@ EXPORT_SYMBOL_FOR_MODULES(cxl_calculate_dpa_offset, "cxl_translate");
 
 int cxl_calculate_position(u64 hpa_offset, u8 eiw, u16 eig)
 {
-	unsigned int ways = 0;
+	int ways = 0;
 	u64 shifted, rem;
 	int pos, ret;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1297594beaec..66cb2293fec1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -91,7 +91,7 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 }
 
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
-static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
+static inline int eig_to_granularity(u16 eig, int *granularity)
 {
 	if (eig > CXL_DECODER_MAX_ENCODED_IG)
 		return -EINVAL;
@@ -100,7 +100,7 @@ static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
 }
 
 /* Encode defined in CXL ECN "3, 6, 12 and 16-way memory Interleaving" */
-static inline int eiw_to_ways(u8 eiw, unsigned int *ways)
+static inline int eiw_to_ways(u8 eiw, int *ways)
 {
 	switch (eiw) {
 	case 0 ... 4:
@@ -118,6 +118,7 @@ static inline int eiw_to_ways(u8 eiw, unsigned int *ways)
 
 static inline int granularity_to_eig(int granularity, u16 *eig)
 {
+	*eig = 0;
 	if (granularity > SZ_16K || granularity < CXL_DECODER_MIN_GRANULARITY ||
 	    !is_power_of_2(granularity))
 		return -EINVAL;
@@ -127,6 +128,7 @@ static inline int granularity_to_eig(int granularity, u16 *eig)
 
 static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 {
+	*eiw = 0;
 	if (ways > 16)
 		return -EINVAL;
 	if (is_power_of_2(ways)) {

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.37.3

