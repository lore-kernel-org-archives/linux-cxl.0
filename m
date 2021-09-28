Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECC0C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 01:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A16661156
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 01:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbhI1BLh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Sep 2021 21:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhI1BLg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Sep 2021 21:11:36 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F5BC061575
        for <linux-cxl@vger.kernel.org>; Mon, 27 Sep 2021 18:09:58 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n2so12991032plk.12
        for <linux-cxl@vger.kernel.org>; Mon, 27 Sep 2021 18:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CxJNUWPJvjxPaZpkYuLpm+YSVaNHwjxYSRsxvSOdpLo=;
        b=y6zbcsL2olsAH4Tsgh4CsK2a6kMvgvI5wgElI0DH5CgDZx9bqof6YzxW90Km/CPqQ0
         t6tPazEgpG8OepvXOG1xWiZm6mRtet1e0YLZdL+iQFZ7av65A03Ms7vJB/jhL2p5w1Fq
         HqembniF3j6P8zKINmvwBhRTGtz+3kUwC+C1uskuPWqTtwI0YpoI1xJx/MlgO7V/Jc5S
         4OIAtyiVdmoASuVbhzmz4lBT5qrfFcVL0sL3KvS60OiQyshfIM8UAawHqbLUPDmds0Km
         CN+iFlxyNn0Wm2i6YN9auzXM8WjoXwXHYxF8VbEk2zLjPWk0raeO3YvyeBSClif+1SsA
         WdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CxJNUWPJvjxPaZpkYuLpm+YSVaNHwjxYSRsxvSOdpLo=;
        b=XKY8gpRChRc6R4lwKf8mVV7drOZ8/wFU2Y4SO6tMjNx2F3MNi9Fr7Hk9vtAcHhrGgt
         /iucm/T6OyuasEapDI8VtGF11lDaTebvLoHhBH4T2NH9R4gCtKnJgYkMbpzMnJOvHnkk
         HcAvtO7obGBR1m+U4wlkPtrrELpQW7wDa2LVd7OP1N5QDs2z90qQT+RYtoP3xCp9I2fa
         XKY62PZsl4HnSkv8Tacw8F9+THhGF0wtBdKUFkgj+0rqCgC+miWLbXPgvGgr9ymbcG5c
         Tx6kAUlmLgc/c6YUNlAqY2q8+felQfBr53M+Qt25K0TPTO2tZri2+Oh+p1JvOquSvdC6
         OVeg==
X-Gm-Message-State: AOAM531Jb9YWn1mr5hbsVu06dlRspXTAfjQY2KWjtm+UUAJqHTiyjom8
        4EPnw/YgW1WMd4RpEpCkIS4Cci9+Hq4lMkdFNZRmRA==
X-Google-Smtp-Source: ABdhPJxS3VxpzuWTXpbfmf5O6LhDAL4nA7pr1+TUh3NKNOcBCeoKUcKYOgIYtVYZ1qiskuE/0HddXWx2sV++XojLLW0=
X-Received: by 2002:a17:902:e80f:b0:13b:721d:f750 with SMTP id
 u15-20020a170902e80f00b0013b721df750mr2545769plg.18.1632791397917; Mon, 27
 Sep 2021 18:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210924212817.489801-1-ben.widawsky@intel.com>
 <CAPcyv4gsVCoaqX81q57XZSAOqQmdLbdruGGxBpOk59nNRn+hXg@mail.gmail.com>
 <20210927224522.gvybo3nhbgqhjbwo@intel.com> <CAPcyv4gmsmtOap8jwu7zEC6K1PCeTGSwRwEHKbBGksRERdCUnQ@mail.gmail.com>
 <20210928000605.eh5yiqdkty45z6px@intel.com> <CAPcyv4gAJBV8Z3Xfi+R+DL6x3LXoOtHkcnsewU6Ru8YmH-bfSQ@mail.gmail.com>
 <20210928002124.wgwss44ygjjeaaej@intel.com> <20210928003233.fo2ddlinveg66rm5@intel.com>
In-Reply-To: <20210928003233.fo2ddlinveg66rm5@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 27 Sep 2021 18:09:46 -0700
Message-ID: <CAPcyv4hCv9iZjeQPMsbBV1PP2eH04h=mjDXtPbLqo_S+MN8CZw@mail.gmail.com>
Subject: Re: [RFC PATCH] cxl: switch usp to parent cxl_port
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 27, 2021 at 5:32 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-09-27 17:21:24, Ben Widawsky wrote:
> > On 21-09-27 17:18:35, Dan Williams wrote:
> > > On Mon, Sep 27, 2021 at 5:06 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > [..]
> > > > > Per-above you probably want to start the scan below each root port, or
> > > > > otherwise filter out the top-level scan work that cxl_acpi owns.
> > > >
> > > > The scan will skip everything until it finds a USP or DSP which cxl_acpi
> > > > wouldn't be touching. I don't have any issue with:
> > > >
> > > > >         list_for_each_entry(dport, &root_port->dports, list)
> > > > >                 pci_walk_bus(dport->subordinate, match_uport, ctx);
> > > >
> > > > but I don't see any issue with the current code either. Did I miss something?
> > >
> > > if (pdev->bus != root_bus)
> > >     return 0;
> > >
> > > Doesn't that always fail for the switches in question? Did I miss
> > > where root_bus is updated?
> >
> > In my previous comment I meant that I'd drop this check, but I see what you're
> > saying now. I need to pick some subordinate bus or I'll just walk over all
> > switches, even ones I don't care about...
>
> Would this work?

Would need to see the whole patch in context, but I'm being thrown off
by the attempted reuse of 'struct cxl_walk_context'. That assumes that
the parent port is passed and only scans the top-level PCI bus.
Whereas for switches we're talking about walking all of them and using
something like find_cxl_port() to lookup parent ports as it goes.

>
> -int enumerate_ports_from_root_port(struct cxl_port *root_port)
> +int enumerate_ports_from_root_port(struct cxl_dport *root_port)
>  {
> -       struct device *d = root_port->uport;
> +       struct device *d = root_port->dport;
>         struct cxl_walk_context ctx;
>         struct pci_dev *pdev;
>
>         if (!dev_is_pci(d))
>                 return -ENODEV;
>
>         pdev = to_pci_dev(d);
>         ctx = (struct cxl_walk_context){
>                 .dev = d,
>                 .root = pdev->bus,
> -               .port = root_port,
> +               .port = root_port->port,

Per-above why would match_add_switches() care about this port once it
walks down a level in the tree?

>         };
>
>         pci_walk_bus(pdev->bus, match_add_switches, &ctx);
>
>         return 0;
>  }
>
>
