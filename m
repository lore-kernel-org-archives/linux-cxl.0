Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3D3C4338F
	for <linux-cxl@archiver.kernel.org>; Wed, 28 Jul 2021 23:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F506101B
	for <linux-cxl@archiver.kernel.org>; Wed, 28 Jul 2021 23:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhG1XVg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 28 Jul 2021 19:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhG1XVg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 28 Jul 2021 19:21:36 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C811C061757
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jul 2021 16:21:34 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l19so7606301pjz.0
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jul 2021 16:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iqNxgMPFhBGQpn1rwUknr9JjsqdUjZrU/3Fz0xH81Cs=;
        b=t/uSGffO1hlbz+dqgWTAOXQqoKsL41LGNeZKyc/jafs6z6FG+Pgbn9Psh+GDEU5kZZ
         SEHtLphwz1+L90LcB6v0TuOLAIebLZGEwM4JnK4vFgW4AJJQOC3+rx2O4+KrASy4+hTA
         5DVBbbJNbWGLdXUAj7S9hhP+srw2leOmaYC1KO2svLda+cGW32Rdk3vPLyKocQI69K6p
         D6OCX1A18mT0dzNYi5HxA8fypBcD+Bqggwsimg4hA0DpJntDccwcILgusbCSCPY9i3/L
         2eF+k4wnrzBxKbsP7/CuPLUg+nURiB/JCOBBIvQ4vJsOnBdHCYlhVhrxYxxurXIqXWxE
         oB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iqNxgMPFhBGQpn1rwUknr9JjsqdUjZrU/3Fz0xH81Cs=;
        b=l+OrVLhMB+eKQ4mOpWao4LxESCkNhz+6rN2GpDELlNUBN/NtCpojzz/pSzZlqp8Ehb
         84G5ZhN4LhYzvz+Woo7AmeZgZJLk+AiMW54UMnS85PuKhnlBWt3dURzuVXlZXRW+LDBp
         jhZhH5Ickvpkf5rKBuMJC5HWx1tY0iAKo4C2Gm6k/0NbT7Cwwq3Xxa2rkYN2XrL1RQuk
         rrwAQx+SRH3b+o4AlNJynkA1m6jMg8Xz+l8gTVFpKiS5bZ7XZzcGrJ05wI0R0TLGxieI
         82D7Q3Z41SfStRbCgA1hKRuhYTirvHNl7V98upYMdrFga+Qts3XgD/5CP9fWyMkEa1Z3
         vGRw==
X-Gm-Message-State: AOAM532JDCL+n7Cdm0F3S6urOTbUgKTrdBgt1SZC6sDznaZBaz2UtxfV
        9/rcMh7sJQZracNnu5/61GV/WR2Yeof7nUS3fOZSQA==
X-Google-Smtp-Source: ABdhPJwfFDK81Z6YmbOY36C5ZIOf9RKfody3muyeMDr4Do9pPCECssigxB09eimk/DNIDHKLsKLjTlAS5jhuapSN2xY=
X-Received: by 2002:a17:902:7d91:b029:12b:45b0:736b with SMTP id
 a17-20020a1709027d91b029012b45b0736bmr1780185plm.79.1627514494006; Wed, 28
 Jul 2021 16:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210715194125.898305-1-ben.widawsky@intel.com> <20210715194125.898305-6-ben.widawsky@intel.com>
In-Reply-To: <20210715194125.898305-6-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 28 Jul 2021 16:21:22 -0700
Message-ID: <CAPcyv4hdDA-ErwTvEQYO-qtcfMSeq=iR8qHnPKJp0usH4jZSXQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] cxl: Pass fops and shutdown to memdev creation
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jul 15, 2021 at 12:41 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Drivers that use cxl_core for registering a cxl_memdev will likely
> require synchronization with the core for shutdown so as to not race
> against the device going away.

This isn't quite right. There are three independent lifetimes to worry
about: the liveness of the file_operations (bounded by userspace last
close), the driver attach lifetime (bounded by ->remove()), and the
device lifetime (bounded by last put_device()). The devm vs
file_operations lifetime collision is a common problem [1]. I'd go so
far as to define something like:

struct devres_file_operations {
    struct file_operations *fops;
    (int)(*shutdown)(struct device *);
};

...where the definition of @shutdown is:

