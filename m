Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606EF763F1
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698025; cv=none; b=IAzAREFwLDWJfcSwTo0hgRpGunZpAclKcmiRWFSNvioN9IfipBBoHQmcb24RdjEtIfjAu7NQ40y/EzYsQKTKQU4r2bfcHl3qqGYQkLV2eY+lydWs1q+UN212kyaFfbz0RqVt8CH4svEv1tG/W1siy5TpNsKBZpRrzazgGZMBkxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698025; c=relaxed/simple;
	bh=NfTrNrwstMYLcaSRw6nVIRERiotDwq7/UbsEh3jWZvw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijAiVRNizeYJEcvC/bgNgGI1gHk8nXRhVRbV561gXp8deIUYFj4oIrnR7Yp1uEskapFVsijGkCdq/S76SZQS9k8rh7JtYglTVhwmSDt5pDjGA2VStiQMKV8ajUm62XLtkgZk5mtYE87YVN7Q8GMNLTPknvxVpm6Nl376CIE19GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdHlKe1q; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdHlKe1q"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0edd0340fso55725355ad.2
        for <linux-cxl@vger.kernel.org>; Tue, 09 Apr 2024 14:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712698022; x=1713302822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PN4FNhNcV9wAPWo7s0sX5206NAjn0+Sd3JZEC1nJA0E=;
        b=mdHlKe1qDA3sRXWPEc3KmRNOlOqVKlGvAX56j2Wt/TXMVC9GHUl+hO91jcfD9hPjYx
         CxdFrAb2Ad/auPZ3TyYgvgEUkIhfKtu4NabdkfjPGR0AgwoU7kBKEC7r3o9ndwvScCAW
         O3zlB4kY8kB9OfcsHHNjXAr1DRSp8rYzpIWvOyHbcwjwUYHO9Ykt5bkE74/7+iM33bsv
         NuE0NniFfkx6ystjTQu4GUcbF/tdxPDAhpV81/8WIU3ncjuBUeYn4QOjL98CHzO17wVw
         XHFgIZj8IdzgZcBDQrWaRDx/wnovIeRUdFuUUG/SsTpW20GXvFJEcZsRdqSrt9/3Ho/X
         32lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712698022; x=1713302822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN4FNhNcV9wAPWo7s0sX5206NAjn0+Sd3JZEC1nJA0E=;
        b=XwS6+SRKZOrWvfR7U2/CJTETv2aTCbbwKlUiYa4N/sb+WoPj/9AzhLmawwgHjkUOvr
         V3CnzGoGO96vh0t8CNfkKoKToL5NoRh5xiFUE8NZG/ulJ+8pGt6wNdGuqd+4H9K8lUNn
         B/rp7eoArc2yjVhAzFeTeJ3YJ3QKLDBPtxA0l7X9LceqP1JLlzSwlm65MT1OUjjvif8d
         tHbXumBVo6kQwmELPpb5jqVK0X5R+eDbzZ2a+7tEdwszqSveRRuI4zMFK20xceSCs444
         6bLKIAQEs/HWZv7BdjH95/1xerAHi6H9/5sCb4CboYCbo+uaaEH0I4EPX5eaMx3YHn/R
         K3fA==
X-Forwarded-Encrypted: i=1; AJvYcCU6KqXWNblUKMpmh+ypN5/8sRMRLEkZkqeqXDAD1A2bwsmrb2ExBISfiD49EYVmBMjKkQa8zV4LcYuXMvRP5byXi+FUDmOIMVz2
X-Gm-Message-State: AOJu0YyWOzcDB5AVMd1e4WoDk1/XjPkTcBtHh2nWBxCwim/9Yll8FVwG
	+QNAIkmjSYTXuzI/9yopjcM9ffoL4Tt0wIe8OTbwIENymb8l8g2I
X-Google-Smtp-Source: AGHT+IFdGmcPIYPNaV791y87Kdi86jkPK1wPx6qGlwh6MW8H/z8O7FaPNQOVKvZuben2X9MvHR5tXQ==
X-Received: by 2002:a17:903:2692:b0:1e4:25e8:c2f2 with SMTP id jf18-20020a170903269200b001e425e8c2f2mr848045plb.41.1712698022352;
        Tue, 09 Apr 2024 14:27:02 -0700 (PDT)
Received: from debian ([2601:641:300:14de:d5a8:c39c:9dd3:f96e])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b001d8be6d1ec4sm9558976pln.39.2024.04.09.14.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:27:01 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 9 Apr 2024 14:26:51 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	gregory.price@memverge.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZhWym2yHoh6YIaXj@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-10-nifan.cxl@gmail.com>
 <20240405131856.000025e7@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405131856.000025e7@Huawei.com>

