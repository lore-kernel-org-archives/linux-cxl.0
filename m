Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CD61EA74
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282484; cv=none; b=DxvKN9yQmcQH32g+eHSFByIAG7DtUPGxXPFKMTvFZKCStqLmSv9m5x+Nt5o/J9ca5AMTx1P58VgyeBqeArhtJebFOMkTCOSqwq5Y7NKK/Ja4IOL5q0Y/VfPSd4dpXyREzxqz/AZPoHA6KRY8SQoPcbM9y3xgTeJAhjSrTAjamt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282484; c=relaxed/simple;
	bh=+rXLzZdV9iVRpvoBxv7uegg29iS1vSPygQai1lL1Jto=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRVDURZyu7xBx/std7HsLSS0N3/ORD+Yv7trMF4yH0HY9wbD4ubzoy8yHuBfLe4tokLJjDOudj6go9Mnu+JgE71pjewCKS4nHFWoAEtjGaYyZgxYWLWuYjduI76cOVBeTImgHoxfRAWuxODb1Xm6c1MqcEyW5XOdHf6jNgDXoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TM1Xz4BQcz688d6;
	Fri, 26 Jan 2024 23:18:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CA2C140516;
	Fri, 26 Jan 2024 23:21:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 15:21:17 +0000
Date: Fri, 26 Jan 2024 15:21:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<nifan@outlook.com>, <jim.harris@samsung.com>
Subject: Re: [PATCH v3 0/9] Enabling DCD emulation support in Qemu
Message-ID: <20240126152116.00001dd3@Huawei.com>
In-Reply-To: <6556af1fc8791_1a4bd32947e@iweiny-mobl.notmuch>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
	<6556af1fc8791_1a4bd32947e@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 16 Nov 2023 16:09:03 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> nifan.cxl@ wrote:
> > From: Fan Ni <nifan.cxl@gmail.com>
> > 
> > 
> > The patch series are based on Jonathan's branch cxl-2023-09-26.  
> 
> Finally getting around to trying this new series and the patch series does not
> seem to apply on top of this branch?
> 
> Just to verify is this the top commit this work was based on?
> 
>    d4edf131bbac [jonathan/cxl-2023-09-26] cxl/vendor: SK hynix Niagara Multi-Headed SLD Device
> 
> I seem to have found some issue with CDAT checksumming[1] which I'm not quite
> sure about.
> 
> I went ahead and pulled your latest work from:
> 
>     https://github.com/moking/qemu-jic-clone.git dcd-dev
> 
>     abe893944bb3  hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions
> 
> It still has this same problem.
> 

> Before I dig into this, is this the latest dcd branch?
I've pushed out a new tree, but it's definitely in a may eat babies form...

gitlab.com/jic23/qemu cxl-2024-26-01-draft

Only had the most basic of testing so far.  DCD rebase was messy as I've dragged
it into the 'next to send upstream' location and various fixes including
Ira's CDAT one have gone out already.

I'm keen to try and land this in QEMU 9.0 which basically means we have until
the end of Feb to shake out any problems.

Some other work is at least somewhat built on top of this (because of the
need to deal with DCD regions as well as pmem and volatile ones).

Jonathan


