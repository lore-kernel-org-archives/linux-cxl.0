Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B522DC433C1
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 15:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8367F619CF
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 15:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhC3Phf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbhC3Pha (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 Mar 2021 11:37:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C94C061574
        for <linux-cxl@vger.kernel.org>; Tue, 30 Mar 2021 08:37:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b7so25509731ejv.1
        for <linux-cxl@vger.kernel.org>; Tue, 30 Mar 2021 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8QVueR2J4MG452uSvhDqbSnDmvlg2Lkj4kwKpUq0Ag=;
        b=JC9HzvaCN6/0Ezka753cn0ntDqupiz9J5lCvt7eKMBgZMSAAjfglM+ppRcOE81ssun
         jI0A7lYOev6YGjf22yjxPzi9iHoWg70Jl6kEBLVH0M9LP28bx1EQcbmJAZ1JNEBZ6SBC
         NQBU52jNtek5CJLli0h4K3ettWmsKxizHz59JCcxHViufUp/Twziq9olbE/2HZKCPSfQ
         BIp9kDzBD5tR68MyRzZxycmLgSpNoV6LKvDG9gOiTqcjDUg11I1q+3EF94d1TaMUuRW+
         JcjyG/yVyJF2iOXuVkxMLdqCFBzov9l4WyPOnbK5a+z6R8glPMyW3rHu6FgxdCPSQqrS
         aEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8QVueR2J4MG452uSvhDqbSnDmvlg2Lkj4kwKpUq0Ag=;
        b=a9jU+Q8UcM735O/pOFQ5Zfa0/WLvBh2A4MaZ7dfx7ZvxgYX4qMKo9SnqkwBmpdnM2f
         al4V6qpPxYAktWvyLWJJsBYdEdgxX3WWdRCPlVcTl3i9mT3tLUOA10uqRytY01GWLGwx
         HjUy8KbM1K4DNJd+kedr8XJ4DNq1DFTRlCJqdpX5x51WKlIKoL4RthWdu0JqplD0VlYs
         ZFLyvAtYc+LIu1R7RqOBv+YmzU1YmpiBTbVx0eUazXx64iyAWRw+3Rl1XQ44RZ8SP0tc
         jkCNUHu7/jQsF5GbRQRzHebmPkY0Xj57yMco6QrHG0J+3D/MpdvT3mKQwDSdH+sBo7hD
         Ik6w==
X-Gm-Message-State: AOAM532T7AjjZjzR6rc0pY6Wc0PD46vW/YXZJZbJa86phSCsiSKkA3a9
        mZPNJp5jNCsFfvWnnv4E/pZjs3aHFU/m9Si1y/CQe7wUSYOXFA==
X-Google-Smtp-Source: ABdhPJx/6s9iYOeW5br47lgE1qFLbKm3qI/FVFrtxTDlYTEtW43HlM1qGYwq4bN1JpZGXJvdMUv2lYVFG/6v36DyvWU=
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr34155158ejg.418.1617118648892;
 Tue, 30 Mar 2021 08:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210330111620.GK2356281@nvidia.com>
In-Reply-To: <20210330111620.GK2356281@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Mar 2021 08:37:19 -0700
Message-ID: <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
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

On Tue, Mar 30, 2021 at 4:16 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Mar 29, 2021 at 07:47:49PM -0700, Dan Williams wrote:
>
> > @@ -1155,21 +1175,12 @@ static void cxlmdev_unregister(void *_cxlmd)
> >       struct cxl_memdev *cxlmd = _cxlmd;
> >       struct device *dev = &cxlmd->dev;
> >
> > -     percpu_ref_kill(&cxlmd->ops_active);
> >       cdev_device_del(&cxlmd->cdev, dev);
> > -     wait_for_completion(&cxlmd->ops_dead);
> > +     synchronize_srcu(&cxl_memdev_srcu);
>
> This needs some kind of rcu protected pointer for SRCU to to
> work.. The write side has to null the pointer and the read side has to
> copy the pointer to the stack and check for NULL.
>
> Otherwise the read side can't detect when the write side is shutting
> down.
>
> Basically you must use rcu_derference(), rcu_assign_pointer(), etc
> when working with RCU.

If the shutdown path was not using synchronize_rcu() then I would
agree with you. This usage of srcu is also used to protect dax device
shutdown after talking through rwsem vs srcu in this thread with Jan
and Paul [1]. The syncrhonize_rcu() guarantees that all read-side
critical sections have had at least one chance to quiesce.

So this could either use rcu pointer accessors and call_srcu to free
the object in a quiescent state, or it can use synchronize_srcu()
relative to a condition that aborts usage of the pointer.

[1]: https://lore.kernel.org/lkml/20180408031113.GO3948@linux.vnet.ibm.com/
