Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC2A33B96B
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649314; cv=none; b=UdJizxL4ot0oB7b7AgJ9SxlPHC9yvldlPheuPQ+Bs/EOL6AxPixMua3QgbA0H/R3/tzIpjMfJ3xthyBt3kkNUi+iZSrJyPQpa20gqvCuns6VQben1hPrlNwVgfYwdgiQpvCCcFxJAy4lni6xwVIZHclVYek8pr/r/75+uKBvLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649314; c=relaxed/simple;
	bh=kyUQzaZAkXIMjQQNj6mfpXkpo9j+dtKoE9ytze1hIig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFFUSnunxUQLFZ+L1CHLVLp3lk+hM3fFxeGIfN4WINUd6q2tdWV6S+3c1VROBnQZUmFVOKdOFIVTRETyJflW7GjHikRoLqj5xe/9WyIZ8Zic0Jw3Fo+AcpLDMFAY5FwStmqFSZsHf4jpZxYXGn81SRdXLykT5xjOs9Ordoe8JUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sen4iuil; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sen4iuil"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30b6dad2382so1503769eec.0
        for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791649312; x=1792254112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+tttsdNRPkGTFHD+cQkqcfUTsQCG7wUbwOdSg+1Yvk=;
        b=Sen4iuila7P/tpIdL5z5AYcdygr/f3aDBYue+ebd0R7mvsxT//jFCYDuzXj0OMnv5+
         GxO/dZxPJR6fzTIsDs755Wu35SUF7i4Lk13bax+HLarAih6jaQ8TVglX3Zdj0j9QKhXz
         rEDkl9Uqm4KgtqUDLpnMSoOAXKvvBrZ6PVRyMf8JgdNUdfNBrda21EeFfzrVxxp+Nt5S
         /hZmanJSiX6H5KYLO1dMlw1DVCeomrARqpFo89H2FzJkCluaOOYLyXzOkgDlPNuLilo8
         L5/SjwrClGu4nn/pGmK3Khs1qyLldbpM9ARAmjtAQCRTRtQANrHwY9pZmhYxXVigraAz
         2Vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791649312; x=1792254112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f+tttsdNRPkGTFHD+cQkqcfUTsQCG7wUbwOdSg+1Yvk=;
        b=2lw23WdrNZNI78x3vSDOIiXcg6rYr+vrG+8NPmrR/j3w4ewGuxqyRvYP0SVnsr1vb3
         EcU9WAc3mRsPRM1/obBeetWqbBgWflLrpM999jpqfdTjWx3sO95TWfhFd6A6Ifg+z+jC
         4/9JwQetxP0Nofn/xcGucla1Fdy5aiDubJt29lv1BXGdAe1g84QAChkh2fUrEbAPPJWP
         UYy7wcNNR6dBlhbSC5fKjShr8z2WvcVoD7DL52LRc1Jpw6C8kOvIqTEhNDl1BV1YOtUd
         6w1kpWCAKmMAESIzy0/kT+BKSTppsyf7RUyG1jPqiWSWIGfEZg0WkuxPCO+hjV8BKJ2X
         PPuQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlhAe9kB8q8rLHUP57qNi0qvOemmtyfdV4DKBHS/PVYwHx64jkXpKNeP5VLnQcAa2QhVBRcA1MzTY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIq7my7lpB0SubS/wg7CbE3Vg2u0LW8FJORCOjCm1sUIyg8C1J
	/1aQhzkyqnA4lcuyVbnwqH7JP0GdthCNJq5uQFFxapLv+LEI2FE9ESDZ
X-Gm-Gg: AYBFou1pPtAxWkVNQkfX9Lil5Ll1xyKurSHRXIXvbP93wURTh93lLTZ748HD4gA7yqU
	oa3/xWINTfjxNariTupC6ZA+PpD9q1/sshkTrE0Vg/IcKIdLwxgLqzdI7jMzh32S6kwTVRsW4hs
	kQ1Cl+Pq/LTC5akj0whxXugZ7nh7fP8begv3IuEEZ9Tr74mvrE41r6Tz9Fhzu6Hh/OLsCtMbZfW
	nIIx1HbwdcHuhmv2g6rA4K9eTdm57Oiq0kXZcRNgbB+IR+g4BPzfBsNR9g717awYm/n2ZU3Ghud
	ktqmtXiUDeUpFGlb9urj0Uo9J+cLZNkeqreqR1xVOXXmyq4q0wqmKyluLLtBLbtmx7ntj2QQz8t
	rWYUHLVaWGMHDNN2VrFxLj8ZUqOxuTk5LpEH4yY1yNs65X7DU9SE5cVx6YqRbOuN3mHd8ddXa1A
	0Dr7ZPvUKlXVJphHN8L9LSIR/gxpO7AN9hOy1yqYJzym7sfLMeIoLDfzfHs/WeOlbiKYmkKo0zs
	UB1koisp3eEdniJ+A==
