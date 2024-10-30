Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923361DDC10
	for <linux-cxl@vger.kernel.org>; Wed, 30 Oct 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300387; cv=none; b=FflWUff3Hhqd2dx1XDV+f/1jhBiCkECxGNQTfRfst9aF4E/UGJQ13T7inDbqYk4EQPLkcqgaRx41FYUxjI7lUGYPVhH7dmmB8JflP6sKbMpqTmt5iSOBXNc0hscIjUIM+N1eLzyRga/poNgnrZJ8NhiqbHFVIRPkoOKOaAOn99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300387; c=relaxed/simple;
	bh=xgTGTLCEi3J05i1dd/M/kJiy/4dDsFFhU1eqm56yAXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ld1f4bq+J0UjAtrQ8euWWvbvb8P9UdZXijJ4Th844ZUaf2b4CXPJGkQ92x0Lz9GLTyZu3ha7E+TGIC0yrTI1lf+DNWpX0eO2twWoQAFAPEXkG3PlhRqoDFI5Z1D7ogyqjQ0tbenOmSJcom1c8ezL5MHwiTTaj5B1xcGa8qpGGzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Rj8xdqco; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Rj8xdqco"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbe53a68b5so46655186d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 30 Oct 2024 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730300383; x=1730905183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1CRNigufEv4srYMK7CzZ+n/1hKhvYmg+07IbXIIY6zQ=;
        b=Rj8xdqco40tFZFQkwoYWFKbwTgPH0fCkaO14XwFGGdKrE5plUpPvNoLvLdStl4uXF9
         y80ki0jpSy2lCUcOxa5ukN1UZpEeN/QcFciRONgNWvGTwtB4zGrGAkax0vZn2kMM/N8u
         DAKT1Sl2pmAeGvVHRZQjHnyh7oXWpUwzNGqSYQG2GwFrsvjkyduMWQH0+kZ88hI0aBEz
         PdLze5bsbq1zr59huFTucQqiJihQjMT5mxbk4RK/lt+f25ljcs9PGmWAcZuZHZgCGBr6
         5qESX5OhRKRVCJgHh0lQcwxL0Dh3Q2ZVX+PtljxFrbW9DXdshYAk5UpaPjMrH3j1gxTV
         z0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300383; x=1730905183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CRNigufEv4srYMK7CzZ+n/1hKhvYmg+07IbXIIY6zQ=;
        b=KucOBGN9qAdRUwDWfp1iXejBaeAcNw/vWCzL4q1nZ6nWfPkPp7IQ4ZDySwZxSS5igr
         5oatLlJDLhHHpa4ePe8te45NUPWtlTkhlGgPDoI5nqAbja8aP0YKdD5tnroJC8ECdAXP
         2oTA9comL7WRmcbz6r4CFJccuITZPc5qhZ2nxQIiQxcGs3OUhSd22nX1iBoNj7bXD7WU
         M3HVmACexm9JjMSo9KJxVwvKNMZmK/b1SJx6zKFyTBiFKpLdJJMmUEs6HgWvtVpgoZUJ
         gryOwLszzb8F3ef6p2BQXqWBr64Yqilbxj6lNicPWXIsvVeXdbxc46vt1Kcp+a7j82pv
         vy1w==
X-Forwarded-Encrypted: i=1; AJvYcCUt64xR4Sg1wEoK7++4rYKCzOt+jvktcW469RpLEHpQz2WioJVtXZJRcVbuO7Ygu2FP1BQdRtpPShs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDEw4Hd0JACAJjftZhiptn5ghQPH5J9IbwnvyzABNpf56Pci1o
	iDr/kIyMNvLb6s3zfRWRu9bhyWg/o9yJ1VV/X536QZ0KXfeQvw7w36lXtv8V7WE=
X-Google-Smtp-Source: AGHT+IEV7l+Y+OcHF3D5iHR7Q3RlAhw7sBOVYB5E6ILrTizIrARGpPbdx8snNJXXQLRSYzX4Yuru7A==
X-Received: by 2002:a0c:f409:0:b0:6cb:c6d2:3567 with SMTP id 6a1803df08f44-6d345fae094mr34561776d6.3.1730300383356;
        Wed, 30 Oct 2024 07:59:43 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a09498sm52532166d6.93.2024.10.30.07.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:59:43 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:59:48 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, osalvador@suse.de, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, rppt@kernel.org
