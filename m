Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB07CF29
	for <linux-cxl@vger.kernel.org>; Tue, 12 Mar 2024 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260850; cv=none; b=O7LedULGCNXpllgJ92JjZ2gunlKpTuOMDnPNqi/lprstWjpNYlDoOtb9p93gjJ9QZAdDXjtqAmdb/iNiKmNF1ArS6w5nS2Aiw3T4pOc6ARaIstfe3F0+FRUbgWeYymOsrPPuDNxCehfNlXdITyf7mv9mN3IL8A5xpEYUOadCsWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260850; c=relaxed/simple;
	bh=IrrCeCvZmQxT1NJd494UuNSUDOnFL6sQeF4lrwJYytA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKsXY3uTmj0dLBmAdxFnZ/nc+du/+pPvByeNlIhTqVN5IA9CaaBorTmlp03D4OxrWxf5OB9RNSEAxOcX6L25DW2gkgjmzToC13t1RBzkl67mL3UtKHd61QHgFd/m5aqoBKMRVoR4gDBc7tBY9anVvS6Yar2a3AAlRTpOMdtZLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue/BTGkV; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue/BTGkV"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c8bd9837fdso31889039f.1
        for <linux-cxl@vger.kernel.org>; Tue, 12 Mar 2024 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710260848; x=1710865648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q55MnN0LvCb2kgiAr/MJm3d1SpDTvR8LT65JmJCoZ8s=;
        b=Ue/BTGkVeTV3IYLyhNnW3WWdtuobVnR74Illrbc3gMIcioY2gc8eSjiMVcKNZG5P9L
         fe6kW+hA6UlMvuKgk7HNLQCLvkI8pz0clyqukpIU2s/zWiZeRtyNOmTazC1Q3XlSp1KD
         rsqeDs//H4FEe1aeOPcXcVZs76nSBafLATTIWzbn+TlqYKLJ4kHvJwc1GwEtFlMY1PXy
         03NV7g0J7DrKM0QMpvmM3h42lKlk7fT+2VELVDL/Jx3UgFXf+lzqUBc9uAknNHm1OnnG
         IxjHPUuVkaUR8ddBbMGNo4LbdXaOptzNjSIMD6J0vCj23TnDCjZn0U0SSqV8GTegOgPC
         8hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710260848; x=1710865648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q55MnN0LvCb2kgiAr/MJm3d1SpDTvR8LT65JmJCoZ8s=;
        b=SIPrMVQV9WPpU8odOvaVzUj8WqhSF0ScAMBjBTPTnMH+92CutYxL3R4818XkKADijw
         Dov10/5yUSdBhS3o4dcye8vISS0/h/FuehjK9eB8R+8J4UTr3gTf9ZYKPzkSHp5ZPGeN
         1vjtq1qeo+4WItpElq7qV16CyC6QEEzq+0mcHN13m3RCgDAupB2EOH8F6CNZ/XYLduX2
         lX5143HpPGRtlpyBbm7A9kfnhW/6LH51SkSYrIdhGhfGMctAfgOKgI4L9ewaHzPVpPjO
         d3aqa4Cyr6weB9TwKSdfihEVxkgmNRxmCrJKwX5wZU5+VpeUACZLoNzSy4jHl7BgWDEx
         WIEA==
X-Forwarded-Encrypted: i=1; AJvYcCUGof3GEXTAXSv/NGFQTa/BpXoM17poXeEaXaeNII7AX3070oR30MDxxYmjU+RD9S5Qr5W44nmiCL3XTBu+YyxIEv3tgmOdktH7
X-Gm-Message-State: AOJu0YxlCQ4V971CfOLqXfD6chTPN9iA2ihKA5ybaas3zkrzPxpMn1Ze
	Z07lxLChx9Xy46NdCecFoK/JSfaSimGn9wj145pdoqC1N15hT9GC
X-Google-Smtp-Source: AGHT+IFg1zgxj0wdk8rTzy0XoCXK6YPLGLeQvgI8jQb6fEEi9suzWVyC+RtajJZm45LxWxsl8UQ1/Q==
X-Received: by 2002:a5d:8b09:0:b0:7c8:c659:b951 with SMTP id k9-20020a5d8b09000000b007c8c659b951mr4596389ion.7.1710260847974;
        Tue, 12 Mar 2024 09:27:27 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id h14-20020a02cd2e000000b00474d68c24e6sm2343499jaq.120.2024.03.12.09.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 09:27:27 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 12 Mar 2024 09:27:05 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, gregory.price@memverge.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com, jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZfCCWboh4w3NNVe4@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <20240306174811.000029fd@Huawei.com>
 <Zej5EuQXytgeWGfj@debian>
 <20240307124555.00001408@Huawei.com>
 <ZevnKbzBOy_9sjeg@debian>
 <20240312123723.0000420d@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312123723.0000420d@Huawei.com>

