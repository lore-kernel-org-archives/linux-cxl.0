Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38919C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 23:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB2D611AD
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 23:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhIJXLH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 19:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhIJXLH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 19:11:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854A8C061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 16:09:54 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso2467207pjq.4
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 16:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJC81Rg5cbi7V5huCX7ZqJ6+Zh1hUR6yaoIvDzhE6mw=;
        b=I/xN+e1+3RxgczYx9tsjUL+ybWtfKmBsNXU4QCFDCBJY/inPPp32NYnC870gsQ1Gbs
         sZoJ9TMWRNst3IrrRXQk+GL+ZtdDjBHzaqf06MvlVsfOUTHGeFTqqaJqgLIEnyaLXNVv
         WQDXVIBsJLRLUedX4XrytoHA5+T6JJ3kcg2Cb0dNImbVNTb22l+CkI127CvOC5AJ4vX2
         lEsQSuiAMuaY07IOrPgKCvyjteviC6OyCdqv4+xSecqQr2OQwxm2243yRTDothJ9Qv+6
         qpIaeZVVQGle7vuVjYCw/hfXdGPCC4VDi8+J9JR+PzDYk/WVzCZ14vxgUUjSkTOZQIEf
         MoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJC81Rg5cbi7V5huCX7ZqJ6+Zh1hUR6yaoIvDzhE6mw=;
        b=i2HGOQY8oKo/MJLFxyJUwZHAKQHC3Rs9pIhtMonjz+FOsD8j153vQXm1k+pwBkk+4H
         7pyMXKmmVZED25xFoOjxVrCU5sdV+WtvR8pIz7NTVlEr7YbJbv+uNnnqQApJ3qf3DACq
         n5iFLY+USytDVSVF7oyt1HSbuW7pyPNRJGBLsJ7A7PdAGgGnDuGKOo+OohpKcYL9ij69
         /kx1Z/Dq5kZ58X+LpSrT3ebAGDPgLVZMB0hqHdr3RBiEQa/8cYffJsgdnqe6P/VEOSrS
         7sXlxMFMgnrIfQA+xJYMIfeHc3Autlgj7dGDTegNtABs9aXISAqIMFchPfrx8y6gI/ke
         vWiA==
X-Gm-Message-State: AOAM533sxzC/v2ut1nyMwsM9X6adFodgYEnBpqEGYCE7NtXW160+UdcP
        rgFiEeVdAjvnNGHpMR9FBrJN7EcMeb2oSs1WC7MrmF0lpug=
X-Google-Smtp-Source: ABdhPJy91gKOtkRBC+jxVzIXs2pyWCc0jg1lcFYPm4ZJHXa/gqg+bI1oPriAl3hopOg+am2EhbBhJEYNIaCbNGPhAOU=
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr87615pju.8.1631315393906;
 Fri, 10 Sep 2021 16:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com> <20210902195017.2516472-9-ben.widawsky@intel.com>
In-Reply-To: <20210902195017.2516472-9-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 16:09:43 -0700
Message-ID: <CAPcyv4icms5Og86QwY7fGh0+4EhSaPfFSSN_wwKWPFSyC6=BXQ@mail.gmail.com>
Subject: Re: [PATCH 08/13] cxl/mem: Add memdev as a port
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

On Thu, Sep 2, 2021 at 12:50 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> CXL endpoints contain HDM decoders that are architecturally the same as
> a CXL switch, or a CXL hostbridge. While some restrictions are in place
> for endpoints, they will require the same enumeration logic to determine
> the number and abilities of the HDM decoders.
>
> Utilizing the existing port APIs from cxl_core is the simplest way to
> gain access to the same set of information that switches and hostbridges
> have.

Per the comment a few patches back I think this patch deserves to be
moved before and referenced by the endpoint-decoder patch.

>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/core/bus.c |  5 ++++-
>  drivers/cxl/mem.c      | 10 +++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 56f57302d27b..f26095b40f5c 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -377,7 +377,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>
>         dev = &port->dev;
>         if (parent_port)
> -               rc = dev_set_name(dev, "port%d", port->id);
> +               if (host->type == &cxl_memdev_type)
> +                       rc = dev_set_name(dev, "devport%d", port->id);

While I am certain that a root port will always be at the root, I'm
only 99% convinced that port in a device will never have child-ports,
so I'm inclined that this still be named "portX" and userspace must
consult portX/devtype to determine the port rather than infer it from
the name.

> +               else
> +                       rc = dev_set_name(dev, "port%d", port->id);
>         else
>                 rc = dev_set_name(dev, "root%d", port->id);
>         if (rc)
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index b6dc34d18a86..9d5a3a29cda1 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -63,6 +63,7 @@ static int cxl_mem_probe(struct device *dev)
>         struct device *pdev_parent = cxlm->dev->parent;
>         struct pci_dev *pdev = to_pci_dev(cxlm->dev);
>         struct device *port_dev;
> +       int rc;
>
>         if (!is_cxl_mem_enabled(pdev))
>                 return -ENODEV;
> @@ -72,7 +73,14 @@ static int cxl_mem_probe(struct device *dev)
>         if (!port_dev)
>                 return -ENODEV;
>
> -       return 0;
> +       /* TODO: Obtain component registers */

The agent that registered the memdev should have already enumerated
them for this device. Let's not duplicate that enumeration. I would
hope that this driver could be PCI details free and only operate on
memory-mapped resources.

> +       rc = PTR_ERR_OR_ZERO(devm_cxl_add_port(&cxlmd->dev, &cxlmd->dev,

I'd prefer this be broken out on multiple lines.

port = devm_cxl_add_port(...);
rc = PTR_ERR_OR_ZERO(port);


> +                                              CXL_RESOURCE_NONE,
> +                                              to_cxl_port(port_dev)));
> +       if (rc)
> +               dev_err(dev, "Unable to add devices upstream port");

Perhaps:

"Failed to register port"

...it will already be clear that it's a device port from the
device-name and driver that will be prepended to this print.


> +
> +       return rc;
>  }
>
>  static void cxl_mem_remove(struct device *dev)
> --
> 2.33.0
>
