Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4122E40F
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320046; cv=none; b=EsePto/GUU4qX6skCGz1aVgOzgQF06SpTyJSfiH2nLd/q6FLSyPdJQ4ZZ/jEIQW96IVxHxX11gcmLniNQn4qNVnY57BS4WJdAjdJ8+sc6FsbOYTpA75tqZo5GSogHvtjbGZt/NmFHHnmK1v5nS7ES1tbvFAm6Y+T0Kd9Y1hrAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320046; c=relaxed/simple;
	bh=t3GLPMTBPrAfKuVllUSWdNrbSHLzGBRkIShkIiXZ95c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZxpqJFmnx3mTQMxJh5pBy5s+NZF/pTOCpxG4oa9URFrFdzbfwC53htTGuAYe0JfXvy0AhybNL6b4sJ/Em52Bhv+ktMLK1SD8ax9O2yuMTGEgRC86mARrx+kBfbBl2Pni3P/N4hNqgHXGdmL7ZxO76UY6NmdfjkudLeoeikx8dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9yL83scxz6D95T;
	Fri,  5 Apr 2024 20:22:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 25D571400D1;
	Fri,  5 Apr 2024 20:27:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 13:27:20 +0100
Date: Fri, 5 Apr 2024 13:27:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gregory Price <gregory.price@memverge.com>
CC: <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240405132719.00005859@Huawei.com>
In-Reply-To: <Zg2c+YauNGqhFfTW@memverge.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
	<20240325190339.696686-10-nifan.cxl@gmail.com>
	<Zg2c+YauNGqhFfTW@memverge.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 3 Apr 2024 14:16:25 -0400
Gregory Price <gregory.price@memverge.com> wrote:

A few follow up comments.

> On Mon, Mar 25, 2024 at 12:02:27PM -0700, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > To simulate FM functionalities for initiating Dynamic Capacity Add
> > (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL spec
> > r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces to issue
> > add/release dynamic capacity extents requests.
> >   
> ... snip 
> > +
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
> ... snip 
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
> 
> I think num_extents is always equal to the length of the list, otherwise
> this code will return with error.
> 
> Nitpick:
> This can be moved to the bottom w/ `list = list->next` to express that a
> little more clearly.
> 
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
> > +
> > +    if (num_extents == 0) {  
> 
> Since num_extents is always the length of the list, this is equivalent to
> `if (!records)` prior to the while loop. Makes it a little more clear that:
> 
> 1. There must be at least 1 extent
> 2. All extents must be valid for the command to be serviced.

Agreed.

> 
> > +        error_setg(errp, "no valid extents to send to process");
> > +        return;
> > +    }
> > +  
> 
> I'm looking at adding the MHD extensions around this point, e.g.:
> 
> /* If MHD cannot allocate requested extents, the cmd fails */
> if (type == DC_EVENT_ADD_CAPACITY && dcd->mhd_dcd_extents_allocate &&
>     num_extents != dcd->mhd_dcd_extents_allocate(...))
> 	return;
> 
> where mhd_dcd_extents_allocate checks the MHD block bitmap and tags
> for correctness (shared // no double-allocations, etc). On success,
> it garuantees proper ownership.
> 
> the release path would then be done in the release response path from
> the host, as opposed to the release event injection.

I think it would be polite to check if the QMP command on release
for whether it is asking something plausible - makes for an easier
to user QMP interface.  I guess it's not strictly required though.
What races are there on release?  We aren't support force release
for now, and for anything else, it's host specific (unlike add where
the extra rules kick in).   AS such I 'think' a check at command
time will be valid as long as the host hasn't done an async
release of capacity between that and the event record.  That
is a race we always have and the host should at most log it and
not release capacity twice.

> 
> Do you see any issues with that flow?
> 
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
> 
> Pardon if I missed a prior discussion about this, but what happens to
> pending events in the scenario where cxl_event_insert fails?

For an add or release, error returned to the FM that tried it.
For Force release, carry on regardless (setting overflow etc).
Host goes boom but that probably happens anyway :)

Jonathan


> 
> ~Gregory

