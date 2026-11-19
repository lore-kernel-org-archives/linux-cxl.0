Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120961;
	b=PV5ZntseIEacfCtUA26tnzZ7LsOgsMItx0zSlp3EHLxvTxcekDSLXMRz/CuczbpKpihW
	 hhxXsijtV/H5Eo2NJXSnTfecgNOuivGwP+PfV+3xiD0YE9/JLhq1r3gMDls9uL/kQedxY
	 yMDPM8ZJubvGoi8rKkI1LpjirRzlvRpJxzuAe6uW+fkc7pXJs2cyumuei3vGU2yl0Zkew
	 NCLGi7EDfj3BIR00mTm3yuyL1u2MqxTXwWWihoph9KD1oUePPH7czaxPl4SJgC4eRctK4
	 g/Jf0hdu0DyoVjkE/UmDGvZ1wY0zYaB4l7ShVo9XEwQ0fr1RgNSm2bLYWe9HtspVsVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZBFQR7u8Ee3YVRPu1eQVodXE/UpYLg54xCAcuhe+MAs=;
	b=0PC4BYJ60X0kOQQqQJgz61wJ7yHztTvXFPImaYycw6j8jhyz5IhvD0qy9nz4pQTvl0bP
	 QEu7VNcRTx5aUzaDmQnx8Fj9aMT4fqehlEvwCS9LJVVefylWlJKFh1ul7nCaU1qomeRSr
	 asFZ3T3N2j+PAW6Oeg5tIOEGQqXh8Nwb/Hwj0drHerPCAGREqTjEM+7rtrvt0mVJjhVlO
	 9VInUaPsrtYThvtI8JIHEnVMlg25pfz7DE+iFSI/tLaIYcFCuajtVObPIBL+JoH8sNTMe
	 wfegt/JnGJQi3CNL2GbOjyFB5uu/sYDxIY8YnfmjrYYyhC3hKqxHWwTYdEJujqiaEwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aE6sIri7;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E0606B76D
	for <linux-cxl@vger.kernel.org>; Thu, 19 Nov 2026 20:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E8E0606B76D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aE6sIri7
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-38587f3de36so131641eec.0
        for <linux-cxl@vger.kernel.org>; Thu, 19 Nov 2026 12:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795120960; x=1795725760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZBFQR7u8Ee3YVRPu1eQVodXE/UpYLg54xCAcuhe+MAs=;
        b=aE6sIri7PZ2O/cNz8ffteNa/iaPenFBW/4KsA6dbejNcO+T5cplXyqluJA/UZyEdKQ
         uAkOTsVvXXiONT6yGDBljiQ097E+0/MtfqurKtc90inEuaW91wBbUDoH3uIzpq8dxtbq
         Ke8dLeSmK4bYjr9qi3qC3UEDOmFHj+0tkequohf5G8AJ/n0Ns5WNvbz9Hpep7o3i96Gq
         g9NhXhSkM/+BuW1uTcLttyOjlwf8mghs9w4tyu+YbPSTzDk0q1mudOA3Xn+4HXgjJ4dZ
         kkyfPmcy4Ny90JknpXSza1CDqOKVpzsYFR9TuyVerWoRMYRIo4zVOfDJU9IJz+2bnV1B
         NtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795120960; x=1795725760;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZBFQR7u8Ee3YVRPu1eQVodXE/UpYLg54xCAcuhe+MAs=;
        b=mcm1G4WOOiQLWdlKiOhtZUDAQKgXZe+B5i4Qv0aAu/9iMQBWcN2B/I6RTa+qWHmd6K
         aqmMvvtkg3n0+84RytjtBc/Dj6BKoDmMw97hmpcMG9VCIHov96z/aeXzG8Ko/jqJp2TJ
         EKYh/lIDj0UchyWNgeGIFDZPKl6+lVTGiCRIbTwW9JAVuGr5DqmKE2Edg8ScCEbfSOp/
         +sIkcGR97/GFUeJ30Uu9wmGFazjT62IFaIEAmLJbrenaABSSZUuBLm+is0Fg4f1IByX9
         Xitqhamj02lpuJgQW9vOddSU78UG5Orw+IZMOhfND7M85j3jqOy52Ho3dBIYUekP/gCP
         Xfww==
