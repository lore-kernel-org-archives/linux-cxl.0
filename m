Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9367CF2B
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113393; cv=none; b=ch9BjfYS4az1j1u+8GPNhjnZ06bM15bk/PMUcrvMhU5j4aa1mN7ak9skrYHvks01EmTGi/9IAwxj6fhS/EWTVoZOlChS9kTSn9XNqIbUK6MlTIr2lGpLn/6LVUwwlFoD1+EdbYFkKAwmt4o6cKSNK1qdk0pV3Mj2r9DEygjcvL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113393; c=relaxed/simple;
	bh=f1FOkVCVa24IFRFS9cd2l2IHLowCSr49g3kqVfkjXYA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+a4ZWYTXSvZqLU1XTyZc87E/9lKAVdMeOyDhgDWKd4VXIbiwF45TS0fD4SHBRTs89lSvbnWFBHrYNVPxZcqKcSNED8Dn288KpbYlRWUP6DyiKc8Co+SRTjJfn4lx36xkpEncvkasLTY4Nd3dTctZtIRTWO30ajPvxoIFipQljA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKq1Q060nz6K912;
	Thu, 25 Jan 2024 00:20:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D06A1140B55;
	Thu, 25 Jan 2024 00:23:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 16:23:06 +0000
Date: Wed, 24 Jan 2024 16:23:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 7/9] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <20240124162305.00001806@Huawei.com>
In-Reply-To: <20231107180907.553451-8-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
	<20231107180907.553451-8-nifan.cxl@gmail.com>
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