Subject: Re: [PATCH v4 1/3] memory: implement
 memory_block_advise/probe_max_size
Message-ID: <ZyJJ5Pvfj4Spcyo7@PC2K9PVX.TheFacebook.com>
References: <20241029202041.25334-1-gourry@gourry.net>
 <20241029202041.25334-2-gourry@gourry.net>
 <55df76a9-afa3-4dc0-a7f9-ff9b6f139448@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55df76a9-afa3-4dc0-a7f9-ff9b6f139448@redhat.com>

On Wed, Oct 30, 2024 at 11:25:33AM +0100, David Hildenbrand wrote:
> On 29.10.24 21:20, Gregory Price wrote:
> > Hotplug memory sources may have opinions on what the memblock size
> > should be - usually for alignment purposes.  For example, CXL memory
> > extents can be 256MB with a matching alignment. If this size/alignment
> > is smaller than the block size, it can result in stranded capacity.
> > 
> > Implement memory_block_advise_max_size for use prior to allocator init,
> > for software to advise the system on the max block size.
> > 
> > Implement memory_block_probe_max_size for use by arch init code to
> > calculate the best block size. Use of advice is architecture defined.
> > 
> > The probe value can never change after first probe. Calls to advise
> > after probe will return -EBUSY to aid debugging.
> > 
> > On systems without hotplug, always return -ENODEV and 0 respectively.
> > 
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >   drivers/base/memory.c  | 48 ++++++++++++++++++++++++++++++++++++++++++
> >   include/linux/memory.h | 10 +++++++++
> >   2 files changed, 58 insertions(+)
> > 
> > diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> > index 67858eeb92ed..099a972c52dc 100644
> > --- a/drivers/base/memory.c
> > +++ b/drivers/base/memory.c
> > @@ -110,6 +110,54 @@ static void memory_block_release(struct device *dev)
> >   	kfree(mem);
> >   }
> > +/**
> > + * memory_block_advise_max_size() - advise memory hotplug on the max suggested
> > + *				    block size, usually for alignment.
> > + * @size: suggestion for maximum block size. must be aligned on power of 2.
> > + *
> > + * Early boot software (pre-allocator init) may advise archs on the max block
> > + * size. This value can only decrease after initialization, as the intent is
> > + * to identify the largest supported alignment for all sources.
> > + *
> > + * Use of this value is arch-defined, as is min/max block size.
> > + *
> > + * Return: 0 on success
> > + *	   -EINVAL if size is 0 or not pow2 aligned
> > + *	   -EBUSY if value has already been probed
> > + */
> > +static size_t memory_block_advised_sz;
> 
> Nit: if everything is called "size", call this "size" as well.
> 

Mostly shortened here because

	if (memory_block_advised_sz)
		memory_block_advised_size = min(size, memory_block_advised_size);

is over 80 characters lol.  Happy to change if you have strong feelings.


> > +static bool memory_block_advised_size_queried;
> > +int memory_block_advise_max_size(size_t size)
> 
> Not that memory_block_size_bytes() uses "unsigned long". I don't think it
> matters here. Or could it on 32bit? (I assume that code will not really
> matter on 32bit)
> 

ack

> > +{
> > +	if (!size || !is_power_of_2(size))
> > +		return -EINVAL;
> > +
> > +	if (memory_block_advised_size_queried)
> > +		return -EBUSY;
> > +
> > +	if (memory_block_advised_sz)
> > +		memory_block_advised_sz = min(size, memory_block_advised_sz);
> > +	else
> > +		memory_block_advised_sz = size;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * memory_block_advised_max_size() - query advised max hotplug block size.
> > + *
> > + * After the first call, the value can never change. Callers looking for the
> > + * actual block size should use memory_block_size_bytes. This interface is
> > + * intended for use by arch-init when initializing the hotplug block size.
> > + *
> > + * Return: advised size in bytes, or 0 if never set.
> > + */
> > +size_t memory_block_advised_max_size(void)
> > +{
> > +	memory_block_advised_size_queried = true;
> > +	return memory_block_advised_sz;> +}
> > +
> 
> I wonder if both should.could be "__init" ? So they could only be called
> from __init ... which sounds like the tight thing to do?
> 

Was thinking the same thing in another thread, will go ahead and change it.

> Acked-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 
