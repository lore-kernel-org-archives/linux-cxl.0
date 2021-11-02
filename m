Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93C8C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 18:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D2360EBC
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 18:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhKBSMv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbhKBSMu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Nov 2021 14:12:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F88AC061714
        for <linux-cxl@vger.kernel.org>; Tue,  2 Nov 2021 11:10:15 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id m21so113185pgu.13
        for <linux-cxl@vger.kernel.org>; Tue, 02 Nov 2021 11:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZgUhzxBiEaxEuiGAE9P8NFRbCrcQoWMZ9N3Z6TohlQ=;
        b=oL/pPZs+1AY+ZUK+hJqg5Qe6l7Tg7tcZWqGTguAa5znMhChGf/zH4wDk/NoTOj/Pxm
         1AYtBXwkjEueFTKE7Sm3iM8eAmJX6QUnvz2viBN4Atu/MI5T1c1eNBo17mGwW86NqpR5
         8F7lM2WpqwNqweGKBEWtZbiB77GGzSAEi/MwsXG/NgX12l4qTVOax7jcGtwp9nyOBh9w
         /GF3DUnD44XeSSV+LgoWGKdM46j9hGMAYr4jE0YU2xueFw2xx64BJw4/weTsQ0T982kT
         1UMo3NJ7lRVMk3rtJQybhukfzyJhNzUU/0gCrut6xTzyFmptu823ZHwHyxgtlQ/ZkO5g
         2aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZgUhzxBiEaxEuiGAE9P8NFRbCrcQoWMZ9N3Z6TohlQ=;
        b=TZeetbogSG1oBfxNhMSRbIRc41Gk18yXPG4QUq56pY4Zwe4I+Lrt+UKRLXo9NJnOrk
         3N8kPHLkHVYsivGTQsy1O3FC/SZbAmsdDNizrRHyNpuOUvqj64VYZneNsyd5UsW/EBzY
         HIq1b9BVZOXewb1Trp6+lu/qVjzKHfldAI4TXpkpXHJsBM9QO5+8UQgQydmYtpmb045j
         6/N1NC8MDkfUC3km6b05O2FZC1VPWhdlPgc12hoWZ9khIPQnvMVAXLwWvomaEiwHw9tW
         AyF8d9mxMYNSpqHMFFHUiG+bkGBCet2jmtoGHyl0gp2D9hwoij2Uu60Vs8AKN7q4y14B
         LKhA==
X-Gm-Message-State: AOAM531oUUvDh2pzpJ6EWFs7iFytk2fwlYsFlmd1ctde3GVwAfG7QeJ+
        Hw7pkMnu1R6gQ1wuU270nqPt2aaAPFqKmD+9ZErhRw==
X-Google-Smtp-Source: ABdhPJw4Mm1s0PMNeUq8RwgZZmBXqvCm21qd0fQYpNVFFItwx1XKI2T6qFkm84DsdElwitiX8e5wgVDsmpRVn5sykUE=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr15750695pgd.377.1635876615170;
 Tue, 02 Nov 2021 11:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-10-ben.widawsky@intel.com> <CAPcyv4j+mv3+FyJd0OVBe_dUqzzYpS2gkEagiRp-Tqh9t7NMmg@mail.gmail.com>
 <20211101170750.sajcmjxdv5rajffe@intel.com> <CAPcyv4i-8oRjOPywtNwBef3irb8b44PzwBrEUdQ0Bxrzrju5+w@mail.gmail.com>
 <20211102163121.hyfj7yceainmppmk@intel.com> <CAPcyv4iQzHeF8cth4VGGMpAT-3d6T=6knCq5fnt+Yt1ucxbW8Q@mail.gmail.com>
 <20211102175737.k7l4yymx75kdvgwv@intel.com>
In-Reply-To: <20211102175737.k7l4yymx75kdvgwv@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 2 Nov 2021 11:10:05 -0700
Message-ID: <CAPcyv4iNaTmJJ-vgPRMtUO9_xbB0TTTVcrm4gm8m1wMzbfK4NQ@mail.gmail.com>
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

On Tue, Nov 2, 2021 at 10:57 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-11-02 10:46:41, Dan Williams wrote:
> > On Tue, Nov 2, 2021 at 9:31 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > [..]
> > > It seemed like a very simple thing to support given the port driver's existence
> > > so it was added to remove a TODO. However, I will drop it as you request.
> >
> > I'm honestly asking the question why this is needed and more
> > specifically why this is needed in this location?
> >
> > In other words, how is this case different than typical component
> > register probing that is done in the port driver itself? I would
> > expect the TODO just gets deleted by the port driver addition.
>
> Without this code, a decoder is added for the full address range regardless if
> there is an existing programmed HDM decoder. With this code when the port driver
> probes this host bridge HDM component registers, everything will be enumerated
> by the normal flow.
>
> This seemed easier than trying to have the port driver determine what cxl_acpi
> driver did and unwind that if there is a programmed decoder.

I think this is more an argument to unify all decoder creation in the
port driver. When the port driver sees a single dport with no HDM
decoder registers it can create the passthrough decoder, if it sees
single dport with HDM decoder registers then it can create a
programmable decoder.
