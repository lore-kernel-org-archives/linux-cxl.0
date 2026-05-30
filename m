Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A7213B58A
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 00:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780099258; cv=none; b=e/BL6aGRu0wJN6ctZzNMhTG5N1uRuRuRz8FFdFXx3OmCrIYCOPrBwz12afEeW1oJDEhYiq6PAHmPQHnVsktzdRftiFkzfLD1e7U9tMFSllSMY6g0Ki8jeANwCWLRkbHuiwJ8MQFuht80bU81iAa+j+Q9FsryUa8LQx5iGLvH7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780099258; c=relaxed/simple;
	bh=jW+qaHGmgKacXJNho4XjOCAkRfqIzF7NCktsvU+Z+Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhiTaxK0ELG1VZ8w+nbVsIyWG55lXQC9Ia72iYwl7vcx9HzmPh8LY1cRpXAxiRz3U5ocqOay3pQb/WAJvfDTyg73netk3wQad8JBuGQQn7NwozD6N0IHPybDN+RZLZpBjB8rXjelP0yQWUBxvQLuai6zVBtkAfvrvBh45jwMl0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Skl+ZO0R; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Skl+ZO0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780099257; x=1811635257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jW+qaHGmgKacXJNho4XjOCAkRfqIzF7NCktsvU+Z+Dw=;
  b=Skl+ZO0RsDBtT7BjnbE6scqE4Jx6lMAtz0BVnso45j8iUgIf9Zk94lEW
   +cAfyuUdwgHq71zWpHI1tyIZbTxFXQYYugD6zP0dPCdO/dLNNjDvXydh0
   FrRySdC0dA7M9veXE02lmvY5U/rR1tyJkqdWwlz0KqIuDtfIu8ePNA47w
   UH83hgNpMM0XZzPhagF9re09hKWapj358rmRln4W51Fgew9za/3G0feKs
   gFENTUS/0g+gXQMuJTufCgkBj298cj+T8jKpfs829OOEqxR+/ANsqK2FC
   dhmvNS60W7qZZMvAcgzko3c8j4I7k4m09V+H2awgaF6fmHKjpLPsm1R39
   A==;
X-CSE-ConnectionGUID: oOR63TyCSDyxt9Bc/3w9dg==
X-CSE-MsgGUID: rfNl1uIvTxq5u0SJ1VvjYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91530553"
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="91530553"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 17:00:57 -0700
X-CSE-ConnectionGUID: HxFrRmHgSJC/PAWAnMKpjg==
X-CSE-MsgGUID: fbDUUmjQQB+DaMu/l8Pzng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="238804370"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.60])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 17:00:56 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 4/6] cxl/region: Validate mixed-granularity at sysfs and attach gates
Date: Fri, 29 May 2026 17:00:43 -0700
Message-ID: <aad9e586a2184f1e9a1ebec04c3809edc6268cbe.1780095671.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1780095671.git.alison.schofield@intel.com>
References: <cover.1780095671.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User-created regions are validated at sysfs write through
set_interleave_granularity(). Auto regions skip that path. Both
need the same mixed-granularity rule applied before the per-port
selector walk runs.

Replace the same-granularity sysfs check with is_ig_allowed(),
which permits any region granularity not greater than the root
granularity. Call the same helper at attach time so auto regions
get the same rule.

3-way-family roots (3, 6, and 12 ways) need an additional check.
A 3-way interleave consumes no selector bits, so selector containment
alone cannot prove that the root and region cover the same address
span. Add an explicit ways*gran span equality check in
cxl_region_attach() for these roots.

Endpoint decoder capability is still checked at attach time by
check_interleave_cap().

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 57 ++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cc8ab2ad5228..61e6bb73249e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -559,10 +559,29 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
 }
 
+/**
+ * is_ig_allowed() - Validate region interleave granularity
+ * @cxlrd: root decoder
+ * @ig: proposed region interleave granularity in bytes
+ *
+ * Callers must have validated @ig through granularity_to_eig() first.
+ *
+ * Return: true for a non-interleaving root or any region granularity
+ * not larger than the root granularity.
+ */
+static inline bool is_ig_allowed(struct cxl_root_decoder *cxlrd, int ig)
+{
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+
+	if (cxld->interleave_ways <= 1)
+		return true;
+
+	return ig <= cxld->interleave_granularity;
+}
+
 static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	int rc;
 	u16 ig;
@@ -571,15 +590,7 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 	if (rc)
 		return rc;
 
-	/*
-	 * When the host-bridge is interleaved, disallow region granularity !=
-	 * root granularity. Regions with a granularity less than the root
-	 * interleave result in needing multiple endpoints to support a single
-	 * slot in the interleave (possible to support in the future). Regions
-	 * with a granularity greater than the root interleave result in invalid
-	 * DPA translations (invalid to support).
-	 */
-	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
+	if (!is_ig_allowed(cxlrd, val))
 		return -EINVAL;
 
 	lockdep_assert_held_write(&cxl_rwsem.region);
@@ -2128,6 +2139,32 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
+	/* Apply the sysfs granularity rule to auto regions too. */
+	if (!is_ig_allowed(cxlrd, p->interleave_granularity)) {
+		dev_dbg(&cxlr->dev,
+			"ig %d incompatible with root ways %d ig %d\n",
+			p->interleave_granularity,
+			cxlrd->cxlsd.cxld.interleave_ways,
+			cxlrd->cxlsd.cxld.interleave_granularity);
+		return -ENXIO;
+	}
+
+	/*
+	 * Selector containment cannot prove span equality for 3-way family
+	 * roots because a 3-way interleave consumes no selector bits.
+	 */
+	if (!is_power_of_2(cxlrd->cxlsd.cxld.interleave_ways) &&
+	    (u64)p->interleave_ways * p->interleave_granularity !=
+	    (u64)cxlrd->cxlsd.cxld.interleave_ways *
+		    cxlrd->cxlsd.cxld.interleave_granularity) {
+		dev_dbg(&cxlr->dev,
+			"region ways*gran (%d*%d) != root ways*gran (%d*%d)\n",
+			p->interleave_ways, p->interleave_granularity,
+			cxlrd->cxlsd.cxld.interleave_ways,
+			cxlrd->cxlsd.cxld.interleave_granularity);
+		return -ENXIO;
+	}
+
 	if (p->nr_targets >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
 			p->nr_targets);
-- 
2.37.3

