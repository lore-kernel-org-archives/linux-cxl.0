Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE731DF74F
	for <linux-cxl@vger.kernel.org>; Sun, 11 Oct 2026 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791678033; cv=none; b=uzzSHqCq/IVEFdzv9WowAd1xscsmzG7DRMpJY+XYQIjaa23+uBXGRKzstikPUG3agu2kLbvAYxHs7iKKXvXEsT7EjhSgUusIePObcAQmyyoLyIIPKG1310jBGieGOW7KSFwxkcDFsAH+rRUvHRFcBTnNq+98KKmfaUv7xWb+3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791678033; c=relaxed/simple;
	bh=52eFf1bOZYA0pVW/kDPA6up7PxDL+L2tTFF1lh99gao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0QvGDIN9SnzSqIgmlIod0/jR+iNgvXghM99yeOKOAhTv3hnwbqdXBwgOgkeFER4orupAl33JH9/agRRC6OaROSQlpoi0chHEBoYZpTDzzmg6br/iZoSx7g5sCUMtDzKgZGnlbmx1UNnVkStSS3vSi8qqDriRIyXC6nRWjXf994=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMzBNLiy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMzBNLiy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791678032; x=1823214032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=52eFf1bOZYA0pVW/kDPA6up7PxDL+L2tTFF1lh99gao=;
  b=UMzBNLiyo1EJkv0ECbNhWc6MFCzoHLz2qfKheNIHkoWjsh27XKNgdgw3
   TTV+MYc9/coDD/HLhLBkdddtqDAFRaDRNFhTXAP+PIYjGg2KZxt9HbT5G
   1RTFysLI/7YTXdOKb4YftUmje/E69JzleUZFpPxd0rzARQu+E+ZfLFrOv
   gTyNYuDkBTU11DCfJnMt1OZV8RwYD4dp/EqvCmVUZO1G8EhrUhPM+ZwfW
   sKm79Kpf4ayil5fTndv/MEWKnrM00y+Yt+Tflu3zxMCiSk/cjiLu3h7lR
   wvRXAqJX3RZJ6+K+blQ6OeZGEAe1tYWIztxI6UoR4nkbTCUudWxlWYHjn
   w==;
X-CSE-ConnectionGUID: C+8rdKS5Tgi+30Fvo4KRrg==
X-CSE-MsgGUID: YQUU1D5IQz2snq4JKtU07w==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="459324"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="459324"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 17:20:31 -0700
X-CSE-ConnectionGUID: rBcLeNxmTOSBvgNspm13ow==
X-CSE-MsgGUID: HMVXutCIR6WcLmEflj0loQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="679022"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.8])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 17:20:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 3/8] cxl/region: Rename cxl_port_setup_targets() to cxl_switch_port_setup_targets()
Date: Sat, 10 Oct 2026 17:20:18 -0700
Message-ID: <6bef106f136e813b760fa7ab65d419fa4a1b6922.1791676454.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791676454.git.alison.schofield@intel.com>
References: <cover.1791676454.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_port_setup_targets() configures the switch decoder targets for a
region. It runs for each switch port, including host bridges, between the
root and an endpoint.

Rename the function to cxl_switch_port_setup_targets() to make its scope
explicit.

No functional change.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1a42753fda48..d564443a1d39 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1432,9 +1432,9 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	return 0;
 }
 
-static int cxl_port_setup_targets(struct cxl_port *port,
-				  struct cxl_region *cxlr,
-				  struct cxl_endpoint_decoder *cxled)
+static int cxl_switch_port_setup_targets(struct cxl_port *port,
+					 struct cxl_region *cxlr,
+					 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
@@ -1716,7 +1716,7 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
 		 */
 		for (ep = cxl_ep_load(iter, cxlmd); iter;
 		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
-			rc = cxl_port_setup_targets(iter, cxlr, cxled);
+			rc = cxl_switch_port_setup_targets(iter, cxlr, cxled);
 			if (rc) {
 				cxl_region_teardown_targets(cxlr);
 				return rc;
-- 
2.37.3

