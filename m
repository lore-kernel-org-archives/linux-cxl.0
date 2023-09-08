Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEADEEB560
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Sep 2023 17:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjIHRVy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Sep 2023 13:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbjIHRVx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Sep 2023 13:21:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4AF1FC4
        for <linux-cxl@vger.kernel.org>; Fri,  8 Sep 2023 10:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1694193609; x=1694798409; i=fan.ni@gmx.us;
 bh=eTuAMCtxIep1hkQhE9WfgRxSJEMBNLNyy1WUCrC1IlY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UucjMoheG9kEHhtv7iyNw4nzNkbJ9koDQ+Y6Z/LmfyjRv4eFMZ9C27u7Hmw0xfLI2qhYusp
 0a4ZmhlNP/9sNyhj46UzD3N7uAk3IDpzO7qrC/NqGlF5g6+p3rShJN0gNMDHvKW2ug/tO27VZ
 +ZEbPq6EHaoPROMpXDuJr1w1gvMJJtUQU4zk69mOp/AMBHsExTCPoSGQLD0QOP67scAO0DSjO
 Ti8XuRv+WoWEzm8+78tY9btwHB4rn3tjW+59gCalf0agHb0Iijs2WJvp+tDC4u5qF25zp24S4
 mGAFwsCX+IfmGC8UgRbQBHZpxSPw7k92ATGoC7LB67w0nnAVjYYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([99.13.228.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbRfv-1q38PB2db7-00brwB; Fri, 08
 Sep 2023 19:20:09 +0200
Date:   Fri, 8 Sep 2023 10:19:55 -0700
From:   Fan Ni <fan.ni@gmx.us>
To:     J?rgen Hansen <Jorgen.Hansen@wdc.com>
Cc:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
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
Message-ID: <ZPtXuyJkFKgBpL9A@debian>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183957uscas1p2a076b6f7b694d2e632a0b8025ec331d7@uscas1p2.samsung.com>
 <20230725183939.2741025-8-fan.ni@samsung.com>
 <e1640028-6b9d-3cdf-52fb-241f985c4bbb@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1640028-6b9d-3cdf-52fb-241f985c4bbb@wdc.com>
X-Provags-ID: V03:K1:QOKSHZN38gt922xEcnREdH3Tslemuxy+b9ml1WlkVVpglkGkJqN
 OPacRVz8/gO+I0m1ozpn2VbTQkV5EwMh9+xrMFLdKxolorY+Wdvbvtb3fhZL0F6VmTuGF5Q
 zQHN28ur4vpp3a+E3QlGsLqerE3tpHpNORjDuT5DD2ALViwm2B3JvNBhIiJm2EGmgkXtQFL
 6vCI7t30MrkWwdviUNwFg==
UI-OutboundReport: notjunk:1;M01:P0:cQMkAvkz3fM=;x3zDOCgKmb3VZDXqVcZ8tuoSEkM
 M9HM4eT7Zdu2y+mljRzb64V/39LvZuXlU1AOoLPCtb9XOpjCdB/5yKc2FY6cmNlkOwcHg8cV2
 6WqSEIxzMJYPEfEP8madX72WuovzpvMh8CMlYc10mgpz7IjDu0qGE6Y9X4eRunNkOEVPU/tT+
 VCavPghGkHTnDqBFGGX29xboaa8MCqDPwFyPv96VCShpFHIzgv23+ue8pC3Lwr7mz67uP3vIJ
 fDqAF4r2Gae3ZrlUNa5/O6x2pt3jlT0YOvdrU+gSlNPyF+aQ+LvT2iDQFgVXQDVhy6fOM4NDV
 LGmkHvjzuR4mmrhu1Ss0Bp7NQFFUQBpNBGJ/6gQ4sCMRGPb+/qmez717p3AyW58ZUBDJGp8U/
 UTKf1v5OGsiyjN6dN51ntqLzpkqn0f4mRq5NXo3jlyR5WZ0keKkW7GYZKIXMH//2xCSxBd7su
 SjoeIGJh/w3kBTKpFzF8Le0HCf02/Kp42GtS3aJT6sVFzwrSi5uBgnHm2fbB0/McvXWaxJkgi
 +LtVtu90UAIctKpPXXRzP8eXvveThWYvN4iVevD9vYZjINXXRIObsBjSSuUVZ1OI+0fuX7psD
 8itWhby3I4bXk9NCuX34ExcA76TL2stpbeZy5GqExfBXLe0Fpo3Zl/t1/mmQymm1751YXw/zQ
 qTkx7q3j0qffvqrwcc8vatpByI1Q7Z1Vw79FSpIdrY7xYahtEySof1RmYZgynyVUNnLRbhuJn
 XzL4oBvWl03ziSBYusMlePPX+WJQ28frci64WEr3Vf56ShNMJP1ZbfwGc4qZ/7sANTu6d54MI
 YDHvh7MJqRd0qyp6mI8DiCJ3Y4ThlzsAjOgZyAX1DFoA8hFgnnxMdCwz2dkyH3AjMxGPtn/XX
 Lqz2U18isn0iK+ep9C4ZTCcDVHm7wUkq+FTfzLzqJWehngVwoIvZtOxsPTRGXXUdKiuxof5AZ
 F6kkwsIbSD98I2d2eFrYujMQK0g=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Sep 08, 2023 at 01:00:16PM +0000, J?rgen Hansen wrote:
> On 7/25/23 20:39, Fan Ni wrote:
> > From: Fan Ni <nifan@outlook.com>
> >
> > Per CXL spec 3.0, two mailbox commands are implemented:
> > Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.8.9.3, and
> > Release Dynamic Capacity (Opcode 4803h) 8.2.9.8.9.4.
> >
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c  | 253 ++++++++++++++++++++++++++++++++++=
++
> >   include/hw/cxl/cxl_device.h |   3 +-
> >   2 files changed, 255 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 3d25a9697e..1e4944da95 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -84,6 +84,8 @@ enum {
> >       DCD_CONFIG  =3D 0x48, /*r3.0: 8.2.9.8.9*/
> >           #define GET_DC_CONFIG          0x0
> >           #define GET_DYN_CAP_EXT_LIST   0x1
> > +        #define ADD_DYN_CAP_RSP        0x2
> > +        #define RELEASE_DYN_CAP        0x3
> >       PHYSICAL_SWITCH =3D 0x51
> >           #define IDENTIFY_SWITCH_DEVICE      0x0
> >   };
> > @@ -1086,6 +1088,251 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list=
(struct cxl_cmd *cmd,
> >       return CXL_MBOX_SUCCESS;
> >   }
> >
> > +/*
> > + * Check whether the bits at addr between [nr, nr+size) are all set,
> > + * return 1 if all 1s, else return 0
> > + */
> > +static inline int test_bits(const unsigned long *addr, int nr, int si=
ze)
> > +{
> > +    unsigned long res =3D find_next_zero_bit(addr, size + nr, nr);
> > +
> > +    return (res >=3D nr + size) ? 1 : 0;
> > +}
> > +
> > +/*
> > + * Find dynamic capacity region id based on dpa range [dpa, dpa+len)
> > + */
> > +static uint8_t find_region_id(struct CXLType3Dev *dev, uint64_t dpa,
> > +        uint64_t len)
> > +{
> > +    int8_t i =3D dev->dc.num_regions - 1;
> > +
> > +    while (i > 0 && dpa < dev->dc.regions[i].base) {
> > +        i--;
> > +    }
> > +
> > +    if (dpa < dev->dc.regions[i].base
> > +            || dpa + len > dev->dc.regions[i].base + dev->dc.regions[=
i].len) {
> > +        return dev->dc.num_regions;
> > +    }
> > +
> > +    return i;
> > +}
> > +
> > +static void insert_extent_to_extent_list(CXLDCDExtentList *list, uint=
64_t dpa,
> > +        uint64_t len, uint8_t *tag, uint16_t shared_seq)
> > +{
> > +    CXLDCD_Extent *extent;
> > +    extent =3D g_new0(CXLDCD_Extent, 1);
> > +    extent->start_dpa =3D dpa;
> > +    extent->len =3D len;
> > +    if (tag) {
> > +        memcpy(extent->tag, tag, 0x10);
> > +    } else {
> > +        memset(extent->tag, 0, 0x10);
> > +    }
> > +    extent->shared_seq =3D shared_seq;
> > +
> > +    QTAILQ_INSERT_TAIL(list, extent, node);
> > +}
> > +
> > +typedef struct updated_dc_extent_list_in_pl {
> > +    uint32_t num_entries_updated;
> > +    uint8_t rsvd[4];
> > +    struct { /* r3.0: Table 8-130 */
> > +        uint64_t start_dpa;
> > +        uint64_t len;
> > +        uint8_t rsvd[8];
> > +    } QEMU_PACKED updated_entries[];
> > +} QEMU_PACKED updated_dc_extent_list_in_pl;
> > +
> > +/*
> > + * The function only check the input extent list against itself.
> > + */
> > +static CXLRetCode detect_malformed_extent_list(CXLType3Dev *dev,
> > +        const updated_dc_extent_list_in_pl *in)
> > +{
> > +    unsigned long *blk_bitmap;
> > +    uint64_t min_block_size =3D dev->dc.regions[0].block_size;
> > +    struct CXLDCD_Region *region =3D &dev->dc.regions[0];
> > +    uint32_t i;
> > +    uint64_t dpa, len;
> > +    uint8_t rid;
> > +    CXLRetCode ret;
> > +
> > +    for (i =3D 1; i < dev->dc.num_regions; i++) {
> > +        region =3D &dev->dc.regions[i];
> > +        if (min_block_size > region->block_size) {
> > +            min_block_size =3D region->block_size;
> > +        }
> > +    }
> > +
> > +    blk_bitmap =3D bitmap_new((region->len + region->base
> > +                - dev->dc.regions[0].base) / min_block_size);
> > +
> > +    for (i =3D 0; i < in->num_entries_updated; i++) {
> > +        dpa =3D in->updated_entries[i].start_dpa;
> > +        len =3D in->updated_entries[i].len;
> > +
> > +        rid =3D find_region_id(dev, dpa, len);
> > +        if (rid =3D=3D dev->dc.num_regions) {
> > +            ret =3D CXL_MBOX_INVALID_PA;
> > +            goto out;
> > +        }
> > +
> > +        region =3D &dev->dc.regions[rid];
> > +        if (dpa % region->block_size || len % region->block_size) {
> > +            ret =3D CXL_MBOX_INVALID_EXTENT_LIST;
> > +            goto out;
> > +        }
>
> Hi,
>
> The bitmap uses the dc region 0 base address as the baseline, so when
> checking the dpa against the bitmap it needs to be adjusted for that
> before the bitmap checks, e.g.,
>
> +        dpa -=3D dev->dc.regions[0].base;
>
> Thanks,
> Jorgen

Make sense. Will fix. Thanks.

Fan
>
> > +        /* the dpa range already covered by some other extents in the=
 list */
> > +        if (test_bits(blk_bitmap, dpa / min_block_size, len / min_blo=
ck_size)) {
> > +            ret =3D CXL_MBOX_INVALID_EXTENT_LIST;
> > +            goto out;
> > +        }
> > +        bitmap_set(blk_bitmap, dpa / min_block_size, len / min_block_=
size);
> > +   }
> > +
> > +    ret =3D CXL_MBOX_SUCCESS;
> > +
> > +out:
> > +    g_free(blk_bitmap);
> > +    return ret;
> > +}
> > +
> > +/*
> > + * cxl spec 3.0: 8.2.9.8.9.3
> > + * Add Dynamic Capacity Response (opcode 4802h)
> > + * Assume an extent is added only after the response is processed suc=
cessfully
> > + * TODO: for better extent list validation, a better solution would b=
e
> > + * maintaining a pending extent list and use it to verify the extent =
list in
> > + * the response.
> > + */
> > +static CXLRetCode cmd_dcd_add_dyn_cap_rsp(struct cxl_cmd *cmd,
> > +        CXLDeviceState *cxl_dstate, uint16_t *len_unused)
> > +{
> > +    updated_dc_extent_list_in_pl *in =3D (void *)cmd->payload;
> > +    struct CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev=
,
> > +            cxl_dstate);
> > +    CXLDCDExtentList *extent_list =3D &ct3d->dc.extents;
> > +    CXLDCD_Extent *ent;
> > +    uint32_t i;
> > +    uint64_t dpa, len;
> > +    CXLRetCode ret;
> > +
> > +    if (in->num_entries_updated =3D=3D 0) {
> > +        ret =3D CXL_MBOX_SUCCESS;
> > +        goto out;
> > +    }
> > +
> > +    ret =3D detect_malformed_extent_list(ct3d, in);
> > +    if (ret !=3D CXL_MBOX_SUCCESS) {
> > +        goto out;
> > +    }
> > +
> > +    for (i =3D 0; i < in->num_entries_updated; i++) {
> > +        dpa =3D in->updated_entries[i].start_dpa;
> > +        len =3D in->updated_entries[i].len;
> > +
> > +        /*
> > +         * Check if the DPA range of the to-be-added extent overlaps =
with
> > +         * existing extent list maintained by the device.
> > +         */
> > +        QTAILQ_FOREACH(ent, extent_list, node) {
> > +            if (ent->start_dpa =3D=3D dpa && ent->len =3D=3D len) {
> > +                ret =3D CXL_MBOX_INVALID_PA;
> > +                goto out;
> > +            } else if (ent->start_dpa <=3D dpa
> > +                    && dpa + len <=3D ent->start_dpa + ent->len) {
> > +                ret =3D CXL_MBOX_INVALID_PA;
> > +                goto out;
> > +            } else if ((dpa < ent->start_dpa + ent->len
> > +                        && dpa + len > ent->start_dpa + ent->len)
> > +                    || (dpa < ent->start_dpa && dpa + len > ent->star=
t_dpa)) {
> > +                ret =3D CXL_MBOX_INVALID_PA;
> > +                goto out;
> > +            }
> > +        }
> > +
> > +        /*
> > +         * TODO: add a pending extent list based on event log record =
and verify
> > +         * the input response
> > +         */
> > +
> > +        insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> > +    }
> > +    ret =3D CXL_MBOX_SUCCESS;
> > +
> > +out:
> > +    return ret;
> > +}
> > +
> > +/*
> > + * Spec 3.0: 8.2.9.8.9.4
> > + * Release Dynamic Capacity (opcode 4803h)
> > + **/
> > +static CXLRetCode cmd_dcd_release_dyn_cap(struct cxl_cmd *cmd,
> > +        CXLDeviceState *cxl_dstate,
> > +        uint16_t *len_unused)
> > +{
> > +    updated_dc_extent_list_in_pl *in =3D (void *)cmd->payload;
> > +    struct CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev=
,
> > +            cxl_dstate);
> > +    CXLDCDExtentList *extent_list =3D &ct3d->dc.extents;
> > +    CXLDCD_Extent *ent;
> > +    uint32_t i;
> > +    uint64_t dpa, len;
> > +    CXLRetCode ret;
> > +
> > +    if (in->num_entries_updated =3D=3D 0) {
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    ret =3D detect_malformed_extent_list(ct3d, in);
> > +    if (ret !=3D CXL_MBOX_SUCCESS) {
> > +        return ret;
> > +    }
> > +
> > +    for (i =3D 0; i < in->num_entries_updated; i++) {
> > +        dpa =3D in->updated_entries[i].start_dpa;
> > +        len =3D in->updated_entries[i].len;
> > +
> > +        QTAILQ_FOREACH(ent, extent_list, node) {
> > +            if (ent->start_dpa =3D=3D dpa && ent->len =3D=3D len) {
> > +                break;
> > +            } else if (ent->start_dpa < dpa
> > +                    && dpa + len <=3D ent->start_dpa + ent->len) {
> > +                /* remove partial extent */
> > +                uint64_t len1 =3D dpa - ent->start_dpa;
> > +                uint64_t len2 =3D ent->start_dpa + ent->len - dpa - l=
en;
> > +
> > +                if (len1) {
> > +                    insert_extent_to_extent_list(extent_list, ent->st=
art_dpa,
> > +                            len1, NULL, 0);
> > +                }
> > +                if (len2) {
> > +                    insert_extent_to_extent_list(extent_list, dpa + l=
en, len2,
> > +                            NULL, 0);
> > +                }
> > +                break;
> > +            } else if ((dpa < ent->start_dpa + ent->len
> > +                        && dpa + len > ent->start_dpa + ent->len)
> > +                    || (dpa < ent->start_dpa && dpa + len > ent->star=
t_dpa))
> > +                return CXL_MBOX_INVALID_EXTENT_LIST;
> > +        }
> > +
> > +        if (ent) {
> > +            QTAILQ_REMOVE(extent_list, ent, node);
> > +            g_free(ent);
> > +        } else {
> > +            /* Try to remove a non-existing extent */
> > +            return CXL_MBOX_INVALID_PA;
> > +        }
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >   #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> >   #define IMMEDIATE_DATA_CHANGE (1 << 2)
> >   #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> > @@ -1129,6 +1376,12 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D=
 {
> >       [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] =3D {
> >           "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_=
ext_list,
> >           8, 0 },
> > +    [DCD_CONFIG][ADD_DYN_CAP_RSP] =3D {
> > +        "ADD_DCD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
> > +        ~0, IMMEDIATE_DATA_CHANGE },
> > +    [DCD_CONFIG][RELEASE_DYN_CAP] =3D {
> > +        "RELEASE_DCD_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
> > +        ~0, IMMEDIATE_DATA_CHANGE },
> >   };
> >
> >   static struct cxl_cmd cxl_cmd_set_sw[256][256] =3D {
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 3a338b3b37..01a5eaca48 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -130,7 +130,8 @@ typedef enum {
> >       CXL_MBOX_INCORRECT_PASSPHRASE =3D 0x14,
> >       CXL_MBOX_UNSUPPORTED_MAILBOX =3D 0x15,
> >       CXL_MBOX_INVALID_PAYLOAD_LENGTH =3D 0x16,
> > -    CXL_MBOX_MAX =3D 0x17
> > +    CXL_MBOX_INVALID_EXTENT_LIST =3D 0x1E, /* cxl r3.0: Table 8-34*/
> > +    CXL_MBOX_MAX =3D 0x1F
> >   } CXLRetCode;
> >
> >   struct cxl_cmd;
> > --
> > 2.25.1
