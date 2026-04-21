Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9A31F997
	for <linux-cxl@vger.kernel.org>; Tue, 21 Apr 2026 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793336; cv=none; b=GXczqgsBAoLXzsiwfQiWFUpSbbDaOpL0uKKSSwj1bWijZ3nhqlWqB0SVBvYxbROkme8PGucf7JWiQnOrqx+MeGdrSGnbme5DM8TZLMmL6zCkEuHGKy96za2AGeOlvodx64w9HzxkWR1D50KPj6dh+/sQedh2+z94/PX7NpBLmgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793336; c=relaxed/simple;
	bh=meVYm0abCwJ39QMQ8J9mk7t7LT3l9hrrJngpI7uxkHs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC2HHk35J+4ts5AF9WEhQeHZ3oFlPblQXM4S4R8TVG32MHmy4r4K73zgUdQQ98yQ5O92hjt7+0S03rKVigZ17mWrdUwNUDB7p3aRHlu72blBow7alUcd3Lfxsa1bQL/uYOQQF+dfNhGzqiPdJwnQ1Jn72kKWvGQoq0HUOjskMFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdl9e+RJ; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdl9e+RJ"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6530dd51ccaso4344888d50.3
        for <linux-cxl@vger.kernel.org>; Tue, 21 Apr 2026 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776793334; x=1777398134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jJGT9V0fh+fbrCA4yWxV3NEel4uhGUnIv72PJk1oRhU=;
        b=kdl9e+RJP0r0DtZt7L4rbp1jGVkNVtsAhsyOi/NpWHVvlsKQZrzAXpz+8AdiabcGOf
         rCNaZHMkR+Uz9oUQu9a+huBGQSmKLa1JucaBEQr/dUvug9gSpJkFe4lF49fu1gXF8nvO
         wM/7XTwRWFwo2n8o+lUHAeBNYLiD4os5psNHSJsVJV/5D4Cu+IFudPkxMTJ3DcZMBH/R
         KNScVdMTLzVEzm36XDsSQWpt2sHZDffL5MWogmvj+nFxoeyO+xYJyAQjW4FMlFWU+RNm
         N54SbrtDn8AM/3QwmcJxxHryLpLXkzlpElyexRQZCaP22zLZBiQ8/ZvAJVAJ9nCgw3Do
         qiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776793334; x=1777398134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJGT9V0fh+fbrCA4yWxV3NEel4uhGUnIv72PJk1oRhU=;
        b=eq+yPE8JzR6yH4l2Kih0j87M0/iQBVRFMpx7cyUve/u8rEzg/9yHdHR2pngKwhNA0k
         Ezcz/QWaYDiVvvpUIBdF1zJK1mxZOqpFXAfiFladUuQR7WimNSYiNgSYZVa/vB0kPAjr
         hglpq5QoPGv4b29kl8cXmupfZLgT6uUsoKpIRVJDbncrBuIQ0DXfu5jD6bgyVzG+MHBB
         t7zXnSHsMmK4Q2TpvFm83RD9bzXjHyRCeSGj5ZzwIU8HJmknOJImrTDHdneuWlNSBiVm
         B5nWKI918Sxw0RrankfjtvaitCRvU/ATZn4NoQitGZuD104G/ouXtpi4BtgI4S7N0jW5
         4+jw==
X-Forwarded-Encrypted: i=1; AFNElJ/G/kx8qIzHIUK13ITohj3Dr/Mw1wUlmCccFxBn+tr9r1SYaZa2GghO8YGjUVx2CSNdf7f0GPqTZqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypxN6FcxF51Q2u7xaRkySxW04Jo62wCsFkxhZI+Uh0TQJPbl3D
	Yp5P91bHu71hlW5C0UhUzSXKuEQ1lEos8K7Y3jnNU1uNoXEngYiTxOlm
X-Gm-Gg: AeBDieu0jAU6gg9wEVEdZWALEnMyyzkawyk1YWI0e8OMbomcUtnWXvt2Ww3LROl5w3u
	Dyf5HajCwulfkqkYOpyGLJjYqK7iuuhVpvgfYR/HDNoJnNtU1UsASkMrQb+BrohDYtnVmoXyw+h
	ackmOZmpprBtOLb/cWh5MoVW2fgMDhdMWDoM2iofgoqygoYBkSkWQL7S67NKyu2WMMoB0ENIIZp
	mP3+x8rIBtragEVHolC074LHc5Myw5eIIcLRsq7PA5Q1hfNEGUacL5ekgRU/uZNMfwjmrJo6Yqv
	Zeymq05w9NA3Aa7nr5dv2lLvEIa9DCwX3jVOvUVy827gjf+yN0d85lSAntP2G93+52v16R18Iwf
	75caVS9xpgC5RBNyEReeaIvgjtvTSyGg1BdayUfZiDNsnpxl6oG4ExJ4UDcdeQKc8e184KYm6mH
	nU29OU+91vwBevDyVl3z6cC5R88o9lyRpx+usMHpbLWQIgV7BptVBi
