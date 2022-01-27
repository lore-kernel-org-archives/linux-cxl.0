Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976DAC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 19:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245376AbiA0TDt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245331AbiA0TDs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 14:03:48 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C04C061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 11:03:48 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id g11-20020a17090a7d0b00b001b2c12c7273so5693368pjl.0
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 11:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2y824XNfVYTG+PMeq3NLOTBwEqq1v2BZjb9hMjKq8s8=;
        b=a+nQXsVp1u8yTnyWucoemzUMgYN49ZZFOFqSoZDbHci2ijG118LvBVsQ4CLLt/IOH7
         BdbrvuqwchPXXCuDnpzULaCAv1zb8Fl2j4YPt1Fu3avVnAhnYRTax4Wkhv3BXsN3q9td
         MXmbtIB5/l+hpKQeIDyEnoXpRlMbxerm69NJ6V/Mro5aVtHwJweFPkfhCBtYg9z2O/Ll
         NlEPSaQZnumo2BrQNW5axLBfLsCGmriORlRGHLt4YfpIEr1EdwY9UhEfMUIvX1RNYzBp
         52KBnrxxXLji70tleY+a/7ybPdDC70IJVbW01JCsG1Q4wQfdAHtgYsDoef2rWi38G5hf
         nXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2y824XNfVYTG+PMeq3NLOTBwEqq1v2BZjb9hMjKq8s8=;
        b=Gr++9N6ksIR+d9y96hAUCHJqSli13SrPulwMhYsmIbJItyw78sMgetjqhTWLa9VNSV
         m8UKPO/zuaBOND9GQ3B6NjQQoKqcwnrVZeh4943pr57wxtxSqyKWkI3j5CzXV1DFm2RW
         S+Ds5mS/J1auEzmy4ZLOQYXhJBKdt99wTV0AgMXmWZk/l9mOwYei68gJXJ6BiYaHf4Py
         msUtquWeEmNSL0xiLw9TEgOddHuNoNsq93jHfuTTs3x5ecIKPPBqfAJhSV+r91GW37Jo
         db4OpsH804S6ywRomD2awZAOmt60bMi0+VVvudfDaIIUWc/JMuTCx4wRtY8REPepuG4n
         SKDw==
X-Gm-Message-State: AOAM533Vz7AhQfRs+i4St9ghonGunI20mW9xW/VFD4Gi0GpUt6BPtPHP
        YrKJxj6UxPeJjDtJwW11PXVCL0zvGaRo10WUBc5a3GXbuyU=
X-Google-Smtp-Source: ABdhPJxUlx5dHATsN/cA0bSTgQMnsHKTsKZ6sx/mUR8wm5eUgz4yEEjzv5XQGa1nhRH1TDhuHteEPVhtyPoLota6tBY=
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr4120025ply.34.1643310227543;
 Thu, 27 Jan 2022 11:03:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642535478.git.alison.schofield@intel.com>
 <d8760a4a0ca5b28be4eee27a2581ca8c2abe3e49.1642535478.git.alison.schofield@intel.com>
 <CAPcyv4gx+mvAPEmYstUXAsjWY=Aq7zb4y4V+QGzwnauk1F8DEw@mail.gmail.com> <20220127054421.GE890284@alison-desk>
In-Reply-To: <20220127054421.GE890284@alison-desk>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Jan 2022 11:03:36 -0800
Message-ID: <CAPcyv4geNbFpd3FGV6CG28nXBPoOPz4Ym7e9TBVGhabd4MKwRw@mail.gmail.com>
Subject: Re: [ndctl PATCH v3 6/6] cxl: add command set-partition-info
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jan 26, 2022 at 9:40 PM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Wed, Jan 26, 2022 at 05:44:54PM -0800, Dan Williams wrote:
> > On Tue, Jan 18, 2022 at 12:20 PM <alison.schofield@intel.com> wrote:
> > >
> > > From: Alison Schofield <alison.schofield@intel.com>
> > >
> > > Users may want to change the partition layout of a memory
> > > device using the CXL command line tool.
> >
> > How about:
> >
> > CXL devices may support both volatile and persistent memory capacity.
> > The amount of device capacity set aside for each type is typically
> > established at the factory, but some devices also allow for dynamic
> > re-partitioning, add a command for this purpose.
>
> Thanks!
> >
> > > Add a new CXL command,
> > > 'cxl set-partition-info', that operates on a CXL memdev, or a
> > > set of memdevs, and allows the user to change the partition
> > > layout of the device(s).
> > >
> > > Synopsis:
> > > Usage: cxl set-partition-info <mem0> [<mem1>..<memN>] [<options>]
> >
> > It's unfortunate that the specification kept the word "info" in the
> > set-partition command name, let's leave it out of this name and just
> > call this 'cxl set-partition'.
> >
> Will do.
>
> > >
> > >         -v, --verbose           turn on debug
> > >         -s, --volatile_size <n>
> > >                                 next volatile partition size in bytes
> >
> > Some users will come to this tool with the thought, "I want volatile
> > capacity X", others "I want pmem capacity Y". All but the most
> > advanced users will not understand how the volatile setting affects
> > the pmem and vice versa, nor will they understand that capacity might
> > be fixed and other capacity is dynamic.
>
> I went very by the spec here, with those advance users in mind. I do
> think the user with limited knowledge may get frustrated by the rules.
> ie. like finding that their total capacity is not all partitionable
> capacity. I looked at ipmctl goal setting, where they do percentages,
> and didn't pursue - stuck with the spec.
>
> I like this below. If user wants 100% of any type, no math needed. But,
> anything else the user will have to specify a byte value.
>
> > So how about a set of options like:
> >
> > -t, --type=<volatile,pmem>
> > -s,--size=<size>
> >
> > ...where by default -t is 'pmem' and -s is '0' for 100% of the dynamic
> > capacity set to PMEM.
> >
> I don't get the language "and -s is '0' for 100%", specifically, the
> "-s is 0".
>
> If -s is ommitted the default behavior will be to set 100% of the
> partitionable capacity to type.

Right, sorry, yes I should have been clear that "-s 0" on the command
line means zero-out that capacity, but no "-s" is a default value that
means 100% of the given type.

I forgot that NULL can be used to detect string options not specified.

>
> If both type and size are ommitted, 100% of partitionable capacity is
> set to PMEM.
>
> Humor me...are these right?
>
> set-partition mem0
>         100% to pmem

yup.

>
> set-partition mem0 -tpmem
>         100% to pmem

I thought you need a space after short options, but apparently not.

>
> set-partition mem0 -tvolatile -s0
>         100% to pmem          ^^ That's what I think a -s0 does?!?
>

Agree, looks good.

> set-partition mem0 -tvolatile
>         100% to volatile

yup.

>
> set-partition mem0 -tvolatile -s256MB
>         256MB to volatile
>         Remainder to pmem
>
> set-partition mem0 -s256MB
>         256MB to pmem
>         Remainder to volatile

Yup, thanks for going through the examples to clarify.
