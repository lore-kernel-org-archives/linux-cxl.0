Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFECC433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 21:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6504461100
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 21:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhKBVhF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Nov 2021 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhKBVhF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Nov 2021 17:37:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E373C061714
        for <linux-cxl@vger.kernel.org>; Tue,  2 Nov 2021 14:34:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o14so906939plg.5
        for <linux-cxl@vger.kernel.org>; Tue, 02 Nov 2021 14:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PxcE7U6fXb5xMTfi8tFDnTJlBlXpUw7inWmW8GvRAww=;
        b=7Vag5gMqy+cQWSRoGFqDFyrmDLo7V6j2y9yKzwhBhv7oszv/TjPXFCfGaUFJj3UxUt
         VcgaXC57woE5wRRF9x0y5Rv33dLCQlQHAAzd4Gi9NoVPbUx6uDKOF0LstBSZgMgbxW5F
         FQfFujdqajW4EwEkWl/B2w5adEIaVt+NRc9ws5HQEFTvxQe3ZBJkAILqTpqG16wqjU+4
         F8oPWfnycPDyDID8TExBXAwPyvdtNUXrPgxvrmXSMaqaEV7rfx5m4Ixp5m/jlM+tF/Wz
         0UUTc+m/Gy5ueEv5VrKxUy3oKbhOMYa2pTZtpoe9ERE+WdwQIFI7w7TQCtmz2fTH4xIl
         9IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxcE7U6fXb5xMTfi8tFDnTJlBlXpUw7inWmW8GvRAww=;
        b=4jX0wmK9sIruIlQrY4oCWa5sXQEoFkBzBI9Pi7EBdhyzrP704/Hnm+o5L9DTAf2o/9
         S4qUVlpeqngzJGoTZ21BlXGZiCeqXnloH7R5n0O11C3WH/wm+JhKvOtocBJzUXAi3YEM
         5N++4xYwtKkaQwxfl6bA+abBHo8BNZg3vLLqWN5MRIG5MGZClenmYPWQu2tpQDplr91/
         BAcC+5ls0KnUZFtvvp0wObZ/vZAdFTQNPstv7cAFS0nvuiNQAPkoKA7P/EWSTt1ywI8B
         cQ15/Hhac3RlS0nBTNxd90D7Ucck7aLFootSGdfeLEmQcSfhG648WxauchyglRwqe6Hs
         eNlg==
X-Gm-Message-State: AOAM532j6PprNkHm6UgYO1LJWdYCgmBFJy/+U+6WsJUOnCFv5ehIL/uq
        g3TXGiAArLyqYTNHsfvRKNWcX9eFtzTwditMEHH6Bg==
X-Google-Smtp-Source: ABdhPJwtOPf9exptqczW8eOYq37oJTJ1cbYKeCb5q7SCm14+xxd6Cz5xube/PY1FaeInOIx7n+W3Qn+SYzR2zIyvPYQ=
X-Received: by 2002:a17:90a:a085:: with SMTP id r5mr9796704pjp.8.1635888869923;
 Tue, 02 Nov 2021 14:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-10-ben.widawsky@intel.com>
 <CAPcyv4j+mv3+FyJd0OVBe_dUqzzYpS2gkEagiRp-Tqh9t7NMmg@mail.gmail.com>
 <20211101170750.sajcmjxdv5rajffe@intel.com> <CAPcyv4i-8oRjOPywtNwBef3irb8b44PzwBrEUdQ0Bxrzrju5+w@mail.gmail.com>
 <20211102163121.hyfj7yceainmppmk@intel.com> <CAPcyv4iQzHeF8cth4VGGMpAT-3d6T=6knCq5fnt+Yt1ucxbW8Q@mail.gmail.com>
 <20211102175737.k7l4yymx75kdvgwv@intel.com> <CAPcyv4iNaTmJJ-vgPRMtUO9_xbB0TTTVcrm4gm8m1wMzbfK4NQ@mail.gmail.com>
 <20211102182715.p5odqlr2z7z3n6go@intel.com> <CAPcyv4j0yi7utGR2UcG99_i0TH4j23QyryiYxOvZ6BosP=WEhQ@mail.gmail.com>
 <20211102211556.ingfag535md3z37y@intel.com>
In-Reply-To: <20211102211556.ingfag535md3z37y@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 2 Nov 2021 14:34:19 -0700
Message-ID: <CAPcyv4iTXJ=Ck2hR=KDBNwHtV+FF7RUFyq0YD+YuwtnhTF55yQ@mail.gmail.com>
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

On Tue, Nov 2, 2021 at 2:16 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-11-02 11:49:14, Dan Williams wrote:
> > On Tue, Nov 2, 2021 at 11:27 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 21-11-02 11:10:05, Dan Williams wrote:
> > > > On Tue, Nov 2, 2021 at 10:57 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > > > > On 21-11-02 10:46:41, Dan Williams wrote:
> > > > > > On Tue, Nov 2, 2021 at 9:31 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > > > [..]
> > > > > > > It seemed like a very simple thing to support given the port driver's existence
> > > > > > > so it was added to remove a TODO. However, I will drop it as you request.
> > > > > >
> > > > > > I'm honestly asking the question why this is needed and more
> > > > > > specifically why this is needed in this location?
> > > > > >
> > > > > > In other words, how is this case different than typical component
> > > > > > register probing that is done in the port driver itself? I would
> > > > > > expect the TODO just gets deleted by the port driver addition.
> > > > >
> > > > > Without this code, a decoder is added for the full address range regardless if
> > > > > there is an existing programmed HDM decoder. With this code when the port driver
> > > > > probes this host bridge HDM component registers, everything will be enumerated
> > > > > by the normal flow.
> > > > >
> > > > > This seemed easier than trying to have the port driver determine what cxl_acpi
> > > > > driver did and unwind that if there is a programmed decoder.
> > > >
> > > > I think this is more an argument to unify all decoder creation in the
> > > > port driver. When the port driver sees a single dport with no HDM
> > > > decoder registers it can create the passthrough decoder, if it sees
> > > > single dport with HDM decoder registers then it can create a
> > > > programmable decoder.
> > >
> > > That too, though I'm not sure how useful that will be for us.
> >
> > ?
> >
> > This is about the proper place to enumerate decoders. The proposal in
> > this patch is to do some part of the enumeration in cxl_acpi and some
> > part in cxl_port, I'm saying push it all to cxl_port. I.e. it was a
> > layering violation in retrospect to create a default passthrough
> > decoder from cxl_acpi.
>
> I think it makes sense to have cxl_decoder_add() not called from anything but
> the port driver. So long as there's a way to determine it's a CXL 2.0 Root Port,
> which, it seems we'll have, it should be straight forward.

Does it need to be root port aware? I expect any single ported switch
is treated the same, not that I expect single-ported switches to be a
real thing, but I don't expect our port driver would care.
