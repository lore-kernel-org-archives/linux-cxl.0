Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96F3C11F65
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Jun 2021 17:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DB861446
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Jun 2021 17:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhF3RwM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Jun 2021 13:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhF3RwM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Jun 2021 13:52:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71DDC061756
        for <linux-cxl@vger.kernel.org>; Wed, 30 Jun 2021 10:49:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso1911670pjp.2
        for <linux-cxl@vger.kernel.org>; Wed, 30 Jun 2021 10:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDYXs/AtZsS1H+0cQkzhuXfDa2bv5e9wluBlvDyz1fs=;
        b=WRys+F/gnADEJY2cuH77GbDGN84iLLewMrviWO+qmdqVnOBPt0SxJnUNhNNeTfxhsa
         rbVxSZ37jc4iKxHQOETuFN1ES9r6Sipogi0ZNAHoA7v0+UdzePOD2XzxPYRqg0NDcD8i
         hFsFfTDEXyrctwaQL7iRZbe7A3sdg944RawQ7kwZu4m35RUMaJ7KNW6u5k+cK8gfddz+
         fEslLA00RwX7eYIcSn3Dz9dMyOCI7wJLFkP5Zic5ZQ9XROgGCYW/5jGczrnp+/TzOXkE
         UnPINoQ6UvqraYzggyPhYWvrJZxX14q712ZHFY4txqLuVt6p5ghSMCWYhR9ZrIklMyLk
         RNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDYXs/AtZsS1H+0cQkzhuXfDa2bv5e9wluBlvDyz1fs=;
        b=KGRi7kau3Mr6tTy3U2jdviGv13EevjwrmkqbMl62Z/xy+fTCuA4YDXEGLtLh4m04fN
         GyqR0DCYCYNTojNcWh6qhR52pRhLRnbPNQ5RBG7diCCCMc11YBcUoOkJnjtLLiSJFOT+
         Qr1Y/c/sZNPl4KZgBZQfV02jZUp4Imibko6INlwoISa5meFcQQgWZYfxmM4uicBZ2pCb
         /40Ls/XjRpyu0W/CwqFjPxXFlkwFrmLQp9eL+4uK8U/pVr/jod5hoQ3afTc0kFanHTGm
         xN3wGFNY4+PLkjdc9GYLPLbvqUfuIDFlcHQyxRDnX4DBYDbteuKHRK6fs12AVcNKxh4W
         oQhg==
X-Gm-Message-State: AOAM531BmKqI+ejI0T5YkUYurHeaQCzxIRihdiq0WBkfwP6Qzum9QwOr
        Bah3MmB1lSQqLLTbn5xb1s7pKVuuNcNGP5EbpfTkFg==
X-Google-Smtp-Source: ABdhPJxIxxLQB3e5xk+xKxYF+eUPSQxHBPWuvWL2j9G1fmEwHqmFyAS/cEJqAPvVKJfjQfVS9SqeFNIeoeGseMbyTao=
X-Received: by 2002:a17:902:b497:b029:115:e287:7b55 with SMTP id
 y23-20020a170902b497b0290115e2877b55mr32836164plr.79.1625075383024; Wed, 30
 Jun 2021 10:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210618005200.997804-1-ben.widawsky@intel.com> <20210618152721.00006b71@Huawei.com>
In-Reply-To: <20210618152721.00006b71@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 30 Jun 2021 10:49:32 -0700
Message-ID: <CAPcyv4jP05cCFjwWAeSfpURBWaGoRPxfzN0VBk5mASQgCWf3JQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Introduce memdev driver
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jun 18, 2021 at 7:27 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 17 Jun 2021 17:51:55 -0700
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > The concept of the memdev has existed since the initial support for CXL.io
> > landed in 5.12. Here, supported is furthered by adding a driver that is capable
> > of reporting whether or not the device is also CXL.mem capable. With this, the
> > region driver is able to consume these devices for programming interleave (or
> > x1) sets. Unlike the region driver, no explicit sysfs interaction is needed to
> > utilize this driver.
> >
> > The logic encapsulated here checks two things:
> > 1. The device itself is CXL.mem enabled.
>
> Need comments in relevant places to say checking if it is enabled,
> not capable.
>
> > 2. The device's upstream is CXL.mem enabled [1].
> >
> > What's currently missing is for the cxlmem driver to add the device as an
> > upstream port (since it has HDM decoders). I'm still working out those details.
> > HDM decoder programming still remains undone as well, and isn't pertinent to
> > this series perse.
> >
> > The patches are based on top of my region patches [2].
> >
> > The code itself is pretty rough for now, and so I'm mostly looking for feedback
> > as to whether or not the memdev driver is serving its purpose and checking what
> > needs to be checked on bind. If however you come along something glaringly bad,
> > or feel like reviewing not fully tested code (I know it builds), by all means...
>
> :)
>
> >
> > [1]: This series doesn't actually add real support for switches which would also
> > need to make the determination of CXL.mem enabling.
>
> Any plans to do the QEMU stuff needed for a switch?  I guess it's going to get
> messy if you want the hdm decoders to 'work' but should be fairly trivial to make them look
> plausible from an interfaces point of view.

It's already the case that the stack is modeling host bridges as
devtype 'cxl_decoder_switch' objects. So, I was hoping we, linux-cxl@
community, could convince ourselves that the algorithm that works for
the default 'cxl_decoder_switch' in the hierarchy can apply generally
to N layers of those. That said, it still would be nice to exercise
that case, but I don't see QEMU getting there anytime soon. I'm taking
a look at modeling a CXL hierarchy with kernel mocked resources for
this purpose.