X-Forwarded-Encrypted: i=1; AL+hErG0MEN8FlF1CQ2nEqWlF+G6HXUEOu+xnuf8y8c+6b5GU6rX7H7y0LgccwHoTHMHrvGZXcO53R51BtY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TaxRAyMd9ONCRUh+KDinNATkhnHNNNttNlFZEIMucg8DSCwpY
	rTeNRY4aYZ1UBVS2UTweB05Ebyrjm4we4ppScx+Ub7G8tomKDmg3llH6
X-Gm-Gg: AZFdTZefR4ZiGn4qInIzRfRrnXZjpn2NySD+YbIchWip/9eWRmgeTc/KjlrnK+B2qKp
	lcN74VIpk5CVxQdthQT5Yp+qP6nJBkO1T04qSqVMPltXcyPddcKk49oAjH3LbI5RhqORkcTU0fC
	fGvUpvNA87flXfVOl0kolXdHXlTE0fmFA7ySw6HJ/6nE8scbyrPaHvrXqZSFQcyZM7Yk+4QKZ/Y
	UgTW1VbZ23aN06pKL4/qNP8XgFAob3Meg0qf4yp/KMxcdLIf3K4kDyjzEIKrriOQ6kBoHpH5fg9
	Ann/yPG8dg7CYcuMbdQzbCqGT0rLBMxOlNX2Ta/JumS2IrA1JgJNaD7NKFGbGw3QZ4MYP50X6qV
	LuEHDX4vR5TpJaId+lQ/+sUbTX7eyPVt6aQ+NQXTCJPuSHvzTk9X33znw7oNq+Dm7+CrLqpE/9p
	F8qpeCFdkRsYb2XKuIj0Nsk6CAb6vmaVjTygEWJ4m/oXuRY5H8zMTXGLieDuOn2Z5t2ksfZNhxB
	07Cv6vaN0Ruez94Pnx8TEI0+ynLE6/I9pudp7akcGx0J3bT1dmRlfLJiFlnRxpIf8NE1yS1tAa3
	gUyjTr4not6vtG2IG9OBDGcPKzEjLO3/fg==
X-Received: by 2002:a05:7301:4306:b0:351:29c8:643 with SMTP id 5a478bee46e88-3856f65cb16mr430705eec.18.1795120959979;
        Thu, 19 Nov 2026 12:42:39 -0800 (PST)
