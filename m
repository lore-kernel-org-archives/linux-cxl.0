Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE99305066
	for <linux-cxl@vger.kernel.org>; Fri, 23 Jan 2026 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769128126; cv=none; b=SxfMlysYt3T/KKIgHR8x19HRyxuykYfNP4ICaS8G7MVN4E9yOjOSSEOiH1mZ5R0zV4dBzBgxNVkoTDB6NgcfDLe+Lo7G7rRW8+PeRXt20iGmyeOo5bbnVcpsJ2b30twl/dIuqOUw6+blTBv9FYSk6wof2zeQHsFRh+Sxmo8HLHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769128126; c=relaxed/simple;
	bh=CLu2Yq17aYmqM4LkqoKcf2RIYC2R/DknVeOLtc0bZGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idb5YLlkixvoK5rA1r9bXLkIRIRK1xaH+LydaDVN7GrF2k17XgOvSoXt5cfsKGsoyrHbB/kMVBULrxA3WV5EnJk7mKU74zzQk2zyy2R4OETE7xnaFcjtvDWg1KoaGZxUNkja5jfXkiK8pcCQCFensQevJ7MVOB2voRcFuFFUrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sTex8HEQ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sTex8HEQ"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89461ccc46eso32352426d6.2
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 16:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769128120; x=1769732920; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IFYgKhU8JAGQuJjWFIbGQPMHdR9zMmvtXkRE/aex1U0=;
        b=sTex8HEQQp3vah89i8+O7hh84DidLZQtBHw1mCl+K6YTYOgiMe3InmUiS2/IzfP+fU
         L3DIThXVCm5i6E/yxU+KnBuhY8sU3/dhTheD0NEpvnoXZIKCePc7OSsj4oy6YQljzd98
         wAAA1CNbjE8RULaWUsbwBWnS25/Bt7+Z5ZJLNf3vf0spHictHhkjqBLq1ptWrfgoKqLD
         Ws6PblsTysFIclW1IOe8Ayht3r/5rUGU/WfRQIJVBP5/Td5xHkRwKtyNW1hf+KhEQVo9
         noHe8heq8xhdHoyvk4EiAdrZochL4HbAIZXfvtM+uY43CRPSnwVKtzEUNCUmDauIc+mv
         0VyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769128120; x=1769732920;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFYgKhU8JAGQuJjWFIbGQPMHdR9zMmvtXkRE/aex1U0=;
        b=Fa8tOw5/vac0ccFMcTZ9aLqaFttgtpXsMRU1xoMO4OcU8Yd1Eo0mwF/LnZdhVgCjyY
         4DUZG6FY+0uXfalFuchviOl23/oLYk3RcBCoDvWOs3FshdjVVWuZHzJsPR4hTNvYo5Hb
         uP8d8KlzT/7lpAXUN0801P7QNbVGUvp3PEul7DTMRSYDrYkRLY4H0KWURC0sfaUUiZN/
         0mqFIXtnLe93vS+qCUkk+D6JT0h6oUBxQIzYM00vXefeIUjJeKiaAuMvXpBc6e5wVhMH
         R207mWc247bgk3ovYPCaQq9xhc9dmgND8x0ci428q+pjMP+c7ORIjrJ6asMjbJZ9Fgr2
         +HLQ==
X-Gm-Message-State: AOJu0YyIJSCygqqEgQ7HXx8jWETDxgKQVvOeku1LzgML7bogxD+yTN9C
	pvYtx/9SFOzM4DEeFL2ACCneosdmEqC4rl1JtNjQvdtPs6itbUk3PFGBQ0DlQKApgWM=
X-Gm-Gg: AZuq6aIwp8du6XQ86Ztf4gnkXOWVw3MS3NieAY74pQmg4h0plh96uvy3PuVKaRGK870
	dawbiRWdRUY2/ENKfjqic0W4JrtrR3m7O3T/huwJcIj4zImL24q8so1s4bSM3yl9a76R5Up6wWM
	e7zYZgxvM/iRSK5Iv8JxtymA4r7K2g3enWuBKXGl06jljdp5qFCvT0Y2t8PsjbYPwb97BD1/3WX
	gmGK6g7szzUFME0aDMmdLXntsDAPRkdZ0rMXBTSbGVttpQ3LUF7F1XqoNMGrODlw15Lsh631lmG
	9gGxzAkIA8bn4cxFh2C1pKX6N9l3xNj0l15ZZKtJD9Mte+zhFXc0udEwSOOf+WmG4doCGG6HLGg
	uaVmQNNh9pmHGXeN+SYMfC5xV/HBHmL1AZ9B51a2qOz6Ep1MviukqM7b9I0Gfmdi+JqnBDdcDeB
	ZNnUmtPc8vKwF5yBgNJxSZou6eeLgzW6+/ZvYjtiunenJy6TwAi/Zbm0PAZ4aJAqitNZfOCg==
X-Received: by 2002:a05:6214:1315:b0:894:7d25:d6ba with SMTP id 6a1803df08f44-89490187df0mr21475356d6.6.1769128119741;
        Thu, 22 Jan 2026 16:28:39 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894918c99c0sm5137846d6.32.2026.01.22.16.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 16:28:39 -0800 (PST)
Date: Thu, 22 Jan 2026 19:28:37 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	dave.jiang@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	vishal.l.verma@intel.com, benjamin.cheatham@amd.com,
	David Rientjes <rientjes@google.com>
