Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9894C433DB
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 19:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7796561987
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 19:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhC3TAo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 15:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbhC3TAf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 Mar 2021 15:00:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE56C061762
        for <linux-cxl@vger.kernel.org>; Tue, 30 Mar 2021 12:00:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h10so19419525edt.13
        for <linux-cxl@vger.kernel.org>; Tue, 30 Mar 2021 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySqH0GZxajP8KrZ+n0xkhdcfDVlDyNCl1jidh+ITquU=;
        b=RW21Rwlm4SZq0A71YieJ7UGN5BUyQuxa8BQ+EI8CySUWq2GuztQ7yDNEFaOwQOULxF
         Avj1P5K1FBw+RfBSBZTGb4gg3fC2Tq1m1rH4Di9wgs6LuOJc3lWf3JZYvU25a/VLBJzA
         qjcvNRAUuLo7ygxkbGPzP1t6o4QuzGIKu9ki0paA2hVYabwDcpW3pwvGqpbk7x7rGEbj
         W/BXgfZAYAqmc2/O05yO8D/UEprzvBw3cZ/Afjl0C8/T2aP44v3kupO5wxeBUgeC2jxc
         wVgCygnrYu1ixk6kMujZoLtq9V6ZN95EUuBxtalzByPJ0QIEAuXzmmPsULlaSqUbISEC
         y/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySqH0GZxajP8KrZ+n0xkhdcfDVlDyNCl1jidh+ITquU=;
        b=feZn9YI/0V32fOVUzQBEIANOOVjNntGzGDkNojMXnrOzr6RDGX+cRP3Kji4VO4iaE8
         7hECjA4yvCtNvEhLBvKX/sxqlHcA8EjGobQgUY00lzZo9PkCda/NWn09s15dOauulW2b
         NI7DOke1pbwFWTnXVNKadqAA8RJ7PxaHTHtdYSDWOAultrtG3u9BvMfOMMdJ+Thq8Xdc
         uTjCSlmw6kZF93QJf95qyZR5F+G+uc9r8GZx3Ft0MTin1KA4VPlyx5AC0EQ+cadl8KoZ
         7Het62uiYi1CErjuTXe5RPBw4Znovg6lL6QRkTaNZaA9rQa1hHonGIUw78uVYhLagr/o
         hujA==
X-Gm-Message-State: AOAM533He2hWmfgpFTUYtpXf90+QcOjTJ5oRq7UcqS/pODNbmW7hFaL4
        cnoEqjzL8G1EiesHTNELFh5OhI7DnPcurgxIxcSdDg==
X-Google-Smtp-Source: ABdhPJy4OBG59iCDYL7xATyHi5xULCWzYjz0hSNLm4DQ3DFUtKNhhTC8O6ZcDlWYCwKCNa2AmMKNVa0BOFoHs2aEp9M=
X-Received: by 2002:a50:82c5:: with SMTP id 63mr34857756edg.97.1617130833296;
 Tue, 30 Mar 2021 12:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210330111620.GK2356281@nvidia.com> <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
 <20210330154712.GR2356281@nvidia.com> <CAPcyv4hL-B=1hostoj9t6EE5impmcDR2-wsgahvBKdzL9LbqLg@mail.gmail.com>
 <20210330170253.GU2356281@nvidia.com> <CAPcyv4ixD=+PejHErT_FLtEyXsm4mk+93R7mQ0uFtd_kd-fs1w@mail.gmail.com>
 <20210330175431.GX2356281@nvidia.com>
In-Reply-To: <20210330175431.GX2356281@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Mar 2021 12:00:23 -0700
Message-ID: <CAPcyv4igMvwfZNgi-Uap_QUJi+uocMUD3KZBhXUy56AuHZQtqw@mail.gmail.com>
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

On Tue, Mar 30, 2021 at 10:54 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Mar 30, 2021 at 10:31:15AM -0700, Dan Williams wrote:
> > On Tue, Mar 30, 2021 at 10:03 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Tue, Mar 30, 2021 at 09:05:29AM -0700, Dan Williams wrote:
> > >
> > > > > If you can't clearly point to the *data* under RCU protection it is
> > > > > being used wrong.
> > > >
> > > > Agree.
> > > >
> > > > The data being protected is the value of
> > > > dev->kobj.state_in_sysfs. The
> > >
> > > So where is that read under:
> > >
> > > +       idx = srcu_read_lock(&cxl_memdev_srcu);
> > > +       rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
> > > +       srcu_read_unlock(&cxl_memdev_srcu, idx);
> > >
> > > ?
> >
> > device_is_registered() inside __cxl_memdev_ioctl().
>
> Oh, I see, I missed that
>
> > > It can't read the RCU protected data outside the RCU critical region,
> > > and it can't read/write RCU protected data without using the helper
> > > macros which insert the required barriers.
> >
> > The required barriers are there. srcu_read_lock() +
> > device_is_registered() is paired with cdev_device_del() +
> > synchronize_rcu().
>
> RCU needs barriers on the actual load/store just a naked
> device_is_registered() alone is not strong enough.
>
> > > IMHO this can't use 'dev->kobj.state_in_sysfs' as the RCU protected data.
> >
> > This usage of srcu is functionally equivalent to replacing
> > srcu_read_lock() with down_read() and the shutdown path with:
>
> Sort of, but the rules for load/store under RCU are different than for
> load/store under a normal barriered lock. All the data is unstable for
> instance and minimially needs READ_ONCE.

The data is unstable under the srcu_read_lock until the end of the
next rcu grace period, synchronize_rcu() ensures all active
srcu_read_lock() sections have completed. Unless Paul and I
misunderstood each other, this scheme of synchronizing object state is
also used in kill_dax(), and I put that comment there the last time
this question was raised. If srcu was being used to synchronize the
liveness of an rcu object like @cxlm or a new ops object then I would
expect rcu_dereference + rcu_assign_pointer around usages of that
object. The liveness of the object in this case is handled by kobject
reference, or inode reference in the case of kill_dax() outside of
srcu.

>
> > cdev_device_del(...);
> > down_write(...):
> > up_write(...);
>
> The lock would have to enclose the store to state_in_sysfs, otherwise
> as written it has the same data race problems.

There's no race above. The rule is that any possible observation of
->state_in_sysfs == 1, or rcu_dereference() != NULL, must be flushed.
After that value transitions to zero, or the rcu object is marked for
deletion, an rcu grace period is needed before that memory can be
freed. If an rwsem is used the only requirement is that any read-side
sections that might have observed ->state_in_sysfs == 1 have ended
which is why the down_write() / up_write() does not need to surround
the cdev_device_del(). It's sufficient to flush the read side after
the state is known to have changed. There are several examples of
rwsem being used as a barrier like this:

drivers/mtd/ubi/wl.c:1432:      down_write(&ubi->work_sem);
drivers/mtd/ubi/wl.c-1433-      up_write(&ubi->work_sem);

drivers/scsi/cxlflash/main.c:2229:      down_write(&cfg->ioctl_rwsem);
drivers/scsi/cxlflash/main.c-2230-      up_write(&cfg->ioctl_rwsem);

fs/btrfs/block-group.c:355:     down_write(&space_info->groups_sem);
fs/btrfs/block-group.c-356-     up_write(&space_info->groups_sem);

fs/btrfs/disk-io.c:4189:        down_write(&fs_info->cleanup_work_sem);
fs/btrfs/disk-io.c-4190-        up_write(&fs_info->cleanup_work_sem);

net/core/net_namespace.c:629:   down_write(&pernet_ops_rwsem);
net/core/net_namespace.c-630-   up_write(&pernet_ops_rwsem);