On Tue,  7 Nov 2023 10:07:11 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Per CXL spec 3.0, two mailbox commands are implemented:
> Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.8.9.3, and
> Release Dynamic Capacity (Opcode 4803h) 8.2.9.8.9.4.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Some minor comments inline. Mostly agreeing we need a pending list.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 271 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |   3 +-
>  include/hw/cxl/cxl_device.h |   5 +-
>  3 files changed, 277 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 56f4aa237a..9f788b03b6 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -83,6 +83,8 @@ enum {
>      DCD_CONFIG  = 0x48,
>          #define GET_DC_CONFIG          0x0
>          #define GET_DYN_CAP_EXT_LIST   0x1
> +        #define ADD_DYN_CAP_RSP        0x2
> +        #define RELEASE_DYN_CAP        0x3
>      PHYSICAL_SWITCH = 0x51,
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>          #define GET_PHYSICAL_PORT_STATE     0x1
> @@ -1356,6 +1358,269 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * Check whether any bit between addr[nr, nr+size) is set,
> + * return true if any bit is set, otherwise return false
> + */
> +static bool test_any_bits_set(const unsigned long *addr, int nr, int size)
> +{
> +    unsigned long res = find_next_bit(addr, size + nr, nr);
> +
> +    return res < nr + size;
> +}
> +
> +CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
> +{
> +    CXLDCDRegion *region = &ct3d->dc.regions[0];
> +    int i;
> +
> +    if (dpa < region->base ||
> +        dpa >= region->base + ct3d->dc.total_capacity) {
> +        return NULL;
> +    }
> +
> +    /*
> +     * CXL r3.0 section 9.13.3: Dynamic Capacity Device (DCD)
> +     *
> +     * Regions are used in increasing-DPA order, with Region 0 being used for
> +     * the lowest DPA of Dynamic Capacity and Region 7 for the highest DPA.
> +     * So check from the last region to find where the dpa belongs. Extents that
> +     * cross multiple regions are not allowed.
> +     */
> +    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
> +        region = &ct3d->dc.regions[i];
> +        if (dpa >= region->base) {
> +            /*Should we compare with decode_len or len of the region??*/

len of region. If it's in the hole after the len but before the decoded len
not a lot of use in finding the region as nothing we can do with any access.
If it's useful to match on decode_len here and then reject outside len
at the callers, that's fine too.

> +            if (dpa + len > region->base +
> +                    region->decode_len * CXL_CAPACITY_MULTIPLIER)
> +                return NULL;
> +            return region;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static void cxl_insert_extent_to_extent_list(CXLDCDExtentList *list,
> +                                             uint64_t dpa,
> +                                             uint64_t len,
> +                                             uint8_t *tag,
> +                                             uint16_t shared_seq)
> +{
> +    CXLDCDExtent *extent;
> +
> +    extent = g_new0(CXLDCDExtent, 1);
> +    extent->start_dpa = dpa;
> +    extent->len = len;
> +    if (tag) {
> +        memcpy(extent->tag, tag, 0x10);
> +    } else {
> +        memset(extent->tag, 0, 0x10);

You allocated zero filled above. Don't set them here.

> +    }
> +    extent->shared_seq = shared_seq;
> +
> +    QTAILQ_INSERT_TAIL(list, extent, node);
> +}
> +
> +/*
> + * CXL r3.0 Table 8-129: Add Dynamic Capacity Response Input Payload
> + * CXL r3.0 Table 8-131: Release Dynamic Capacity Input Payload
> + */
> +typedef struct updated_dc_extent_list_in_pl {

Not matching QEMU naming conventions for types which is
camelcase fun.

CXLUpdateDCExtentListInPl perhaps?


> +    uint32_t num_entries_updated;
> +    uint8_t rsvd[4];

There is a flag in there now (fairly sure this one was an errata to r3.0)
but easier to just use r3.1.  That More flag is vital for some of the flows
as it associates multiple records.  We might not implement it yet but
we should have it in the structure at least.

> +    /* CXL r3.0 Table 8-130: Updated Extent List */
> +    struct {
> +        uint64_t start_dpa;
> +        uint64_t len;
> +        uint8_t rsvd[8];
> +    } QEMU_PACKED updated_entries[];
> +} QEMU_PACKED updated_dc_extent_list_in_pl;
> +
> +/*
> + * For the extents in the extent list to operate, check whether they are valid
> + * 1. The extent should be in the range of a valid DC region;
> + * 2. The extent should not cross multiple regions;
> + * 3. The start DPA and the length of the extent should align with the block
> + * size of the region;
> + * 4. The address range of multiple extents in the list should not overlap.
> + */
> +static CXLRetCode cxl_detect_malformed_extent_list(CXLType3Dev *ct3d,
> +        const updated_dc_extent_list_in_pl *in)
> +{
> +    uint64_t min_block_size = UINT64_MAX;
> +    CXLDCDRegion *region = &ct3d->dc.regions[0];
> +    CXLDCDRegion *lastregion = &ct3d->dc.regions[ct3d->dc.num_regions - 1];
> +    g_autofree unsigned long *blk_bitmap = NULL;
> +    uint64_t dpa, len;
> +    uint32_t i;
> +
> +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> +        region = &ct3d->dc.regions[i];
> +        min_block_size = MIN(min_block_size, region->block_size);
> +    }
> +
> +    blk_bitmap = bitmap_new((lastregion->len + lastregion->base -

I'd flip order of those two.  People tend to think base + length I think rather
than length + base.

> +                             ct3d->dc.regions[0].base) / min_block_size);
> +
> +    for (i = 0; i < in->num_entries_updated; i++) {
> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        region = cxl_find_dc_region(ct3d, dpa, len);
> +        if (!region) {
> +            return CXL_MBOX_INVALID_PA;
> +        }
> +
> +        dpa -= ct3d->dc.regions[0].base;
> +        if (dpa % region->block_size || len % region->block_size) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +        /* the dpa range already covered by some other extents in the list */
> +        if (test_any_bits_set(blk_bitmap, dpa / min_block_size,
> +            len / min_block_size)) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +        bitmap_set(blk_bitmap, dpa / min_block_size, len / min_block_size);
> +   }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/*
> + * CXL r3.0 section 8.2.9.8.9.3: Add Dynamic Capacity Response (opcode 4802h)
> + *
> + * Assume an extent is added only after the response is processed successfully
> + * TODO: for better extent list validation, a better solution would be
> + * maintaining a pending extent list and use it to verify the extent list in
> + * the response.

We really should be doing that given the
"shall report invalid physical address if: One or more extents in the updated
 extent list specify a DPA range that is outside the <of> range of the Extent
 List contained in the Add Capacity Event Record"

As you observe, a simple pending list should work for that.
I think we also have to deal with hardware trying to accept only part
of an extent - though we can just reject that if we like with
Resources Exhausted (because it might require tracking resources we can't
handle - think accepting every other 4k of a 2TiB region).

> + */
> +static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> +                                          uint8_t *payload_in,
> +                                          size_t len_in,
> +                                          uint8_t *payload_out,
> +                                          size_t *len_out,
> +                                          CXLCCI *cci)
> +{
> +    updated_dc_extent_list_in_pl *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDCDExtentList *extent_list = &ct3d->dc.extents;
> +    CXLDCDExtent *ent;
> +    uint32_t i;
> +    uint64_t dpa, len;
> +    CXLRetCode ret;
> +
> +    if (in->num_entries_updated == 0) {
> +        return CXL_MBOX_SUCCESS;
> +    }
> +
> +    ret = cxl_detect_malformed_extent_list(ct3d, in);
> +    if (ret != CXL_MBOX_SUCCESS) {
> +        return ret;
> +    }
> +
> +    for (i = 0; i < in->num_entries_updated; i++) {
> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        /*
> +         * Check if the DPA range of the to-be-added extent overlaps with
> +         * existing extent list maintained by the device.
> +         */
> +        QTAILQ_FOREACH(ent, extent_list, node) {
> +            if (ent->start_dpa <= dpa &&
> +                    dpa + len <= ent->start_dpa + ent->len) {
> +                return CXL_MBOX_INVALID_PA;
> +            /* Overlapping one end of the other */
> +            } else if ((dpa < ent->start_dpa + ent->len &&
> +                        dpa + len > ent->start_dpa + ent->len) ||
> +                       (dpa < ent->start_dpa && dpa + len > ent->start_dpa)) {
> +                return CXL_MBOX_INVALID_PA;
> +            }
> +        }
> +
> +        /*
> +         * TODO: add a pending extent list based on event log record and
> +         * verify the input response
> +         */
> +
> +        cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> +        ct3d->dc.total_extent_count += 1;
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/*
> + * CXL r3.0 section 8.2.9.8.9.4: Release Dynamic Capacity (opcode 4803h)
> + */
> +static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
> +                                          uint8_t *payload_in,
> +                                          size_t len_in,
> +                                          uint8_t *payload_out,
> +                                          size_t *len_out,
> +                                          CXLCCI *cci)
> +{
> +    updated_dc_extent_list_in_pl *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDCDExtentList *extent_list = &ct3d->dc.extents;
> +    CXLDCDExtent *ent;
> +    uint32_t i;
> +    uint64_t dpa, len;
> +    CXLRetCode ret;
> +
> +    if (in->num_entries_updated == 0) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    ret = cxl_detect_malformed_extent_list(ct3d, in);
> +    if (ret != CXL_MBOX_SUCCESS) {
> +        return ret;
> +    }
> +
> +    for (i = 0; i < in->num_entries_updated; i++) {
> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        QTAILQ_FOREACH(ent, extent_list, node) {
> +            if (ent->start_dpa <= dpa &&
> +                dpa + len <= ent->start_dpa + ent->len) {
> +                /* Remove any partial extents */

This comment needs more detail.

> +                uint64_t len1 = dpa - ent->start_dpa;
> +                uint64_t len2 = ent->start_dpa + ent->len - dpa - len;
> +
> +                if (len1) {
> +                    cxl_insert_extent_to_extent_list(extent_list,
> +                                                     ent->start_dpa, len1,
> +                                                     NULL, 0);
> +                    ct3d->dc.total_extent_count += 1;
> +                }
> +                if (len2) {
> +                    cxl_insert_extent_to_extent_list(extent_list, dpa + len,
> +                                                     len2, NULL, 0);
> +                    ct3d->dc.total_extent_count += 1;
> +                }
> +                break;
> +                /*Currently we reject the attempt to remove a superset*/

Hmm. That's fine if we do extent fusion. I guess it's fine in general for now
if the linux support doesn't fuse extents in it's tracking,
but I'm not sure the spec allows us to be so picky.

> +            } else if ((dpa < ent->start_dpa + ent->len &&
> +                        dpa + len > ent->start_dpa + ent->len) ||
> +                       (dpa < ent->start_dpa && dpa + len > ent->start_dpa)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +        }
> +
> +        if (ent) {
> +            QTAILQ_REMOVE(extent_list, ent, node);
> +            g_free(ent);
> +            ct3d->dc.total_extent_count -= 1;
> +        } else {
> +            /* Try to remove a non-existing extent */
> +            return CXL_MBOX_INVALID_PA;
> +        }
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +

...

>  static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index c9d792a725..482329a499 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -789,7 +789,7 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
>      int i;
>      uint64_t region_base = 0;
>      uint64_t region_len =  2 * GiB;
> -    uint64_t decode_len = 8; /* 8*256MB */
> +    uint64_t decode_len = 2 * GiB;

Push this down to the earlier patch that introduced this.
I think it's a good change, but given I commented on the oddity of it
there it would be better if it was never odd!

>      uint64_t blk_size = 2 * MiB;
>      CXLDCDRegion *region;
>  
> @@ -803,6 +803,7 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
>      for (i = 0; i < ct3d->dc.num_regions; i++) {
>          region = &ct3d->dc.regions[i];
>          region->base = region_base;
> +        /* NOTE: Should be divided by 256 * MiB before be returned to host */

Is that done?  I'd expect to see that change in this patch.

>          region->decode_len = decode_len;
>          region->len = region_len;
>          region->block_size = blk_size;
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 5738c6f434..b3d35fe000 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -130,7 +130,8 @@ typedef enum {
>      CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
>      CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
>      CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
> -    CXL_MBOX_MAX = 0x17
> +    CXL_MBOX_INVALID_EXTENT_LIST = 0x1E, /* cxl r3.0: Table 8-34*/

This is already in the posted update for the r3.1 codes that I plan
to get upstream ahead of this series. So can drop this bit.

> +    CXL_MBOX_MAX = 0x1F
>  } CXLRetCode;
>  
>  typedef struct CXLCCI CXLCCI;
> @@ -548,4 +549,6 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d);
>  
>  void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
>  
> +CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
> +
>  #endif

