Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3F4C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 02:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B1B60EE3
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 02:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhKBCST (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 22:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhKBCSS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Nov 2021 22:18:18 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05723C061714
        for <linux-cxl@vger.kernel.org>; Mon,  1 Nov 2021 19:15:45 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id b4so11723256pgh.10
        for <linux-cxl@vger.kernel.org>; Mon, 01 Nov 2021 19:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/v+n9U6urF9NOqSaS7CIVF/jfwiV4vr2FpotjIQrbcY=;
        b=HTO8716DluFUGlP8PRditv8qClBcqPAiae5piTeZKSJYpfJPSX8xhYU0U5eUtZ6p/j
         OLN57y6s2+tlMzJVthw2fb1LLBotK6nBp9cA1K005luwpY/taw/r4WAI16Lmv/6D+U1d
         NxnDQglJsIjdQc2Yp1a0XA6JdzyG0isVnB8tLKjXX0GrEhCjOoRAAouI2BolwFvIA91v
         0DtwSw4KIrXzeCDk6UsAQL+LAzPrIJKpvWiylrJ7lXpRDrcY0g5i+J9TnMiXPnII9iaj
         uF11BOSMTuthfwOIb2TOyq31V7Nsht175etObO8q72sltJExjo57j5bYinN1gWcI6DYJ
         C1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/v+n9U6urF9NOqSaS7CIVF/jfwiV4vr2FpotjIQrbcY=;
        b=HE/Yx88e9KnHUtOtvk301z9OjnP79VOQt/FctX/MU25LNnAI0sQU2vJnMrFhhwA2I/
         omYFcb7SjT29h6SJohk5nPk9y1Brb1xrK3v1PVe+GRZBU0aQbIOOD4ADMa/lhwm+fY0H
         TVDGr09aqfj+YnTtR/nBca7EydRodLFukIE5YJYbyfMmqZItIAEoGcc7/qN+Xnsc96K4
         UHAQVJxm4iuOsFp+rrMOnD9YxB5xmHuE2Uh1Z2IHWsa0ebD6GSM9j5rYNIv2nj1MPtXc
         sFjBXvkr2K4i6gkSooMYMWcaUvJ6cRlE54xBfK/MJGuBSe77LL4gCvbXrkIR/iSF76Lf
         A69Q==
X-Gm-Message-State: AOAM53397v+oGZ+RHe4KdrT6vmpTg1ED1bQjtN2g3GGwU+71YqJ/A/cY
        gLEiSw2Y3wkerrYiFtazUHgfXzj3+PLpZHlYbDU5pg==
X-Google-Smtp-Source: ABdhPJy+hbvFIQC9mYyrRh0Io2TCmwbaSCE9NFmHMS6K9hMUef9RmVYzgqbCteujizMoQhhCYSEcgVNQ4l3p/Deql0I=
X-Received: by 2002:a63:6bc2:: with SMTP id g185mr24884239pgc.356.1635819344574;
 Mon, 01 Nov 2021 19:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-10-ben.widawsky@intel.com> <CAPcyv4j+mv3+FyJd0OVBe_dUqzzYpS2gkEagiRp-Tqh9t7NMmg@mail.gmail.com>
 <20211101170750.sajcmjxdv5rajffe@intel.com>
In-Reply-To: <20211101170750.sajcmjxdv5rajffe@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Nov 2021 19:15:33 -0700
Message-ID: <CAPcyv4i-8oRjOPywtNwBef3irb8b44PzwBrEUdQ0Bxrzrju5+w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/28] cxl/acpi: Map single port host bridge
 component registers
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

On Mon, Nov 1, 2021 at 10:08 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-10-31 11:03:37, Dan Williams wrote:
> > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > Now that the port driver exists and is able to do proper decoder
> > > enumeration of the component registers, it becomes trivial to use that
> >
> > This is the second occurrence of "becomes trivial" in this series,
> > it's distracting because it immediately sets off alarm bells that the
> > changelog is not in:
> >
> > Background
> > Problem
> > Solution
> >
> > ...format.
>
> Let me make sure I understand.
>
> Background: Now that the port driver exists...
> Problem: host bridge uports can use the port driver [but don't yet]
> Solution: This patch (the description is indeed missing).
>
> Is your point that I didn't document a solution, or something else?

Why do single port host bridge registers need to be mapped?

Why does the cxl_acpi driver need to do it and not the just introduced
port driver?

This patch seems to be saying, map these because they can be mapped.

>
>
> >
> > > for host bridge uports. For reasons out of scope, a functional change
> > > would be visible if the HDM decoder was programmed by BIOS to values
> > > other than the full address range. Similarly if a type2 device was
> > > connected to this root port and programmed by BIOS, that can now be
> > > acted upon accordingly.
> >
> > I would reserve discussion of "no functional change" for patches that
> > are pure cleanup. In this case this patch will cause the kernel to
> > behave differently when other conditions are met.
>
> True. I will remove that.
>
> >
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  drivers/cxl/acpi.c | 25 ++++++++++++++++++++++++-
> > >  1 file changed, 24 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index d61397055e9f..8cca0814dfb8 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -280,12 +280,14 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> > >         struct cxl_port *root_port = arg;
> > >         struct device *host = root_port->dev.parent;
> > >         struct acpi_device *bridge = to_cxl_host_bridge(host, match);
> > > +       struct cxl_component_reg_map map;
> > >         struct acpi_pci_root *pci_root;
> > >         struct cxl_walk_context ctx;
> > >         int single_port_map[1], rc;
> > >         struct cxl_decoder *cxld;
> > >         struct cxl_dport *dport;
> > >         struct cxl_port *port;
> > > +       void __iomem *crb;
> > >
> > >         if (!bridge)
> > >                 return 0;
> > > @@ -318,10 +320,31 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> > >                 return -ENODEV;
> > >         if (ctx.error)
> > >                 return ctx.error;
> > > +       /*
> > > +        * If the host bridge has more than 1 root port, it must have registers
> > > +        * controlling the HDM decoders. Those will be enumerated by the port
> > > +        * driver.
> > > +        */
> > >         if (ctx.count > 1)
> > >                 return 0;
> > >
> > > -       /* TODO: Scan CHBCR for HDM Decoder resources */
> > > +       /*
> > > +        * If the single ported host bridge has a component register block,
> > > +        * simply let the port driver handle the decoder enumeration.
> > > +        *
> > > +        * Host bridge component registers live in the system's physical address
> > > +        * space.
> > > +        */
> > > +       crb = ioremap(dport->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
> >
> > This looks broken, the driver for the port should be mapping dport
> > component registers to offer services to upper layers.
> >
> > There's also a missing iounmap.
> >
>
> Where's the missing iounmap?

Oops, sorry, don't know why I missed that. Forgive the noise.

> The port driver does what you say, but I need a way
> to shortcircuit the case where the root port doesn't have component registers
> which you've previously documented as allowed by spec. How would you recommend
> doing that?

Perhaps cxl_port_probe() needs to special case the single dport case
and just say, "no registers needed, single port == HDM passthrough".

Until there's a need to look at non-HDM registers I'd hold off on
enabling this case. Probably that comes soon when considering IDE
support, but no need to pre-enable that yet.