"invoked in the devres release path to disconnect any driver instance
data from @dev. It assumes synchronization with any fops operation
that requires driver data. After @shutdown an operation may only
reference @device data."

I'd define it locally for now, unless / until other subsystems want to
share the CXL device allocation scheme.

[1]: https://lore.kernel.org/r/YOagA4bgdGYos5aa@kroah.com

> The main example currently is with the
> ioctl interface. Through the duration of the ioctl it's expected that
> the underlying memdev will not disappear.

It's not cxlmd that's the concern, it's cxlm.

> Additionally, it may be desirable to have the fops be passed along as
> well for drivers which do not want the standard handler for the
> character device's ioctl.

Let's give a concrete example. "The unit test code for CXL will also
use a mock driver that provides its own devres_file_operations
instance."

I'll take a shot at reworking this.

>
> As memdev is being migrated to core, this separation must be made.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.h |  2 ++
>  drivers/cxl/pci.c | 23 +++++++++++++++--------
>  2 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> index 2092f86beeb8..2b7481376621 100644
> --- a/drivers/cxl/mem.h
> +++ b/drivers/cxl/mem.h
> @@ -42,12 +42,14 @@ extern int cxl_mem_major;
>   * @cdev: char dev core object for ioctl operations
>   * @cxlm: pointer to the parent device driver data
>   * @id: id number of this memdev instance.
> + * @shutdown: Optional function to call on memory device shutdown.
>   */
>  struct cxl_memdev {
>         struct device dev;
>         struct cdev cdev;
>         struct cxl_mem *cxlm;
>         int id;
> +       void (*shutdown)(struct cxl_memdev *cxlmd);
>  };
>
>  /**
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6f10b19c9c83..418ae0eac188 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1293,11 +1293,13 @@ static void cxl_memdev_unregister(void *_cxlmd)
>         struct device *dev = &cxlmd->dev;
>
>         cdev_device_del(&cxlmd->cdev, dev);
> -       cxl_memdev_shutdown(cxlmd);
> +       if (cxlmd->shutdown)
> +               cxlmd->shutdown(cxlmd);
>         put_device(dev);
>  }
>
> -static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
> +static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm,
> +                                          const struct file_operations *fops)
>  {
>         struct pci_dev *pdev = cxlm->pdev;
>         struct cxl_memdev *cxlmd;
> @@ -1323,7 +1325,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
>         device_set_pm_not_required(dev);
>
>         cdev = &cxlmd->cdev;
> -       cdev_init(cdev, &cxl_memdev_fops);
> +       cdev_init(cdev, fops);
>         return cxlmd;
>
>  err:
> @@ -1331,15 +1333,17 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
>         return ERR_PTR(rc);
>  }
>
> -static struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -                                             struct cxl_mem *cxlm)
> +static struct cxl_memdev *
> +devm_cxl_add_memdev(struct device *host, struct cxl_mem *cxlm,
> +                   const struct file_operations *fops,
> +                   void (*shutdown)(struct cxl_memdev *cxlmd))
>  {
>         struct cxl_memdev *cxlmd;
>         struct device *dev;
>         struct cdev *cdev;
>         int rc;
>
> -       cxlmd = cxl_memdev_alloc(cxlm);
> +       cxlmd = cxl_memdev_alloc(cxlm, fops);
>         if (IS_ERR(cxlmd))
>                 return cxlmd;
>
> @@ -1362,6 +1366,7 @@ static struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>         rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>         if (rc)
>                 return ERR_PTR(rc);
> +       cxlmd->shutdown = shutdown;
>         return cxlmd;
>
>  err:
> @@ -1369,7 +1374,8 @@ static struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>          * The cdev was briefly live, shutdown any ioctl operations that
>          * saw that state.
>          */
> -       cxl_memdev_shutdown(cxlmd);
> +       if (shutdown)
> +               shutdown(cxlmd);
>         put_device(dev);
>         return ERR_PTR(rc);
>  }
> @@ -1610,7 +1616,8 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         if (rc)
>                 return rc;
>
> -       cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlm);
> +       cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlm, &cxl_memdev_fops,
> +                                   cxl_memdev_shutdown);
>         if (IS_ERR(cxlmd))
>                 return PTR_ERR(cxlmd);
>
> --
> 2.32.0
>
