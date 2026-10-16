Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B51A3E3DA7;
	Fri, 16 Oct 2026 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190144; cv=none; b=sW7mU8bhOxfs1SkWhpWbRzApX5R7uSnBAOXWFBzfTkqF4WL8xo6GrEoC9SUY8zHLL2/SwC10jGziYO2zQCi5Saa3gL/CeabEcIzLjHLW2Om543iVq0ts9gABn8SBXDsdrPq1wEnBXt2Wl9imu+08MBCLSajX9/jbRqvdkIQl3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190144; c=relaxed/simple;
	bh=Pdv+NxhLM0cVhwBnzGUnuhMjGfWdC/0s3ezaMKS15hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJ3UQ06By3luuZgjIu7bXc6vxZNbJ32PUXoLP6SSnHUjrIO5EpjXHaXmb50jx1M5e+mPMah9SmrCphK4gDVIYmRbyt4HN9ktumUIJges3tRjEWGbzsHCsSSkMO6J8GsBSVboK9DNQrW+/SsnvTVPEQ5h6iefHx3kTE3nveXBxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbOApN5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbOApN5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00861F000C4;
	Fri, 16 Oct 2026 22:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792190142;
	bh=koD97Vv2RYamT9rN9MXKPLQgXJvKwvWeT6gBi9Nqxq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EbOApN5vLmmkI7IJZpButnxPBgRf4rcgdHycHn1yb6VzYpakZNKZr4veISSzhcWrD
	 S8LQmXccykbzt9guSeCWWbChQIfsR9qRfYQ5MfpKwn4yVJVN8wJUzVc6aHNLskoQg5
	 RDBcjWjP8HJaqnUEjZXYTdQfbzaHAZvE2BFdxC6XI25aviqlrj4kL4xlJx4HiSKRo/
	 3JkFWV02BIw6dpfnvZrbLhs7q6DLcMcVB+eLTx/dfD0oUlZUlF904gpCdwCxFRsfQt
	 vy9pCudmdvohqYbuN/UjF4pxhlQtVQarfshkOFHomb9cj/ThG7etT6xH9ussq8j2YW
	 wOufjIoqa/wCA==
Date: Fri, 16 Oct 2026 23:35:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Miaohe Lin
 <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Breno Leitao <leitao@debian.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
 <icheng@nvidia.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan
 Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand
 <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, Kiryl Shutsemau
 <kas@kernel.org>, Harry Yoo <harry@kernel.org>
Subject: Re: [RFC PATCH 5/5] cxl/region: Register device poison before
 exposing RAM
Message-ID: <20261016233532.51766fc4@jic23-hlaptop>
In-Reply-To: <20261010162017.62506-6-shaikhkamal2012@gmail.com>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
	<20261010162017.62506-6-shaikhkamal2012@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 21:50:13 +0530
Shaikh Kamaluddin <shaikhkamal2012@gmail.com> wrote:

> The trigger_poison_list interface may retrieve poison after CXL memory
> is already online, which is too late to prevent known-bad frames from
> entering the page allocator.
> 
> During RAM-region probe, retrieve a poison-list snapshot for each
> participating endpoint decoder. Validate each record against the
> decoder's assigned DPA range, translate its poisoned DPA units to HPA
> and PFN, and collect the affected PFNs in an xarray. Coalesce consecutive
> PFNs and register the resulting ranges with the pre-online hwpoison
> registry before creating the DAX region.
> 
> When Get Poison List is supported, abort region probe if the list is
> incomplete, malformed, or cannot be translated. If volatile poison-list
> retrieval is unsupported, preserve the existing behavior and warn that
> poison cannot be withheld before memory onlining.
> 
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
A few comments inline.  I wouldn't rush to revise this though as I think
the whole concept needs more input from others.

Jonathan

> ---
>  drivers/cxl/core/region.c | 322 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 322 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c72524923b38..e3ffa77927df 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -14,6 +14,7 @@
>  #include <linux/string_choices.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> +#include <linux/memory-failure.h>
>  #include "core.h"
>  #include "mce.h"
>  
> @@ -3038,6 +3039,323 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  	return rc;
>  }
>  
> +/*
> + * Device-reported poison is gathered at RAM-region probe, before the range
> + * reaches dax/kmem, and registered with the pre-online registry so the
> + * frames it covers are withheld when the memory is onlined.
> + */
> +static int cxl_poison_store_pfn(struct xarray *pfns, u64 hpa)
> +{
> +	return xa_err(xa_store(pfns, PHYS_PFN(hpa), xa_mk_value(1),
> +			GFP_KERNEL));

Fix alignment of the line above. Right now it isn't visually clear
which function call the parameter is for.

> +}

