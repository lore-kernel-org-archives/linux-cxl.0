Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC4EC001B0
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Aug 2023 08:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjHGIyS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Aug 2023 04:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjHGIxt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Aug 2023 04:53:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD4710FD
        for <linux-cxl@vger.kernel.org>; Mon,  7 Aug 2023 01:53:46 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RK94d2TMfz67sgR;
        Mon,  7 Aug 2023 16:50:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 09:53:43 +0100
Date:   Mon, 7 Aug 2023 09:53:42 +0100
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
Subject: Re: [Qemu PATCH v2 9/9] hw/mem/cxl_type3: Add dpa range validation
 for accesses to dc regions
Message-ID: <20230807095342.00006f88@Huawei.com>
In-Reply-To: <20230725183939.2741025-10-fan.ni@samsung.com>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
        <CGME20230725183957uscas1p2ca5293c7229ab989ad1a2d95395436a6@uscas1p2.samsung.com>
        <20230725183939.2741025-10-fan.ni@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 25 Jul 2023 18:39:56 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> From: Fan Ni <nifan@outlook.com>
> 
> Not all dpa range in the dc regions is valid to access until an extent
> covering the range has been added. Add a bitmap for each region to
> record whether a dc block in the region has been backed by dc extent.
> For the bitmap, a bit in the bitmap represents a dc block. When a dc
> extent is added, all the bits of the blocks in the extent will be set,
> which will be cleared when the extent is released.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Hi Fan,

A few of the bits of feedback apply broadly across the series.  Given I'm
rebasing this anyway to give myself something to test I'll tidy things up
(feel free to disagree with and revert any changes !) 
and push a tree out in next day or two.  I'll message when I've done so.

Jonathan

> ---
>  hw/mem/cxl_type3.c          | 155 ++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |   1 +
>  2 files changed, 156 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 41a828598a..51943a36fc 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -787,13 +787,37 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
>          /* dsmad_handle is set when creating cdat table entries */
>          region->flags = 0;
>  
> +        region->blk_bitmap = bitmap_new(region->len / region->block_size);

In common with many allocators in qemu if this fails it calls abort()
internally so no need to handle potential errors.

