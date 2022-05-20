Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A584C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 20 May 2022 15:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243036AbiETPh7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 May 2022 11:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350891AbiETPh6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 May 2022 11:37:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D539D05C
        for <linux-cxl@vger.kernel.org>; Fri, 20 May 2022 08:37:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i1so7667377plg.7
        for <linux-cxl@vger.kernel.org>; Fri, 20 May 2022 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqeiI/7vhG2ub3w04cBZvW6Ap5WsemzUG12oj+4DA/I=;
        b=WuNx7l2NISSZOxlCsi+09Nj6LDX8yDQD7hPRIEkNijKtu+uWjWY+AH68YEIug4L+LR
         XZc3PtQ57OQKFPsri/zYLlNlaQ6ZtwxXpGLHVUJ9vyisA2v+76uOUqhJq8JY/HNMwmJz
         PBP74atLr9VW8BrpXW8slqVQ8dEsrcywyMCJEvCWrAICtNzsoUKl1XgfrSY93Y/bKeOG
         MOLZt+PAdg9WUkT5k4vimEJAA15wJXVGumL/h/QguLwidUtQXFSV/5trM7e7NOrLa1Hj
         JNLpmH2IIf5wM62lCCUtuI4CovypAtb6/Zu/THR3sA027PqcVBqjj3fcdca6X/YIri2u
         oU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqeiI/7vhG2ub3w04cBZvW6Ap5WsemzUG12oj+4DA/I=;
        b=FLGNSOwu3uRZ9U12COtRk9iQQOQ+vKkTEkHib0Q91ae6TvBpVk2QOKKq6aFnKFig7o
         WJjbKG2TJK7EGGsoJouZSEBxYe3RyGtFx3TYvznLDxaWvfeR5PptKuQ/BnaJmw+kYPr4
         eVvbOcKKYL81T46kEcpJSF8JXcQqmZWjUHll+TG0wghwyU/laGwnXffNHdXP0/pKA96N
         CXfbdhfWsRys92cOMDJEUCOe0HIV90mLfEWWJ3u9wJz5VUS/7ujlmFe7PjTUDum0DCe5
         oN9Rde9mQM7kOTNLtDcfP8d9EhSQdTXmjN2OMEabcz1iBxzzQu8ib6zowO9lbCO0HPLz
         4ZDQ==
X-Gm-Message-State: AOAM533yEywF+QRDQJx1qQubQSYcRK1HyX3hG8l8DCvm4Xu3AOpRDixm
        5yjAON5gvz6k/qObGIgmWR/v8z/wPp9lW6m3WUXl2o08qjc=
X-Google-Smtp-Source: ABdhPJweIVN4dvihbIGlOHjdQ/wzSfnFu055d5x1QnAq0lXCBWN+eyOhuY5EJM7Oigu+ugSitr35F6jot8sZIXVJ45o=
X-Received: by 2002:a17:902:ea57:b0:15a:6173:87dd with SMTP id
 r23-20020a170902ea5700b0015a617387ddmr10417526plg.147.1653061076530; Fri, 20
 May 2022 08:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de> <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de> <20220511191943.GB26623@wunner.de>
 <CAPcyv4hUKjt7QrA__wQ0KowfaxyQuMjHB5V-=rZBm=UbV4OvSg@mail.gmail.com>
 <20220514135521.GB14833@wunner.de> <YoT4C77Yem37NUUR@infradead.org> <20220520054214.GB22631@wunner.de>
In-Reply-To: <20220520054214.GB22631@wunner.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 20 May 2022 08:37:50 -0700
Message-ID: <CAPcyv4iWGb7baQSsjjLJFuT1E11X8cHYdZoGXsNd+B9GHtsxLw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gavin Hindman <gavin.hindman@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org, CHUCK_LEVER <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, May 19, 2022 at 10:42 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Wed, May 18, 2022 at 06:43:39AM -0700, Christoph Hellwig wrote:
> > On Sat, May 14, 2022 at 03:55:21PM +0200, Lukas Wunner wrote:
> > > Circling back to the SPDM/IDE topic, while NVMe is now capable of
> > > reliably recovering from errors, it does expect the kernel to handle
> > > recovery within a few seconds.  I'm not sure we can continue to
> > > guarantee that if the kernel depends on user space to perform
> > > re-authentication with SPDM after reset.  That's another headache
> > > that we could avoid with in-kernel SPDM authentication.
> >
> > I wonder if we need kernel bundled and tightly controlled userspace
> > code for these kinds of things (also for NVMe/NFS TLS).  That is,
> > bundle a userspace ELF file or files with a module which is unpacked
> > to or accessible by a ramfs-style file systems.  Then allow executing
> > it without any interaction with the normal userspace, and non-pagable
> > memory.  That way we can reuse existing userspace code, have really
> > nice address space isolation but avoid all the deadlock potential
> > of normal userspace code.  And I don't think it would be too hard to
> > implement either.
>
> Just as a reminder, on resume from system sleep, IDE needs to be
> set up by pci_pm_resume_noirq() to comply with the existing assumption
> that a PCI driver's ->resume_noirq callback may access the device.
>
> At that point (device) interrupts are disabled, so it's not possible
> to e.g. read certificates from disk or perform an OCSP request.
> So the bundled userspace code would have to conform to a number of
> severe restrictions to avoid resume issues.

Recall that OS managed IDE is somewhat of a stop-gap / special case as
typically the OS kernel is outside of the platform trust boundary for
things like TDX. I imagine suspend in the presence of IDE would be
platform firmware managed, not OS managed. Certificate validation can
always move internal to the kernel later if a concrete need arises,
but it is difficult to go the other way, to kick out certificate
validation from the kernel if it proves not to be needed. Otherwise, a
ring3/ userspace helper that can live in non-pageable memory to avoid
scenarios like this sounds like a capability that would be worth
having regardless.
