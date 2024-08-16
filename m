Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F37F1C0DD2;
	Fri, 16 Aug 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817320; cv=none; b=Y+mREY7UuiA/7FDYfX7P58uzr3Q/E86CM37dozVBbSCqdIqupfFtPBJEQZPyHrZl8BoPuYXz2wZWrW01Vjj+DdEwghBCLb4aR8wZdR3JtbZ8H8gEOPKH9A8hbTbkqrOzAvtoyealYHL621f9sqGe5i51qoi+6T3pFYtimvt+ueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817320; c=relaxed/simple;
	bh=r5+l2xi7CwUvP683eP1rT3xt7URxitfNsBryB6O28tU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cxA2H9PM6UZgtEKjSmnUvWEs9yPSFRnuWqaPbEdSKSkE/W8feJqD/f+oKbDnUW1iPt7HShRqu+xQR4Pn/JAIT85Km8BtEGrJeOYTaBxe5tt9qy1lvqiD3KO5KNxJvDxQmFNYs1j+sCToMe4X874tlDM2J3D3RUiuA0Ecs/psN7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BsSnuS5b; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BsSnuS5b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817319; x=1755353319;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=r5+l2xi7CwUvP683eP1rT3xt7URxitfNsBryB6O28tU=;
  b=BsSnuS5b4FKaOUJU3lwUPU5gZOOK3VH44l1U3SyaFnnVAAPKg/PdrNCF
   m5zcl6jrP+qrL6/iEuAuerFN8btDzvPxKecD/VlcT4T/pyttvJI74qsyf
   CQV4ilUHlnUWhYcmG5VfHHizzrwBE23oy8ZtWuu+SrKQeNBGaTSideUs1
   kPl00QAMyqeTnnAcdk5PypUfWuocFtxvo0ZGvuZxtJZg+Q7PkBRtsszPY
   Ytq/5q+kb4ziGmDoPxkOZfJartM9ybjorRN2YXdl4OdHnwS33kAaLZtko
   rcXM5V0FxAAtOUOM4AaKzzittvmV2SN4Ewv3gWIeR1pcRWjun6J9usnCq
   g==;
X-CSE-ConnectionGUID: M6oPgh2ZSje4xRumdOUrUA==
X-CSE-MsgGUID: l/sQtHAESUqZiMJRuTALMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22085294"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22085294"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:39 -0700
X-CSE-ConnectionGUID: 1aTvYgMlSQmXPMJz3nH4tQ==
X-CSE-MsgGUID: 5OZ8dA10STy9onOADTXhcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64571624"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:37 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:08:18 -0500
Subject: [PATCH RESEND v2 13/18] dax/bus: Factor out dev dax resize logic
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-13-b4044aadf2bd@intel.com>
References: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Navneet Singh <navneet.singh@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723817288; l=8374;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=r5+l2xi7CwUvP683eP1rT3xt7URxitfNsBryB6O28tU=;
 b=YMrqnM4cAkX/rDYiKS3rt6UdfyVoYeF3PMF2cHBPgm6Ql2PqL0cbwcdhnt9EOfbG0g+jrb5hE
 jI3OeWR+QpwAzfiUkT3+vCyZTX+VYOeQJ+y4AYmY8LiIMB50qXhUbfw
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Dynamic Capacity regions must limit dev dax resources to those areas
which have extents backing real memory.  Four alternatives were
considered to manage the intersection of region space and extents:

1) Create a single region resource child on region creation which
   reserves the entire region.  Then as extents are added punch holes in
   this reservation.  This requires new resource manipulation to punch
   the holes and still requires an additional iteration over the extent
   areas which may already have existing dev dax resources used.

2) Maintain an ordered xarray of extents which can be queried while
   processing the resize logic.  The issue is that existing region->res
   children may artificially limit the allocation size sent to
   alloc_dev_dax_range().  IE the resource children can't be directly
   used in the resize logic to find where space in the region is.

3) Maintain a separate resource tree with extents.  This option is the
   same as 2) but with a different data structure.  Most ideally we have
   some unified representation of the resource tree.

4) Create region resource children for each extent.  Manage the dax dev
   resize logic in the same way as before but use a region child
   (extent) resource as the parents to find space within each extent.

Option 4 can leverage the existing resize algorithm to find space within
the extents.

In preparation for this change, factor out the dev_dax_resize logic.
For static regions use dax_region->res as the parent to find space for
the dax ranges.  Future patches will use the same algorithm with
individual extent resources as the parent.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/bus.c | 128 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 79 insertions(+), 49 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index b76e49813a39..ea7ae82b4687 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -817,11 +817,10 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 	return 0;
 }
 
-static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
-		resource_size_t size)
+static int alloc_dev_dax_range(struct resource *parent, struct dev_dax *dev_dax,
+			       u64 start, resource_size_t size)
 {
 	struct dax_region *dax_region = dev_dax->region;
-	struct resource *res = &dax_region->res;
 	struct device *dev = &dev_dax->dev;
 	struct dev_dax_range *ranges;
 	unsigned long pgoff = 0;
@@ -839,14 +838,14 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
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
 
@@ -997,50 +996,45 @@ static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
 	return true;
 }
 
-static ssize_t dev_dax_resize(struct dax_region *dax_region,
-		struct dev_dax *dev_dax, resource_size_t size)
+/*
+ * dev_dax_resize_static - Expand the device into the unused portion of the
+ * region. This may involve adjusting the end of an existing resource, or
+ * allocating a new resource.
+ *
+ * @parent: parent resource to allocate this range in.
+ * @dev_dax: DAX device we are creating this range for
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
-		return alloc_dev_dax_range(dev_dax, dax_region->res.start, to_alloc);
+	first = parent->child;
+	if (!first) {
+		rc = alloc_dev_dax_range(parent, dev_dax,
+					   parent->start, to_alloc);
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
-			rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, alloc);
-			break;
+		if (res == first && res->start > parent->start) {
+			alloc = min(res->start - parent->start, to_alloc);
+			rc = alloc_dev_dax_range(parent, dev_dax,
+						 parent->start, alloc);
+			if (rc)
+				return rc;
+			return alloc;
 		}
 
 		alloc = 0;
@@ -1049,21 +1043,55 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
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
-		rc = alloc_dev_dax_range(dev_dax, res->end + 1, alloc);
-		break;
+		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc);
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
+	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
+	resource_size_t dev_size = dev_dax_size(dev_dax);
+	struct device *dev = &dev_dax->dev;
+	resource_size_t alloc = 0;
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
@@ -1154,7 +1182,8 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
 
 	to_alloc = range_len(&r);
 	if (alloc_is_aligned(dev_dax, to_alloc))
-		rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc);
+		rc = alloc_dev_dax_range(&dax_region->res, dev_dax, r.start,
+					 to_alloc);
 	device_unlock(dev);
 	device_unlock(dax_region->dev);
 
@@ -1371,7 +1400,8 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	device_initialize(dev);
 	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
 
-	rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, data->size);
+	rc = alloc_dev_dax_range(&dax_region->res, dev_dax, dax_region->res.start,
+				 data->size);
 	if (rc)
 		goto err_range;
 

-- 
2.45.2

