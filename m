Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D19C432BE
	for <linux-cxl@archiver.kernel.org>; Mon, 26 Jul 2021 18:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C5060F90
	for <linux-cxl@archiver.kernel.org>; Mon, 26 Jul 2021 18:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhGZRcI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhGZRcI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 26 Jul 2021 13:32:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE05C061757
        for <linux-cxl@vger.kernel.org>; Mon, 26 Jul 2021 11:12:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a20so12888641plm.0
        for <linux-cxl@vger.kernel.org>; Mon, 26 Jul 2021 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Is+oJKGYPogfWvFZwdYYCcoT9K1XBMrcjlf/DkpZH/E=;
        b=SBoRhGWQCq3eEDgd91yc6ADhSEjR/yadrM0vCz81C2RTZDnLXZFmsm2OqRC++Vjwvx
         pPA6m1aLsANWdJPs1nMEppouQUZae6du+9kXo6vVjcckr3NxXjORLmPNJPcdLS7Kq9Co
         CYzZb918Yn6sjp/qNbRFeZHVTdYvZjndZjf718+CMKr/XNl1r6Kh5bvxpdFUjzy161e4
         GHyVK9DsRvie4hyBXqDuOuNfiYvPTB/PDNePRPdewToLpNiqxMM2CfR167NHuR4xkVkV
         076eytd9bxKuxK29EtGI9VzrGvxyrHJ8om7RYQIsndOLQcXYnRprymbEce8GgKPHjfcl
         Wbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Is+oJKGYPogfWvFZwdYYCcoT9K1XBMrcjlf/DkpZH/E=;
        b=r1J7yWi+PBj/JrolHvg+Xly86T0wMx/GWVih+5pjDRbIq4Uy5xaUfMPx7Ck08WDlml
         LRsRz0q+W0TPhPO4JK+ibdMn6DBzvSzCjHNDb3g8YuDP4TGhic92FkkNg3jvflx1j2Kf
         MBmRlhmxjn1omKgj9ahSSbMiE1zlDJX+JOUdMMhZNf2Ab/Kv4ExWODaAeqUPzh15KxrQ
         VDKSb7tPp8Dk2yrou2fMWwnOTBv+qL8ZElb7AvzAq/otOYKrdDE3kFVwGg2I3znW5VRR
         HwcYBJHaOxveLojfVtWTaM9D1GsFKmoAaIICsAGZtfKKJ4k/FNm21E6acPTY+zjmHx6G
         cebA==
X-Gm-Message-State: AOAM531SyBAPY7IvRDKnNURUsIqRjiaQU/yQCzzUa80Y/PYcwPm3bYEh
        xToCxObITJd0wdiL/fKKW8dphnuEUcbvMSFJtqnN0A==
X-Google-Smtp-Source: ABdhPJx5NqlOopCpzWLC2vibWWgD3XZcKkajAVM53ofepmQxyWlKDODoW+h05xfkA8DyckzoPpIhILOh0dWAtKmEOfY=
X-Received: by 2002:a17:90a:708c:: with SMTP id g12mr243492pjk.13.1627323156220;
 Mon, 26 Jul 2021 11:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210702040009.68794-1-ben.widawsky@intel.com>
 <20210706160050.527553-1-ben.widawsky@intel.com> <CAPcyv4g8XqzbwtSP3Hdww5nUvB9Hz--QL9Z_h56XfxTQMdMxmw@mail.gmail.com>
 <20210720234307.qacrosxfaogn5app@intel.com>
In-Reply-To: <20210720234307.qacrosxfaogn5app@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Jul 2021 11:12:25 -0700
Message-ID: <CAPcyv4jDua9e66e-h2fsEmAwQ_4vDyWbuKRSCU9RfAwECP5xUQ@mail.gmail.com>
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

On Tue, Jul 20, 2021 at 4:43 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
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
>
> How do you want me to handle the existing parent (ACPI0017) and child (ACPI0016)
> relationships? I see no reason to preserve this, but perhaps you know something
> I don't.

I'm not understanding the concern? ACPI0016 is already not a child of
ACPI0017. The decoder is a child of a port. ACPI0016 is a dport in a
platform decoder, and the uport for the CXL switch in the host-bridge.
