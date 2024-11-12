Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF99E21CF9F
	for <linux-cxl@vger.kernel.org>; Tue, 12 Nov 2024 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455281; cv=none; b=UmQmv7taubIJf/fmICa6Jeh8eIR10JpBcRMXnKAr4M+grnxbwl6PFKs2kT6Sq/casPuT9D8NJG0uibVf9gBxLbcFGfmF5XSDfEzug2rfhve0xRUnZoKYkgHdwyhBlbWrWk3dl+3eO700EyWYGkRli45IXDFwDwbCX+dbSn2r9Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455281; c=relaxed/simple;
	bh=N7dFYszMXv8mOrLoOkSsYfFtGY+5VlTWGDWy+wCc/Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgY1trzdRuQY19vuYmaph6Of2PTuNBV7LshXmo1AmmFeNV03680s2ZjLhouJnjwrrWGlobC8qxj0FS3sUk01TRtXtYYCV9HKg32ARo0VJdXyIacvz88tZmzCTcESnv8pf/GE4W/EmMoXVbteA45hmEKZ8qmi8efP1oSs+Wkbyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aMQnJ4BO; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aMQnJ4BO"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbe68f787dso40539446d6.2
        for <linux-cxl@vger.kernel.org>; Tue, 12 Nov 2024 15:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1731455278; x=1732060078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nOX9DSgNLbyzHMkGOIxDMiwsq1o4f6ejGQOhBxaCHpU=;
        b=aMQnJ4BOncOEUbjunI/ZUQTc01EBixAoSiqs6gb0lLss+sR65ega/+nqMc2vrZD4tI
         qtBrJ4Qb5XcS2kHa3lQEq7tgX+HkZENJtaYFFekrlCWFgAfTtwzlP2n+dOjjoT/EOm2+
         tXq5dcGpYzgr+cd8pgA0N4xr8xmDUHaHF59lCYjj7XLHjt70hFFpK7cwLD3G3xZd0d/s
         EYfD10szDlD+m0I17jj/ifLMpGV4ONz8u/YBPWnpLJj1anqaV161w+sqWK3Xcn3/mK1V
         PQGio9H+XsNZrUhiIa1YjzzIHUKPQTv7JYAZWVbhbyPHQ1IPjnXXhfKKuZvN0YtVgVIK
         7PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731455278; x=1732060078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOX9DSgNLbyzHMkGOIxDMiwsq1o4f6ejGQOhBxaCHpU=;
        b=Yq7GPq8lQocCeopKWuzHL7NMaSDTJ63s12irstgI3a/2ARYhPP3YgcWA0mRfS/lfOp
         1Cy9i+TueaaUmixGe8A+Ega/YDDzRbbMqDOBK+6vJ4sphC7+7KB/PGuSyjoU7IWQ8hBp
         Ce+NZ0rBI+yf14mVQHKWmnOdWi79v6umwRcZMUlNil70CrI2kTnMeAQeNY7eJZI/A/Qu
         ParXyNTe5FLHzgrGUdt3LLY2nDYRkLfJT4UEUux2lev2rN51peGC0b9rJTaOT73016OE
         GUKxSHCw8lkG0J3P30o8eGXoE90wESVISBIkwrFluThUF52ALKPRI/EXneiLLlw2Hx/a
         B0Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVxH79dcbfQVQ7rMOkBXeetUPBRqhDsyfV+D5yccGe6O+TaMDjovriswuLGuAgxB9Rnx2EqUoS1q7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrcm1QuAQayv60lq6+Kfde20ffmvhHbqCAyV5u80YJg+sM5+2O
	qFKh55CLagbCDVG8FtLSA83vt+TpEj1QrSIiL/9fx1CEpRJgusXDEJhZpPbzOvI=
X-Google-Smtp-Source: AGHT+IESCbVOvkdTgqqmwdwGBZDyO5gMTGBHvzuur/6mM+yLjVaQptGL8/RUONrYdiW+pZ1cU+a0nw==
X-Received: by 2002:a05:6214:5b87:b0:6cb:f16f:65d5 with SMTP id 6a1803df08f44-6d3dd039d0emr15720396d6.12.1731455278579;
        Tue, 12 Nov 2024 15:47:58 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d39643b678sm77555456d6.97.2024.11.12.15.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:47:58 -0800 (PST)
Date: Tue, 12 Nov 2024 18:47:35 -0500
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, kernel-team@meta.com,
	Jonathan.Cameron@huawei.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, david@redhat.com, osalvador@suse.de,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	rppt@kernel.org
Subject: Re: [PATCH v6 3/3] acpi,srat: give memory block size advice based on
 CFMWS alignment
Message-ID: <ZzPpFzdzu-cis114@PC2K9PVX.TheFacebook.com>
References: <20241106155847.7985-1-gourry@gourry.net>
 <20241106155847.7985-4-gourry@gourry.net>
 <6733cba395c30_10bc6294df@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6733cba395c30_10bc6294df@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Nov 12, 2024 at 01:41:55PM -0800, Dan Williams wrote:
> Gregory Price wrote:
> > Capacity is stranded when CFMWS regions are not aligned to block size.
> > On x86, block size increases with capacity (2G blocks @ 64G capacity).
> > 
> > Use CFMWS base/size to report memory block size alignment advice.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > ---
> >  drivers/acpi/numa/srat.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 44f91f2c6c5d..34b6993e7d6c 100644
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
> > @@ -338,13 +339,22 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >  {
> >  	struct acpi_cedt_cfmws *cfmws;
> >  	int *fake_pxm = arg;
> > -	u64 start, end;
> > +	u64 start, end, align;
> >  	int node;
> >  
> >  	cfmws = (struct acpi_cedt_cfmws *)header;
> >  	start = cfmws->base_hpa;
> >  	end = cfmws->base_hpa + cfmws->window_size;
> >  
> > +	/* Align memblock size to CFMW regions if possible */
> > +	align = 1UL << __ffs(start | end);
> > +	if (align >= SZ_256M) {
> > +		if (memory_block_advise_max_size(align) < 0)
> > +			pr_warn("CFMWS: memblock size advise failed\n");
> 
> Oh, this made me go back to look at what happens if CFMWS has multiple
> alignment suggestions. Should not memory_block_advise_max_size() be
> considering the max advice?
> 
>     if (memory_block_advised_size) {
>         ...    
>     } else {
>             memory_block_advised_size = max(memory_block_advised_size, size);
>     }
> 
> For example, if region0 is an x4 region and region1 is an x1 region then
> the memory block size should be 1GB, not 256M. I.e. CFMWS alignment
> follows CXL hardware decoder alignment of "256M * InterleaveWays".

Max size to minimize capacity loss to due alignment truncation.

If CFMW-0 is aligned at 1GB and CFMW-1 is aligned at 256MB, if you select 1GB
then some portion of CFMW-1 will be unmappable.

so you want min(memory_block_advised_size, size) to ensure the hotplug memblock
size aligns to the *smallest* CFMW (or any other source) alignment.

Unless I'm misunderstanding your feedback here.


I'm not clear on why the interleave data is relevant here - that just tells us
how decoders line up with the memory region described in the CFMW.  The window
still gets chopped up into N memblocks of memory_block_advised_size.

~Gregory
