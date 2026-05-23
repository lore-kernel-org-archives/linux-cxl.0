Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1B038E10F
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529464; cv=none; b=GhW9gkxqNU34e3pn+oqrtWX1FN0z7a8BnYh9YxxjYRiZVHyYf+/fkib581rF74+xaist1Ex2ksTtQt6wLrPEy8foFidhUTFYR+/J0aGJreHe6AADVhhXdTH+YrzFtWQgbhjS8Iy/jRWzphRTN+F1AADRYn7gnNzcVuPlL7Azbwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529464; c=relaxed/simple;
	bh=8IuA4Maawk4JmdW1e3XdQBnbX3d39FsPRnY5vEwRHwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InKDCA8VSAHMxdM4WSweQDY/5wUIH5vgDp4BCyGSbJ/th0B9nprY14FlP77VLsV0t5FyJ+qa3HuLXs/R8o02ChFF0W0qygrcCobO9+Zq/W1PMGfV+HeJCFudWsVMi3ZivC2hUzOrYXdiBiOWnivj/F7NMtOSugwLJ+N8bqxZK2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvgpsEjh; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvgpsEjh"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-135e7f4a295so2841137c88.0
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529461; x=1780134261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdYPrQ2V0SsFL9O2oIVedkPq9+Ea1ePouOP0UuVSLgA=;
        b=bvgpsEjhVR4o15s8rTpxVsKpo5hIHxpQcinL66XyGfZoL5n4yyxgoHmgwuNH6dWwPA
         g5BMmPge2j0R+Q01tdBNmqzYPY9gXtqSZPBcZvmo+sstSqtpsW+dfuZysvDl4aeNyDyd
         m0dX7IKlkIsguPaLtTCi8gD88wV3unc8hUYpTUuNLb4EW/Ef4LBSA/IzZBccWVghh0VK
         6yS66CpEfV3eK/657IqrQqVmACxeruFZ667jhbWLOo7CWEb1Ovw6CUJ1gflVwRbNNyYm
         cjZQ1B2bsFAa5aGLjpwvVVisWRoQ0H3WYWW8nPHqTgGr0ONGmCq5u8Pphyni+Rw51348
         ch/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529461; x=1780134261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fdYPrQ2V0SsFL9O2oIVedkPq9+Ea1ePouOP0UuVSLgA=;
        b=XWuJFOfI0+z6eY+KtDhxPd0YQzmwkQkCUajMPOu9ylbcBUGIxTmXLNsL3Is00gpU0s
         TmzXMaZWX48DziIlIMVZYD2S2BIT8/P+4riS15oG6tjUZ1ClU5n8hVOxV3XrTBCtrf30
         SluY4eDjZkXRAPfFSvvEaahnGe2OYg3H5LqmOI+y2P5IYF0cJI7+ODg9JpjBa/YmGbkJ
         vCF6KVxV246HuX67dfVXBkLiC55DeBFoDZMfvnbazQjn9Q0gp4dwK0UBSAjpXpimYZVo
         AlBLBXg7SbtbtKsNZym+f/G382dX1GArAWR5glCk9KNf7i3I0R3tXaS+cZ0FpvT46gUS
         0Q3Q==
X-Gm-Message-State: AOJu0YywCW4g9+ZjEpilhYbbHyRi2u2JfKF3cbEm0oJyqrLZOU7HiIe8
	A7BOPWEebFi4j/tV+3px1XFbb8fNfGHS9FdthAg5r2uUOfnR7T0BcbwaV6h0fQ==
X-Gm-Gg: Acq92OGYZdrEcBSbJOobvVjB8lkAxLg0MTG3UC+ISwop9R11LCf1rfHaU0F+rg83AgV
	3cPpFkYkM1O7MJmAhAPJbSqBct9r+kaO/c6UEkjWPk9Ciz4VuICwMbiYziX8JHR73lrg9+O+Q/w
	Z25g1vHSbn3MuXrvjRUtNkNndU5ndLUMPwNCcCo+rmFYJ5erxEUs+e2/+q5HdOa6Xkp/6SdK2Vl
	OBnDa6q9jYO+S/tUn5ReUahjnwsSkY5QcHp1NER0A+5tJsLkcPAM34QF9qo1lJla7po30n/4h87
	gY4WWd4shq/4yMLWZWVX4ISqWwO2dNSyR+uHyX0JzVzCWfv8irphXGRDivI4cixqFEjyUz91IVN
	xjINXE06KVL+k3Y1MrXAG6jCYexXvawuBelXxjKgT7bZu6A9sN6E3cMx6/YWyWCyvz1rNs4kQtq
	xzcavntkfU44Ggx0PK3ypWd1U26p+mJhEjYHQ5YvtgFiss9vFzKoYqQZUYZxTLxu2Ie9KEbiXd6
	OgCiH8=
