Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4D12E1F0
	for <linux-cxl@vger.kernel.org>; Mon, 26 Feb 2024 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971029; cv=none; b=ijmezppEXHist2R2qxI2gl8UvfAaP/dQbpfd+1vRpVCvabr1jHuv/ONY+HnyX2lZooVSUcG5Z4DLRpD5JGGz8I9ko/bCqATMxqc/+GH2s2pBo2ExJXSXqiYA6NUSKO6yCqvNiUk0Tbp1pj5x91/tSGYM9DxAnJIsunLEIMrxM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971029; c=relaxed/simple;
	bh=sgNtbB0SpCCzTNaL8SVimEzrKf8btQStckk4sPzuetM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0X2yrrJVN57RfHl/abljW+cPosjKSNQ3QcuMdg/gPukZeNeTSS9cHJiDg7p/RYBXAw91v4T7+3wjaF4Et2FJAngA3NvO8cwsFImSRZaGuKzGEErLOQN9EaifJxW0jyWYL0naD7RnNNlM30LtDnN2a/oi7X7GZDBfVy392Wp52M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk7p52FR1z6JBTn;
	Tue, 27 Feb 2024 02:05:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 96C7E140B73;
	Tue, 27 Feb 2024 02:10:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 18:10:23 +0000
Date: Mon, 26 Feb 2024 18:10:21 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>, Fan Ni
	<fan.ni@samsung.com>
Subject: Re: [PATCH v4 09/10] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240226181021.00005a02@Huawei.com>
In-Reply-To: <20240221182020.1086096-10-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
	<20240221182020.1086096-10-nifan.cxl@gmail.com>
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

