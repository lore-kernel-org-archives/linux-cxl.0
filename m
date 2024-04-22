Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3AB1465AB
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787328; cv=none; b=sfIjpKputgF3rZd/JbvIFsSQtYbEVBa4KyZM1bQFqz5glc0E9U222QrkMd50+HpvL15uspp6W++a+1YWoOQudhcZC3EI9erzzsEIzkHlCQAOBCE1C7eBGv60uRt0pQIxOQzJFazz+7k2joXMrsYJfgknzetRU0FevlJT/jCvUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787328; c=relaxed/simple;
	bh=wsBeajOTB3fIk/x1npN86qu7Lf5AxqPq7FhweTX6Sdc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1m8/OEa7TIPx3NzjhQwF+qZcx9Se6Z0MkxH3B97KNbR/YYX3WunzybHWZkHlybFJRwCFhotYYP0jN1J90GyI9cb2JnQlsI5yWUiAaimgE7o915nEBBeFtnsccXpYbvPoYppiyAMm9q76s64s2EuhxRMaYH81rQxHBTH90+aBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNP1r4L2Tz6K6f8;
	Mon, 22 Apr 2024 19:59:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C8C3140AE5;
	Mon, 22 Apr 2024 20:02:00 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 13:01:59 +0100
Date: Mon, 22 Apr 2024 13:01:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>,
	Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240422130158.000030c8@huawei.com>
In-Reply-To: <20240418232902.583744-10-fan.ni@samsung.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
	<20240418232902.583744-10-fan.ni@samsung.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
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

On Thu, 18 Apr 2024 16:11:00 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
>

Hi Fan,

Please expand CC list to include QAPI maintainers.
+CC Markus and Micheal.

Also, for future versions +CC Michael Tsirkin.

I'm find rolling these up as a series with the precursors but
if it is already some Michael has seen it may speed things up.

Jonathan

