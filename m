Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B79A25A633
	for <linux-cxl@vger.kernel.org>; Thu,  6 Nov 2025 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448489; cv=none; b=o+5fc0XKyzx867VgVPLZ4OLPx08kG/2clf6wbFcQTMptEE9cb95tFUivmn21KUK+lbx1uVNNAEMSl0DPnLok9KmyujYQFMHiNO6rMppuW7el96+CCzGj+kCrH5RpFQBjCXVNe0ldBzMyrsf81e0l7dBsjU5uaOTlVUShQk+yef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448489; c=relaxed/simple;
	bh=xIwhZR9zRUhD0ojQ7h2FH9mCA2VuJz35vz6luGIyvFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpExNGRQ4uVWfcb9wm6csWU/7L6MJRXVv8jROftn/bZLWnKKA89yUgyl7jsNq+tUdFI+jcL2CJKR9mRgLQUF7vx6ANU2ZPPCMkp4eWTefu5P5vggzzRX07QPsW/vgzfuvfJ/EFc7hhxZZl1DoSY72Pu+o+WIxUPXDab9PNKJgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C565AC116B1;
	Thu,  6 Nov 2025 17:01:28 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com
Subject: [PATCH 1/2] cxl: Rename region_res_match_cxl_range() to spa_maps_hpa()
Date: Thu,  6 Nov 2025 10:01:07 -0700
Message-ID: <20251106170108.1468304-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106170108.1468304-1-dave.jiang@intel.com>
References: <20251106170108.1468304-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function name region_res_match_cxl_range() does not accurately
convey the operation of address comparison with cache size. Rename
to spa_maps_hpa() to provide a better function name.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/linux-cxl/68eea19c7e67e_2f899100a8@dwillia2-mobl4.notmuch/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..302db75dc908 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -838,8 +838,8 @@ static int match_free_decoder(struct device *dev, const void *data)
 	return 1;
 }
 
-static bool region_res_match_cxl_range(const struct cxl_region_params *p,
-				       const struct range *range)
+static bool spa_maps_hpa(const struct cxl_region_params *p,
+			 const struct range *range)
 {
 	if (!p->res)
 		return false;
@@ -865,7 +865,7 @@ static int match_auto_decoder(struct device *dev, const void *data)
 	cxld = to_cxl_decoder(dev);
 	r = &cxld->hpa_range;
 
-	if (region_res_match_cxl_range(p, r))
+	if (spa_maps_hpa(p, r))
 		return 1;
 
 	return 0;
@@ -1465,7 +1465,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
 		    (iw > 1 && cxld->interleave_granularity != ig) ||
-		    !region_res_match_cxl_range(p, &cxld->hpa_range) ||
+		    !spa_maps_hpa(p, &cxld->hpa_range) ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
 				"%s:%s %s expected iw: %d ig: %d %pr\n",
@@ -3398,7 +3398,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 	p = &cxlr->params;
 
 	guard(rwsem_read)(&cxl_rwsem.region);
-	return region_res_match_cxl_range(p, r);
+	return spa_maps_hpa(p, r);
 }
 
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
-- 
2.51.1

