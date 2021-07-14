Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D84C11F66
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jul 2021 18:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09408613C1
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jul 2021 18:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhGNS4m (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238941AbhGNS4m (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jul 2021 14:56:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80969C06175F
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jul 2021 11:53:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id j3so1919913plx.7
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jul 2021 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ON3G2Z6IWRorYbI97FcTafr8gCZT6sggkTN1icobpk=;
        b=pkDZFtRLQwbBtNqMZyPA1OmkeOUvPmbFoAzp0UMvyyanmkFouYVfZom/abUYk+MjC6
         0NsKbNFt5/8XDgUDCFSYeOYyYsiwhdAAaaN7dw8QXLrmmVZ9LftqfAiFJOHDBvXHqJfT
         VUVTX/3u7IPk+kT9iZwtODwuXo7+5SzMJ7JdqIBpyCpuf0tfz7odFsH+PpZnQ8R4KX/O
         C6ymQX0+Oi0TcSxuVkXdCYj2qBlcLS3AXKbatfV8xtedl3ulQi+GJNwi1AsGagPp4UeZ
         UeeE1z4yuaqNpo5KZZGeFJDMd584PRDm+lS7rwUSvQHIIwYBtP2v31KZ8KC3wGNe1/ar
         4tIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ON3G2Z6IWRorYbI97FcTafr8gCZT6sggkTN1icobpk=;
        b=da0O/I+1RraSDIv/ew/oIz5HVqFS4w34QU7x6jtmUaP/jlvnOTOHQPXsGT78+vvuov
         Omq2VJH89fLvTYFGMrXsmzkLw10hiM5pKrp13efjhkMj/12mQuiBJnGc/cdulAGR+0J8
         aNLBxZLHDc0yLDRABN9yGxqLE75E6p8tAvLHOFRg/tbmpR5Q0DebqHuxlMrj5RcvgjqJ
         n1NnSByIu00MhV8Z3uHvn7/rTfskICvDSkVHJGlwICMTttwAqZ+ghvBTMvBS94ifkIDC
         ZnicXwewZqYlWpseQW+WVO6gcLFD2kWZSkzjrKATri61fcx3QaWVJjpIU3yPwfReyBbn
         0Tcw==
X-Gm-Message-State: AOAM533NwxvEjaP/Gc9frPAQw2XY5idjWKlLhrFvclwpOyCdecmE5qzP
        MJTZmZil8GNdXo4C9Rg2ow0QjQaA6wQEG9AYkEIesIy6Myc=
X-Google-Smtp-Source: ABdhPJyuGQ9xsCXZvs6+UQ6iAMwgNXhSfTcIqqM4AhaRqRxyRQ1LvNcFDPJPswtUyBOmcdyHxDHKS3BNHr0JcLDv5mU=
X-Received: by 2002:a17:90a:2f63:: with SMTP id s90mr5030539pjd.168.1626288829940;
 Wed, 14 Jul 2021 11:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <162586035908.1431180.14991721381432827647.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87mtqo68e4.fsf@vajain21.in.ibm.com>
In-Reply-To: <87mtqo68e4.fsf@vajain21.in.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 14 Jul 2021 11:53:39 -0700
Message-ID: <CAPcyv4jjv=VMLdHx-vJb5b5NOZHQY=_qzJ5Ym+zNa9A22zj9Qg@mail.gmail.com>
Subject: Re: [ndctl PATCH 0/6] Convert to the Meson build system
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jul 14, 2021 at 11:47 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > Autotools is slow. It is so slow that it takes some of the joy out of
> > hacking on the ndctl project. A fellow developer points out that QEMU
> > has moved to meson, and systemd has moved as well. An initial conversion
> > of ndctl to meson shows speed gains as large as an order of magnitude
> > improvement, and that result motivates the formal patches below to
> > complete the conversion.
> >
> > Given that this change breaks scripts built for automating the autotools
> > style build, the old autotools environment is kept working until all the
> > meson conversion bugs have been worked out, and downstream users have
> > had a chance to adjust.
> >
> > Other immediate benefits beside build speed is a unit test execution
> > harness with more capability and flexibility. It allows tests to be
> > organized by category and has a framework to support timeout as a test
> > failure.
> >
> > ---
> >
> > Dan Williams (6):
> >       util: Distribute 'filter' and 'json' helpers to per-tool objects
> >       Documentation: Drop attrs.adoc include
> >       build: Drop unnecessary $tool/config.h includes
> >       build: Explicitly include version.h
> >       test: Prepare out of line builds
> >       build: Add meson build infrastructure
> >
>
> With the patch-series got working builds for ndctl/daxctl on ppc64le using meson/ninja
> Hence,
>
> Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>

Thanks!
