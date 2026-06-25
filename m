Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8E31C56D
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395510; cv=none; b=YtCsPoMkW8wjAKiXfiXHgF0Zn5H1jKcn8phPWtrRA1J+J0K3vBfmTNwU5mc67XnLOBCRBn32OQz6ivXnRZQaA4BDFxeLZo5s16EXkw5Ng9BJPo2JHtdOzevrxNT/3jpHJbX6mFEvOJQOFTI1dpd5oDwnMUpJBBq8RnFpNn1XtHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395510; c=relaxed/simple;
	bh=hLIxkknUY1qEk33mNlGnfp7C3XVSiZnlZVJPB7bPOFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctBq5ki+LIGvTUaS8Yx118FXbl0bVXDwo8HDKfFwui34sF9wGPGT8I4dTJVs6dQvar+/k9kB3m09FACfle5YMuTHIQam7SI48yZgE0w9G405bZOX++v5EoRmNq/Lyd/3j6ygQf7ResC+zpca7J89wFFEvKGDpXHH3I+xhR0ldSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=L+5tuE9W; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="L+5tuE9W"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9159951f05aso268963885a.0
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782395508; x=1783000308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKYJf6dgXdgamkqA4Gs/PyiillXu8yFih4YnbHcGiuM=;
        b=L+5tuE9WMTjSkPcBaYEt5I3YE4TDsX9EsEIQbLUSG94RPqQT4evKuOlp/O3jKmYJcm
         OYHwpMYkBNjcDbktaxnW1mee6sflkwEZqSfZ2w422MiTRQJX2pHmumViNg8ybeRq1vzW
         mFiuh3FprRcThPp+774VftfpQQ1B2OHiPyq76UEOnE8agd1ITmP04NbQfJPsXePSZ5Gz
         YlY1upFSdaQzWxIkNYQ4LsgTVeBWOpZyRYZjDEyNz8LnWJPg4s14vYId8809mkruWB5V
         CmuY4goF/9pXVlt0v2Na1IbL4r53EdKNwtuoajtmBasTNS/q5lwDqtB7ubUVbRn2WCQB
         xYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782395508; x=1783000308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKYJf6dgXdgamkqA4Gs/PyiillXu8yFih4YnbHcGiuM=;
        b=pwKI91XY403AWHW8iphwunx0aAzyORxS3CFauyS78i22XXONWQmq/EKDovV6+bEA7a
         xIkGtdb1hd4oOB0zMaAeY/2MxadSzSAbI1gJxCeQMlvV2Ug9KMLW0d+9FkrwbQPkeBB+
         l9MbsWrYzya3EPXxNzAoBx/QyG7/xDQdoikBSES4d6JAQ8YUZpz1THw9TUBd16ZGVBY/
         NbUe/DIB3J+dljIqtr1SZFPJ46zYHvr2vFYRJ3OO+hFiKNc6hIMm4OsZuA30AJMW/+AE
         720Tg1UU/4EHI58ZK2wlctVpeiseJg+FJrj9qKNj0zlYNIeWPgLq/g0hNAeMI+8M5bjZ
         m72Q==
X-Forwarded-Encrypted: i=1; AFNElJ91ByS3bF+V+qa+zVPPxubD6/mmLlTnVE0Hf/q7fQ88rgqJpyW+qTNazdPItDraznj0HQEtwvgk5xc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk8Dpe0j2TgvzX4W/U4QjRThpIaAYwXrs+pVKR9KNHXGVshy35
	tCoTWzSfvYi81JqodUjDLUimppSfJewUMsrGczNJt5uKAEXJW+dXFS8WDIUWJh7opys=
X-Gm-Gg: AfdE7cmxyLLVPPjdwwidMN6OXr1kn8ecNara86lQjyRnQSwLi4R/OmHSh5XHXjTUuI9
	LjR8GaJOISA2CWC1juNrMNEpM9ZCkXTheFwEESOIcM3/v9JsskpDp7kCKsRuKLmSHYyXIY/lPWs
	SKwftJArEPGohnJvxO0lcdcje8y3LKvCjD14/SXM6uq/eP+MUk7TYAa4KJu9JGzbksSwiG4lcIk
	UfWbjT2aPj6hcDtx24zJyT9Q8IPOj4VPCzOuZF5L/2TNzohmVtjWLuVvx+ELSdHRuHBlnMmDpra
	7zOCplCk31nNFd9z2fXk3MnJ4EwCGggsK1cujyJk+ZABLrcCpdXk1f83Lgy8qDSyZy0VcwUslFH
	ozX95G+H4F6aUF9ribZgi0U09XP50l+yln1S5c5tVTdct7cUxdwFsFIuA1jW09hXDHBdtSVXHfY
	bUzYsBq1u87GKvy0B4dm22kOMaSxJipWHJpfC+XwEXx0rszRvZz/P7Yzlkcvq3y52wZP0pFfNnT
	aQlssE=
