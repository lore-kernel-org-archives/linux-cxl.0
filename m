Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41AF2AE78
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871648; cv=none; b=c2UKWfpKBylhSg+17R8RdQRiRqiTjHb1agcM8OgEOkyG9pkUx7X1ZeogDxMAZlmen9w1uXy2yOQKDYWTTUE8zfyue5m2mcNvaLXKqOd7PquE0JCqlkR8+Fjdwwuc7t3CSCcsrS7dG4wwJMxzsJ0eFXbNyFWInKbwO24OiLHUKD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871648; c=relaxed/simple;
	bh=tOppsO4d0YvJvVZ7oyoYwlGabEtcvOSrYzdkdYOvIs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5fToCIcN2x2A5XnomeBbKcp/Q6eYnjn/qklgC/BKh+I0CprEI6sUcSP1h5hGiiKxgforVN5cuP3+Ni3cgJ+8FGvqZzfOr3ZWHpiJPLIDljEtE8GWBFZ+PllWDnQlDPVTRtdr9ok78e+nb6qRAoszTthnAN+thI1uZoFdqRT3uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDxS3n3T; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDxS3n3T"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79db5e18ac6so27188367b3.1
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871646; x=1776476446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17IIPTq/9th2BRK8fWvv5HHuxRGjfWESmi8k7JxfiAo=;
        b=cDxS3n3TpS122mU3GSKlpOmUQhl9vLSMxty5O+04PxgzNtufnm9UqNVM9gKKcD2wcg
         25faAZ/yUzXApUtTD5XVYRj1ChSYAJZwKgDRZlFUxe4Dnauos08tBoFfYrUte0kVZTwM
         ZibOpg5rehi2SbfL/WwdkS6VoD03IakOw2raNWu6/A+nbHLz506nNJZKMBA9hfS4RSKo
         cWrpmX+RLoXyRa/qjJJ4dvoMbPDmpI7WIDzUVYjohtFI1BJpKyqzLLsqsFaL4PeWjv+z
         Ys/6mdbdp+HE/bfwsg7PJVVJXMYUdnOdYNzXXAHL5Srn+1vARBsu6X3zgVK5Wluj32aZ
         y2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871646; x=1776476446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=17IIPTq/9th2BRK8fWvv5HHuxRGjfWESmi8k7JxfiAo=;
        b=lkZFnbHWWcUbNbSBoRyUPG3fefUVZUrALt5/QcIoX9xNuobTHzs+Mqatd2EgLs4H1B
         iwppBqkce8p/wvZc2nlRnQzke3l1y8MyfXSMIPVc8vhKDDNvjHLEzNHlFz++kFmmszZL
         pDkYmLP9mE1OM83e7dUmyRMOP5sOJb1u5k1G/436Rhgqe49HbdK1VMt565E4OuXG3Xqe
         bG1n17IbTh45I4ZTzSnavuWCZHpuoVxf+3ifPlW+6cVIfvo0qIAQnCdJ8zY9BKsfG9JL
         EuRXFI9lnGuV3qwvTMDhxTAGajbS2qfbZJuKXbBXTwiENLUAvkV+XjsWrxwOSSrK9hGm
         WzqA==
X-Gm-Message-State: AOJu0YyStPUDOtAMHv0vfSu99SllJE/WGa6HUPQJ4xPsVz3I0fxLokoc
	bBwD0M7sLKjqxsF73iDT+tLt6sSY0LjXpZRfhYodvu+kn41XZ3Y+xiZY+ST8hg==
