Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC79C433EF
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 20:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38958610A0
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 20:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhJaUQP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 31 Oct 2021 16:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhJaUQP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 31 Oct 2021 16:16:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F321C061570
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 13:13:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso8340pjb.0
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TN4IpC2asbuU7yfb/DyFAfoxVHGgFo+aSGp65ra1bq0=;
        b=b+5LhjYA30PndMeAvoCpqPM2P9atQqaK5SE9DtueQVb7+4sM74R2pK4zAqQ6KAEs7X
         YtZ8pT0dB1CzTKGM+VGgA/zaaD09gs9H+f+8c6AZhrGgjcAAynKtLpft+4okHpl/yus8
         kFUGI2z5Q06Jy0QCDjOCStzjDoqEs4xYEHVTXyR8krnCWfTSQwGNgJU6NKOQH71ntWv9
         g/1Dogztj3Z7t5aN4dD9PVHt7/KqC2Tc9DqUnpCUQPLdrKD6UneaAvdyTJG3KCgWBUGP
         K3VTmK2MgLkjfa2mMpFJJGbyCVDGtp/X8nV/a6V+PKc/9uLWwoC8lZAuIXLwvkm33f7w
         VpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TN4IpC2asbuU7yfb/DyFAfoxVHGgFo+aSGp65ra1bq0=;
        b=C5A3bghU0IkYqzadqo2wJQBWhlXPp15WG/0OdUAhuapJsuwaVO+B5UHP/kEDlN91qj
         4C1wMfqlNPvx/QH27jDEakMbyixaya93VOf0PAcOmMqAVe7T91gM5YA40c4KNrIvS8Xf
         8mnu8JOEihjzHq4oqwRG2BpRcjBUyMVtXsaAQ+V2gox/7PPsiNdsE/XbC2w+IDQs8PQt
         29cCiejhaCGpggtEjAFVUXAR4qobHRHw5dlU3afKQdYRU1LuyKIT23BNvsg+08PsS/1f
         Boy0OA2y2xJQj68lo6wdo5USztvsPy+31nK0G829/YetX6/I5ov76QKZ5Hj2IwWD2P4j
         u5RQ==
X-Gm-Message-State: AOAM5309voY9RVa5QDmOmPICaKpnQs9/C4qnr1FM8ForgdkVox8Wo9IU
        lZ/i3NDY+IG9ZwvV/YtuDOuhnqi452c63O3fWKKFyw==
X-Google-Smtp-Source: ABdhPJzN178uxKUdqG9yEUS1PAoVzVmOwJlq/uY6MJO3wh4Nnsp3Q7McdDQQ0wOWlDXvbvRCSQ6t1CQOqwgGU6IbhxI=
X-Received: by 2002:a17:902:b697:b0:141:c7aa:e10f with SMTP id
 c23-20020a170902b69700b00141c7aae10fmr8524801pls.18.1635711222530; Sun, 31
 Oct 2021 13:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com> <20211022183709.1199701-13-ben.widawsky@intel.com>
In-Reply-To: <20211022183709.1199701-13-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 31 Oct 2021 13:13:32 -0700
Message-ID: <CAPcyv4gR0w4CFPsDoiBd6o=ZyToiyRWFuj8GfTNieOeopHwLEg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/28] cxl/core: Store component register base for memdevs
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Bake component registers into the memdev creation API in order to be
> able to use them as part of driver probing.
>
> Component register base addresses are obtained through PCI mechanisms.
> As such it makes most sense for the cxl_pci driver to obtain that
> address. In order to reuse the port driver for enumerating decoder
> resources for an endpoint, it is desirable to be able to add the
> endpoint as a port.  Unfortunately, by the time an endpoint driver would
> run, it no longer has any concept of the underlying PCI device (this is
> done intentionally to provide separation between drivers).

Changelog looks good.

