Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D7CC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 18:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2642761250
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 18:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhIJSwh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 14:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhIJSwh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 14:52:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9FEC061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 11:51:26 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 5so1731378plo.5
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 11:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5aWl0HcmfrTQ3Euk5dwHWxu7O1MyxM+kiTKzLk6k3Us=;
        b=aLvT1fVyPBzB1G/BeirM8DQ0D4+qeZKaqPD8NkGIQ13mxhQfLwPR8RujtTdOSGZC3I
         XR+krCeL9hoxeNUuh9WE0Hv2cjmGNtqQ/xPbJbQ24G8rj6C+oiUgcNacA10ceEY4j4KH
         kGcA8tR0TbaY04DBa8lhDqILIkFxOeuwexTrvdagyS0jzwEy6n0SqD9cy+9vOMlACvmT
         LmuPUzR9nnFX1yfD8XitnVze+Usjdp7lgKZmw9ocyhmOojZniGN4GshH7RCxnuwtHzqk
         xLOQ5enxlCvp3XiRqozsF8/SGZcEzLHXN+rPJ6C9d9qfgU2K1X0yO4hbb4+iMx8t+w38
         YDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5aWl0HcmfrTQ3Euk5dwHWxu7O1MyxM+kiTKzLk6k3Us=;
        b=yliwbRzgu8mh0sVxRKkrfQpBIIVvyXPsWSFBNSgIW6Fw6Tdy4icpt/qsFNfpSaAXPL
         +H2PLmz8NFdfTCm//3veLVFr9EETm295dS7PGaJ0C5cnpticBxfvRxsVHhLpPFCSIojK
         4zR+HjgWafTN1eRnYYDVblBKgyWR63hoFzB8yL2Awa9VSLKdPNGimJ9a9h7jboZ7jWxp
         7pDKKNwOPzxaTsSi0nEsd46P7E86/jhSmK+5NuDN2aiDmcaYp2bg+lSy2ZTi8NFqa/Fp
         13RlFkKddOtc1UHQdMR41kwYtFqw5mlyFqNkn93tM3VWMfE65KuJjwAsEnrv4TvgYPU0
         NAjA==
X-Gm-Message-State: AOAM531GjwR2azXR6dNmQj7EkkUEMhlM0yU0BkhcKTKqvb9Z4NypPkc7
        w8pL6SK40Z8H2DsT/QGgdfRcqbXliK2gv/Vhg/RFCA==
X-Google-Smtp-Source: ABdhPJyfHsrr/kdKTs5MZ/4qppFQiUzFVJPr1ylEeIbNk1LIGwCYowDes1/bfLe9s/axJGvEI5LLULAyYh8beJRDoP4=
X-Received: by 2002:a17:902:8c93:b0:13a:1dd7:485b with SMTP id
 t19-20020a1709028c9300b0013a1dd7485bmr8815497plo.4.1631299885634; Fri, 10 Sep
 2021 11:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com> <20210902195017.2516472-3-ben.widawsky@intel.com>
In-Reply-To: <20210902195017.2516472-3-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 11:51:14 -0700
Message-ID: <CAPcyv4gF12w-rF5Qh0Y8=JxxDEdahnX4KVvy7SwJhY2hLBhChw@mail.gmail.com>
Subject: Re: [PATCH 02/13] cxl/core/bus: Add kernel docs for decoder ops
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
> Since the code to add decoders for switches and endpoints is on the
> horizon, document the new interfaces that will be consumed by them.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/core/bus.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 3991ac231c3e..9d98dd50d424 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -453,6 +453,19 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
>  }
>  EXPORT_SYMBOL_GPL(cxl_add_dport);
>
> +/**
> + * cxl_decoder_alloc - Allocate a new CXL decoder
> + * @port: owning port of this decoder
> + * @nr_targets: downstream targets accessible by this decoder
> + *
> + * A port should contain one or more decoders. Each of those decoders enable
> + * some address space for CXL.mem utilization. Therefore, it is logical to

I think a "therefore it is logical" statement is changelog fodder.
Once the code is in the kernel it does not need to keep justifying its
existence.

> + * allocate decoders while enumerating a port. While >= 1 is defined by the CXL
> + * specification, due to error conditions it is possible that a port may have 0
> + * decoders.

This comment feels out of place. Why does cxl_decoder_alloc() care how
many decoders a port has? I would expect this comment on a cxl_port
api that is trying to walk decoders.

> + *
> + * Return: A new cxl decoder which wants to be added with cxl_decoder_add()

s/which wants to be added/to be registered by/

> + */
>  struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>  {
>         struct cxl_decoder *cxld;
> @@ -491,6 +504,21 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>  }
>  EXPORT_SYMBOL_GPL(cxl_decoder_alloc);
>
> +/**
> + * cxl_decoder_add - Add a decoder with targets
> + * @host: The containing struct device. This is typically the PCI device that is
> + *        CXL capable

No, this is the device doing the enumeration. After the devm removal
for decoder creation it's now only being used to print a debug
message. Do you have another use for it? Perhaps it should just be
deleted. The new cxl_decoder_autoremove() handles what @host was used
for previously.

> + * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
> + * @target_map: A list of downstream ports that this decoder can direct memory
> + *              traffic to. These numbers should correspond with the port number
> + *              in the PCIe Link Capabilities structure.
> + *
> + * Return: 0 if decoder was successfully added.
> + *
> + * Certain types of decoders may not have any targets. The main example of this
> + * is an endpoint device. A more awkward example is a hostbridge whose root
> + * ports get hot added (technically possible, though unlikely).
> + */
>  int cxl_decoder_add(struct device *host, struct cxl_decoder *cxld,
>                     int *target_map)
>  {
> --
> 2.33.0
>