Subject: Re: cxl/region.c improvements and DAX/Hotplug plumbing
Message-ID: <aXLAtVZ_bVwF9nBG@gourry-fedora-PF4VCD3F>
References: <aXErSP1zKnv4koKG@gourry-fedora-PF4VCD3F>
 <4d66eac3-1a2b-4d9d-8a9a-529a19758439@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d66eac3-1a2b-4d9d-8a9a-529a19758439@kernel.org>

On Thu, Jan 22, 2026 at 11:14:15PM +0100, David Hildenbrand (Red Hat) wrote:
> Some of that (especially the interaction with core-mm) feels like it would
> be a good fit to discuss with he wider MM community in one of the bi-weekly
> mm meeting. (CCing David R.)
> 

There is a Monthly Linux-DAX meeting, and a Monthly Linux-CXL meeting,
obviously this is a lot of cross-attendance.

Happy to attend additional discussion.  I was trying to shore up some of
the cxl-region plumbing aspects before going wider.

> >        - hiding memory blocks? (discussed in last meeting)
> 
> What is that about and what was the result of that discussion? :)
> 

It was just a question as to whether memory blocks are still useful
if the intent is to provide a collective hotplug interface. I don't
think there are any real proposals for this, just making note of it.

> >    Solution 2:  Make a dedicated sysram_region with policy
> 
> What kind of region would that be?

plumbing between regionN and dax_region kobjects

right now the kobject relationship is:

region0           <- cxl driver created kobject
  └dax_region0    <- default selects IORESOURCE_DAX_KMEM
  	└dax0.0   <- auto-probes on discovery

But there is baggage in the existing plumbing:

1) dax/cxl.c =>  hard-coded IORESOURCE_DAX_KMEM for dax_region
2) dax/bus.c =>  devdax is probed on discovery w/o manual bind step
3) cxl/core/region.c => BIOS-configured CXL regions automatically
   generate a dax_region, and this auto-creates a dax_kmem device
   which is subject to system-wide MHP policy.

This creates a backwards compatibility headache.

The same auto-plumbing is used in the manual creation path, so:

   echo regionN > cxl/decoder0.0/create_ram_region
   /* program decoders */
   echo regionN > cxl/drivers/region/bind

will pump the whole thing directly into dax_kmem and auto-online
according to system default MHP policy.  There's no intermediate
step in which the user can define preferences (unless you add
them as attributes to regionN - which is another option).

Adding the intermediate object:

regionN
  └sysram_region      <- encodes policy like hotplug and dax drv
  	└dax_regionN  <- which would be passed here on creation
		└dax0.0

lets the cxl-cli command to be more expressive:
   `cxl-cli create-region -t ram --driver=sysram` => kmem
   `cxl-cli create-region -t ram --driver=dax`    => device_dax

and would change the sysfs pattern to
	echo regionN > cxl/decoder0.0/create_ram_region
	echo regionN > cxl/drivers/sysram_region/bind
	echo online_movable > cxl/devices/dax_regionN/hotplug
        echo dax_regionN > cxl/drivers/dax_region/bind

and gives the user a chance to configure a policy before the region
is pumped all the way through to the endpoint dax driver.


(Much of the rest of this doc is QoL stuff that could be ignored)

> >    Solution 2: dedicated sysram_region driver w/ or w/o DAX.
> >                Can support sparseness w/o DAX (see DCD problem)
> > 	      Could use DAX for tagged DCD regions.
> >                Tradeoff: May duplicate some DAX logic.
> 
> How would that look like?

For untagged extents w/o dax:

    sysram_region->nr_range
    sysram_region->ranges[0 : nr_range-1]

    Extents in this list would be hotpluggable individually and
    could be returned to the DCD device individually

    sysram_region.c code would call hotplug directly, not via dax.
       - hence, this duplicates some DAX logic

The above just prevents needlessly creating dax-indirection for sysram
extents with only one destination:  add_memory_driver_managed()


For tagged extents:
    sysram_region->nr_regions
    sysram_region->dax_regions[0 : nr_regions]

    A set of tagged extents would only be hotpluggable as a group
    and could only be returned to the DCD as a group.

    it would also expose:  dax0.0/uuid  <- contains the tag


from this you get a cli command like

    cxl release-extents regionN [--id=X] [--tag=Y]

         translates to something like

    echo "release" > regionN/sysram_region/extents/[X,Y]

Something like this.

> > 
> >    Solution 4: Prevent non-driver actions from changing state.
> >                Also solves hotplug protection problem (see next)
> 
> The crucial part is solving what you spelled out in the description: "race
> conditions". Forbidding someone to re-configure system RAM sounds
> unnecessary.
> 
> For example, I use it a lot for testing issues with page migration while
> offlining memory from ZONE_MOVABLE.
> 

For most use-cases yes.  For something like FAMFS (distributed shared
memory), one system onlining a block as kmem could be potentially
destructive to an entirely separate physical server.

A small guardrail to prevent silly mistakes, but certainly not required

Probably not needed for sysram and normal dax regions.

But fair, I can drop this. If an actual issue shows up, this can be
restricted with memory_notifier pretty trivially.

> >     Example:  Slow(er) memory
> >        Some memory is "just memory", but might be particularly slow and
> >        intended for use as a filesystem backend or as only a demotion
> >        target.  Otherwise its allocated / mapped like any other memory,
> >        but it still required isolation so isolated to the demotion path
> >        and not a fallback allocation target
> 
> That doesn't quite fit the description of N_PRIVATE_MEMORY, though. Or what
> am I missing?

I suppose we could also explore a per-node fallback policy to accomplish
this - but there was also the LPC talk about trying to deprecate that
entirely.

For the filesystem piece, you're probably right.

~Gregory
