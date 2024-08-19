Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD82512B8B
	for <linux-cxl@vger.kernel.org>; Mon, 19 Aug 2024 02:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724033559; cv=none; b=Ea+jXyxzR8r0aVDOz8PDoSMP/rKrWjPXerpnv+Tyg8RjtwZiVpBo4wYeaPP4xV5/1Zqm2NA7fvm+ZuYmq3QLWipHFBIN9+7QLArW49/0ak7WcbB1G+6wx6D77FvqWsnTb+8ObffnS39ULz+lJpjpuIWM5xpgOrlQIAw3lW9TiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724033559; c=relaxed/simple;
	bh=8V1EnnrP+rP0hoAVl91Egvi86Hqq6YQ4nuv5SU2Rl4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k05bgowS6WgdOM1oeG5rKeQUdHnqRKrWReDOOYn9yVXtonGFwps1/fwXMyX/W/zCQQHlWA1TGgv3dFOZBw+owxOQaWIcLxOSV6KAqvDntJlh0yu4jNnMxoxzqrcgaoqkwNCLs1jDql6BhXPETX2pg3CXtLAN/Evtmg2iBDWXFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrpQVlyU; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrpQVlyU"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5e97b8a22so2303135eaf.2
        for <linux-cxl@vger.kernel.org>; Sun, 18 Aug 2024 19:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724033557; x=1724638357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kuLzrxHtd3ErSvy/xkwzVOEiflzs3mXlwCUfMyo1XlY=;
        b=FrpQVlyU5eWrAvQPqKF5nSiibRzWjJY7XP2lFXaMLxzQ0P3L7VialSWjBRdK6uFNcI
         KDlekO5pM8OTvhv9wqHL1q4P+0kjxVpRUgzjunyhZ+7hVba+4QLI60Hfhggm0uhYOSkT
         z4KXW+Vt/hkhh7/c821m4qOnAp7BTiaCtC6J7Wba8U6afYUwlIw8RHdqQwl72CjTdz9E
         BggODwZXtarZVLlDSAWcXTIaZI6rzaqnHM/spqH/Rj58fXKG2MbYZAGSz7U34ebKSgPU
         fT160psMzCHt9Z5z0yJpL+5jYhLP6rr27+k6+UDvKxlJY33BoovOV2hEZYJHhaTi0+Xo
         yfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724033557; x=1724638357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuLzrxHtd3ErSvy/xkwzVOEiflzs3mXlwCUfMyo1XlY=;
        b=mZAj4kEatlnuuAMxx1qeMHsIfRn0WuY8zVuJGJ2Ki9ePtLpuj7qIl1IKnSFDDT2ofs
         17S6J17vBacUj1WMzyDl7v/9EKakMm837uSzeKVE+pWqE8HvsX9F1blGV/HjkyGYMCqD
         ONYgBYjiZcpM5UhcV3NLm7IDWjRra6aanBTmMj52FZSvlFes002ndGEeGwLuDVhUlYNe
         FaVoZCHJDO9qe0OLvEypclE7IOgFa+GdsghmWzfMHv2yLu8bF8JI0Qm8HHr6XO6zYiNF
         gcGsEVHvSV98k/bXaPLV133S7v2g6xjO84ktdOsDEaRkJFw9dtCJpg/cB6B5CLz8QmMr
         +Mhw==
X-Forwarded-Encrypted: i=1; AJvYcCXV9dMr1uLcolxJPIT4t6tpjfe/PjaycwYKnFAeuIUp/fwrEz8jJLfre2fnS9fnhYhT95zTqUqJ9QdKGId4G0yQLvwdm0Bj4ZIN
X-Gm-Message-State: AOJu0YwloYZGSnXziV1NTV2Z/Egvly+VX2eU7i/2MRP9zMIUSXMyEXWf
	zNmpg4oiTbXa7hDHjemLBnfLv3WBivQXHrOeGHkZTKeMUlt0WJvR
X-Google-Smtp-Source: AGHT+IGPFkOOeEpckRDFCUVwQIGGQr/JsPZgxRaMEz2IAoGo+sQFEwWCNUAzmF3eAuk+/dJ8qwreqw==
X-Received: by 2002:a05:6820:1624:b0:5da:a2fd:5af9 with SMTP id 006d021491bc7-5daa2fd7235mr7883905eaf.8.1724033556730;
        Sun, 18 Aug 2024 19:12:36 -0700 (PDT)
