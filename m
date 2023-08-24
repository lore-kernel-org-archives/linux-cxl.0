Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536D1C7113B
	for <linux-cxl@archiver.kernel.org>; Thu, 24 Aug 2023 20:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243595AbjHXUvK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243605AbjHXUuz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 24 Aug 2023 16:50:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AEE1989
        for <linux-cxl@vger.kernel.org>; Thu, 24 Aug 2023 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1692910154; x=1693514954; i=fan.ni@gmx.us;
 bh=cojvJ9Sk6Ei6IcvAfsXiEAhgupuX7yHbHAR5oyAk7YM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=sLNe/uVSq5lQyagkSc6tJa0AcMFL+DwnDwRfDoP0SCFQ5LPaP1zmbRJLfuFJJTxDjFwmQNE
 K7fbDmvjn27u5A9mFMcbiV+9HL4KXpNec+BOGRZjVXe5juTcrN+6roNPtutJOXZFm20V8E1Zn
 l/7VkwbxH1zuDY582XBv+48iFE7L7751ffOwVsUHprfcu24k2bE63wrSrHJ1h41US2KBuQ9FC
 D86338VWJfPTatKLf+Ym1hv4AV8la6cL3UoKwkxnZBv5lvaty7Jjc0jEGKovfNzb3g8ZjVWZg
 SGt+0IVLXXHywwm5vGLP6pImtaGi2IMFa4HRp/C3v63QFywvYHlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([99.13.228.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mel7v-1pyZbQ48hR-00anqO; Thu, 24
 Aug 2023 22:49:14 +0200
Date:   Thu, 24 Aug 2023 13:49:00 -0700
From:   Fan Ni <fan.ni@gmx.us>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
Message-ID: <ZOfCPADXcYMGIGC4@debian>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183957uscas1p2ca5293c7229ab989ad1a2d95395436a6@uscas1p2.samsung.com>
 <20230725183939.2741025-10-fan.ni@samsung.com>
 <20230807095342.00006f88@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807095342.00006f88@Huawei.com>
X-Provags-ID: V03:K1:3Z+LimPkf0jWtknBKvIuplqjYkTd/DAekeLJBu8RUW4sWIdP6UU
 ok8XjJr/tbUyJGLBKipJTgH0QgGEYf09yFVSQZM6hvGwjzPOf3eioDpWNAEAenK/3U7Tx4v
 6rgKsfAr3OxsQjx1R/gBKUjrTocA7+N5de9ZUs7piHtZMewB7DpiSnU1YzzCMFeuel+pUF0
 ez4cZmJ4ppjf0oW8Xx1GQ==
UI-OutboundReport: notjunk:1;M01:P0:aT6Nt0nTZOs=;ATfsrix915RjtRhcu21F2G6xnlQ
 vCWRcjxt7gqeaMyh1cKzuaHJjmt3BxMy6/txLAZ0vFDXxcBLT4Oh9cwoKP2fm/hqd1yFIlpus
 kDn08rwURtQIOi3ivSJJmuMEvYMLuxjFV5VNs8WFvHuxdmIuNID6HhkyX9OBF2sRyAfpsMK7X
 coTdE3kS5VFrZRpTzbrLDZNZqQ3fEKUSAln/gWbHhKtX8Rhn+wjSPc7mE0IR/yh8p9IXOaxCZ
 hkLQUfRt1rE0oX+yfqvBlsh0RI753MVLqGn72C5B7Cdxa/WfbdeToPx4QQ1VyoOkVIOOAtaG5
 GE2GgPGoyrPWUtY143kLQFqdb69iliB84pWpWjghOMNbwfBoXK71eXpyBOm4WDZLqufuEk2ww
 Hlz0QBOSbLO1vv84n+P7u3ACN1JefHxW0l66z40tm7mkO41FoHYLXWqffJhOhQd5rpVzJuxM0
 CpCYi9VVJjCGxheWgFl29Jy4fHFVhYoU1IxVPxOkD+dGuAHTK3j2FjGWoLEUCfWNFPtRkrYna
 GLmmJRL8juCyBIKbyyN0BNYTssIOC1hmvgMpLj+lK3065TKQc62C1epUxycDs6/d7B4CD/woG
 qBvHX3MkkRCUSn8zeUSHd3hW3Yx6Q7gZmDlSO2TG1NmO6mN2uBf4oucQY6rWBlky+vw6Epcbm
 PSMzjNfm+gGVlyvtrAaVFYlNuaYtbtWn9mKuSDtxjTOKdWcSdUOA24TwCZqbypPVWh0pU9w38
 k7xY2/VtM1IVnoi00iS0T4OGh0zBkL6P6rMSsXBzCTQ4tI+wkqbxfoPRnUJzrMcELxL4uCzjd
 cAe054+fceZJyhzznd8ekHxzu1kGTx2tMwdL1jKXVRujWa4tnJZouAYYA6cUK2oFL7/gPLsDV
 l10PPZTOI4NOAqq5ZPZjO2FYgeeWWSsyIMO7mI+E+ZEfwzEDv2PmFj49c7MLJINd8IzW8kyY4
 rBxeNbtiqntR3IIi1jqeh8JcXLU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Aug 07, 2023 at 09:53:42AM +0100, Jonathan Cameron wrote:
> On Tue, 25 Jul 2023 18:39:56 +0000
> Fan Ni <fan.ni@samsung.com> wrote:
>
> > From: Fan Ni <nifan@outlook.com>
> >
> > Not all dpa range in the dc regions is valid to access until an extent
> > covering the range has been added. Add a bitmap for each region to
> > record whether a dc block in the region has been backed by dc extent.
> > For the bitmap, a bit in the bitmap represents a dc block. When a dc
> > extent is added, all the bits of the blocks in the extent will be set,
> > which will be cleared when the extent is released.
> >
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> Hi Fan,
>
> A few of the bits of feedback apply broadly across the series.  Given I'=
m
> rebasing this anyway to give myself something to test I'll tidy things u=
p
> (feel free to disagree with and revert any changes !)
> and push a tree out in next day or two.  I'll message when I've done so.
>
> Jonathan

Hi Jonathan,
I tried DCD with your branch "cxl-2023-08-07", and noticed the
following,
1. You made some changes to the bitmap functionality, now it is only
used to validate extents when adding/releasing dc extents. My original
thought of adding the bitmap is to 1) validating extents for extent
add/release as you do; 2) Add validating when doing read/write to the dc
regions since some address region may not have valid extent added yet.
Do you think 2) is not necessary?

