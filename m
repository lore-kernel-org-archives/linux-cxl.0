Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB310A34
	for <linux-cxl@vger.kernel.org>; Sat,  9 Mar 2024 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709958971; cv=none; b=nyQTaWq4FRjmGSLoA+J8VIka2+Y8c+zsLdcerHfI96vl5rr+J2x8BQXec1Z+wkr3Fd1rXtVZ1r4i4JNB4eoRSFWVvdXY0+1hyj/QOttYvcz92H3zGTp4WjVcC7iIRIlv/sfwGGt39/RDsQ0uj3Lf/zi+NjKDkILxmr/pt5JIg+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709958971; c=relaxed/simple;
	bh=mPhWqVyUTxHklo6sqjEuD8L0KlKJ+qnEc3Q0WZV9+/0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsY4lBuAky7cKoGgBWDQHJhjmyKcLrwpmMTcpPZCSdEp/Vh1ERph2GRaWS+ZRMSBFNxx7jaJiEQ/+j8A+pSmZ5CqSOBMwju26TDmNGjBIiK4AeP8Dx9UrEpZSfRsJrjnvqrJgAAg+i8jxF3Qd57mj3E+zaWY8q7QcPYDwlL3kMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdErbn8N; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdErbn8N"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cedfc32250so1216642a12.0
        for <linux-cxl@vger.kernel.org>; Fri, 08 Mar 2024 20:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709958968; x=1710563768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=17QTZ3ChO1eXgGrWivTxrsCH7FEhKd/2ieF4d0cg6FY=;
        b=bdErbn8NweMB0XI+tenkSjI8aveGN6kPmMpThWQ5QprtoC9/clQQOP3PHrp4FlUs0Z
         6jnS5tFaVpgIf+hmZt9K8SmJpjDwxa9E36eh0aO18wkRwtSEVC5/DYPP/WZssgfYBZwq
         0qS31qMZ9o4Ri+kfzdR3qTnlRm83pbPE4WZQT6BdAlx2HGEj4/ekELYL4yd6rvf0d3PJ
         d1iTnjCEQXB9ZLBs3wyobPNw4WFa0YNhCKcSfn0Ej6xlzix2eaTpk3OFDPE53bglnNst
         oYwSJ4fjGiR1qly0ie+Ce9P7A02kzTNzZ42OOUw31uXG1ZGREHStwIAdSdK/73yP+Z6c
         vMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709958968; x=1710563768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17QTZ3ChO1eXgGrWivTxrsCH7FEhKd/2ieF4d0cg6FY=;
        b=FNlUMUWgW6ANff0hNfUYA6gt2cQNSXq4eGO0QK5/Vp3TrXGH4pLLj73sP1x1t9Zoh/
         Tibyt1whowoSHtABZNVbw4ex0tp2jFCb84BsjiHvcH3GJAAa7prm2h8qgEK5nmuFiQtv
         B/TDyWkmH9LZuTLfwECFvN2sKSGsh8D+uHN44IgR+QWaSL+lesdMaX1ZEwOC41WcW+yy
         bkD7lL8asQHwPF5HO90hswdE4iBPZU6Yan3WNxIIl1+UWT2j8FyNC9VlL1hrgPfXHpHd
         7MaDuy32rwRZ98TiV3zcUSnSa6gU9Gk5o7vr7qdn2kPNTxpfrmBaPoPdLPJ5Js3GebAR
         1v/w==
X-Forwarded-Encrypted: i=1; AJvYcCVajBrb75F2jWHObx6gWyJDJeLqpYzMjzja4OUUUd8oSODQbzgBuGcEgOA6RZL2xHbDOIIkhozMiT/ebnulJjQwNbbZ4CElysM9
X-Gm-Message-State: AOJu0YwMG+UZD3L55u+AhWQA3jYCdot74XykB7wu9MhTzpItY23T9W9R
	KVwCG4GpeOyZP04YmuYaMpoLX/MVcicAuY89+Yl/AiAN2gyvvvvg
X-Google-Smtp-Source: AGHT+IHqj1J7G7icMdcHF4VYXAM3cdtUJCEEsu6y22G16ihZCps0aV4hEpKjtF3l03Gi5sqh8IdTDw==
X-Received: by 2002:a17:902:b494:b0:1dc:ad86:8f41 with SMTP id y20-20020a170902b49400b001dcad868f41mr663573plr.28.1709958968499;
        Fri, 08 Mar 2024 20:36:08 -0800 (PST)
Received: from debian ([2601:641:300:14de:68d6:5df5:5646:a413])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902ea0500b001dbc3f2e7e8sm452336plg.98.2024.03.08.20.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 20:36:08 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 8 Mar 2024 20:35:53 -0800
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
Message-ID: <ZevnKbzBOy_9sjeg@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <20240306174811.000029fd@Huawei.com>
 <Zej5EuQXytgeWGfj@debian>
 <20240307124555.00001408@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307124555.00001408@Huawei.com>

