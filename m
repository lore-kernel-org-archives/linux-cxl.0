Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CAC2FF177
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411671; cv=none; b=YIJO/DfbiUX5i37ny9M1G4ZV1r7x/og/2GVvJxbu9J4Xooj9f8MHtDMbVSsP8lx/dHfi+53GVVXL6Qi7/4po8T25RpacgduFF8OcTP2K+N/rJt90dZNSUp0swXLlyrnw1V6P6+H4/LJPQP0IxSL0dHo3i1th0ldARYVJ23+8/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411671; c=relaxed/simple;
	bh=BqCvlqSVSE09C2/snd3R+i7XS2A8CrQ1CJT3b7m8rA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1qjy+au1eLVzrUrAxhZ3ftGFBTM7jUZu8OI0aGn2/yzScIhLt7mzmSZNu0h94ZLCH9+KW4Bx8VfTeoi/LbehInHChJex5MDL358G4lQgaJ8SKB72A+Kg2DNnHV81tUBxJWZp+5TjWPF/u/gy5isaq/rlmcUrHcd5kGpnli6eHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ob2N0NAs; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ob2N0NAs"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5013d163e2fso395091cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 09:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768411669; x=1769016469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U4FdywhLVayjs/og8ka5nlrVNCvxPIqbw9riK1WrSno=;
        b=Ob2N0NAsKIhz3NtQRO9Ai5DZZwfFVsiqfyX7I5lCBhNzrsXCS0NgfnkTjlttssU25Q
         1/qD5i62zaSlvwAMF+RKRZQFgb/J1a4dcUrJAWMkIakzVVSZ8L3ojX5nHfuoTOUrPIGJ
         5an/gKvMl1xfrFdZj17esVqoV+Rjpt6d9pH/1KZzj4/OGC3rApPFDA0n5QWa9VmibewC
         yw1Y8PMVXZHVApFCcxEpzSiOfMjDAofXUdZGSiTc5pYmijB3ROYKNvYgNvQD+SumTqdk
         CuVcO+5kAuBNITlQbJcMDPQRqAAO9Xk8I+zYfoXpu3V1/HPinkyoA7rHQ1WSW+Pxh+Ti
         Xc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768411669; x=1769016469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4FdywhLVayjs/og8ka5nlrVNCvxPIqbw9riK1WrSno=;
        b=f65CHqyvddbtBwbL4sU9UzVLwBH0Awqj3Opey/Yyq13SsRtMOKqT3OBEAlp4qadL93
         A6mcFQ51/oVncFZkjf/uUz24HeC4bkUlo4XLH/hAz08POdfvTOhTNWQ0UrqhKo1wYFex
         Vm2XXRbJNeZFbqGR8AxTD+oKHwozBYbP2QUKmrC1o4/PiJw6UQA/iqjl9LFICQ8CfIwo
         K6j542OppJRY4+icNpbNlt1d//+HjPJ4rRDb7AC27vLmbKoRTXJqMdylyaRLEd2fJhi/
         5pWroEXBpmaoLC+yYCAbjHh/mPRJd1QSH4MsdS9eKr1+QMiBQNS03TslDcy9H3y5csEZ
         kfwg==
X-Forwarded-Encrypted: i=1; AJvYcCWm5bsJWoJ1/thcx+6PUFxjIhx7/dju9TOSRCakgcCodqOqGZQ73DQRhsbPvdz78AcyVel5UJiUTMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHbYRoWJmmQzqpGmXqUlv6IhUPMDGQh4kR42rKE7WtG6AHMFfP
	AS3eRoy2MmLvyOni9+gJu4DdxofStpWEuQHrd4nid/idYUpynjgSL5GCKEbTVrrSKA0=
X-Gm-Gg: AY/fxX6YoSlLBeigu0EyiAnH6VINTXY077heFFsRdMhTd5ne6t1Q8ZeFwaqAxGlZ0te
	5XgHeZncvThCzLvwCubDSuEBFLrgpiC6CZ8Sw5zmKRCQkX64Mn0RMrWMXdpMSFSvif/ilGKGPwQ
	+A4AAr+AvwrBETtQtV9S5aiIaYwXxiZxwL5caNZEC2+XxWxftcHhkDN1xPVBnEsRe9Tz7Lu1VHm
	QhJHzyOvYCwyVZ2fg/dxXVN/qJAWSl3FYapzXzpggr2bwOydWEF8fN15+t+xsgje/7/bOFDXJIV
	G/MCTtiI/N0YO5AQ+e8SOXr/WrS3Gudh2LaCOFYEiELN2EnG6l89nrnNfhu9ZokMSM7sow4krrX
	tjjWTxvYqolWlXcu46sv28qHEmrL1KtXiLa2rfp/LxShfZNSKBDTRQ1w/0hbx9bV4G8AHoBmvvF
	18wcjFXEwtNumTJdiBJtXSC9hzgmdUuAuAD4rnw83R60PA0kK83oTwbrjc2M0l0X1woD7RFQ==
X-Received: by 2002:a05:622a:14cb:b0:4ee:1f22:3615 with SMTP id d75a77b69052e-5014827ba2dmr51922171cf.51.1768411668907;
        Wed, 14 Jan 2026 09:27:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148dd75d4sm18287131cf.2.2026.01.14.09.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:27:48 -0800 (PST)
