Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375B51CD3D
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766936; cv=none; b=AVnyzfW390fVupb2oW1+vvAmeFMB1e5+g+AYmKmf16spYD4Ry23NDC/4lc4k/1mu2Tq7YGd7CkJ98FALKSWxxrC4CPJ299N59I1o4ZIrT1uTG0jfQAzDa5efBKbhFJ00j6/zGusW/NzZuYG6lAkmZkA3FJ11ayCsGMvkGlixrI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766936; c=relaxed/simple;
	bh=CPKqd4kbeR2imTuzaZtf5VpVV8A82mUXTBc1yjnKtOI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhBAHH5SMPMNZvt4nPA3IosPp69fGkkO/XJvCVauyPkrqQEYiCuyVM+I3a9WHyeJUIjTEMivVqPmlcw4YGFIyS5soE6FgMVw+GJaVQC7j26vvPClYeVFUPTkUW3NYQjJN0DThaxETR/9aC+OC6/2k0L9bYwG9WNn99YW8W81uBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gx1gTk/b; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx1gTk/b"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc0e5b223eso2236215ad.1
        for <linux-cxl@vger.kernel.org>; Wed, 06 Mar 2024 15:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766933; x=1710371733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Id/V3NEpLU2tiqiNwwAXaXlUYzvDYW4eeAi92PZrxBg=;
        b=gx1gTk/bfcefMvwn6LcniZJ8sOMNDLnKwTI8FNKmCCyDNpUITU/9iJ1w16cv+Fr/Ab
         JgR/DRuvJnRy8KtZyjuVvT2W5u+BThqFR9w0RM1VJeUnFLWqn2qznnLN8154H84rZBx7
         fymdnc4dvuHkC0WGtUDi1nu51AZAKWEY4gbwZh+aTt4IZtLog5hbxlyiz9TCzt6OmdmX
         URPTlNSjdk7FeLyuGlZNnjWdCSBwtEbF9L7cb5SSz+l+C8e1evqsMuKLsnpo7aj5wByU
         VAPaSj/AJBIUo2pz6sbYoIZxHk/2hREl2oSQcueoafa3LqF5IP79gh4Z+VZOAm34Perd
         OWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766933; x=1710371733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id/V3NEpLU2tiqiNwwAXaXlUYzvDYW4eeAi92PZrxBg=;
        b=hEaOlnbWbK33lxWXGF0dSGS8X7g3Bqs1v8sK2MY9f1rwX4vi5gCrkwoRHUl8ng8qPD
         B29WYG2beWk9MOc7zNz9dfPXssP8Srahm6tvrf8kAvyyrw0BzCZ+/c/LR5M9QcYw2RSD
         2MO92oOhiyQ2HGCugiNJjprpNnlyTl12Krzj/8VXzdQo3FjzWx1PKM8dKcrqZ/z9arKE
         c+grANjnTh97HK+UBvFn6Dd7+I4ZAnv5e6y1+LZwHcGQ9v29D7/NPHXKvR7Gqr/br8l3
         jEVJA6OZ6+FjTjf7mgUoEDiov74AzpC/vyzQWFluxj4uwjG0ZRnTcewrRCrmv6wppRpr
         ZH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFcFWu78vIFNmT070A4hqrNm9QniDz47OWQdS60aJT1cGKO5GOXl9ML/b6jJkDReuoa3zn/ObjBjd+4xEE2HdcOKWYeN/cNIo8
X-Gm-Message-State: AOJu0YyGX05Q36dPWcYu6A4zqjEV95xrY5fQkorBegbKbdZD2XDQdbkQ
	0D+ztcEO+0wvkw2T5gkuqw1r4RyJx7F9iRvnzckRMvbjkPRj7fMu
X-Google-Smtp-Source: AGHT+IHC4n6g6JZ8b8UX0f61GtFy2ythZAVB/WHpm1wDMOTMRWsUDf9ruwcnTgdITBdJGgTgiRZ+jw==
X-Received: by 2002:a17:902:bc86:b0:1dc:16:9000 with SMTP id bb6-20020a170902bc8600b001dc00169000mr6126594plb.16.1709766933398;
        Wed, 06 Mar 2024 15:15:33 -0800 (PST)
Received: from debian ([2601:641:300:14de:57cf:345:75f0:2085])
        by smtp.gmail.com with ESMTPSA id kx3-20020a170902f94300b001dca40bb727sm13205906plb.88.2024.03.06.15.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:15:33 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 6 Mar 2024 15:15:30 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	gregory.price@memverge.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <Zej5EuQXytgeWGfj@debian>
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

Skip here does not mean the extent is invalid, it just means the extent
is still pending to add, so remove them from pending list would be
enough to reject the extent, no need to release further. That is based
on your feedback on v4.

The loop here is only to collect the extents to sent to the event log. 
But as you said, we need one pass before updating pending list.
Actually if we do not allow the above case where extents to release is
still in the pending to add list, we can just return here with error, no
extra dry run needed. 

What do you think?

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

Why? Only extents passed the check will be stored in variable extents and
processed further and i be updated. 
For skipped ones, since i is not updated, they will be
overwritten by following valid ones.

Fan

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
