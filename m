Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8380FEB64DD
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Aug 2023 12:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjHGMAT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Aug 2023 08:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjHGMAP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Aug 2023 08:00:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF602128
        for <linux-cxl@vger.kernel.org>; Mon,  7 Aug 2023 04:59:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKDq91KC0z6J7Ys;
        Mon,  7 Aug 2023 19:38:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 12:42:31 +0100
Date:   Mon, 7 Aug 2023 12:42:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [Qemu PATCH v2 7/9] hw/cxl/cxl-mailbox-utils: Add mailbox
 commands to support add/release dynamic capacity response
Message-ID: <20230807124230.00002b3d@Huawei.com>
In-Reply-To: <20230725183939.2741025-8-fan.ni@samsung.com>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
        <CGME20230725183957uscas1p2a076b6f7b694d2e632a0b8025ec331d7@uscas1p2.samsung.com>
        <20230725183939.2741025-8-fan.ni@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 25 Jul 2023 18:39:56 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> From: Fan Ni <nifan@outlook.com>
> 
> Per CXL spec 3.0, two mailbox commands are implemented:
> Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.8.9.3, and
> Release Dynamic Capacity (Opcode 4803h) 8.2.9.8.9.4.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

I'm reviewing these backwards mostly because I'm tidying them up in that
order (makes rebases easier).  Hence some of this only makes sense in light of
patch 9 comments!

In my rebase of this, I've made some changes that are non trivial
so definitely want you to look at them.

I also left what I think is a nasty bug.  If we get extents
added next to each other they aren't fused, so a release extent that
covers more than one will fail.  Far as I can tell that's a valid
if weird corner cases.

Jonathan


> ---
>  hw/cxl/cxl-mailbox-utils.c  | 253 ++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |   3 +-
>  2 files changed, 255 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 3d25a9697e..1e4944da95 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -84,6 +84,8 @@ enum {
>      DCD_CONFIG  = 0x48, /*r3.0: 8.2.9.8.9*/
>          #define GET_DC_CONFIG          0x0
>          #define GET_DYN_CAP_EXT_LIST   0x1
> +        #define ADD_DYN_CAP_RSP        0x2
> +        #define RELEASE_DYN_CAP        0x3
>      PHYSICAL_SWITCH = 0x51
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>  };
> @@ -1086,6 +1088,251 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * Check whether the bits at addr between [nr, nr+size) are all set,
> + * return 1 if all 1s, else return 0
> + */
> +static inline int test_bits(const unsigned long *addr, int nr, int size)
bool

Also, let the compiler make decisions on inlining.

Hmm. Documentation lacking on find_next_zero_bit() but I think it returns
the size if there aren't any so this should be fine.