Date: Wed, 14 Jan 2026 12:27:15 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 3/8] mm/memory_hotplug: add APIs for explicit online type
 control
Message-ID: <aWfR86RIKEvyZsh6@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-4-gourry@gourry.net>
 <b3d435d2-643f-4dad-9928-bc7fb5080181@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d435d2-643f-4dad-9928-bc7fb5080181@kernel.org>

On Wed, Jan 14, 2026 at 11:21:34AM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/14/26 09:51, Gregory Price wrote:
> > Add new memory hotplug APIs that allow callers to explicitly control
> > the online type when adding or managing memory:
> > 
> >    - Extend add_memory_driver_managed() with an online_type parameter:
> >      Callers can now specify MMOP_ONLINE, MMOP_ONLINE_KERNEL, or
> >      MMOP_ONLINE_MOVABLE to online with that type, MMOP_OFFLINE to leave
> >      memory offline, or MMOP_SYSTEM_DEFAULT to use the system default
> >      policy. Update virtio_mem to pass MMOP_SYSTEM_DEFAULT to maintain
> >      existing behavior.
> 
> I wonder if we rather want to add a new interface
> (add_and_online_memory_driver_managed()) where we can restrict it to known
> kernel modules that do not violate user-space onlining policies.
> 

I originally did this, but then add_memory_driver_managed is just

__add_memory_driver_managed(..., MMOP_SYSTEM_DEFAULT)

at that point, just update all the existing callers of
add_memory_driver_managed(..., mhp_default_etc) and make it explicit in
those call spaces that this is what's happening.

> For dax we know that user space will define the policy.
> 

Actually this may not always be true.  A driver spawning a dax on probe
might also end up selecting the policy... eventually... maybe... I might
be planning to add that glue between CXL and DAX so I can add some
config similar to the system-default policy to avoid systems with
multiple memory-devices being forced into the same policy

(e.g. CXL memory device can online auto in ZONE_MOVABLE, but the other
 device can have its own policy).

There's a weird corner case for CXL auto-regions (BIOS configured
everything but left the memory EFI_MEMORY_SP - so comes up as DAX).
I'm trying to keep those systems working the same as they have been
while the userland policy stuff catches up.  Early CXL patterns are :[

> > 
> >    - online_memory_range(): online a previously-added memory range with
> >      a specified online type (MMOP_ONLINE, MMOP_ONLINE_KERNEL, or
> >      MMOP_ONLINE_MOVABLE). Validates that the type is valid for onlining.
> 
> Why not simply online_memory() and offline_memory() ?
> 

stupidly: I thought online_memory existed lol, ack.

> > 
> >    - offline_memory(): offline a memory range without removing it. This
> >      is a wrapper around the internal __offline_memory() that handles
> >      locking. Useful for drivers that want to offline memory blocks
> >      before performing other operations.
> > 
> 
> These two should be not exported to arbitrary kernel modules. Use
> EXPORT_SYMBOL_FOR_MODULES() if required, or do not export them at all.
> 

hm, not sure i understand this.  Maybe you address their usage later in
dax_kmem_do_online and dax_kmem_do_offline, i'll come back around on
this.

I did see you were asking about why we need the offline state.  I'll
come back to it there.

> > diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> > index d5407264d72a..0f98bea6da65 100644
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -265,6 +265,7 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
> >   extern void try_offline_node(int nid);
> >   extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> >   			 struct zone *zone, struct memory_group *group);
> > +extern int offline_memory(u64 start, u64 size);
> 
> No new "extern" for functions.
> 

doh, habit matching surrounding code

> > index ab73c8fcc0f1..515ff9d18039 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1343,6 +1343,34 @@ static int online_memory_block(struct memory_block *mem, void *arg)
> >   	return device_online(&mem->dev);
> >   }
> > +/**
> > + * online_memory_range - online memory blocks in a range
> > + * @start: physical start address of memory region
> > + * @size: size of memory region
> > + * @online_type: MMOP_ONLINE, MMOP_ONLINE_KERNEL, or MMOP_ONLINE_MOVABLE
> 
> I wonder if we instead want something that consumes all parameters like
> 
> int online_or_offline_memory(int online_type)
> 
> Then it's easier to use and we don't really have to document the
> "online_type" that much to hand-select some values.
> 
> (I'm sure there are better nameing suggestions :) )
> 

mhp_do_the_thing(int online_type) :P

I can think about this.

> Should we document what happens if the memory is already online, but was
> onlined to a different zone?
> 

Yeah i'll do that, it should just refuse, since that's what dax does.

> > + *
> > + * @online_type specifies the online behavior: MMOP_ONLINE, MMOP_ONLINE_KERNEL,
> > + * MMOP_ONLINE_MOVABLE to online with that type, MMOP_OFFLINE to leave offline,
> > + * or MMOP_SYSTEM_DEFAULT to use the system default policy.
> > + *
> 
> I think we can simplify this documentation. Especially, one
> MMOP_SYSTEM_DEFAULT is gone.
>

ack

> > +/*
> > + * Try to offline a memory range. Might take a long time to finish in case
> > + * memory is still in use. In case of failure, already offlined memory blocks
> > + * will be re-onlined.
> > + */
> 
> Proper kerneldoc? :)
>

ack

~Gregory