On Thu, Mar 07, 2024 at 12:45:55PM +0000, Jonathan Cameron wrote:
> ...
> 
> > > > +    list = records;
> > > > +    extents = g_new0(CXLDCExtentRaw, num_extents);
> > > > +    while (list) {
> > > > +        CXLDCExtent *ent;
> > > > +        bool skip_extent = false;
> > > > +
> > > > +        offset = list->value->offset;
> > > > +        len = list->value->len;
> > > > +
> > > > +        extents[i].start_dpa = offset + dcd->dc.regions[rid].base;
> > > > +        extents[i].len = len;
> > > > +        memset(extents[i].tag, 0, 0x10);
> > > > +        extents[i].shared_seq = 0;
> > > > +
> > > > +        if (type == DC_EVENT_RELEASE_CAPACITY ||
> > > > +            type == DC_EVENT_FORCED_RELEASE_CAPACITY) {
> > > > +            /*
> > > > +             *  if the extent is still pending to be added to the host,  
> > > 
> > > Odd spacing.
> > >   
> > > > +             * remove it from the pending extent list, so later when the add
> > > > +             * response for the extent arrives, the device can reject the
> > > > +             * extent as it is not in the pending list.
> > > > +             */
> > > > +            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
> > > > +                        &extents[i]);
> > > > +            if (ent) {
> > > > +                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
> > > > +                g_free(ent);
> > > > +                skip_extent = true;
> > > > +            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
> > > > +                /* If the exact extent is not in the accepted list, skip */
> > > > +                skip_extent = true;
> > > > +            }  
> > > I think we need to reject case of some extents skipped and others not.
> > > That's not supported yet so we need to complain if we get it at least. Maybe we need
> > > to do two passes so we know this has happened early (or perhaps this is a later
> > > patch in which case a todo here would help).  
> > 
> > Skip here does not mean the extent is invalid, it just means the extent
> > is still pending to add, so remove them from pending list would be
> > enough to reject the extent, no need to release further. That is based
> > on your feedback on v4.
> 
> Ah. I'd missunderstood.

Hi Jonathan,

I think we should not allow to release extents that are still pending to
add. 
If we allow it, there is a case that will not work.
Let's see the following case (time order):
1. Send request to add extent A to host; (A --> pending list)
2. Send request to release A from the host; (Delete A from pending list,
hoping the following add response for A will fail as there is not a matched
extent in the pending list).
3. Host send response to the device for the add request, however, for
some reason, it does not accept any of it, so updated list is empty,
spec allows it. Based on the spec, we need to drop the extent at the
head of the event log. Now we have problem. Since extent A is already
dropped from the list, we either cannot drop as the list is empty, which
is not the worst. If we have more extents in the list, we may drop the
one following A, which is for another request. If this happens, all the
following extents will be acked incorrectly as the order has been
shifted.
 
Does the above reasoning make sense to you?

Fan

> 
> > 
> > The loop here is only to collect the extents to sent to the event log. 
> > But as you said, we need one pass before updating pending list.
> > Actually if we do not allow the above case where extents to release is
> > still in the pending to add list, we can just return here with error, no
> > extra dry run needed. 
> > 
> > What do you think?
> 
> I think we need a way to back out extents from the pending to add list
> so we can create the race where they are offered to the OS and it takes
> forever to accept and by the time it does we've removed them.
> 
> > 
> > >   
> > > > +        
> > > > +
> > > > +        /* No duplicate or overlapped extents are allowed */
> > > > +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> > > > +                              len / block_size)) {
> > > > +            error_setg(errp, "duplicate or overlapped extents are detected");
> > > > +            return;
> > > > +        }
> > > > +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> > > > +
> > > > +        list = list->next;
> > > > +        if (!skip_extent) {
> > > > +            i++;  
> > > Problem is if we skip one in the middle the records will be wrong below.  
> > 
> > Why? Only extents passed the check will be stored in variable extents and
> > processed further and i be updated. 
> > For skipped ones, since i is not updated, they will be
> > overwritten by following valid ones.
> Ah. I'd missed the fact you store into the extent without a check on validity
> but only move the index on if they were valid. Then rely on not passing a trailing
> entry at the end.
> If would be more readable I think if local variables were used for the parameters
> until we've decided not to skip and the this ended with
> 
>         if (!skip_extent) {
>             extents[i] = (DCXLDCExtentRaw) {
>                 .start_dpa = ...
> 	        ...
>             };
>             i++
>         }
> We have local len already so probably just need
> uint64_t start_dpa = offset + dcd->dc.regions[rid].base;
> 
> Also maybe skip_extent_evlog or something like that to explain we are only
> skipping that part. 
> Helps people like me who read it completely wrong!
> 
> Jonathan
> 
>  
> 
