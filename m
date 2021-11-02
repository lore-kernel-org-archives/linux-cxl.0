Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EE3C433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 18:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C106C60E54
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 18:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhKBSwC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhKBSwA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Nov 2021 14:52:00 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B52C061714
        for <linux-cxl@vger.kernel.org>; Tue,  2 Nov 2021 11:49:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x64so1977827pfd.6
        for <linux-cxl@vger.kernel.org>; Tue, 02 Nov 2021 11:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TwNxytMPVTZG/AeLkzOD4sMqQDlFN6ILnR3zgfU2iu0=;
        b=QLnfazdvlvcuhCrEeLj6KGc0HmQ2tf1EQwhV3tWzET0C4NdJw96ml35KGzmPttrn21
         /t34eykY3JMnBO6diCvlteFxUqAPeHYbgBuvLVTLd2jlHdsaOSygfGf98R8EwHMDNOy3
         uo2QA8YUj6AgBkg0AGyOF5EyArFkFWj13py3cyrzfk2bAtkDUG2z3wl1/C5JPjOHR2Rd
         ueJjD1P+UFX9t2yHeo14p8JJtLAYCiYNLXDgCVaAnLYL++9QcSBn8CIsb+JsSb9+5RUD
         gJVUDQcskdA6sFd9rTdkzXTziJiVPbtODMtGtzox3Wae61qsBgWn10SQEE7E3TF9KXlW
         ic0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TwNxytMPVTZG/AeLkzOD4sMqQDlFN6ILnR3zgfU2iu0=;
        b=1mKdjo3evc7ZGgzoYn3qTgB24xdlmU8sbu05dSHQU2aIiLZTmQY3jOieildTmbdUad
         0MqdR3WbuNSTfTJ4k8R0xWDG5DHKNL6Exr41OnsKru0kwn9l/7DklXEg9iXT3qdnxfvD
         J2r752uRBYO4TE+5HssRNKYsF06ngwNby0PAjHbn0qYyzW23ME39puXFYLSxX2Y/l5VT
         /NC65Q/FWfspNmsTWhzwzYNYYPmClvp9prCbHagnMBBLAtrenMp8KClNxFx1Fz3A5Qvw
         qNqLxX1pbhZ8nf1oJLI6hLZy8zAovvjirYiPZYahQA7DGNgjqhlYGErRxO2dd/ndj6AH
         cETA==
X-Gm-Message-State: AOAM531H1g0RA9FzJY5egwCn2ghaU7wiExkgJyhg/XPvOCDmWFSnI4LG
        EgzhX03NTDwmo1OLGvRQzKVh3dTw2mHFa+OoT4p9Xg==
X-Google-Smtp-Source: ABdhPJyybvQJLsq4slyqvd4T60smjuq1Qri8mA3JjFK+W5Fyhb1tVe89hDV/64PtU9LLm4gr8lOBsQN68J/sx5nm660=
X-Received: by 2002:a63:6bc2:: with SMTP id g185mr28908546pgc.356.1635878964706;
 Tue, 02 Nov 2021 11:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-10-ben.widawsky@intel.com> <CAPcyv4j+mv3+FyJd0OVBe_dUqzzYpS2gkEagiRp-Tqh9t7NMmg@mail.gmail.com>
 <20211101170750.sajcmjxdv5rajffe@intel.com> <CAPcyv4i-8oRjOPywtNwBef3irb8b44PzwBrEUdQ0Bxrzrju5+w@mail.gmail.com>
 <20211102163121.hyfj7yceainmppmk@intel.com> <CAPcyv4iQzHeF8cth4VGGMpAT-3d6T=6knCq5fnt+Yt1ucxbW8Q@mail.gmail.com>
 <20211102175737.k7l4yymx75kdvgwv@intel.com> <CAPcyv4iNaTmJJ-vgPRMtUO9_xbB0TTTVcrm4gm8m1wMzbfK4NQ@mail.gmail.com>
 <20211102182715.p5odqlr2z7z3n6go@intel.com>
In-Reply-To: <20211102182715.p5odqlr2z7z3n6go@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 2 Nov 2021 11:49:14 -0700
Message-ID: <CAPcyv4j0yi7utGR2UcG99_i0TH4j23QyryiYxOvZ6BosP=WEhQ@mail.gmail.com>
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

On Tue, Nov 2, 2021 at 11:27 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-11-02 11:10:05, Dan Williams wrote:
> > On Tue, Nov 2, 2021 at 10:57 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 21-11-02 10:46:41, Dan Williams wrote:
> > > > On Tue, Nov 2, 2021 at 9:31 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > [..]
> > > > > It seemed like a very simple thing to support given the port driver's existence
> > > > > so it was added to remove a TODO. However, I will drop it as you request.
> > > >
> > > > I'm honestly asking the question why this is needed and more
> > > > specifically why this is needed in this location?
> > > >
> > > > In other words, how is this case different than typical component
> > > > register probing that is done in the port driver itself? I would
> > > > expect the TODO just gets deleted by the port driver addition.
> > >
> > > Without this code, a decoder is added for the full address range regardless if
> > > there is an existing programmed HDM decoder. With this code when the port driver
> > > probes this host bridge HDM component registers, everything will be enumerated
> > > by the normal flow.
> > >
> > > This seemed easier than trying to have the port driver determine what cxl_acpi
> > > driver did and unwind that if there is a programmed decoder.
> >
> > I think this is more an argument to unify all decoder creation in the
> > port driver. When the port driver sees a single dport with no HDM
> > decoder registers it can create the passthrough decoder, if it sees
> > single dport with HDM decoder registers then it can create a
> > programmable decoder.
>
> That too, though I'm not sure how useful that will be for us.

?

This is about the proper place to enumerate decoders. The proposal in
this patch is to do some part of the enumeration in cxl_acpi and some
part in cxl_port, I'm saying push it all to cxl_port. I.e. it was a
layering violation in retrospect to create a default passthrough
decoder from cxl_acpi.

> I think the more
> likely case is BIOS is trying to hide some device (or switch) address space.

Not sure why that is relevant for the decision about where to place
component register probing and passthrough decoder creation?
