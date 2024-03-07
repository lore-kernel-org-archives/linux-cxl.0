Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25312BEA9
	for <linux-cxl@vger.kernel.org>; Thu,  7 Mar 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815563; cv=none; b=LGJI/yByoKh0EgVKp0dVSNpUCh9g5ZEvKpJ1+ZBjpLpmV6L/iyp4tfWr2zMieW4ougypXRaBBMeQzcj7gHxOCbe9ux/eHmzrFVJCTp4YLN2zJNA6bB6AvXM8cpL+sUX3MafmfBmLFIVws4L8tbcbG9uUUBi9U+VLKoLxSIoH/iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815563; c=relaxed/simple;
	bh=SlJogLzvYYeT9CRECXRqDlOdOgt0RoPWrz/dbeBjN10=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5BtgusKxP9G1uP6UWFGkfPpz72+0tqic3pKN2LJDnnjFLl37zI0LYetLglNZewf6TGDbFXH844Mnw/WPcN3R1zwhVWF7hoIqzFSbI0M3c2DHDRgeafPj7io8073gfVGcv0pEAZqTpUYpzh9oCvBPZbJVzHhByG0n/tiPTTDKmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tr87p5JjBz6K9C7;
	Thu,  7 Mar 2024 20:41:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 147B3140736;
	Thu,  7 Mar 2024 20:45:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 12:45:56 +0000
Date: Thu, 7 Mar 2024 12:45:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240307124555.00001408@Huawei.com>
In-Reply-To: <Zej5EuQXytgeWGfj@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-10-nifan.cxl@gmail.com>
	<20240306174811.000029fd@Huawei.com>
	<Zej5EuQXytgeWGfj@debian>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

...

> > > +    list = records;
> > > +    extents = g_new0(CXLDCExtentRaw, num_extents);
> > > +    while (list) {
> > > +        CXLDCExtent *ent;
> > > +        bool skip_extent = false;
> > > +
> > > +        offset = list->value->offset;
> > > +        len = list->value->len;
> > > +
> > > +        extents[i].start_dpa = offset + dcd->dc.regions[rid].base;
> > > +        extents[i].len = len;
> > > +        memset(extents[i].tag, 0, 0x10);
> > > +        extents[i].shared_seq = 0;
> > > +
> > > +        if (type == DC_EVENT_RELEASE_CAPACITY ||
> > > +            type == DC_EVENT_FORCED_RELEASE_CAPACITY) {
> > > +            /*
> > > +             *  if the extent is still pending to be added to the host,  
> > 
> > Odd spacing.
> >   
> > > +             * remove it from the pending extent list, so later when the add
> > > +             * response for the extent arrives, the device can reject the
> > > +             * extent as it is not in the pending list.
> > > +             */
> > > +            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
> > > +                        &extents[i]);
> > > +            if (ent) {
> > > +                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
> > > +                g_free(ent);
> > > +                skip_extent = true;
> > > +            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
> > > +                /* If the exact extent is not in the accepted list, skip */
> > > +                skip_extent = true;
> > > +            }  
> > I think we need to reject case of some extents skipped and others not.
> > That's not supported yet so we need to complain if we get it at least. Maybe we need
> > to do two passes so we know this has happened early (or perhaps this is a later
> > patch in which case a todo here would help).  
> 
> Skip here does not mean the extent is invalid, it just means the extent
> is still pending to add, so remove them from pending list would be
> enough to reject the extent, no need to release further. That is based
> on your feedback on v4.

Ah. I'd missunderstood.

> 
> The loop here is only to collect the extents to sent to the event log. 
> But as you said, we need one pass before updating pending list.
> Actually if we do not allow the above case where extents to release is
> still in the pending to add list, we can just return here with error, no
> extra dry run needed. 
> 
> What do you think?

I think we need a way to back out extents from the pending to add list
so we can create the race where they are offered to the OS and it takes
forever to accept and by the time it does we've removed them.

> 
> >   
> > > +        
> > > +
> > > +        /* No duplicate or overlapped extents are allowed */
> > > +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> > > +                              len / block_size)) {
> > > +            error_setg(errp, "duplicate or overlapped extents are detected");
> > > +            return;
> > > +        }
> > > +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> > > +
> > > +        list = list->next;
> > > +        if (!skip_extent) {
> > > +            i++;  
> > Problem is if we skip one in the middle the records will be wrong below.  
> 
> Why? Only extents passed the check will be stored in variable extents and
> processed further and i be updated. 
> For skipped ones, since i is not updated, they will be
> overwritten by following valid ones.
Ah. I'd missed the fact you store into the extent without a check on validity
but only move the index on if they were valid. Then rely on not passing a trailing
entry at the end.
If would be more readable I think if local variables were used for the parameters
until we've decided not to skip and the this ended with

        if (!skip_extent) {
            extents[i] = (DCXLDCExtentRaw) {
                .start_dpa = ...
	        ...
            };
            i++
        }
We have local len already so probably just need
uint64_t start_dpa = offset + dcd->dc.regions[rid].base;

Also maybe skip_extent_evlog or something like that to explain we are only
skipping that part. 
Helps people like me who read it completely wrong!

Jonathan

 

