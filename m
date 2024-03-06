Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F17B22F19
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768213; cv=none; b=T0YWZaKCFP+s6RlV9HVzt+gF++R5t7RyhTSbshWLQzUQyIqRWEuT+RzYX5dZ9xVhL68OF+qIkOxuoJtA5jl9ib8yTPdH0oK0moyHalsHsDGEHMNeJBAyYN2P48sWocYZ7qgvMYJJsG5yNG7v8mgpBpmZSyYzDZHmukMUhdk51nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768213; c=relaxed/simple;
	bh=UeZRENaWHt6jjGRLkgLrDxT2EnWmy68FVTELOl/SrBo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8Wn1ktsNUR4QobDmVMqyfU7HvyFwDHrnyyFMIsQRDREypBQYEDC6RNOUU30wNmQYaGq5jItkKGaEZavUJzblfyPAKx+XDQU+uyFi0t8bkKhCqjOmLBc0I2mIoubSACKtiXeFtBNfJbGwTcvLx83KjQCEXBJUWi+lNm3aCPyGnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpXGZPgq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpXGZPgq"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e5d7f1f25fso232774b3a.0
        for <linux-cxl@vger.kernel.org>; Wed, 06 Mar 2024 15:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709768211; x=1710373011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G3NByaC7e2vU7KXkuTFn4jau+iZXlsPs1U5JLg/SDIM=;
        b=ZpXGZPgqtLHJ8w7QVM342s2j9QSXmhLgBy6KERnKJOsJTl5amMv47R9xywknpkJPjf
         SpB60DED/RxzN0bMOiaEbdrMlrel4jubIcoRT139LqqkF+qddnL0NbPljNg04q0+1pVK
         +HiXe2H7D6Xdbdc8Sof+NvXrebA3azTy6tfirvlsYkBOSgka2Qs4CJlFqUoNlV4D1ZXR
         tnqMKjwXe4EPn9TwCcOmUqOayCf7dfqNnan6CMevOaf7345naciAl43kxvN4W0rLwFGy
         p4pe3YTFqmUTaSukHYbeQwfVYJHfaKfE3cpD0qzGoB/gK+gVj7ooUjm7ekVOmdnaMvHF
         XJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709768211; x=1710373011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3NByaC7e2vU7KXkuTFn4jau+iZXlsPs1U5JLg/SDIM=;
        b=WAq+2PZ0AP4IwzRKURASrfovVUzH7yxtr5j9ZJQQf9qTiZZ9kkUIxXJz2jrWJpqa5d
         WDe0GMcuVLBgt/105PkAxbsuhapI18KXEqPr8HuLeJ5+FsNQHD/PyWnOBTMdhLzM/akH
         i2slikVJvnXwS0vuIDOyPKpe7QFHwdVstvoGCQ/Nz6OlWHNi5P01zY1TZ6i37W9k2jEp
         YU8x1hwDwF66uAe7UYhYLtgb9y+H4zQzFnzXMbcfhzyH1WF2Q9HaR4x2icjR2hd01xyX
         JcvWnhdSOawjjxmUW8Wcc8WupTTyJrWkXhPTwAJkgyIvr9wtmQjut+hLsZi9e/YGbK5B
         6ejw==
X-Forwarded-Encrypted: i=1; AJvYcCVNQrCuGgesh+GC2FAXUsZ5/E7WHSqjvpmvYv3AQn50OsfanCRTyR4aN2ghIPDNFoj0Kj9Ar2UB5+kSZFnJDbgLgi6KDG4T2/MP
X-Gm-Message-State: AOJu0YyPx+PKpf3UiF+OrHQlSOb3iQ2f5hWHpZn0Q4ElKh1KLpGo9aQ2
	9legl/95b941hDJL9YxVPdY6pCapaD0ZqOyAAgKFCiljMaNM/4xO
X-Google-Smtp-Source: AGHT+IEwtRMhFbSxQb/KZXhLcR9EIwBKij6+ixLsZ46fWXDn9wg1tZGHwoGvcDjNQ8MYSr5vZ+jMkA==
X-Received: by 2002:a05:6a00:10ca:b0:6e6:3f05:74d8 with SMTP id d10-20020a056a0010ca00b006e63f0574d8mr6160393pfu.3.1709768211057;
        Wed, 06 Mar 2024 15:36:51 -0800 (PST)
Received: from debian ([2601:641:300:14de:57cf:345:75f0:2085])
        by smtp.gmail.com with ESMTPSA id k19-20020a63ff13000000b005cfb6e7b0c7sm11710093pgi.39.2024.03.06.15.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:36:50 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 6 Mar 2024 15:36:38 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	gregory.price@memverge.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <Zej-Bg7ooVyswHXZ@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <20240306174811.000029fd@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306174811.000029fd@Huawei.com>