X-Received: by 2002:a05:620a:2887:b0:91e:7a20:3cc9 with SMTP id af79cd13be357-9293d5b247dmr385793985a.52.1782395507830;
        Thu, 25 Jun 2026 06:51:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f5ff5e6sm180208286d6.12.2026.06.25.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 06:51:47 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:51:42 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, osalvador@suse.de, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org,
	vishal.l.verma@intel.com, dave.jiang@intel.com,
	akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, shuah@kernel.org, alison.schofield@intel.com,
	Smita.KoralahalliChannabasappa@amd.com, ira.weiny@intel.com,
	apopple@nvidia.com
Subject: Re: [PATCH v5 5/9] mm/memory_hotplug:
 offline_and_remove_memory_ranges()
Message-ID: <aj0ybgV7n0pqXF0b@gourry-fedora-PF4VCD3F>
References: <20260624145744.3532049-1-gourry@gourry.net>
 <20260624145744.3532049-6-gourry@gourry.net>
 <d48feca1-0203-43ff-bd66-6243291a51ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d48feca1-0203-43ff-bd66-6243291a51ba@kernel.org>

On Thu, Jun 25, 2026 at 09:22:01AM +0200, David Hildenbrand (Arm) wrote:
> On 6/24/26 16:57, Gregory Price wrote:
> >  extern int offline_and_remove_memory(u64 start, u64 size);
> > +int offline_and_remove_memory_ranges(const struct range *ranges, int nr_ranges);
> >  
> >  #else
> >  static inline void try_offline_node(int nid) {}
> > @@ -283,6 +284,12 @@ static inline int remove_memory(u64 start, u64 size)
> >  }
> >  
> >  static inline void __remove_memory(u64 start, u64 size) {}
> > +
> > +static inline int offline_and_remove_memory_ranges(const struct range *ranges,
> > +						   int nr_ranges)
> 
> Best to use "unsigned int" right from the start and use two tabs to indent.
> 

ack, ack.  need to reprogram my brain to two-indent style, i keep doing
this reflexively.

> > +int offline_and_remove_memory_ranges(const struct range *ranges, int nr_ranges)
> > +{
> > +	unsigned long mb_total = 0;
> >  	uint8_t *online_types, *tmp;
> > -	int rc;
> > +	int i, rc = 0;
> >  
> > -	if (!IS_ALIGNED(start, memory_block_size_bytes()) ||
> > -	    !IS_ALIGNED(size, memory_block_size_bytes()) || !size)
> > +	if (!ranges || nr_ranges <= 0)
> 
> With "unsigned int" this will be !nr_ranges.
> 
> Wondering whether we would WARN_ON_ONCE() here.
> 

Seems reasonable.  Do we normally WARN when callers send dumb arguments?
Seems like sending -EINVAL is sufficient?

> > -	online_types = kmalloc_array(mb_count, sizeof(*online_types),
> > +	online_types = kmalloc_array(mb_total, sizeof(*online_types),
> >  				     GFP_KERNEL);
> 
> Is "mb_total" really more expressive than "mb_count"?
> 

No, this was mostly my way ok keeping try of what was being moved around
while working it.  I will change it back.

> >  	/*
> > -	 * In case we succeeded to offline all memory, remove it.
> > -	 * This cannot fail as it cannot get onlined in the meantime.
> > +	 * Phase 2: Remove each range. This essentially cannot fail as we hold
> > +	 * the hotplug lock . WARN if that assumption is ever broken.
> >  	 */
> >  	if (!rc) {
> > -		rc = try_remove_memory(start, size);
> > -		if (rc)
> > -			pr_err("%s: Failed to remove memory: %d", __func__, rc);
> > +		for (i = 0; i < nr_ranges; i++) {
> > +			rc = try_remove_memory(ranges[i].start,
> > +					       range_len(&ranges[i]));
> > +			if (WARN_ON_ONCE(rc)) {
> > +				pr_err("%s: Failed to remove memory: %d",
> > +				       __func__, rc);
> > +				break;
> 
> Do we really want to break? I'd say, just warn and continue, and fake rc == 0.
> Something is seriously messed up already, and we partially removed memory. There
> is no clean rollback possible.
> 
> Similar to __remove_memory(), ignoring the error because it offlined it already.
> 

This seems reasonable, will change to warn and continue + return error.

Sashiko actually pointed out there there's a corner condition here with
offline rollback, so i needed to tweak this chunk anyway.

~Gregory
