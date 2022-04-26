Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCCEC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 26 Apr 2022 20:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242199AbiDZUFc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354345AbiDZUFa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 26 Apr 2022 16:05:30 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2DC192A2
        for <linux-cxl@vger.kernel.org>; Tue, 26 Apr 2022 13:02:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k4so19647008plk.7
        for <linux-cxl@vger.kernel.org>; Tue, 26 Apr 2022 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFQoTHus1YItG3So+GJ3XM1u+6Horagq1SLU0dS++yw=;
        b=UfiQ0V9Rk0FG6eg1obt8DliCkJfV6pomFd5SjRNflr8aAQUD/LnoRt40tcgvhe8z1A
         CyWFMbafQdBYN7Eq+2t4yInTIuv2mD0nDf7RJXmtQrHwp609+JuOP1oHGTyBqtuzedhg
         zi8ABNaf5XzL3O2E1Iz0nyvwBYmEyKPy4Ok2u1ZOhbG8GtmNZj0crnTI9vxbJhokw46F
         SXSEunPjkyJTd/ziNjb6uRoUT4/ypIuTW+TEZrXhoY3LqZycVxobLiO0dXAyORRMH4uA
         8aMSzxzkkZ+IAfDyQsWqnE8l6K477JcP+TtrmImRmdtg6ljVeXrZCsMZ9bl5Hb1o2jhR
         2How==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFQoTHus1YItG3So+GJ3XM1u+6Horagq1SLU0dS++yw=;
        b=ZXb/fFkUIMsq77p94KIrtNl/3/JM15NWCkxmQWVkN1iyFkbu26Xj4M7wKTfDv0PnyT
         oxTaqV7gGsybpHgAZiMRSUnl/AlpEwroEq6ucNULs60GcQONKv2aDkElHYV1Y+3mWawk
         tlWmS1cR651BJapC4eQbNOA3Gf33nhfsMrC+Rkqp9XGrJ+5SgCAdRYe3PYFlkuKQxqDm
         Qh44+jmTqDKTHeF3GZ9niMB4prjzGWhmyu58sTz4VoyUKSsPeh/WSc1d66fy34ck47Zi
         ZI8J16671X+RyFL6rkz+T0aOgrXm1OFZPaDqUZtiJCBdNhGytQ6l9BPsNXHylGNs0ED/
         ZbSQ==
X-Gm-Message-State: AOAM533KYNwUmeF/NFPGmhMfN0/KCwg7a2sF37tKvlIQGjbmjXaxEslq
        t4/80SjbIO6NngE0vaUf3YlqtijzKEEknWm/gJjwZg==
X-Google-Smtp-Source: ABdhPJzIh89W1il3pmdZqdtbdOp0YimN9VNdx9CEBHzAHqqNMujb1YaS3P2rEwCtzGgczoIunF4d4/VD5kaFc+DoaaE=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr24913472pll.132.1651003340744; Tue, 26
 Apr 2022 13:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220426180832.00005f0b@Huawei.com> <CAPcyv4i+=ArjE7uH_jKGS+B9-dLJ3An_T+NgWB2xqC-7Zh-VYA@mail.gmail.com>
 <20220426190615.000063ed@Huawei.com> <CAPcyv4gjn7MAo-kzW40EAc9J6zQaOKh0a-42GyV1X5Efac_W_Q@mail.gmail.com>
 <20220426203850.00006538@Huawei.com>
