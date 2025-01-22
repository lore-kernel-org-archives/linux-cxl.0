Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E101C20FA80
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737536376; cv=none; b=gfkK3xZvXKDXbQo+jm9IqEvQ+mD+qeRBlscFv1nGY7PxmwdaayYd7jgYMrb0Xg2lTMuphbACfx/U7vJ+jqvvWDvwi2gduknfzVYUfPErKPusC7qigEi5G2WQY+7AsXFEwAIJrhmiP2AVbM0k65+1ctp+ClnlX+2RESMNpkETuRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737536376; c=relaxed/simple;
	bh=+pQ7x8D3Jh3r5Qcht5j1uNnKKdO3FI5oRtixrpdn7eo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=leA54qMN6L7dKTUBKc0BYOZOm7x91TXGcul6yjpu7hUNABbRe/rMUHUllet+fU5FI6S8u99fuLsWDXEeTSnbQbjXzcigB1GsaqlWTx16N2a8ub7+aaxTrgp5bMHofNIcN/sTdBPt5+PFysYK+9vELXd9BMwkMQsVQ5MENmxZy88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlWpYqqu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlWpYqqu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737536374; x=1769072374;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+pQ7x8D3Jh3r5Qcht5j1uNnKKdO3FI5oRtixrpdn7eo=;
  b=GlWpYqquIGJv+rJtw7RhKErA+ZpFUcMNh+uya12BOkDD67NO0cpkLZP1
   BXnYOjShOXMjp4XOGv2HtMOeHcqa/x6FPHKnuosyVmwtTvFdEL39ivH0d
   ofl5HT3xF4UnoWjxXEhBE9o4SUqyH1Fgj8o+uemwBQxsKiEBi/3p6d3Hp
   WLKnEE6mcRq51bvO0DpQ9Jpk2RWHIahqUST0TsloWY8NBHpy9RhK/b0vC
   fNoJYTTPQMX53D75Q2Y3N710yUolGR45UCUp/MZ3ndlITsLvnCg3bPfhu
   csI0j5smx3NhMz45vgYk4OjX39nvJJ06cIz5xjrvvdjvMhKW6WdsecpQ2
   A==;
X-CSE-ConnectionGUID: hxjMs4etSEu0zraGYxLiqQ==
X-CSE-MsgGUID: +A8nl07xSla6G/nyhc6cmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37680092"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="37680092"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 00:59:34 -0800
X-CSE-ConnectionGUID: Kk47CJuSSXq0UR34RTw1OQ==
X-CSE-MsgGUID: M503/Ua1Sdi5k3LTi6rIBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="107180032"
Received: from ldmartin-desk2.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.110.77])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 00:59:33 -0800
Subject: [PATCH v2 4/5] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
 Ira Weiny <ira.weiny@intel.com>, dave.jiang@intel.com,
 Jonathan.Cameron@huawei.com
Date: Wed, 22 Jan 2025 00:59:33 -0800
Message-ID: <173753637297.3849855.5217976225600372473.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

cxl_dpa_alloc() is a hard coded nest of assumptions around PMEM
allocations being distinct from RAM allocations in specific ways when in
practice the allocation rules are only relative to DPA partition index.

The rules for cxl_dpa_alloc() are:

- allocations can only come from 1 partition

- if allocating at partition-index-N, all free space in partitions less
  than partition-index-N must be skipped over

Use the new 'struct cxl_dpa_partition' array to support allocation with
an arbitrary number of DPA partitions on the device.

A follow-on patch can go further to cleanup 'enum cxl_decoder_mode'
concept and supersede it with looking up the memory properties from
partition metadata. Until then cxl_part_mode() temporarily bridges code
that looks up partitions by @cxled->mode.

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alejandro Lucero <alucerop@amd.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |  215 +++++++++++++++++++++++++++++++++++-------------
 drivers/cxl/cxlmem.h   |   14 +++
 2 files changed, 172 insertions(+), 57 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 3f8a54ca4624..591aeb26c9e1 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -223,6 +223,31 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
 
