Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2BAC433E1
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 21:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5CA619CA
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 21:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhC3VBO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 17:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhC3VA5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 Mar 2021 17:00:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2376C061762
        for <linux-cxl@vger.kernel.org>; Tue, 30 Mar 2021 14:00:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jy13so26888645ejc.2
        for <linux-cxl@vger.kernel.org>; Tue, 30 Mar 2021 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eSzLg2RKbnYeMq4eRahVBhcZV/UV1n8+MtGZY4WiZyk=;
        b=F+UxR0U+QUxOokXex86/w/bqbr6b+HWOOXm/3v/msCAlchrCogarEfIO8EUbul+fX7
         vbyifbrl3mzbp0pC/13AJwItk4a/ijyTVChVtAbmcZ45FCPFjuOsGu2s+W2pbmrOqAab
         CNXDLht/0vG7n068uTB69OQNqDi7OqTv80VlsWIvHQbaJtJEoMusLrgVRr8iFRIwcv66
         GCfrM5/6YY2DWd2qFPPceth/CQSeNUziwDjNZ+Ds1LHiP6vR33FsuZ/EYPbsB6LtEaFK
         AEJEI0fsGjcUhRR9A+KySNF3HXN/JTT++TrOvShmlr9Up6ybzlI57UDlSgieN7qVkjdF
         M9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSzLg2RKbnYeMq4eRahVBhcZV/UV1n8+MtGZY4WiZyk=;
        b=OO1MqZbYObO6S158CcPTmV6+RAXKzhWx5CXYK+6AupwDI9swABHrGJ3m4ljDFbhicu
         2gYIXUHLdTvF8IOx9DPQ7vrU5CdSF4/opah3zJmWUE+EyiXpBfDYVha4uG/EZRnJIfAt
         UCqUVsF1oPb7ogusmaSv4gs/ZiShEg3CFg4eaaCOC+lZ4ExlfqwYfg2RPlLK4cPOFpsc
         mVLD3RNadSgw7sdrxYlSQpDv9KzAGI3A4Uk48POCSbPE7akyLSSMYE7yyOI/e4yrgnQV
         BKXg8PTb46KjU/+on5RKipXvrh3yZ23DpnB283M/BcM6dKSPmyBchlcQtCRC+DqdE5xm
         M15A==
X-Gm-Message-State: AOAM531MPuw0Ip9X3zC86A40f833esGa13A2kiLRR00eVwPyt1Hc4Ni9
        kDwDWTM7xWFJgFm6wa0gLviZ10n42KGJbS5uRWffyA==
X-Google-Smtp-Source: ABdhPJzXpCWkJa9HeMzf9uIeo/Qjunq0oMB5Tb7yizfS1AbYDAYqs2YCc7D6y7hGbREpu63FWinYsrtM/ZPzEz6yhvY=
X-Received: by 2002:a17:906:1386:: with SMTP id f6mr20784ejc.45.1617138055494;
 Tue, 30 Mar 2021 14:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210330111620.GK2356281@nvidia.com> <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
 <20210330154712.GR2356281@nvidia.com> <CAPcyv4hL-B=1hostoj9t6EE5impmcDR2-wsgahvBKdzL9LbqLg@mail.gmail.com>
 <20210330170253.GU2356281@nvidia.com> <CAPcyv4ixD=+PejHErT_FLtEyXsm4mk+93R7mQ0uFtd_kd-fs1w@mail.gmail.com>
 <20210330175431.GX2356281@nvidia.com> <CAPcyv4igMvwfZNgi-Uap_QUJi+uocMUD3KZBhXUy56AuHZQtqw@mail.gmail.com>
 <20210330192608.GA1430856@nvidia.com> <CAPcyv4h1qgQAP1JT88rWOf9xZz_1o2yPvMFETNY2dFn17uFwhw@mail.gmail.com>
 <20210330195143.GB1430856@nvidia.com>
In-Reply-To: <20210330195143.GB1430856@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Mar 2021 14:00:43 -0700
Message-ID: <CAPcyv4gwha+fgLbW_LCqRhRtC+N6Ws2Cnmv==C661ccv5GoOdQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] cxl/mem: Fix synchronization mechanism for device
 removal vs ioctl operations
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 30, 2021 at 12:52 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Mar 30, 2021 at 12:43:15PM -0700, Dan Williams wrote:
>
> > Ok, so this is the disagreement. Strict adherence to the model where
> > it does not matter in practice.
>
> The basic problem is that it is hard to know if it does not matter in
> practice because you never know what the compiler might decide to do
> ...
>
> It is probably fine, but then again I've seen a surprising case in the
> mm where the compiler did generate double loads and it wasn't fine.
>
> Now with the new data race detector it feels like marking all
> concurrent data access with READ_ONCE / WRITE_ONCE (or a stronger
> atomic) is the correct thing to do.
>
> > > > There's no race above. The rule is that any possible observation of
> > > > ->state_in_sysfs == 1, or rcu_dereference() != NULL, must be
> > > > flushed.
> > >
> > > It is not about the flushing.
> >
> > Ok, it's not about the flushing it's about whether the store to
> > state_in_sysfs can leak past up_write(). If that store can leak then
> > neither arrangement of:
>
> up_write() and synchronize_srcu() are both store barriers, so the
> store must be ordered.
>
> It is the reader that is the problem. This ordering:
>
> > down_write(...):
> > cdev_device_del(...);
> > up_write(...);
>
> Prevents state_in_sysfs from being unstable during read as the write
> lock prevents it from being written while a reader is active. No
> READ_ONCE needed.
>

Ok, so another case where I agree the instability exists but does not
matter in practice in this case because the cxl_memdev_ioctl() read
side is prepared for the state change to leak into the down_read()
section. There's no meaningful publish/unpublish race that READ_ONCE()
resolves here. With the read-side prepared for instability it obviates
needing to hold a lock over cdev_device_del() which would entangle
this locking dependency unnecessarily with all the other operations
that cdev_device_del() performs.

Again though I appear to be spilling bytes explaining specific
mitigating circumstances. I anticipate your response to the assertion
that holding a lock over cdev_device_del() is too broad would be to
move the synchronization away from device object state and towards the
specific dependency that needs to remain stable for the execution of
the ioctl. So registration path does:

cxlmd->cxlm = cxlm;
down_write(&cxl_memdev_rwsem);
up_write(&cxl_memdev_rwsem);
cdev_device_add(...);

...unregistration path does:

down_write(&cxl_memdev_rwsem);
cxlmd->cxlm = cxlm;
up_write(&cxl_memdev_rwsem);
cdev_device_del(...);

...and then no unstable state of the ->cxlm reference leaks into the
read-side that does:

down_read(&cxl_memdev_rwsem);
if (!cxlmd->cxlm) {
    up_read(&cxl_memdev_rwsem)
    return -ENXIO;
}
...
up_read(&cxl_memdev_rwsem);

...and no need to debate locks held over cdev_device_del() to resolve
instability.