X-Received: by 2002:a05:701b:4281:20b0:134:fc38:5d2f with SMTP id a92af1059eb24-136616f4055mr1707179c88.21.1779529460723;
        Sat, 23 May 2026 02:44:20 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm2376358c88.7.2026.05.23.02.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:44:20 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v10 23/31] dax/bus: Factor out dev dax resize logic
Date: Sat, 23 May 2026 02:43:17 -0700
Message-ID: <29393afa419cdffdd5d299cdc323262f5c20c036.1779528761.git.anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779528761.git.anisa.su@samsung.com>
References: <cover.1779528761.git.anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

Dynamic Capacity (DC) DAX regions back their dax devices with per-extent
resource children of the region, rather than carving from a single
contiguous dax_region->res.  Allocating space for a DC dax device — on
initial uuid claim of its backing extents and on shrink-to-0 during
destroy — needs the same allocator the static case uses, but pointed at
a different parent resource.

Factor the body of dev_dax_resize() into __dev_dax_resize(parent, ...)
and add a dev_dax_resize_static() wrapper that passes dax_region->res
for static (non-DC) regions.  alloc_dev_dax_range() gains the same
parent parameter so it can operate under either kind of parent.

No functional change.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[anisa: reword to drop the options-considered discussion and "sparse"
 terminology; preserved in a later commit that realizes per-extent
 resource children]
---
 drivers/dax/bus.c | 131 ++++++++++++++++++++++++++++------------------
 1 file changed, 81 insertions(+), 50 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 6368bdfdf93a..5c1b93890d30 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1012,11 +1012,10 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 	return 0;
 }
 
-static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
-		resource_size_t size, struct dax_resource *dax_resource)
+static int alloc_dev_dax_range(struct resource *parent, struct dev_dax *dev_dax,
+			       u64 start, resource_size_t size,
+			       struct dax_resource *dax_resource)
 {
-	struct dax_region *dax_region = dev_dax->region;
-	struct resource *res = &dax_region->res;
 	struct device *dev = &dev_dax->dev;
 	struct dev_dax_range *ranges;
 	unsigned long pgoff = 0;
@@ -1034,14 +1033,14 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		return 0;
 	}
 
-	alloc = __request_region(res, start, size, dev_name(dev), 0);
+	alloc = __request_region(parent, start, size, dev_name(dev), 0);
 	if (!alloc)
 		return -ENOMEM;
 
 	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
 			* (dev_dax->nr_range + 1), GFP_KERNEL);
 	if (!ranges) {
-		__release_region(res, alloc->start, resource_size(alloc));
+		__release_region(parent, alloc->start, resource_size(alloc));
 		return -ENOMEM;
 	}
 
@@ -1195,50 +1194,45 @@ static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
 	return true;
 }
 