On Tue, Mar 12, 2024 at 12:37:23PM +0000, Jonathan Cameron wrote:
> On Fri, 8 Mar 2024 20:35:53 -0800
> fan <nifan.cxl@gmail.com> wrote:
> 
> > On Thu, Mar 07, 2024 at 12:45:55PM +0000, Jonathan Cameron wrote:
> > > ...
> > >   
> > > > > > +    list = records;
> > > > > > +    extents = g_new0(CXLDCExtentRaw, num_extents);
> > > > > > +    while (list) {
> > > > > > +        CXLDCExtent *ent;
> > > > > > +        bool skip_extent = false;
> > > > > > +
> > > > > > +        offset = list->value->offset;
> > > > > > +        len = list->value->len;
> > > > > > +
> > > > > > +        extents[i].start_dpa = offset + dcd->dc.regions[rid].base;
> > > > > > +        extents[i].len = len;
> > > > > > +        memset(extents[i].tag, 0, 0x10);
> > > > > > +        extents[i].shared_seq = 0;
> > > > > > +
> > > > > > +        if (type == DC_EVENT_RELEASE_CAPACITY ||
> > > > > > +            type == DC_EVENT_FORCED_RELEASE_CAPACITY) {
> > > > > > +            /*
> > > > > > +             *  if the extent is still pending to be added to the host,    
> > > > > 
> > > > > Odd spacing.
> > > > >     
> > > > > > +             * remove it from the pending extent list, so later when the add
> > > > > > +             * response for the extent arrives, the device can reject the
> > > > > > +             * extent as it is not in the pending list.
> > > > > > +             */
> > > > > > +            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
> > > > > > +                        &extents[i]);
> > > > > > +            if (ent) {
> > > > > > +                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
> > > > > > +                g_free(ent);
> > > > > > +                skip_extent = true;
> > > > > > +            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
> > > > > > +                /* If the exact extent is not in the accepted list, skip */
> > > > > > +                skip_extent = true;
> > > > > > +            }    
> > > > > I think we need to reject case of some extents skipped and others not.
> > > > > That's not supported yet so we need to complain if we get it at least. Maybe we need
> > > > > to do two passes so we know this has happened early (or perhaps this is a later
> > > > > patch in which case a todo here would help).    
> > > > 
> > > > Skip here does not mean the extent is invalid, it just means the extent
> > > > is still pending to add, so remove them from pending list would be
> > > > enough to reject the extent, no need to release further. That is based
> > > > on your feedback on v4.  
> > > 
> > > Ah. I'd missunderstood.  
> > 
> > Hi Jonathan,
> > 
> > I think we should not allow to release extents that are still pending to
> > add. 
> > If we allow it, there is a case that will not work.
> > Let's see the following case (time order):
> > 1. Send request to add extent A to host; (A --> pending list)
> > 2. Send request to release A from the host; (Delete A from pending list,
> > hoping the following add response for A will fail as there is not a matched
> > extent in the pending list).
> 
> Definitely not allow the host to release something it hasn't accepted.
> Should allow QMP to release such entrees though (and same for fmapi when
> we get there). Any such requested from host should be treated as whatever
> it says to do if you release an extent that you don't have.

Not sure how it works here. If we allow QMP to release such extents and
clear the pending list entrees accordingly, later if the host response with
empty extent list, how can the device figure out which request the response is
for. The spec assumes the response comes in order, so the head of the
pending list should be removed from the pending list, however, if QMP
process already removed it.

The key problem here is for empty updated extent list, we do not have a way to
figure out the corresponding request as there is no DPA info to look
into.

> 
> > 3. Host send response to the device for the add request, however, for
> > some reason, it does not accept any of it, so updated list is empty,
> > spec allows it. Based on the spec, we need to drop the extent at the
> > head of the event log. Now we have problem. Since extent A is already
> > dropped from the list, we either cannot drop as the list is empty, which
> > is not the worst. If we have more extents in the list, we may drop the
> > one following A, which is for another request. If this happens, all the
> > following extents will be acked incorrectly as the order has been
> > shifted.
> >  
> > Does the above reasoning make sense to you?
> Absolutely.  I got confused here on who was doing release.
> Host definitely can't release stuff it hasn't successfully accepted.
> 
> Jonathan
> 

The assumption here is FM first initiates the request to add some
extents to the hosts, and later FM initiates to release the extents
while the extents has not been accepted by the host yet. 

Fan
> > 
> > Fan
> > 
> > >   
> > > > 
> > > > The loop here is only to collect the extents to sent to the event log. 
> > > > But as you said, we need one pass before updating pending list.
> > > > Actually if we do not allow the above case where extents to release is
> > > > still in the pending to add list, we can just return here with error, no
> > > > extra dry run needed. 
> > > > 
> > > > What do you think?  
> > > 
> > > I think we need a way to back out extents from the pending to add list
> > > so we can create the race where they are offered to the OS and it takes
> > > forever to accept and by the time it does we've removed them.
> > >   
> > > >   
> > > > >     
> > > > > > +        
> > > > > > +
> > > > > > +        /* No duplicate or overlapped extents are allowed */
> > > > > > +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> > > > > > +                              len / block_size)) {
> > > > > > +            error_setg(errp, "duplicate or overlapped extents are detected");
> > > > > > +            return;
> > > > > > +        }
> > > > > > +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> > > > > > +
> > > > > > +        list = list->next;
> > > > > > +        if (!skip_extent) {
> > > > > > +            i++;    
> > > > > Problem is if we skip one in the middle the records will be wrong below.    
> > > > 
> > > > Why? Only extents passed the check will be stored in variable extents and
> > > > processed further and i be updated. 
> > > > For skipped ones, since i is not updated, they will be
> > > > overwritten by following valid ones.  
> > > Ah. I'd missed the fact you store into the extent without a check on validity
> > > but only move the index on if they were valid. Then rely on not passing a trailing
> > > entry at the end.
> > > If would be more readable I think if local variables were used for the parameters
> > > until we've decided not to skip and the this ended with
> > > 
> > >         if (!skip_extent) {
> > >             extents[i] = (DCXLDCExtentRaw) {
> > >                 .start_dpa = ...
> > > 	        ...
> > >             };
> > >             i++
> > >         }
> > > We have local len already so probably just need
> > > uint64_t start_dpa = offset + dcd->dc.regions[rid].base;
> > > 
> > > Also maybe skip_extent_evlog or something like that to explain we are only
> > > skipping that part. 
> > > Helps people like me who read it completely wrong!
> > > 
> > > Jonathan
> > > 
> > >  
> > >   
> 