2. Your change introduced a bug in the code.
https://gitlab.com/jic23/qemu/-/blob/cxl-2023-08-07/hw/cxl/cxl-mailbox-uti=
ls.c?ref_type=3Dheads#L1394
ct3d->dc.num_regions should be ct3d->dc.num_regions-1.

Thanks,
Fan

>
> > ---
> >  hw/mem/cxl_type3.c          | 155 +++++++++++++++++++++++++++++++++++=
+
> >  include/hw/cxl/cxl_device.h |   1 +
> >  2 files changed, 156 insertions(+)
> >
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 41a828598a..51943a36fc 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -787,13 +787,37 @@ static int cxl_create_dc_regions(CXLType3Dev *ct=
3d)
> >          /* dsmad_handle is set when creating cdat table entries */
> >          region->flags =3D 0;
> >
> > +        region->blk_bitmap =3D bitmap_new(region->len / region->block=
_size);
>
> In common with many allocators in qemu if this fails it calls abort()
> internally so no need to handle potential errors.
>
> > +        if (!region->blk_bitmap) {
> > +            break;
> > +        }
> > +
> >          region_base +=3D region->len;
> >      }
> > +
> > +    if (i < ct3d->dc.num_regions) {
> > +        while (--i >=3D 0) {
> > +            g_free(ct3d->dc.regions[i].blk_bitmap);
> > +        }
> > +        return -1;
> > +    }
> > +
> >      QTAILQ_INIT(&ct3d->dc.extents);
> >
> >      return 0;
> >  }
> >
> > +static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
> > +{
> > +    int i;
> > +    struct CXLDCD_Region *region;
> > +
> > +    for (i =3D 0; i < ct3d->dc.num_regions; i++) {
> > +        region =3D &ct3d->dc.regions[i];
> > +        g_free(region->blk_bitmap);
> > +    }
> > +}
> > +
> >  static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >  {
> >      DeviceState *ds =3D DEVICE(ct3d);
> > @@ -1021,6 +1045,7 @@ err_free_special_ops:
> >      g_free(regs->special_ops);
> >  err_address_space_free:
> >      if (ct3d->dc.host_dc) {
> > +        cxl_destroy_dc_regions(ct3d);
> >          address_space_destroy(&ct3d->dc.host_dc_as);
> >      }
> >      if (ct3d->hostpmem) {
> > @@ -1043,6 +1068,7 @@ static void ct3_exit(PCIDevice *pci_dev)
> >      spdm_sock_fini(ct3d->doe_spdm.socket);
> >      g_free(regs->special_ops);
> >      if (ct3d->dc.host_dc) {
> > +        cxl_destroy_dc_regions(ct3d);
> >          address_space_destroy(&ct3d->dc.host_dc_as);
> >      }
> >      if (ct3d->hostpmem) {
> > @@ -1053,6 +1079,110 @@ static void ct3_exit(PCIDevice *pci_dev)
> >      }
> >  }
> >
> > +/*
> > + * This function will marked the dpa range [dpa, dap + len) to be bac=
ked and
> > + * accessible, this happens when a dc extent is added and accepted by=
 the
> > + * host.
> > + */
> > +static void set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> > +        uint64_t len)
> > +{
> > +    int i;
> > +    CXLDCD_Region *region =3D &ct3d->dc.regions[0];
> > +
> > +    if (dpa < region->base
> > +            || dpa >=3D region->base + ct3d->dc.total_capacity)
> > +        return;
> > +
> > +    /*
> > +     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, wit=
h
> > +     * Region 0 being used for the lowest DPA of Dynamic Capacity and
> > +     * Region 7 for the highest DPA.
> > +     * So we check from the last region to find where the dpa belongs=
.
> > +     * access across multiple regions is not allowed.
> > +     **/
> > +    for (i =3D ct3d->dc.num_regions - 1; i >=3D 0; i--) {
> > +        region =3D &ct3d->dc.regions[i];
> > +        if (dpa >=3D region->base) {
> > +            break;
> > +        }
> > +    }
> > +
> > +    bitmap_set(region->blk_bitmap, (dpa - region->base) / region->blo=
ck_size,
> > +            len / region->block_size);
> > +}
> > +
> > +/*
> > + * This function check whether a dpa range [dpa, dpa + len) has been =
backed
> > + * with dc extents, used when validating read/write to dc regions
> > + */
> > +static bool test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> > +        uint64_t len)
> > +{
> > +    int i;
> > +    CXLDCD_Region *region =3D &ct3d->dc.regions[0];
> > +    uint64_t nbits;
> > +    long nr;
> > +
> > +    if (dpa < region->base
> > +            || dpa >=3D region->base + ct3d->dc.total_capacity)
> > +        return false;
> > +
> > +    /*
> > +     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, wit=
h
> > +     * Region 0 being used for the lowest DPA of Dynamic Capacity and
> > +     * Region 7 for the highest DPA.
> > +     * So we check from the last region to find where the dpa belongs=
.
> > +     * access across multiple regions is not allowed.
> > +     */
> > +    for (i =3D ct3d->dc.num_regions - 1; i >=3D 0; i--) {
> > +        region =3D &ct3d->dc.regions[i];
> > +        if (dpa >=3D region->base) {
> > +            break;
> > +        }
> > +    }
> > +
> > +    nr =3D (dpa - region->base) / region->block_size;
> > +    nbits =3D len / region->block_size;
> > +    return find_next_zero_bit(region->blk_bitmap, nbits, nr) >=3D nr =
+ nbits;
> > +}
> > +
> > +/*
> > + * This function will marked the dpa range [dpa, dap + len) to be unb=
acked and
> > + * inaccessible, this happens when a dc extent is added and accepted =
by the
> > + * host.
> > + */
> > +static void clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa=
,
> > +        uint64_t len)
> > +{
> > +    int i;
> > +    CXLDCD_Region *region =3D &ct3d->dc.regions[0];
> > +    uint64_t nbits;
> > +    long nr;
> > +
> > +    if (dpa < region->base
> > +            || dpa >=3D region->base + ct3d->dc.total_capacity)
> > +        return;
> > +
> > +    /*
> > +     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, wit=
h
> > +     * Region 0 being used for the lowest DPA of Dynamic Capacity and
> > +     * Region 7 for the highest DPA.
> > +     * So we check from the last region to find where the dpa belongs=
.
> > +     * access across multiple regions is not allowed.
> > +     */
> > +    for (i =3D ct3d->dc.num_regions - 1; i >=3D 0; i--) {
> > +        region =3D &ct3d->dc.regions[i];
> > +        if (dpa >=3D region->base) {
> > +            break;
> > +        }
> > +    }
> > +
> > +    nr =3D (dpa - region->base) / region->block_size;
> > +    nbits =3D len / region->block_size;
> > +    bitmap_clear(region->blk_bitmap, nr, nbits);
> > +}
> > +
> >  static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64=
_t *dpa)
> >  {
> >      uint32_t *cache_mem =3D ct3d->cxl_cstate.crb.cache_mem_registers;
> > @@ -1145,6 +1275,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3=
Dev *ct3d,
> >          *as =3D &ct3d->hostpmem_as;
> >          *dpa_offset -=3D vmr_size;
> >      } else {
> > +        if (!test_region_block_backed(ct3d, *dpa_offset, size)) {
> > +            return -ENODEV;
> > +        }
> > +
> >          *as =3D &ct3d->dc.host_dc_as;
> >          *dpa_offset -=3D (vmr_size + pmr_size);
> >      }
> > @@ -1944,6 +2078,27 @@ static void qmp_cxl_process_dynamic_capacity_ev=
ent(const char *path,
> >      }
> >
> >      g_free(extents);
> > +
> > +    /* Another choice is to do the set/clear after getting mailbox re=
sponse*/
> > +    list =3D records;
> > +    while (list) {
> > +        dpa =3D list->value->dpa * 1024 * 1024;
> > +        len =3D list->value->len * 1024 * 1024;
> > +        rid =3D list->value->region_id;
> > +
> > +        switch (type) {
> > +        case DC_EVENT_ADD_CAPACITY:
> > +            set_region_block_backed(dcd, dpa, len);
> > +            break;
> > +        case DC_EVENT_RELEASE_CAPACITY:
> > +            clear_region_block_backed(dcd, dpa, len);
> > +            break;
> > +        default:
> > +            error_setg(errp, "DC event type not handled yet");
> > +            break;
> > +        }
> > +        list =3D list->next;
> > +    }
> >  }
> >
> >  void qmp_cxl_add_dynamic_capacity_event(const char *path,
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 01a5eaca48..1f85c88017 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -412,6 +412,7 @@ typedef struct CXLDCD_Region {
> >      uint64_t block_size;
> >      uint32_t dsmadhandle;
> >      uint8_t flags;
> > +    unsigned long *blk_bitmap;
> >  } CXLDCD_Region;
> >
> >  struct CXLType3Dev {
>