> +{
> +    unsigned long res = find_next_zero_bit(addr, size + nr, nr);
> +
> +    return (res >= nr + size) ? 1 : 0;
> +}
> +
> +/*
> + * Find dynamic capacity region id based on dpa range [dpa, dpa+len)
> + */
> +static uint8_t find_region_id(struct CXLType3Dev *dev, uint64_t dpa,
> +        uint64_t len)
> +{
> +    int8_t i = dev->dc.num_regions - 1;
> +
> +    while (i > 0 && dpa < dev->dc.regions[i].base) {
> +        i--;
> +    }
This is another search function, similar to the one I factored out when applying
patch 9.  I'll pull that function back here instead of having it in patch 9
+ rename it to be more in keeping with functions in this file.

The handling is a little different (NULL or the region pointer, and that also
simplifies the code around where it is used a little.

> +
> +    if (dpa < dev->dc.regions[i].base
> +            || dpa + len > dev->dc.regions[i].base + dev->dc.regions[i].len) {
> +        return dev->dc.num_regions;
> +    }
> +
> +    return i;
> +}
> +
> +static void insert_extent_to_extent_list(CXLDCDExtentList *list, uint64_t dpa,
> +        uint64_t len, uint8_t *tag, uint16_t shared_seq)
> +{
> +    CXLDCD_Extent *extent;
> +    extent = g_new0(CXLDCD_Extent, 1);
> +    extent->start_dpa = dpa;
> +    extent->len = len;
> +    if (tag) {
> +        memcpy(extent->tag, tag, 0x10);
> +    } else {
> +        memset(extent->tag, 0, 0x10);
> +    }
> +    extent->shared_seq = shared_seq;
> +
> +    QTAILQ_INSERT_TAIL(list, extent, node);
> +}
> +
Added a reference to both Table 8-129 and Table 8-131 here

> +typedef struct updated_dc_extent_list_in_pl {
> +    uint32_t num_entries_updated;
> +    uint8_t rsvd[4];
> +    struct { /* r3.0: Table 8-130 */

I reformatted this and added name of table. Makes it easier
to find in CXL rN.0

> +        uint64_t start_dpa;
> +        uint64_t len;
> +        uint8_t rsvd[8];
> +    } QEMU_PACKED updated_entries[];
> +} QEMU_PACKED updated_dc_extent_list_in_pl;
> +
> +/*
> + * The function only check the input extent list against itself.

I haven't added any info here yet, but feels like this function needs
comments on what those checks are doing.

> + */
> +static CXLRetCode detect_malformed_extent_list(CXLType3Dev *dev,

prefixed with cxl_ to keep everything that is easy to do namespaced.

> +        const updated_dc_extent_list_in_pl *in)
> +{
> +    unsigned long *blk_bitmap;
> +    uint64_t min_block_size = dev->dc.regions[0].block_size;

If we use UINT64_MAX then anything seen will be less than it and
we can just loop over all regions.

> +    struct CXLDCD_Region *region = &dev->dc.regions[0];
> +    uint32_t i;
> +    uint64_t dpa, len;
> +    uint8_t rid;
> +    CXLRetCode ret;
> +
> +    for (i = 1; i < dev->dc.num_regions; i++) {
> +        region = &dev->dc.regions[i];
> +        if (min_block_size > region->block_size) {
> +            min_block_size = region->block_size;
> +        }
	min_block_size = MIN(min_block_size, region->block_size);
> +    }
> +
> +    blk_bitmap = bitmap_new((region->len + region->base

This is tricky to read as relies on side effect loop above.
Better to use
	&dev->dc.regions[dev->dc.num_regions - 1]
explicitly via a
CXLDCDregion *lastregion = &dev->dc.regions[dev->dc.num_regions]
though I also renamed dev at ct3d to make the type more obvious.



> +                - dev->dc.regions[0].base) / min_block_size);
> +
> +    for (i = 0; i < in->num_entries_updated; i++) {
> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        rid = find_region_id(dev, dpa, len);
rid is never needed here as such - just a check on whether the
region exists. Hence use the find function previously pulled out of patch 9.

> +        if (rid == dev->dc.num_regions) {
> +            ret = CXL_MBOX_INVALID_PA;
> +            goto out;
> +        }
> +
> +        region = &dev->dc.regions[rid];
> +        if (dpa % region->block_size || len % region->block_size) {
> +            ret = CXL_MBOX_INVALID_EXTENT_LIST;
> +            goto out;
> +        }
> +        /* the dpa range already covered by some other extents in the list */
> +        if (test_bits(blk_bitmap, dpa / min_block_size, len / min_block_size)) {
> +            ret = CXL_MBOX_INVALID_EXTENT_LIST;
> +            goto out;
> +        }
> +        bitmap_set(blk_bitmap, dpa / min_block_size, len / min_block_size);
> +   }
> +
> +    ret = CXL_MBOX_SUCCESS;
> +
> +out:

Great place for a g_autofree magic pointer as then can return above without any
manual cleanup.

> +    g_free(blk_bitmap);
> +    return ret;
> +}
> +
> +/*
> + * cxl spec 3.0: 8.2.9.8.9.3
> + * Add Dynamic Capacity Response (opcode 4802h)
> + * Assume an extent is added only after the response is processed successfully
> + * TODO: for better extent list validation, a better solution would be
> + * maintaining a pending extent list and use it to verify the extent list in
> + * the response.
> + */
> +static CXLRetCode cmd_dcd_add_dyn_cap_rsp(struct cxl_cmd *cmd,
> +        CXLDeviceState *cxl_dstate, uint16_t *len_unused)
> +{
> +    updated_dc_extent_list_in_pl *in = (void *)cmd->payload;
> +    struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev,
> +            cxl_dstate);
> +    CXLDCDExtentList *extent_list = &ct3d->dc.extents;
> +    CXLDCD_Extent *ent;
> +    uint32_t i;
> +    uint64_t dpa, len;
> +    CXLRetCode ret;
> + 
> +    if (in->num_entries_updated == 0) {
> +        ret = CXL_MBOX_SUCCESS;
> +        goto out;

I always prefer direct returns as it makes the flows easier to follow.
(don't need to go see what cleanup is there - in this case none!)

> +    }
> +
> +    ret = detect_malformed_extent_list(ct3d, in);
> +    if (ret != CXL_MBOX_SUCCESS) {
> +        goto out;
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
> +            if (ent->start_dpa == dpa && ent->len == len) {
> +                ret = CXL_MBOX_INVALID_PA;
> +                goto out;
> +            } else if (ent->start_dpa <= dpa
> +                    && dpa + len <= ent->start_dpa + ent->len) {

I think this second one always incorporates the first case.
I haven't changed this yet though...  Added a todo note.

> +                ret = CXL_MBOX_INVALID_PA;
> +                goto out;
> +            } else if ((dpa < ent->start_dpa + ent->len
> +                        && dpa + len > ent->start_dpa + ent->len)
> +                    || (dpa < ent->start_dpa && dpa + len > ent->start_dpa)) {
> +                ret = CXL_MBOX_INVALID_PA;
> +                goto out;
> +            }
> +        }
> +
> +        /*
> +         * TODO: add a pending extent list based on event log record and verify
> +         * the input response
> +         */
> +
> +        insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> +    }
> +    ret = CXL_MBOX_SUCCESS;
> +
> +out:
> +    return ret;
> +}
> +
> +/*
> + * Spec 3.0: 8.2.9.8.9.4
> + * Release Dynamic Capacity (opcode 4803h)
> + **/
> +static CXLRetCode cmd_dcd_release_dyn_cap(struct cxl_cmd *cmd,
> +        CXLDeviceState *cxl_dstate,
> +        uint16_t *len_unused)
> +{
> +    updated_dc_extent_list_in_pl *in = (void *)cmd->payload;
> +    struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev,
> +            cxl_dstate);
> +    CXLDCDExtentList *extent_list = &ct3d->dc.extents;
> +    CXLDCD_Extent *ent;
> +    uint32_t i;
> +    uint64_t dpa, len;
> +    CXLRetCode ret;
> +
> +    if (in->num_entries_updated == 0) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    ret = detect_malformed_extent_list(ct3d, in);
> +    if (ret != CXL_MBOX_SUCCESS) {
> +        return ret;
> +    }
> +
> +    for (i = 0; i < in->num_entries_updated; i++) {
> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        QTAILQ_FOREACH(ent, extent_list, node) {
> +            if (ent->start_dpa == dpa && ent->len == len) {
> +                break;
> +            } else if (ent->start_dpa < dpa
<=  We want to do the partial but at start case.
Please check my logic on this! I'll test it later, but for now I've
made the change.

We shuould just let this code run even in the exact match case
as len1 == len2 == 0 and math is cehap.


> +                    && dpa + len <= ent->start_dpa + ent->len) {

Not commented on it though I've tidied this up in other places...
Local style is to have the boolean operator on the end of the line before
not the start of the next one.

> +                /* remove partial extent */
> +                uint64_t len1 = dpa - ent->start_dpa;
> +                uint64_t len2 = ent->start_dpa + ent->len - dpa - len;
> +
> +                if (len1) {
> +                    insert_extent_to_extent_list(extent_list, ent->start_dpa,
> +                            len1, NULL, 0);
> +                }
> +                if (len2) {
> +                    insert_extent_to_extent_list(extent_list, dpa + len, len2,
> +                            NULL, 0);
> +                }
> +                break;
> +            } else if ((dpa < ent->start_dpa + ent->len
> +                        && dpa + len > ent->start_dpa + ent->len)
> +                    || (dpa < ent->start_dpa && dpa + len > ent->start_dpa))

This is rejecting attempt to remove a superset. Fair enough but does this code
fuse neighbouring extents? Left for now.


> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        if (ent) {
> +            QTAILQ_REMOVE(extent_list, ent, node);
> +            g_free(ent);
> +        } else {
> +            /* Try to remove a non-existing extent */
> +            return CXL_MBOX_INVALID_PA;
> +        }
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> + 
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -1129,6 +1376,12 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>      [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
>          "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
>          8, 0 },
> +    [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
> +        "ADD_DCD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
> +        ~0, IMMEDIATE_DATA_CHANGE },
> +    [DCD_CONFIG][RELEASE_DYN_CAP] = {
> +        "RELEASE_DCD_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
> +        ~0, IMMEDIATE_DATA_CHANGE },
>  };
>  
>  static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 3a338b3b37..01a5eaca48 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -130,7 +130,8 @@ typedef enum {
>      CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
>      CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
>      CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
> -    CXL_MBOX_MAX = 0x17
> +    CXL_MBOX_INVALID_EXTENT_LIST = 0x1E, /* cxl r3.0: Table 8-34*/
> +    CXL_MBOX_MAX = 0x1F
>  } CXLRetCode;
>  
>  struct cxl_cmd;