On Fri, Apr 05, 2024 at 01:18:56PM +0100, Jonathan Cameron wrote:
> On Mon, 25 Mar 2024 12:02:27 -0700
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > To simulate FM functionalities for initiating Dynamic Capacity Add
> > (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL spec
> > r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces to issue
> > add/release dynamic capacity extents requests.
> > 
> > With the change, we allow to release an extent only when its DPA range
> > is contained by a single accepted extent in the device. That is to say,
> > extent superset release is not supported yet.
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
> >           "offset": 0,
> >           "len": 134217728
> >       },
> >       {
> >           "offset": 134217728,
> >           "len": 134217728
> >       }
> 
> Hi Fan,
> 
> I talk more on this inline, but to me this interface takes multiple extents
> so that we can treat them as a single 'offer' of capacity. That is they
> should be linked in the event log with the more flag and the host should
> have to handle them in one go (I known Ira and Navneet's code doesn't handle
> this yet, but that doesn't mean QEMU shouldn't).
> 
> Alternative for now would be to only support a single entry.  Keep the
> interface defined to take multiple entries but reject it at runtime.
> 
> I don't want to end up with a more complex interface in the end just
> because we allowed this form to not set the MORE flag today.
> We will need this to do tagged handling and ultimately sharing, so good
> to get it right from the start.
> 
> For tagged handling I think the right option is to have the tag alongside
> region-id not in the individual extents.  That way the interface is naturally
> used to generate the right description to the host.
> 
> >       ]
> >   }
> > }
Hi Jonathan,
Thanks for the detailed comments.

For the QMP interface, I have one question. 
Do we want the interface to follow exactly as shown in
Table 7-70 and Table 7-71 in cxl r3.1?

Fan

