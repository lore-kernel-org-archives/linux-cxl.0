Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52790C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 11 May 2022 21:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347950AbiEKVEh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 May 2022 17:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347948AbiEKVEg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 May 2022 17:04:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC2E22922F
        for <linux-cxl@vger.kernel.org>; Wed, 11 May 2022 14:04:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id iq10so3386572pjb.0
        for <linux-cxl@vger.kernel.org>; Wed, 11 May 2022 14:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sd8TS3LSOetDUEh+IitqYXL7ef+8AV1deYn9fBUFEnw=;
        b=oPobyhQSM3W+m8jOIhS4xc4rfvr8/4431Oe9H7/A97kpdpty6jOa89OLwr6gnMwyg+
         w8Fgjh0Sxzi1Vil2N/M0irj0s5zdqKh6MRp3mQ5Fi5Ee9fnZR37Fazs+87vWA+PmEARn
         rn5++yKYold8vkgOPOwAkA3dKy9s8X+YKEapp8lSqqEO3CA/gyliTRUsnF9CZv5G+Yaf
         s7sd/xx+0eSG0kqLMF4G+ejzf5th5nffWaDwjimfXvZkGzhFU60TIvcvvHTkC+YXorb0
         qlH4lFEKuBnIx0eZ4bJyoliRbqwkvNiRzm4BkiBEwUmQIRYD46E1Eyjzyd+dmoAQqiaC
         1zaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sd8TS3LSOetDUEh+IitqYXL7ef+8AV1deYn9fBUFEnw=;
        b=JRtFRXOG8U2bwRn9h4K4jcvoVtMdT/+f3CFeOkVcT+Gsz/w3yvQNnBvEFoEkTJ+xfO
         Fg/W2o6oVAZFDxqFEsYRUhxYZetG0D9prsqF+vENM48FPTSamlTcQfKZrYMfbV0OYiU2
         WnkyzAzFXNfbs1vlImf1B687yB+xV/107Vg7WTWzOcx81eRQDxfoTM6ZhEgUNttn6UvX
         oiuTtpYswzBulvcB5kC+gJhKh5qO0uHo3iILfgkl7uZ62lSSVuEruJKSPi6DWO9nAOqh
         nykZtgCcK7o39x2pKdGI7YWs3ZlaLUEncB6MtIOuVrGbmQ1wO3YYUtpIq4TmQ7pmNZZg
         w7ig==
X-Gm-Message-State: AOAM531WNz9GGPsHOQQoQlCgJbKcfitve4Nnc6oZ8ndoXKUU05VKewj3
        LJjzFyXgHgR9PsoPQIu9O6utzw16dBh2X80yZrxjNQ==
X-Google-Smtp-Source: ABdhPJwm1iZCF5sgYgLXlCPGVeMT6ocMr7PQ+baaQemaHPcLOEQ/dSuJjpP9aJzg6QKQfE9+1spkwYjTFeMsn6ndnSs=
X-Received: by 2002:a17:90b:3845:b0:1dc:a733:2ece with SMTP id
 nl5-20020a17090b384500b001dca7332ecemr7260303pjb.220.1652303075169; Wed, 11
 May 2022 14:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de> <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de> <CAPcyv4idjqiY9CV=sghDbWqQS_PM2Z0xWxr2MsrMxS-XqU1F=w@mail.gmail.com>
 <DM4PR11MB5373D8BCF189EAECA8F22D7EFFC89@DM4PR11MB5373.namprd11.prod.outlook.com>
In-Reply-To: <DM4PR11MB5373D8BCF189EAECA8F22D7EFFC89@DM4PR11MB5373.namprd11.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 May 2022 14:04:24 -0700
Message-ID: <CAPcyv4hpLnC7JV5Jj+h92jrz6ye8mtWzyRZeoe3FmydxYD3Waw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
To:     "Hindman, Gavin" <gavin.hindman@intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        CHUCK_LEVER <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, May 11, 2022 at 1:22 PM Hindman, Gavin <gavin.hindman@intel.com> wr=
ote:
>
>
>
> >-----Original Message-----
> >From: Dan Williams <dan.j.williams@intel.com>
> >Sent: Wednesday, May 11, 2022 12:42 PM
> >To: Lukas Wunner <lukas@wunner.de>
> >Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Hindman, Gavin
> ><gavin.hindman@intel.com>; Linuxarm <linuxarm@huawei.com>; Weiny, Ira
> ><ira.weiny@intel.com>; Linux PCI <linux-pci@vger.kernel.org>; linux-
> >cxl@vger.kernel.org; CHUCK_LEVER <chuck.lever@oracle.com>
> >Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
> >
> >On Wed, May 11, 2022 at 12:14 PM Lukas Wunner <lukas@wunner.de> wrote:
> >>
> >> On Mon, May 09, 2022 at 10:48:06AM +0100, Jonathan Cameron wrote:
> >> > On Sat, 7 May 2022 12:18:48 +0200 Lukas Wunner <lukas@wunner.de>
> >wrote:
> >> > > I'm still somewhat undecided on the kernel vs. user space question=
.
> >> >
> >> > Likewise.  I feel a few more prototypes are needed to come to clear
> >> > conclusion.
> >>
> >> Gavin Hindman (+cc) raised an important point off-list:
> >>
> >> When an IDE-capable device is runtime suspended to D3hot and later
> >> runtime resumed to D0, it may not preserve its internal state.
> >> (The No_Soft_Reset bit in the Power Management Control/Status Register
> >> tells us whether the device is capable of preserving internal state
> >> over a transition to D3hot, see PCIe r6.0, sec. 7.5.2.2.)
> >
> >I think power-management effects relative to IDE is a soft spot of the
> >specification. If the link goes down then yes, IDE needs to be re-establ=
ished,
> >but as far as I can see that's a policy tradeoff to support runtime rese=
t or
> >support link encryption.
> >
> >> Likewise, when an IDE-capable device is reset (e.g. due to Downstream
> >> Port Containment, AER or a bus reset initiated by user space),
> >> internal state is lost and must be reconstructed by pci_restore_state(=
).
> >> That state includes the SPDM session or IDE encryption.
> >>
> >> If setting up an SPDM session is dependent on user space, the kernel
> >> would have to leave a device in an inoperable state after runtime
> >> resume or reset, until user space gets around to initiate SPDM.
> >
> >Yes, this seems acceptable from the perspective of server platforms that=
 can
> >make the power management vs security tradeoff.
> >
>
> Agree, though more and more we need to be thinking about sustainability a=
nd cost-of-ownership and having to keep devices awake in order to meet secu=
rity goals is somewhat contrary to that objective.  I fully realize those a=
re not technical constraints, but IMO should still be considered.  Latency =
for deadline-driven tasks was my original consideration, not just security =
- power-management features commonly get turned off due to resume latency, =
and this would appear to have the potential to extend resume latencies even=
 in kernel, let alone waiting for user-space response. Again, obviously not=
 a hard design constraint, but seems worthy of consideration

Keep in mind that kernel managed IDE is not much more than a stop-gap
to fully attesting that devices are within a goven trusted compute
boundary. In that model the kernel is not trusted to establish that
validation. Instead that role is reserved for a trusted platform
entity. So yes, those are important considerations, but they do not
read on the kernel implementation in the near term.
