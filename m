Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD43485921
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 04:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791866689; cv=none; b=gIxF0nH98tdQ8+KFT28F0e6oz9B91ASwwaXJ6BNxXyuiaYfy+qdpaEL0KHndawbd2/bYlJkbnZnHW42Yrd7CGbWdm2cLB+yGdlcGAKf5w4fMcVES+Ub8+HhgqFJ7TIxTqnpHmaeTJwuabixXAl8BitS04aUl7Exnj4n5HfUca3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791866689; c=relaxed/simple;
	bh=mnfish2qZilEbGeuzck4IwFqVZ/vvXNQ68XhX8hAK7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZXDBo6qHcYPY+MT3l4yurx74uB3zHdy4fHfE/EU/PFtPhWK0Rz/bty2r2U0EyLZic9fcTNqNWybuM7IhUrfAR7GEaSE5R309yzHsScBfVj7xlrnmy5vUJAG67NRSd8GJp7m6/1h6afsLmZ0CJhKN1/0os6h39NeNwey6Iwa5Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKridH8+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKridH8+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791866687; x=1823402687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mnfish2qZilEbGeuzck4IwFqVZ/vvXNQ68XhX8hAK7o=;
  b=AKridH8+E+tGUU/OltfyZRfXyT5mB2AfpGhM8UIzFU+HSRDR3kQaGNDc
   Sra9ES70GsSUEN9wqYvD10l1EfVAKSkyaxjnbMrSdi6rriBPPqTWGKoCO
   D2O5902GAHFWth2TkN0zXkpaJ7AM7FofjeWdsEmCX6rmRmnx/12NPjIDG
   1zMFjlJajDoNLyNbTUOu7V4mL2Ma8WQCO5B7VeyhsOK+Q6qZQbB+eKu8y
   MOyI+4Khzzol0ERIUaPiiHRsBDSMH6DJnwzwLa++11WBzXOqsQ0e+un+y
   xUM+j0C2tphz7zuO6hW0tgvKJn0IDW2zw2EetFf5xEn48F6tPcRhaI8dw
   w==;
X-CSE-ConnectionGUID: JjqsT9mMSlma1iaA0RXWIA==
X-CSE-MsgGUID: 7mThIA3BStuW2mT5o76nlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="482815"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="482815"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:44:36 -0700
X-CSE-ConnectionGUID: M1oaQYrATFWfMiF3rin6gQ==
X-CSE-MsgGUID: w62XmjZ8T9y6V7j90gaS1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1170841"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.102])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:44:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v6 4/5] cxl/region: Support user region granularity finer than the root
Date: Mon, 12 Oct 2026 21:44:26 -0700
Message-ID: <8a2d963610075e0de0dc7d5ddf74e156859ffb83.1791863201.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791863201.git.alison.schofield@intel.com>
References: <cover.1791863201.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User region creation currently requires an interleaving root to have the
same granularity as the region.

That rejects a region granularity finer than the granularity of the
interleaving root decoder. A region granularity coarser than the root
remains invalid because it produces incorrect DPA translations.

Allow a region granularity finer than an interleaving root and continue to
reject a coarser granularity. Validate the complete ways/granularity
relationship when the region endpoints are attached.

For example, CXL 4.0 Section 9.13.1.1 Table 9-7 describes a 6-way region at
IGB across three host bridges as a 3-way root interleave at 2 * IGB with a
2-way interleave at IGB below it.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ee450704af2c..03472ed12e9d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -569,15 +569,15 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 		return -EINVAL;
 
 	/*
-	 * When the host-bridge is interleaved, disallow region granularity !=
-	 * root granularity. Regions with a granularity less than the root
-	 * interleave result in needing multiple endpoints to support a single
-	 * slot in the interleave (possible to support in the future). Regions
-	 * with a granularity greater than the root interleave result in invalid
-	 * DPA translations (invalid to support).
+	 * Region granularity coarser than the root produces invalid endpoint
+	 * address translations.
 	 */
-	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
+	if (cxld->interleave_ways > 1 && val > cxld->interleave_granularity) {
+		dev_dbg(&cxlr->dev,
+			"cannot set granularity to %d: exceeds root decoder granularity %d\n",
+			val, cxld->interleave_granularity);
 		return -EINVAL;
+	}
 
 	lockdep_assert_held_write(&cxl_rwsem.region);
 
-- 
2.37.3

