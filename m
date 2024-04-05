Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD516C858
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339099; cv=none; b=Z1yblAZiFLSuqNYyiwXvslW21eGOTINP7JQ44sugm8Zil7fBIkDgC6lrtC4KM1iNhWdQ8+4qJXPHbUcQeud7UdYLv+mnNXtZYROwFXFj9wNAcA4aJzep6pcfa22oKXq7xzRYHTFgKddTUbFA80nrJkoyW6upCMBud73y8LYFr6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339099; c=relaxed/simple;
	bh=KU4awP022vMurDM7BOmuQhjkUY0eFq8ZivpdjqqD+FE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIbW7CRwOUOSrs2AXLrABGBIQBoKriFRMkbGKSjVXgH8n3X2+RBbPHaqpqFdHiTiYrn4iZx5DJfizCacCDQMjt6gXOAXi7ZF1UVbNIUi6GCEJ4XXoRx3lRx8YjzAtn6xNW/8boPr/BCQUIJo/6w0+ubugtj20OWyaWcOD6ddTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VB5SL2x8xz688jH;
	Sat,  6 Apr 2024 01:43:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B977B141548;
	Sat,  6 Apr 2024 01:44:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 18:44:53 +0100
Date: Fri, 5 Apr 2024 18:44:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gregory Price <gregory.price@memverge.com>
CC: <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240405184452.00007986@Huawei.com>
In-Reply-To: <ZhAh0Qmv2/VTe1wT@memverge.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
	<20240325190339.696686-10-nifan.cxl@gmail.com>
	<Zg2c+YauNGqhFfTW@memverge.com>
	<20240405132719.00005859@Huawei.com>
	<ZhAh0Qmv2/VTe1wT@memverge.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 5 Apr 2024 12:07:45 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Fri, Apr 05, 2024 at 01:27:19PM +0100, Jonathan Cameron wrote:
> > On Wed, 3 Apr 2024 14:16:25 -0400
> > Gregory Price <gregory.price@memverge.com> wrote:
> > 
> > A few follow up comments.
> >   
> > >   
> > > > +        error_setg(errp, "no valid extents to send to process");
> > > > +        return;
> > > > +    }
> > > > +    
> > > 
> > > I'm looking at adding the MHD extensions around this point, e.g.:
> > > 
> > > /* If MHD cannot allocate requested extents, the cmd fails */
> > > if (type == DC_EVENT_ADD_CAPACITY && dcd->mhd_dcd_extents_allocate &&
> > >     num_extents != dcd->mhd_dcd_extents_allocate(...))
> > > 	return;
> > > 
> > > where mhd_dcd_extents_allocate checks the MHD block bitmap and tags
> > > for correctness (shared // no double-allocations, etc). On success,
> > > it garuantees proper ownership.
> > > 
> > > the release path would then be done in the release response path from
> > > the host, as opposed to the release event injection.  
> > 
> > I think it would be polite to check if the QMP command on release
> > for whether it is asking something plausible - makes for an easier
> > to user QMP interface.  I guess it's not strictly required though.
> > What races are there on release?  
> 
> The only real critical section, barring force-release beign supported,
> is when you clear the bits in the device allowing new requests to swipe
> those blocks. The appropriate place appears to be after the host kernel
> has responded to the release extent request.

Agreed you can't release till then, but you can check if it's going to 
work.  I think that's worth doing for ease of use reasons.

> 
> Also need to handle the case of multiple add-requests contending for the
> same region, but that's just an "oops failed to get all the bits, roll
> back" scenario - easy to handle.
> 
> Could go coarse-grained to just lock access to the bitmap entirely while
> operating on it, or be fancy and use atomics to go lockless. The latter
> code already exists in the Niagara model for reference.

I'm fine either way, though I'd just use a lock in initial version()

> 
> > We aren't support force release
> > for now, and for anything else, it's host specific (unlike add where
> > the extra rules kick in).   AS such I 'think' a check at command
> > time will be valid as long as the host hasn't done an async
> > release of capacity between that and the event record.  That
> > is a race we always have and the host should at most log it and
> > not release capacity twice.
> >  
> 
> Borrowing from the Ira's flow chart, here are the pieces I believe are
> needed to implement MHD support for DCD.
> 
> Orchestrator      FM         Device       Host Kernel    Host User
> 
>     |             |           |            |              |
>     |-- Add ----->|-- Add --->A--- Add --->|              |
>     |  Capacity   |  Extent   |   Extent   |              |
>     |             |           |            |              |
>     |             |<--Accept--B<--Accept --|              |
>     |             |   Extent  |   Extent   |              |
>     |             |           |            |              |
>     |             |     ... snip ...       |              |
>     |             |           |            |              |
>     |-- Remove -->|--Release->C---Release->|              |
>     |  Capacity   |  Extent   |   Extent   |              |
>     |             |           |            |              |
>     |             |<-Release--D<--Release--|              |
>     |             |  Extent   |   Extent   |              |
>     |             |           |            |              |
> 
> 1. (A) Upon Device Receiving Add Capacity Request
>    a. the device sanity checks the request against local mappings
>    b. the mhd hook is called to sanity check against global mappings
>    c. the mhd bitmap is updated, marking the capacity owned by that head
> 
>    function: qmp_cxl_process_dynamic_capacity
> 
> 2. (B) Upon Device Receiving Add Dynamic Capacity Response
>    a. accepted extents are compared to the original request
>    b. not accepted extents are cleared from the bitmap (local and MHD)
>    (Note: My understanding is that for now each request = 1 extent)

Yeah but that is a restriction I think we need to solve soon.

> 
>    function: cmd_dcd_add_dyn_cap_rsp
> 
> 3. (C) Upon Device receiving Release Dynamic Capacity Request
>    a. check for a pending release request. If exists, error.

Not sure that's necessary - can queue as long as the head
can track if the bits are in a pending release state.

>    b. check that the bits in the MHD bitmap are actually set
Good.
> 
>    function: qmp_cxl_process_dynamic_capacity
> 
> 4. (D) Upon Device receiving Release Dynamic Capacity Response
>    a. clear the bits in the mhd bitmap
>    b. remove the pending request from the pending list
> 
>    function: cmd_dcd_release_dyn_cap
> 
> Something to note: The MHD bitmap is essentially the same as the
> existing DCD extent bitmap - except that it is located in a shared
> region of memory (mmap file, shm, whatever - pick one).

I think you will ideally also have a per head one to track head access
to the things offered by the mhd.

> 
> Maybe it's worth abstracting out the bitmap twiddling to make that
> backable by a file mmap'd SHARED and use atomics to twiddle the bits?
> 
> That would be about 90% of the way to MH-DCD.

> 
> Maybe flock() could be used for coarse locking on the a shared bitmap
> in the short term?  This mitigates your concern of using shm.h as
> the coordination piece, though i'm not sure how portable flock() is.
Sounds nice, but you are wondering into that pesky userspace stuff
where I'd have to google a lot to understand :)

Jonathan

> 
> ~Gregory

