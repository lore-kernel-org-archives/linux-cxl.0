Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA1FC433F5
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 18:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5219361038
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 18:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhJaSGU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 31 Oct 2021 14:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhJaSGU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 31 Oct 2021 14:06:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1BBC061570
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 11:03:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v20so10133556plo.7
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFsPYoFUPT5XC7FhK1dPPc22Najk/EMbXk4uLHq/Pos=;
        b=M6xfOMELd2NAMrYU/0LXvZT/QrQIUUPVpSMowQ+mBaP0EZJAW+rwAQ2pmbWS31Eh/6
         Se1BME30iOZQlECvPID0UZwOUgV1PIeGbaIfoGmymw595aOLLctretLrACFYxrp1WyZO
         qj2gFRGHjHPte3U16PLruXH5gqYHscwu2JBCTr1Y+b7sMzIKtBKiVwBB/1nRtRWWwiT6
         TVjJUzqYi5dSMlkHxkHc9xZrW/77JxztkC1kJt51gQTyuKKsk3STwdQrclKmFOptiJDM
         S+Yxtxbf5la15PFfmKmrhk/Q2dlMIikoxWtWh1NWTYSFliebEXO9mMU/FIw1ApiLhuqS
         Gfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFsPYoFUPT5XC7FhK1dPPc22Najk/EMbXk4uLHq/Pos=;
        b=JZVTSjEnFdrsGPbj1vyhIyGhvnGlKMNZR4F8Neg+kBVdfsMrVOsacu0K/iuOef/bQZ
         LHZnwGes6OWirpc/MyyO7vAwt4yPEyfkTvhfGmmgEZwnSeVE3SRwnKJb7zfojDNd0eEU
         5aaVm2aSLrt7w6GwL7I20DRXBCpGdjh65I8iCWFebCxuJw+FRnnKT7Lg1eUr0EniFfJl
         1TxMIhKbgf2aGJNm805x9TKHVwYuYLJvzJZ7C4ar8+uRfk9Lecny0Re0fYekLVmkKizQ
         L0ztuAMsaRQdO/aWddKrMmbbphh35UNG2G9wX9oL5rI+Gph8NDGINJTLk977Buj4k0BD
         giYg==
X-Gm-Message-State: AOAM531bGZcYi2iWgQvWDOThDAF8iA2pztEi34zi2G++T/KzTB9m6rpQ
        VvpN/AHSIf/Rw9lzcIGnJHF2mYFEQ1qujbYXHcDt0g==
X-Google-Smtp-Source: ABdhPJxiqQjPxSzIEAMuwfd/pFHw9QIFrTtNuiWvZmLReWkhpU55NeCuXTuKP+F2gBtL/VOV+qBE+JCv5fQC8hCxYpg=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr24458642pjb.220.1635703427722;
 Sun, 31 Oct 2021 11:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com> <20211022183709.1199701-10-ben.widawsky@intel.com>
In-Reply-To: <20211022183709.1199701-10-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 31 Oct 2021 11:03:37 -0700
Message-ID: <CAPcyv4j+mv3+FyJd0OVBe_dUqzzYpS2gkEagiRp-Tqh9t7NMmg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/28] cxl/acpi: Map single port host bridge
 component registers
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
> Now that the port driver exists and is able to do proper decoder
> enumeration of the component registers, it becomes trivial to use that

This is the second occurrence of "becomes trivial" in this series,
it's distracting because it immediately sets off alarm bells that the
changelog is not in:

Background
Problem
Solution

...format.

> for host bridge uports. For reasons out of scope, a functional change
> would be visible if the HDM decoder was programmed by BIOS to values
> other than the full address range. Similarly if a type2 device was
> connected to this root port and programmed by BIOS, that can now be
> acted upon accordingly.

I would reserve discussion of "no functional change" for patches that
are pure cleanup. In this case this patch will cause the kernel to
behave differently when other conditions are met.

>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/acpi.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index d61397055e9f..8cca0814dfb8 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -280,12 +280,14 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>         struct cxl_port *root_port = arg;
>         struct device *host = root_port->dev.parent;
>         struct acpi_device *bridge = to_cxl_host_bridge(host, match);
> +       struct cxl_component_reg_map map;
>         struct acpi_pci_root *pci_root;
>         struct cxl_walk_context ctx;
>         int single_port_map[1], rc;
>         struct cxl_decoder *cxld;
>         struct cxl_dport *dport;
>         struct cxl_port *port;
> +       void __iomem *crb;
>
>         if (!bridge)
>                 return 0;
> @@ -318,10 +320,31 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>                 return -ENODEV;
>         if (ctx.error)
>                 return ctx.error;
> +       /*
> +        * If the host bridge has more than 1 root port, it must have registers
> +        * controlling the HDM decoders. Those will be enumerated by the port
> +        * driver.
> +        */
>         if (ctx.count > 1)
>                 return 0;
>
> -       /* TODO: Scan CHBCR for HDM Decoder resources */
> +       /*
> +        * If the single ported host bridge has a component register block,
> +        * simply let the port driver handle the decoder enumeration.
> +        *
> +        * Host bridge component registers live in the system's physical address
> +        * space.
> +        */
> +       crb = ioremap(dport->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);

This looks broken, the driver for the port should be mapping dport
component registers to offer services to upper layers.

There's also a missing iounmap.

> +       if (crb) {
> +               cxl_probe_component_regs(&root_port->dev, crb, &map);
> +               iounmap(crb);
> +               if (map.hdm_decoder.valid) {
> +                       dev_dbg(host,
> +                               "Found single port host bridge with component registers\n");
> +                       return 0;
> +               }
> +       }
>
>         /*
>          * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability
> --
> 2.33.1
>
