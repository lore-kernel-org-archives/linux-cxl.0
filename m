Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0C3A4528
	for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 03:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776827728; cv=none; b=OoAOCN3FkIHELIIFATBHd4KvibCv/JS0TZoffmENfNNGW480lPvdqguql4/jGblxY0Dbalnezoaq3dAWLjBIbGk8qmontkelT7VGfGjWAbFgH/E50Ypu4pHDc/R0HTHvHPyixqyIm7K0S7CCJZZOmysTEZNpnf5utesoq+q+9AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776827728; c=relaxed/simple;
	bh=a7cP/xI1+En3Lvm2qTq/w+sFhLUAdd/NYXFCkoKemb4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A3j1OCQ6808B01sOQnahvtswbVN4AkDgkF2G+9vh6I0Joij6N0BtwS54b+5x6mRrxCmJDMC4IGYbvU+6O64xmRB1UbqgFmpN8sqJ80St3/7syezP4KTmMdZHYOr7yip2ayYWpr/rF2C5MO2T40sRRoZPfdEmrBCKVbRbS01eSOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id CA4CB161364;
	Wed, 22 Apr 2026 03:15:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf03.hostedemail.com (Postfix) with ESMTPA id 41CF26000A;
	Wed, 22 Apr 2026 03:15:13 +0000 (UTC)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id A69BAF4006A;
	Tue, 21 Apr 2026 23:15:12 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-09.internal (MEProxy); Tue, 21 Apr 2026 23:15:12 -0400
X-ME-Sender: <xms:QD3oad6sweGk3krAyrcKbO_DqznGut252CqDTfRDwMdqx7f5VhspEQ>
    <xme:QD3oaVvi_NwL24qpHUd8yjtWqKsj133KWEDTZIRga9I1P2NrkIWtGX-664peIhsQ2
    ZD_4l_48Bx1w_F99FCbqhOAFO3TdbUy_B44iov-sdJvQfZIZam81_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeifeduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdflohhhnhcu
    ifhrohhvvghsfdcuoehjohhhnhesghhrohhvvghsrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeffeegueehleetgfffgfejffelhfdttdelkedvteetieehvddugeegvdfhfedvtden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjghhrohhvvghsodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieehgeduieeludduqdeffeduje
    dtkeekjedqjhhohhhnpeepghhrohhvvghsrdhnvghtsehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnh
    hishgrrdhsuhekkeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvvhdrshhrihhn
    ihhvrghsuhhluhesghhmrghilhdrtghomhdprhgtphhtthhopehgohhurhhrhiesghhouh
    hrrhihrdhnvghtpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgr
    figvihdrtghomhdprhgtphhtthhopegrlhhishhonhdrshgthhhofhhivghlugesihhnth
    gvlhdrtghomhdprhgtphhtthhopegurghnrdhjrdifihhllhhirghmshesihhnthgvlhdr
    tghomhdprhgtphhtthhopegurghvvgdrjhhirghnghesihhnthgvlhdrtghomhdprhgtph
    htthhopehirhgrrdifvghinhihsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghjrgih
    jhhoshhhihesmhhitghrohhnrdgtohhm
X-ME-Proxy: <xmx:QD3oaWKxlRm8q-BcgzwrttEYFWqJbAbLWvu-4zH8qDP1plnnHCg6og>
    <xmx:QD3oaUoy4EnCRy5gMkZ_evK1tV3XzyFVXuV2xDy7qqHq9ZTxfl75Uw>
    <xmx:QD3oaUvwxQLe9Rw9GSatNccqHwnoXctXc0ognDELTocNaXfhLZQKbg>
    <xmx:QD3oaeL9-KCg9jv2VaEnXe4K-B2tdzOYjElk4o4XGnlMtuY-yDGKng>
    <xmx:QD3oaToIY8C47VnYR583pgOk2GeJfqB04lT2yb5_3fql_K7o88T3vxNO>
Feedback-ID: i3a164872:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6EBA5C40077; Tue, 21 Apr 2026 23:15:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 Apr 2026 22:14:42 -0500
From: "John Groves" <john@groves.net>
To: "Anisa Su" <anisa.su887@gmail.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "Dave Jiang" <dave.jiang@intel.com>, "Gregory Price" <gourry@gourry.net>,
 dave@stgolabs.net, "Jonathan Cameron" <jonathan.cameron@huawei.com>,
 "Alison Schofield" <alison.schofield@intel.com>,
 "Ira Weiny" <ira.weiny@intel.com>, "Dan Williams" <dan.j.williams@intel.com>,
 "Anisa Su" <anisa.su@samsung.com>, "Aravind Ramesh" <arramesh@micron.com>,
 "Ajay Joshi" <ajayjoshi@micron.com>, dev.srinivasulu@gmail.com
Message-Id: <fb7dc730-4e9f-43c7-b243-21130f6ca5cd@app.fastmail.com>
In-Reply-To: <aeeX7sSGiW4VRCIH@groves.net>
References: <20260411013958.47422-1-anisa.su@samsung.com>
 <aeeX7sSGiW4VRCIH@groves.net>
Subject: Re: [RFC PATCH 00/20] DCD: Remove support for sparse regions & add tags
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1hiqqiukbrh7sq8b4sp38ym3mghsrgeo
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 41CF26000A
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX1/45tQlf+Ax0PuMqxT1ACCwP/X5H+Z5HLw=
X-HE-Tag: 1776827713-972469
X-HE-Meta: U2FsdGVkX1+AEJyDgbUsvJHRlQoS3fzWksxaoA2ypE0da7Yg1ut1sujwKyQWFRDNcELsfuZbBQ3cEC0Pd52QklFx8UuPeISjtnC8RWvF5SXaE1cLKpski7h8BrjK7OmXx1iPy8hJqHwtXvt9THdJ0SF7B6y025r0tss0sHyty8i1uYT57jRSE1uhK6jpU1sGLPyI0BgC2ok6rPYNsfEXV4yqcEdVwTqNq0saPy+scG65Amp7WqWLq9Rf0MhYfR0mSwORZ84S66cS6H4BSBouPCsOmvkFbEpQYvuArOEkvfawpzyh5VtSH93zZLpSuarB94RNC3xLOQ4TZZ59klAM+QLC9AWtSIdnN0PuLu/r0hZp5Bad+NvQGyaAyYE1mld5wb13+gpRAwItP9SU86myuAOnRwgB2lb6



On Tue, Apr 21, 2026, at 10:30 AM, John Groves wrote:
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
> > I've tacked on 1 commit at the end to change the driver type of DC regions from
> > DAXDRV_KMEM_TYPE to DAXDRV_DEVICE_TYPE so it can be bound to the new fsdev driver.
> > 
> > Also, I've documented with more detail in the commit messages of the commits
> > that were modified on what exactly was changed, so I hope that's clear.
> > 
> > ================================================================================
> > Git History
> > 
> > This series is based on cxl-next, with base commit:
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
> Thanks!
> John

I've bounced around about the best way to do this, but I'm working on 
one patch at the end of this series that fixes up the tagged extent handling
to concatenate together all extents that share the same tag into one 
daxdev, in sequence number order (and fail if any of the extent boundaries 
are misaligned). The DPA ranges of the extents don't matter, provided the
boundary alignment is good. And the extents get assembled in sequence
number order, not DPA order.

Once we've agreed it's right, I'll help with squashing it sensibly if you like.

I'm close, but it's not quite ready. I should be able to send it Wednesday.

Then I'll try to channel Jonathan and to a general review pass on the series.
Actually, maybe I'll try to program AI Jonathan :D

Thanks for what you do Anisa,
John
