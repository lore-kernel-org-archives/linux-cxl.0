Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CBBC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 21:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5750610A0
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 21:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhJ2Vlx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhJ2Vlw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Oct 2021 17:41:52 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77FBC061570
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 14:39:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o10-20020a17090a3d4a00b001a6555878a8so75227pjf.1
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 14:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDtsmExLQJvxEdLb6lOYi16V0W5m6CnRAzX33MubWO8=;
        b=YJT6NLVRq8qHXplk5nowuFBt+pcOCHhc/+QYlxXruIwLrq4bxWNDrURIxE+njIWNPF
         kEJRWpHZp39ZtfYnGbfvQVrCeZJ5Uv9uCd5c/ahXkG6JPzA55oCIB7GaYxgPbBiurP9r
         PtbauLoIeMXTI1fGYbRvZ/Ne+kEQVde6Q/MxjmzaQO9C0xS08z3G5z7IsGfUkxZARCCD
         mGLYSvIxIrEXPSZ3dGuQlTaXPKFzkbFHDIsB9EXdJa6MRrcrRd46d+86g4206/XrPo4w
         XHoEOoCEoM9EAovpC/q9RP9FWFtWSnAg8ofM86zV6IaBngqxBglmrUt938xlJNbaD87p
         Rpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDtsmExLQJvxEdLb6lOYi16V0W5m6CnRAzX33MubWO8=;
        b=SjrEExNe2pf52uU3Occ5/dLTyxnVonL7devsn3iNpuQtBF+RtYcT7klPkZKISQFLuw
         2NAOwp4rfjRlfUQT2BOP+j88G8HHRgMAo7raT8+jAYXykms2bNpS3Qv7Sz19BHSSHHme
         lO76Dt+MdCti7EY8LhnKw7sAdfeKv4t/w5BAscSPsmMe52aUSyJkmubrGtw9AuJcIiTA
         B/cbEmbQ+EC4sAsTLgrH78o1Z5QQmXGJRFQCSltgAl5lzUbZFq0eLcC5uQAQTEHDKRSP
         UWC1VU3AyfkMjRIyTeZL8at2IyHLqCwXOnlVPWUcRlDLkcrIaIwqxZC2FCtsEeUf95K5
         nIww==
X-Gm-Message-State: AOAM530rLp0LyF+QUSBLjQgGfVWd0VFxUDpDyc2zjpJZQfUEp+SQWQvU
        uExdFNbhjqD50fUYcV1BpTtzzXopqb80vjXRdSzeUg==
X-Google-Smtp-Source: ABdhPJyWyJ0gEBlJrAd/UPZANNBGi5WoifwLo1Hh7jFn2/2gEvT4E36WQs14nPJchDhtcuabm8AJAFQKORbkh4e0TEM=
X-Received: by 2002:a17:90a:a085:: with SMTP id r5mr22365423pjp.8.1635543563198;
 Fri, 29 Oct 2021 14:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-2-ben.widawsky@intel.com> <CAPcyv4i_ZnMkTwOcg=94AO959Gzt1FFkirEO=FL3sjNcMsCAeA@mail.gmail.com>
 <20211029212042.so56mkjju3ja2k54@intel.com>
In-Reply-To: <20211029212042.so56mkjju3ja2k54@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Oct 2021 14:39:11 -0700
Message-ID: <CAPcyv4iY1zcfJgG1_XT5TPuwf4O_QkmwB1UG4U_z3p8s6adWEA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/28] cxl: Rename CXL_MEM to CXL_PCI
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 29, 2021 at 2:20 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-10-29 13:15:46, Dan Williams wrote:
> > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > With the upcoming introduction of a driver to control the non-PCI
> > > aspects of CXL.mem, such as interleave set creation and configuration,
> > > there will be an opportunity to disconnection control over CXL device
> >
> > s/disconnection/disconnect/
> >
> > > memory and CXL device manageability. CXL device manageability is
> > > implemented by the cxl_pci driver. Doing this rename allows the CXL
> > > memory driver to be enabled by a new config option independently of CXL
> > > device manageability through CXL.io/PCI mechanisms.
> >
> > That comes across a bit hard to parse to me, how about:
> >
> > "The cxl_mem module was renamed cxl_pci in commit 21e9f76733a8 ("cxl:
> > Rename mem to pci"). In preparation for adding an ancillary driver for
> > cxl_memdev devices (registered on the cxl bus by cxl_pci), go ahead
> > and rename CONFIG_CXL_MEM to CONFIG_CXL_PCI. Tree up the CXL_MEM name
>
> I assume you meant s/tree/tee - right?

Sorry, that should have been "Free"

>
> > for that new driver to manage generic CXL.mem endpoint operations."
> >
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  drivers/cxl/Kconfig  | 13 ++++++-------
> > >  drivers/cxl/Makefile |  2 +-
> > >  2 files changed, 7 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > > index e6de221cc568..23773d0ac896 100644
> > > --- a/drivers/cxl/Kconfig
> > > +++ b/drivers/cxl/Kconfig
> > > @@ -13,14 +13,13 @@ menuconfig CXL_BUS
> > >
> > >  if CXL_BUS
> > >
> > > -config CXL_MEM
> > > -       tristate "CXL.mem: Memory Devices"
> > > +config CXL_PCI
> > > +       tristate "PCI manageability"
> >
> > s/PCI manageability/CXL Memory Device: PCI Operations/
> >
> > ...as I don't think an end user reading "PCI Manageability" would know
> > that it supports basic memory expander enumeration and mailbox
> > operations.
> >
> > >         default CXL_BUS
> > >         help
> > > -         The CXL.mem protocol allows a device to act as a provider of
> > > -         "System RAM" and/or "Persistent Memory" that is fully coherent
> > > -         as if the memory was attached to the typical CPU memory
> > > -         controller.
> > > +         The CXL specification defines a set of interfaces which are controlled
> > > +         through well known PCI configuration mechanisms. Such access is
> > > +         referred to CXL.io in the specification.
> >
> > The CXL specification defines a "CXL memory device" sub-class in the
> > PCI "memory controller" base class of devices. Device's identified by
> > this class code provide support for volatile and / or persistent
> > memory to be mapped into the system address map (Host-managed Device
> > Memory (HDM)).
> >
> > >
> > >           Say 'y/m' to enable a driver that will attach to CXL.mem devices for
> >
> > This would need updating too...
> >
> > s/CXL.mem devices /generic CXL memory expanders identified by the
> > memory device class code/
> >
> > ...to reduce confusion about this driver for generic type-3 vs vendor
> > specific type-2 devices that also support CXL.mem
> >
>
> Overall seems like an improvement to me. I'm not too fond of the word "generic"
> though, both here and in the commit message. I think they work equally well just
> deleting that word.

Sure, and it's redundant with the mention of "class code".
