Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525D843F8D6
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065571; cv=none; b=VMOObJoRFCrKJgwAkxCuCTuhOQI6SJttGUnxmlMg4FZLdJ89KkeztkaP1brkzPlAT1mjy8BTV6L2YST+GmEsLWWU402WhTBmWSgXfZ+RbM6xxMlk/3xc0fZK8P4Dkyxl+F/XVqngz6OfYBHxJWIdaP5bBJy91SAxk/E1TeDg4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065571; c=relaxed/simple;
	bh=gDuzCbBWa4i/QzDHVpki1vGVufDbJq3yyqVO9iAFePk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPT86G+59asnMPkKGLVWxPKNysr956hooU3HePKpiOYG94LDmbWYK8PcY9aoGaFcy9r0m9Y/6SSUqR1oVnrbd0gV7dFZXZZYcUfPFHPnIeIKLu+hH36hh7b4WBs0Exwvuci5IEgbUO3C77d83tXeeiQFFPtJpMopKL2ulxEGG9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cnyw4aPI; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cnyw4aPI"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea34ef3so3425559a12.0
        for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 01:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790065568; x=1790670368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0brUoJgl363yZ4gkPK7I4CZdxK+wxHx8g/cRElUmljE=;
        b=cnyw4aPISA7iv7CXUHvXiqJVIJT455FHLioGGZoff4PQLdODzYK78Oq6/6IWQq9AYM
         /Nx5UJmOw9s3wfiCjZl0dUJ1hVNJfLRqhfN8SsCBmHxn7YECOt1dKaifln9OVs2VzQGz
         upBaSEuVDEn6ehBbIn634G3qB9hikYzHgRVSj4fODEaDLw4mwAtdXSrMRuP4FMrGarOX
         C32B3nICZQC0X/E9vK4wnROFY11ZjRpR5AZhQiZchf0sl1nh2UuoZ/UyOw+ffo6LTz2J
         TfGr5zH99wEuzF5F/0Apk+so/Mds4QATcHukbF1WqPUVfAwyUfUx0iF8f1yfafilZGSa
         wwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065568; x=1790670368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0brUoJgl363yZ4gkPK7I4CZdxK+wxHx8g/cRElUmljE=;
        b=PjgIFBuZCImjGGdrHx8HTTeQ33BpFoMKWbouFAGh/iDZ7rYcMjKbpv5bPB7vbUBm7P
         KT4Yc1Wm9h2PATuvzXdcSO6BbNV7Y3oQUWVmgIqlvJCtR2oAgbctP/LQSlUbF8mnZwR7
         ur8sVZRcTIm3kSfIQj56nVjSGl+vvfPVy0I48auBRyVH6TME+ecGSP6y1auN6LaG9KRv
         n2922c9Hx/dX/fwyb1kw5wxGW3Ran5Aiesb5m20OsrzS7qqlSJ4yulW9JyYw31iFhG8v
         qK9e6wuVb0+Z9RhHPsiSGPC5S8qwA4pYcpOMWOXNfNLCsnvX5m5WDfkB/ifZmSjRi6ef
         CJlA==
X-Forwarded-Encrypted: i=1; AKwUvBwe7ZhsFeTkZQ9VEQVMlVCghTZnPufivAuPjY7WNPAV5GOjSH9XDDaZhnA/sVLyk2qsRgilPa93vRs=@vger.kernel.org
X-Gm-Message-State: AFuF++koreQJjCf0ZKPdhvwigmv07aQa/tx79tiJnvw2VMpG+s1dnDaA
	z7rn69okfgk5Op9Yn8y4Lg2JI6cHIiH5DgvaxCF8lmRJHRA8ABmHM9z/HlT+z3nkP1U=
X-Gm-Gg: AYBFou1DMtbG6erv3qaO9ZPhv8O8M/pd7ECXPPnThpaWS44ncYEb5wnWRYjUwKAfODm
	jZG/uI4KeUPK8pTsK69epp/HNriki3zSNzabyPjGO8kuny+QKFJmYgNGR1BhvzhftuvXanb8xSo
	PB/eW1lzRc/V8Us8NpSs5tmj8K2f0eBNHPhGcp4HkLLd1CXWW5QNlRC+i+Y/o+Vrxoz/ccClM+a
	3raF5H7MciL4Uf52AlLx1tiETjWxhx8jpvrA/L1FQsXBL8Tk+htPIIUXj6nxuY6Y9lya7IUXrAx
	DQdtKrJY/xH7Kmaad/vTrcvn6KtfiMsuVSSH8nMJ6ZdfQGQcwXwb0gPwSlzo65R3b2dCenAt/y0
	m17n3Va8Al6WWHngK81TpgRaQ2ZzwIWG4G6QSr0LMnsHilyWuaQTPq+As0b1lOPp6RxSWmz4vbM
	xymYq0ATX6qfnrT0k4whOFuHUrg0A/xbhpZ7qNdNOh/aGRE0iQlJCyA8qfR6wOPscO2TEM1uV1n
	xFZjZU8iGmlXSgAAvXY
X-Received: by 2002:a17:90a:da8c:b0:39e:4c81:6c96 with SMTP id 98e67ed59e1d1-3a073128f99mr412576a91.28.1790065564966;
        Tue, 22 Sep 2026 01:26:04 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07385e516sm223056a91.0.2026.09.22.01.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:26:04 -0700 (PDT)
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
Subject: [PATCH v2 2/2] dax/bus: fix Device DAX range alignment validation
Date: Tue, 22 Sep 2026 16:25:51 +0800
Message-ID: <20260922082551.874901-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922082551.874901-1-songmuchun@bytedance.com>
References: <20260922082551.874901-1-songmuchun@bytedance.com>
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
allocations use the same validation.

A mapping with an unaligned start is now rejected with -EINVAL, while a
naturally aligned mapping still binds successfully.

Fixes: 6d82120f4156 ("device-dax: add an 'align' attribute")
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
- Keep the alloc_is_aligned() name to avoid unrelated helper renaming
  (suggested by Dave Jiang)
- Move this patch after the mapping error reporting fix for independent
  backports (suggested by Dave Jiang)
---
 drivers/dax/bus.c | 134 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 104 insertions(+), 30 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index e40c25401cf0..277c3ce23b83 100644
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