-static ssize_t dev_dax_resize(struct dax_region *dax_region,
-		struct dev_dax *dev_dax, resource_size_t size)
+/**
+ * dev_dax_resize_static - Expand the device into the unused portion of the
+ * region. This may involve adjusting the end of an existing resource, or
+ * allocating a new resource.
+ *
+ * @parent: parent resource to allocate this range in
+ * @dev_dax: DAX device to be expanded
+ * @to_alloc: amount of space to alloc; must be <= space available in @parent
+ *
+ * Return the amount of space allocated or -ERRNO on failure
+ */
+static ssize_t dev_dax_resize_static(struct resource *parent,
+				     struct dev_dax *dev_dax,
+				     resource_size_t to_alloc)
 {
-	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
-	resource_size_t dev_size = dev_dax_size(dev_dax);
-	struct resource *region_res = &dax_region->res;
-	struct device *dev = &dev_dax->dev;
 	struct resource *res, *first;
-	resource_size_t alloc = 0;
 	int rc;
 
-	if (dev->driver)
-		return -EBUSY;
-	if (size == dev_size)
-		return 0;
-	if (size > dev_size && size - dev_size > avail)
-		return -ENOSPC;
-	if (size < dev_size)
-		return dev_dax_shrink(dev_dax, size);
-
-	to_alloc = size - dev_size;
-	if (dev_WARN_ONCE(dev, !alloc_is_aligned(dev_dax, to_alloc),
-			"resize of %pa misaligned\n", &to_alloc))
-		return -ENXIO;
-
-	/*
-	 * Expand the device into the unused portion of the region. This
-	 * may involve adjusting the end of an existing resource, or
-	 * allocating a new resource.
-	 */
-retry:
-	first = region_res->child;
-	if (!first)
-		return alloc_dev_dax_range(dev_dax, dax_region->res.start, to_alloc, NULL);
+	first = parent->child;
+	if (!first) {
+		rc = alloc_dev_dax_range(parent, dev_dax,
+					   parent->start, to_alloc, NULL);
+		if (rc)
+			return rc;
+		return to_alloc;
+	}
 
-	rc = -ENOSPC;
 	for (res = first; res; res = res->sibling) {
 		struct resource *next = res->sibling;
+		resource_size_t alloc;
 
 		/* space at the beginning of the region */
-		if (res == first && res->start > dax_region->res.start) {
-			alloc = min(res->start - dax_region->res.start, to_alloc);
-			rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, alloc, NULL);
-			break;
+		if (res == first && res->start > parent->start) {
+			alloc = min(res->start - parent->start, to_alloc);
+			rc = alloc_dev_dax_range(parent, dev_dax,
+						 parent->start, alloc, NULL);
+			if (rc)
+				return rc;
+			return alloc;
 		}
 
 		alloc = 0;
@@ -1247,21 +1241,56 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
 			alloc = min(next->start - (res->end + 1), to_alloc);
 
 		/* space at the end of the region */
-		if (!alloc && !next && res->end < region_res->end)
-			alloc = min(region_res->end - res->end, to_alloc);
+		if (!alloc && !next && res->end < parent->end)
+			alloc = min(parent->end - res->end, to_alloc);
 
 		if (!alloc)
 			continue;
 
 		if (adjust_ok(dev_dax, res)) {
 			rc = adjust_dev_dax_range(dev_dax, res, resource_size(res) + alloc);
-			break;
+			if (rc)
+				return rc;
+			return alloc;
 		}
-		rc = alloc_dev_dax_range(dev_dax, res->end + 1, alloc, NULL);
-		break;
+		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc, NULL);
+		if (rc)
+			return rc;
+		return alloc;
 	}
-	if (rc)
-		return rc;
+
+	/* available was already calculated and should never be an issue */
+	dev_WARN_ONCE(&dev_dax->dev, 1, "space not found?");
+	return 0;
+}
+
+static ssize_t dev_dax_resize(struct dax_region *dax_region,
+		struct dev_dax *dev_dax, resource_size_t size)
+{
+	resource_size_t avail = dax_region_avail_size(dax_region);
+	resource_size_t dev_size = dev_dax_size(dev_dax);
+	struct device *dev = &dev_dax->dev;
+	resource_size_t to_alloc;
+	resource_size_t alloc;
+
+	if (dev->driver)
+		return -EBUSY;
+	if (size == dev_size)
+		return 0;
+	if (size > dev_size && size - dev_size > avail)
+		return -ENOSPC;
+	if (size < dev_size)
+		return dev_dax_shrink(dev_dax, size);
+
+	to_alloc = size - dev_size;
+	if (dev_WARN_ONCE(dev, !alloc_is_aligned(dev_dax, to_alloc),
+			"resize of %pa misaligned\n", &to_alloc))
+		return -ENXIO;
+
+retry:
+	alloc = dev_dax_resize_static(&dax_region->res, dev_dax, to_alloc);
+	if (alloc <= 0)
+		return alloc;
 	to_alloc -= alloc;
 	if (to_alloc)
 		goto retry;
@@ -1367,7 +1396,8 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
 
 	to_alloc = range_len(&r);
 	if (alloc_is_aligned(dev_dax, to_alloc))
-		rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc, NULL);
+		rc = alloc_dev_dax_range(&dax_region->res, dev_dax, r.start,
+					 to_alloc, NULL);
 	up_write(&dax_dev_rwsem);
 	up_write(&dax_region_rwsem);
 
@@ -1659,7 +1689,8 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	device_initialize(dev);
 	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
 
-	rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, data->size, NULL);
+	rc = alloc_dev_dax_range(&dax_region->res, dev_dax, dax_region->res.start,
+				 data->size, NULL);
 	if (rc)
 		goto err_range;
 
-- 
2.43.0

