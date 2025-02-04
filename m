Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36981CAA7B
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 04:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643066; cv=none; b=qNsdP+Ze43fkXDMlzi9qCPaR/RkJlBwJ16oyHlOwYH8SKs/86pzqAwsMrFrNBgetQox89nVexMZWOTxa34F4G7GiKGpH/erePDljGxeHet/ikDsbXgQJ3lBJZPhLauB2VmJXVvffO9wvnMhNntnHM51MOHsYgqf2cemUYoRnOu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643066; c=relaxed/simple;
	bh=DGkMQyK2BVUFXfQRK/1ZVs2B3OKVzxYQs6LIdsZqlnI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j268MUK07EPPT+PGTOtvN5kuKYjtDasTB/k7Sw+qVxyzXxtOMTE+PvX3p2q+Ux/amRPNZnQ4gJt+P7oioaPeJTlIein4MbWHh81i2wb5cmHqlmb36opt/yXB7CG/LjShQUCvVcHkONHtNVtKAKD4XhlzF4nQQcjyt1N/WhbhJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eV44v4M6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eV44v4M6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738643065; x=1770179065;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DGkMQyK2BVUFXfQRK/1ZVs2B3OKVzxYQs6LIdsZqlnI=;
  b=eV44v4M6nQ8tX9dH2H8cymhc2DqHQhM8CAhIgYjer7tOJtHjNiH0BmaX
   0sV0ZIfCy8TZuWmH/jS5kXtXnD3AZ//QNz4RyWrS030znphyznPheoqve
   VMjcpH1SjlPTB8krRxJUNcg2Ej0NSozGZdqJA76/tC3oPsTpwjLbI73Gp
   /dYKjmdSgoP369cru2CjTxWgDdTjN97vy47YM8YQCFZxRvyg8Htvqwe8G
   aLzi2g4HCkBRwP/8yacIFdZv05OFhvLYBNK9D1l1dtvreuZnG3PjT8+74
   oF8ePBUyyfbUBPz7QpN9X5ZQK9be+AQ+AjXxrL6wiG8BV3frCU9IWYfas
   w==;
X-CSE-ConnectionGUID: fXwJU9cVQbm0Lc+G++KPMQ==
X-CSE-MsgGUID: VtArVcASSbqv7CowH4g2sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="39058672"
X-IronPort-AV: E=Sophos;i="6.13,257,1732608000"; 
   d="scan'208";a="39058672"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 20:24:25 -0800
X-CSE-ConnectionGUID: 4b077n2tT6eOv6vxfFJwoA==
X-CSE-MsgGUID: tqWVPxwnRJe4cItR4g8iwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114520407"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.230])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 20:24:24 -0800
Subject: [PATCH v3 4/6] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>, Alejandro Lucero <alucerop@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, dave.jiang@intel.com,
 Jonathan.Cameron@huawei.com
Date: Mon, 03 Feb 2025 20:24:24 -0800
Message-ID: <173864306400.668823.12143134425285426523.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
References: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
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

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |  199 ++++++++++++++++++++++++++++++++++--------------
 drivers/cxl/cxlmem.h   |   14 +++
 2 files changed, 156 insertions(+), 57 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ea4e792f789f..78ecb88bad7e 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -223,6 +223,37 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
 
+/* See request_skip() kernel-doc */
+static resource_size_t __adjust_skip(struct cxl_dev_state *cxlds,
+				     const resource_size_t skip_base,
+				     const resource_size_t skip_len,
+				     const char *requester)
+{
+	const resource_size_t skip_end = skip_base + skip_len - 1;
+
+	for (int i = 0; i < cxlds->nr_partitions; i++) {
+		const struct resource *part_res = &cxlds->part[i].res;
+		resource_size_t adjust_start, adjust_end, size;
+
+		adjust_start = max(skip_base, part_res->start);
+		adjust_end = min(skip_end, part_res->end);
+
+		if (adjust_end < adjust_start)
+			continue;
+
+		size = adjust_end - adjust_start + 1;
+
+		if (!requester)
+			__release_region(&cxlds->dpa_res, adjust_start, size);
+		else if (!__request_region(&cxlds->dpa_res, adjust_start, size,
+					   requester, 0))
+			return adjust_start - skip_base;
+	}
+
+	return skip_len;
+}
+#define release_skip(c, b, l) __adjust_skip((c), (b), (l), NULL)
+
 /*
  * Must be called in a context that synchronizes against this decoder's
  * port ->remove() callback (like an endpoint decoder sysfs attribute)
@@ -241,7 +272,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 	skip_start = res->start - cxled->skip;
 	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
 	if (cxled->skip)
-		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
+		release_skip(cxlds, skip_start, cxled->skip);
 	cxled->skip = 0;
 	cxled->dpa_res = NULL;
 	put_device(&cxled->cxld.dev);
@@ -268,6 +299,58 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
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
+	resource_size_t skipped = __adjust_skip(cxlds, skip_base, skip_len,
+						dev_name(&cxled->cxld.dev));
+
+	if (skipped == skip_len)
+		return 0;
+
+	dev_dbg(cxlds->dev,
+		"%s: failed to reserve skipped space (%pa %pa %pa)\n",
+		dev_name(&cxled->cxld.dev), &skip_base, &skip_len, &skipped);
+
+	release_skip(cxlds, skip_base, skipped);
+
+	return -EBUSY;
+}
+
 static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			     resource_size_t base, resource_size_t len,
 			     resource_size_t skipped)
@@ -276,7 +359,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *dev = &port->dev;
+	enum cxl_decoder_mode mode;
 	struct resource *res;
+	int rc;
 
 	lockdep_assert_held_write(&cxl_dpa_rwsem);
 
@@ -305,14 +390,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
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
@@ -320,22 +400,23 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
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
@@ -542,15 +623,13 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
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
@@ -566,47 +645,53 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
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
+
+	if (part < 0) {
+		rc = -EBUSY;
+		goto out;
+	}
 
-	for (p = pmem_res->child, last = NULL; p; p = p->sibling)
+	res = &cxlds->part[part].res;
+	for (p = res->child, last = NULL; p; p = p->sibling)
 		last = p;
 	if (last)
-		free_pmem_start = last->end + 1;
+		start = last->end + 1;
 	else
-		free_pmem_start = pmem_res->start;
+		start = res->start;
 
-	if (cxled->mode == CXL_DECODER_RAM) {
-		start = free_ram_start;
-		avail = ram_res->end - start + 1;
-		skip = 0;
-	} else if (cxled->mode == CXL_DECODER_PMEM) {
-		resource_size_t skip_start, skip_end;
-
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
index e33b2d5efed9..9fe615d96573 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -529,6 +529,20 @@ static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
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

