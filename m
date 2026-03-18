Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BD63939C9;
	Wed, 18 Mar 2026 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823991; cv=none; b=MwyyOvNvp8RVP02JbCuuGyVxbvsw8FA9g2XXLWba+W+5sxkPFAo7wTocnrJJyBJviMIqw/4hTS87+M7/vufq+6p5nYOlno2l0sF2jEqQ10wfMKsBzZ20D2Xvecx1Bpyps+9JJQ7RVe19Qu3sOj3wmO+Wuu6jRh4zKLs7BiwEKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823991; c=relaxed/simple;
	bh=hlsD8LO9ExQzsDMc9/GoTSMCxjp+n8FGdWB39l3oGEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ef9HxwcOeC25qiH690Ox215eBuG+mNwDByS4OrAfr7eFvJu8tfQS3v1g3VnaI2biBOh1eZCxnQJUmbo1ih00cjHqpiSgkJRkCRhfcr0L0eVZng7xG8Dzg29Yn79gGobui7KTvn8Twr83rLjZBOCXYSVWV2PEwuw/jjeAlOld9ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjGLIYYC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjGLIYYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFD2C19424;
	Wed, 18 Mar 2026 08:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773823990;
	bh=hlsD8LO9ExQzsDMc9/GoTSMCxjp+n8FGdWB39l3oGEE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HjGLIYYCS/Bh9mCxklMCiMmbNHL6fgPurJobIe6qRh9VBaAC/iM7NdFpK2R9gynq0
	 JQhzfxF20REoqQrpyfhFeIKgnv0s02c5IzdxK4ygAdCZPnCPISsY/+vWed/V5NMn3Q
	 hbh6lnEkSBBDr/edhbOgD3aV8uiHumHo7oBs/RCz47g0qTz0emJX2XRgPJGP9Jpnn6
	 +z2s8BqjYQF27ck6Sc8NhgizwELcmrtXBe/3WvKOnWqIJ2HCibQOtA8HLzQfglUrKP
	 Qs/FNrBHPOrJxUTZBQsNASlIufisA29OabVDXYNLYn921/v08TvJssXH4ouDSomTon
	 vpqBO4fmTLd8w==
Message-ID: <217b154d-e4d1-4824-b2e3-fea82bc44402@kernel.org>
Date: Wed, 18 Mar 2026 09:53:05 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cxl/region.c improvements and DAX/Hotplug plumbing
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 dave.jiang@intel.com, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 vishal.l.verma@intel.com, benjamin.cheatham@amd.com,
 David Rientjes <rientjes@google.com>
References: <aXErSP1zKnv4koKG@gourry-fedora-PF4VCD3F>
 <4d66eac3-1a2b-4d9d-8a9a-529a19758439@kernel.org>
 <aXLAtVZ_bVwF9nBG@gourry-fedora-PF4VCD3F>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <aXLAtVZ_bVwF9nBG@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/23/26 01:28, Gregory Price wrote:
> On Thu, Jan 22, 2026 at 11:14:15PM +0100, David Hildenbrand (Red Hat) wrote:
>> Some of that (especially the interaction with core-mm) feels like it would
>> be a good fit to discuss with he wider MM community in one of the bi-weekly
>> mm meeting. (CCing David R.)
>>
> 
> There is a Monthly Linux-DAX meeting, and a Monthly Linux-CXL meeting,
> obviously this is a lot of cross-attendance.
> 
> Happy to attend additional discussion.  I was trying to shore up some of
> the cxl-region plumbing aspects before going wider.

Oh hey, I found an unanswered mail in my inbox :)

Sorry for stumbling over this that late.

> 
>>>        - hiding memory blocks? (discussed in last meeting)
>>
>> What is that about and what was the result of that discussion? :)
>>
> 
> It was just a question as to whether memory blocks are still useful
> if the intent is to provide a collective hotplug interface. I don't
> think there are any real proposals for this, just making note of it.

Okay, thanks.

> 
>>>    Solution 2:  Make a dedicated sysram_region with policy
>>
>> What kind of region would that be?
> 
> plumbing between regionN and dax_region kobjects
> 
> right now the kobject relationship is:
> 
> region0           <- cxl driver created kobject
>   └dax_region0    <- default selects IORESOURCE_DAX_KMEM
>   	└dax0.0   <- auto-probes on discovery
> 
> But there is baggage in the existing plumbing:
> 
> 1) dax/cxl.c =>  hard-coded IORESOURCE_DAX_KMEM for dax_region
> 2) dax/bus.c =>  devdax is probed on discovery w/o manual bind step
> 3) cxl/core/region.c => BIOS-configured CXL regions automatically
>    generate a dax_region, and this auto-creates a dax_kmem device
>    which is subject to system-wide MHP policy.
> 
> This creates a backwards compatibility headache.