p.s. Today I'm just building a tree, but will circle back around
later in the week with a final review of the last few changes.

 
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
> ---
>  hw/cxl/cxl-mailbox-utils.c  |  62 +++++--
>  hw/mem/cxl_type3.c          | 311 +++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3_stubs.c    |  20 +++
>  include/hw/cxl/cxl_device.h |  22 +++
>  include/hw/cxl/cxl_events.h |  18 +++
>  qapi/cxl.json               |  69 ++++++++
>  6 files changed, 489 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9d54e10cd4..3569902e9e 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1405,7 +1405,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
>   * Check whether any bit between addr[nr, nr+size) is set,
>   * return true if any bit is set, otherwise return false
>   */
> -static bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
> +bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
>                                unsigned long size)
>  {
>      unsigned long res = find_next_bit(addr, size + nr, nr);
> @@ -1444,7 +1444,7 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
>      return NULL;
>  }
>  
> -static void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
> +void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
>                                               uint64_t dpa,
>                                               uint64_t len,
>                                               uint8_t *tag,
> @@ -1470,6 +1470,44 @@ void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
>      g_free(extent);
>  }
>  
> +/*
> + * Add a new extent to the extent "group" if group exists;
> + * otherwise, create a new group
> + * Return value: return the group where the extent is inserted.
> + */
> +CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
> +                                                    uint64_t dpa,
> +                                                    uint64_t len,
> +                                                    uint8_t *tag,
> +                                                    uint16_t shared_seq)
> +{
> +    if (!group) {
> +        group = g_new0(CXLDCExtentGroup, 1);
> +        QTAILQ_INIT(&group->list);
> +    }
> +    cxl_insert_extent_to_extent_list(&group->list, dpa, len,
> +                                     tag, shared_seq);
> +    return group;
> +}
> +
> +void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
> +                                       CXLDCExtentGroup *group)
> +{
> +    QTAILQ_INSERT_TAIL(list, group, node);
> +}
> +
> +void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
> +{
> +    CXLDCExtent *ent, *ent_next;
> +    CXLDCExtentGroup *group = QTAILQ_FIRST(list);
> +
> +    QTAILQ_REMOVE(list, group, node);
> +    QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
> +        cxl_remove_extent_from_extent_list(&group->list, ent);
> +    }
> +    g_free(group);
> +}
> +
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
> @@ -1586,10 +1629,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
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
> @@ -1615,11 +1655,9 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>  
>          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
>          ct3d->dc.total_extent_count += 1;
> -        /*
> -         * TODO: we will add a pending extent list based on event log record
> -         * and process the list accordingly here.
> -         */
>      }
> +    /* Remove the first extent group in the pending list*/
> +    cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
>  
>      return CXL_MBOX_SUCCESS;
>  }
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index c2cdd6d506..e892b3de7b 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -667,6 +667,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>          ct3d->dc.total_capacity += region->len;
>      }
>      QTAILQ_INIT(&ct3d->dc.extents);
> +    QTAILQ_INIT(&ct3d->dc.extents_pending);
>  
>      return true;
>  }
> @@ -674,10 +675,19 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>  static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
>  {
>      CXLDCExtent *ent, *ent_next;
> +    CXLDCExtentGroup *group, *group_next;
>  
>      QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
>          cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
>      }
> +
> +    QTAILQ_FOREACH_SAFE(group, &ct3d->dc.extents_pending, node, group_next) {
> +        QTAILQ_REMOVE(&ct3d->dc.extents_pending, group, node);
> +        QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
> +            cxl_remove_extent_from_extent_list(&group->list, ent);
> +        }
> +        g_free(group);
> +    }
>  }
>  
>  static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> @@ -1443,7 +1453,6 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
>          return CXL_EVENT_TYPE_FAIL;
>      case CXL_EVENT_LOG_FATAL:
>          return CXL_EVENT_TYPE_FATAL;
> -/* DCD not yet supported */
>      default:
>          return -EINVAL;
>      }
> @@ -1694,6 +1703,306 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>      }
>  }
>  
> +/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
> +static const QemuUUID dynamic_capacity_uuid = {
> +    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
> +                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> +};
> +
> +typedef enum CXLDCEventType {
> +    DC_EVENT_ADD_CAPACITY = 0x0,
> +    DC_EVENT_RELEASE_CAPACITY = 0x1,
> +    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
> +    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
> +    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
> +    DC_EVENT_CAPACITY_RELEASED = 0x5,
> +} CXLDCEventType;
> +
> +/*
> + * Check whether the range [dpa, dpa + len - 1] has overlaps with extents in
> + * the list.
> + * Return value: return true if has overlaps; otherwise, return false
> + */
> +static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> +                                           uint64_t dpa, uint64_t len)
> +{
> +    CXLDCExtent *ent;
> +    Range range1, range2;
> +
> +    if (!list) {
> +        return false;
> +    }
> +
> +    range_init_nofail(&range1, dpa, len);
> +    QTAILQ_FOREACH(ent, list, node) {
> +        range_init_nofail(&range2, ent->start_dpa, ent->len);
> +        if (range_overlaps_range(&range1, &range2)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +/*
> + * Check whether the range [dpa, dpa + len - 1] is contained by extents in
> + * the list.
> + * Will check multiple extents containment once superset release is added.
> + * Return value: return true if range is contained; otherwise, return false
> + */
> +bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
> +                                    uint64_t dpa, uint64_t len)
> +{
> +    CXLDCExtent *ent;
> +    Range range1, range2;
> +
> +    if (!list) {
> +        return false;
> +    }
> +
> +    range_init_nofail(&range1, dpa, len);
> +    QTAILQ_FOREACH(ent, list, node) {
> +        range_init_nofail(&range2, ent->start_dpa, ent->len);
> +        if (range_contains_range(&range2, &range1)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> +                                                uint64_t dpa, uint64_t len)
> +{
> +    CXLDCExtentGroup *group;
> +
> +    if (!list) {
> +        return false;
> +    }
> +
> +    QTAILQ_FOREACH(group, list, node) {
> +        if (cxl_extents_overlaps_dpa_range(&group->list, dpa, len)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
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
> +            if (cxl_extent_groups_overlaps_dpa_range(&dcd->dc.extents_pending,
> +                                                     dpa, len)) {
> +                error_setg(errp,
> +                           "cannot add DPA again while still pending");
> +                return;
> +            }
> +        }
> +        list = list->next;
> +        num_extents++;
> +    }
> +
> +    /* Create extent list for event being passed to host */
> +    i = 0;
> +    list = records;
> +    extents = g_new0(CXLDCExtentRaw, num_extents);
> +    while (list) {
> +        offset = list->value->offset;
> +        len = list->value->len;
> +        dpa = dcd->dc.regions[rid].base + offset;
> +
> +        extents[i].start_dpa = dpa;
> +        extents[i].len = len;
> +        memset(extents[i].tag, 0, 0x10);
> +        extents[i].shared_seq = 0;
> +        if (type == DC_EVENT_ADD_CAPACITY) {
> +            group = cxl_insert_extent_to_extent_group(group,
> +                                                      extents[i].start_dpa,
> +                                                      extents[i].len,
> +                                                      extents[i].tag,
> +                                                      extents[i].shared_seq);
> +        }
> +
> +        list = list->next;
> +        i++;
> +    }
> +    if (group) {
> +        cxl_extent_group_list_insert_tail(&dcd->dc.extents_pending, group);
> +    }
> +
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
> +    /* FIXME: for now, validity flag is cleared */
> +    dCap.validity_flags = 0;
> +    stw_le_p(&dCap.host_id, hid);
> +    /* only valid for DC_REGION_CONFIG_UPDATED event */
> +    dCap.updated_region_id = 0;
> +    dCap.flags = 0;
> +    for (i = 0; i < num_extents; i++) {
> +        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
> +               sizeof(CXLDCExtentRaw));
> +
> +        if (i < num_extents - 1) {
> +            /* Set "More" flag */
> +            dCap.flags |= BIT(0);
> +        }
> +
> +        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
> +                             (CXLEventRecordRaw *)&dCap)) {
> +            cxl_event_irq_assert(dcd);
> +        }
> +    }
> +}
> +
> +void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t hid,
> +                                  uint8_t sel_policy, uint8_t region_id,
> +                                  const char *tag,
> +                                  CXLDCExtentRecordList  *records,
> +                                  Error **errp)
> +{
> +    enum {
> +        CXL_SEL_POLICY_FREE,
> +        CXL_SEL_POLICY_CONTIGUOUS,
> +        CXL_SEL_POLICY_PRESCRIPTIVE,
> +        CXL_SEL_POLICY_ENABLESHAREDACCESS,
> +    };
> +    switch (sel_policy) {
> +    case CXL_SEL_POLICY_PRESCRIPTIVE:
> +        qmp_cxl_process_dynamic_capacity_prescriptive(path, hid,
> +                                                      DC_EVENT_ADD_CAPACITY,
> +                                                      region_id, records, errp);
> +        return;
> +    default:
> +        error_setg(errp, "Selection policy not supported");
> +        return;
> +    }
> +}
> +
> +#define REMOVAL_POLICY_MASK 0xf
> +#define REMOVAL_POLICY_PRESCRIPTIVE 1
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
> +    case REMOVAL_POLICY_PRESCRIPTIVE:
> +        qmp_cxl_process_dynamic_capacity_prescriptive(path, hid, type,
> +                                                      region_id, records, errp);
> +        return;
> +    default:
> +        error_setg(errp, "Removal policy not supported");
> +        return;
> +    }
> +}
> +
>  static void ct3_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 3e1851e32b..810685e0d5 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -67,3 +67,23 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
>  {
>      error_setg(errp, "CXL Type 3 support is not compiled in");
>  }
> +
> +void qmp_cxl_add_dynamic_capacity(const char *path,
> +                                  uint16_t hid,
> +                                  uint8_t sel_policy,
> +                                  uint8_t region_id,
> +                                  const char *tag,
> +                                  CXLDCExtentRecordList  *records,
> +                                  Error **errp)
> +{
> +    error_setg(errp, "CXL Type 3 support is not compiled in");
> +}
> +
> +void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t hid,
> +                                      uint8_t flags, uint8_t region_id,
> +                                      const char *tag,
> +                                      CXLDCExtentRecordList  *records,
> +                                      Error **errp)
> +{
> +    error_setg(errp, "CXL Type 3 support is not compiled in");
> +}
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index df3511e91b..c69ff6b5de 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -443,6 +443,12 @@ typedef struct CXLDCExtent {
>  } CXLDCExtent;
>  typedef QTAILQ_HEAD(, CXLDCExtent) CXLDCExtentList;
>  
> +typedef struct CXLDCExtentGroup {
> +    CXLDCExtentList list;
> +    QTAILQ_ENTRY(CXLDCExtentGroup) node;
> +} CXLDCExtentGroup;
> +typedef QTAILQ_HEAD(, CXLDCExtentGroup) CXLDCExtentGroupList;
> +
>  typedef struct CXLDCRegion {
>      uint64_t base;       /* aligned to 256*MiB */
>      uint64_t decode_len; /* aligned to 256*MiB */
> @@ -494,6 +500,7 @@ struct CXLType3Dev {
>           */
>          uint64_t total_capacity; /* 256M aligned */
>          CXLDCExtentList extents;
> +        CXLDCExtentGroupList extents_pending;
>          uint32_t total_extent_count;
>          uint32_t ext_list_gen_seq;
>  
> @@ -555,4 +562,19 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
>  
>  void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
>                                          CXLDCExtent *extent);
> +void cxl_insert_extent_to_extent_list(CXLDCExtentList *list, uint64_t dpa,
> +                                      uint64_t len, uint8_t *tag,
> +                                      uint16_t shared_seq);
> +bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
> +                       unsigned long size);
> +bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
> +                                    uint64_t dpa, uint64_t len);
> +CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
> +                                                    uint64_t dpa,
> +                                                    uint64_t len,
> +                                                    uint8_t *tag,
> +                                                    uint16_t shared_seq);
> +void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
> +                                       CXLDCExtentGroup *group);
> +void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
>  #endif
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 5170b8dbf8..38cadaa0f3 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -166,4 +166,22 @@ typedef struct CXLEventMemoryModule {
>      uint8_t reserved[0x3d];
>  } QEMU_PACKED CXLEventMemoryModule;
>  
> +/*
> + * CXL r3.1 section Table 8-50: Dynamic Capacity Event Record
> + * All fields little endian.
> + */
> +typedef struct CXLEventDynamicCapacity {
> +    CXLEventRecordHdr hdr;
> +    uint8_t type;
> +    uint8_t validity_flags;
> +    uint16_t host_id;
> +    uint8_t updated_region_id;
> +    uint8_t flags;
> +    uint8_t reserved2[2];
> +    uint8_t dynamic_capacity_extent[0x28]; /* defined in cxl_device.h */
> +    uint8_t reserved[0x18];
> +    uint32_t extents_avail;
> +    uint32_t tags_avail;
> +} QEMU_PACKED CXLEventDynamicCapacity;
> +
>  #endif /* CXL_EVENTS_H */
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 4281726dec..2dcf03d973 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -361,3 +361,72 @@
>  ##
>  {'command': 'cxl-inject-correctable-error',
>   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> +
> +##
> +# @CXLDCExtentRecord:
> +#
> +# Record of a single extent to add/release
> +#
> +# @offset: offset to the start of the region where the extent to be operated
> +# @len: length of the extent
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'CXLDCExtentRecord',
> +  'data': {
> +      'offset':'uint64',
> +      'len': 'uint64'
> +  }
> +}
> +
> +##
> +# @cxl-add-dynamic-capacity:
> +#
> +# Command to start add dynamic capacity extents flow. The device will
> +# have to acknowledged the acceptance of the extents before they are usable.
> +#
> +# @path: CXL DCD canonical QOM path
> +# @hid: host id
> +# @selection-policy: policy to use for selecting extents for adding capacity
> +# @region-id: id of the region where the extent to add
> +# @tag: Context field
> +# @extents: Extents to add
> +#
> +# Since : 9.1
> +##
> +{ 'command': 'cxl-add-dynamic-capacity',
> +  'data': { 'path': 'str',
> +            'hid': 'uint16',
> +            'selection-policy': 'uint8',
> +            'region-id': 'uint8',
> +            'tag': 'str',
> +            'extents': [ 'CXLDCExtentRecord' ]
> +           }
> +}
> +
> +##
> +# @cxl-release-dynamic-capacity:
> +#
> +# Command to start release dynamic capacity extents flow. The host will
> +# need to respond to indicate that it has released the capacity before it
> +# is made unavailable for read and write and can be re-added.
> +#
> +# @path: CXL DCD canonical QOM path
> +# @hid: host id
> +# @flags: bit[3:0] for removal policy, bit[4] for forced removal, bit[5] for
> +#     sanitize on release, bit[7:6] reserved
> +# @region-id: id of the region where the extent to release
> +# @tag: Context field
> +# @extents: Extents to release
> +#
> +# Since : 9.1
> +##
> +{ 'command': 'cxl-release-dynamic-capacity',
> +  'data': { 'path': 'str',
> +            'hid': 'uint16',
> +            'flags': 'uint8',
> +            'region-id': 'uint8',
> +            'tag': 'str',
> +            'extents': [ 'CXLDCExtentRecord' ]
> +           }
> +}

