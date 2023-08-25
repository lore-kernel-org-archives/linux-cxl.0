Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DC3C3DA66
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Aug 2023 16:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344023AbjHYQhT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Aug 2023 12:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344014AbjHYQgq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Aug 2023 12:36:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C05F1991
        for <linux-cxl@vger.kernel.org>; Fri, 25 Aug 2023 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1692981310; x=1693586110; i=fan.ni@gmx.us;
 bh=833F+CkwYAofFw4YYRSOBwzeI6Gm3qodAYkD5TIPTro=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=N2Ejh1IKRhZm0wEgEdi2gciYsXJ8gf/y6vARShoMJusv30ImmqBhWqy5z/sqXOGIjGyqj2v
 2VNG8vrXlmLq5qjxQAW+mavJsw7c8rjBRV6vrbSv1/MOyO+ezimydoU1jKmWCjgLmJGtLmktT
 lb8dJRv/zxnYnmSQn7CoaicfFQAZvSirioe0Uf0aA8jJBzsiNPiSHpduqYb7xDUP1HZS2N6XK
 RE72KrfrgNeB3CzguM4RMueKbe4iDcxzUilQ2V5Knq3dKmuvI0AtFJ93PVIJWqe6keFjxb/bT
 iJo9EaoRJnCNo5KUg7NUOLZCIQLi+ePue38B2kkaQ2USrZIaQb2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([99.13.228.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryXN-1pxEs43TDp-00o1Gb; Fri, 25
 Aug 2023 18:35:10 +0200
Date:   Fri, 25 Aug 2023 09:34:50 -0700
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
Message-ID: <ZOjYKq+vDMIdFEl7@debian>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183957uscas1p2ca5293c7229ab989ad1a2d95395436a6@uscas1p2.samsung.com>
 <20230725183939.2741025-10-fan.ni@samsung.com>
 <20230807095342.00006f88@Huawei.com>
 <ZOfCPADXcYMGIGC4@debian>
 <20230825124256.0000604c@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825124256.0000604c@Huawei.com>
X-Provags-ID: V03:K1:GUwe59V/6OuK2RkHi4d6cpt1mbnbiLUJkSPN6EjN7+Zf+Puree/
 Du1nP7apcZg+7jI+yqee+Cs8hs5MySxYyvwunU0URTsmf/URvDPkpz4tss8JojXaEc2ucjc
 oV4EeUIZgXiUQMqE2ebvJE1wI9LHVJ1xcIiyg7GQ3syDsX80viowNySij36Mf57pLmHO2f7
 j2i+SbZ3JSjNZLcC+zbmQ==
UI-OutboundReport: notjunk:1;M01:P0:cHA8VV+7+bk=;yzpiO6uS5yusvVMFckfTxHWHGV/
 UXvrugLHR2+zuQsLx/alNDI99neV2mtr02JBXnaA/O9i15PmOJIUjXhLCL5Le5tA9kr9ybkq0
 pyrkTsHj679cq0izl448Pe9uX9nmsmJEcGSujyyF9ZJNhDDBeq63eO/iyQDl9CHzGij/8XetI
 LuEj7SzAjIGkppOVsp06Xv481evzJZR8ttgbGcI2cMlboerE67GcPkZlGnGrRHhs+XGijmr3K
 +yfKTv+a/gEibZFHt5+g/FPexpPzsQV8MKjy4s3CzZEy2LGeaOROtWQIUfM08WN5HlJf9YYRP
 Rux/3xK/uDS6eA5V7HnuLmgjMm+HLufQPfB2sgjyt7w1xS0vx0KDgendMHV745gGFbm5luGTo
 B30WZCHQhVpqlk/3gb+5iL1YU3/EC3BNx46JssEEcim0+ZlQvTe9oeG/h+x3njmYFVWdZGcU8
 uKpF85S9gYC+mVqBVFud+txDfGYXO9d97p+I2u7HpoJlXLd/UkRs+stkpP6WZ95zjCvu+E6CU
 6LS+xCCgKYt5/sW+oQNh8qXyY+t9oJp4jVSQ1ApsO3cMILe8cfwR8NhsUVphiIDSNTcsOmuzA
 UFWCB58NypB31dHl/Ut6hhRmI8ClSWYTeCc2u8DrvZ4FMkZVb5Swp400Cnug6VVJU4gLGuPwK
 qF1fmoXQFlJKUJX64NmqG8MjFa58pNtcntf0WGumcZg/NHkO6Y7+Ebdt759FWuIECOEGPIKpl
 8/YE4g8twKyTQaUo1BEQNuQhy2YfCKlYflBrMkX0IiNj0yC53c/lkYZzhJ+fervKb++nUuaDP
 tID0Hu834f0b7kaDZ7alhv+5/khBsT7AP4h7dRB3kF9dF7vg2wWf/49y71HeWsA/HEES8Wu6v
 yr/P2+EjAGlSrGdMxvEeo8xPqVAz7UhiSiFe3xXJbYiges9duvw5fMsmkTRaoOSA614XVc3nH
 2Km/rBL+Ggw3U3uzIdo3mPYXS+Q=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Aug 25, 2023 at 12:42:56PM +0100, Jonathan Cameron wrote:
> On Thu, 24 Aug 2023 13:49:00 -0700
> Fan Ni <fan.ni@gmx.us> wrote:
>
> > On Mon, Aug 07, 2023 at 09:53:42AM +0100, Jonathan Cameron wrote:
> > > On Tue, 25 Jul 2023 18:39:56 +0000
> > > Fan Ni <fan.ni@samsung.com> wrote:
> > >
> > > > From: Fan Ni <nifan@outlook.com>
> > > >
> > > > Not all dpa range in the dc regions is valid to access until an ex=
tent
> > > > covering the range has been added. Add a bitmap for each region to
> > > > record whether a dc block in the region has been backed by dc exte=
nt.
> > > > For the bitmap, a bit in the bitmap represents a dc block. When a =
dc
> > > > extent is added, all the bits of the blocks in the extent will be =
set,
> > > > which will be cleared when the extent is released.
> > > >
> > > > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > > Hi Fan,
> > >
> > > A few of the bits of feedback apply broadly across the series.  Give=
n I'm
> > > rebasing this anyway to give myself something to test I'll tidy thin=
gs up
> > > (feel free to disagree with and revert any changes !)
> > > and push a tree out in next day or two.  I'll message when I've done=
 so.
> > >
> > > Jonathan
> >
> > Hi Jonathan,
> > I tried DCD with your branch "cxl-2023-08-07", and noticed the
> > following,
> > 1. You made some changes to the bitmap functionality, now it is only
> > used to validate extents when adding/releasing dc extents. My original
> > thought of adding the bitmap is to 1) validating extents for extent
> > add/release as you do; 2) Add validating when doing read/write to the =
dc
> > regions since some address region may not have valid extent added yet.
> > Do you think 2) is not necessary?
>
> Change wasn't intentional. I probably just messed up the rebase!

