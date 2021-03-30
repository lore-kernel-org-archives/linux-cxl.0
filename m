Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D23C433E0
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 16:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE5B619CE
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 16:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhC3QGH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 12:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhC3QFk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 Mar 2021 12:05:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7E2C061574
        for <linux-cxl@vger.kernel.org>; Tue, 30 Mar 2021 09:05:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id dm8so18852846edb.2
        for <linux-cxl@vger.kernel.org>; Tue, 30 Mar 2021 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTeGm2gnR8rNNn47/dNZEpSnzYBxYfRGyQZfWrQAsf8=;
        b=ZHb2TD+dgtwnji5LAsp1IhPENr4lacW1qnMOoxxbfM8YGefGbHlkmsJHTCWm1Isc5h
         3dFj0DO6y6Gc2SzCYGgRr1YFNXi5A/sfDbDnhYQc/BJ2kEpYduz19pqbzdRPLonIexz3
         4t1/bo+XgyL5ftEk2ptbdOE5MCYw3uk1gZxxS8m3z1VBxRbVPudJeBWoTZmCqvGZ8M8H
         BEg9QvtmmX17wEzjoLRwtBxRAx5FoU4cFzt/7ZRI29dgyUP1fLLepm9+41F2ObBUek3f
         +P7CbC2B0Z0+bOnyg/hKIED4IJ55vmPFa0WeksGzn8ifI78PacfWREbtUAT4dGpW722E
         q45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTeGm2gnR8rNNn47/dNZEpSnzYBxYfRGyQZfWrQAsf8=;
        b=AH//gVPTyeplflp39IXi1leRE7pLYjvWcRMxNNrCMsIGyM7qzkdTXwi7Me193pSARH
         vd8FEKz3+X1aGZYyUjNQBj4ZhwN/bFGpWGwujV/fx2h/MED5JEHvGFOigABxUi5rRLLK
         s7brI4y5wOsYJWnaST4zD9sWM/wp7MEvhoRKKtDHzJvyHgvP3WRrxxt9nlm7rXdzBPQ4
         j48xg04FDxAp4gGysm6CE7PZUm4U0L9L/BH6b8/azzUzPo4GCe1DcXEPw496qa/yhrB9
         K1oHxZcyU4P3TOsHcj6VekSpzBUFsw3rFu2AZRPLUrIljew++QlphNbDUDZPsZ/qY41w
         Fd+A==
X-Gm-Message-State: AOAM5325VfzFUTVqkUfthua4i3CTbRpJjx8ByrqoDf/4ojust9FfyN7d
        0+Lxrh08EdRpMVsrDVu/a8aCw6E+BAjclcHs7oUZNA==
X-Google-Smtp-Source: ABdhPJxC7G1pNlaBw24vWX+kFubWjOR+3cklTPNbBUUSYS6/zQNmx3KnYPbP+NBgGCk3VhAePo3/FV4g1Rh06wRFstE=
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr34511651edw.348.1617120339206;
 Tue, 30 Mar 2021 09:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210330111620.GK2356281@nvidia.com> <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
 <20210330154712.GR2356281@nvidia.com>
In-Reply-To: <20210330154712.GR2356281@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Mar 2021 09:05:29 -0700
Message-ID: <CAPcyv4hL-B=1hostoj9t6EE5impmcDR2-wsgahvBKdzL9LbqLg@mail.gmail.com>
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

On Tue, Mar 30, 2021 at 8:47 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Mar 30, 2021 at 08:37:19AM -0700, Dan Williams wrote:
> > On Tue, Mar 30, 2021 at 4:16 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Mon, Mar 29, 2021 at 07:47:49PM -0700, Dan Williams wrote:
> > >
> > > > @@ -1155,21 +1175,12 @@ static void cxlmdev_unregister(void *_cxlmd)
> > > >       struct cxl_memdev *cxlmd = _cxlmd;
> > > >       struct device *dev = &cxlmd->dev;
> > > >
> > > > -     percpu_ref_kill(&cxlmd->ops_active);
> > > >       cdev_device_del(&cxlmd->cdev, dev);
> > > > -     wait_for_completion(&cxlmd->ops_dead);
> > > > +     synchronize_srcu(&cxl_memdev_srcu);
> > >
> > > This needs some kind of rcu protected pointer for SRCU to to
> > > work.. The write side has to null the pointer and the read side has to
> > > copy the pointer to the stack and check for NULL.
> > >
> > > Otherwise the read side can't detect when the write side is shutting
> > > down.
> > >
> > > Basically you must use rcu_derference(), rcu_assign_pointer(), etc
> > > when working with RCU.
> >
> > If the shutdown path was not using synchronize_rcu() then I would
> > agree with you. This usage of srcu is also used to protect dax device
> > shutdown after talking through rwsem vs srcu in this thread with Jan
> > and Paul [1]. The syncrhonize_rcu() guarantees that all read-side
> > critical sections have had at least one chance to quiesce.
> >
> > So this could either use rcu pointer accessors and call_srcu to free
> > the object in a quiescent state, or it can use synchronize_srcu()
> > relative to a condition that aborts usage of the pointer.
>
> synchronize_rcu doesn't stop the read side from running it. It only
> guarentees that all running or future read sides will see the *write*
> performed prior to synchronize_rcu.
>
> If you can't clearly point to the *data* under RCU protection it is
> being used wrong.

Agree.

The data being protected is the value of dev->kobj.state_in_sysfs. The
read-side is allowed to keep running, and the syncrhonize_rcu()
guarantees that any read-side that saw state_in_sysfs == 1 has had a
chance to complete. Future reads terminate the ioctl at the
device_is_registered() check.

> Same as if you can't point to the *data* being protected by a rwsem it
> is probably being used wrong.
>
> We are not locking code.

Agree.