X-Received: by 2002:a05:7022:28f:b0:14f:99a2:1715 with SMTP id a92af1059eb24-16a612bc067mr7503413c88.39.1791649312371;
        Sat, 10 Oct 2026 09:21:52 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([115.96.176.39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a3f6186fsm15778622c88.14.2026.10.10.09.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 09:21:51 -0700 (PDT)
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Breno Leitao <leitao@debian.org>
Cc: Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Kiryl Shutsemau <kas@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Subject: [RFC PATCH 5/5] cxl/region: Register device poison before exposing RAM
Date: Sat, 10 Oct 2026 21:50:13 +0530
Message-ID: <20261010162017.62506-6-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trigger_poison_list interface may retrieve poison after CXL memory
is already online, which is too late to prevent known-bad frames from
entering the page allocator.

During RAM-region probe, retrieve a poison-list snapshot for each
participating endpoint decoder. Validate each record against the
decoder's assigned DPA range, translate its poisoned DPA units to HPA
and PFN, and collect the affected PFNs in an xarray. Coalesce consecutive
PFNs and register the resulting ranges with the pre-online hwpoison
registry before creating the DAX region.

When Get Poison List is supported, abort region probe if the list is
incomplete, malformed, or cannot be translated. If volatile poison-list
retrieval is unsupported, preserve the existing behavior and warn that
poison cannot be withheld before memory onlining.

Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
---
 drivers/cxl/core/region.c | 322 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 322 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c72524923b38..e3ffa77927df 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -14,6 +14,7 @@
 #include <linux/string_choices.h>
 #include <cxlmem.h>
 #include <cxl.h>
+#include <linux/memory-failure.h>
 #include "core.h"
 #include "mce.h"
 
@@ -3038,6 +3039,323 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
 	return rc;
 }
 
+/*
+ * Device-reported poison is gathered at RAM-region probe, before the range
+ * reaches dax/kmem, and registered with the pre-online registry so the
+ * frames it covers are withheld when the memory is onlined.
+ */
+static int cxl_poison_store_pfn(struct xarray *pfns, u64 hpa)
+{
+	return xa_err(xa_store(pfns, PHYS_PFN(hpa), xa_mk_value(1),
+			GFP_KERNEL));
+}
+
+static int cxl_poison_store_hpa(struct cxl_region *cxlr, struct xarray *pfns,
+				u64 hpa)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int rc;
+
+	/* Outside this region: not ours to withhold. */
+	if (!cxl_resource_contains_addr(p->res, hpa))
+		return -ERANGE;
+
+	rc = cxl_poison_store_pfn(pfns, hpa);
+	if (rc || !p->cache_size)
+		return rc;
+
+	/*
+	 * An extended linear cache makes the same DPA visible a second time
+	 * at hpa - cache_size. Match the translation used by the
+	 * cxl_general_media and cxl_dram trace events.
+	 */
+	if (WARN_ON_ONCE(hpa < p->res->start + p->cache_size))
+		return -ERANGE;
+
+	return cxl_poison_store_pfn(pfns, hpa - p->cache_size);
+}
+
+static int cxl_poison_record_to_pfns(struct cxl_region *cxlr,
+				     struct cxl_memdev *cxlmd,
+				     const struct cxl_poison_record *record,
+				     struct xarray *pfns)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	u64 raw = le64_to_cpu(record->address);
+	u64 units = le32_to_cpu(record->length);
+	u64 dpa = raw & CXL_POISON_START_MASK;
+	u8 source = raw & CXL_POISON_SOURCE_MASK;
+	u64 length, end, step, cur;
+
+	if (!units ||
+	    check_mul_overflow(units, (u64)CXL_POISON_LEN_MULT, &length) ||
+	    check_add_overflow(dpa, length, &end))
+		return -EPROTO;
+
+	/*
+	 * A corrected error never reaches the poison list, so every record
+	 * is uncorrectable. Only a failure of the device's own media is
+	 * withheld: External poison was written by the host into healthy
+	 * media and a rewrite or Clear Poison recovers it, and Injected
+	 * poison is a test artifact. Withholding either would make a
+	 * recoverable state permanent.
+	 */
+	if (source != CXL_POISON_SOURCE_INTERNAL) {
+		dev_dbg(&cxlr->dev, "%s: dpa %#llx source %u not withheld\n",
+			dev_name(&cxlmd->dev), dpa, source);
+		return 0;
+	}
+
+	/*
+	 * Translate once per unit of HPA contiguity rather than per 64
+	 * bytes. Consecutive DPAs within an interleave granule map to
+	 * consecutive HPAs, and a granule no larger than a page lies within
+	 * one page, so stepping by min(granule, PAGE_SIZE) from an aligned
+	 * start reaches every page the record covers.
+	 */
+	step = clamp_t(u64, p->interleave_granularity, CXL_POISON_LEN_MULT,
+		       PAGE_SIZE);
+
+	for (cur = ALIGN_DOWN(dpa, step); cur < end; cur += step) {
+		u64 hpa = cxl_dpa_to_hpa(cxlr, cxlmd, max(cur, dpa));
+		int rc;
+
+		/* Not mapped by this region; nothing here to withhold. */
+		if (hpa == ULLONG_MAX)
+			continue;
+
+		rc = cxl_poison_store_hpa(cxlr, pfns, hpa);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int cxl_region_collect_decoder_poison(struct cxl_region *cxlr,
+					     struct cxl_endpoint_decoder *cxled,
+					     struct xarray *pfns)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_poison_snapshot snapshot;
+	int rc;
+
+	rc = cxl_poison_snapshot_init(cxlmd, &snapshot);
+	if (rc == -EOPNOTSUPP) {
+		dev_info(&cxlr->dev,
+			 "%s: no Get Poison List support, nothing withheld\n",
+			 dev_name(&cxlmd->dev));
+		return 0;
+	}
+	if (rc)
+		return rc;
+
+	rc = cxl_get_poison_by_decoder(cxled, &snapshot,
+				       CXL_POISON_QUERY_PREONLINE);
+	if (rc == -EFAULT) {
+		/*
+		 * The device keeps no poison list for volatile ranges, which
+		 * CXL r3.2 8.2.9.8.4.1 permits. Online the region as today.
+		 */
+		dev_info(&cxlr->dev,
+			 "%s: no volatile poison list, nothing withheld\n",
+			 dev_name(&cxlmd->dev));
+		rc = 0;
+		goto out;
+	}
+	if (rc)
+		goto out;
+
+	/*
+	 * Withholding from a partial list would online the region on the
+	 * belief that every bad frame had been named.
+	 */
+	if (snapshot.truncated ||
+	    (snapshot.device_flags & CXL_POISON_FLAG_OVERFLOW)) {
+		dev_err(&cxlr->dev, "%s: poison list incomplete\n",
+			dev_name(&cxlmd->dev));
+		rc = -EOVERFLOW;
+		goto out;
+	}
+	if (snapshot.device_flags & CXL_POISON_FLAG_SCANNING) {
+		dev_err(&cxlr->dev, "%s: media scan in progress\n",
+			dev_name(&cxlmd->dev));
+		rc = -EBUSY;
+		goto out;
+	}
+
+	for (u32 i = 0; i < snapshot.nr_records; i++) {
+		rc = cxl_poison_record_to_pfns(cxlr, cxlmd,
+					       &snapshot.records[i], pfns);
+		if (rc)
+			break;
+	}
+out:
+	cxl_poison_snapshot_destroy(&snapshot);
+	return rc;
+}
+
+static unsigned int cxl_count_poison_ranges(struct xarray *pfns)
+{
+	unsigned long index, previous = 0;
+	unsigned int nr = 0;
+	void *entry;
+	bool first = true;
+
+	xa_for_each(pfns, index, entry) {
+		if (first || index != previous + 1)
+			nr++;
+		first = false;
+		previous = index;
+	}
+	return nr;
+}
+
+/*
+ * The xarray holds each PFN once and xa_for_each() walks them in ascending
+ * order, so runs of consecutive indices are exactly the sorted,
+ * nonoverlapping ranges preonline_hwpoison_register() requires.
+ */
+static int cxl_pfns_to_ranges(struct xarray *pfns,
+			      struct preonline_hwpoison_range **ranges_out,
+			      unsigned int *nr_ranges_out)
+{
+	struct preonline_hwpoison_range *ranges;
+	unsigned long index, previous = 0, run_start = 0;
+	unsigned int nr_ranges, nr = 0;
+	void *entry;
+	bool first = true;
+
+	nr_ranges = cxl_count_poison_ranges(pfns);
+	if (!nr_ranges) {
+		*ranges_out = NULL;
+		*nr_ranges_out = 0;
+		return 0;
+	}
+
+	ranges = kvmalloc_array(nr_ranges, sizeof(*ranges), GFP_KERNEL);
+	if (!ranges)
+		return -ENOMEM;
+
+	xa_for_each(pfns, index, entry) {
+		if (first) {
+			run_start = index;
+			previous = index;
+			first = false;
+			continue;
+		}
+		if (index == previous + 1) {
+			previous = index;
+			continue;
+		}
+		ranges[nr++] = (struct preonline_hwpoison_range) {
+			.start_pfn = run_start,
+			.nr_pages = previous - run_start + 1,
+		};
+		run_start = index;
+		previous = index;
+	}
+	ranges[nr++] = (struct preonline_hwpoison_range){
+		.start_pfn = run_start,
+		.nr_pages = previous - run_start + 1,
+	};
+
+	WARN_ON_ONCE(nr != nr_ranges);
+	*ranges_out = ranges;
+	*nr_ranges_out = nr;
+	return 0;
+}
+
+static void cxl_unregister_device_poison(void *data)
+{
+	preonline_hwpoison_unregister(data);
+}
+
+static int cxl_region_register_device_poison(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct preonline_hwpoison_range *ranges = NULL;
+	struct preonline_hwpoison *handle;
+	unsigned int nr_ranges = 0;
+	unsigned long nr_frames = 0;
+	struct xarray pfns;
+	int rc = 0;
+
+	lockdep_assert_held(&cxl_rwsem.region);
+	lockdep_assert_held(&cxl_rwsem.dpa);
+
+	/* The region may have been decommitted while the lock was dropped. */
+	if (p->state < CXL_CONFIG_COMMIT)
+		return -ENXIO;
+
+	if (test_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags)) {
+		dev_info(&cxlr->dev,
+			 "normalized addressing, poison not translated\n");
+		return 0;
+	}
+
+	xa_init(&pfns);
+
+	for (int i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+
+		if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
+			continue;
+		rc = cxl_region_collect_decoder_poison(cxlr, cxled, &pfns);
+		if (rc)
+			goto out;
+	}
+
+	if (xa_empty(&pfns))
+		goto out;
+
+	rc = cxl_pfns_to_ranges(&pfns, &ranges, &nr_ranges);
+	if (rc)
+		goto out;
+
+	rc = preonline_hwpoison_register(ranges, nr_ranges, &handle);
+	if (rc == -EOPNOTSUPP) {
+		/* No poison tracking in this kernel; nothing to withhold. */
+		rc = 0;
+		goto out;
+	}
+	if (rc)
+		goto out;
+
+	for (unsigned int i = 0; i < nr_ranges; i++)
+		nr_frames += ranges[i].nr_pages;
+	dev_warn(&cxlr->dev,
+		 "withholding %lu frame(s) reported poisoned by the device\n",
+		 nr_frames);
+
+	rc = devm_add_action_or_reset(&cxlr->dev, cxl_unregister_device_poison,
+				      handle);
+out:
+	kvfree(ranges);
+	xa_destroy(&pfns);
+	return rc;
+}
+
+static int cxl_region_scan_device_poison(struct cxl_region *cxlr)
+{
+	int rc;
+
+	/* Nothing would consume the result. */
+	if (!IS_ENABLED(CONFIG_MEMORY_FAILURE))
+		return 0;
+
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem);
+	if (rc)
+		return rc;
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem);
+	if (rc)
+		return rc;
+
+	return cxl_region_register_device_poison(cxlr);
+}
+
 struct cxl_dpa_to_region_context {
 	struct cxl_region *cxlr;
 	u64 dpa;
@@ -4262,6 +4580,10 @@ static int cxl_region_probe(struct device *dev)
 					p->res->start, p->res->end, cxlr,
 					is_system_ram) > 0)
 			return 0;
+		rc = cxl_region_scan_device_poison(cxlr);
+		if (rc)
+			return rc;
+
 		return devm_cxl_add_dax_region(cxlr);
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
-- 
2.43.0

