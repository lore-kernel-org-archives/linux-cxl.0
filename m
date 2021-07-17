Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10667C636C9
	for <linux-cxl@archiver.kernel.org>; Sat, 17 Jul 2021 22:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7AA61106
	for <linux-cxl@archiver.kernel.org>; Sat, 17 Jul 2021 22:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhGQWVS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 17 Jul 2021 18:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhGQWVR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 17 Jul 2021 18:21:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD751C061762
        for <linux-cxl@vger.kernel.org>; Sat, 17 Jul 2021 15:18:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x16so7491389plg.3
        for <linux-cxl@vger.kernel.org>; Sat, 17 Jul 2021 15:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+iPgkN9cHYikZba6rrUHbLTujjsNwMj/MAIN7Qobig=;
        b=KZauvZ28mixLIVsLS52jEdBBAOM/S/CJu+BtNny5q/tUaTfoM2NUx+C+4abwpsFv+9
         78kczTlZVMWTdAbvB5MV0Dju57UP/9PGGKCZAr6XkXQzkLNLVXH5qo+cCqNSN5mgVomz
         87DmRT2z72b5UZaur0nHFvNGRBmGifyz/+CU+DytTenu4QtWsIU0RisBaJnkDqRYdEOP
         7OfcFvvRJsEbo4bwtoCkHuX+s++z/Wm2QD8NkxKaizTXDsdyEppGypku+KZnSCRbDNle
         j7xy/4a3amvfUz1bLRmxAGJ4wyrb5W777GHNxZoX4nnaIJ12/rwWOb3kgMLYCcEN8Rog
         Oy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+iPgkN9cHYikZba6rrUHbLTujjsNwMj/MAIN7Qobig=;
        b=UjHOtO3MozC+ivGn2QIE4AiAx8rqPMKNP1rPwKv0ybE2GFfJgj12TS5TXdJ66iljYk
         54q1vIpgw8wuDcUGBn/Cm1QskB/5cud+vWR4ErJZ5tqxNpn0LDRRBOxLxvvqkSVZ3a+0
         CbPqFuOPfvg+K9TS+bOn063QOauk/YQcfLi5R0cXLJvB2Z2a0GtzuqzbcfDamPIx+nUK
         SEJ/Wcyhzy0vQpEbB0OUUzlOYSgwIq6IWZraUyU5N5CYsOxgQHNawiUymcOvklAYZEHS
         qOnmuSLYetSxMgeaZKN7HrOBRUjB1KLzAb3CODgPxDqbAzvi59JRBvuPC/mmdW04W3dY
         1JBw==
X-Gm-Message-State: AOAM5321we8N/uu29mZ+myMGqJCdj/nwit21An3Qug7UpJh3/zFOrOdS
        tIhmqgayxf0aPVe9rgaf0+ptc56CY2wjC4577yOIVA==
X-Google-Smtp-Source: ABdhPJzeoK0CSYcGFrFmRTb9wxLZ9nIxoyzzoVgHNwsFKznHe+MXcHQaf7OvSAM7y/+JnJHKuHSn/p0ylcbXT8LrSIU=
X-Received: by 2002:a17:90a:f40a:: with SMTP id ch10mr11582193pjb.149.1626560300105;
 Sat, 17 Jul 2021 15:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210702040009.68794-1-ben.widawsky@intel.com>
 <20210706160050.527553-1-ben.widawsky@intel.com> <CAPcyv4g8XqzbwtSP3Hdww5nUvB9Hz--QL9Z_h56XfxTQMdMxmw@mail.gmail.com>
 <20210716233726.26gfctyxvtpyr2na@intel.com>
In-Reply-To: <20210716233726.26gfctyxvtpyr2na@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 17 Jul 2021 15:18:09 -0700
Message-ID: <CAPcyv4j5828yFpQR3O1iWBmS1Yd4QbUeXLXy=hwXTx9iTSwnxA@mail.gmail.com>
Subject: Re: [PATCH v2] cxl: Enable an endpoint decoder type
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jul 16, 2021 at 4:37 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-07-09 16:56:48, Dan Williams wrote:
> > On Tue, Jul 6, 2021 at 9:01 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > CXL memory devices support HDM decoders. Currently, when a decoder is
> > > instantiated there is no knowledge of the type of decoder; only the
> > > underlying endpoint type is specified. In order to have the memory
> > > devices reuse the existing decoder creation infrastructure it is
> > > convenient to pass along the type of decoder on creation.
> > >
> > > The primary difference for an endpoint decoder is that it doesn't have
> > > dports, nor targets. The target is just the underlying media (with
> > > offset).
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >
> > > v2 Fixes target_type and stores the decoder type on instantiation
> >
> > This depends on the memdev driver series? It's not applying for me on
> > top of cxl.git#next.
> >
>
> Weird, it shouldn't. All my other branches depend on core-reorg work, where
> core.c isn't a thing anymore. Would you like to get this in shape before the
> core rework? I think git should dtrt, but it might be easier to merge that
> first.

