Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3637B12E1F0
	for <linux-cxl@vger.kernel.org>; Tue, 16 Apr 2024 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279510; cv=none; b=CuF+4Z6Ot0xkQOGS162V0hlJtcnjOTYehrKNGnlGq82W3jcI9O5uE9D/qFiKXI9u0s1geAlnXovb3oT79ei1FARNKKhP+xrwHjU+agwOmrbWhijOPLRvQft4iWR15jp1oliKszqfYO8qJhfeGFTF/3BqPP0DxKYHynpRIcSuYhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279510; c=relaxed/simple;
	bh=bETq7/7GC09YfT1jowh8uKz1v1yCpOI30Q09wNPBOBg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DaqwmPzUSPwQlr0DgwVAfExQELcoTtbebodTC7hwEGR5WvhZ6R6NQcJ4+ONlxgW3B02Vrsi8nkOchOoDAzhhzxdY1lIkhAAjHrztV3NVVriNPi7EKpCBGFV7XsfBP+etQ8UQ8tEXjb4SUWYBTv2XNEjdAnmDYaZIYQuqL6r4ShY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VJn940QWZz6K6c6;
	Tue, 16 Apr 2024 22:53:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5272A140119;
	Tue, 16 Apr 2024 22:58:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 16 Apr
 2024 15:58:23 +0100
Date: Tue, 16 Apr 2024 15:58:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240416155822.00004fce@Huawei.com>
In-Reply-To: <Zh2IrA8TQDJn1ft_@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
	<20240325190339.696686-10-nifan.cxl@gmail.com>
	<20240405131856.000025e7@Huawei.com>
	<ZhWym2yHoh6YIaXj@debian>
	<20240410204911.0000590b@Huawei.com>
	<Zh2IrA8TQDJn1ft_@debian>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Apr 2024 13:06:04 -0700
fan <nifan.cxl@gmail.com> wrote:

