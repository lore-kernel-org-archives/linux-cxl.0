Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B49BC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 13 May 2022 19:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiEMTPF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 May 2022 15:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiEMTPE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 May 2022 15:15:04 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDF21156
        for <linux-cxl@vger.kernel.org>; Fri, 13 May 2022 12:15:03 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id v11so8479765pff.6
        for <linux-cxl@vger.kernel.org>; Fri, 13 May 2022 12:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8QWs9D7fbumOnkm1+CCLVtD36AcpCOypoLWKCjuOeew=;
        b=XdzCIVbsb+J6LsOyN7l3zHi7vMFHI2LR3C4OmZ4RhWpMHo2T4pYz3QzG+IORz0UYeI
         zkRBqxQyNcwVR5PZ8fWRcqEqiGJ8QJ2GnoUzhUM3sS+9b3p6C/HB/FrfcDuG/fEh8Aer
         u6jx9DWRPngC4OjNcMJhETGhU+u2G9v+pbzVSlTju+mKaobyQtW0iSmuTRX/OxUXRywk
         EKvFPaVcPkyz5o64/yZZqjlUyaXvBfYRe6zMkJP0cv2tdgFEe3dC9O7ewu7dqFBb8+WM
         lNQsjGj2AcS4qOYcffRxd23qLTw8/HGehGHTG7HFm4+0e9CVelm2CxthdYJNTueHE93l
         e1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8QWs9D7fbumOnkm1+CCLVtD36AcpCOypoLWKCjuOeew=;
        b=GYEWgXUj3DwCZKNEBSUCxk7Fis8ddbM/z7+kud/F+3fIxrTi5YdkbQ2eDDtQfUuWtX
         lVA1z+k4JvS08J7DhLrkFViDKCDTKaUM5y8hbJOXzQ6cRyVb6BuBlDjRf6L/JTDt9ZE7
         RAEZL+Uba9PPYmINUyNU/fuCO3/gMmxRXjgFDP47Lltx665EAiD1O8Yv3sqcOFWrElul
         XvAOEAvADXv24dLlnRSmJrvgDu8IT1Y4ZOfV3uduspZUsMHqWzOs7II+BKBy8CYxXxV0
         QEt89ezjR203BuFZWJqZn87MJUgBWZkuK7jVDD1rvoUab6sx8QdVUV6r5zFOQfekAAYc
         nIFQ==
X-Gm-Message-State: AOAM5315AGfgjbI+i9XO6lJVcOcMhqVDl9/i0YBZGR84ISPME1dyaG9v
        K3X00K+msJLnqKZ/+b+KCKQNb0H2dzYpTvl5lINdSQ==
X-Google-Smtp-Source: ABdhPJyVfOVoNgeRTRNCy4GT5YX/vEqfEzWBaDSBald7zJ2ikwL5p3rhi80jAPZKVpGGZmJohQZPl7OQuc+Sfo0Xnt8=
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id
 bk3-20020a056a02028300b00342703e1434mr5090420pgb.74.1652469302641; Fri, 13
 May 2022 12:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220413183720.2444089-1-ben.widawsky@intel.com>
 <20220413183720.2444089-3-ben.widawsky@intel.com> <CAPcyv4hKGEy_0dMQWfJAVVsGu364NjfNeup7URb7ORUYLSZncw@mail.gmail.com>
 <CGME20220418163713uscas1p17b3b1b45c7d27e54e3ecb62eb8af2469@uscas1p1.samsung.com>
 <20220418163702.GA85141@bgt-140510-bm01> <20220512155014.bbyqvxqbqnm3pk2p@intel.com>
 <Yn1DiuqjYpklcEIT@bombadil.infradead.org> <20220513130909.0000595e@Huawei.com>
 <Yn51WhjsC1FDKNfS@bombadil.infradead.org>
