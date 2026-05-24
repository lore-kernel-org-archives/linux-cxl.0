Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8580332B109;
	Sun, 24 May 2026 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779616598; cv=pass; b=LgxHULoLPOrUBOlRMrHoWKtbS0OEbeDIBNzktTWLz+Jvgw60BMFUeyk3oEMkAT3sN0pP+LzrK3FpvYz8g7C95LgKaMBHvAtqndm6arcMm1SLuXr1OgzVDjzkbvHHrxZuTQGuYl9FuXmsQHrDo7WOhYTuPzvuHBu9sj5CAdCj1no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779616598; c=relaxed/simple;
	bh=3evzGI8ydlntYUzNqJn8pFf8/D934Cn6h0RJyPqDnaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XYQU3oTCZxsOFDKT/NAO/vUOBgbEg1hpiDJ5JyJktCjwy0Y1hiioq7uFzQ9b7Ho6QHj268JfqW1QmtaKFmeuNAtGlIy6Qz/DpCnQiCI0cc/PqUwIAwrlGOF6q52PXW4+jueceuvVTJI+E6Yahc1YO97ZWH4ksepMPu+nzCWvYkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=PHSV+xo4; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="PHSV+xo4"
ARC-Seal: i=1; a=rsa-sha256; t=1779616589; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CYD1K1ptZ2gVQd+XSOz1THLYqiovXr/2vWM9ecDHPYvCXlvwDTgeWYLWjixPaDRKO06eY/dwRTfCOEfaGXNPzSdsFyaObo2zXa/9S0SL3PHhG7lI8TnCBhW2jS6B2d2hxXBVN3WI7X//TqWBVVVU0OKSUWVckppsi9u/hsHUkHw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779616589; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LbfxgxO+Vn0lgyF+08e1lUphD91UlmVCase93BEmJec=; 
	b=j33J5QCI4NdYzONCycdapUeA+dNsAgEGkkqaPuvVtWIBdzIAYMWsLQO6OB8PcdU8bWMlSbnm9+q/FPkr93IHEH9jjkz/IIPFBN/ypp8PedGFHKLmcTt/fvQqhPzoM2QQ2WkTTsqelEpyUQuOAU4eo/T341GVTfQQ7wokAkDTNCA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779616589;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=LbfxgxO+Vn0lgyF+08e1lUphD91UlmVCase93BEmJec=;
	b=PHSV+xo4qvmJLnMEVbcGZhnrlJUwGHsZzPH55eBmeWe3Ep8Ehlzpjn3Ns2zM3Rz5
	iTNyjeIF7KlUyHbbrt+2m0GOMYh3TJAitxXzHZ3ob3z7qVvYfvouKmFFEpakRQ4lhfg
	1KAayE3UT8iBWcSjAlAuahk0aEWI9PHk6CbjzJZo=
Received: by mx.zohomail.com with SMTPS id 1779616586755771.2567109612221;
	Sun, 24 May 2026 02:56:26 -0700 (PDT)
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
Subject: [PATCH v2 1/1] cxl/region: Fix out-of-bounds access in cxl_cancel_auto_attach()
Date: Sun, 24 May 2026 17:56:20 +0800
Message-ID: <20260524095620.636535-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112276625901bc1b5317b5bb2ed210000c8babd66bbe57849d15ea7203a6385b3da6d7e3f6048f4a446:ZohoMail
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
Changes from v1:
- Update commit log. (Dave)
- Update comment in cxl_region_sort_targets(). (Dave)
- Fix potential 'hole' issue. (Alison & Sashiko review)
---
 drivers/cxl/core/region.c | 40 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..8956b049c462 100644
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
+	for (i = 0; i < p->interleave_ways; i++) {
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

