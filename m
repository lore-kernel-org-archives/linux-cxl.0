Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650571;
	b=vu78MzEvpn9wupnoAn/Wc9JbfpSwTPEhN+OTPYGnkn8vDjBMg0ikBdC4b8W1eAI+X9sv
	 Z6G7vGs09Gsp7wHePoMazeTlWoO4+DStJ7unDhxV2cUahYAARVS0Cxye2sxi+vGwZFLXB
	 VWB8jJY/9aag+wIbPHP4mXYzXDQAxzxsPhDgb7JXTqTKLRmo2VifFhl/UAQvyeHMh6Dl1
	 aPAQJgY0KabUV5F5LEQpT9DSybe1UFxfKsu5hPLUmmmJotwWDrCdScESajotffVo9j/05
	 jq9nRFHJXP12Qae7+UE+Rcgemqi9RUFjSEMIOqn5iR1odyKU4d0ZkNciLrvLAZxjTIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650571;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H234y7NEPgLsTQH7PJH2yoNFBUw4m41j8CoCzZ36bUg=;
	b=iQOYFYRlP8OzDcjfea8fn9qC4ylJaKSOU8Up91m2ELOcvB4vv+eUDE0kjuRFJWeb+Qgr
	 F2fv+EytPH1/ECPA0prfO9A44792wUmb+U1y+w9Ij5eDppQ79Ip5vfKiBCQFMGiGxZSSo
	 LPvN8tWsW5Q+fXgnJP1Z2KpsdIEw1bFUcFvlUYtVRY6filOdkkqgyXnB9S51qyrQnV0qR
	 iXEkWGCY6SFYVmaNSUDZAzloEa93PtlUkysX1oieYmm6aawfXfAufuC6OyaqulqQ5encv
	 jjXSnH0fiAPtC/YJx+RN0sW1lRqlvPy1j56RWYnlL7Z6sA5h2yDAe3HwAQhQ4lCkDeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SZOcI7GP;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A7606A324
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 20:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05A7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SZOcI7GP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793650570; x=1825186570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MWIozloRmeqPMfdKkLEcKTIDuJaQMga09uY7xGMKhUw=;
  b=SZOcI7GP8Pry59OhYpQBlKKtf/2XBXaTEEPh7UChzR3ljdpc2E3dLpLf
   uekZsrJBKo4MHT5LXF3KTrINqe80uZ2CXviszeximwJupdEathVYB++5b
   93fTHIRYxy2ewJ0jEfHip6n4DU7ZfKbujc6m5B5GiuQRi2i3Do+u8r9Rh
   on6RNFHtciwFdeROgQAQYfmKcLhHsnlshqqKfC7wWuXFAyytbuzLhiHk/
   HOSrfYVNa06kfntWk2THemd9snR6MLJuMZk4sdssBo7uqedeNAC7ZnjiY
   rwn4q5r8rBuN8jVxjw33M/LQ/NYUPjKJOxEOnfJtt5hNnyiZdnEc/V+ia
   Q==;
X-CSE-ConnectionGUID: CHVI9BTrTHC8QSJU9c1CvQ==
X-CSE-MsgGUID: Yn3sycmETwWtAlkKzI3wYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2463990"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2463990"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:10 -0800
X-CSE-ConnectionGUID: gR+zJl8BTOOuFFRdJfSmVw==
X-CSE-MsgGUID: nkji/Sm9T4imKrPetYfgGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6215589"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:08 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 1/9] cxl: Add interleave encoding validity helpers
Date: Mon,  2 Nov 2026 12:15:56 -0800
Message-ID: <272dd3f8462c651093e61e814a2f394c602340f7.1793649898.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1793649898.git.alison.schofield@intel.com>
References: <cover.1793649898.git.alison.schofield@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some callers of ways_to_eiw(), granularity_to_eig(), and
eig_to_granularity() only need to determine whether an input is valid,
but must provide storage for a converted value that is then discarded.
This obscures the purpose of the call and requires unnecessary temporary
variables.

Define and use new helpers that provide a validation-only interface for
those callers.

cxl_port_setup_targets() also encodes and then decodes its calculated
granularity solely to validate it. Calculate the granularity directly
and validate it instead, making the calculation explicit and removing
the encode/decode round trip.