Received: from Borg-110.local (syn-070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5da8cf83db6sm1928759eaf.33.2024.08.18.19.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 19:12:36 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sun, 18 Aug 2024 21:12:34 -0500
From: John Groves <John@groves.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, 
	Ira Weiny <ira.weiny@intel.com>, virtualization@lists.linux.dev, 
	Oscar Salvador <osalvador@suse.de>, qemu-devel@nongnu.org, Dave Jiang <dave.jiang@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com, wangkefeng.wang@huawei.com, 
	John Groves <jgroves@micron.com>, Fan   Ni <fan.ni@samsung.com>, 
	Navneet   Singh <navneet.singh@intel.com>, =?utf-8?B?4oCcTWljaGFlbCBTLiBUc2lya2lu4oCd?= <mst@redhat.com>, 
	Igor Mammedov <imammedo@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Message-ID: <sjz2xzwkgkq6bun5lssqbsimbggczarotpjdhcsq3itoq5h7jc@x5ormqciwofo>
References: <20240815172223.00001ca7@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815172223.00001ca7@Huawei.com>

On 24/08/15 05:22PM, Jonathan Cameron wrote:
> Introduction
> ============
> 
> If we think application specific memory (including inter-host shared memory) is
> a thing, it will also be a thing people want to use with virtual machines,
> potentially nested. So how do we present it at the Host to VM boundary?
> 
> This RFC is perhaps premature given we haven't yet merged upstream support for
> the bare metal case. However I'd like to get the discussion going given we've
> touched briefly on this in a number of CXL sync calls and it is clear no one is

Excellent write-up, thanks Jonathan.

Hannes' idea of an in-person discussion at LPC is a great idea - count me in.

As the proprietor of famfs [1] I have many thoughts.

First, I like the concept of application-specific memory (ASM), but I wonder
if there might be a better term for it. ASM suggests that there is one
application, but I'd suggest that a more concise statement of the concept
is that the Linux kernel never accesses or mutates the memory - even though
multiple apps might share it (e.g. via famfs). It's a subtle point, but
an important one for RAS etc. ASM might better be called non-kernel-managed
memory - though that name does not have as good a ring to it. Will mull this
over further...

Now a few level-setting comments on CXL and Dynamic Capacity Devices (DCDs),
some of which will be obvious to many of you:

* A DCD is just a memory device with an allocator and host-level
  access-control built in.
* Usable memory from a DCD is not available until the fabric manger (likely
  on behalf of an orchestrator) performs an Initiate Dynamic Capacity Add
  command to the DCD.
* A DCD allocation has a tag (uuid) which is the invariant way of identifying
  the memory from that allocation.
* The tag becomes known to the host from the DCD extents provided via
  a CXL event following succesful allocation.
* The memory associated with a tagged allocation will surface as a dax device
  on each host that has access to it. But of course dax device naming &
  numbering won't be consistent across separate hosts - so we need to use
  the uuid's to find specific memory.

A few less foundational observations:

* It does not make sense to "online" shared or sharable memory as system-ram,
  because system-ram gets zeroed, which blows up use cases for sharable memory.
  So the default for sharable memory must be devdax mode.
* Tags are mandatory for sharable allocations, and allowed but optional for
  non-sharable allocations. The implication is that non-sharable allocations
  may get onlined automatically as system-ram, so we don't need a namespace
  for those. (I argued for mandatory tags on all allocations - hey you don't
  have to use them - but encountered objections and dropped it.)
* CXL access control only goes to host root ports; CXL has no concept of
  giving access to a VM. So some component on a host (perhaps logically
  an orchestrator component) needs to plumb memory to VMs as appropriate.

So tags are a namespace to find specific memory "allocations" (which in the
CXL consortium, we usually refer to as "tagged capacity").

In an orchestrated environment, the orchestrator would allocate resources
(including tagged memory capacity), make that capacity visible on the right
host(s), and then provide the tag when starting the app if needed.

if (e.g.) the memory cotains a famfs file system, famfs needs the uuid of the
root memory allocation to find the right memory device. Once mounted, it's a
file sytem so apps can be directed to the mount path. Apps that consume the
dax devices directly also need the uuid because /dev/dax0.0 is not invariant
across a cluster...

I have been assuming that when the CXL stack discovers a new DCD allocation,
it will configure the devdax device and provide some way to find it by tag.
/sys/cxl/<tag>/dev or whatever. That works as far as it goes, but I'm coming
around to thinking that the uuid-to-dax map should not be overtly CXL-specific.

General thoughts regarding VMs and qemu

Physical connections to CXL memory are handled by physical servers. I don't
think there is a scenario in which a VM should interact directly with the
pcie function(s) of CXL devices. They will be configured as dax devices
(findable by their tags!) by the host OS, and should be provided to VMs
(when appropriate) as DAX devices. And software in a VM needs to be able to
find the right DAX device the same way it would running on bare metal - by
the tag.

Qemu can already get memory from files (-object memory-backend-file,...), and
I believe this works whether it's an actual file or a devdax device. So far,
so good.

Qemu can back a virtual pmem device by one of these, but currently (AFAIK)
not a virtual devdax device. I think virtual devdax is needed as a first-class
abstraction. If we can add the tag as a property of the memory-backend-file,
we're almost there - we just need away to lookup a daxdev by tag.

Summary thoughts:

* A mechanism for resolving tags to "tagged capacity" devdax devices is
  essential (and I don't think there are specific proposals about this
  mechanism so far).
* Said mechanism should not be explicitly CXL-specific.
* Finding a tagged capacity devdax device in a VM should work the same as it
  does running on bare metal.
* The file-backed (and devdax-backed) devdax abstraction is needed in qemu.
* Beyond that, I'm not yet sure what the lookup mechanism should be. Extra
  points for being easy to implement in both physical and virtual systems.

Thanks for teeing this up!
John


[1] https://github.com/cxl-micron-reskit/famfs/blob/master/README.md