>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/core/memdev.c    |  5 +++--
>  drivers/cxl/cxlmem.h         |  5 ++++-
>  drivers/cxl/pci.c            | 17 ++++++++++++++++-
>  tools/testing/cxl/test/mem.c |  3 ++-
>  4 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index bf1b04d00ff4..15762c16d83f 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -276,8 +276,8 @@ static const struct file_operations cxl_memdev_fops = {
>         .llseek = noop_llseek,
>  };
>
> -struct cxl_memdev *
> -devm_cxl_add_memdev(struct cxl_mem *cxlm)
> +struct cxl_memdev *devm_cxl_add_memdev(struct cxl_mem *cxlm,
> +                                      resource_size_t component_reg_phys)
>  {
>         struct cxl_memdev *cxlmd;
>         struct device *dev;
> @@ -298,6 +298,7 @@ devm_cxl_add_memdev(struct cxl_mem *cxlm)
>          * needed as this is ordered with cdev_add() publishing the device.
>          */
>         cxlmd->cxlm = cxlm;
> +       cxlmd->creg_base = component_reg_phys;

Let's pick one style for both, either rename component_reg_phys to
creg_base, or creg_base to component_reg_phys. My preference is
component_reg_phys, but I won't put up much of a fight against
creg_base.


>
>         cdev = &cxlmd->cdev;
>         rc = cdev_device_add(cdev, dev);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c4f450ad434d..62fe8e2c59e4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -35,12 +35,14 @@
>   * @cdev: char dev core object for ioctl operations
>   * @cxlm: pointer to the parent device driver data
>   * @id: id number of this memdev instance.
> + * @creg_base: register base of component registers
>   */
>  struct cxl_memdev {
>         struct device dev;
>         struct cdev cdev;
>         struct cxl_mem *cxlm;
>         int id;
> +       resource_size_t creg_base;
>  };
>
>  static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
> @@ -48,7 +50,8 @@ static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
>         return container_of(dev, struct cxl_memdev, dev);
>  }
>
> -struct cxl_memdev *devm_cxl_add_memdev(struct cxl_mem *cxlm);
> +struct cxl_memdev *devm_cxl_add_memdev(struct cxl_mem *cxlm,
> +                                      resource_size_t component_reg_phys);
>
>  /**
>   * struct cxl_mbox_cmd - A command to be submitted to hardware.
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index d1adc759d051..96a312ed8269 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -421,6 +421,7 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> +       resource_size_t creg = CXL_RESOURCE_NONE;
>         struct cxl_register_map map;
>         struct cxl_memdev *cxlmd;
>         struct cxl_mem *cxlm;
> @@ -465,7 +466,21 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         if (rc)
>                 return rc;
>
> -       cxlmd = devm_cxl_add_memdev(cxlm);
> +       /*
> +        * If the component registers can't be found, the cxl_pci driver may
> +        * still be useful for management functions so don't return an error.

This comment makes sense...

> +        *
> +        * XXX: Creating the device is going to kick of the cxl_mem probing.
> +        * That probe requires the component registers. Therefore, the register
> +        * block must always be found first.
> +        */

..., but I don't understand the point of this comment. Given that
devm_cxl_add_memdev() takes the base address as an argument it's
already clear that the component registers need to be found before
devm_cxl_add_memdev().

> +       rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +       if (rc)
> +               dev_warn(&cxlmd->dev, "No component registers (%d)\n", rc);
> +       else
> +               creg = cxl_reg_block(pdev, &map);
> +
> +       cxlmd = devm_cxl_add_memdev(cxlm, creg);
>         if (IS_ERR(cxlmd))
>                 return PTR_ERR(cxlmd);
>
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 12a8437a9ca0..471fc7fb5418 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -227,7 +227,8 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>         if (rc)
>                 return rc;
>
> -       cxlmd = devm_cxl_add_memdev(cxlm);
> +       /* TODO: mock component registers, or... */

How about:

/* cxl_test does not emulate registers, any memdev operations that
imply component register access will be mocked at the memdev
operations interface */

> +       cxlmd = devm_cxl_add_memdev(cxlm, CXL_RESOURCE_NONE);
>         if (IS_ERR(cxlmd))
>                 return PTR_ERR(cxlmd);
>
> --
> 2.33.1
>