On Wed, Mar 06, 2024 at 05:48:11PM +0000, Jonathan Cameron wrote:
> On Mon,  4 Mar 2024 11:34:04 -0800
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Since fabric manager emulation is not supported yet, the change implements
> > the functions to add/release dynamic capacity extents as QMP interfaces.
> 
> We'll need them anyway, or to implement an fm interface via QMP which is
> going to be ugly and complex.
> 
> > 
> > Note: we skips any FM issued extent release request if the exact extent
> > does not exist in the extent list of the device. We will loose the
> > restriction later once we have partial release support in the kernel.
> 
> Maybe the kernel will treat it as a request to release the extent it
> is tracking that contains it.  So we may want to add a way to poke that.
> Not today though!
> 
> > 
> > 1. Add dynamic capacity extents:
> > 
> > For example, the command to add two continuous extents (each 128MiB long)
> > to region 0 (starting at DPA offset 0) looks like below:
> > 
> > { "execute": "qmp_capabilities" }
> > 
> > { "execute": "cxl-add-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "region-id": 0,
> >       "extents": [
> >       {
> >           "dpa": 0,
> >           "len": 134217728
> >       },
> >       {
> >           "dpa": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> > 
> > 2. Release dynamic capacity extents:
> > 
> > For example, the command to release an extent of size 128MiB from region 0
> > (DPA offset 128MiB) look like below:
> > 
> > { "execute": "cxl-release-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "region-id": 0,
> >       "extents": [
> >       {
> >           "dpa": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> ...
>   
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index dccfaaad3a..e9c8994cdb 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -674,6 +674,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> >          ct3d->dc.total_capacity += region->len;
> >      }
> >      QTAILQ_INIT(&ct3d->dc.extents);
> > +    QTAILQ_INIT(&ct3d->dc.extents_pending_to_add);
> >  
> >      return true;
> >  }
> > @@ -686,6 +687,12 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
> >          ent = QTAILQ_FIRST(&ct3d->dc.extents);
> >          cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
> >      }
> > +
> > +    while (!QTAILQ_EMPTY(&ct3d->dc.extents_pending_to_add)) {
> 
> QTAILQ_FOR_EACHSAFE
> 
> > +        ent = QTAILQ_FIRST(&ct3d->dc.extents_pending_to_add);
> > +        cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending_to_add,
> > +                                           ent);
> > +    }
> >  }
> 
> > +/*
> > + * The main function to process dynamic capacity event. Currently DC extents
> > + * add/release requests are processed.
> > + */
> > +static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
> > +                                             CXLDCEventType type, uint16_t hid,
> > +                                             uint8_t rid,
> > +                                             CXLDCExtentRecordList *records,
> > +                                             Error **errp)
> > +{
> > +    Object *obj;
> > +    CXLEventDynamicCapacity dCap = {};
> > +    CXLEventRecordHdr *hdr = &dCap.hdr;
> > +    CXLType3Dev *dcd;
> > +    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
> > +    uint32_t num_extents = 0;
> > +    CXLDCExtentRecordList *list;
> > +    g_autofree CXLDCExtentRaw *extents = NULL;
> > +    uint8_t enc_log;
> > +    uint64_t offset, len, block_size;
> > +    int i;
> > +    int rc;
> 
> Combine the two lines above.
> 
> > +    g_autofree unsigned long *blk_bitmap = NULL;
> > +
> > +    obj = object_resolve_path(path, NULL);
> > +    if (!obj) {
> > +        error_setg(errp, "Unable to resolve path");
> > +        return;
> > +    }
> 
> object_resolve_path_type() and skip a step (should do this in various places
> in our existing code!)
> 
> > +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> > +        error_setg(errp, "Path not point to a valid CXL type3 device");
> > +        return;
> > +    }
> > +
> > +    dcd = CXL_TYPE3(obj);
> > +    if (!dcd->dc.num_regions) {
> > +        error_setg(errp, "No dynamic capacity support from the device");
> > +        return;
> > +    }
> > +
> > +    rc = ct3d_qmp_cxl_event_log_enc(log);
> > +    if (rc < 0) {
> > +        error_setg(errp, "Unhandled error log type");
> > +        return;
> > +    }
> > +    enc_log = rc;
> > +
> > +    if (rid >= dcd->dc.num_regions) {
> > +        error_setg(errp, "region id is too large");
> > +        return;
> > +    }
> > +    block_size = dcd->dc.regions[rid].block_size;
> > +
> > +    /* Sanity check and count the extents */
> > +    list = records;
> > +    while (list) {
> > +        offset = list->value->offset;
> > +        len = list->value->len;
> > +
> > +        if (len == 0) {
> > +            error_setg(errp, "extent with 0 length is not allowed");
> > +            return;
> > +        }
> > +
> > +        if (offset % block_size || len % block_size) {
> > +            error_setg(errp, "dpa or len is not aligned to region block size");
> > +            return;
> > +        }
> > +
> > +        if (offset + len > dcd->dc.regions[rid].len) {
> > +            error_setg(errp, "extent range is beyond the region end");
> > +            return;
> > +        }
> > +
> > +        num_extents++;
> > +        list = list->next;
> > +    }
> > +    if (num_extents == 0) {
> > +        error_setg(errp, "No extents found in the command");
> > +        return;
> > +    }
> > +
> > +    blk_bitmap = bitmap_new(dcd->dc.regions[rid].len / block_size);
> > +
> > +    /* Create Extent list for event being passed to host */
> > +    i = 0;
> > +    list = records;
> > +    extents = g_new0(CXLDCExtentRaw, num_extents);
> > +    while (list) {
> > +        CXLDCExtent *ent;
> > +        bool skip_extent = false;
> > +
> > +        offset = list->value->offset;
> > +        len = list->value->len;
> > +
> > +        extents[i].start_dpa = offset + dcd->dc.regions[rid].base;
> > +        extents[i].len = len;
> > +        memset(extents[i].tag, 0, 0x10);
> > +        extents[i].shared_seq = 0;
> > +
> > +        if (type == DC_EVENT_RELEASE_CAPACITY ||
> > +            type == DC_EVENT_FORCED_RELEASE_CAPACITY) {
> > +            /*
> > +             *  if the extent is still pending to be added to the host,
> 
> Odd spacing.
> 
> > +             * remove it from the pending extent list, so later when the add
> > +             * response for the extent arrives, the device can reject the
> > +             * extent as it is not in the pending list.
> > +             */
> > +            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
> > +                        &extents[i]);
> > +            if (ent) {
> > +                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
> > +                g_free(ent);
> > +                skip_extent = true;
> > +            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
> > +                /* If the exact extent is not in the accepted list, skip */
> > +                skip_extent = true;
> > +            }
> I think we need to reject case of some extents skipped and others not.
> That's not supported yet so we need to complain if we get it at least. Maybe we need
> to do two passes so we know this has happened early (or perhaps this is a later
> patch in which case a todo here would help).

If the second skip_extent case, I will reject earlier instead of
skipping.

Fan

> 
> > +        
> > +
> > +        /* No duplicate or overlapped extents are allowed */
> > +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> > +                              len / block_size)) {
> > +            error_setg(errp, "duplicate or overlapped extents are detected");
> > +            return;
> > +        }
> > +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> > +
> > +        list = list->next;
> > +        if (!skip_extent) {
> > +            i++;
> Problem is if we skip one in the middle the records will be wrong below.
> > +        }
> > +    }
> > +    num_extents = i;
> > +
> > +    /*
> > +     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
> > +     *
> > +     * All Dynamic Capacity event records shall set the Event Record Severity
> > +     * field in the Common Event Record Format to Informational Event. All
> > +     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
> > +     * Event Log.
> > +     */
> > +    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
> > +                            cxl_device_get_timestamp(&dcd->cxl_dstate));
> > +
> > +    dCap.type = type;
> > +    /* FIXME: for now, validity flag is cleared */
> > +    dCap.validity_flags = 0;
> > +    stw_le_p(&dCap.host_id, hid);
> > +    /* only valid for DC_REGION_CONFIG_UPDATED event */
> > +    dCap.updated_region_id = 0;
> > +    /*
> > +     * FIXME: for now, the "More" flag is cleared as there is only one
> > +     * extent associating with each record and tag-based release is
> > +     * not supported.
> 
> Hmm. Seems like tag support would be easy.  Add an optional qmp parameter,
> if a tag is set, we set the more flag for all but the last entry in this
> loop.  I'm ok with that being a follow up patch though.
> 
> > +     */
> > +    dCap.flags = 0;
> > +    for (i = 0; i < num_extents; i++) {
> > +        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
> > +               sizeof(CXLDCExtentRaw));
> > +
> > +        if (type == DC_EVENT_ADD_CAPACITY) {
> > +            cxl_insert_extent_to_extent_list(&dcd->dc.extents_pending_to_add,
> > +                                             extents[i].start_dpa,
> > +                                             extents[i].len,
> > +                                             extents[i].tag,
> > +                                             extents[i].shared_seq);
> > +        }
> > +
> > +        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
> > +                             (CXLEventRecordRaw *)&dCap)) {
> > +            cxl_event_irq_assert(dcd);
> > +        }
> > +    }
> > +}
> 
> 
> 
> 
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 341260e6e4..b524c5e699 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -490,6 +490,7 @@ struct CXLType3Dev {
> >          AddressSpace host_dc_as;
> >          uint64_t total_capacity; /* 256M aligned */
> >          CXLDCExtentList extents;
> > +        CXLDCExtentList extents_pending_to_add;
> 
> Long name, extents_pending or just pending is plenty I think.
> 
> >          uint32_t total_extent_count;
> >          uint32_t ext_list_gen_seq;
> >  
> > @@ -551,4 +552,9 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
> >  
> >  void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
> >                                          CXLDCExtent *extent);
> > +void cxl_insert_extent_to_extent_list(CXLDCExtentList *list, uint64_t dpa,
> > +                                      uint64_t len, uint8_t *tag,
> > +                                      uint16_t shared_seq);
> > +bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
> > +                       unsigned long size);
> >  #endif
> 
> 
