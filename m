Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A0FC433C1
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Mar 2021 21:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADBC61976
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Mar 2021 21:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhC2VDy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Mar 2021 17:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhC2VDu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 29 Mar 2021 17:03:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C826C061762
        for <linux-cxl@vger.kernel.org>; Mon, 29 Mar 2021 14:03:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x21so15747597eds.4
        for <linux-cxl@vger.kernel.org>; Mon, 29 Mar 2021 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sOIzusR3RaOLn+apOKVFE+YN8K3J+XLAoyC9RgaKsaY=;
        b=wHX/D/4qmRBY2ifT9YnjFc9D7tN8KEaMl2+eyX3rIxT86n7vk7t2sQR5LLHTyo5/07
         94v7OZLk8gyLph2GlQ71QVyQQaa6+IETn45wTwKIa7v7i/3D5AxJ5G/DZTChpX3WJhmg
         ymMWqVLDSpoN93fR/6u9v87JwEcVYefGMHTGgt+G/ncW++b+scuvGOD7jfCGZejALN4j
         aVF5J0Nl2hjV1pjxcnW6dRa5VgYNCYvTc1v+AUZm7MqpE3q8e1vCx+XJ5Jt5uJxFKh0M
         oJAckCglXV26N3osTyMU/oBIB6GndSMEE9ELm8H3yoSOi/qu06mmsQhzwNuNtZ4HNMZp
         C4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOIzusR3RaOLn+apOKVFE+YN8K3J+XLAoyC9RgaKsaY=;
        b=ADPf3wbCZQzzRC1BS1HC/ZOOPOg17NfnaD/j/lNRu+Qcjt1HpxCoVDOl7SydC6grZA
         uHf6MfHtTLHTkMypeemKPTbk6PIoZHodc7rNMZIqJQRhq4nbQ4IlwNuxewnBvHuYcaB+
         /Cnar7Hkd4Rchu5jPssKujXyiFL3ruzYGVSC+/TYPMQ/4Uoc+lVzi0mQQCHxzS8fWW8p
         mjB2aun8e3Rt7K61kzYdG0vR9iiLYD6Bd8QqhmwGsB8mfA6eawTjQnd9XbeMh2hO1zLv
         fkNMjew+xL5rSrZoctTij5DxpPOPqCJHoRSairiDE78qEibm5a61RnHFb5O5ovANG0FD
         sjPg==
X-Gm-Message-State: AOAM532UzIyDKL5ZKoohXhsbo8pVlgf14A1GGvOmASvdtx1nQB/v2SZZ
        1psDDzLJynTSNaw5jl/EPn8uvOI9ZoDEvmR2XFeGCA==
X-Google-Smtp-Source: ABdhPJztl5Gocmnp+xygLzAn7o5w+wwI50xM03oEph5E03jvUNnSbrxq2vl+RtRfQ+Vol2cC7fYoJRlXEyXkmq0U1Sc=
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr30390835edw.348.1617051828094;
 Mon, 29 Mar 2021 14:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161661971651.1721612.7457823773061754064.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210325171126.GD2356281@nvidia.com>
In-Reply-To: <20210325171126.GD2356281@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Mar 2021 14:03:37 -0700
Message-ID: <CAPcyv4hMHAK4=eGuvP5Bg_2YfQCLt5cd5ku0tUUNY3VCxkKmaQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] cxl/mem: Fix cdev_device_add() error handling
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-cxl@vger.kernel.org, "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 25, 2021 at 10:12 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Mar 24, 2021 at 02:01:56PM -0700, Dan Williams wrote:
> > If cdev_device_add() fails then the allocation performed by
> > dev_set_name() is leaked. Use put_device(), not open coded release, for
> > device_add() failures.
> >
> > The comment is obsolete because direct err_id failures need not worry
> > about the device being live.
> >
> > The release method expects the percpu_ref is already dead, so
> > percpu_ref_kill() is needed before put_device(). However, given that the
> > cdev was partially live wait_for_completion() also belongs in the
> > release method.
> >
> > Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
> > Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >  drivers/cxl/mem.c |   16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 30bf4f0f3c17..e53d573ae4ab 100644
> > +++ b/drivers/cxl/mem.c
> > @@ -1049,6 +1049,7 @@ static void cxl_memdev_release(struct device *dev)
> >  {
> >       struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >
> > +     wait_for_completion(&cxlmd->ops_dead);
>
> This only works because the fops stuff is not right, a kref shouldn't
> have a completion like this.
>
> Also, don't use devm for unregister. That just makes it extra-hard to
> write the driver remove function correctly.

To date there is no driver remove function, however if that changes
then I expect all the devm needs to go.

>
> > @@ -1157,7 +1158,6 @@ static void cxlmdev_unregister(void *_cxlmd)
> >
> >       percpu_ref_kill(&cxlmd->ops_active);
> >       cdev_device_del(&cxlmd->cdev, dev);
> > -     wait_for_completion(&cxlmd->ops_dead);
> >       cxlmd->cxlm = NULL;
> >       put_device(dev);
> >  }
> > @@ -1210,20 +1210,16 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
> >       cdev_init(cdev, &cxl_memdev_fops);
> >
> >       rc = cdev_device_add(cdev, dev);
> > -     if (rc)
> > -             goto err_add;
> > +     if (rc) {
> > +             percpu_ref_kill(&cxlmd->ops_active);
> > +             put_device(dev);
>
> This must be one high performance ioctl to warrant the percpu ref.. If
> it is not high performance use a rwsem, otherwise I'd suggest srcu as
> a faster/simpler alternative.

The plan is to refactor and share the same reference counted fops
mechanism as debugfs and make that common infrastructure. However, in
the meantime I think global srcu is suitable.

>
> This is a use-after-free:
>
> static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
>                              unsigned long arg)
> {
>         struct cxl_memdev *cxlmd;
>         struct inode *inode;
>         int rc = -ENOTTY;
>
>         inode = file_inode(file);
>         cxlmd = container_of(inode->i_cdev, typeof(*cxlmd), cdev);
>        ^^^^^ can be freed memory
>
> ioctl needs to store the cxlmd in file->private_data and
> open()/release() need to do get/put device on it so the memory stays
> around. This is why open gets the inode as an argument and ioctl/etc
> does not.

Ugh, exactly why I was motivated to attempt to preclude this with new
core infrastructure that attempted to fix this centrally [1]. Remove
the  possibility of "others" getting this wrong. However after my
initial idea bounced off Greg then I ended up shipping this bug in the
local rewrite. I think the debugfs api gets this right in terms of
centralizing the reference count management, and I want to see
something similar for common driver ioctl patterns.

[1]: http://lore.kernel.org/r/CAPcyv4hGxLZGEkfnqdLfF-a1CzfEjLux-TBxXztbknFhEe9mYA@mail.gmail.com

>
> The ordering cxlmdev_unregister should mirror the ordering in create
> so cdev_device_del should be first

Sure.
