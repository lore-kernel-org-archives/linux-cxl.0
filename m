Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0F28466F
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776907447; cv=none; b=NmuovgyOhVZPN9Uo0thuqJHcevxcPHs/M9p3fO6Wp+WRNxpvnqfM8g9RJOUi9y9FD7gJOP9Y0WrJAddZ40wZSyGjxqOSiX4K32g1V+nYEF32VqnmpS0+D7BWqeelZ32XCp9lx5NGOHsC/3h9zqjscMKQA2CTqhQgTVDNQeMY6lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776907447; c=relaxed/simple;
	bh=S8UG2U0huUs4uqqVl47I6aRuj2owsvXl0moUrbNiyuk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUj40haVvhBCEUC8PV9xQdo9ZdFwp9LyYsU65+naIeJlVStH8fZeYl3HW/r23q6YcHlUZZRs078Q59J4Z8LFW1rMusmcCtSbky5nvmoa2olQtI3j32GKUsXSSeucBKhlUpRUFkyfDYB+5DRfrrHmWY4/j7LGqTUCLGlmZVrM+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r23DixCM; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r23DixCM"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c156c4a9efso8380546eec.1
        for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 18:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776907444; x=1777512244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=47xp/VHTj89+GEuO6XgV2tYFmVxW9h7mBWFkN8AoYt4=;
        b=r23DixCMwpZ3PPNBMpkea4OUU4gjHSWyMcTAIlin5xv+/tBsWIeRkUJJPWDtu1Rfcc
         gNboXMowiXayiChM2Mm/XzQuEL44aavsCHaTyS5ijNIH5esaEi4FYGiVlRP4jhS367Ux
         MhEdUjcInPLbNXDJlgLtBbPuFZqDS8qDJzhPDlXeoWomto9gdi2OycX7vBRGIyQJ+OQz
         FvbzgP7uR0wlzGWyzngndWr7yT6MgKLRxeM1a47lTKEYwBOxtp1doIFq5ub/ECLjw/lA
         kN57oKOIMbh11wiIJmZklfeyQfRi4egA68xjnqpYvNpnnC6Td+Q8dw2jdcrDaR1wd6mF
         R4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776907444; x=1777512244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47xp/VHTj89+GEuO6XgV2tYFmVxW9h7mBWFkN8AoYt4=;
        b=mbWe8DczQTA7ffFtQqgq92leFMACEkqZ6hK9gIANnqEON4FjcHy4DZ0AOnXDr5uEEN
         GLBVubRuN9JtlkyEF7qWUk+EqafAWyRz4QmBQWTa3atq0q70wLMSAKWRxyLCHO+JfZYW
         0ynilDC/4qEuWgVpZdoGLuVi/WfRpxTNmon4XyJs+EvsbvKUHX1sXrPwkermt7hYpejL
         4w1qcn7fn7O2gs4LZfBEqe+QlcZxGQfX99RAQZsznmLbK+DNTi3NTOIvC7Ac6/BqnLi+
         mRpLTmpe26Rmb0/iFzOP4s44sgpLA5HiVXxFYVdns8cTVx3hRh4x0DPIS9UwN7sE7ga0
         8o9g==
X-Forwarded-Encrypted: i=1; AFNElJ9dZk5u+lV1YttHjj9CYpYzKRyEJZ1Jog/poNuq2mV5sHb/zEpMDuIFi0pD1WexHItFcD4kreaeSRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweq4eeRAAPFFaxN6lOGRWh0pcIs1lc/mk+FhVrIhwwgMLaIQAh
	3M6Me9vkF/OZ2PJojRx9b2vRiJHnxTO8DbsYyMEJnu0ykX29gvpma4Mx