Received: from localhost ([115.96.176.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c0c1dsm1079684eec.21.2026.11.19.12.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 12:42:39 -0800 (PST)
Date: Fri, 20 Nov 2026 02:12:36 +0530
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Breno Leitao <leitao@debian.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Kiryl Shutsemau <kas@kernel.org>, Harry Yoo <harry@kernel.org>
Subject: Re: [RFC PATCH 5/5] cxl/region: Register device poison before
 exposing RAM
Message-ID: <av9fPGZHfa8yOnq7@acer-nitro-anv15-41>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
 <20261010162017.62506-6-shaikhkamal2012@gmail.com>
 <20261016233532.51766fc4@jic23-hlaptop>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016233532.51766fc4@jic23-hlaptop>

On Fri, Oct 16, 2026 at 11:35:32PM +0100, Jonathan Cameron wrote:
> On Sat, 10 Oct 2026 21:50:13 +0530
> Shaikh Kamaluddin <shaikhkamal2012@gmail.com> wrote:
> 
> > The trigger_poison_list interface may retrieve poison after CXL memory
> > is already online, which is too late to prevent known-bad frames from
> > entering the page allocator.
> > 
> > During RAM-region probe, retrieve a poison-list snapshot for each
> > participating endpoint decoder. Validate each record against the
> > decoder's assigned DPA range, translate its poisoned DPA units to HPA
> > and PFN, and collect the affected PFNs in an xarray. Coalesce consecutive
> > PFNs and register the resulting ranges with the pre-online hwpoison
> > registry before creating the DAX region.
> > 
> > When Get Poison List is supported, abort region probe if the list is
> > incomplete, malformed, or cannot be translated. If volatile poison-list
> > retrieval is unsupported, preserve the existing behavior and warn that
> > poison cannot be withheld before memory onlining.
> > 
> > Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> A few comments inline.  I wouldn't rush to revise this though as I think
> the whole concept needs more input from others.
> 

Hi Jonathan,

Agreed. There are open comments on the mm side too (3/5 and 4/5), so I
will get the design settled before sending v2.


> Jonathan
> 
> > ---
> >  drivers/cxl/core/region.c | 322 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 322 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index c72524923b38..e3ffa77927df 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/string_choices.h>
> >  #include <cxlmem.h>
> >  #include <cxl.h>
> > +#include <linux/memory-failure.h>
> >  #include "core.h"
> >  #include "mce.h"
> >  
> > @@ -3038,6 +3039,323 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
> >  	return rc;
> >  }
> >  
> > +/*
> > + * Device-reported poison is gathered at RAM-region probe, before the range
> > + * reaches dax/kmem, and registered with the pre-online registry so the
> > + * frames it covers are withheld when the memory is onlined.
> > + */
> > +static int cxl_poison_store_pfn(struct xarray *pfns, u64 hpa)
> > +{
> > +	return xa_err(xa_store(pfns, PHYS_PFN(hpa), xa_mk_value(1),
> > +			GFP_KERNEL));
> 
> Fix alignment of the line above. Right now it isn't visually clear
> which function call the parameter is for.
>

Will fix.

> > +}
> 
> > +static int cxl_poison_record_to_pfns(struct cxl_region *cxlr,
> > +				     struct cxl_memdev *cxlmd,
> > +				     const struct cxl_poison_record *record,
> > +				     struct xarray *pfns)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	u64 raw = le64_to_cpu(record->address);
> > +	u64 units = le32_to_cpu(record->length);
> > +	u64 dpa = raw & CXL_POISON_START_MASK;
> > +	u8 source = raw & CXL_POISON_SOURCE_MASK;
> > +	u64 length, end, step, cur;
> > +
> > +	if (!units ||
> > +	    check_mul_overflow(units, (u64)CXL_POISON_LEN_MULT, &length) ||
> > +	    check_add_overflow(dpa, length, &end))
> > +		return -EPROTO;
> > +
> > +	/*
> > +	 * A corrected error never reaches the poison list, so every record
> > +	 * is uncorrectable. Only a failure of the device's own media is
> > +	 * withheld: External poison was written by the host into healthy
> > +	 * media and a rewrite or Clear Poison recovers it, and Injected
> > +	 * poison is a test artifact. Withholding either would make a
> > +	 * recoverable state permanent.
> 
> This reflects back to the comment I made in the cover letter.
> Device discovered poison can be ephemeral. 

Agreed. If the error was only temporary, the next write would fix it.
But nothing ever writes a withheld frame, so it stays on the list and
we keep withholding it forever.

>I'm also not sure for volatile
> where any poison record would come from if you are doing this for newly 
> powered up devices - they might scan whilst initializing but might not as
> that is very very slow to do.  Typically poison is found much later by
> patrol scrub (or synchronous read).

A real media fault is still there after a power cycle, which is why
PPR exists, at boot or at runtime. But on a volatile device the poison
list may not remember it: until patrol scrub or a read finds it again,
the list can be empty. So this mainly helps when the device stays
powered while the host restarts, like kexec or a driver re-bind, or
with a device that keeps its error records across a power cycle.

>This may be more interesting for
> persistent memory where the persistence is used, but you aren't addressing
> that as far as I can tell.
>

Agreed, that is the stronger case. Today the CXL driver doesn't feed
the poison list into the nvdimm bad ranges at all, so pmem and devdax
on CXL don't see known-bad locations either. cxl_pmem_ctl() also
returns -ENOTTY for ND_CMD_CLEAR_ERROR, so a bad block couldn't be
cleared by a write even if it were listed.

I will  look at both as a separate series: bad ranges from the poison
list at pmem region probe, plus clear-error support. kmem could then
use the same list when a pmem range becomes system RAM.

> > +	 */
> > +	if (source != CXL_POISON_SOURCE_INTERNAL) {
> > +		dev_dbg(&cxlr->dev, "%s: dpa %#llx source %u not withheld\n",
> > +			dev_name(&cxlmd->dev), dpa, source);
> > +		return 0;
> > +	}
> > +
> > +	/*
> > +	 * Translate once per unit of HPA contiguity rather than per 64
> > +	 * bytes. Consecutive DPAs within an interleave granule map to
> > +	 * consecutive HPAs, and a granule no larger than a page lies within
> > +	 * one page, so stepping by min(granule, PAGE_SIZE) from an aligned
> > +	 * start reaches every page the record covers.
> > +	 */
> > +	step = clamp_t(u64, p->interleave_granularity, CXL_POISON_LEN_MULT,
> > +		       PAGE_SIZE);
> > +
> > +	for (cur = ALIGN_DOWN(dpa, step); cur < end; cur += step) {
> > +		u64 hpa = cxl_dpa_to_hpa(cxlr, cxlmd, max(cur, dpa));
> > +		int rc;
> > +
> > +		/* Not mapped by this region; nothing here to withhold. */
> > +		if (hpa == ULLONG_MAX)
> > +			continue;
> > +
> > +		rc = cxl_poison_store_hpa(cxlr, pfns, hpa);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_region_collect_decoder_poison(struct cxl_region *cxlr,
> > +					     struct cxl_endpoint_decoder *cxled,
> > +					     struct xarray *pfns)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_poison_snapshot snapshot;
> > +	int rc;
> > +
> > +	rc = cxl_poison_snapshot_init(cxlmd, &snapshot);
> > +	if (rc == -EOPNOTSUPP) {
> > +		dev_info(&cxlr->dev,
> > +			 "%s: no Get Poison List support, nothing withheld\n",
> > +			 dev_name(&cxlmd->dev));
> > +		return 0;
> > +	}
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = cxl_get_poison_by_decoder(cxled, &snapshot,
> > +				       CXL_POISON_QUERY_PREONLINE);
> > +	if (rc == -EFAULT) {
> > +		/*
> > +		 * The device keeps no poison list for volatile ranges, which
> > +		 * CXL r3.2 8.2.9.8.4.1 permits. Online the region as today.
> 
> Use latest available spec for references (they don't make old ones easy
> to download!)
> 

Will update the latest references.

> > +		 */
> > +		dev_info(&cxlr->dev,
> > +			 "%s: no volatile poison list, nothing withheld\n",
> > +			 dev_name(&cxlmd->dev));
> too noisy.
>

Will drop it.

> > +		rc = 0;
> > +		goto out;
> > +	}
> > +	if (rc)
> > +		goto out;
> > +
> > +	/*
> > +	 * Withholding from a partial list would online the region on the
> > +	 * belief that every bad frame had been named.
> > +	 */
> > +	if (snapshot.truncated ||
> > +	    (snapshot.device_flags & CXL_POISON_FLAG_OVERFLOW)) {
> > +		dev_err(&cxlr->dev, "%s: poison list incomplete\n",
> > +			dev_name(&cxlmd->dev));
> > +		rc = -EOVERFLOW;
> > +		goto out;
> > +	}
> > +	if (snapshot.device_flags & CXL_POISON_FLAG_SCANNING) {
> 
> That one seems wrong. We don't prevent memory from coming online because
> there might be poison to be found.

Agreed, I will drop that check. Anything the scan finds later is handled
like any other poison found at runtime.

> 
> > +		dev_err(&cxlr->dev, "%s: media scan in progress\n",
> > +			dev_name(&cxlmd->dev));
> > +		rc = -EBUSY;
> > +		goto out;
> > +	}
> > +
> > +	for (u32 i = 0; i < snapshot.nr_records; i++) {
> > +		rc = cxl_poison_record_to_pfns(cxlr, cxlmd,
> > +					       &snapshot.records[i], pfns);
> > +		if (rc)
> > +			break;
> > +	}
> > +out:
> > +	cxl_poison_snapshot_destroy(&snapshot);
> > +	return rc;
> > +}
> > +
> > +static unsigned int cxl_count_poison_ranges(struct xarray *pfns)
> > +{
> > +	unsigned long index, previous = 0;
> > +	unsigned int nr = 0;
> > +	void *entry;
> > +	bool first = true;
> > +
> > +	xa_for_each(pfns, index, entry) {
> > +		if (first || index != previous + 1)
> > +			nr++;
> > +		first = false;
> > +		previous = index;
> > +	}
> > +	return nr;
> > +}
> > +
> > +/*
> > + * The xarray holds each PFN once and xa_for_each() walks them in ascending
> > + * order, so runs of consecutive indices are exactly the sorted,
> > + * nonoverlapping ranges preonline_hwpoison_register() requires.
> > + */
> > +static int cxl_pfns_to_ranges(struct xarray *pfns,
> > +			      struct preonline_hwpoison_range **ranges_out,
> > +			      unsigned int *nr_ranges_out)
> > +{
> > +	struct preonline_hwpoison_range *ranges;
> > +	unsigned long index, previous = 0, run_start = 0;
> > +	unsigned int nr_ranges, nr = 0;
> > +	void *entry;
> > +	bool first = true;
> > +
> > +	nr_ranges = cxl_count_poison_ranges(pfns);
> > +	if (!nr_ranges) {
> > +		*ranges_out = NULL;
> > +		*nr_ranges_out = 0;
> > +		return 0;
> > +	}
> > +
> > +	ranges = kvmalloc_array(nr_ranges, sizeof(*ranges), GFP_KERNEL);
> 
> kvmalloc_objs()
> 

Will switch.

Thanks,
Shaikh Kamal

> > +	if (!ranges)
> > +		return -ENOMEM;
> > +
> > +	xa_for_each(pfns, index, entry) {
> > +		if (first) {
> > +			run_start = index;
> > +			previous = index;
> > +			first = false;
> > +			continue;
> > +		}
> > +		if (index == previous + 1) {
> > +			previous = index;
> > +			continue;
> > +		}
> > +		ranges[nr++] = (struct preonline_hwpoison_range) {
> > +			.start_pfn = run_start,
> > +			.nr_pages = previous - run_start + 1,
> > +		};
> > +		run_start = index;
> > +		previous = index;
> > +	}
> > +	ranges[nr++] = (struct preonline_hwpoison_range){
> > +		.start_pfn = run_start,
> > +		.nr_pages = previous - run_start + 1,
> > +	};
> > +
> > +	WARN_ON_ONCE(nr != nr_ranges);
> > +	*ranges_out = ranges;
> > +	*nr_ranges_out = nr;
> > +	return 0;
> > +}
> > +
> > +static void cxl_unregister_device_poison(void *data)
> > +{
> > +	preonline_hwpoison_unregister(data);
> > +}
> > +
> > +static int cxl_region_register_device_poison(struct cxl_region *cxlr)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	struct preonline_hwpoison_range *ranges = NULL;
> > +	struct preonline_hwpoison *handle;
> > +	unsigned int nr_ranges = 0;
> > +	unsigned long nr_frames = 0;
> > +	struct xarray pfns;
> > +	int rc = 0;
> > +
> > +	lockdep_assert_held(&cxl_rwsem.region);
> > +	lockdep_assert_held(&cxl_rwsem.dpa);
> > +
> > +	/* The region may have been decommitted while the lock was dropped. */
> > +	if (p->state < CXL_CONFIG_COMMIT)
> > +		return -ENXIO;
> > +
> > +	if (test_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags)) {
> > +		dev_info(&cxlr->dev,
> > +			 "normalized addressing, poison not translated\n");
> > +		return 0;
> > +	}
> > +
> > +	xa_init(&pfns);
> > +
> > +	for (int i = 0; i < p->nr_targets; i++) {
> > +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > +
> > +		if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> > +			continue;
> > +		rc = cxl_region_collect_decoder_poison(cxlr, cxled, &pfns);
> > +		if (rc)
> > +			goto out;
> > +	}
> > +
> > +	if (xa_empty(&pfns))
> > +		goto out;
> > +
> > +	rc = cxl_pfns_to_ranges(&pfns, &ranges, &nr_ranges);
> > +	if (rc)
> > +		goto out;
> > +
> > +	rc = preonline_hwpoison_register(ranges, nr_ranges, &handle);
> > +	if (rc == -EOPNOTSUPP) {
> > +		/* No poison tracking in this kernel; nothing to withhold. */
> > +		rc = 0;
> > +		goto out;
> > +	}
> > +	if (rc)
> > +		goto out;
> > +
> > +	for (unsigned int i = 0; i < nr_ranges; i++)
> > +		nr_frames += ranges[i].nr_pages;
> > +	dev_warn(&cxlr->dev,
> > +		 "withholding %lu frame(s) reported poisoned by the device\n",
> > +		 nr_frames);
> > +
> > +	rc = devm_add_action_or_reset(&cxlr->dev, cxl_unregister_device_poison,
> > +				      handle);
> > +out:
> > +	kvfree(ranges);
> > +	xa_destroy(&pfns);
> > +	return rc;
> > +}
> 
> 