> From ce75be83e915fbc4dd6e489f976665b81174002b Mon Sep 17 00:00:00 2001
> From: Fan Ni <fan.ni@samsung.com>
> Date: Tue, 20 Feb 2024 09:48:31 -0800
> Subject: [PATCH 09/13] hw/cxl/events: Add qmp interfaces to add/release
>  dynamic capacity extents
> 
> To simulate FM functionalities for initiating Dynamic Capacity Add
> (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL spec
> r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces to issue
> add/release dynamic capacity extents requests.
> 
> With the change, we allow to release an extent only when its DPA range
> is contained by a single accepted extent in the device. That is to say,
> extent superset release is not supported yet.
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
>       "hid": 0,
>       "selection-policy": 2,
>       "region-id": 0,
>       "tag": "",
>       "extents": [
>       {
>           "offset": 0,
>           "len": 134217728
>       },
>       {
>           "offset": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
> 
> 2. Release dynamic capacity extents:
> 
> For example, the command to release an extent of size 128MiB from region 0
> (DPA offset 128MiB) looks like below:
> 
> { "execute": "cxl-release-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "hid": 0,
>       "flags": 1,
>       "region-id": 0,
>       "tag": "",
>       "extents": [
>       {
>           "offset": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Nice!  A few small comments inline - particularly don't be nice to the
kernel by blocking things it doesn't understand yet ;)

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c  |  65 ++++++--
>  hw/mem/cxl_type3.c          | 310 +++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3_stubs.c    |  20 +++
>  include/hw/cxl/cxl_device.h |  22 +++
>  include/hw/cxl/cxl_events.h |  18 +++
>  qapi/cxl.json               |  69 ++++++++
>  6 files changed, 491 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index cd9092b6bf..839ae836a1 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c

>  /*
>   * CXL r3.1 Table 8-168: Add Dynamic Capacity Response Input Payload
>   * CXL r3.1 Table 8-170: Release Dynamic Capacity Input Payload
> @@ -1541,6 +1579,7 @@ static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
>  {
>      uint32_t i;
>      CXLDCExtent *ent;
> +    CXLDCExtentGroup *ext_group;
>      uint64_t dpa, len;
>      Range range1, range2;
>  
> @@ -1551,9 +1590,13 @@ static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
>          range_init_nofail(&range1, dpa, len);
>  
>          /*
> -         * TODO: once the pending extent list is added, check against
> -         * the list will be added here.
> +         * The host-accepted DPA range must be contained by the first extent
> +         * group in the pending list
>           */
> +        ext_group = QTAILQ_FIRST(&ct3d->dc.extents_pending);
> +        if (!cxl_extents_contains_dpa_range(&ext_group->list, dpa, len)) {
> +            return CXL_MBOX_INVALID_PA;
> +        }
>  
>          /* to-be-added range should not overlap with range already accepted */
>          QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
> @@ -1588,26 +1631,26 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>      CXLRetCode ret;
>  
>      if (in->num_entries_updated == 0) {
> -        /*
> -         * TODO: once the pending list is introduced, extents in the beginning
> -         * will get wiped out.
> -         */
> +        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
>          return CXL_MBOX_SUCCESS;
>      }
>  
>      /* Adding extents causes exceeding device's extent tracking ability. */
>      if (in->num_entries_updated + ct3d->dc.total_extent_count >
>          CXL_NUM_EXTENTS_SUPPORTED) {
> +        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
>          return CXL_MBOX_RESOURCES_EXHAUSTED;
>      }
>  
>      ret = cxl_detect_malformed_extent_list(ct3d, in);
>      if (ret != CXL_MBOX_SUCCESS) {
> +        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);

If it's a bad message from the host, I don't think the device is supposed to
do anything with pending extents.

>          return ret;
>      }
>  
>      ret = cxl_dcd_add_dyn_cap_rsp_dry_run(ct3d, in);
>      if (ret != CXL_MBOX_SUCCESS) {
> +        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
>          return ret;
>      }



> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 2d4b6242f0..8d99b27b27 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c

> +/*
> + * The main function to process dynamic capacity event with extent list.
> + * Currently DC extents add/release requests are processed.
> + */
> +static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
> +        uint16_t hid, CXLDCEventType type, uint8_t rid,
> +        CXLDCExtentRecordList *records, Error **errp)
> +{
> +    Object *obj;
> +    CXLEventDynamicCapacity dCap = {};
> +    CXLEventRecordHdr *hdr = &dCap.hdr;
> +    CXLType3Dev *dcd;
> +    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
> +    uint32_t num_extents = 0;
> +    CXLDCExtentRecordList *list;
> +    CXLDCExtentGroup *group = NULL;
> +    g_autofree CXLDCExtentRaw *extents = NULL;
> +    uint8_t enc_log = CXL_EVENT_TYPE_DYNAMIC_CAP;
> +    uint64_t dpa, offset, len, block_size;
> +    g_autofree unsigned long *blk_bitmap = NULL;
> +    int i;
> +
> +    obj = object_resolve_path_type(path, TYPE_CXL_TYPE3, NULL);
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve CXL type 3 device");
> +        return;
> +    }
> +
> +    dcd = CXL_TYPE3(obj);
> +    if (!dcd->dc.num_regions) {
> +        error_setg(errp, "No dynamic capacity support from the device");
> +        return;
> +    }
> +
> +
> +    if (rid >= dcd->dc.num_regions) {
> +        error_setg(errp, "region id is too large");
> +        return;
> +    }
> +    block_size = dcd->dc.regions[rid].block_size;
> +    blk_bitmap = bitmap_new(dcd->dc.regions[rid].len / block_size);
> +
> +    /* Sanity check and count the extents */
> +    list = records;
> +    while (list) {
> +        offset = list->value->offset;
> +        len = list->value->len;
> +        dpa = offset + dcd->dc.regions[rid].base;
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
> +        /* No duplicate or overlapped extents are allowed */
> +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> +                              len / block_size)) {
> +            error_setg(errp, "duplicate or overlapped extents are detected");
> +            return;
> +        }
> +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> +
> +        if (type == DC_EVENT_RELEASE_CAPACITY) {
> +            if (cxl_extent_groups_overlaps_dpa_range(&dcd->dc.extents_pending,
> +                                                     dpa, len)) {
> +                error_setg(errp,
> +                           "cannot release extent with pending DPA range");
> +                return;
> +            }
> +            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents, dpa, len)) {
> +                error_setg(errp,
> +                           "cannot release extent with non-existing DPA range");
> +                return;
> +            }
> +        } else if (type == DC_EVENT_ADD_CAPACITY) {
> +            if (cxl_extents_overlaps_dpa_range(&dcd->dc.extents, dpa, len)) {
> +                error_setg(errp,
> +                           "cannot add DPA already accessible  to the same LD");
> +                return;
> +            }
> +        }
> +        list = list->next;
> +        num_extents++;
> +    }
> +
> +    if (num_extents > 1) {
> +        error_setg(errp,
> +                   "TODO: remove the check once kernel support More flag");
Not our problem :)  For now we can just test the kernel by passing in single
extents via separate commands.

I don't want to carry unnecessary limitations in qemu.

> +        return;
> +    }
> +

> +
> +#define REMOVAL_POLICY_MASK 0xf
> +#define FORCED_REMOVAL_BIT BIT(4)
> +
> +void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t hid,
> +                                      uint8_t flags, uint8_t region_id,
> +                                      const char *tag,
> +                                      CXLDCExtentRecordList  *records,
> +                                      Error **errp)
> +{
> +    CXLDCEventType type = DC_EVENT_RELEASE_CAPACITY;
> +
> +    if (flags & FORCED_REMOVAL_BIT) {
> +        /* TODO: enable forced removal in the future */
> +        type = DC_EVENT_FORCED_RELEASE_CAPACITY;
> +        error_setg(errp, "Forced removal not supported yet");
> +        return;
> +    }
> +
> +    switch (flags & REMOVAL_POLICY_MASK) {
> +    case 1:
Probably benefit form a suitable define.

> +        qmp_cxl_process_dynamic_capacity_prescriptive(path, hid, type,
> +                                                      region_id, records, errp);
> +        break;

I'd not noticed before but might as well return from these case blocks.

> +    default:
> +        error_setg(errp, "Removal policy not supported");
> +        break;
> +    }
> +}