On Wed, 21 Feb 2024 10:16:02 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Since fabric manager emulation is not supported yet, the change implements
> the functions to add/release dynamic capacity extents as QMP interfaces.
> 
> Note: we skips any FM issued extent release request if the exact extent
> does not exist in the extent list of the device. We will loose the
> restriction later once we have partial release support in the kernel.
> 
> 1. Add dynamic capacity extents:
> 
> For example, the command to add two continuous extents (each 128MiB long)
> to region 0 (starting at DPA offset 0) looks like below:
> 
> { "execute": "qmp_capabilities" }
> 
> { "execute": "cxl-add-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "region-id": 0,
>       "extents": [
>       {
>           "dpa": 0,
>           "len": 134217728
>       },
>       {
>           "dpa": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
> 
> 2. Release dynamic capacity extents:
> 
> For example, the command to release an extent of size 128MiB from region 0
> (DPA offset 128MiB) look like below:
> 
> { "execute": "cxl-release-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "region-id": 0,
>       "extents": [
>       {
>           "dpa": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
A few things inline. I don't understand one of the comments.

> ---


>  
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index f4edada303..b8c4273e99 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c

> +/*
> + * Check whether the exact extent exists in the list
> + * Return value: the extent pointer in the list; else null
> + */
> +static CXLDCExtent *cxl_dc_extent_exists(CXLDCExtentList *list,
> +        CXLDCExtentRaw *ext)
> +{
> +    CXLDCExtent *ent;
> +
> +    if (!ext || !list) {
> +        return NULL;
> +    }
> +
> +    QTAILQ_FOREACH(ent, list, node) {
> +        if (ent->start_dpa != ext->start_dpa) {
> +            continue;
> +        }
> +
> +        /*Found exact extent*/
Spacing /* Found .. extent */

> +        return ent->len == ext->len ? ent : NULL;
> +    }
> +
> +    return NULL;
> +}
> +
> +/*
> + * The main function to process dynamic capacity event. Currently DC extents
> + * add/release requests are processed.
> + */
> +static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
> +                                             CXLDCEventType type, uint16_t hid,
> +                                             uint8_t rid,
> +                                             CXLDCExtentRecordList *records,
> +                                             Error **errp)
> +{
> +    Object *obj;
> +    CXLEventDynamicCapacity dCap = {};
> +    CXLEventRecordHdr *hdr = &dCap.hdr;
> +    CXLType3Dev *dcd;
> +    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
> +    uint32_t num_extents = 0;
> +    CXLDCExtentRecordList *list;
> +    g_autofree CXLDCExtentRaw *extents = NULL;
> +    uint8_t enc_log;
> +    uint64_t offset, len, block_size;
> +    int i;
> +    int rc;
> +    g_autofree unsigned long *blk_bitmap = NULL;
> +
> +    obj = object_resolve_path(path, NULL);
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path not point to a valid CXL type3 device");
> +        return;
> +    }
> +
> +    dcd = CXL_TYPE3(obj);
> +    if (!dcd->dc.num_regions) {
> +        error_setg(errp, "No dynamic capacity support from the device");
> +        return;
> +    }
> +
> +    rc = ct3d_qmp_cxl_event_log_enc(log);
> +    if (rc < 0) {
> +        error_setg(errp, "Unhandled error log type");
> +        return;
> +    }
> +    enc_log = rc;
> +
> +    if (rid >= dcd->dc.num_regions) {
> +        error_setg(errp, "region id is too large");
> +        return;
> +    }
> +    block_size = dcd->dc.regions[rid].block_size;
> +
> +    /* Sanity check and count the extents */
> +    list = records;
> +    while (list) {
> +        offset = list->value->offset;
> +        len = list->value->len;
> +
> +        if (len == 0) {
> +            error_setg(errp, "extent with 0 length is not allowed");
> +            return;
> +        }
> +
> +        if (offset % block_size || len % block_size) {
> +            error_setg(errp, "dpa or len is not aligned to region block size");
> +            return;
> +        }
> +
> +        if (offset + len > dcd->dc.regions[rid].len) {
> +            error_setg(errp, "extent range is beyond the region end");
> +            return;
> +        }
> +
> +        num_extents++;
> +        list = list->next;
> +    }
> +    if (num_extents == 0) {
> +        error_setg(errp, "No extents found in the command");
> +        return;
> +    }
> +
> +    blk_bitmap = bitmap_new(dcd->dc.regions[rid].len / block_size);
> +
> +    /* Create Extent list for event being passed to host */
> +    i = 0;
> +    list = records;
> +    extents = g_new0(CXLDCExtentRaw, num_extents);
> +    while (list) {
> +        CXLDCExtent *ent;
> +        bool skip_extent = false;
> +
> +        offset = list->value->offset;
> +        len = list->value->len;
> +
> +        extents[i].start_dpa = offset + dcd->dc.regions[rid].base;
> +        extents[i].len = len;
> +        memset(extents[i].tag, 0, 0x10);
> +        extents[i].shared_seq = 0;
> +
> +        if (type == DC_EVENT_RELEASE_CAPACITY ||
> +            type == DC_EVENT_FORCED_RELEASE_CAPACITY) {
> +            /*
> +             *  if the extent is still pending to be added to the host,
> +             * remove it from the pending extent list, so later when the add
> +             * response for the extent arrives, the device can reject the
> +             * extent as it is not in the pending list.
> +             */
> +            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
> +                        &extents[i]);
> +            if (ent) {
> +                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
> +                g_free(ent);
> +                skip_extent = true;
> +            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
> +                /* If the exact extent is not in the accepted list, skip */
> +                skip_extent = true;
> +            }
> +        }
> +
> +        /* No duplicate or overlapped extents are allowed */
> +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> +                              len / block_size)) {
> +            error_setg(errp, "duplicate or overlapped extents are detected");
> +            return;
> +        }
> +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> +
> +        list = list->next;
> +        if (!skip_extent) {
> +            i++;
> +        }
> +    }
> +    num_extents = i;
> +
> +    switch (type) {
> +    case DC_EVENT_ADD_CAPACITY:
> +        break;
> +    default:
> +        break;
> +    }
> +    /*
> +     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
> +     *
> +     * All Dynamic Capacity event records shall set the Event Record Severity
> +     * field in the Common Event Record Format to Informational Event. All
> +     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
> +     * Event Log.
> +     */
> +    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
> +                            cxl_device_get_timestamp(&dcd->cxl_dstate));
> +
> +    dCap.type = type;
> +    /* FIXME: for now, validaity flag is cleared */

spelling

> +    dCap.validity_flags = 0;
> +    stw_le_p(&dCap.host_id, hid);
> +    /* only valid for DC_REGION_CONFIG_UPDATED event */
> +    dCap.updated_region_id = 0;
> +    /*
> +     * FIXME: for now, "More" flag is cleared as there is only one extent for
> +     * each record

This need more info.  If they have the same tag then should set more on the
records.

> +     */
> +    dCap.flags = 0;
> +
> +    /*
> +     * For current implementation, each DC event record only associates with
> +     * one extent, so the "More" flag does not need to be set.
> +     */
> +    for (i = 0; i < num_extents; i++) {
> +        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
> +               sizeof(CXLDCExtentRaw));
> +
> +        if (type == DC_EVENT_ADD_CAPACITY) {
> +            cxl_insert_extent_to_extent_list(&dcd->dc.extents_pending_to_add,
> +                                             extents[i].start_dpa,
> +                                             extents[i].len,
> +                                             extents[i].tag,
> +                                             extents[i].shared_seq);
> +        }
> +
> +        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
> +                             (CXLEventRecordRaw *)&dCap)) {
> +            cxl_event_irq_assert(dcd);
> +        }
> +    }
> +}


