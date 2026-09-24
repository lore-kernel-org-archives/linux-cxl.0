Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDEE399890
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790218252; cv=none; b=XajWHDCGLkodKeJnbx5Kwqmq1nffTLKtnTiqiEkyZB72jElIeKXbU3v9vPE2UGSTmikJ+tKddDB0/77PrIJttDRpmb1AqSgsEojQsAlFlq0U+6qQlHG0SoL052wkqhwan5tEVRXsCje1RtPauADtcEqItcVG7AIkBz+OJQMSWZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790218252; c=relaxed/simple;
	bh=PSGIyj/he3EQ5z9BehwBm22jMhvf+ztAjx5Btu3GKEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBzHQeVxIVgV3cLDjnKHCyLknOKuet+T1hJcJ7ZL635/x6BmWs6ZwOeLng006/gMbQWj0yWu5mIplLPkEOsOorc+PDDFvovQSz09gWG7M0I3qAw56bJB4GBH99yLVnHAz5q8njdz5P+v5GsEyRF1F3lgdGp8JXmLOFBOFyBD7Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eCLSM9op; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eCLSM9op"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d91ede8035so14503265ad.3
        for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 19:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790218250; x=1790823050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OkhVxd3L9PzXsj1q1bSnMpIAsRsR0Q+1nWxwALhwIXY=;
        b=eCLSM9ophRu+CoX6LqrcAXTECYl1IVOrBfmOJh8y+8LxkjWhJ+QylJmTVDM3Y89JD8
         1nZ8oc6NkMfesktx5NiQGi56zXaD+yBZT/NUGd8qAS85B/n6+461qMIi51t334pwhpXT
         RvOr8YJX5fvQlW8dfWcwgs/kybCQzaITEl2amfVL8l1dl2GibPkmhkRUgnjorsASkmmn
         NZdopUeFL6kgtRiUamo7wVeu8KJ8h0vEK7MYTzskkXLAWBu3lQmMUB9XXHCxGHYNeaxN
         Ibm3yUsKTAn4B7QrcxHDknYfDZOlCgfpJLjJa2iVRe1wRQcSDIbEh6tmiSWyCQZoJJBz
         kHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790218250; x=1790823050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OkhVxd3L9PzXsj1q1bSnMpIAsRsR0Q+1nWxwALhwIXY=;
        b=jffmAb7iVGQmQF8f17kf6Uy5JwZK8X1GqFBEqm/jD6BNOvZtYgyo5G7vU4RsveGozi
         sHCI7X/GNMWrUFrUs39y3OXXxyGvyUp8nggnvn4NYMwrhiZV/d3bxh/F5OHcy7Am/WMZ
         zYRE/AknTWimHUlguuypm1NjEvfiYLmKlNq4xSsEmSVO+1NibgaVzDpTFsDuEzkf1EkE
         H/hMCsl8/kON2DlSurGSlD8ZCHoO/xU2+gPxyQjmZRqTyRNPEaPnG8Wtr2PlDdlldBpD
         OcCjAV40aEN5IKlshhh3gR+m6MrPP/0IHKkEUWigcU1ccbsgnMkgcToeEPYN8L9+S6By
         QYlw==
X-Forwarded-Encrypted: i=1; AKwUvByNf/ux0anHAkd4Nr6vf76F8INnR694z/uIdG3bmTtlIlSCe6JV+pVfEYYHJNhVGnfhzlQX6Tq+VZ8=@vger.kernel.org
X-Gm-Message-State: AFuF++lx6kagb7SUXG7eukEuBpuZ+zIn/P6fgXywRSJA0vbKTo0WyPB9
	ZuLK8OnaGUHP5ZUDQ69I0+61bJXfSQRSayS+F1NTCrppcllRs5Vcr1Pf3foXkzeaJ3A=