Just double checked the code. The logic is still there, but in another
patch in the series, so no issue and ignore my previous question.
Sorry for the confusion.

>
> >
> > 2. Your change introduced a bug in the code.
> > https://gitlab.com/jic23/qemu/-/blob/cxl-2023-08-07/hw/cxl/cxl-mailbox=
-utils.c?ref_type=3Dheads#L1394
> > ct3d->dc.num_regions should be ct3d->dc.num_regions-1.
> Thanks.  Given I might forget about about it, if you want to incorporate=
 that in
> your next version that would be great. I might remember to fix it in the=
 meantime!
>
> Jonathan
>

My code does not have this. It seems you added the lastregion variable
to record the last region, while I use the following logic to iterate
the regions and record last region automatically while collecting
min_block_size.

+    for (i =3D 1; i < dev->dc.num_regions; i++) {
+        region =3D &dev->dc.regions[i];
+        if (min_block_size > region->block_size) {
+            min_block_size =3D region->block_size;
+        }
+    }
+
+    blk_bitmap =3D bitmap_new((region->len + region->base
+                - dev->dc.regions[0].base) / min_block_size);


Fan

> >
> > Thanks,
> > Fan
> >
> > >
> > > > ---
> > > >  hw/mem/cxl_type3.c          | 155 +++++++++++++++++++++++++++++++=
+++++
> > > >  include/hw/cxl/cxl_device.h |   1 +
> > > >  2 files changed, 156 insertions(+)
> > > >
> > > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > > index 41a828598a..51943a36fc 100644
> > > > --- a/hw/mem/cxl_type3.c
> > > > +++ b/hw/mem/cxl_type3.c
> > > > @@ -787,13 +787,37 @@ static int cxl_create_dc_regions(CXLType3Dev=
 *ct3d)
