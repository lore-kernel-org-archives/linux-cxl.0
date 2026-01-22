Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65A7389465;
	Thu, 22 Jan 2026 22:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120062; cv=none; b=eynfjsZn9NFrK+C+he0qEHnxOC0EAWL+4cCLr9dZNo2WKzw5KinrHppO+RfnKVF82MUsTL5gLNXE7YWtWw6lfzZOBUdM+x5H3+35KbJ3n8yUyq98fCRAVQVTGFoYZRU9wTa39R63ERQr8+PiuMeuYZWBijRhS5+ReQ9MHoci53c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120062; c=relaxed/simple;
	bh=15s8hCm/sckjqd3FTQ4S5gHgqFVlvwgL/Ya1WvOKtuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDQwDjjPd+0Iox7mB78ciUewfAnrv1gm9Wnt0FfUO3EoN9bwwwubdLd8do8fpFGUpTG4ScNuDoGh4DkTpxrDqD87deEooNqNO3YuBOGTmXlv6ig4qibyCUCdtMc02tuz2u/y4hgUY2qNKUi0Z1gHHGPMCvreSTVRbX1Cv9hgj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW94mGBN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW94mGBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC6EC116C6;
	Thu, 22 Jan 2026 22:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769120061;
	bh=15s8hCm/sckjqd3FTQ4S5gHgqFVlvwgL/Ya1WvOKtuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GW94mGBNRj+3ZJKB3shZ+k1PaXZ4somyIsQvvQdYSHHE5or5lNqMnB59+evENwb2r
	 Mgokgr76fbFoJSSsFu/siS+hzD7E54krNABbDWGeWhs3RnQ1QeJ44F/OfcMMHGuSQQ
	 FHF4nNC/aHmmSwS4UwbRiTxMXEqq/HmOgxPcaFc69szMqLxQrsK9secgt5yuuL1CZ6
	 xpNdStLdXtqRXs+96VQEtxlKjp8JeinQHMXe40JUA/830wsmYbeHDP4e4hsAHPylKP
	 pCVvWP0j1GPZuwhAl9b9euDmMQMmV1q3/VYYzQXLOa4cXCKjqWXJBEUGjW2dljHoUi
	 Lq49/ui2DKS/Q==
Message-ID: <4d66eac3-1a2b-4d9d-8a9a-529a19758439@kernel.org>
Date: Thu, 22 Jan 2026 23:14:15 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cxl/region.c improvements and DAX/Hotplug plumbing
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, dave.jiang@intel.com,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, dave@stgolabs.net, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, vishal.l.verma@intel.com, benjamin.cheatham@amd.com,
 David Rientjes <rientjes@google.com>
References: <aXErSP1zKnv4koKG@gourry-fedora-PF4VCD3F>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
In-Reply-To: <aXErSP1zKnv4koKG@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This is a lot of stuff. In which meeting would you usually discuss these 
things?

Some of that (especially the interaction with core-mm) feels like it 
would be a good fit to discuss with he wider MM community in one of the 
bi-weekly mm meeting. (CCing David R.)

> My list of current discrete steps (some serial, some parallel):
> 
>     1) Internally formalize cxl_region.region_driver (no ABI exposure)
> 
>     3) Plumb additional information through to DAX based on driver
>        - dax-driver mode preference
>        - uuid for tagged capacity
> 
>     2) Create explicit sysram_driver
>        - Write in terms of DCD
>        - Tagged Extents:   use DAX glue to manage set of tagged extents
>        - Untagged Extents: Hotplug and manage directly
>        - new ABI: `region0/region_driver` - switch between [dax,sysram]
> 
>     4) Plumb additional hotplug policy from CXL into DAX and MHP
>        - dax0.0/hotplug  (atomic operation on all blocks)
>        - cxl region auto-online policy (region0/rctl/auto-online)
>        - block-protection policy? (memory_notifier controls)
>        - hiding memory blocks? (discussed in last meeting)

What is that about and what was the result of that discussion? :)

>        - ABI: `region0/rctl/*` controls
> 
>     5) Formalize DCD dax_region driver use
>        - each extent list = new dax device in devdax mode
>        - tags enforced to be globally unique
>        - dax_region.add_extents(tag, extent_list)
>            -> create new daxN.0
>            -> expose daxN.0/uuid
>        - dax_region.remove_extents(extent_list)
>        - dax_region.remove_tagged_extents(tag)
> 
>     6) Formalize DCD sysram_region driver use
>        - sysram_region.add_extents(tag, extent_list)
>            -> untagged capacity managed as individual memory blocks
>            -> tagged capacity managed with DAX glue
>        - sysram_region.remove_extents(extent_list) (untagged)
>        - sysram_region.remove_tagged_extents(tag)  (tagged)
> 
>     7) Add private_region infrastructure
>        - private_region driver design
>        - N_PRIVATE_MEMORY infrastructure
>        - derivative driver (in my case compressed memory)
>        - Probably wants memory_blocks hiding and/or retricted operations
> 

[...]

