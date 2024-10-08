Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5891DEFCF
	for <linux-cxl@vger.kernel.org>; Tue,  8 Oct 2024 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400655; cv=none; b=i0BIFy5z/dUsAX5yfHBvcY9wyCFN88tu9N3RbAgZKeCzaXHFUMX4tDVk5tJgiO5giuc6ReRuVmwhyPAOD6V8aXoN8p9+CQPam4s7WMX2oiBCf3o3xfqEPaE8PxWPfI1XKx6a/bAy3vGzcsJ5gRg1ozVW9zbfZb7Cuis0xk9hjGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400655; c=relaxed/simple;
	bh=1cJf1jEpAsd3u2qq6i8kPjFM1lpCm1L003ZxZ9W/NWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SigoJbtp1c8zVPYHlHV347smiF78rouBsCBbg6zHV+0WrEA8Hnng1ECytwzEVZdzJ2oLjdJD3EZRV9cvn7g7lr/Vv/bLUTv+CJO031Pvzy6+zdtG1dDFouiXbj3SiqSWsE5YfLqfd9iW9V7FQCHigOdrvYExLj5rDwnCw0RsVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=grSyvLUB; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="grSyvLUB"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4583083d019so39614001cf.3
        for <linux-cxl@vger.kernel.org>; Tue, 08 Oct 2024 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728400652; x=1729005452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H78KOsXxqZBUvG+QHX45xW+vctWF6+s2zoBWOxIrUFc=;
        b=grSyvLUB3IACCu/RiUb88VW629XIF73qTcgO5uAwSMLxvLfkEdXa5J2mN/xsF/UrXI
         0qU4wbKsaP9LEXrWo7giGlJ3ctDfron04snSQqjHa/2v1B8xv03huiWObBtIqPjd2UMD
         NKXAQF81sQWdyEhzriSEgdbFdoEXDND7lrNSml1fhiVB6DGnjLRF4f9O5mhERyonrvtF
         tNvzodiDlhFEY+PxO9hiz1H8bqApsIplnYKHylR6Vz/FwQyPKoaRKlpxHw45PW19O4ZX
         BZ6QtAueMK3KTwSorGNXCkuFv2V/EDTHhXnAV7f2OQO7koTQJd5AIWbduOFpMe38simX
         G1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400652; x=1729005452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H78KOsXxqZBUvG+QHX45xW+vctWF6+s2zoBWOxIrUFc=;
        b=n7BzxFYHFIUUep8IaDtK/T45uZfFhvPZv5idnaN2bwayHWMEurBgTxRtVjFompb27e
         DtbIWUUPBLj8fw4lxoMykuQq6lLXjfumo7cNtdDNTtpL35LEaY+E5dRVo2lXXPc9oLMi
         rvl988USL3+aNUhbXzBqrqyUputZFBLAh3MM4rteYzCVhjcSZYeO9P2Z7tj6JfYy6U4z
         z6UuGLJQFTeQt+qkA3z66wguiMFu0/yNb2Ct2IxS3V5bnQJFbYNxoYu/PB6j+SLLXDvw
         iU7LpBpzZYXek51iGiUHMfohSnemABnFEFzBiw4jvuZ7oE8ZNnkInd5XwIj9Z8WnSvv9
         3w4g==
X-Gm-Message-State: AOJu0YyesmcuTGKLt+g66SVCOBk8ltIjhOhkYOvy5qhSR2A9tmFcjxZF
	duplMcoH+cgRiu/DcKZ35PKNwdxSH89wErPRSgrXosEznYiKg2UzLa6KXHNNamk=
X-Google-Smtp-Source: AGHT+IG7uM3piKF3jfYxHaDkswnZHDMGTup6PjRZnneyV4fyTZle4+CCL0LEcgUKcnOhtQbrxRwlJA==
X-Received: by 2002:a05:622a:5798:b0:458:5357:dc19 with SMTP id d75a77b69052e-45d9bafaefbmr235642641cf.49.1728400651702;
        Tue, 08 Oct 2024 08:17:31 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45efcedd9dcsm6790911cf.91.2024.10.08.08.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:17:31 -0700 (PDT)
Date: Tue, 8 Oct 2024 11:17:21 -0400
From: Gregory Price <gourry@gourry.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-cxl@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	david@redhat.com, osalvador@suse.de, gregkh@linuxfoundation.org,
	rafael@kernel.org, akpm@linux-foundation.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	alison.schofield@intel.com, rrichter@amd.com, terry.bowman@amd.com,
	lenb@kernel.org, dave.jiang@intel.com
Subject: Re: [PATCH 3/3] acpi,srat: reduce memory block size if CFMWS has a
 smaller alignment
Message-ID: <ZwVNAYiyUaoc8Pax@PC2K9PVX.TheFacebook.com>
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-4-gourry@gourry.net>
 <6705489bdc79b_125a729415@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6705489bdc79b_125a729415@iweiny-mobl.notmuch>