X-Gm-Gg: AeBDieuhI5wvWg4jCJOd8f5m3o0fUzZg05fj64oIJhlURUxyAB69ifTZusWm4cWkSpu
	ov75q8F5cW+L6b6TNn4nGDkySx9FSoljV0DvpQTnHLgOoiQ3Di/ZJoRQj2d1mnIx6hrUWBecfW8
	YCHt2fJk9rSV/yM3iAhEG7lLf+OvNiRABMKWcHxe7ZgdZrM2rZs/OtaeHbKL2l82YXCOOlH3Z3Z
	Zt+2ynp8RxZ84AdAFo13ffz3r9BTTEUvtvIgp74/P1cOCPgD+8hNua+H7OU6hp/m0Jbr9ieJjFK
	kva9+e5UKRqePQ/X3p4ngZhEFa6HFutiHi1xQ1IcErxeN8Rs0gSCq0cTh2+wP+hQxxYec3J3EaU
	gS/b9AkDBC3n1SRNXB7LbaVl44xe9IsKebXuL/VaDrKffnIJgGpra8mM/3l1dxiqY3jBMhwoGAJ
	F6pO8KLiwCFKkwIBpkD0JEFpXn6jfQ3cy66bnlUMRs154ub6gdKfbJ39uec0z0JjC6bYUYwIAAE
	O01l6zgzOf6jVMcvqvBojI=
X-Received: by 2002:a05:7301:4591:b0:2d9:6373:ad24 with SMTP id 5a478bee46e88-2e479214a0emr13443956eec.26.1776907444236;
        Wed, 22 Apr 2026 18:24:04 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce460sm26156709eec.19.2026.04.22.18.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 18:24:03 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 22 Apr 2026 18:24:02 -0700
To: John Groves <john@groves.net>
Cc: Anisa Su <anisa.su887@gmail.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Gregory Price <gourry@gourry.net>, dave@stgolabs.net,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>, dev.srinivasulu@gmail.com
Subject: Re: [RFC PATCH 00/20] DCD: Remove support for sparse regions & add
 tags
Message-ID: <ael0sv3yABIxi_yu@4470NRD-ASU.ssi.samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
 <aeeX7sSGiW4VRCIH@groves.net>
 <fb7dc730-4e9f-43c7-b243-21130f6ca5cd@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb7dc730-4e9f-43c7-b243-21130f6ca5cd@app.fastmail.com>

