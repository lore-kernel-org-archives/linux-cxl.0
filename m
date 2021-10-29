Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EC5C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 21:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5577D61056
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 21:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhJ2VDD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhJ2VDC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Oct 2021 17:03:02 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C273BC061570
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 14:00:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so11480163pji.5
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mWNX2NM1Fqkk/Osj98x5UrJLdeiZzioqc8sVts/twiY=;
        b=3ctAIAecnEEjTGymkYZAUJkprK20U2P/FEuzyeHMUbk+n9OekMowZAEZn7YVVZWXfz
         9NSXUwv93gaSRjuDgB+ibRoB5j5bwrwFYR56Ob8cthGxjTZfmt37u7ubxnlzmo5aCvEN
         oULHLqca8by1ZoM2tV36KjNdnP8mLK2DCVzOaczdKfGljdbGCQUE0ujWs2n14IOMoWP0
         S9CyzUmkeDgQjb+u+/N+MJNrKDO0SfO5cijVIwcr2FnctOmgtZixSpsekzuQ7D4Hh9wy
         RuYUtQ4lyGg1g7GuOm4ZH+WnUB9H808iyZp/F0rFrmCBZwVh0Cdfrqp+4hM7Cr3bejMk
         dVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWNX2NM1Fqkk/Osj98x5UrJLdeiZzioqc8sVts/twiY=;
        b=OPmK1CKUNJDAL7n8u33UsrxaVrHLHXQZBzBjDQRq7PDJuTBwywYIN0sDk0jRnGlOFb
         v69Nu3yJ6gy7XVZemikFRaDp44Zy5r80Kw72YAPQA3Ac9vEJ6dOeQKN0sgE8a0UkpwQj
         YFu0QdKYGxA0UIijTkYZmcmhIIlwXULv+d2MIZuPnpQsWXBKXz3KSYQ6zpgJPt8HRw9C
         IBrhb8LrbsJTnJGPawd1M/VcbM+PG7j9pLDevvYuFscrXHH86AxQ+IlDBKAJobPH5Edr
         ++JkRsODYXjXfSJjNg2Xa1t8+rHGAWTYatJSWbRPrAtEMkHFVEt8Uh51+14ZvEP7r57g
         epcQ==
X-Gm-Message-State: AOAM533VEzNNxxB488YtKuLP6mvcauFlibQZJ9wUDC5zUdi/KilOQOUc
        WktxVvqn0JvBUqe/6cOWAssE53H1BDuD1qA7ZB9/a8GwFvI=
X-Google-Smtp-Source: ABdhPJx/TO4DdhaBgdO2sUZCCn6OWMQMHglF8PHAt68oRvB7K0wMxnFVGaiI8KlB99eycPfwK1wGIZ2In5+tPRWAjH0=
X-Received: by 2002:a17:902:ab50:b0:13f:4c70:9322 with SMTP id
 ij16-20020a170902ab5000b0013f4c709322mr11643585plb.89.1635541233344; Fri, 29
 Oct 2021 14:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com> <20211022183709.1199701-7-ben.widawsky@intel.com>
In-Reply-To: <20211022183709.1199701-7-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Oct 2021 14:00:21 -0700
Message-ID: <CAPcyv4iiMFCUEg+8zk6yqSmA_9jXjkjkEpYdj4zVr8n=GbodvA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/28] cxl: Introduce endpoint decoders
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
> Endpoints have decoders too. It is useful to share the same
> infrastructure from cxl_core. Endpoints do not have dports (downstream
> targets), only the underlying physical medium. As a result, some special
> casing is needed.
>
> There is no functional change introduced yet as endpoints don't actually
> enumerate decoders yet.

The nr_targets type change either needs to be commented on here, or
moved to its own patch.

Otherwise, this looks good.

>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/core/bus.c | 40 ++++++++++++++++++++++++++++++++--------
>  drivers/cxl/cxl.h      |  3 ++-
>  2 files changed, 34 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 454d4d846eb2..5564a71773e2 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -175,6 +175,12 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
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
> @@ -184,6 +190,12 @@ static void cxl_decoder_release(struct device *dev)
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
> @@ -196,6 +208,11 @@ static const struct device_type cxl_decoder_root_type = {
>         .groups = cxl_decoder_root_attribute_groups,
>  };
>
> +static bool is_endpoint_decoder(struct device *dev)
> +{
> +       return dev->type == &cxl_decoder_endpoint_type;
> +}
> +
>  bool is_root_decoder(struct device *dev)
>  {
>         return dev->type == &cxl_decoder_root_type;
> @@ -483,7 +500,8 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
>         return rc;
>  }
>
> -struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> +struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> +                                     unsigned int nr_targets)
>  {
>         struct cxl_decoder *cxld, cxld_const_init = {
>                 .nr_targets = nr_targets,
> @@ -491,7 +509,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>         struct device *dev;
>         int rc = 0;
>
> -       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
> +       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
>                 return ERR_PTR(-EINVAL);
>
>         cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> @@ -510,8 +528,11 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>         dev->parent = &port->dev;
>         dev->bus = &cxl_bus_type;
>
> +       /* Endpoints don't have a target list */
> +       if (nr_targets == 0)
> +               dev->type = &cxl_decoder_endpoint_type;
>         /* root ports do not have a cxl_port_type parent */
> -       if (port->dev.parent->type == &cxl_port_type)
> +       else if (port->dev.parent->type == &cxl_port_type)
>                 dev->type = &cxl_decoder_switch_type;
>         else
>                 dev->type = &cxl_decoder_root_type;
> @@ -538,12 +559,15 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>         if (cxld->interleave_ways < 1)
>                 return -EINVAL;
>
> -       port = to_cxl_port(cxld->dev.parent);
> -       rc = decoder_populate_targets(cxld, port, target_map);
> -       if (rc)
> -               return rc;
> -
>         dev = &cxld->dev;
> +
> +       port = to_cxl_port(cxld->dev.parent);
> +       if (!is_endpoint_decoder(dev)) {
> +               rc = decoder_populate_targets(cxld, port, target_map);
> +               if (rc)
> +                       return rc;
> +       }
> +
>         rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
>         if (rc)
>                 return rc;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7f2e2bdc7883..91b8fd54bc93 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -293,7 +293,8 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
>
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> -struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets);
> +struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> +                                     unsigned int nr_targets);
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
>  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
>
> --
> 2.33.1
>