> +static int cxl_poison_record_to_pfns(struct cxl_region *cxlr,
> +				     struct cxl_memdev *cxlmd,
> +				     const struct cxl_poison_record *record,
> +				     struct xarray *pfns)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	u64 raw = le64_to_cpu(record->address);
> +	u64 units = le32_to_cpu(record->length);
> +	u64 dpa = raw & CXL_POISON_START_MASK;
> +	u8 source = raw & CXL_POISON_SOURCE_MASK;
> +	u64 length, end, step, cur;
> +
> +	if (!units ||
> +	    check_mul_overflow(units, (u64)CXL_POISON_LEN_MULT, &length) ||
> +	    check_add_overflow(dpa, length, &end))
> +		return -EPROTO;
> +
> +	/*
> +	 * A corrected error never reaches the poison list, so every record
> +	 * is uncorrectable. Only a failure of the device's own media is
> +	 * withheld: External poison was written by the host into healthy
> +	 * media and a rewrite or Clear Poison recovers it, and Injected
> +	 * poison is a test artifact. Withholding either would make a
> +	 * recoverable state permanent.

This reflects back to the comment I made in the cover letter.
Device discovered poison can be ephemeral.  I'm also not sure for volatile
where any poison record would come from if you are doing this for newly 
powered up devices - they might scan whilst initializing but might not as
that is very very slow to do.  Typically poison is found much later by
patrol scrub (or synchronous read).  This may be more interesting for
persistent memory where the persistence is used, but you aren't addressing
that as far as I can tell.

> +	 */
> +	if (source != CXL_POISON_SOURCE_INTERNAL) {
> +		dev_dbg(&cxlr->dev, "%s: dpa %#llx source %u not withheld\n",
> +			dev_name(&cxlmd->dev), dpa, source);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Translate once per unit of HPA contiguity rather than per 64
> +	 * bytes. Consecutive DPAs within an interleave granule map to
> +	 * consecutive HPAs, and a granule no larger than a page lies within
> +	 * one page, so stepping by min(granule, PAGE_SIZE) from an aligned
> +	 * start reaches every page the record covers.
> +	 */
> +	step = clamp_t(u64, p->interleave_granularity, CXL_POISON_LEN_MULT,
> +		       PAGE_SIZE);
> +
> +	for (cur = ALIGN_DOWN(dpa, step); cur < end; cur += step) {
> +		u64 hpa = cxl_dpa_to_hpa(cxlr, cxlmd, max(cur, dpa));
> +		int rc;
> +
> +		/* Not mapped by this region; nothing here to withhold. */
> +		if (hpa == ULLONG_MAX)
> +			continue;
> +
> +		rc = cxl_poison_store_hpa(cxlr, pfns, hpa);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_region_collect_decoder_poison(struct cxl_region *cxlr,
> +					     struct cxl_endpoint_decoder *cxled,
> +					     struct xarray *pfns)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_poison_snapshot snapshot;
> +	int rc;
> +
> +	rc = cxl_poison_snapshot_init(cxlmd, &snapshot);
> +	if (rc == -EOPNOTSUPP) {
> +		dev_info(&cxlr->dev,
> +			 "%s: no Get Poison List support, nothing withheld\n",
> +			 dev_name(&cxlmd->dev));
> +		return 0;
> +	}
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_get_poison_by_decoder(cxled, &snapshot,
> +				       CXL_POISON_QUERY_PREONLINE);
> +	if (rc == -EFAULT) {
> +		/*
> +		 * The device keeps no poison list for volatile ranges, which
> +		 * CXL r3.2 8.2.9.8.4.1 permits. Online the region as today.

Use latest available spec for references (they don't make old ones easy
to download!)

> +		 */
> +		dev_info(&cxlr->dev,
> +			 "%s: no volatile poison list, nothing withheld\n",
> +			 dev_name(&cxlmd->dev));
too noisy.

> +		rc = 0;
> +		goto out;
> +	}
> +	if (rc)
> +		goto out;
> +
> +	/*
> +	 * Withholding from a partial list would online the region on the
> +	 * belief that every bad frame had been named.
> +	 */
> +	if (snapshot.truncated ||
> +	    (snapshot.device_flags & CXL_POISON_FLAG_OVERFLOW)) {
> +		dev_err(&cxlr->dev, "%s: poison list incomplete\n",
> +			dev_name(&cxlmd->dev));
> +		rc = -EOVERFLOW;
> +		goto out;
> +	}
> +	if (snapshot.device_flags & CXL_POISON_FLAG_SCANNING) {

That one seems wrong. We don't prevent memory from coming online because
there might be poison to be found.

> +		dev_err(&cxlr->dev, "%s: media scan in progress\n",
> +			dev_name(&cxlmd->dev));
> +		rc = -EBUSY;
> +		goto out;
> +	}
> +
> +	for (u32 i = 0; i < snapshot.nr_records; i++) {
> +		rc = cxl_poison_record_to_pfns(cxlr, cxlmd,
> +					       &snapshot.records[i], pfns);
> +		if (rc)
> +			break;
> +	}
> +out:
> +	cxl_poison_snapshot_destroy(&snapshot);
> +	return rc;
> +}
> +
> +static unsigned int cxl_count_poison_ranges(struct xarray *pfns)
> +{
> +	unsigned long index, previous = 0;
> +	unsigned int nr = 0;
> +	void *entry;
> +	bool first = true;
> +
> +	xa_for_each(pfns, index, entry) {
> +		if (first || index != previous + 1)
> +			nr++;
> +		first = false;
> +		previous = index;
> +	}
> +	return nr;
> +}
> +
> +/*
> + * The xarray holds each PFN once and xa_for_each() walks them in ascending
> + * order, so runs of consecutive indices are exactly the sorted,
> + * nonoverlapping ranges preonline_hwpoison_register() requires.
> + */
> +static int cxl_pfns_to_ranges(struct xarray *pfns,
> +			      struct preonline_hwpoison_range **ranges_out,
> +			      unsigned int *nr_ranges_out)
> +{
> +	struct preonline_hwpoison_range *ranges;
> +	unsigned long index, previous = 0, run_start = 0;
> +	unsigned int nr_ranges, nr = 0;
> +	void *entry;
> +	bool first = true;
> +
> +	nr_ranges = cxl_count_poison_ranges(pfns);
> +	if (!nr_ranges) {
> +		*ranges_out = NULL;
> +		*nr_ranges_out = 0;
> +		return 0;
> +	}
> +
> +	ranges = kvmalloc_array(nr_ranges, sizeof(*ranges), GFP_KERNEL);

kvmalloc_objs()

> +	if (!ranges)
> +		return -ENOMEM;
> +
> +	xa_for_each(pfns, index, entry) {
> +		if (first) {
> +			run_start = index;
> +			previous = index;
> +			first = false;
> +			continue;
> +		}
> +		if (index == previous + 1) {
> +			previous = index;
> +			continue;
> +		}
> +		ranges[nr++] = (struct preonline_hwpoison_range) {
> +			.start_pfn = run_start,
> +			.nr_pages = previous - run_start + 1,
> +		};
> +		run_start = index;
> +		previous = index;
> +	}
> +	ranges[nr++] = (struct preonline_hwpoison_range){
> +		.start_pfn = run_start,
> +		.nr_pages = previous - run_start + 1,
> +	};
> +
> +	WARN_ON_ONCE(nr != nr_ranges);
> +	*ranges_out = ranges;
> +	*nr_ranges_out = nr;
> +	return 0;
> +}
> +
> +static void cxl_unregister_device_poison(void *data)
> +{
> +	preonline_hwpoison_unregister(data);
> +}
> +
> +static int cxl_region_register_device_poison(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct preonline_hwpoison_range *ranges = NULL;
> +	struct preonline_hwpoison *handle;
> +	unsigned int nr_ranges = 0;
> +	unsigned long nr_frames = 0;
> +	struct xarray pfns;
> +	int rc = 0;
> +
> +	lockdep_assert_held(&cxl_rwsem.region);
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +
> +	/* The region may have been decommitted while the lock was dropped. */
> +	if (p->state < CXL_CONFIG_COMMIT)
> +		return -ENXIO;
> +
> +	if (test_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags)) {
> +		dev_info(&cxlr->dev,
> +			 "normalized addressing, poison not translated\n");
> +		return 0;
> +	}
> +
> +	xa_init(&pfns);
> +
> +	for (int i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +		if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> +			continue;
> +		rc = cxl_region_collect_decoder_poison(cxlr, cxled, &pfns);
> +		if (rc)
> +			goto out;
> +	}
> +
> +	if (xa_empty(&pfns))
> +		goto out;
> +
> +	rc = cxl_pfns_to_ranges(&pfns, &ranges, &nr_ranges);
> +	if (rc)
> +		goto out;
> +
> +	rc = preonline_hwpoison_register(ranges, nr_ranges, &handle);
> +	if (rc == -EOPNOTSUPP) {
> +		/* No poison tracking in this kernel; nothing to withhold. */
> +		rc = 0;
> +		goto out;
> +	}
> +	if (rc)
> +		goto out;
> +
> +	for (unsigned int i = 0; i < nr_ranges; i++)
> +		nr_frames += ranges[i].nr_pages;
> +	dev_warn(&cxlr->dev,
> +		 "withholding %lu frame(s) reported poisoned by the device\n",
> +		 nr_frames);
> +
> +	rc = devm_add_action_or_reset(&cxlr->dev, cxl_unregister_device_poison,
> +				      handle);
> +out:
> +	kvfree(ranges);
> +	xa_destroy(&pfns);
> +	return rc;
> +}