No functional change.

Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 49 +++++++++++++--------------------------
 drivers/cxl/cxl.h         | 21 +++++++++++++++++
 2 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a048bd5c06cb..bc087ca63946 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -493,11 +493,9 @@ static int set_interleave_ways(struct cxl_region *cxlr, int val)
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	int save, rc;
-	u8 iw;
 
-	rc = ways_to_eiw(val, &iw);
-	if (rc)
-		return rc;
+	if (!ways_valid(val))
+		return -EINVAL;
 
 	/*
 	 * Even for x3, x6, and x12 interleaves the region interleave must be a
@@ -566,12 +564,9 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
-	int rc;
-	u16 ig;
 
-	rc = granularity_to_eig(val, &ig);
-	if (rc)
-		return rc;
+	if (!granularity_valid(val))
+		return -EINVAL;
 
 	/*
 	 * When the host-bridge is interleaved, disallow region granularity !=
@@ -1451,8 +1446,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *iter = port;
-	u16 eig, peig;
-	u8 eiw, peiw;
 
 	/*
 	 * While root level decoders support x3, x6, x12, switch level
@@ -1524,48 +1517,38 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		parent_iw = parent_cxld->interleave_ways;
 	}
 
-	rc = granularity_to_eig(parent_ig, &peig);
-	if (rc) {
+	if (!granularity_valid(parent_ig)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
 			dev_name(parent_port->uport_dev),
 			dev_name(&parent_port->dev), parent_ig);
-		return rc;
+		return -EINVAL;
 	}
 
-	rc = ways_to_eiw(parent_iw, &peiw);
-	if (rc) {
+	if (!ways_valid(parent_iw)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
 			dev_name(parent_port->uport_dev),
 			dev_name(&parent_port->dev), parent_iw);
-		return rc;
+		return -EINVAL;
 	}
 
 	iw = cxl_rr->nr_targets;
-	rc = ways_to_eiw(iw, &eiw);
-	if (rc) {
+	if (!ways_valid(iw)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
 			dev_name(port->uport_dev), dev_name(&port->dev), iw);
-		return rc;
+		return -EINVAL;
 	}
 
 	/*
 	 * Interleave granularity is a multiple of @parent_port granularity.
 	 * Multiplier is the parent port interleave ways.
 	 */
-	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
-	if (rc) {
+	ig = parent_ig * parent_iw;
+
+	if (!granularity_valid(ig)) {
 		dev_dbg(&cxlr->dev,
 			"%s: invalid granularity calculation (%d * %d)\n",
 			dev_name(&parent_port->dev), parent_ig, parent_iw);
-		return rc;
-	}
-
-	rc = eig_to_granularity(eig, &ig);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			256 << eig);
-		return rc;
+		return -EINVAL;
 	}
 
 	if (iw > 8 || iw > cxlsd->nr_targets) {
@@ -3131,13 +3114,13 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
  */
 int cxl_validate_translation_params(u8 eiw, u16 eig, int pos)
 {
-	int ways, gran;
+	int ways;
 
 	if (eiw_to_ways(eiw, &ways)) {
 		pr_debug("%s: invalid eiw=%u\n", __func__, eiw);
 		return -EINVAL;
 	}
-	if (eig_to_granularity(eig, &gran)) {
+	if (!eig_valid(eig)) {
 		pr_debug("%s: invalid eig=%u\n", __func__, eig);
 		return -EINVAL;
 	}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index baa6df2d362a..11688d17d09f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -146,6 +146,27 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 	return 0;
 }
 
+static inline bool eig_valid(u16 eig)
+{
+	int granularity;
+
+	return eig_to_granularity(eig, &granularity) == 0;
+}
+
+static inline bool granularity_valid(int granularity)
+{
+	u16 eig;
+
+	return granularity_to_eig(granularity, &eig) == 0;
+}
+
+static inline bool ways_valid(unsigned int ways)
+{
+	u8 eiw;
+
+	return ways_to_eiw(ways, &eiw) == 0;
+}
+
 /* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
 #define CXL_RAS_UNCORRECTABLE_STATUS_OFFSET 0x0
 #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
-- 
2.37.3