> ---------------------------------------------------------
> Problem: SysRAM Auto-Hotplug policy is too broadly scoped
> ---------------------------------------------------------
>    Hotplug SYSRAM indirection through DAX leads to complex auto-online
>    interactions and/or current policy options are too broad in scope.
>    (e.g. MHP_AUTO_ONLINE build option is bad cross-platform)
> 
>    Solution 1: Plumb auto-online policy from cxl_region into dax_kmem
> 
>      Build Options:
>         Default auto-online policy for auto-regions?
>         Moves scope from MHP-Global to CXL-local
> 
>      ABI: dax_region - regionN/rctl/auto-online
>         Gives the region creator a chance to define before probe()
> 
>    Solution 2:  Make a dedicated sysram_region with policy

What kind of region would that be?

> 
>    May want both solutions longer term (for tagged DCD capacity)
> 
>    ndctl extension:
>         cxl create-region --driver=sysram --auto-online=movable ?
> 


[...]

> ---------------------------------------------------------------
> Problem/Annoyance: DAX kmem per-block operation race conditions
> ---------------------------------------------------------------
>    DAX exposes SYSRAM regions as individual memory blocks, which
>    creates race conditions when trying to manage a set of blocks.
> 
>    Example: udev can have an auto-onlining policy that twiddles
>             memory_block bits while cxl driver is trying to unplug.
> 
>    Affects: DCD, SysRAM, potentially N_PRIVATE_MEMORY
> 
>    Solution 1: [unplug, online, online_movable] > dax0.0/hotplug
>                Does operation on all blocks under the hotplug lock.
> 
>    Solution 2: dedicated sysram_region driver w/ or w/o DAX.
>                Can support sparseness w/o DAX (see DCD problem)
> 	      Could use DAX for tagged DCD regions.
>                Tradeoff: May duplicate some DAX logic.

How would that look like?

> 
>    Solution 3: Hide nodeN/memory_block's w/ MHP Flag.
>                Issue: Possibly userland breaking.

Hacky. :)

> 
>    Solution 4: Prevent non-driver actions from changing state.
>                Also solves hotplug protection problem (see next)

The crucial part is solving what you spelled out in the description: 
"race conditions". Forbidding someone to re-configure system RAM sounds 
unnecessary.

For example, I use it a lot for testing issues with page migration while 
offlining memory from ZONE_MOVABLE.

> 
> Patch: Implements solution 1
> https://lore.kernel.org/linux-cxl/20260114235022.3437787-5-gourry@gourry.net/
> 
> --------------------------------------------------------------
> Problem: SYSRAM or N_PRIVATE want memory_block policy controls
> --------------------------------------------------------------
>    A SYSRAM or N_PRIVATE region may have an implied zone-policy to
>    protect - or N_PRIVATE blocks may want to restrict any operation.

Why is N_PRIVATE special here?

> 
>    Privileged userspace action could do this:
>      cat memoryN/state              => online_movable
>      cat memoryN/valid_zones        => movable
>      echo offline > memoryN/state   => offline
>      echo online > memoryN/state    => online
>      cat memoryN/valid_zones        => normal
> 
>    - A DCD driver wants to try to protect hotpluggability.
>    - userspace has no business twiddling private_region blocks.

Why?

> 
>    Solution: Prevent non-driver actions from changing state.

If you can handle race conditions properly, why disallow offline + 
re-online, for example? Sure, you could restrict the zone.

> 
>        Essentially, add memory_notifier to region_driver or DAX
>        that rejects operations according to driver-defined policy.
> 
>    May not require explicit, could be encoded in default region
>    driver policy (e.g. dcd implies protection).
> 
> Example Patch:
> https://lore.kernel.org/linux-cxl/20260114235022.3437787-6-gourry@gourry.net/


[...]

> ---------------------------------------------
> Problem: "Special" Device memory usage policy
> ---------------------------------------------
>     Memory devices may have special features that dictate use patterns.
>     They may also prefer using core mm/ services for basic operation.
>     (page_alloc, reclaim, migration, etc)
>     
>     But: This memory shouldn't be exposed as "Normal System RAM".
> 
>     Solution: N_PRIVATE_MEMORY node_state
> 
>     CXL Driver Piece: private_region driver
>         These drivers would know how to register N_PRIVATE_MEMORY
>         Would also allow device-specific usage behavior to be written.
>         Would likely be used by upper layer drivers rather than uapi.
> 
>     Example:  Compressed Memory
> 
>       general service can use page_alloc() for get_page_from_freelist()
>       region_driver registers memory on a compressed memory node
>       vmscan.c/memory-tiers.c calls back to driver to handle migration
> 
>     Example:  Accelerator Memory Region
> 
>        Accel library/drive does node-based allocs.
>        Driver callbacks might include write-faults (ZONE_DEVICE-esque
>          pattern that passes page ownership between CPU/GPU)
> 
>        Either way, driver applies mapping policy w/o accounting cargo
> 
>     Example:  Slow(er) memory
>        Some memory is "just memory", but might be particularly slow and
>        intended for use as a filesystem backend or as only a demotion
>        target.  Otherwise its allocated / mapped like any other memory,
>        but it still required isolation so isolated to the demotion path
>        and not a fallback allocation target

That doesn't quite fit the description of N_PRIVATE_MEMORY, though. Or 
what am I missing?


-- 
Cheers

David