X-Received: by 2002:a05:690e:4812:b0:650:1bf0:ca64 with SMTP id 956f58d0204a3-653107bd0camr12081457d50.8.1776793333949;
        Tue, 21 Apr 2026 10:42:13 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314ed1150sm6897711d50.18.2026.04.21.10.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:42:13 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 21 Apr 2026 10:42:09 -0700
To: John Groves <john@groves.net>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	dave.jiang@intel.com, gourry@gourry.net, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [RFC PATCH 00/20] DCD: Remove support for sparse regions & add
 tags
Message-ID: <aee28bKNdlFTn4xs@4470NRD-ASU.ssi.samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
 <aeeX7sSGiW4VRCIH@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeeX7sSGiW4VRCIH@groves.net>

On Tue, Apr 21, 2026 at 10:30:33AM -0500, John Groves wrote:
> On 26/04/10 06:22PM, Anisa Su wrote:
> > This RFC modifies Ira's DCD patchset to enforce tags and remove sparse DAX region
> > support, which are the requirements that I've understood from the community
> > meetings, with the end goal of FAMFS as the end user for DCD. Feedback would be
> > greatly appreciated to let me know if this is on the right track? Or totally off
> > the mark...
> > 
> > Everything is the same as before except:
> > - extents must have tags (uuids)
> > - 1 tag per region
> > - regions must be contiguous (no more sparse regions)
> > 
> > To achieve this, the main thing is to change the relationship between
> > cxl_dax_region : region_extent from 1 : many to 1 : 1. Each region_extent is
> > comprised of 1+ contiguous device extents with the same tag. Contiguity
> > is enforced by sorting device extents by DPA order. They're re-sorted by the
> > original order in which they were sent for the response, which is required by
> > the spec.
> > 
> > Once valid extents have been collected, it's passed as 1 contiguous capacity
> > to the DAX layer via cxl_dax_region notify(). Once notified, the same region
> > cannot be added to again, unless all extents are released.
> > 
> > For release: upon receiving a release event record, if the extent is within the
> > bounds of any cxl_region, and it has the correct tag, then all extents in the
> > region are released, so the "More" flag is still ignored. Not sure if this is the
> > right way to do it but it was the simplest.
> > 
> > The changes to the DAX layer remain untouched, as all of this extra validation is done
> > in the CXL layer. And since FAMFS already takes care of the devdax -> fsdev conversion,
> > there was no need to add anything there.
> > 
> > Most of the series remains unchanged as I've tried not to make too many big changes
> > right off the bat. Only the following commits were modified:
> > - cxl/extent: Process dynamic partition events and realize region extents
> > - dax/region: Create resources on DAX regions
> > - cxl/region: Read existing extents on region creation
> > 
> > i've tacked on 1 commit at the end to change the driver type of dc regions from
> > daxdrv_kmem_type to daxdrv_device_type so it can be bound to the new fsdev driver.
> > 
> > also, i've documented with more detail in the commit messages of the commits
> > that were modified on what exactly was changed, so i hope that's clear.
> > 
> > ================================================================================
> > git history
> > 
> > this series is based on cxl-next, with base commit:
> > 3939dba00f98 Merge branch 'for-7.1/cxl-misc' into cxl-for-next
> > + bug fix: https://lore.kernel.org/linux-cxl/20260411011137.43545-1-anisa.su@samsung.com/T/#u
> > 
> > GH Branch: https://github.com/anisa-su993/anisa-linux-kernel/tree/dcd-rfc-04-10-26
> > 
> > It doesn't apply cleanly onto famfs-v9, although I have the version that's applied
> > onto famfs-v9 here: https://github.com/anisa-su993/anisa-linux-kernel/tree/famfs-v9-dcd
> > - famfs-v9 for reference: https://github.com/jagalactic/linux/tree/famfs-v9
> > 
> > I've tested the current series without famfs as well as the series applied on
> > famfs-v9 with famfs.
> > ================================================================================
> > Testing:
> > 
> > This patchset was tested with Ali's QEMU patchset adding tag support:
> > https://lore.kernel.org/linux-cxl/20260325184259.366-1-alireza.sanaee@huawei.com/T/#t
> > 
> > Details:
> > Topology: '-object memory-backend-file,id=cxl-mem1,mem-path=/tmp/t3_cxl1.raw,size=12G \
> >      -object memory-backend-file,id=cxl-lsa1,mem-path=/tmp/t3_lsa1.raw,size=1G \
> >      -device usb-ehci,id=ehci \
> >      -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
> >      -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
> >      -device cxl-type3,bus=cxl_rp_port0,id=cxl-dcd0,dc-regions-total-size=12G,num-dc-regions=1,sn=99 \
> >      -device usb-cxl-mctp,bus=ehci.0,id=usb1,target=cxl-dcd0\
> >      -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=12G,cxl-fmw.0.interleave-granularity=1k'
> > 
> > 1. Start VM (12GB)
> > 2. Issue QMP to add tagged backend (8GB):
> > { "execute": "qmp_capabilities" }
> > {
> >     "execute": "object-add",
> >     "arguments": {
> >         "qom-type": "memory-backend-ram",
> >         "id": "tm0",
> >         "size": 8589934592,
> >         "share": true,
> >         "tag": "5be13bce-ae34-4a77-b6c3-16df975fcf1a"
> >     }
> > }
> > 3. Create region on the VM: cxl create-region -m -d decoder0.0 -w 1 -s 8G mem0 -t dynamic_ram_a
> > 4. Issue QMP to add an 8GB extent:
> > { "execute": "qmp_capabilities" }
> > {
> >     "execute": "cxl-add-dynamic-capacity",
> >     "arguments": {
> >         "path": "/machine/peripheral/cxl-dcd0",
> >         "host-id": 0,
> >         "selection-policy": "prescriptive",
> >         "region": 0,
> >         "tag": "5be13bce-ae34-4a77-b6c3-16df975fcf1a",
> >         "extents": [
> >             {
> >                 "offset": 0,
> >                 "len": 8589934592
> >             }
> >         ]
> >     }
> > }
> > 5. Verify with sysfs:
> > root@bgt-140510-bm03:~# cat /sys/bus/cxl/devices/dax_region0/extent0.0/offset
> > 0x0
> > root@bgt-140510-bm03:~# cat /sys/bus/cxl/devices/dax_region0/extent0.0/length
> > 0x200000000
> > root@bgt-140510-bm03:~# cat /sys/bus/cxl/devices/dax_region0/extent0.0/uuid
> > 5be13bce-ae34-4a77-b6c3-16df975fcf1a
> > 
> > 6. daxctl create-device -r region0
> > [
> >   {
> >     "chardev":"dax0.1",
> >     "size":8589934592,
> >     "target_node":1,
> >     "align":2097152,
> >     "mode":"devdax"
> >   }
> > ]
> > created 1 device
> > 
> > Currently, QEMU only supports sending 1 extent in an add/release request, which
> > limits what I can test. However, I was able to verify that once extent(s) have
> > been added to a region, it can't be added to again (size cannot be increased).
> > 
> > Up to this point is what I test with this patchset. Then below is the additional
> > famfs tests for the version applied on famfs.
> > ================================================================================
> > 7. Install famfs userspace tool:
> > https://github.com/cxl-micron-reskit/famfs
> > 
> > 8.mkfs.famfs --v /dev/dax0.1 output:
> > devsize: 8589934592
> > Famfs Superblock:
> >   Filesystem UUID:   c33b4525-a2c7-4d64-9204-e8ed273b4ffb
> >   Device UUID:       ae887e6b-f886-45f9-bc55-f0696f3cd91d
> >   System UUID:       da314140-12e7-45c2-98b2-753d3bfe4f46
> >   role of this node: Owner
> >   alloc_unit:        0x200000
> >   OMF major version: 2
> >   OMF minor version: 1
> >   sizeof superblock: 200
> >   log size (bytes):  8388608
> >   primary: /dev/dax0.1   8589934592
> > 
> > Log stats:
> >   # of log entries in use: 0 of 15420
> >   Log size in use:          48
> >   Log size (total bytes)    8388608
> >   No allocation errors found
> > 
> > Capacity:
> >   Device capacity:        8.00G
> >   Bitmap capacity:        8.00G
> >   Sum of file sizes:      0.00G
> >   Allocated space:        0.01G
> >   Free space:             7.99G
> >   Space amplification:     inf
> >   Percent used:            0.1%
> > 
> > Famfs log:
> >   0 of 15420 entries used
> >   0 bad log entries detected
> >   0 files
> >   0 directories
> > 
> > 9. famfs smoke tests also succeed. The smoke tests include
> > some fio tests, which run some simulated workloads
> > 
> > :== Test Timing Summary
> > :==-------------------------------------------------------------------
> > :==  prepare              0:10
> > :==  test0                0:07
> > :==  test_shadow_yaml     0:04
> > :==  test1                0:22
> > :==  test2                0:12
> > :==  test3                0:03
> > :==  test4                0:10
> > :==  test_errors          0:01
> > :==  stripe_test          0:58
> > :==  test_pcq             1:26
> > :==  test_fio             0:34
> > :==-------------------------------------------------------------------
> > :==  TOTAL                4:27
> > :==-------------------------------------------------------------------
> > :==run_smoke completed successfully (Thu Apr  9 10:33:28 PM UTC 2026)
> > 
> > Anisa Su (1):
> >   dax/bus.c: make DC regions driver type DAXDRV_DEVICE_TYPE
> > 
> > Ira Weiny (19):
> >   cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
> >   cxl/mem: Read dynamic capacity configuration from the device
> >   cxl/cdat: Gather DSMAS data for DCD partitions
> >   cxl/core: Enforce partition order/simplify partition calls
> >   cxl/mem: Expose dynamic ram A partition in sysfs
> >   cxl/port: Add 'dynamic_ram_a' to endpoint decoder mode
> >   cxl/region: Add sparse DAX region support
> >   cxl/events: Split event msgnum configuration from irq setup
> >   cxl/pci: Factor out interrupt policy check
> >   cxl/mem: Configure dynamic capacity interrupts
> >   cxl/core: Return endpoint decoder information from region search
> >   cxl/extent: Process dynamic partition events and realize region
> >     extents
> >   cxl/region/extent: Expose region extent information in sysfs
> >   dax/bus: Factor out dev dax resize logic
> >   dax/region: Create resources on DAX regions
> >   cxl/region: Read existing extents on region creation
> >   cxl/mem: Trace Dynamic capacity Event Record
> >   tools/testing/cxl: Make event logs dynamic
> >   tools/testing/cxl: Add DC Regions to mock mem data
> > 
> >  Documentation/ABI/testing/sysfs-bus-cxl |  100 ++-
> >  drivers/cxl/core/Makefile               |    2 +-
> >  drivers/cxl/core/cdat.c                 |   11 +
> >  drivers/cxl/core/core.h                 |   47 +-
> >  drivers/cxl/core/extent.c               |  471 +++++++++++
> >  drivers/cxl/core/hdm.c                  |   13 +-
> >  drivers/cxl/core/mbox.c                 |  770 ++++++++++++++++-
> >  drivers/cxl/core/memdev.c               |   87 +-
> >  drivers/cxl/core/port.c                 |    5 +
> >  drivers/cxl/core/region.c               |   43 +-
> >  drivers/cxl/core/region_dax.c           |    6 +
> >  drivers/cxl/core/trace.h                |   65 ++
> >  drivers/cxl/cxl.h                       |   60 +-
> >  drivers/cxl/cxlmem.h                    |  124 ++-
> >  drivers/cxl/mem.c                       |    2 +-
> >  drivers/cxl/pci.c                       |  115 ++-
> >  drivers/dax/bus.c                       |  360 ++++++--
> >  drivers/dax/bus.h                       |    4 +-
> >  drivers/dax/cxl.c                       |   71 +-
> >  drivers/dax/dax-private.h               |   40 +
> >  drivers/dax/hmem/hmem.c                 |    2 +-
> >  drivers/dax/pmem.c                      |    2 +-
> >  include/cxl/cxl.h                       |    6 +
> >  include/cxl/event.h                     |   39 +
> >  include/linux/ioport.h                  |    3 +
> >  tools/testing/cxl/Kbuild                |    5 +-
> >  tools/testing/cxl/test/mem.c            | 1018 ++++++++++++++++++++---
> >  27 files changed, 3210 insertions(+), 261 deletions(-)
> >  create mode 100644 drivers/cxl/core/extent.c
> > 
> > -- 
> > 2.43.0
> > 
> 
> what commit or branch does this apply on top of? Not v7.0...
> 
This series was based on cxl-for-next: 3939dba00f98 Merge branch 'for-7.1/cxl-misc'
But I was dumb while resolving the merge conflicts when I rebased and dropped
1 loc which I need to add back in :( sorry...

But I also have a version of this that's based on famfs-v9, which I used to run
the famfs smoke tests. It's on github:
https://github.com/anisa-su993/anisa-linux-kernel/tree/famfs-v9-dcd

or I can send you the patches separately?

- Anisa
> Thanks!
> John
