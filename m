Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABACC07E99
	for <linux-cxl@archiver.kernel.org>; Fri,  9 Jul 2021 23:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D847613BE
	for <linux-cxl@archiver.kernel.org>; Fri,  9 Jul 2021 23:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhGIX7o (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 9 Jul 2021 19:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhGIX7o (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 9 Jul 2021 19:59:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF4AC0613DD
        for <linux-cxl@vger.kernel.org>; Fri,  9 Jul 2021 16:57:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id oj10-20020a17090b4d8ab0290172f77377ebso6981892pjb.0
        for <linux-cxl@vger.kernel.org>; Fri, 09 Jul 2021 16:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALsFKmAY0enPHR9GjizD42Pv6lj/DVgPh6b4HTxMKc8=;
        b=fPdIfQxDrjxNbOGvta+3YSzqu0nhc4962/MFvdVu/v6KB2Ut/6UttlqCSdnbFdGrjb
         vfd9YVm5fBG3l1JaUBVpuuBXDkbTs9ks+f6UtHeQY40dGiCfq8EvQ/lNXGNdImwtROwg
         C/1Gk8B0HjQZp2z4yEp/Eh/YpWz1Uvyy1C7bhzoEQ053qN2w14PQVXmY3DAdQuWzb9Pw
         YeqtkP+xXJdmyzzqovUW8yGmhjeHdhRPapUt1EEXvHBKwocnTTpU+Bknu51a5ePen0yj
         85i8i1O9FEfTmHntioJ7SIdRj6+D1fabzCPK03NY76UwA70hSr95BmVUsnDCuAyRAgva
         FsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALsFKmAY0enPHR9GjizD42Pv6lj/DVgPh6b4HTxMKc8=;
        b=IVYa942+nBXEL6lzEh/r69LmGY2qqsT14VMMAjBsCpHQAhm7wNdqOd4nEVSnBUUwHP
         OlmeLP1HJR1honmruD0i8aCuCzIk1RESIknr3BeT0QgsRKK4F289G9aeTOz+W8iOoXg9
         V3KS3bFs54K6HGiWREGx5OuHGieugQykmXxAYAB3TCPbWwd+LsYqJbSM0FB2Uqr+EqfG
         pnrd/+0Xg+3hiMvw9rtuZKYhgGX0kef+UNqE5EunFEk7gbFDQDVmHuRwOmH3WA9KV/gM
         B55QXemSISoM4MQVmY2nPkJ4bLjN5QH3Qn5VNRTQ6riJ3aZj6I9VP3Zt9g8fTxJ7875n
         9gkA==
X-Gm-Message-State: AOAM530sBLqZzyd+zFAisVi0hpl6ieSMgJ370D0YQ7HRIA1lOYHRw7/E
        /zWR27UmmEyTKTLcl+fXhZ67F3fCJYyidczTJYX5VQ==
X-Google-Smtp-Source: ABdhPJysZAFb2r5fy2xoQdPf+KNPJbm4Jjkj/13m5K82UM2/1mbVp2uWrljXTbXRpSXUBI9vqNMSD5pmXjmJs7wANBE=
X-Received: by 2002:a17:90a:ae0c:: with SMTP id t12mr1298476pjq.149.1625875019814;
 Fri, 09 Jul 2021 16:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210702040009.68794-1-ben.widawsky@intel.com> <20210706160050.527553-1-ben.widawsky@intel.com>
In-Reply-To: <20210706160050.527553-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 9 Jul 2021 16:56:48 -0700
Message-ID: <CAPcyv4g8XqzbwtSP3Hdww5nUvB9Hz--QL9Z_h56XfxTQMdMxmw@mail.gmail.com>
Subject: Re: [PATCH v2] cxl: Enable an endpoint decoder type
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

On Tue, Jul 6, 2021 at 9:01 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> CXL memory devices support HDM decoders. Currently, when a decoder is
> instantiated there is no knowledge of the type of decoder; only the
> underlying endpoint type is specified. In order to have the memory
> devices reuse the existing decoder creation infrastructure it is
> convenient to pass along the type of decoder on creation.
>
> The primary difference for an endpoint decoder is that it doesn't have
> dports, nor targets. The target is just the underlying media (with
> offset).
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>
> v2 Fixes target_type and stores the decoder type on instantiation

This depends on the memdev driver series? It's not applying for me on
top of cxl.git#next.

>
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index 196f260e2580..69acdd230f54 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -493,10 +493,11 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
>                         .start = base,
>                         .end = base + len - 1,
>                 },
> +               .type = type,

...but there's already the dev->type?

>                 .flags = flags,
>                 .interleave_ways = interleave_ways,
>                 .interleave_granularity = interleave_granularity,
> -               .target_type = type,
> +               .target_type = CXL_DEVICE_EXPANDER,

In the cxl-switch case how to indicate that only type-2 targets are supported?

I do think I misnamed the cxl_decoder_type. I also did not make it
clear that root decoders don't have a target type, they have a set of
flags indicating their restrictions, and unlike switch level decoders
they can support targeting both accelerators and expanders in the same
windows. I think the decoder can still be just the dev->type, but
there needs to be separate helpers for the 3 cases you have
identified. Something like the following where devm_cxl_add_decoder()
because private to the core:

devm_cxl_add_platform_decoder(struct device *host, int nr_targets,
                              resource_size_t base, resource_size_t len,
                              int interleave_ways, int interleave_granularity,
                              unsigned long flags)
{
        return devm_cxl_add_decoder(host, NULL, nr_targets, base, len,
                                    interleave_ways, interleave_granularity,
                                    0, flags);
}

devm_cxl_add_switch_decoder(struct device *host, struct cxl_port *port,
                            enum cxl_decoder_type type)
{
        return devm_cxl_add_decoder(host, port, 0, 0, 0, 0, 0,
                                    CXL_DECODER_UNKNOWN, 0);
}

devm_cxl_add_endpoint_decoder(struct device *host, struct cxl_port *port,
                              enum cxl_decoder_type type)
{
        return devm_cxl_add_decoder(host, port, 0, 0, 0, 0, 0, type,
                                    CXL_DECODER_F_ENDPOINT);
}

...where 0 values are filled in by the decoder driver init or N/A.
Presumably the memdev driver calling devm_cxl_add_endpoint_decoder()
will know whether it is an expander or an accelerator. Although given
there are no CXL accelerator drivers on the horizon, maybe even that
degree of freedom can be hidden for now.

Then the dev->type determination is:

platform => no parent cxl_port
switch => parent cxl_port and flags does not have CXL_DECODER_F_ENDPOINT
endpoint =>  parent cxl_port and flags has CXL_DECODER_F_ENDPOINT

...and probably s/cxl_decoder_type/cxl_target_type/ to make it clear
that it's not related to the cxl_decoder_X_type dev->type value.

>         };
>
>         /* handle implied target_list */
>
> ---
>  drivers/cxl/acpi.c |  2 +-
>  drivers/cxl/core.c | 46 ++++++++++++++++++++++++++++++++++------------
>  drivers/cxl/cxl.h  | 31 +++++++++++++++++++++++++++----
>  3 files changed, 62 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 8ae89273f58e..5215845e0f89 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -114,7 +114,7 @@ static void cxl_add_cfmws_decoders(struct device *dev,
>                                             cfmws->base_hpa, cfmws->window_size,
>                                             CFMWS_INTERLEAVE_WAYS(cfmws),
>                                             CFMWS_INTERLEAVE_GRANULARITY(cfmws),
> -                                           CXL_DECODER_EXPANDER,
> +                                           CXL_DECODER_PLATFORM,
>                                             flags);
>
>                 if (IS_ERR(cxld)) {
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index a2e4d54fc7bc..69acdd230f54 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -75,9 +75,9 @@ static ssize_t target_type_show(struct device *dev,
>         struct cxl_decoder *cxld = to_cxl_decoder(dev);
>
>         switch (cxld->target_type) {
> -       case CXL_DECODER_ACCELERATOR:
> +       case CXL_DEVICE_ACCELERATOR:
>                 return sysfs_emit(buf, "accelerator\n");
> -       case CXL_DECODER_EXPANDER:
> +       case CXL_DEVICE_EXPANDER:
>                 return sysfs_emit(buf, "expander\n");
>         }
>         return -ENXIO;
> @@ -167,6 +167,12 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
>         NULL,
>  };
>
> +static const struct attribute_group *cxl_decoder_endpoint_attribute_groups[] = {
> +       &cxl_decoder_base_attribute_group,
> +       &cxl_base_attribute_group,
> +       NULL,
> +};
> +
>  static void cxl_decoder_release(struct device *dev)
>  {
>         struct cxl_decoder *cxld = to_cxl_decoder(dev);
> @@ -176,6 +182,12 @@ static void cxl_decoder_release(struct device *dev)
>         kfree(cxld);
>  }
>
> +static const struct device_type cxl_decoder_endpoint_type = {
> +       .name = "cxl_decoder_endpoint",
> +       .release = cxl_decoder_release,
> +       .groups = cxl_decoder_endpoint_attribute_groups,
> +};
> +
>  static const struct device_type cxl_decoder_switch_type = {
>         .name = "cxl_decoder_switch",
>         .release = cxl_decoder_release,
> @@ -458,12 +470,14 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
>         if (interleave_ways < 1)
>                 return ERR_PTR(-EINVAL);
>
> -       device_lock(&port->dev);
> -       if (list_empty(&port->dports))
> -               rc = -EINVAL;
> -       device_unlock(&port->dev);
> -       if (rc)
> -               return ERR_PTR(rc);
> +       if (type != CXL_DECODER_ENDPOINT) {
> +               device_lock(&port->dev);
> +               if (list_empty(&port->dports))
> +                       rc = -EINVAL;
> +               device_unlock(&port->dev);
> +               if (rc)
> +                       return ERR_PTR(rc);
> +       }
>
>         cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
>         if (!cxld)
> @@ -479,10 +493,11 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
>                         .start = base,
>                         .end = base + len - 1,
>                 },
> +               .type = type,
>                 .flags = flags,
>                 .interleave_ways = interleave_ways,
>                 .interleave_granularity = interleave_granularity,
> -               .target_type = type,
> +               .target_type = CXL_DEVICE_EXPANDER,
>         };
>
>         /* handle implied target_list */
> @@ -496,10 +511,17 @@ cxl_decoder_alloc(struct cxl_port *port, int nr_targets, resource_size_t base,
>         dev->bus = &cxl_bus_type;
>
>         /* root ports do not have a cxl_port_type parent */
> -       if (port->dev.parent->type == &cxl_port_type)
> -               dev->type = &cxl_decoder_switch_type;
> -       else
> +       switch (type) {
> +       case CXL_DECODER_PLATFORM:
>                 dev->type = &cxl_decoder_root_type;
> +               break;
> +       case CXL_DECODER_SWITCH:
> +               dev->type = &cxl_decoder_switch_type;
> +               break;
> +       case CXL_DECODER_ENDPOINT:
> +               dev->type = &cxl_decoder_endpoint_type;
> +               break;
> +       }
>
>         return cxld;
>  err:
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b6bda39a59e3..02e0af4c147c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -164,6 +164,11 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>  #define CXL_TARGET_STRLEN 20
>
> +enum cxl_device_type {
> +       CXL_DEVICE_ACCELERATOR = 2,
> +       CXL_DEVICE_EXPANDER = 3,
> +};
> +
>  /*
>   * cxl_decoder flags that define the type of memory / devices this
>   * decoder supports as well as configuration lock status See "CXL 2.0
> @@ -177,8 +182,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>  #define CXL_DECODER_F_MASK  GENMASK(4, 0)
>
>  enum cxl_decoder_type {
> -       CXL_DECODER_ACCELERATOR = 2,
> -       CXL_DECODER_EXPANDER = 3,
> +       CXL_DECODER_PLATFORM,
> +       CXL_DECODER_SWITCH,
> +       CXL_DECODER_ENDPOINT,
>  };
>
>  /**
> @@ -186,19 +192,36 @@ enum cxl_decoder_type {
>   * @dev: this decoder's device
>   * @id: kernel device name id
>   * @range: address range considered by this decoder
> + * @type: the type of this CXL decoder (platform, switch, endpoint)
>   * @interleave_ways: number of cxl_dports in this decode
>   * @interleave_granularity: data stride per dport
>   * @target_type: accelerator vs expander (type2 vs type3) selector
>   * @flags: memory type capabilities and locking
>   * @target: active ordered target list in current decoder configuration
> + *
> + * Abstractly, a CXL decoder represents one of 3 possible decoders:

s/Abstractly, a/A/

Outside of that I like this documentation for describing the
cxl_decoder_X_type options.

> + * 1. Platform specific routing - opaque rules for the memory controller that
> + *    may be communicated via ACPI or devicetree. This decoding has implied
> + *    interleave parameters as well as physical address ranges that are directed
> + *    to the downstream ports of this decoder.
> + * 2. HDM decoder for a switch. Similar to the platform specific routing in that
> + *    it contains a set of downstream ports which receive and send traffic in an
> + *    interleave fashion, the main difference is that the interleave and address
> + *    ranges are controlled by the HDM decoder registers defined in the CXL 2.0
> + *    specification.
> + * 3. HDM decoder for an endpoint. Like the decoder in a switch, this decoder's
> + *    configuration is entirely programmable and defined in CXL spec. Unlike the
> + *    switch's decoder, there is not a set of downstream ports, only the
> + *    underlying media.
>   */
>  struct cxl_decoder {
>         struct device dev;
>         int id;
>         struct range range;
> +       enum cxl_decoder_type type;
>         int interleave_ways;
>         int interleave_granularity;
> -       enum cxl_decoder_type target_type;
> +       enum cxl_device_type target_type;
>         unsigned long flags;
>         struct cxl_dport *target[];
>  };
> @@ -289,7 +312,7 @@ static inline struct cxl_decoder *
>  devm_cxl_add_passthrough_decoder(struct device *host, struct cxl_port *port)
>  {
>         return devm_cxl_add_decoder(host, port, 1, 0, 0, 1, PAGE_SIZE,
> -                                   CXL_DECODER_EXPANDER, 0);
> +                                   CXL_DECODER_PLATFORM, 0);
>  }
>
>  extern struct bus_type cxl_bus_type;
> --
> 2.32.0
>