> > > >          /* dsmad_handle is set when creating cdat table entries *=
/
> > > >          region->flags =3D 0;
> > > >
> > > > +        region->blk_bitmap =3D bitmap_new(region->len / region->b=
lock_size);
> > >
> > > In common with many allocators in qemu if this fails it calls abort(=
)
> > > internally so no need to handle potential errors.
> > >
> > > > +        if (!region->blk_bitmap) {
> > > > +            break;
> > > > +        }
> > > > +
> > > >          region_base +=3D region->len;
> > > >      }
> > > > +
> > > > +    if (i < ct3d->dc.num_regions) {
> > > > +        while (--i >=3D 0) {
> > > > +            g_free(ct3d->dc.regions[i].blk_bitmap);
> > > > +        }
> > > > +        return -1;
> > > > +    }
> > > > +
> > > >      QTAILQ_INIT(&ct3d->dc.extents);
> > > >
> > > >      return 0;
> > > >  }
> > > >
> > > > +static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
> > > > +{
> > > > +    int i;
> > > > +    struct CXLDCD_Region *region;
> > > > +
> > > > +    for (i =3D 0; i < ct3d->dc.num_regions; i++) {
> > > > +        region =3D &ct3d->dc.regions[i];
> > > > +        g_free(region->blk_bitmap);
> > > > +    }
> > > > +}
> > > > +
> > > >  static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> > > >  {
> > > >      DeviceState *ds =3D DEVICE(ct3d);
> > > > @@ -1021,6 +1045,7 @@ err_free_special_ops:
> > > >      g_free(regs->special_ops);
> > > >  err_address_space_free:
> > > >      if (ct3d->dc.host_dc) {
> > > > +        cxl_destroy_dc_regions(ct3d);
> > > >          address_space_destroy(&ct3d->dc.host_dc_as);
> > > >      }
> > > >      if (ct3d->hostpmem) {
> > > > @@ -1043,6 +1068,7 @@ static void ct3_exit(PCIDevice *pci_dev)
> > > >      spdm_sock_fini(ct3d->doe_spdm.socket);
> > > >      g_free(regs->special_ops);
> > > >      if (ct3d->dc.host_dc) {
> > > > +        cxl_destroy_dc_regions(ct3d);
> > > >          address_space_destroy(&ct3d->dc.host_dc_as);
> > > >      }
> > > >      if (ct3d->hostpmem) {
> > > > @@ -1053,6 +1079,110 @@ static void ct3_exit(PCIDevice *pci_dev)
> > > >      }
> > > >  }
> > > >
> > > > +/*
> > > > + * This function will marked the dpa range [dpa, dap + len) to be=
 backed and
> > > > + * accessible, this happens when a dc extent is added and accepte=
d by the
> > > > + * host.
> > > > + */
> > > > +static void set_region_block_backed(CXLType3Dev *ct3d, uint64_t d=
pa,
> > > > +        uint64_t len)
> > > > +{
> > > > +    int i;
> > > > +    CXLDCD_Region *region =3D &ct3d->dc.regions[0];
> > > > +
> > > > +    if (dpa < region->base
> > > > +            || dpa >=3D region->base + ct3d->dc.total_capacity)
> > > > +        return;
> > > > +
> > > > +    /*
> > > > +     * spec 3.0 9.13.3: Regions are used in increasing-DPA order,=
 with
> > > > +     * Region 0 being used for the lowest DPA of Dynamic Capacity=
 and
> > > > +     * Region 7 for the highest DPA.
> > > > +     * So we check from the last region to find where the dpa bel=
ongs.
> > > > +     * access across multiple regions is not allowed.
> > > > +     **/
> > > > +    for (i =3D ct3d->dc.num_regions - 1; i >=3D 0; i--) {
> > > > +        region =3D &ct3d->dc.regions[i];
> > > > +        if (dpa >=3D region->base) {
> > > > +            break;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    bitmap_set(region->blk_bitmap, (dpa - region->base) / region-=
>block_size,
> > > > +            len / region->block_size);
> > > > +}
> > > > +
> > > > +/*
> > > > + * This function check whether a dpa range [dpa, dpa + len) has b=
een backed
> > > > + * with dc extents, used when validating read/write to dc regions
> > > > + */
> > > > +static bool test_region_block_backed(CXLType3Dev *ct3d, uint64_t =
dpa,
> > > > +        uint64_t len)
> > > > +{
> > > > +    int i;
> > > > +    CXLDCD_Region *region =3D &ct3d->dc.regions[0];
> > > > +    uint64_t nbits;
> > > > +    long nr;
> > > > +
> > > > +    if (dpa < region->base
> > > > +            || dpa >=3D region->base + ct3d->dc.total_capacity)
> > > > +        return false;
> > > > +
> > > > +    /*
> > > > +     * spec 3.0 9.13.3: Regions are used in increasing-DPA order,=
 with
> > > > +     * Region 0 being used for the lowest DPA of Dynamic Capacity=
 and
> > > > +     * Region 7 for the highest DPA.
> > > > +     * So we check from the last region to find where the dpa bel=
ongs.
> > > > +     * access across multiple regions is not allowed.
> > > > +     */
> > > > +    for (i =3D ct3d->dc.num_regions - 1; i >=3D 0; i--) {
> > > > +        region =3D &ct3d->dc.regions[i];
> > > > +        if (dpa >=3D region->base) {
> > > > +            break;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    nr =3D (dpa - region->base) / region->block_size;
> > > > +    nbits =3D len / region->block_size;
> > > > +    return find_next_zero_bit(region->blk_bitmap, nbits, nr) >=3D=
 nr + nbits;
> > > > +}
> > > > +
> > > > +/*
> > > > + * This function will marked the dpa range [dpa, dap + len) to be=
 unbacked and
> > > > + * inaccessible, this happens when a dc extent is added and accep=
ted by the
> > > > + * host.
> > > > + */
> > > > +static void clear_region_block_backed(CXLType3Dev *ct3d, uint64_t=
 dpa,
> > > > +        uint64_t len)
> > > > +{
> > > > +    int i;
> > > > +    CXLDCD_Region *region =3D &ct3d->dc.regions[0];
> > > > +    uint64_t nbits;
> > > > +    long nr;
> > > > +
> > > > +    if (dpa < region->base
> > > > +            || dpa >=3D region->base + ct3d->dc.total_capacity)
> > > > +        return;
> > > > +
> > > > +    /*
> > > > +     * spec 3.0 9.13.3: Regions are used in increasing-DPA order,=
 with
> > > > +     * Region 0 being used for the lowest DPA of Dynamic Capacity=
 and
> > > > +     * Region 7 for the highest DPA.
> > > > +     * So we check from the last region to find where the dpa bel=
ongs.
> > > > +     * access across multiple regions is not allowed.
> > > > +     */
> > > > +    for (i =3D ct3d->dc.num_regions - 1; i >=3D 0; i--) {
> > > > +        region =3D &ct3d->dc.regions[i];
> > > > +        if (dpa >=3D region->base) {
> > > > +            break;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    nr =3D (dpa - region->base) / region->block_size;
> > > > +    nbits =3D len / region->block_size;
> > > > +    bitmap_clear(region->blk_bitmap, nr, nbits);
> > > > +}
> > > > +
> > > >  static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, ui=
nt64_t *dpa)
> > > >  {
> > > >      uint32_t *cache_mem =3D ct3d->cxl_cstate.crb.cache_mem_regist=
ers;
> > > > @@ -1145,6 +1275,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLT=
ype3Dev *ct3d,
> > > >          *as =3D &ct3d->hostpmem_as;
> > > >          *dpa_offset -=3D vmr_size;
> > > >      } else {
> > > > +        if (!test_region_block_backed(ct3d, *dpa_offset, size)) {
> > > > +            return -ENODEV;
> > > > +        }
> > > > +
> > > >          *as =3D &ct3d->dc.host_dc_as;
> > > >          *dpa_offset -=3D (vmr_size + pmr_size);
> > > >      }
> > > > @@ -1944,6 +2078,27 @@ static void qmp_cxl_process_dynamic_capacit=
y_event(const char *path,
> > > >      }
> > > >
> > > >      g_free(extents);
> > > > +
> > > > +    /* Another choice is to do the set/clear after getting mailbo=
x response*/
> > > > +    list =3D records;
> > > > +    while (list) {
> > > > +        dpa =3D list->value->dpa * 1024 * 1024;
> > > > +        len =3D list->value->len * 1024 * 1024;
> > > > +        rid =3D list->value->region_id;
> > > > +
> > > > +        switch (type) {
> > > > +        case DC_EVENT_ADD_CAPACITY:
> > > > +            set_region_block_backed(dcd, dpa, len);
> > > > +            break;
> > > > +        case DC_EVENT_RELEASE_CAPACITY:
> > > > +            clear_region_block_backed(dcd, dpa, len);
> > > > +            break;
> > > > +        default:
> > > > +            error_setg(errp, "DC event type not handled yet");
> > > > +            break;
> > > > +        }
> > > > +        list =3D list->next;
> > > > +    }
> > > >  }
> > > >
> > > >  void qmp_cxl_add_dynamic_capacity_event(const char *path,
> > > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_devi=
ce.h
> > > > index 01a5eaca48..1f85c88017 100644
> > > > --- a/include/hw/cxl/cxl_device.h
> > > > +++ b/include/hw/cxl/cxl_device.h
> > > > @@ -412,6 +412,7 @@ typedef struct CXLDCD_Region {
> > > >      uint64_t block_size;
> > > >      uint32_t dsmadhandle;
> > > >      uint8_t flags;
> > > > +    unsigned long *blk_bitmap;
> > > >  } CXLDCD_Region;
> > > >
> > > >  struct CXLType3Dev {
> > >
>
