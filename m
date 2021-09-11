Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CAAC433F5
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Sep 2021 01:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EECD6120A
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Sep 2021 01:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhIKBiu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 21:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKBit (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 21:38:49 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73E1C061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 18:37:37 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q68so3428477pga.9
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 18:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aaX/O1wBiKgh/WWNMWkbsmad2qBZv0XcTyr8tMaFjuE=;
        b=TbzmqfDN6LVMN4ElxxTwd75qEokLY9y1+xzfqsMEgdyry494cman4fGLbNSJ9ZqT+n
         G0JhJCirukfyuEiVr5ZC7murpa4ahc1qZEjI9GqdPbvicg83PK67MA29y/Ew2JVngfps
         P6e1jdstaPxJ35HwlnYFrmC7TpOVyBJe6EgMV4HJQqFFA6cmdwlImoIBUT00STN0Do73
         QLAP3G2vxatlZXWMQWGTDP+1ROpE2Ja862E842ZfIoyEFHHaIwb/EULMFWj1UKe60B4/
         Br2uXx8hYRerkIgTzJOZOESy9/ecIXKOtk4ZHy/uB6Y5Y1Sh7G2SmVGR8JTas7f65SjW
         kT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aaX/O1wBiKgh/WWNMWkbsmad2qBZv0XcTyr8tMaFjuE=;
        b=OLRI89qD7qFJ3SSbd+9gMutz63z5iJp5PgY0CSN6h6RiTf5zKYnxPki5TVfIcksDiX
         RBcCtNhts+Ve/9qBh4SjW0qir3EA0ophmdfKR1UVgAm/ovvub/VJ8FrB2J+I8BbZCp1Q
         ZJ/33EQ7eq6kzQJKWXUn+Evn5cki8w9KlcHfCtXKhHHKTj8DpaP7qExeZBjmOKNIv0Q3
         RsihxrBkt9PsXEED5thqgMAgON8tuQ7DtMSZ+xDoPkxO0SGX4mrOb6D2ASq1Kha3Q3ys
         wwM2vqZsBrSvQDWGVZ38EG1ZBR42/WISMgUG3Fpa2Lw+KHSz9s4xXVeP585ENojCpyoi
         PiMw==
X-Gm-Message-State: AOAM530YPqdiqIqWvkFbl+cWPW3aHJ2u/MXMIYUtfCexg7NuA3RK+wp2
        02rgSn76vvqC0v4rlijUIpuEdgVxWnCbHG7gfRDViA==
X-Google-Smtp-Source: ABdhPJzQbm49jQpzU/NRSBdAy/6Dw44r0seFWd9OHl93JH4rAVkgOzMAWOgvWhA4jgRVXoBxUs/EDYi3C9qZpzAee9c=
X-Received: by 2002:a62:6d07:0:b0:40a:33cd:d3ea with SMTP id
 i7-20020a626d07000000b0040a33cdd3eamr438500pfc.61.1631324257322; Fri, 10 Sep
 2021 18:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
 <20210902195017.2516472-13-ben.widawsky@intel.com> <20210903184347.00002b32@Huawei.com>
In-Reply-To: <20210903184347.00002b32@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 18:37:26 -0700
Message-ID: <CAPcyv4hOKqXoUBOSJ_-KDtJv4PKtcwKaDyMySFNfqe=1e4OtNw@mail.gmail.com>
Subject: Re: [PATCH 12/13] cxl/core/bus: Enumerate all HDM decoders
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Sep 3, 2021 at 10:44 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 2 Sep 2021 12:50:16 -0700
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > As of the CXL 2.0 specification, every port will have between 1 and 10
> > HDM decoders available in hardware. These exist in the endpoint, switch=
,
> > and top level hostbridges. HDM decoders are required for configuration
> > CXL regions, and therefore enumerating them is an important first step.
> >
> > As an example, the below has 4 decoders, a top level CFMWS decoder
> > (0.0), a single decoder in a single host bridge (1.0), and two devices
> > each with 1 decoder (2.0 and 3.0)
> >
> > =E2=94=9C=E2=94=80=E2=94=80 decoder0.0 -> ../../../devices/platform/ACP=
I0017:00/root0/decoder0.0
> > =E2=94=9C=E2=94=80=E2=94=80 decoder1.0 -> ../../../devices/platform/ACP=
I0017:00/root0/port1/decoder1.0
> > =E2=94=9C=E2=94=80=E2=94=80 decoder2.0 -> ../../../devices/platform/ACP=
I0017:00/root0/port1/devport2/decoder2.0
> > =E2=94=9C=E2=94=80=E2=94=80 decoder3.0 -> ../../../devices/platform/ACP=
I0017:00/root0/port1/devport3/decoder3.0
> >
> > Additionally, attributes are added for a port:
> >
> > /sys/bus/cxl/devices/port1
> > =E2=94=9C=E2=94=80=E2=94=80 active_decoders
> > =E2=94=9C=E2=94=80=E2=94=80 decoder_count
> > =E2=94=9C=E2=94=80=E2=94=80 decoder_enabled
> > =E2=94=9C=E2=94=80=E2=94=80 max_target_count
> > ...
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> Documentation/ABI/testing/sysfs-bus-cxl  needs updating.
>
> Various minor things inline.
>
>
> > ---
> >  drivers/cxl/core/bus.c | 161 ++++++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/cxl.h      |  54 ++++++++++++--
> >  2 files changed, 209 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > index d056dbd794a4..b75e42965e89 100644
> > --- a/drivers/cxl/core/bus.c
> > +++ b/drivers/cxl/core/bus.c
[..]
> > +             ctrl =3D readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET=
(i));
> > +             cxld->decoder_enabled =3D
> > +                     !!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl=
);
> > +             /* If the decoder is already active, parse info */
> > +             if (cxld->decoder_enabled) {
> > +                     set_bit(i, port->used_decoders);
> > +                     iw =3D cxl_hdm_decoder_iw(ctrl);
> > +                     ig =3D cxl_hdm_decoder_ig(ctrl);
> > +                     if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) =
=3D=3D 0)
> > +                             type =3D CXL_DECODER_ACCELERATOR;
> > +                     res.start =3D readl(hdm_decoder +
> > +                                       CXL_HDM_DECODER0_BASE_LOW_OFFSE=
T(i));
> > +                     res.start |=3D
> > +                             (u64)readl(hdm_decoder +
> > +                                        CXL_HDM_DECODER0_BASE_HIGH_OFF=
SET(i))
> > +                             << 32;
>
> Perhaps worth thinking about exposing if the decoder is locked as well?
> Might be good to let userspace know that..