X-Gm-Gg: AYBFou2dppWEX+V2nSdLQRv7QzAeihIwxoQZHd6ZpDNsR+1/MAbDuXxBWpZXAPCDxea
	3yewC91W3UT2ij6fmRhdFxjAB7F/DGK3lq5xhmSMoU+7kr9HQ8oLV09OMk6s/H12f2M0TNyhtwT
	k2IyTlSu8a5CrEcKy4NuM/z0xEa4+BcGqX2NC3YHTIcHzXD8ANFwsCcfxNppfinOFWvtgSc57Vt
	JlRZl+Nd8BA+zS4q7f1BudMfebWsbTUR17LiF8oObeSpju+RAZUjupXlixvWTgIsb2tmHV9tWhB
	Lb77+eG04JHXUqI+yANhFdoAlMlmk7+gMnLZYcjh47vrmMq7lR045fS7RIsxce22ojuKMEMCl2j
	+b+BWdkbIF2ATPKwF0KdzG2rMz3KadqROnRsqJZ0yxj2OcjhW0L9xAO+3CfBUw8mdUsotsRn5LZ
	tnpM38yG55uQTNnA5jl7s2osV4pyDJSOESObVJHu3RD7PUqjpImyFvPgn51EnunuTnJg2T/kCPj
	Mv1oft+1vZ89vs/uBhx
X-Received: by 2002:a17:902:f707:b0:2dd:c100:9439 with SMTP id d9443c01a7336-2df7e65c38dmr8400315ad.55.1790218249975;
        Wed, 23 Sep 2026 19:50:49 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a4f6bsm18638185ad.15.2026.09.23.19.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 19:50:49 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v3 2/2] dax/bus: fix Device DAX range alignment validation
Date: Thu, 24 Sep 2026 10:50:35 +0800
Message-ID: <20260924025035.1265035-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260924025035.1265035-1-songmuchun@bytedance.com>
References: <20260924025035.1265035-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_dax->align describes the page size used by a Device DAX mapping.
Both the start and size of every range must therefore be aligned to it;
otherwise the starting PFN cannot represent a naturally aligned page of
that size.

Only range sizes are currently validated. A dynamic device can therefore
select a large-page alignment and allocate a range whose start is not
naturally aligned to that page size. The device binds successfully, but a
subsequent write to a userspace mapping may trigger a kernel panic.

The automatic resize path can also split a size-aligned request across
arbitrary free gaps. When devices with different alignments fragment a
region, this can extend a range by less than its alignment. A later
allocation then fails, leaving the failed resize partially applied.

Validate both the start and size of allocated and adjusted ranges. Make
the resize path account only for usable aligned space before changing any
ranges, and skip gaps that cannot satisfy the device alignment. Initialize
the device alignment before allocating its initial range so that all
allocations use the same validation. Perform size validation under the
same locks as alignment updates so the alignment cannot change before
resizing begins.

A mapping with an unaligned start is now rejected with -EINVAL, while a
naturally aligned mapping still binds successfully.

Fixes: 6d82120f4156 ("device-dax: add an 'align' attribute")
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v3:
- Serialize size alignment validation with alignment updates to avoid a
  partial shrink after a concurrent alignment change (reported by Sashiko)
- Document the size validation serialization in the commit message

v2:
- Keep the alloc_is_aligned() name to avoid unrelated helper renaming
  (suggested by Dave Jiang)
- Move this patch after the mapping error reporting fix for independent
  backports (suggested by Dave Jiang)
---
 drivers/dax/bus.c | 144 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 109 insertions(+), 35 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index e40c25401cf0..8616527656d8 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -848,6 +848,44 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 	return 0;
 }
 
+static inline unsigned long dev_dax_min_align(struct dev_dax *dev_dax)
+{
+	return max_t(unsigned long, dev_dax->align, memremap_compat_align());
+}
+
+static inline bool alloc_is_aligned(struct dev_dax *dev_dax, resource_size_t size)
+{
+	/*
+	 * The minimum mapping granularity for a device instance is a
+	 * single subsection, unless the arch says otherwise.
+	 */
+	return IS_ALIGNED(size, dev_dax_min_align(dev_dax));
+}
+
+static inline bool range_is_aligned(struct dev_dax *dev_dax, u64 start,
+				    resource_size_t size)
+{
+	return IS_ALIGNED(start | size, dev_dax_min_align(dev_dax));
+}
+
+static resource_size_t
+aligned_gap_size(struct dev_dax *dev_dax, resource_size_t *start,
+		 resource_size_t end)
+{
+	resource_size_t aligned_start = ALIGN(*start, dev_dax_min_align(dev_dax));
+	resource_size_t size;
+
+	if (aligned_start < *start || aligned_start > end)
+		return 0;
+
+	size = ALIGN_DOWN(end - aligned_start + 1, dev_dax_min_align(dev_dax));
+	if (!size)
+		return 0;
+
+	*start = aligned_start;
+	return size;
+}
+
 static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		resource_size_t size)
 {
@@ -870,6 +908,9 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		return 0;
 	}
 