+/* See request_skip() kernel-doc */
+static void release_skip(struct cxl_dev_state *cxlds,
+			 const resource_size_t skip_base,
+			 const resource_size_t skip_len)
+{
+	resource_size_t skip_start = skip_base, skip_rem = skip_len;
+
+	for (int i = 0; i < cxlds->nr_partitions; i++) {
+		const struct resource *part_res = &cxlds->part[i].res;
+		resource_size_t skip_end, skip_size;
+
+		if (skip_start < part_res->start || skip_start > part_res->end)
+			continue;
+
+		skip_end = min(part_res->end, skip_start + skip_rem - 1);
+		skip_size = skip_end - skip_start + 1;
+		__release_region(&cxlds->dpa_res, skip_start, skip_size);
+		skip_start += skip_size;
+		skip_rem -= skip_size;
+
+		if (!skip_rem)
+			break;
+	}
+}
+
 /*
  * Must be called in a context that synchronizes against this decoder's
  * port ->remove() callback (like an endpoint decoder sysfs attribute)
@@ -241,7 +266,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 	skip_start = res->start - cxled->skip;
 	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
 	if (cxled->skip)
-		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
+		release_skip(cxlds, skip_start, cxled->skip);
 	cxled->skip = 0;
 	cxled->dpa_res = NULL;
 	put_device(&cxled->cxld.dev);
@@ -268,6 +293,79 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 	__cxl_dpa_release(cxled);
 }
 
+/**
+ * request_skip() - Track DPA 'skip' in @cxlds->dpa_res resource tree
+ * @cxlds: CXL.mem device context that parents @cxled
+ * @cxled: Endpoint decoder establishing new allocation that skips lower DPA
+ * @skip_base: DPA < start of new DPA allocation (DPAnew)
+ * @skip_len: @skip_base + @skip_len == DPAnew
+ *
+ * DPA 'skip' arises from out-of-sequence DPA allocation events relative
+ * to free capacity across multiple partitions. It is a wasteful event
+ * as usable DPA gets thrown away, but if a deployment has, for example,
+ * a dual RAM+PMEM device, wants to use PMEM, and has unallocated RAM
+ * DPA, the free RAM DPA must be sacrificed to start allocating PMEM.
+ * See third "Implementation Note" in CXL 3.1 8.2.4.19.13 "Decoder
+ * Protection" for more details.
+ *
+ * A 'skip' always covers the last allocated DPA in a previous partition
+ * to the start of the current partition to allocate.  Allocations never
+ * start in the middle of a partition, and allocations are always
+ * de-allocated in reverse order (see cxl_dpa_free(), or natural devm
+ * unwind order from forced in-order allocation).
+ *
+ * If @cxlds->nr_partitions was guaranteed to be <= 2 then the 'skip'
+ * would always be contained to a single partition. Given
+ * @cxlds->nr_partitions may be > 2 it results in cases where the 'skip'
+ * might span "tail capacity of partition[0], all of partition[1], ...,
+ * all of partition[N-1]" to support allocating from partition[N]. That
+ * in turn interacts with the partition 'struct resource' boundaries
+ * within @cxlds->dpa_res whereby 'skip' requests need to be divided by
+ * partition. I.e. this is a quirk of using a 'struct resource' tree to
+ * detect range conflicts while also tracking partition boundaries in
+ * @cxlds->dpa_res.
+ */
+static int request_skip(struct cxl_dev_state *cxlds,
+			struct cxl_endpoint_decoder *cxled,
+			const resource_size_t skip_base,
+			const resource_size_t skip_len)
+{
+	resource_size_t skip_start = skip_base, skip_rem = skip_len;
+
+	for (int i = 0; i < cxlds->nr_partitions; i++) {
+		const struct resource *part_res = &cxlds->part[i].res;
+		struct cxl_port *port = cxled_to_port(cxled);
+		resource_size_t skip_end, skip_size;
+		struct resource *res;
+
+		if (skip_start < part_res->start || skip_start > part_res->end)
+			continue;
+
+		skip_end = min(part_res->end, skip_start + skip_rem - 1);
+		skip_size = skip_end - skip_start + 1;
+
+		res = __request_region(&cxlds->dpa_res, skip_start, skip_size,
+				       dev_name(&cxled->cxld.dev), 0);
+		if (!res) {
+			dev_dbg(cxlds->dev,
+				"decoder%d.%d: failed to reserve skipped space\n",
+				port->id, cxled->cxld.id);
+			break;
+		}
+		skip_start += skip_size;
+		skip_rem -= skip_size;
+		if (!skip_rem)
+			break;
+	}
+
+	if (skip_rem == 0)
+		return 0;
+
+	release_skip(cxlds, skip_base, skip_len - skip_rem);
+
+	return -EBUSY;
+}
+
 static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			     resource_size_t base, resource_size_t len,
 			     resource_size_t skipped)
@@ -276,7 +374,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *dev = &port->dev;
+	enum cxl_decoder_mode mode;
 	struct resource *res;
+	int rc;
 
 	lockdep_assert_held_write(&cxl_dpa_rwsem);
 
@@ -305,14 +405,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	}
 
 	if (skipped) {
-		res = __request_region(&cxlds->dpa_res, base - skipped, skipped,
-				       dev_name(&cxled->cxld.dev), 0);
-		if (!res) {
-			dev_dbg(dev,
-				"decoder%d.%d: failed to reserve skipped space\n",
-				port->id, cxled->cxld.id);
-			return -EBUSY;
-		}
+		rc = request_skip(cxlds, cxled, base - skipped, skipped);
+		if (rc)
+			return rc;
 	}
 	res = __request_region(&cxlds->dpa_res, base, len,
 			       dev_name(&cxled->cxld.dev), 0);
@@ -320,22 +415,23 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
 			port->id, cxled->cxld.id);
 		if (skipped)
-			__release_region(&cxlds->dpa_res, base - skipped,
-					 skipped);
+			release_skip(cxlds, base - skipped, skipped);
 		return -EBUSY;
 	}
 	cxled->dpa_res = res;
 	cxled->skip = skipped;
 
