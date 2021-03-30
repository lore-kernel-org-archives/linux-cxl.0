Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A293FC433DB
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 19:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7CA619AB
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 19:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhC3Tne (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 15:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbhC3Tn1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 Mar 2021 15:43:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BE9C061574
        for <linux-cxl@vger.kernel.org>; Tue, 30 Mar 2021 12:43:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id dm8so19583539edb.2
        for <linux-cxl@vger.kernel.org>; Tue, 30 Mar 2021 12:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g3IJGSpa4V7kxQCCiNdS0yq+p2vQpiM9GPuBKrSVj54=;
        b=vOUdoK1PWlhj/aNxl5aoyoNnCu021/rOMrZTK4OK6qhKjx6ZY9ZTMprpwLM6aUHCA7
         L0cncH+g4f10YhaxVwCbAD46s1n+cLOuHWbfgiNvDRtiB/f2JQz7Rtjycw4CnTgcvtEs
         mpv4oQEanMuhdN1hAbKhxolFwMFr0u7Zn/bBMvBMQaGNjCclm3/FqH4I6nqsX+22gqZi
         zwAQr5iz/jPTmvKI0a33bbSsotX4Tpaybw+k4jPqvA/b4kTZzuwvKLtcRjpM2B7tO8fY
         hd+zdWQxqH7f0qu6MiIq+GakE6RUB+W3ZTadLhcSkHXpT6ZRXURyOPFYF5Bf8t9ZPCCH
         T6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3IJGSpa4V7kxQCCiNdS0yq+p2vQpiM9GPuBKrSVj54=;
        b=SGAp+RjUhgllSh2gy9eF3UR9MaNRzoiK3ATm5ZmQo0C7qGLEYa7nYJ7pl7S2sfzteZ
         TtUCJ0G66QKxtaGysAXJ1ajOARGcOQgc9aR59rbhL2/8NFdALCOBjB2uCHvqJ8MNXdVd
         b0JwIIQsulY5uQpoxJ8P958q6y6+BCukdYserSUqxR08k8Dxz2VpkvElB/fFt25tuiSE
         THSRRa3XZ9CnUxJRv7/2BZ1RK7ZMHFtvYkXNsmjWTDVqoMok1TkHCpKHzV9a3XCQbacf
         WdST+NrSmlrT0QiMBFeyG5mkpDdB37nqMXCiO809zGPqX6W5IrY5K4jrWczi+xsM+xnH
         EmXA==
X-Gm-Message-State: AOAM530bAJNukX8u3pB3LYlgKn1ifnhsLn5BDzzD0Z/mtESMyorU/mkR
        b/sVcPGJJ4cI8wsKwDZQAijy9fScimLfXXzBzw14/A==
X-Google-Smtp-Source: ABdhPJwBEBj8fo/hJdeZZDm/dRXHjrbF/OiaG2jxVa0CBcAl/tlB+hn3pnNw60cE/ownotAxX29n0/A81nJAhMX8RZ0=
X-Received: by 2002:a05:6402:1713:: with SMTP id y19mr35386165edu.52.1617133405601;
 Tue, 30 Mar 2021 12:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210330111620.GK2356281@nvidia.com> <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
 <20210330154712.GR2356281@nvidia.com> <CAPcyv4hL-B=1hostoj9t6EE5impmcDR2-wsgahvBKdzL9LbqLg@mail.gmail.com>
 <20210330170253.GU2356281@nvidia.com> <CAPcyv4ixD=+PejHErT_FLtEyXsm4mk+93R7mQ0uFtd_kd-fs1w@mail.gmail.com>
 <20210330175431.GX2356281@nvidia.com> <CAPcyv4igMvwfZNgi-Uap_QUJi+uocMUD3KZBhXUy56AuHZQtqw@mail.gmail.com>
 <20210330192608.GA1430856@nvidia.com>
In-Reply-To: <20210330192608.GA1430856@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Mar 2021 12:43:15 -0700
Message-ID: <CAPcyv4h1qgQAP1JT88rWOf9xZz_1o2yPvMFETNY2dFn17uFwhw@mail.gmail.com>
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

On Tue, Mar 30, 2021 at 12:26 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Mar 30, 2021 at 12:00:23PM -0700, Dan Williams wrote:
>
> > > > > IMHO this can't use 'dev->kobj.state_in_sysfs' as the RCU protected data.
> > > >
> > > > This usage of srcu is functionally equivalent to replacing
> > > > srcu_read_lock() with down_read() and the shutdown path with:
> > >
> > > Sort of, but the rules for load/store under RCU are different than for
> > > load/store under a normal barriered lock. All the data is unstable for
> > > instance and minimially needs READ_ONCE.
> >
> > The data is unstable under the srcu_read_lock until the end of the
> > next rcu grace period, synchronize_rcu() ensures all active
> > srcu_read_lock() sections have completed.
>
> No, that isn't how I would phrase it. *any* write side data under RCU
> is always unstable by definition in the read side because the write
> side can always race with any reader. Thus one should use the RCU
> accessors to deal with that data race, and get some acquire/release
> semantics when pointer chasing (though this doesn't matter here)
>
> > Unless Paul and I misunderstood each other, this scheme of
> > synchronizing object state is also used in kill_dax(), and I put
> > that comment there the last time this question was raised. If srcu
> > was being used to synchronize the liveness of an rcu object like
> > @cxlm or a new ops object then I would expect rcu_dereference +
> > rcu_assign_pointer around usages of that object. The liveness of the
> > object in this case is handled by kobject reference, or inode
> > reference in the case of kill_dax() outside of srcu.
>
> It was probably a mis-understanding as I don't think Paul would say
> you should read data in thread A and write to it in B without using
> READ_ONCE/WRITE_ONCE or a stronger atomic to manage the data race.
>
> The LWN articles on the "big bad compiler" are informative here. You
> don't want the compiler to do a transformation where it loads
> state_in_sysfs multiple times and gets different answers. This is what
> READ_ONCE is aiming to prevent.
>
> Here is it just a boolean flag, and the flag is only cleared, so risks
> are low, but it still isn't a technically correct way to use RCU.
>
> (and yes the kernel is full of examples of not following the memory
> model strictly)

Ok, so this is the disagreement. Strict adherence to the model where
it does not matter in practice. In that sense this use is not
idiomatic, and the fact that we've spilled this many bytes in emails
back and forth is good enough reason to change it.

>
> > > > cdev_device_del(...);
> > > > down_write(...):
> > > > up_write(...);
> > >
> > > The lock would have to enclose the store to state_in_sysfs, otherwise
> > > as written it has the same data race problems.
> >
> > There's no race above. The rule is that any possible observation of
> > ->state_in_sysfs == 1, or rcu_dereference() != NULL, must be
> > flushed.
>
> It is not about the flushing.

Ok, it's not about the flushing it's about whether the store to
state_in_sysfs can leak past up_write(). If that store can leak then
neither arrangement of:

cdev_device_del(...);
down_write(...):
up_write(...);

...or:

down_write(...):
cdev_device_del(...);
up_write(...);

...is sufficient.