In-Reply-To: <Yn51WhjsC1FDKNfS@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 13 May 2022 12:14:51 -0700
Message-ID: <CAPcyv4gwi1gr-_XTV9z5aZ-HJ=J5gDonQk0_M-_U9yYDqqi3PQ@mail.gmail.com>
Subject: Re: [RFC PATCH 02/15] cxl/core/hdm: Bail on endpoint init fail
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Klaus Jensen <its@irrelevant.dk>, Josef Bacik <jbacik@fb.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, May 13, 2022 at 8:12 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, May 13, 2022 at 01:09:09PM +0100, Jonathan Cameron wrote:
> > On Thu, 12 May 2022 10:27:38 -0700
> > Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > > On Thu, May 12, 2022 at 08:50:14AM -0700, Ben Widawsky wrote:
> > > > On 22-04-18 16:37:12, Adam Manzanares wrote:
> > > > > On Wed, Apr 13, 2022 at 02:31:42PM -0700, Dan Williams wrote:
> > > > > > On Wed, Apr 13, 2022 at 11:38 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > > > >
> > > > > > > Endpoint decoder enumeration is the only way in which we can determine
> > > > > > > Device Physical Address (DPA) -> Host Physical Address (HPA) mappings.
> > > > > > > Information is obtained only when the register state can be read
> > > > > > > sequentially. If when enumerating the decoders a failure occurs, all
> > > > > > > other decoders must also fail since the decoders can no longer be
> > > > > > > accurately managed (unless it's the last decoder in which case it can
> > > > > > > still work).
> > > > > >
> > > > > > I think this should be expanded to fail if any decoder fails to
> > > > > > allocate anywhere in the topology otherwise it leaves a mess for
> > > > > > future address translation code to work through cases where decoder
> > > > > > information is missing.
> > > > > >
> > > > > > The current approach is based around the current expectation that
> > > > > > nothing is enumerating pre-existing regions, and nothing is performing
> > > > > > address translation.
> > > > >
> > > > > Does the qemu support currently allow testing of this patch? If so, it would
> > > > > be good to reference qemu configurations. Any other alternatives would be
> > > > > welcome as well.
> > > > >
> > > > > +Luis on cc.
> > > > >
> > > >
> > > > No. This type of error injection would be cool to have, but I'm not sure of a
> > > > good way to support that in a scalable way. Maybe Jonathan has some ideas?
> > >
> > > In case it helps on the Linux front the least intrusive way is to use
> > > ALLOW_ERROR_INJECTION(). It's what I hope we'll slowly strive for on
> > > the block layer and filesystems slowly. That incurs one macro call per error
> > > routine you want to allow error injection on.
> > >
> > > Then you use debugfs to dynamically enable / disable the error
> > > injection / rate etc.
> > >
> > > So I think this begs the question, what error injection mechanisms
> > > exist for qemu and would new functionality be welcomed?
> >
> > So what paths can actually cause this to fail?
>
> If you are asking about adopting something like the failmalloc
> should_fail() strategy in qemu, you'd essentially open code a call to
> a should_fail() and in it pass the arguments you want from your
> own call down. If you want to ignore size you can just pass 0
> for instance.
>
> > Looking at the upstream
> > code in init_hdm_decoder() looks like there are only a few things that
> > are checked.
>
> If you mean in Linux, you would open code a should_fail()
> specific to the area as in this commit old commit example, and
> adding a respective kconfig entry for it:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a8b6502fb669c3a0638a08955442814cedc86b1
>
> Eech of these knobs then get its own probability, times, and space
> debugfs entries which let the routine should_fail() fail when the
> parameters set meet the criteria set by debugfs.
>
> There are ways to make this much more scalable though, but I had not
> seen many efforts to do so. I did start such an approach using debugfs
> specific to *one* kconfig entry, for instance see this block layer proposed
> change, which would in turn enable tons of different ways to enable failing
> if CONFIG_FAIL_ADD_DISK would be used:
>
> https://lore.kernel.org/linux-block/20210512064629.13899-9-mcgrof@kernel.org/
>
> However, at the recent discussion at LSFMM for this we decided instead
> to just sprinkle ALLOW_ERROR_INJECTION() after each routine. Otherwise
> you are open coding tons of new "should_fail()" calls in your runtime
> path and that can make it hard to review patches and is just a lot of
> noise in code.
>
> But with CONFIG_FAIL_FUNCTION this means you don't have to open code
> should_fail() calls, but instead for each routine you want to add a failure
> injection support you'd just use ALLOW_ERROR_INJECTION() per call.

So cxl_test takes the opposite approach and tries not to pollute the
production code with test instrumentation. All of the infrastructure
to replace calls and inject mocked values is self contained in
tools/testing/cxl/ where it builds replacement modules with test
instrumentation. Otherwise its a maintenance burden, in my view, to
read the error injection macros in the nominal code paths.

> Read Documentation/fault-injection/fault-injection.rst on
> fail_function/injectable and fail_function/<function-name>/retval,
> so we could do for instance, to avoid a namespace clash I just
> added the cxl_ prefix:

Certainly those would be good to use behind the mocked interfaces.