-	if (to_pmem_res(cxlds) && resource_contains(to_pmem_res(cxlds), res))
-		cxled->mode = CXL_DECODER_PMEM;
-	else if (to_ram_res(cxlds) && resource_contains(to_ram_res(cxlds), res))
-		cxled->mode = CXL_DECODER_RAM;
-	else {
+	mode = CXL_DECODER_NONE;
+	for (int i = 0; cxlds->nr_partitions; i++)
+		if (resource_contains(&cxlds->part[i].res, res)) {
+			mode = cxl_part_mode(cxlds->part[i].mode);
+			break;
+		}
+
+	if (mode == CXL_DECODER_NONE)
 		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
 			 port->id, cxled->cxld.id, res);
-		cxled->mode = CXL_DECODER_NONE;
-	}
+	cxled->mode = mode;
 
 	port->hdm_end++;
 	get_device(&cxled->cxld.dev);
@@ -529,15 +625,13 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	resource_size_t free_ram_start, free_pmem_start;
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *dev = &cxled->cxld.dev;
-	resource_size_t start, avail, skip;
+	struct resource *res, *prev = NULL;
+	resource_size_t start, avail, skip, skip_start;
 	struct resource *p, *last;
-	const struct resource *ram_res = to_ram_res(cxlds);
-	const struct resource *pmem_res = to_pmem_res(cxlds);
-	int rc;
+	int part, rc;
 
 	down_write(&cxl_dpa_rwsem);
 	if (cxled->cxld.region) {
@@ -553,47 +647,54 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 		goto out;
 	}
 
-	for (p = ram_res->child, last = NULL; p; p = p->sibling)
-		last = p;
-	if (last)
-		free_ram_start = last->end + 1;
-	else
-		free_ram_start = ram_res->start;
+	part = -1;
+	for (int i = 0; i < cxlds->nr_partitions; i++) {
+		if (cxled->mode == cxl_part_mode(cxlds->part[i].mode)) {
+			part = i;
+			break;
+		}
+	}
 
-	for (p = pmem_res->child, last = NULL; p; p = p->sibling)
+	if (part < 0) {
+		dev_dbg(dev, "partition %d not found\n", part);
+		rc = -EBUSY;
+		goto out;
+	}
+
+	res = &cxlds->part[part].res;
+	for (p = res->child, last = NULL; p; p = p->sibling)
 		last = p;
 	if (last)
-		free_pmem_start = last->end + 1;
+		start = last->end + 1;
 	else
-		free_pmem_start = pmem_res->start;
-
-	if (cxled->mode == CXL_DECODER_RAM) {
-		start = free_ram_start;
-		avail = ram_res->end - start + 1;
-		skip = 0;
-	} else if (cxled->mode == CXL_DECODER_PMEM) {
-		resource_size_t skip_start, skip_end;
+		start = res->start;
 
-		start = free_pmem_start;
-		avail = pmem_res->end - start + 1;
-		skip_start = free_ram_start;
-
-		/*
-		 * If some pmem is already allocated, then that allocation
-		 * already handled the skip.
-		 */
-		if (pmem_res->child &&
-		    skip_start == pmem_res->child->start)
-			skip_end = skip_start - 1;
-		else
-			skip_end = start - 1;
-		skip = skip_end - skip_start + 1;
-	} else {
-		dev_dbg(dev, "mode not set\n");
-		rc = -EINVAL;
-		goto out;
+	/*
+	 * To allocate at partition N, a skip needs to be calculated for all
+	 * unallocated space at lower partitions indices.
+	 *
+	 * If a partition has any allocations, the search can end because a
+	 * previous cxl_dpa_alloc() invocation is assumed to have accounted for
+	 * all previous partitions.
+	 */
+	skip_start = CXL_RESOURCE_NONE;
+	for (int i = part; i; i--) {
+		prev = &cxlds->part[i - 1].res;
+		for (p = prev->child, last = NULL; p; p = p->sibling)
+			last = p;
+		if (last) {
+			skip_start = last->end + 1;
+			break;
+		}
+		skip_start = prev->start;
 	}
 
+	avail = res->end - start + 1;
+	if (skip_start == CXL_RESOURCE_NONE)
+		skip = 0;
+	else
+		skip = res->start - skip_start;
+
 	if (size > avail) {
 		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
 			cxl_decoder_mode_name(cxled->mode), &avail);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 15f549afab7c..bad99456e901 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -530,6 +530,20 @@ static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
 	return resource_size(res);
 }
 
+/*
+ * Translate the operational mode of memory capacity with the
+ * operational mode of a decoder
+ * TODO: kill 'enum cxl_decoder_mode' to obviate this helper
+ */
+static inline enum cxl_decoder_mode cxl_part_mode(enum cxl_partition_mode mode)
+{
+	if (mode == CXL_PARTMODE_RAM)
+		return CXL_DECODER_RAM;
+	if (mode == CXL_PARTMODE_PMEM)
+		return CXL_DECODER_PMEM;
+	return CXL_DECODER_NONE;
+}
+
 static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
 {
 	return dev_get_drvdata(cxl_mbox->host);