Yeah, I think it logically makes sense to finish off the core
representation of ports before enabling them.

>
> > >
> > > diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> > > index 196f260e2580..69acdd230f54 100644
> > > --- a/drivers/cxl/core.c
> > > +++ b/drivers/cxl/core.c
> > > @@ -493,10 +493,11 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
> > >                         .start = base,
> > >                         .end = base + len - 1,
> > >                 },
> > > +               .type = type,
> >
> > ...but there's already the dev->type?
>
> Good point. It's redundant.
>
> >
> > >                 .flags = flags,
> > >                 .interleave_ways = interleave_ways,
> > >                 .interleave_granularity = interleave_granularity,
> > > -               .target_type = type,
> > > +               .target_type = CXL_DEVICE_EXPANDER,
> >
> > In the cxl-switch case how to indicate that only type-2 targets are supported?
> >
> > I do think I misnamed the cxl_decoder_type. I also did not make it
> > clear that root decoders don't have a target type, they have a set of
> > flags indicating their restrictions, and unlike switch level decoders
> > they can support targeting both accelerators and expanders in the same
> > windows. I think the decoder can still be just the dev->type, but
> > there needs to be separate helpers for the 3 cases you have
> > identified. Something like the following where devm_cxl_add_decoder()
> > because private to the core:
> >
> > devm_cxl_add_platform_decoder(struct device *host, int nr_targets,
> >                               resource_size_t base, resource_size_t len,
> >                               int interleave_ways, int interleave_granularity,
> >                               unsigned long flags)
> > {
> >         return devm_cxl_add_decoder(host, NULL, nr_targets, base, len,
> >                                     interleave_ways, interleave_granularity,
> >                                     0, flags);
> > }
> >
> > devm_cxl_add_switch_decoder(struct device *host, struct cxl_port *port,
> >                             enum cxl_decoder_type type)
> > {
> >         return devm_cxl_add_decoder(host, port, 0, 0, 0, 0, 0,
> >                                     CXL_DECODER_UNKNOWN, 0);
> > }
> >
> > devm_cxl_add_endpoint_decoder(struct device *host, struct cxl_port *port,
> >                               enum cxl_decoder_type type)
> > {
> >         return devm_cxl_add_decoder(host, port, 0, 0, 0, 0, 0, type,
> >                                     CXL_DECODER_F_ENDPOINT);
> > }
> >
> > ...where 0 values are filled in by the decoder driver init or N/A.
> > Presumably the memdev driver calling devm_cxl_add_endpoint_decoder()
> > will know whether it is an expander or an accelerator. Although given
> > there are no CXL accelerator drivers on the horizon, maybe even that
> > degree of freedom can be hidden for now.
> >
> > Then the dev->type determination is:
> >
> > platform => no parent cxl_port
> > switch => parent cxl_port and flags does not have CXL_DECODER_F_ENDPOINT
> > endpoint =>  parent cxl_port and flags has CXL_DECODER_F_ENDPOINT
> >
>
> I'm definitely in favor of being more explicit.

The exported function names are not explicit enough?

The thought is that the baseline devm_cxl_add_port() becomes static
and private to the core.

> Are you opposed to having the
> helper set the type and getting rid of endpoint flag? I think it's a little
> non-idiomatic, but I do prefer it stylistically.

The endpoint flag is to disambiguate switches vs endpoints...

>
> ie.
> devm_cxl_add_endpoint_decoder(struct device *host, struct cxl_port *port,
>                               enum cxl_decoder_type type)

...but type is CXL_DECODER_{PLATFORM,SWITCH,ENDPOINT}, what does this
function do when it is passed anything CXL_DECODER_PLATFORM? My
original intention for 'type' was 'expander' vs 'accelerator' since
switch decoders exclusively support one or the other.

> {
>         struct cxl_decoder *cxld;
>
>         cxld = devm_cxl_add_decoder(host, port, 0, 0, 0, 0, 0, type, 0);
>         if (!ret)
>                 cxld->dev.type = &cxl_decoder_endpoint_type;

Unfortunately this is too late as dev->type is in use immediately upon
device_add().
