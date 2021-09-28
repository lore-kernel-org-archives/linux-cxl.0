Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AEEC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 04:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B432610E5
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 04:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhI1EbM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Sep 2021 00:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhI1EbH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Sep 2021 00:31:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CBAC061575
        for <linux-cxl@vger.kernel.org>; Mon, 27 Sep 2021 21:29:29 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y5so10843065pll.3
        for <linux-cxl@vger.kernel.org>; Mon, 27 Sep 2021 21:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bux2UC4gmVK8sgqyQaj+pj7DS3MR8lrC8qn375nurio=;
        b=joB9SBxhvLJx0umhFhgvk7bWN5ROoNGT1Ajtt1JQb3mJiezrtpTH3JiZ1A5fkGv5mY
         viUnAHZlA+ZspQBVBvpi/CZOJPCIwvlC14NnK1p7MFdp2w1+q0SSqrWw1+24XS+aaRl7
         KsGKtkvsHu0XokBz3Lz94yUZLP3HWi1uF48/fJyShpvIaw7gQqlvDtGzoV3JPsvMbJEn
         54X6uXjkhZ7ke2YiJwOYIsy5IK+ZaK8pTTUjHEI9LXMThOgvXy0rbBnrfE5UYG5mCDbC
         zbNWvpnjXDacROgHoEUzz61qmyMth6OTU46PMbdRceLn1lbBnn/AHKxCv/bAs2/zjIvn
         sfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bux2UC4gmVK8sgqyQaj+pj7DS3MR8lrC8qn375nurio=;
        b=IiVGiSX9Gk4O9v052crLORK4syHwqiFpfU4w1V3AZ10ApqjO9RMXxF1I1lWpnEmxWX
         AajshtlSviBXu5GKQRyyo9pRIi+QIudRqqXWEVcDbNwVeFEz7G6ECImLaz94wMdJBz3P
         qYO0NiuyakGv25H/dqWMBtbbAvaEZTOYzr0wOc4JaZlGDvoBybdbxOOKigmRnR0mXDTa
         4AM0LvnH6vml3IKxn+XJjp0ejNwCQI3by2bV2TU7XR+Gc5ClIuvOKdwmbVQbDXX+RR1y
         6rz4Ez5Pg0NWXP3khJwwRf9rLZ0MEEx9iCNZA7TEY+HOl71VIOw41KBGgMJMgdAzkNZU
         7VwQ==
X-Gm-Message-State: AOAM532La2rvZ7kZnNfho9ncMRPxUGRoz+ZESKazGKZfNV/E+kMvk3qV
        EvQFOwr29q9dqiCip+1eGOfbHoBxWyHZGgKj0vTpsmBr7z/u3g==
X-Google-Smtp-Source: ABdhPJwDnD8a/7DyUmXzGG7dnYGxspHpUGt4HiKDHvr/jo0/8cOOKGpgRaLs4cmox+AFtli3DJp6PAgV1jvxkx4ekes=
X-Received: by 2002:a17:902:bd8d:b0:13a:8c8:a2b2 with SMTP id
 q13-20020a170902bd8d00b0013a08c8a2b2mr3135341pls.89.1632803368538; Mon, 27
 Sep 2021 21:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210924212817.489801-1-ben.widawsky@intel.com>
 <CAPcyv4gsVCoaqX81q57XZSAOqQmdLbdruGGxBpOk59nNRn+hXg@mail.gmail.com>
 <20210927224522.gvybo3nhbgqhjbwo@intel.com> <CAPcyv4gmsmtOap8jwu7zEC6K1PCeTGSwRwEHKbBGksRERdCUnQ@mail.gmail.com>
 <20210928000605.eh5yiqdkty45z6px@intel.com> <CAPcyv4gAJBV8Z3Xfi+R+DL6x3LXoOtHkcnsewU6Ru8YmH-bfSQ@mail.gmail.com>
 <20210928002124.wgwss44ygjjeaaej@intel.com> <20210928003233.fo2ddlinveg66rm5@intel.com>
 <CAPcyv4hCv9iZjeQPMsbBV1PP2eH04h=mjDXtPbLqo_S+MN8CZw@mail.gmail.com> <20210928032331.a5du2o2gxs54bvd7@intel.com>
In-Reply-To: <20210928032331.a5du2o2gxs54bvd7@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 27 Sep 2021 21:29:16 -0700
Message-ID: <CAPcyv4j9EmTYSyz4Ee=K7gvv2rtS4_E=pfqKixUwE9Q56ag+8A@mail.gmail.com>
Subject: Re: [RFC PATCH] cxl: switch usp to parent cxl_port
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 27, 2021 at 8:23 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> > > -int enumerate_ports_from_root_port(struct cxl_port *root_port)
> > > +int enumerate_ports_from_root_port(struct cxl_dport *root_port)
> > >  {
> > > -       struct device *d = root_port->uport;
> > > +       struct device *d = root_port->dport;
> > >         struct cxl_walk_context ctx;
> > >         struct pci_dev *pdev;
> > >
> > >         if (!dev_is_pci(d))
> > >                 return -ENODEV;
> > >
> > >         pdev = to_pci_dev(d);
> > >         ctx = (struct cxl_walk_context){
> > >                 .dev = d,
> > >                 .root = pdev->bus,
> > > -               .port = root_port,
> > > +               .port = root_port->port,
> >
> > Per-above why would match_add_switches() care about this port once it
> > walks down a level in the tree?
>
> I thought you wanted the host of every new port to be either the hostbridge or
> the cfmws root port.

The host is the device that owns the devm context. I was thinking the
natural device for hosting the whole CXL port hierarchy is the device
that registered the root cxl_port, the ACPI0017 platform device. I
expect It would just be passed in directly to this 'enumerate' helper.
Although, it's more 'rescan' than 'enumerate'.