X-Gm-Gg: AeBDieuEshOBfwvPpFz89/TbgG9i/Yhy9zASh4OeJQAqLlw4nm65TyJXfsaoiybEiXu
	YpV/z0RZNYHgJtiIDAqMJNaa6LCjyKn/4KYVyJG10sqOWNI3NwFQ5Fv96wftqmmnPO+xVll321/
	HHPVHrLCzZaIEYwAtK+3tq3bXMFeWxFuQyBoOA7BV6gu5ul1Hb5wKx+6ipLOblkYV4JmO394nDl
	0obAHuhLLIwiRqsx/yoM6SM1EzAYF22TQ7BJ1nLdqJCGHfrqE9062umWoUzeE2tq9Z4zWo6AvEW
	fFmnIfAWm2027vM5kpKevwihATar+atRMXJgZpC70vx3MNicVvCtnKmBN5Hl3VRUjHYZUIdWCSL
	vq5c8JdREIhSj+/fufddvs5/um5kzj3teqNq9AHY22N969bprBN0sb3R1FU3r9uAbTiJQmrVrR/
	EfeNQLKLwsItoXCw/boYvIm0rP6tV/kOF3+VrLn7NU8Q==
X-Received: by 2002:a05:690c:6e86:b0:79f:2e53:85f8 with SMTP id 00721157ae682-7adec6e677emr87940347b3.3.1775871645809;
        Fri, 10 Apr 2026 18:40:45 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:45 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: john@groves.net,
	dave.jiang@intel.com,
	gourry@gourry.net,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 14/20] dax/bus: Factor out dev dax resize logic
Date: Fri, 10 Apr 2026 18:23:09 -0700
Message-ID: <20260411013958.47422-15-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

Dynamic Capacity regions must limit dev dax resources to those areas
which have extents backing real memory.  Such DAX regions are dubbed
'sparse' regions.  In order to manage where memory is available four
alternatives were considered:

1) Create a single region resource child on region creation which
   reserves the entire region.  Then as extents are added punch holes in
   this reservation.  This requires new resource manipulation to punch
   the holes and still requires an additional iteration over the extent
   areas which may already have existing dev dax resources used.

2) Maintain an ordered xarray of extents which can be queried while
   processing the resize logic.  The issue is that existing region->res
   children may artificially limit the allocation size sent to
   alloc_dev_dax_range().  IE the resource children can't be directly
   used in the resize logic to find where space in the region is.  This
   also poses a problem of managing the available size in 2 places.

3) Maintain a separate resource tree with extents.  This option is the
   same as 2) but with the different data structure.  Most ideally there
   should be a unified representation of the resource tree not two places
   to look for space.

4) Create region resource children for each extent.  Manage the dax dev
   resize logic in the same way as before but use a region child
   (extent) resource as the parents to find space within each extent.

Option 4 can leverage the existing resize algorithm to find space within
the extents.  It manages the available space in a singular resource tree
which is less complicated for finding space.

In preparation for this change, factor out the dev_dax_resize logic.
For static regions use dax_region->res as the parent to find space for
the dax ranges.  Future patches will use the same algorithm with
individual extent resources as the parent.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[anisa: rebase]
---
 drivers/dax/bus.c | 130 ++++++++++++++++++++++++++++------------------
 1 file changed, 80 insertions(+), 50 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index e41e36747111..40f11fda66b5 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -858,11 +858,9 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 	return 0;
 }
 
-static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
-		resource_size_t size)
+static int alloc_dev_dax_range(struct resource *parent, struct dev_dax *dev_dax,
+			       u64 start, resource_size_t size)
 {
-	struct dax_region *dax_region = dev_dax->region;
-	struct resource *res = &dax_region->res;
 	struct device *dev = &dev_dax->dev;
 	struct dev_dax_range *ranges;
 	unsigned long pgoff = 0;
@@ -880,14 +878,14 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
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
 
@@ -1040,50 +1038,45 @@ static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
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
@@ -1092,21 +1085,56 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
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
@@ -1212,7 +1240,8 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
 
 	to_alloc = range_len(&r);
 	if (alloc_is_aligned(dev_dax, to_alloc))
-		rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc);
+		rc = alloc_dev_dax_range(&dax_region->res, dev_dax, r.start,
+					 to_alloc);
 	up_write(&dax_dev_rwsem);
 	up_write(&dax_region_rwsem);
 
@@ -1480,7 +1509,8 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	device_initialize(dev);
 	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
 
-	rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, data->size);
+	rc = alloc_dev_dax_range(&dax_region->res, dev_dax, dax_region->res.start,
+				 data->size);
 	if (rc)
 		goto err_range;
 
-- 
2.43.0