In fact...

What:           /sys/bus/cxl/devices/decoderX.Y/locked
Date:           June, 2021
KernelVersion:  v5.14
Contact:        linux-cxl@vger.kernel.org
Description:
                CXL HDM decoders have the capability to lock the configurat=
ion
                until the next device reset. For decoders of devtype
                "cxl_decoder_root" there is no standard facility to unlock =
them.
                For decoders of devtype "cxl_decoder_switch" a secondary bu=
s
                reset, of the PCIe bridge that provides the bus for this
                decoders uport, unlocks / resets the decoder.


>
> > +             }
> > +
> > +             cxld->target_type =3D type;
> > +             cxld->res =3D res;
> > +             cxld->interleave_ways =3D iw;
> > +             cxld->interleave_granularity =3D ig;
> > +
> > +             rc =3D cxl_decoder_add(host, cxld, NULL);
> > +             if (rc) {
> > +                     dev_warn(host, "Failed to add decoder (%d)\n", rc=
);
> > +                     kfree(cxld);
> > +                     goto out;
> > +             }
> > +     }
> > +
> > +     /*
> > +      * Enable CXL.mem decoding via MMIO for endpoint devices
> > +      *
> > +      * TODO: If a memory device was configured to participate in a re=
gion by
> > +      * system firmware via DVSEC, this will break that region.

Spec reference please (8.2.5.12.2 CXL HDM Decoder Global Control
Register) . Also the spec calls this "HDM Base registers in DVSEC ID
0".

>
> That seems to me like fatal for this patch set until fixed.
> I'm not sure I understand why it will break a region though as I'd assume=
 it
> would be already on?

The spec recommends that implementations set the HDM Base registers to
match the CXL HDM Decoder 0 value. The expectation is that platform
firmware is locking any HDM decoders for anything that it puts into
the platform firmware memory map. So I think a reasonable heuristic
here is decline to touch / support any device with HDM Base registers
pointing at a live entry in the system memory map as an indication
that the platform firmware is not prepared to interoperate with a CXL
2.0+ aware OS. CXL 2.0+ capable platform firmware should always use
HDM Decoders.

[..]
> >  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
> >  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
> >  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> > @@ -188,6 +210,12 @@ enum cxl_decoder_type {
> >   */
> >  #define CXL_DECODER_MAX_INTERLEAVE 16
> >
> > +/*
> > + * Current specification goes up to 10 double that seems a reasonable
> > + * software max for the foreseeable future
>
> I'd stick to 10 until we have evidence otherwise... If you happen to
> have a mysterious strong reason to go with 20 though I'm not that fussed
> but I suspect others may have equally strong reasons to pick another numb=
er ;)

That's a good point. This is different from max interleave. More
decoders significantly increases the operational complexity of
managing the configuration. If someone thinks they need more than 10,
I would beg to differ, and it helps that Linux pushes back against
that decoder creep by default until someone can come up with an
exceedingly good reason.

>
> > + */
> > +#define CXL_DECODER_MAX_COUNT 20
> > +
> >  /**
> >   * struct cxl_decoder - CXL address range decode configuration
> >   * @dev: this decoder's device
> > @@ -197,6 +225,7 @@ enum cxl_decoder_type {
> >   * @interleave_granularity: data stride per dport
>
> Is it currently documented anywhere that ig is in 2**(ig) bytes?
> Might be worth adding if not.

This structure field would carry the nominal value, not the encoded one, ri=
ght?

>
> >   * @target_type: accelerator vs expander (type2 vs type3) selector
> >   * @flags: memory type capabilities and locking
> > + * @decoder_enabled: Is this decoder currently decoding
> >   * @nr_targets: number of elements in @target
> >   * @target: active ordered target list in current decoder configuratio=
n
> >   */
> > @@ -208,6 +237,7 @@ struct cxl_decoder {
> >       int interleave_granularity;
> >       enum cxl_decoder_type target_type;
> >       unsigned long flags;
> > +     bool decoder_enabled;
> >       int nr_targets;
> >       struct cxl_dport *target[];
> >  };
> > @@ -255,6 +285,12 @@ struct cxl_walk_context {
> >   * @decoder_ida: allocator for decoder ids
> >   * @component_reg_phys: component register capability base address (op=
tional)
> >   * @regs: Mapped version of @component_reg_phys
> > + * @used_decoders: Bitmap of currently active decoders for the port
> > + * @decoder_cap: Capabilities of all decoders contained by the port
> > + * @decoder_cap.count: Count of HDM decoders for the port
> > + * @decoder_cap.target_count: Max number of interleaved downstream por=
ts
> > + * @decoder_cap.interleave11_8: Are address bits 11-8 available for in=
terleave
> > + * @decoder_cap.interleave14_12: Are address bits 14-12 available for =
interleave
> >   */
> >  struct cxl_port {
> >       struct device dev;
> > @@ -264,6 +300,14 @@ struct cxl_port {
> >       struct ida decoder_ida;
> >       resource_size_t component_reg_phys;
> >       struct cxl_component_regs regs;
> > +
> > +     unsigned long *used_decoders;
>
> Given it's not huge use appropriate macro to allocate
> it directly here with the maximum of 10.
> DECLARE_BITMAP() in similar fashion to patch 19 in Dan's
> recent series.
>
> https://lore.kernel.org/all/162982122744.1124374.6742215706893563515.stgi=
t@dwillia2-desk3.amr.corp.intel.com/
>
> (I'm liking lore having "all" now !)

Mmmm.

>
> > +     struct {
> > +             int count;
> > +             int target_count;
> > +             bool interleave11_8;
> > +             bool interleave14_12;
> > +     } decoder_cap;
> >  };
> >
> >  /**
>