+	if (!range_is_aligned(dev_dax, start, size))
+		return -EINVAL;
+
 	alloc = __request_region(res, start, size, dev_name(dev), 0);
 	if (!alloc)
 		return -ENOMEM;
@@ -923,6 +964,9 @@ static int adjust_dev_dax_range(struct dev_dax *dev_dax, struct resource *res, r
 	if (dev_WARN_ONCE(dev, !size, "deletion is handled by dev_dax_shrink\n"))
 		return -EINVAL;
 
+	if (!range_is_aligned(dev_dax, range->start, size))
+		return -EINVAL;
+
 	rc = adjust_resource(res, range->start, size);
 	if (rc)
 		return rc;
@@ -955,15 +999,6 @@ static ssize_t size_show(struct device *dev,
 	return sysfs_emit(buf, "%llu\n", size);
 }
 
-static bool alloc_is_aligned(struct dev_dax *dev_dax, resource_size_t size)
-{
-	/*
-	 * The minimum mapping granularity for a device instance is a
-	 * single subsection, unless the arch says otherwise.
-	 */
-	return IS_ALIGNED(size, max_t(unsigned long, dev_dax->align, memremap_compat_align()));
-}
-
 static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 {
 	resource_size_t to_shrink = dev_dax_size(dev_dax) - size;
@@ -1030,23 +1065,46 @@ static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
 	return true;
 }
 
+static resource_size_t
+dax_region_aligned_avail_size(struct dax_region *dax_region,
+			      struct dev_dax *dev_dax)
+{
+	struct resource *region_res = &dax_region->res;
+	resource_size_t start = region_res->start;
+	resource_size_t avail = 0;
+	struct resource *res;
+
+	lockdep_assert_held_write(&dax_region_rwsem);
+
+	for_each_dax_region_resource(dax_region, res) {
+		if (res->start > start) {
+			resource_size_t gap_start = start;
+
+			avail += aligned_gap_size(dev_dax, &gap_start,
+					res->start - 1);
+		}
+		start = res->end + 1;
+	}
+	if (start <= region_res->end)
+		avail += aligned_gap_size(dev_dax, &start, region_res->end);
+
+	return avail;
+}
+
 static ssize_t dev_dax_resize(struct dax_region *dax_region,
 		struct dev_dax *dev_dax, resource_size_t size)
 {
-	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
 	resource_size_t dev_size = dev_dax_size(dev_dax);
 	struct resource *region_res = &dax_region->res;
 	struct device *dev = &dev_dax->dev;
 	struct resource *res, *first;
-	resource_size_t alloc = 0;
+	resource_size_t alloc, to_alloc;
 	int rc;
 
 	if (dev->driver)
 		return -EBUSY;
 	if (size == dev_size)
 		return 0;
-	if (size > dev_size && size - dev_size > avail)
-		return -ENOSPC;
 	if (size < dev_size)
 		return dev_dax_shrink(dev_dax, size);
 
@@ -1054,6 +1112,8 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
 	if (dev_WARN_ONCE(dev, !alloc_is_aligned(dev_dax, to_alloc),
 			"resize of %pa misaligned\n", &to_alloc))
 		return -ENXIO;
+	if (to_alloc > dax_region_aligned_avail_size(dax_region, dev_dax))
+		return -ENOSPC;
 
 	/*
 	 * Expand the device into the unused portion of the region. This
@@ -1062,37 +1122,51 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
 	 */
 retry:
 	first = region_res->child;
-	if (!first)
-		return alloc_dev_dax_range(dev_dax, dax_region->res.start, to_alloc);
+	if (!first) {
+		resource_size_t start = region_res->start;
+
+		alloc = aligned_gap_size(dev_dax, &start, region_res->end);
+		return alloc_dev_dax_range(dev_dax, start, min(alloc, to_alloc));
+	}
 
 	rc = -ENOSPC;
 	for (res = first; res; res = res->sibling) {
 		struct resource *next = res->sibling;
+		resource_size_t start, end;
 
 		/* space at the beginning of the region */
 		if (res == first && res->start > dax_region->res.start) {
-			alloc = min(res->start - dax_region->res.start, to_alloc);
-			rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, alloc);
-			break;
+			start = dax_region->res.start;
+			end = res->start - 1;
+			alloc = min(aligned_gap_size(dev_dax, &start, end), to_alloc);
+			if (alloc) {
+				rc = alloc_dev_dax_range(dev_dax, start, alloc);
+				break;
+			}
 		}
 
-		alloc = 0;
 		/* space between allocations */
-		if (next && next->start > res->end + 1)
-			alloc = min(next->start - (res->end + 1), to_alloc);
-
-		/* space at the end of the region */
-		if (!alloc && !next && res->end < region_res->end)
-			alloc = min(region_res->end - res->end, to_alloc);
+		if (next) {
+			if (next->start <= res->end + 1)
+				continue;
+			end = next->start - 1;
+		} else {
+			/* space at the end of the region */
+			if (res->end >= region_res->end)
+				continue;
+			end = region_res->end;
+		}
 
+		start = res->end + 1;
+		alloc = min(aligned_gap_size(dev_dax, &start, end), to_alloc);
 		if (!alloc)
 			continue;
 
-		if (adjust_ok(dev_dax, res)) {
+		if (start == res->end + 1 && adjust_ok(dev_dax, res)) {
 			rc = adjust_dev_dax_range(dev_dax, res, resource_size(res) + alloc);
 			break;
 		}
-		rc = alloc_dev_dax_range(dev_dax, res->end + 1, alloc);
+		rc = alloc_dev_dax_range(dev_dax, start, alloc);
 		break;
 	}
 	if (rc)
@@ -1115,11 +1189,6 @@ static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 	if (rc)
 		return rc;
 
-	if (!alloc_is_aligned(dev_dax, val)) {
-		dev_dbg(dev, "%s: size: %lld misaligned\n", __func__, val);
-		return -EINVAL;
-	}
-
 	rc = down_write_killable(&dax_region_rwsem);
 	if (rc)
 		return rc;
@@ -1130,6 +1199,11 @@ static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 	rc = down_write_killable(&dax_dev_rwsem);
 	if (rc)
 		goto err_dev;
+	if (!alloc_is_aligned(dev_dax, val)) {
+		dev_dbg(dev, "%s: size: %lld misaligned\n", __func__, val);
+		rc = -EINVAL;
+		goto err_dev;
+	}
 
 	rc = dev_dax_resize(dax_region, dev_dax, val);
 
@@ -1228,9 +1302,9 @@ static ssize_t dev_dax_validate_align(struct dev_dax *dev_dax)
 	int i;
 
 	for (i = 0; i < dev_dax->nr_range; i++) {
-		size_t len = range_len(&dev_dax->ranges[i].range);
+		struct range *range = &dev_dax->ranges[i].range;
 
-		if (!alloc_is_aligned(dev_dax, len)) {
+		if (!range_is_aligned(dev_dax, range->start, range_len(range))) {
 			dev_dbg(dev, "%s: align %u invalid for range %d\n",
 				__func__, dev_dax->align, i);
 			return -EINVAL;
@@ -1468,6 +1542,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 		return ERR_PTR(-ENOMEM);
 
 	dev_dax->region = dax_region;
+	dev_dax->align = dax_region->align;
 	if (is_static(dax_region)) {
 		if (dev_WARN_ONCE(parent, data->id < 0,
 				"dynamic id specified to static region\n")) {
@@ -1526,7 +1601,6 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 
 	dev_dax->dax_dev = dax_dev;
 	dev_dax->target_node = dax_region->target_node;
-	dev_dax->align = dax_region->align;
 	ida_init(&dev_dax->ida);
 
 	dev_dax->memmap_on_memory = data->memmap_on_memory;
-- 
2.54.0

