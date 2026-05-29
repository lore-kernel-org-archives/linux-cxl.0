Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E9B1DDA18;
	Fri, 29 May 2026 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061148; cv=pass; b=CtxAlGzOnhC3ZgoSRfoQ2I005NrXhTFqmE4/N44zxpZpads3p1j0u+iy++zrakfGeIqWPUg1pxixFosqAPAF1uDkwjn/S+npGBJkV1EmaWmhPU06y00GUTsdWuK3efuOURKQDi5g5ky3ka9Yco3hBEtRDk3h3kOmBUm4nISr2wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061148; c=relaxed/simple;
	bh=QP3LcqIZXzYS71/QBNOlKcQdHMSYIf7BqCcFvgV6xyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K40feECQyGbSoKis2loXseTaUiyzUURLGEtQIuX47J6xTOuR9wIiHKGxfOUJWQIQb7IktaIuEw/Zl0T97lfbhH0P4xGwMibLpgCOST5wOs790af8lHpyfHYZ6VGLdqvwVRry9EW+PIBJCIK0+OLIyvXpIsRkfIhRl7oRn9GjQMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Cz2KWnCy; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Cz2KWnCy"
ARC-Seal: i=1; a=rsa-sha256; t=1780061141; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jSMJdL11amY5PfcEqmM/IsyP4J+nQViCGUFvjAtwwKn3lFYZduMIgM/NTW2vJqCnjngjgQ6cyu2Ri2jJNVTWpVPF8ttLPUaRS6AQ12tdWmNjumL6Iwi8YzM70cx5eZnwz/xlpDIxUYntMQbJyKL0ZlVz5w7pRLYUDn/ifoysLes=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780061141; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GCr93bmAb0/KJNP801AIuS0fs02BCCeHrbLQz0szUJU=; 
	b=LPbc0dqD6q7duIEWWBZ4pOFS7oNhgWJ5oACtKGRHGBDS+Tcos4Hir567DyIn4s5sL+moKs2qr2D0HQEmjeLSRiJkrcpaJg7N9FaXQRKw0AWV8c+hznPJ741GHVHXj1duZ0Rhv2Y92pW/o3qeYYUjWKJ46IgFn2OYz0LF8HOd4bE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780061141;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=GCr93bmAb0/KJNP801AIuS0fs02BCCeHrbLQz0szUJU=;
	b=Cz2KWnCyVT1kBcmfTZh8nHyJSEurvf01SGFAQqM+9iStSwq7tb1uJVlgnCrXnZ2V
	xXiRXzAE4A5K+nUjba5uMEeyI2RiqjFQ8sYSnOYFtMRCydRE8E0S3C2WRHNhiErF+Az
	a1BlqvIJtV9ojRk8b89hPRXyEqTeXkLEFVjnDZms=
Received: by mx.zohomail.com with SMTPS id 1780061138431573.5833036927128;
	Fri, 29 May 2026 06:25:38 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] cxl/region: Fix out-of-bounds access in cxl_cancel_auto_attach()
Date: Fri, 29 May 2026 21:25:33 +0800
Message-ID: <20260529132533.1144383-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227652c39b62c64976bfb3e111e00001060c99a3e3ea6e60b7a48b0cecd4d9a3a220708fdbc0462fe:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

In cxl_cancel_auto_attach(), it assumes cxled->pos is a valid index for
accessing p->targets[]. However, cxled->pos can be set to negative errno
in cxl_region_sort_targets() if cxl_calc_interleave_pos() fails. This
causes the driver to use a negative index to access p->targets[],
resulting in out-of-bounds access.

Fix it by walking p->targets[] instead of using cxled->pos directly.

Fixes: 87805c32e6ad ("cxl/region: Fix use-after-free from auto assembly failure")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
Changes from v2:
- Revert "Fix potential 'hole' issue." changes. (Alison)

Changes from v1:
- Update commit log. (Dave)
- Update comment in cxl_region_sort_targets(). (Dave)
- Fix potential 'hole' issue. (Alison & Sashiko review)
---
 drivers/cxl/core/region.c | 40 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..eb96cb3cae83 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2011,8 +2011,9 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		/*
 		 * Record that sorting failed, but still continue to calc
-		 * cxled->pos so that follow-on code paths can reliably
-		 * do p->targets[cxled->pos] to self-reference their entry.
+		 * cxled->pos so that cxl_calc_interleave_pos() emits its
+		 * dev_dbg() for every member. which is useful for auto
+		 * discovery debug.
 		 */
 		if (cxled->pos < 0)
 			rc = -ENXIO;
@@ -2202,18 +2203,30 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	return 0;
 }
 
-static int cxl_region_by_target(struct device *dev, const void *data)
+static int cxl_region_remove_target(struct device *dev, void *data)
 {
-	const struct cxl_endpoint_decoder *cxled = data;
+	struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
+	int i;
 
 	if (!is_cxl_region(dev))
 		return 0;
 
 	cxlr = to_cxl_region(dev);
 	p = &cxlr->params;
-	return p->targets[cxled->pos] == cxled;
+	for (i = 0; i < p->nr_targets; i++) {
+		if (p->targets[i] == cxled) {
+			p->nr_targets--;
+			cxled->state = CXL_DECODER_STATE_AUTO;
+			cxled->pos = -1;
+			p->targets[i] = NULL;
+
+			return 1;
+		}
+	}
+
+	return 0;
 }
 
 /*
@@ -2222,25 +2235,10 @@ static int cxl_region_by_target(struct device *dev, const void *data)
  */
 static void cxl_cancel_auto_attach(struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_region_params *p;
-	struct cxl_region *cxlr;
-	int pos = cxled->pos;
-
 	if (cxled->state != CXL_DECODER_STATE_AUTO_STAGED)
 		return;
 
-	struct device *dev __free(put_device) =
-		bus_find_device(&cxl_bus_type, NULL, cxled, cxl_region_by_target);
-	if (!dev)
-		return;
-
-	cxlr = to_cxl_region(dev);
-	p = &cxlr->params;
-
-	p->nr_targets--;
-	cxled->state = CXL_DECODER_STATE_AUTO;
-	cxled->pos = -1;
-	p->targets[pos] = NULL;
+	bus_for_each_dev(&cxl_bus_type, NULL, cxled, cxl_region_remove_target);
 }
 
 static struct cxl_region *
-- 
2.43.0