Agreed.

> 
> The same auto-plumbing is used in the manual creation path, so:
> 
>    echo regionN > cxl/decoder0.0/create_ram_region
>    /* program decoders */
>    echo regionN > cxl/drivers/region/bind
> 
> will pump the whole thing directly into dax_kmem and auto-online
> according to system default MHP policy.  There's no intermediate
> step in which the user can define preferences (unless you add
> them as attributes to regionN - which is another option).
> 
> Adding the intermediate object:
> 
> regionN
>   └sysram_region      <- encodes policy like hotplug and dax drv
>   	└dax_regionN  <- which would be passed here on creation
> 		└dax0.0
> 
> lets the cxl-cli command to be more expressive:
>    `cxl-cli create-region -t ram --driver=sysram` => kmem
>    `cxl-cli create-region -t ram --driver=dax`    => device_dax
> 
> and would change the sysfs pattern to
> 	echo regionN > cxl/decoder0.0/create_ram_region
> 	echo regionN > cxl/drivers/sysram_region/bind
> 	echo online_movable > cxl/devices/dax_regionN/hotplug
>         echo dax_regionN > cxl/drivers/dax_region/bind
> 
> and gives the user a chance to configure a policy before the region
> is pumped all the way through to the endpoint dax driver.

Would that still be backwards-compatible?


>>>    Solution 2: dedicated sysram_region driver w/ or w/o DAX.
>>>                Can support sparseness w/o DAX (see DCD problem)
>>> 	      Could use DAX for tagged DCD regions.
>>>                Tradeoff: May duplicate some DAX logic.
>>
>> How would that look like?
> 
> For untagged extents w/o dax:
> 
>     sysram_region->nr_range
>     sysram_region->ranges[0 : nr_range-1]
> 
>     Extents in this list would be hotpluggable individually and
>     could be returned to the DCD device individually
> 
>     sysram_region.c code would call hotplug directly, not via dax.
>        - hence, this duplicates some DAX logic
> 
> The above just prevents needlessly creating dax-indirection for sysram
> extents with only one destination:  add_memory_driver_managed()
> 
> 
> For tagged extents:
>     sysram_region->nr_regions
>     sysram_region->dax_regions[0 : nr_regions]
> 
>     A set of tagged extents would only be hotpluggable as a group
>     and could only be returned to the DCD as a group.
> 
>     it would also expose:  dax0.0/uuid  <- contains the tag


Interesting.

> 
> 
> from this you get a cli command like
> 
>     cxl release-extents regionN [--id=X] [--tag=Y]
> 
>          translates to something like
> 
>     echo "release" > regionN/sysram_region/extents/[X,Y]
> 
> Something like this.
> 
>>>
>>>    Solution 4: Prevent non-driver actions from changing state.
>>>                Also solves hotplug protection problem (see next)
>>
>> The crucial part is solving what you spelled out in the description: "race
>> conditions". Forbidding someone to re-configure system RAM sounds
>> unnecessary.
>>
>> For example, I use it a lot for testing issues with page migration while
>> offlining memory from ZONE_MOVABLE.
>>
> 
> For most use-cases yes.  For something like FAMFS (distributed shared
> memory), one system onlining a block as kmem could be potentially
> destructive to an entirely separate physical server.

Right. But shouldn't we fail this already at the add_memory() stage?
Sounds like during onlining is a bit too late. Conceptually, the hotplug
as sysram was already wrong for famfs, or am I wrong?


> 
>>>     Example:  Slow(er) memory
>>>        Some memory is "just memory", but might be particularly slow and
>>>        intended for use as a filesystem backend or as only a demotion
>>>        target.  Otherwise its allocated / mapped like any other memory,
>>>        but it still required isolation so isolated to the demotion path
>>>        and not a fallback allocation target
>>
>> That doesn't quite fit the description of N_PRIVATE_MEMORY, though. Or what
>> am I missing?
> 
> I suppose we could also explore a per-node fallback policy to accomplish
> this - but there was also the LPC talk about trying to deprecate that
> entirely.

I'm looking forward to that LPC talk!

-- 
Cheers,

David