On Tue, Oct 08, 2024 at 09:58:35AM -0500, Ira Weiny wrote:
> Gregory Price wrote:
> > The CXL Fixed Memory Window allows for memory aligned down to the
> > size of 256MB.  However, by default on x86, memory blocks increase
> > in size as total System RAM capacity increases. On x86, this caps
> > out at 2G when 64GB of System RAM is reached.
> > 
> > When the CFMWS regions are not aligned to memory block size, this
> > results in lost capacity on either side of the alignment.
> > 
> > Parse all CFMWS to detect the largest common denomenator among all
> > regions, and reduce the block size accordingly.
> > 
> > This can only be done when MEMORY_HOTPLUG and SPARSEMEM configs are
> > enabled, but the surrounding code may not necessarily require these
> > configs, so build accordingly.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  drivers/acpi/numa/srat.c | 48 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> > 
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 44f91f2c6c5d..9367d36eba9a 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/acpi.h>
> >  #include <linux/memblock.h>
> > +#include <linux/memory.h>
> >  #include <linux/numa.h>
> >  #include <linux/nodemask.h>
> >  #include <linux/topology.h>
> > @@ -333,6 +334,37 @@ acpi_parse_memory_affinity(union acpi_subtable_headers *header,
> >  	return 0;
> >  }
> >  
> > +#if defined(CONFIG_MEMORY_HOTPLUG)
> 
> Generally we avoid config defines in *.c files...  See more below.
> 
> > +/*
> > + * CXL allows CFMW to be aligned along 256MB boundaries, but large memory
> > + * systems default to larger alignments (2GB on x86). Misalignments can
> > + * cause some capacity to become unreachable. Calculate the largest supported
> > + * alignment for all CFMW to maximize the amount of mappable capacity.
> > + */
> > +static int __init acpi_align_cfmws(union acpi_subtable_headers *header,
> > +				   void *arg, const unsigned long table_end)
> > +{
> > +	struct acpi_cedt_cfmws *cfmws = (struct acpi_cedt_cfmws *)header;
> > +	u64 start = cfmws->base_hpa;
> > +	u64 size = cfmws->window_size;
> > +	unsigned long *fin_bz = arg;
> > +	unsigned long bz;
> > +
> > +	for (bz = SZ_64T; bz >= SZ_256M; bz >>= 1) {
> > +		if (IS_ALIGNED(start, bz) && IS_ALIGNED(size, bz))
> > +			break;
> > +	}
> > +
> > +	/* Only adjust downward, we never want to increase block size */
> > +	if (bz < *fin_bz && bz >= SZ_256M)
> > +		*fin_bz = bz;
> > +	else if (bz < SZ_256M)
> > +		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
> > +
> > +	return 0;
> > +}
> > +#endif /* defined(CONFIG_MEMORY_HOTPLUG) */
> > +
> >  static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >  				   void *arg, const unsigned long table_end)
> >  {
> > @@ -501,6 +533,10 @@ acpi_table_parse_srat(enum acpi_srat_type id,
> >  int __init acpi_numa_init(void)
> >  {
> >  	int i, fake_pxm, cnt = 0;
> > +#if defined(CONFIG_MEMORY_HOTPLUG)
> > +	unsigned long block_sz = memory_block_size_bytes();
> 
> To help address David's comment as well;
> 
> Is there a way to scan all the alignments of the windows and pass the
> desired alignment to the arch in a new call and have the arch determine if
> changing the order is ok?
> 

At least on x86, it's only OK during init, so it would probably look like
setting a static bit (like the global value in x86) and just refusing to
update once it is locked.

I could implement that on the x86 side as an example.

FWIW: this was Dan's suggestion (quoting discord, sorry Dan!)
```
    I am assuming we would call it here
        drivers/acpi/numa/srat.c::acpi_parse_cfmws()
    which should be before page-allocator init
```

It's only safe before page-allocator init (i.e. once blocks start getting
populated and used), and this area occurs before that.


> Also the call to the arch would be a noop for !CONFIG_MEMORY_HOTPLUG which
> cleans up this function WRT CONFIG_MEMORY_HOTPLUG.
> 
> Ira
>

The ifdefs are a nasty result of the HOTPLUG and SPARSEMEM configs
being, from my perview, horrendously inconsistent throughout the system.

As an example, MIN_MEMORY_BLOCK_SIZE depends on SECTION_SIZE_BITS
which on some architectures is dependent on CONFIG_SPARSEMEM, and
on others is defined unconditionally.  Compound this with memblock
usage appearing to imply CONFIG_MEMORY_HOTPLUG which implies
CONFIG_SPARSEMEM (see drivers/base/memory.c) - but mm/memblock.c
makes no such assumption.

The result of this is that if you extern these functions and build
x86 with each combination of HOTPLUG/SPARSMEM on/off, it builds - but
loongarch (and others) fail to build because SECTION_SIZE_BITS doesn't
get defined in some configurations.

It's not clear if removing those ifdefs from those archs is "correct"
(for some definition of correct) and I didn't want to increase scope.

So it's really not clear how to wire this all up.

I spent the better part of a week trying to detangle this mess just
to get things building successfully in LKP and decided to just add the
ifdefs to get it out and get opinions on the issue :[
 
> > +	unsigned long cfmw_align = block_sz;
> > +#endif /* defined(CONFIG_MEMORY_HOTPLUG) */
> >  
> >  	if (acpi_disabled)
> >  		return -EINVAL;
> > @@ -552,6 +588,18 @@ int __init acpi_numa_init(void)
> >  	}
> >  	last_real_pxm = fake_pxm;
> >  	fake_pxm++;
> > +
> > +#if defined(CONFIG_MEMORY_HOTPLUG)
> > +	/* Calculate and set largest supported memory block size alignment */
> > +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_align_cfmws,
> > +			      &cfmw_align);
> > +	if (cfmw_align < block_sz && cfmw_align >= SZ_256M) {
> > +		if (set_memory_block_size_order(ffs(cfmw_align)-1))
> > +			pr_warn("CFMWS: Unable to adjust memory block size\n");
> > +	}
> > +#endif /* defined(CONFIG_MEMORY_HOTPLUG) */
> > +
> > +	/* Then parse and fill the numa nodes with the described memory */
> >  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> >  			      &fake_pxm);
> >  
> > -- 
> > 2.43.0
> > 
> > 
> 
> 