On Tue, Apr 21, 2026 at 10:14:42PM -0500, John Groves wrote:
> 
> 
> On Tue, Apr 21, 2026, at 10:30 AM, John Groves wrote:
> > On 26/04/10 06:22PM, Anisa Su wrote:
> > > This RFC modifies Ira's DCD patchset to enforce tags and remove sparse DAX region
> > > support, which are the requirements that I've understood from the community
> > > meetings, with the end goal of FAMFS as the end user for DCD. Feedback would be
> > > greatly appreciated to let me know if this is on the right track? Or totally off
> > > the mark...
> > > 
> > > Everything is the same as before except:
> > > - extents must have tags (uuids)
> > > - 1 tag per region
> > > - regions must be contiguous (no more sparse regions)
> > > 
> > > To achieve this, the main thing is to change the relationship between
> > > cxl_dax_region : region_extent from 1 : many to 1 : 1. Each region_extent is
> > > comprised of 1+ contiguous device extents with the same tag. Contiguity
> > > is enforced by sorting device extents by DPA order. They're re-sorted by the
> > > original order in which they were sent for the response, which is required by
> > > the spec.
> > > 
> > > Once valid extents have been collected, it's passed as 1 contiguous capacity
> > > to the DAX layer via cxl_dax_region notify(). Once notified, the same region
> > > cannot be added to again, unless all extents are released.
> > > 
> > > For release: upon receiving a release event record, if the extent is within the
> > > bounds of any cxl_region, and it has the correct tag, then all extents in the
> > > region are released, so the "More" flag is still ignored. Not sure if this is the
> > > right way to do it but it was the simplest.
> > > 
> > > The changes to the DAX layer remain untouched, as all of this extra validation is done
> > > in the CXL layer. And since FAMFS already takes care of the devdax -> fsdev conversion,
> > > there was no need to add anything there.
> > > 
> > > Most of the series remains unchanged as I've tried not to make too many big changes
> > > right off the bat. Only the following commits were modified:
> > > - cxl/extent: Process dynamic partition events and realize region extents
> > > - dax/region: Create resources on DAX regions
> > > - cxl/region: Read existing extents on region creation
> > > 
> > > I've tacked on 1 commit at the end to change the driver type of DC regions from
> > > DAXDRV_KMEM_TYPE to DAXDRV_DEVICE_TYPE so it can be bound to the new fsdev driver.
> > > 
> > > Also, I've documented with more detail in the commit messages of the commits
> > > that were modified on what exactly was changed, so I hope that's clear.
> > > 
> > > ================================================================================
> > > Git History
> > > 
> > > This series is based on cxl-next, with base commit:
> > > 3939dba00f98 Merge branch 'for-7.1/cxl-misc' into cxl-for-next
> > > + bug fix: https://lore.kernel.org/linux-cxl/20260411011137.43545-1-anisa.su@samsung.com/T/#u
> > > 
> > > GH Branch: https://github.com/anisa-su993/anisa-linux-kernel/tree/dcd-rfc-04-10-26
> > > 
> > > It doesn't apply cleanly onto famfs-v9, although I have the version that's applied
> > > onto famfs-v9 here: https://github.com/anisa-su993/anisa-linux-kernel/tree/famfs-v9-dcd
> > > - famfs-v9 for reference: https://github.com/jagalactic/linux/tree/famfs-v9
> > > 
> > > I've tested the current series without famfs as well as the series applied on
> > > famfs-v9 with famfs.
> > > ================================================================================
> > > Testing:
> > > 
> > > This patchset was tested with Ali's QEMU patchset adding tag support:
> > > https://lore.kernel.org/linux-cxl/20260325184259.366-1-alireza.sanaee@huawei.com/T/#t
> > > 
> > > Details:
> > > Topology: '-object memory-backend-file,id=cxl-mem1,mem-path=/tmp/t3_cxl1.raw,size=12G \
> > >      -object memory-backend-file,id=cxl-lsa1,mem-path=/tmp/t3_lsa1.raw,size=1G \
> > >      -device usb-ehci,id=ehci \
> > >      -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
> > >      -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
> > >      -device cxl-type3,bus=cxl_rp_port0,id=cxl-dcd0,dc-regions-total-size=12G,num-dc-regions=1,sn=99 \
> > >      -device usb-cxl-mctp,bus=ehci.0,id=usb1,target=cxl-dcd0\
> > >      -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=12G,cxl-fmw.0.interleave-granularity=1k'
> > > 
> > > 1. Start VM (12GB)
> > > 2. Issue QMP to add tagged backend (8GB):
> > > { "execute": "qmp_capabilities" }
> > > {
> > >     "execute": "object-add",
> > >     "arguments": {
> > >         "qom-type": "memory-backend-ram",
> > >         "id": "tm0",
> > >         "size": 8589934592,
> > >         "share": true,
> > >         "tag": "5be13bce-ae34-4a77-b6c3-16df975fcf1a"
> > >     }
> > > }
> > > 3. Create region on the VM: cxl create-region -m -d decoder0.0 -w 1 -s 8G mem0 -t dynamic_ram_a
> > > 4. Issue QMP to add an 8GB extent:
> > > { "execute": "qmp_capabilities" }
> > > {
> > >     "execute": "cxl-add-dynamic-capacity",
> > >     "arguments": {
> > >         "path": "/machine/peripheral/cxl-dcd0",
> > >         "host-id": 0,
> > >         "selection-policy": "prescriptive",
> > >         "region": 0,
> > >         "tag": "5be13bce-ae34-4a77-b6c3-16df975fcf1a",
> > >         "extents": [
> > >             {
> > >                 "offset": 0,
> > >                 "len": 8589934592
> > >             }
> > >         ]
> > >     }
> > > }
> > > 5. Verify with sysfs:
> > > root@bgt-140510-bm03:~# cat /sys/bus/cxl/devices/dax_region0/extent0.0/offset
> > > 0x0
> > > root@bgt-140510-bm03:~# cat /sys/bus/cxl/devices/dax_region0/extent0.0/length
> > > 0x200000000
> > > root@bgt-140510-bm03:~# cat /sys/bus/cxl/devices/dax_region0/extent0.0/uuid
> > > 5be13bce-ae34-4a77-b6c3-16df975fcf1a
> > > 
> > > 6. daxctl create-device -r region0
> > > [
> > >   {
> > >     "chardev":"dax0.1",
> > >     "size":8589934592,
> > >     "target_node":1,
> > >     "align":2097152,
> > >     "mode":"devdax"
> > >   }
> > > ]
> > > created 1 device
> > > 
> > > Currently, QEMU only supports sending 1 extent in an add/release request, which
> > > limits what I can test. However, I was able to verify that once extent(s) have
> > > been added to a region, it can't be added to again (size cannot be increased).
> > > 
> > > Up to this point is what I test with this patchset. Then below is the additional
> > > famfs tests for the version applied on famfs.
> > > ================================================================================
> > > 7. Install famfs userspace tool:
> > > https://github.com/cxl-micron-reskit/famfs
> > > 
> > > 8.mkfs.famfs --v /dev/dax0.1 output:
> > > devsize: 8589934592
> > > Famfs Superblock:
> > >   Filesystem UUID:   c33b4525-a2c7-4d64-9204-e8ed273b4ffb
> > >   Device UUID:       ae887e6b-f886-45f9-bc55-f0696f3cd91d
> > >   System UUID:       da314140-12e7-45c2-98b2-753d3bfe4f46
> > >   role of this node: Owner
> > >   alloc_unit:        0x200000
> > >   OMF major version: 2
> > >   OMF minor version: 1
> > >   sizeof superblock: 200
> > >   log size (bytes):  8388608
> > >   primary: /dev/dax0.1   8589934592
> > > 
> > > Log stats:
> > >   # of log entries in use: 0 of 15420
> > >   Log size in use:          48
> > >   Log size (total bytes)    8388608
> > >   No allocation errors found
> > > 
> > > Capacity:
> > >   Device capacity:        8.00G
> > >   Bitmap capacity:        8.00G
> > >   Sum of file sizes:      0.00G
> > >   Allocated space:        0.01G
> > >   Free space:             7.99G
> > >   Space amplification:     inf
> > >   Percent used:            0.1%
> > > 
> > > Famfs log:
> > >   0 of 15420 entries used
> > >   0 bad log entries detected
> > >   0 files
> > >   0 directories
> > > 
> > > 9. famfs smoke tests also succeed. The smoke tests include
> > > some fio tests, which run some simulated workloads
> > > 
> > > :== Test Timing Summary
> > > :==-------------------------------------------------------------------
> > > :==  prepare              0:10
> > > :==  test0                0:07
> > > :==  test_shadow_yaml     0:04
> > > :==  test1                0:22
> > > :==  test2                0:12
> > > :==  test3                0:03
> > > :==  test4                0:10
> > > :==  test_errors          0:01
> > > :==  stripe_test          0:58
> > > :==  test_pcq             1:26
> > > :==  test_fio             0:34
> > > :==-------------------------------------------------------------------
> > > :==  TOTAL                4:27
> > > :==-------------------------------------------------------------------
> > > :==run_smoke completed successfully (Thu Apr  9 10:33:28 PM UTC 2026)
> > > 
> > > Anisa Su (1):
> > >   dax/bus.c: make DC regions driver type DAXDRV_DEVICE_TYPE
> > > 
> > > Ira Weiny (19):
> > >   cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
> > >   cxl/mem: Read dynamic capacity configuration from the device
> > >   cxl/cdat: Gather DSMAS data for DCD partitions
> > >   cxl/core: Enforce partition order/simplify partition calls
> > >   cxl/mem: Expose dynamic ram A partition in sysfs
> > >   cxl/port: Add 'dynamic_ram_a' to endpoint decoder mode
> > >   cxl/region: Add sparse DAX region support
> > >   cxl/events: Split event msgnum configuration from irq setup
> > >   cxl/pci: Factor out interrupt policy check
> > >   cxl/mem: Configure dynamic capacity interrupts
> > >   cxl/core: Return endpoint decoder information from region search
> > >   cxl/extent: Process dynamic partition events and realize region
> > >     extents
> > >   cxl/region/extent: Expose region extent information in sysfs
> > >   dax/bus: Factor out dev dax resize logic
> > >   dax/region: Create resources on DAX regions
> > >   cxl/region: Read existing extents on region creation
> > >   cxl/mem: Trace Dynamic capacity Event Record
> > >   tools/testing/cxl: Make event logs dynamic
> > >   tools/testing/cxl: Add DC Regions to mock mem data
> > > 
> > >  Documentation/ABI/testing/sysfs-bus-cxl |  100 ++-
> > >  drivers/cxl/core/Makefile               |    2 +-
> > >  drivers/cxl/core/cdat.c                 |   11 +
> > >  drivers/cxl/core/core.h                 |   47 +-
> > >  drivers/cxl/core/extent.c               |  471 +++++++++++
> > >  drivers/cxl/core/hdm.c                  |   13 +-
> > >  drivers/cxl/core/mbox.c                 |  770 ++++++++++++++++-
> > >  drivers/cxl/core/memdev.c               |   87 +-
> > >  drivers/cxl/core/port.c                 |    5 +
> > >  drivers/cxl/core/region.c               |   43 +-
> > >  drivers/cxl/core/region_dax.c           |    6 +
> > >  drivers/cxl/core/trace.h                |   65 ++
> > >  drivers/cxl/cxl.h                       |   60 +-
> > >  drivers/cxl/cxlmem.h                    |  124 ++-
> > >  drivers/cxl/mem.c                       |    2 +-
> > >  drivers/cxl/pci.c                       |  115 ++-
> > >  drivers/dax/bus.c                       |  360 ++++++--
> > >  drivers/dax/bus.h                       |    4 +-
> > >  drivers/dax/cxl.c                       |   71 +-
> > >  drivers/dax/dax-private.h               |   40 +
> > >  drivers/dax/hmem/hmem.c                 |    2 +-
> > >  drivers/dax/pmem.c                      |    2 +-
> > >  include/cxl/cxl.h                       |    6 +
> > >  include/cxl/event.h                     |   39 +
> > >  include/linux/ioport.h                  |    3 +
> > >  tools/testing/cxl/Kbuild                |    5 +-
> > >  tools/testing/cxl/test/mem.c            | 1018 ++++++++++++++++++++---
> > >  27 files changed, 3210 insertions(+), 261 deletions(-)
> > >  create mode 100644 drivers/cxl/core/extent.c
> > > 
> > > -- 
> > > 2.43.0
> > > 
> > 
> > what commit or branch does this apply on top of? Not v7.0...
> > 
> > Thanks!
> > John
> 
> I've bounced around about the best way to do this, but I'm working on 
> one patch at the end of this series that fixes up the tagged extent handling
> to concatenate together all extents that share the same tag into one 
> daxdev, in sequence number order (and fail if any of the extent boundaries 
> are misaligned). The DPA ranges of the extents don't matter, provided the
> boundary alignment is good. And the extents get assembled in sequence
> number order, not DPA order.
> 
> Once we've agreed it's right, I'll help with squashing it sensibly if you like.
> 
> I'm close, but it's not quite ready. I should be able to send it Wednesday.
> 
Ok sounds good!

Thanks,
Anisa
> Then I'll try to channel Jonathan and to a general review pass on the series.
> Actually, maybe I'll try to program AI Jonathan :D
> 
> Thanks for what you do Anisa,
> John