> > 
> > 2. Release dynamic capacity extents:
> > 
> > For example, the command to release an extent of size 128MiB from region 0
> > (DPA offset 128MiB) looks like below:
> > 
> > { "execute": "cxl-release-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "region-id": 0,
> >       "extents": [
> >       {
> >           "offset": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> 
> 
> >          /* to-be-added range should not overlap with range already accepted */
> >          QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
> > @@ -1585,9 +1586,13 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >      CXLDCExtentList *extent_list = &ct3d->dc.extents;
> >      uint32_t i;
> >      uint64_t dpa, len;
> > +    CXLDCExtent *ent;
> >      CXLRetCode ret;
> >  
> >      if (in->num_entries_updated == 0) {
> > +        /* Always remove the first pending extent when response received. */
> > +        ent = QTAILQ_FIRST(&ct3d->dc.extents_pending);
> > +        cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending, ent);
> >          return CXL_MBOX_SUCCESS;
> >      }
> >  
> > @@ -1604,6 +1609,8 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >  
> >      ret = cxl_dcd_add_dyn_cap_rsp_dry_run(ct3d, in);
> >      if (ret != CXL_MBOX_SUCCESS) {
> > +        ent = QTAILQ_FIRST(&ct3d->dc.extents_pending);
> > +        cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending, ent);
> 
> Ah this deals with the todo I suggest you add to the earlier patch.
> I'd not mind so much if you hadn't been so thorough on other todo notes ;)
> Add one in the earlier patch and get rid of ti here like you do below.
> 
> However as I note below I think we need to handle these as groups of extents
> not single extents. That way we keep an 'offered' set offered at the same time by
> a single command (and expose to host using the more flag) together and reject
> them on mass.
> 
> 
> >          return ret;
> >      }
> >  
> > @@ -1613,10 +1620,9 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >  
> >          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> >          ct3d->dc.total_extent_count += 1;
> > -        /*
> > -         * TODO: we will add a pending extent list based on event log record
> > -         * and process the list according here.
> > -         */
> > +
> > +        ent = QTAILQ_FIRST(&ct3d->dc.extents_pending);
> > +        cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending, ent);
> >      }
> >  
> >      return CXL_MBOX_SUCCESS;
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 951bd79a82..74cb64e843 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> 
> >  
> >  static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> > @@ -1449,7 +1454,8 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
> >          return CXL_EVENT_TYPE_FAIL;
> >      case CXL_EVENT_LOG_FATAL:
> >          return CXL_EVENT_TYPE_FATAL;
> > -/* DCD not yet supported */
> 
> Drop the comment but don't add the code.  We are handling DCD differently
> from other events, so this code should never deal with it.
> 
> > +    case CXL_EVENT_LOG_DYNCAP:
> > +        return CXL_EVENT_TYPE_DYNAMIC_CAP;
> >      default:
> >          return -EINVAL;
> >      }
> > @@ -1700,6 +1706,250 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
> >      }
> >  }
> 
> > +/*
> > + * Check whether the range [dpa, dpa + len -1] has overlaps with extents in
> 
> space after - (just looks odd otherwise)
> 
> > + * the list.
> > + * Return value: return true if has overlaps; otherwise, return false
> > + */
> > +static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > +                                           uint64_t dpa, uint64_t len)
> > +{
> > +    CXLDCExtent *ent;
> > +    Range range1, range2;
> > +
> > +    if (!list) {
> > +        return false;
> > +    }
> > +
> > +    range_init_nofail(&range1, dpa, len);
> > +    QTAILQ_FOREACH(ent, list, node) {
> > +        range_init_nofail(&range2, ent->start_dpa, ent->len);
> > +        if (range_overlaps_range(&range1, &range2)) {
> > +            return true;
> > +        }
> > +    }
> > +    return false;
> > +}
> > +
> > +/*
> > + * Check whether the range [dpa, dpa + len -1] is contained by extents in 
> 
> space after -
> 
> > + * the list.
> > + * Will check multiple extents containment once superset release is added.
> > + * Return value: return true if range is contained; otherwise, return false
> > + */
> > +bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
> > +                                    uint64_t dpa, uint64_t len)
> > +{
> > +    CXLDCExtent *ent;
> > +    Range range1, range2;
> > +
> > +    if (!list) {
> > +        return false;
> > +    }
> > +
> > +    range_init_nofail(&range1, dpa, len);
> > +    QTAILQ_FOREACH(ent, list, node) {
> > +        range_init_nofail(&range2, ent->start_dpa, ent->len);
> > +        if (range_contains_range(&range2, &range1)) {
> > +            return true;
> > +        }
> > +    }
> > +    return false;
> > +}
> > +
> > +/*
> > + * The main function to process dynamic capacity event. Currently DC extents
> > + * add/release requests are processed.
> > + */
> > +static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
> 
> As below. Don't pass in a CxlEventLog.  Whilst some infrastructure is shared
> with other event logs, we don't want to accidentally enable other events
> being added to the DC event log.
> 
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
> > +    uint64_t dpa, offset, len, block_size;
> > +    int i, rc;
> > +    g_autofree unsigned long *blk_bitmap = NULL;
> > +
> > +    obj = object_resolve_path_type(path, TYPE_CXL_TYPE3, NULL);
> > +    if (!obj) {
> > +        error_setg(errp, "Unable to resolve CXL type 3 device");
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
> 
> enc_log = CXL_EVENT_TYPE_DYNAMIC_CAP; always so don't look it up.
> 
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
> > +    blk_bitmap = bitmap_new(dcd->dc.regions[rid].len / block_size);
> > +
> > +    /* Sanity check and count the extents */
> > +    list = records;
> > +    while (list) {
> > +        offset = list->value->offset;
> > +        len = list->value->len;
> > +        dpa = offset + dcd->dc.regions[rid].base;
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
> > +        /* No duplicate or overlapped extents are allowed */
> > +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> > +                              len / block_size)) {
> > +            error_setg(errp, "duplicate or overlapped extents are detected");
> > +            return;
> > +        }
> > +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> > +
> > +        num_extents++;
> > +        if (type == DC_EVENT_RELEASE_CAPACITY) {
> > +            if (cxl_extents_overlaps_dpa_range(&dcd->dc.extents_pending,
> > +                                               dpa, len)) {
> > +                error_setg(errp,
> > +                           "cannot release extent with pending DPA range");
> > +                return;
> > +            }
> > +            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents,
> > +                                                dpa, len)) {
> > +                error_setg(errp,
> > +                           "cannot release extent with non-existing DPA range");
> > +                return;
> > +            }
> > +        }
> > +        list = list->next;
> > +    }
> > +    if (num_extents == 0) {
> 
> We can just check if there is a first one.  That check can be done before
> counting them and is probably a little more elegant than leaving it to down here.
> I'm not sure we can pass in an empty list but if we can (easy to poke interface
> and check) then I assume records == NULL. 
> 
> > +        error_setg(errp, "no valid extents to send to process");
> > +        return;
> > +    }
> > +
> > +    /* Create extent list for event being passed to host */
> > +    i = 0;
> > +    list = records;
> > +    extents = g_new0(CXLDCExtentRaw, num_extents);
> > +    while (list) {
> > +        offset = list->value->offset;
> > +        len = list->value->len;
> > +        dpa = dcd->dc.regions[rid].base + offset;
> > +
> > +        extents[i].start_dpa = dpa;
> > +        extents[i].len = len;
> > +        memset(extents[i].tag, 0, 0x10);
> > +        extents[i].shared_seq = 0;
> > +        list = list->next;
> > +        i++;
> > +    }
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
> This is misleading by my understanding of the specification.
> More isn't directly related to tags (though it is necessary for some
> flows with tags, when sharing is enabled anyway).
> The reference to record also isn't that relevant. The idea is you set
> it for all but the last record pushed to the event log (from a given
> action from an FM).
> 
> The whole reason to have a multi extent injection interface is to set
> the more flag to indicate that the OS needs to treat a bunch of extents
> as one 'offer' of capacity.  So a rejection from the OS needs to take
> out 'all those records'.  The proposed linux code will currently reject
> all by the first extent (I moaned about that yesterday). 
> 
> It is fine to not support this in the current code, but then I would check
> the number of extents and reject any multi extent commands until we
> do support it.
> 
> Ultimately I want a qmp command with more than one extent to mean
> they are one 'offer' of capacity and must be handled as such by
> the OS.  I.e. it can't reply with multiple unrelated acceptance
> or reject replies.
> 
> On the add side this is easy to support, the fiddly bit is if the
> OS rejects some or all of the capacity and you then need to
> take out all the extents offered that it hasn't accepted in it's reply.
> 
> Pending list will need to maintain that association.
> Maybe the easiest way is to have pending list be a list of sublists?
> That way each sublist is handled in one go and any non accepted extents
> in that sub list are dropped.
> 
>  
> > +     */
> > +    dCap.flags = 0;
> > +    for (i = 0; i < num_extents; i++) {
> > +        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
> > +               sizeof(CXLDCExtentRaw));
> > +
> > +        if (type == DC_EVENT_ADD_CAPACITY) {
> > +            cxl_insert_extent_to_extent_list(&dcd->dc.extents_pending,
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
> > +
> > +void qmp_cxl_add_dynamic_capacity(const char *path, uint8_t region_id,
> > +                                  CXLDCExtentRecordList  *records,
> > +                                  Error **errp)
> > +{
> > +   qmp_cxl_process_dynamic_capacity(path, CXL_EVENT_LOG_DYNCAP,
> 
> Drop passing in the log, it doesn't make sense given these events only occur
> on that log and we can hard code it in the function.
> 
> > +                                    DC_EVENT_ADD_CAPACITY, 0,
> > +                                    region_id, records, errp);
> > +}
> > +
> > +void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
> > +                                      CXLDCExtentRecordList  *records,
> > +                                      Error **errp)
> > +{
> > +    qmp_cxl_process_dynamic_capacity(path, CXL_EVENT_LOG_DYNCAP,
> > +                                     DC_EVENT_RELEASE_CAPACITY, 0,
> > +                                     region_id, records, errp);
> > +}
> > +
> >  static void ct3_class_init(ObjectClass *oc, void *data)
> >  {
> 
> 
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index df3511e91b..b84063d9f4 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -494,6 +494,7 @@ struct CXLType3Dev {
> >           */
> >          uint64_t total_capacity; /* 256M aligned */
> >          CXLDCExtentList extents;
> > +        CXLDCExtentList extents_pending;
> >          uint32_t total_extent_count;
> >          uint32_t ext_list_gen_seq;
> 
> 
> 
> >  #endif /* CXL_EVENTS_H */
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 8cc4c72fa9..2645004666 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -19,13 +19,16 @@
> >  #
> >  # @fatal: Fatal Event Log
> >  #
> > +# @dyncap: Dynamic Capacity Event Log
> > +#
> >  # Since: 8.1
> >  ##
> >  { 'enum': 'CxlEventLog',
> >    'data': ['informational',
> >             'warning',
> >             'failure',
> > -           'fatal']
> > +           'fatal',
> > +           'dyncap']
> 
> Does this have the side effect of letting us inject error events
> onto the dynamic capacity log? 
> 
> >   }
> >  
> >  ##
> > @@ -361,3 +364,59 @@
> >  ##
> >  {'command': 'cxl-inject-correctable-error',
> >   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> ...
> 
> > +##
> > +# @cxl-add-dynamic-capacity:
> > +#
> > +# Command to start add dynamic capacity extents flow. The device will
> > +# have to acknowledged the acceptance of the extents before they are usable.
> > +#
> > +# @path: CXL DCD canonical QOM path
> > +# @region-id: id of the region where the extent to add
> > +# @extents: Extents to add
> > +#
> > +# Since : 9.0
> 
> 9.1
> 
> > +##
> > +{ 'command': 'cxl-add-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'region-id': 'uint8',
> > +            'extents': [ 'CXLDCExtentRecord' ]
> > +           }
> > +}
> > +
> > +##
> > +# @cxl-release-dynamic-capacity:
> > +#
> > +# Command to start release dynamic capacity extents flow. The host will
> > +# need to respond to indicate that it has released the capacity before it
> > +# is made unavailable for read and write and can be re-added.
> > +#
> > +# @path: CXL DCD canonical QOM path
> > +# @region-id: id of the region where the extent to release
> > +# @extents: Extents to release
> > +#
> > +# Since : 9.0
> 
> 9.1
> 
> > +##
> > +{ 'command': 'cxl-release-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'region-id': 'uint8',
> > +            'extents': [ 'CXLDCExtentRecord' ]
> > +           }
> > +}
> 