> +        if (!region->blk_bitmap) {
> +            break;
> +        }
> +
>          region_base += region->len;
>      }
> +
> +    if (i < ct3d->dc.num_regions) {
> +        while (--i >= 0) {
> +            g_free(ct3d->dc.regions[i].blk_bitmap);
> +        }
> +        return -1;
> +    }
> +
>      QTAILQ_INIT(&ct3d->dc.extents);
>  
>      return 0;
>  }
>  
> +static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
> +{
> +    int i;
> +    struct CXLDCD_Region *region;
> +
> +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> +        region = &ct3d->dc.regions[i];
> +        g_free(region->blk_bitmap);
> +    }
> +}
> +
>  static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>  {
>      DeviceState *ds = DEVICE(ct3d);
> @@ -1021,6 +1045,7 @@ err_free_special_ops:
>      g_free(regs->special_ops);
>  err_address_space_free:
>      if (ct3d->dc.host_dc) {
> +        cxl_destroy_dc_regions(ct3d);
>          address_space_destroy(&ct3d->dc.host_dc_as);
>      }
>      if (ct3d->hostpmem) {
> @@ -1043,6 +1068,7 @@ static void ct3_exit(PCIDevice *pci_dev)
>      spdm_sock_fini(ct3d->doe_spdm.socket);
>      g_free(regs->special_ops);
>      if (ct3d->dc.host_dc) {
> +        cxl_destroy_dc_regions(ct3d);
>          address_space_destroy(&ct3d->dc.host_dc_as);
>      }
>      if (ct3d->hostpmem) {
> @@ -1053,6 +1079,110 @@ static void ct3_exit(PCIDevice *pci_dev)
>      }
>  }
>  
> +/*
> + * This function will marked the dpa range [dpa, dap + len) to be backed and
> + * accessible, this happens when a dc extent is added and accepted by the
> + * host.
> + */
> +static void set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> +        uint64_t len)
> +{
> +    int i;
> +    CXLDCD_Region *region = &ct3d->dc.regions[0];
> +
> +    if (dpa < region->base
> +            || dpa >= region->base + ct3d->dc.total_capacity)
> +        return;
> +
> +    /*
> +     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
> +     * Region 0 being used for the lowest DPA of Dynamic Capacity and
> +     * Region 7 for the highest DPA.
> +     * So we check from the last region to find where the dpa belongs.
> +     * access across multiple regions is not allowed.
> +     **/
> +    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
> +        region = &ct3d->dc.regions[i];
> +        if (dpa >= region->base) {
> +            break;
> +        }
> +    }
> +
> +    bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_size,
> +            len / region->block_size);
> +}
> +
> +/*
> + * This function check whether a dpa range [dpa, dpa + len) has been backed
> + * with dc extents, used when validating read/write to dc regions
> + */
> +static bool test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> +        uint64_t len)
> +{
> +    int i;
> +    CXLDCD_Region *region = &ct3d->dc.regions[0];
> +    uint64_t nbits;
> +    long nr;
> +
> +    if (dpa < region->base
> +            || dpa >= region->base + ct3d->dc.total_capacity)
> +        return false;
> +
> +    /*
> +     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
> +     * Region 0 being used for the lowest DPA of Dynamic Capacity and
> +     * Region 7 for the highest DPA.
> +     * So we check from the last region to find where the dpa belongs.
> +     * access across multiple regions is not allowed.
> +     */
> +    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
> +        region = &ct3d->dc.regions[i];
> +        if (dpa >= region->base) {
> +            break;
> +        }
> +    }
> +
> +    nr = (dpa - region->base) / region->block_size;
> +    nbits = len / region->block_size;
> +    return find_next_zero_bit(region->blk_bitmap, nbits, nr) >= nr + nbits;
> +}
> +
> +/*
> + * This function will marked the dpa range [dpa, dap + len) to be unbacked and
> + * inaccessible, this happens when a dc extent is added and accepted by the
> + * host.
> + */
> +static void clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> +        uint64_t len)
> +{
> +    int i;
> +    CXLDCD_Region *region = &ct3d->dc.regions[0];
> +    uint64_t nbits;
> +    long nr;
> +
> +    if (dpa < region->base
> +            || dpa >= region->base + ct3d->dc.total_capacity)
> +        return;
> +
> +    /*
> +     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
> +     * Region 0 being used for the lowest DPA of Dynamic Capacity and
> +     * Region 7 for the highest DPA.
> +     * So we check from the last region to find where the dpa belongs.
> +     * access across multiple regions is not allowed.
> +     */
> +    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
> +        region = &ct3d->dc.regions[i];
> +        if (dpa >= region->base) {
> +            break;
> +        }
> +    }
> +
> +    nr = (dpa - region->base) / region->block_size;
> +    nbits = len / region->block_size;
> +    bitmap_clear(region->blk_bitmap, nr, nbits);
> +}
> +
>  static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
>  {
>      uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
> @@ -1145,6 +1275,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
>          *as = &ct3d->hostpmem_as;
>          *dpa_offset -= vmr_size;
>      } else {
> +        if (!test_region_block_backed(ct3d, *dpa_offset, size)) {
> +            return -ENODEV;
> +        }
> +
>          *as = &ct3d->dc.host_dc_as;
>          *dpa_offset -= (vmr_size + pmr_size);
>      }
> @@ -1944,6 +2078,27 @@ static void qmp_cxl_process_dynamic_capacity_event(const char *path,
>      }
>  
>      g_free(extents);
> +
> +    /* Another choice is to do the set/clear after getting mailbox response*/
> +    list = records;
> +    while (list) {
> +        dpa = list->value->dpa * 1024 * 1024;
> +        len = list->value->len * 1024 * 1024;
> +        rid = list->value->region_id;
> +
> +        switch (type) {
> +        case DC_EVENT_ADD_CAPACITY:
> +            set_region_block_backed(dcd, dpa, len);
> +            break;
> +        case DC_EVENT_RELEASE_CAPACITY:
> +            clear_region_block_backed(dcd, dpa, len);
> +            break;
> +        default:
> +            error_setg(errp, "DC event type not handled yet");
> +            break;
> +        }
> +        list = list->next;
> +    }
>  }
>  
>  void qmp_cxl_add_dynamic_capacity_event(const char *path,
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 01a5eaca48..1f85c88017 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -412,6 +412,7 @@ typedef struct CXLDCD_Region {
>      uint64_t block_size;
>      uint32_t dsmadhandle;
>      uint8_t flags;
> +    unsigned long *blk_bitmap;
>  } CXLDCD_Region;
>  
>  struct CXLType3Dev {

