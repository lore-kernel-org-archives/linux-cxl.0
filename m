Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D1EC433E1
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 17:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F04BC619CD
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 17:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhC3Rb2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhC3Rb0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 Mar 2021 13:31:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4AAC061762
        for <linux-cxl@vger.kernel.org>; Tue, 30 Mar 2021 10:31:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y6so19188087eds.1
        for <linux-cxl@vger.kernel.org>; Tue, 30 Mar 2021 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tCBIVqvfgxaF1YfBYLDN7JqUVslSSW/Boru1WpFdoTc=;
        b=nfotVrj7OqnLetyZFzqpRRMkGUuwvkuuRkyiZR8STNsHR3gwtnndBEt1+gaDLL7SNe
         yGi3B1sK/JbtVrmiOrvGjD0+4nE8NjKYe+F9Pj8PCkJ+EO7ZSDmH1YlOh+w1LZnkRh84
         pxp/qSnxdxg41NBaPKvG2zm1pyGsYJeKRIvRAjLlrQSxRHS+spHWGoLTkSxwr95tYk6X
         r+o+nmGeOrvCJ2oo/TtOGbUAq6Bm9RT7TB9HRT9pT2uoH3sutsl5AeW4zyqhpbJcXcC4
         eja6qxxWHv3F+1KVOEbfiZSfeTNWG3PvpdikFFgZbZXCYTwMrCUxascBfXzTMYdhypEn
         HUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCBIVqvfgxaF1YfBYLDN7JqUVslSSW/Boru1WpFdoTc=;
        b=ZpqBAobcVnp1DfPy9uESvfOGGWx/kCSX4cTa6pF7AwLFUuu7/JHYnq5Uh9BDjlNnUg
         NUoKsfVegTFKrCWqiKjFzn1g7EI9Q2XdBnyEBv+MalJNLBLRwp3lO3f79gqLN38gwxfl
         iKCVso2HV4kw3penZkGnwkCDKf47PPNE+ElI3HKRjJTAgHmr/9aQfb/OgxEmpEoL1kCg
         VZHv9fsdf23tRWBQNnRjQ8KI2GQWHtyI0TrNAY8ub4xe1QT7Gxj7scQlBm49y8LBgWF/
         0NKdakHsqwGXBsBFT2VJ+vlie7ScVwiXwsz/y+BpjlsH/JY/zbOxd8QG2tLANrfCKmeT
         SdjA==
X-Gm-Message-State: AOAM531/1JsQNous+Uadz30tKWh6dj2/+W1nJn8i1HRh790oHYGHVjA0
        T7st3PIrAo2g8fciZiggGmOI1I+UbBv0fdDUfD9lsQ==
X-Google-Smtp-Source: ABdhPJxUyZgfJzpTqVJMJqnUf9yXQ4xYQNsN4auVji2tGa9c/lwSsVFd6BRHcmE5uRnmmfFvQcem0OyODK1LIcTGKug=
X-Received: by 2002:a05:6402:1713:: with SMTP id y19mr34824354edu.52.1617125485198;
 Tue, 30 Mar 2021 10:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210330111620.GK2356281@nvidia.com> <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
 <20210330154712.GR2356281@nvidia.com> <CAPcyv4hL-B=1hostoj9t6EE5impmcDR2-wsgahvBKdzL9LbqLg@mail.gmail.com>
 <20210330170253.GU2356281@nvidia.com>
In-Reply-To: <20210330170253.GU2356281@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Mar 2021 10:31:15 -0700
Message-ID: <CAPcyv4ixD=+PejHErT_FLtEyXsm4mk+93R7mQ0uFtd_kd-fs1w@mail.gmail.com>
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

On Tue, Mar 30, 2021 at 10:03 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Mar 30, 2021 at 09:05:29AM -0700, Dan Williams wrote:
>
> > > If you can't clearly point to the *data* under RCU protection it is
> > > being used wrong.
> >
> > Agree.
> >
> > The data being protected is the value of
> > dev->kobj.state_in_sysfs. The
>
> So where is that read under:
>
> +       idx = srcu_read_lock(&cxl_memdev_srcu);
> +       rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
> +       srcu_read_unlock(&cxl_memdev_srcu, idx);
>
> ?

device_is_registered() inside __cxl_memdev_ioctl().

> It can't read the RCU protected data outside the RCU critical region,
> and it can't read/write RCU protected data without using the helper
> macros which insert the required barriers.

The required barriers are there. srcu_read_lock() +
device_is_registered() is paired with cdev_device_del() +
synchronize_rcu().

> IMHO this can't use 'dev->kobj.state_in_sysfs' as the RCU protected data.

This usage of srcu is functionally equivalent to replacing
srcu_read_lock() with down_read() and the shutdown path with:

cdev_device_del(...);
down_write(...):
up_write(...);

...to flush readers that read ->state_in_sysfs == 1.
