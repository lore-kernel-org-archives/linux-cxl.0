Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1E3EE801F
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Sep 2023 17:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbjIHRPD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Sep 2023 13:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjIHRPC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Sep 2023 13:15:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE098CE6
        for <linux-cxl@vger.kernel.org>; Fri,  8 Sep 2023 10:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1694193196; x=1694797996; i=fan.ni@gmx.us;
 bh=PyTtTSGkK0YDDu75CUsELW/zziVqpZYsIv90hJn8nFQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=tb/TGIMYR7d2IQMDLkwwr2IjNhtMhbJ9RtZlihJ9+YJFHGaMrWNdpzi6JanCNOeVgihgkIl
 0W0PAdYiIVPvXrBSKPxViYQJwq6xKglJVMYw5Mku8HKtEy5Dpi085d1txOd5LmZ3wMxq/LNLJ
 od1FcGzGNU3CLeK62mcR6mdNEDLUUswG6ORCYxw3fBcTikpI2qdA9WowpqZc2k3ito5n4zZz3
 BUkvj7cyBprGplSCpz/IDWtZNu/Ofrbm1Zi2I0HuFtE0J2jdfo1+PGXlTwo/Ce4F4pe5Uz5Im
 4w1hxK7PEU5ZId3dPesBIFtaqS3xnfxkthhdSNSEqQHSgmJCLk7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([99.13.228.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1po0-1qcTBL3aIq-002Ets; Fri, 08
 Sep 2023 19:13:16 +0200
Date:   Fri, 8 Sep 2023 10:12:58 -0700
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
Subject: Re: [Qemu PATCH v2 6/9] hw/mem/cxl_type3: Add DC extent list
 representative and get DC extent list mailbox support
Message-ID: <ZPtWGqBCISsaDbY/@debian>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183957uscas1p28b38d294f90b97f99769466cc533b4de@uscas1p2.samsung.com>
 <20230725183939.2741025-7-fan.ni@samsung.com>
 <ca63022b-0447-74b8-06fc-0e6d47455ebc@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca63022b-0447-74b8-06fc-0e6d47455ebc@wdc.com>
X-Provags-ID: V03:K1:T3FLWp3hDCYbgtq2nkmqGqy0qgYjfFD0239x81DbBjfOZExWxBz
 1QgCWvCHwgNaSZB0sS/mIy5Zl/0BWBLJHia9Vh2qNBMkxzHmVql+ZxcVwpAD/uOgGeVhQIV
 9ZYfxCSLpB7s1mxsX6YupY1D+2NhRzjXGEh4yVAcp4+5JdE49TBVjskmpG3dekg497lOmpi
 3AHoONQihpYQm67rSqO3g==
UI-OutboundReport: notjunk:1;M01:P0:QCLOZH0v20k=;wkgkaIDRH6F4SSliiPwWT94LDKy
 vJkuNWCLhmuwIGIpnBZiuhJlk0gQg9vKpysXZmObQqMCCqf7Q/jyyQI+TT+Czjhy4mgphprfw
 Z0jst0VyY+P2OaZjLF8lM+pWXDCVy6zTE3T2BvNeUxM8gmqLNWxV4mNMaSRSrKaNHYa0QCIYV
 Xle3OlnjrFOAs+mYRsLANRVjiP40jaTsjRptage+Nh62XjXjnSREdj4vWbTCkhbOMtJUgVBOw
 bLs4NjtR1vc5TuHYMMUX2M+zQG5bqLD46ldZ8MYRoCfqlTCivdZQv6/AChK2bi1XYA4gJlh+5
 zjze6KPszKqyGLhIYRUTrVfUYoBeK6X9lfQs5uLYOzc2YKyJPacB7wxBt7UUuEwQLsXkVPOSL
 AYYLA1J3Uypx/0uyO/IBquTLVypSuQIo8oZpE3bwFhWxUE+w2TwOEqDHGMnO4eTPJcAIFFCrg
 /MwZO2mJqrhgjRGvhjWkp+FYhh7tiBCmqQvPwDvZnTTFv/7uHbkiWsoTJgcWfOZQCbqld4xcO
 3UzhztUCEH4IYqyhABVMDhDwqWQdkHuXhC4o0PL2KHjtZoQ/kLX5nwJvFUeZwpnF+If4ewHLS
 6tAQdn0kktSZMp6Q4owX3s9wHSfhY2nFvpUA99vpwiHBuMB2O6lvOd55Q8kZyXbwq8LH54jWr
 gdVAy/duxGAU/TL+mAXKG+n779U7alVniBLgiZXkgLSCutf0P0E08aQhPnPTkDHbM7FPPi+B/
 sF+qffAQ6FAla6RknEUcZww6sd7tiBWSkoVfhjD2ecu8SHPbEAbXVw+ndz+ChLYdpaeuMMHwD
 YAzs+y7xBb9yUJb0dQ9ZYRFp/PR8xRDZG8RJedhft11qdFJn4seuNQI9lWtTSljME4uc5bLu2
 crOZJVUxogND0wOIe7giWLsnNSrWSjtcmSK7oHaQapJ2aQWKVzsNxEFlOECSJLq87p+Tla9j1
 EoAq7Syr+y8QkzfvzWGeUDO1aIs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Sep 08, 2023 at 01:12:45PM +0000, J?rgen Hansen wrote:
> On 7/25/23 20:39, Fan Ni wrote:
> > From: Fan Ni <nifan@outlook.com>
> >
> > Add dynamic capacity extent list representative to the definition of
> > CXLType3Dev and add get DC extent list mailbox command per
> > CXL.spec.3.0:.8.2.9.8.9.2.
> >
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c  | 71 +++++++++++++++++++++++++++++++++++=
++
> >   hw/mem/cxl_type3.c          |  1 +
> >   include/hw/cxl/cxl_device.h | 23 ++++++++++++
> >   3 files changed, 95 insertions(+)
> >
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 0511b8e6f7..3d25a9697e 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -83,6 +83,7 @@ enum {
> >           #define CLEAR_POISON           0x2
> >       DCD_CONFIG  =3D 0x48, /*r3.0: 8.2.9.8.9*/
> >           #define GET_DC_CONFIG          0x0
> > +        #define GET_DYN_CAP_EXT_LIST   0x1
> >       PHYSICAL_SWITCH =3D 0x51
> >           #define IDENTIFY_SWITCH_DEVICE      0x0
> >   };
> > @@ -1018,6 +1019,73 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(st=
ruct cxl_cmd *cmd,
> >       return CXL_MBOX_SUCCESS;
> >   }
> >
> > +/*
> > + * cxl spec 3.0: 8.2.9.8.9.2
> > + * Get Dynamic Capacity Extent List (Opcode 4810h)
> > + */
> > +static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(struct cxl_cmd *cmd,
> > +        CXLDeviceState *cxl_dstate,
> > +        uint16_t *len)
> > +{
> > +    struct get_dyn_cap_ext_list_in_pl {
> > +        uint32_t extent_cnt;
> > +        uint32_t start_extent_id;
> > +    } QEMU_PACKED;
> > +
> > +    struct get_dyn_cap_ext_list_out_pl {
> > +        uint32_t count;
> > +        uint32_t total_extents;
> > +        uint32_t generation_num;
> > +        uint8_t rsvd[4];
> > +        CXLDCExtent_raw records[];
> > +    } QEMU_PACKED;
> > +
> > +    struct get_dyn_cap_ext_list_in_pl *in =3D (void *)cmd->payload;
> > +    struct get_dyn_cap_ext_list_out_pl *out =3D (void *)cmd->payload;
> > +    struct CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev=
,
> > +            cxl_dstate);
> > +    uint16_t record_count =3D 0, i =3D 0, record_done =3D 0;
> > +    CXLDCDExtentList *extent_list =3D &ct3d->dc.extents;
> > +    CXLDCD_Extent *ent;
> > +    uint16_t out_pl_len;
> > +    uint32_t start_extent_id =3D in->start_extent_id;
> > +
> > +    if (start_extent_id > ct3d->dc.total_extent_count) {
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    record_count =3D MIN(in->extent_cnt,
> > +            ct3d->dc.total_extent_count - start_extent_id);
> > +
> > +    out_pl_len =3D sizeof(*out) + record_count * sizeof(out->records[=
0]);
> > +    /* May need more processing here in the future */
> > +    assert(out_pl_len <=3D CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> > +
> > +    memset(out, 0, out_pl_len);
> > +    stl_le_p(&out->count, record_count);
> > +    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
> > +    stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
> > +
> > +    if (record_count > 0) {
> > +        QTAILQ_FOREACH(ent, extent_list, node) {
> > +            if (i++ < start_extent_id) {
> > +                continue;
> > +            }
> > +            stq_le_p(&out->records[record_done].start_dpa, ent->start=
_dpa);
> > +            stq_le_p(&out->records[record_done].len, ent->len);
> > +            memcpy(&out->records[record_done].tag, ent->tag, 0x10);
> > +            stw_le_p(&out->records[record_done].shared_seq, ent->shar=
ed_seq);
> > +            record_done++;
> > +            if (record_done =3D=3D record_count) {
> > +                break;
> > +            }
> > +        }
> > +    }
> > +
> > +    *len =3D out_pl_len;
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >   #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> >   #define IMMEDIATE_DATA_CHANGE (1 << 2)
> >   #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> > @@ -1058,6 +1126,9 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D =
{
> >           cmd_media_clear_poison, 72, 0 },
> >       [DCD_CONFIG][GET_DC_CONFIG] =3D { "DCD_GET_DC_CONFIG",
> >           cmd_dcd_get_dyn_cap_config, 2, 0 },
> > +    [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] =3D {
> > +        "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_e=
xt_list,
> > +        8, 0 },
> >   };
> >
> >   static struct cxl_cmd cxl_cmd_set_sw[256][256] =3D {
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 76bbd9f785..f1170b8047 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -789,6 +789,7 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d=
)
> >
> >           region_base +=3D region->len;
> >       }
> > +    QTAILQ_INIT(&ct3d->dc.extents);
> >
> >       return 0;
> >   }
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 1c99b05a66..3a338b3b37 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -385,6 +385,25 @@ typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
> >
> >   #define DCD_MAX_REGION_NUM 8
> >
> > +typedef struct CXLDCD_Extent_raw {
> > +    uint64_t start_dpa;
> > +    uint64_t len;
> > +    uint8_t tag[0x10];
> > +    uint16_t shared_seq;
> > +    uint8_t rsvd[0x6];
> > +} QEMU_PACKED CXLDCExtent_raw;
> > +
> > +typedef struct CXLDCD_Extent {
> > +    uint64_t start_dpa;
> > +    uint64_t len;
> > +    uint8_t tag[0x10];
> > +    uint16_t shared_seq;
> > +    uint8_t rsvd[0x6];
> > +
> > +    QTAILQ_ENTRY(CXLDCD_Extent) node;
> > +} CXLDCD_Extent;
> > +typedef QTAILQ_HEAD(, CXLDCD_Extent) CXLDCDExtentList;
> > +
> >   typedef struct CXLDCD_Region {
> >       uint64_t base;
> >       uint64_t decode_len; /* in multiples of 256MB */
> > @@ -433,6 +452,10 @@ struct CXLType3Dev {
> >
> >           uint8_t num_regions; /* 0-8 regions */
> >           struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
> > +        CXLDCDExtentList extents;
> > +
> > +        uint32_t total_extent_count;
>
> Hi,
>
> I don't see total_extent_count being updated anywhere. Shouldn't this be
> adjusted as part of cmd_dcd_add_dyn_cap_rsp()/cmd_dcd_release_dyn_cap()?
>
> Thanks,
> Jorgen

Good catch. Thanks Jorgen, will fix in the next version.

Fan

>
>
> > +        uint32_t ext_list_gen_seq;
> >       } dc;
> >   };
> >
> > --
> > 2.25.1
