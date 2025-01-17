Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822F1F7069
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 06:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094253; cv=none; b=kkmFMAD4e3NhIOK49Y7dCMI5n/tTqyNxlaPLf1ylbQaYcpM/VbqmaIGF9iK72+O/Nel/ShIquydUWAp0YO/GGmB1ijOnlDzb3QJth3EOuAxYqDYriaaNShatki50XEcT7gQ4h81uzDxMY/giJTGzdQgz/Y1b424RZqs3mFkoosA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094253; c=relaxed/simple;
	bh=ljTGYzYVAQSrKCBMs5aAGlQl4yjqxOfF7oYG+cAG0zA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wa3wA2J67e7vZGFvYmt4p5ytkj1lXhAomZs4fV7qFKWsrqgeYkq2BOVz/2KQeYR9BkSRMsNj2CqilI+bnyR7zPmJWDZGW7VVxFNgDAeOdRi+RHaEi5SMS+OG44DSWmmT9jXuP0r5TaX28kaV7W485RRQq+fQpsf1TMRiCgYZLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BR4H+Ns8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BR4H+Ns8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737094251; x=1768630251;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ljTGYzYVAQSrKCBMs5aAGlQl4yjqxOfF7oYG+cAG0zA=;
  b=BR4H+Ns89xFaYEHHIwjEMoYQOyvwbv9tlm8I3uEvmUvzORBNfCDajHTf
   5yIZA2y9IPNfhcbb08iqpXbap4rAIzsiFH3MGIEy33INRUaa9RyDVblaf
   7vJH7KgeE5Ci3vZ04J53KSGGDmhjqCEQJY2lrr/pZNgsT+nNS5FbT+2P5
   duiStkzvMDFCYvxvgTM67J5r0n7FETw213lWp5XDu+zgQG0JFNy7ym2dh
   wFIirWiAkEE3zazt8k/dWhP6i/h+RUV+Y/tn4Lqoe057mcat2wow1arO8
   z9EGNQatACT+EMsnnPq5TK7XefEHaJGTeUVuj+x9cganjfprU+nzBIns/
   A==;
X-CSE-ConnectionGUID: 0i6RPwJLRmi0UtXiYuEsDw==
X-CSE-MsgGUID: XwCJZeFAQwKboS003mrzbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="41193796"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="41193796"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 22:10:51 -0800
X-CSE-ConnectionGUID: HW/tTUg2SMCM/0J8s23ipQ==
X-CSE-MsgGUID: Ks3H8wA1QAyeKlGVXguarA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109789713"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.114])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 22:10:51 -0800
Subject: [PATCH 4/4] cxl: Make cxl_dpa_alloc() DPA partition number agnostic
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
 Ira Weiny <ira.weiny@intel.com>, dave.jiang@intel.com
Date: Thu, 16 Jan 2025 22:10:50 -0800
Message-ID: <173709425022.753996.16667967718406367188.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
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
partition metadata.

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alejandro Lucero <alucerop@amd.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |  167 +++++++++++++++++++++++++++++++++---------------
 drivers/cxl/cxlmem.h   |    9 +++
 2 files changed, 125 insertions(+), 51 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7e1559b3ed88..4a2816102a1e 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -223,6 +223,30 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
 
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
@@ -241,7 +265,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 	skip_start = res->start - cxled->skip;
 	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
 	if (cxled->skip)
-		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
+		release_skip(cxlds, skip_start, cxled->skip);
 	cxled->skip = 0;
 	cxled->dpa_res = NULL;
 	put_device(&cxled->cxld.dev);
@@ -268,6 +292,47 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 	__cxl_dpa_release(cxled);
 }
 
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
@@ -277,6 +342,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *dev = &port->dev;
 	struct resource *res;
+	int rc;
 
 	lockdep_assert_held_write(&cxl_dpa_rwsem);
 
@@ -305,14 +371,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
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
@@ -320,16 +381,15 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
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
 
-	if (resource_contains(to_pmem_res(cxlds), res))
+	if (cxl_partition_contains(cxlds, CXL_PARTITION_PMEM, res))
 		cxled->mode = CXL_DECODER_PMEM;
-	else if (resource_contains(to_ram_res(cxlds), res))
+	else if (cxl_partition_contains(cxlds, CXL_PARTITION_RAM, res))
 		cxled->mode = CXL_DECODER_RAM;
 	else {
 		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
@@ -527,15 +587,13 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
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
@@ -551,47 +609,54 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 		goto out;
 	}
 
-	for (p = ram_res->child, last = NULL; p; p = p->sibling)
-		last = p;
-	if (last)
-		free_ram_start = last->end + 1;
+	if (cxled->mode == CXL_DECODER_RAM)
+		part = CXL_PARTITION_RAM;
+	else if (cxled->mode == CXL_DECODER_PMEM)
+		part = CXL_PARTITION_PMEM;
 	else
-		free_ram_start = ram_res->start;
+		part = cxlds->nr_partitions;
+
+	if (part >= cxlds->nr_partitions) {
+		dev_dbg(dev, "partition %d not found\n", part);
+		rc = -EBUSY;
+		goto out;
+	}
+
+	res = &cxlds->part[part].res;
 
-	for (p = pmem_res->child, last = NULL; p; p = p->sibling)
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
index 2e728d4b7327..43acd48b300f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -515,6 +515,15 @@ static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
 	return resource_size(res);
 }
 
+static inline bool cxl_partition_contains(struct cxl_dev_state *cxlds,
+					  unsigned int part,
+					  struct resource *res)
+{
+	if (part >= cxlds->nr_partitions)
+		return false;
+	return resource_contains(&cxlds->part[part].res, res);
+}
+
 static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
 {
 	return dev_get_drvdata(cxl_mbox->host);