In-Reply-To: <20220426203850.00006538@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Apr 2022 13:02:09 -0700
Message-ID: <CAPcyv4jsd=mWOU0ftgxBzwD6KhZ1oMCRVDm5WTYStfbF7_jBTA@mail.gmail.com>
Subject: Re: CXL type 3 which doesn't have cxl mem enabled.
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Apr 26, 2022 at 12:39 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 26 Apr 2022 12:00:41 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Tue, Apr 26, 2022 at 11:06 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Tue, 26 Apr 2022 10:19:55 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > On Tue, Apr 26, 2022 at 10:09 AM Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > >
> > > > > Hi All,
> > > > >
> > > > > I ran into this whilst debugging why on the current QEMU code
> > > > > we now get a probe failure for CXL mem due to the range 1 size being
> > > > > non 0.
> > > > >
> > > > > The conditions for whether we have legacy ranges programmed don't
> > > > > take into account if Mem_Enable = 1.  That is if the
> > > > > DVSEC CXL Control Mem_Enable bit is set on the type 3 device.
> > > > > If it's not then there is no existing user of the CXL memory
> > > > > setup by firmware or similar so we can switch over to HDM
> > > > > decoders and it doesn't matter what is in the range registers.
> > > > >
> > > > > Unfortunately the QEMU code was bringing the device up with
> > > > > Mem_Enabled already set.  So I fixed that.  After all default
> > > > > value of that bit should be 0.
> > > > >
> > > > > A few problems then showed up.
> > > > >
> > > > > 1. Nothing in the Linux code actually sets Mem_Enabled to 1.
> > >
> > > Sorry - my mistake, that should be Mem_Enable. Though that doesn't
> > > actually clarify things much...
> > >
> > > >
> > > > That's because the device is supposed to, I though, set it of its own
> > > > accord as a result of link training. It's an RO field in the spec, so
> > > > Linux can't set it:
> > > >
> > > > 8.2.1.3.3 DVSEC Flex Bus Port Status (Offset 0Eh)
> > > > "Mem_Enabled: When set, indicates that CXL.mem protocol operation has
> > > > been enabled as a result of PCIe alternate protocol negotiation for
> > > > Flex Bus."
> > >
> > > Agreed with that statement.
> > >
> > > Ah. Nothing like confusing register field names that are very similar....
> > > A Mem_Enable is in DVSEC for CXL Device 8.1.3.2 and is RWL.
> > > Just for giggles there is also a Mem_Enable in the Flex Bus Port Control
> > > but the range registers comment isn't about that one (I hope anyway!).
> >
> > Not sure whether to laugh or cry at that, sorry for the mix up on my part.
> >
> > > The kernel currently sets the value of info->mem_enabled using
> > > the Mem_Enable field of the DVSEC for CXL Device.
> > > https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/cxl/pci.c#L501
> > >
> > > So I think wrong name and wrong DVSEC for that particular condition.
> >
> > Yeah, I don't even see a need to cache that value, so something like
> > the attached? Note that the intent was to only have cxl_mem worry
> > about MMIO mapped register details and not require the 'struct
> > pci_dev' which makes things easier for cxl_test in the near term.
> >
> Hi Dan,
>
> That fixes this problem (I'll test tomorrow but it looks right), but...
>
> I think we still run into the problem I was debugging in the
> first place which is whether the Device DVSEC Range 1 size is non 0.
> https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/cxl/pci.c#L541
> (ranges ends up > 0 and hence we conclude firmware already programmed the
>  device and fail the probe).
>
> As far as I can tell a CXL 2.0 type 3 device is allowed to provide
> the option to use ranges or HDM decoders (or it can be HDM decoder only).
> See the comment at end of 8.1.3.8.4 :
>
> "A CXL.mem capable device that implements CXL HDM Decoder Capability registers
> follows the above behavior as long as HDM Decoder Enable bit in CXL HDM Decoder
> Global Control register is zero."
>
> As such we can't use the range size alone to check if
> the Range registers are in use (it's a RO value, not something previously
> configured)  We need to perform the full check as described which
> includes checking Mem_Enable (which is in the above behavior that comment
> is directing us towards).
>
> As the below patch has already set Mem_Enable hardware field unconditionally
> we don't have the necessary info by the time we reach the relevant code.
> https://elixir.bootlin.com/linux/v5.18-rc4/source/drivers/cxl/mem.c#L107
>
> So you could cache the current value (perhaps with a more meaningful
> name than the spec gives it!) of Device DVSEC Mem_Enable
> at the point where you have it written in this patch and add a check
> on the cached value at the point in the reference above.
>
> That's still a little ugly as ideally we shouldn't transition through
> a somewhat invalid state - though it is harmless as no traffic
> will be sent by the host (probably - though I suspect hardware folk
> would tell me we can't assume it...).

...and there is also the worry about malicious devices, but I don't
know how to determine the difference between valid config, invalid
config, and malicious device claiming a range that it shouldn't.
Perhaps this needs at a minimum cross validation with the CFMWS?

> The invalid state being:
> - Mem_Enable set
> - Range registers in use because global HDM Decoder enable not yet set.
> - Range registers were programmed by firmware to something that actually
>   works but not enabled for some odd reason. I think they might even be
>   technically valid with the defaults even though the base is 0 (imagine
>   a very large CXL memory - some of it might overlap with a region being
>   routed by the host to the CXL host bridges).

Oh yuck, yes the default init state of any device is that it will
decode the first 256MB of memory as long as mem_enabled is set, and
devices are "trusted" to not decode anything that they shouldn't.

I'm wondering if Linux should take a more draconian approach and
mandate that all devices that advertise the CXL 2.0 Class Code
capability must boot in HDM decoder enabled mode, or Mem_enable=0
mode. Any CXL 2.0 device found to have Mem_enable=1 without HDM
decoders enabled will have HDM decoder operation forced upon them so
that Linux can trust that nothing is being decoded by accident, if
that breaks the system, that's a BIOS bug, not a Linux bug. Of course,
could have a module parameter to override that policy while the BIOS
update is in-flight to the target system.

> Ideally we wouldn't set that Mem_Enable until we have switched
> to the HDM decoders.  To avoid that we probably need another callback
> from cxl_mem into cxl_pci.

Either another callback, or move more validation out of cxl_mem and
into cxl_pci. I am leaning towards the latter.

> Agreed on the laughing or crying. I'm off to find a beer.

Cheers!