> 
> Has anything changed in how you specify DCD devices on the qemu command line
> with this latest work?  Here is what I have:
> 
> ...
> -device cxl-type3,bus=hb0rp0,memdev=cxl-mem0,num-dc-regions=2,nonvolatile-dc-memdev=cxl-dc-mem0,id=cxl-dev0,lsa=cxl-lsa0,sn=0
> -device cxl-type3,bus=hb0rp1,memdev=cxl-mem1,num-dc-regions=2,nonvolatile-dc-memdev=cxl-dc-mem1,id=cxl-dev1,lsa=cxl-lsa1,sn=1
> -device cxl-type3,bus=hb1rp0,memdev=cxl-mem2,num-dc-regions=2,nonvolatile-dc-memdev=cxl-dc-mem2,id=cxl-dev2,lsa=cxl-lsa2,sn=2
> -device cxl-type3,bus=hb1rp1,memdev=cxl-mem3,num-dc-regions=2,nonvolatile-dc-memdev=cxl-dc-mem3,id=cxl-dev3,lsa=cxl-lsa3,sn=3
> ...
> 
> 
> Ira
> 
> [1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/
> 
>  
> > The main changes include,
> > 1. Update cxl_find_dc_region to detect the case the range of the extent cross
> >     multiple DC regions.
> > 2. Add comments to explain the checks performed in function
> >     cxl_detect_malformed_extent_list. (Jonathan)
> > 3. Minimize the checks in cmd_dcd_add_dyn_cap_rsp.(Jonathan)
> > 4. Update total_extent_count in add/release dynamic capacity response function.
> >     (Ira and Jorgen Hansen).
> > 5. Fix the logic issue in test_bits and renamed it to
> >     test_any_bits_set to clear its function.
> > 6. Add pending extent list for dc extent add event.
> > 7. When add extent response is received, use the pending-to-add list to
> >     verify the extents are valid.
> > 8. Add test_any_bits_set and cxl_insert_extent_to_extent_list declaration to
> >     cxl_device.h so it can be used in different files.
> > 9. Updated ct3d_qmp_cxl_event_log_enc to include dynamic capacity event
> >     log type.
> > 10. Extract the functionality to delete extent from extent list to a helper
> >     function.
> > 11. Move the update of the bitmap which reflects which blocks are backed with
> > dc extents from the moment when a dc extent is offered to the moment when it
> > is accepted from the host.
> > 12. Free dc_name after calling address_space_init to avoid memory leak when
> >     returning early. (Nathan)
> > 13. Add code to detect and reject QMP requests without any extents. (Jonathan)
> > 14. Add code to detect and reject QMP requests where the extent len is 0.
> > 15. Change the QMP interface and move the region-id out of extents and now
> >     each command only takes care of extent add/release request in a single
> >     region. (Jonathan)
> > 16. Change the region bitmap length from decode_len to len.
> > 17. Rename "dpa" to "offset" in the add/release dc extent qmp interface.
> >     (Jonathan)
> > 18. Block any dc extent release command if the exact extent is not already in
> >     the extent list of the device.
> > 
> > The code is tested together with Ira's kernel DCD support:
> > https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30
> > 
> > Cover letter from v2 is here:
> > https://lore.kernel.org/linux-cxl/20230724162313.34196-1-fan.ni@samsung.com/T/#m63039621087023691c9749a0af1212deb5549ddf
> > 
> > Last version (v2) is here:
> > https://lore.kernel.org/linux-cxl/20230725183939.2741025-1-fan.ni@samsung.com/
> > 
> > More DCD related discussions are here:
> > https://lore.kernel.org/linux-cxl/650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch/
> > 
> > 
> > 
> > Fan Ni (9):
> >   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> >     payload of identify memory device command
> >   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
> >     and mailbox command support
> >   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
> >     type3 memory devices
> >   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
> >     devices
> >   hw/mem/cxl_type3: Add host backend and address space handling for DC
> >     regions
> >   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
> >     list mailbox support
> >   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
> >     dynamic capacity response
> >   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
> >     extents
> >   hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions
> > 
> >  hw/cxl/cxl-mailbox-utils.c  | 469 +++++++++++++++++++++++++++++-
> >  hw/mem/cxl_type3.c          | 548 +++++++++++++++++++++++++++++++++---
> >  hw/mem/cxl_type3_stubs.c    |  14 +
> >  include/hw/cxl/cxl_device.h |  64 ++++-
> >  include/hw/cxl/cxl_events.h |  15 +
> >  qapi/cxl.json               |  60 +++-
> >  6 files changed, 1123 insertions(+), 47 deletions(-)
> > 
> > -- 
> > 2.42.0
> >   
> 
> 
> 

