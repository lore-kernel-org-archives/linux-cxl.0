Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9C6C433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 21:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89F760EE0
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 21:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbhIUVnB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Sep 2021 17:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbhIUVnA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Sep 2021 17:43:00 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6D3C061574
        for <linux-cxl@vger.kernel.org>; Tue, 21 Sep 2021 14:41:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p12-20020a17090adf8c00b0019c959bc795so664210pjv.1
        for <linux-cxl@vger.kernel.org>; Tue, 21 Sep 2021 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5UJWUg1OUPgiF7PhFFFwZMyu0uXaJfqnlJ9Oaj9kzlk=;
        b=BPEYiBRD7ueF7x4tplqUbQPQxI8FV91i3htYPtDROSSb8YY/hEgAKcpGEdnObLBqkO
         Byz3RFEfRgeXLI3C/V9fh6vr0awfsR7GLc+TwPJ5p7M7f0LPA0HoHRWPqdBxmyTTuugw
         fz3bUXwzZ1ecVw1b1qjH4snghnUwGz8lc+TY8vO9frt6QTMwrfbNkyZwDp297Q+TAJ+R
         8cBzJaRpCCDwyKpBp+Edco32J+648oXGsnYzdEckcF7XbV9RKhIuBPT2zDYqMOFtYlHV
         7qruM4coG0jfwW7rYptFdu5lkKl/SRC5xlViArSlxQNynXNyJzN7i34arUFnEOY9ger/
         dH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5UJWUg1OUPgiF7PhFFFwZMyu0uXaJfqnlJ9Oaj9kzlk=;
        b=RIkFF0v0hP87tnM70iH2KkzYRJ7sxxGVnM6an7dTOLSjla93x/+6PQNv7dlxNRzyhN
         yQz+uICD9qbe/16Yc4BEwzon5fLdfybyz8F/r4EDksjLSfjdlDQHHsV23sTnnK0FEXEi
         DFqKnVbdbFznLBlbtVN13Jndgk6DyDp/Soi7OdifEwH2HpzKubkqNR9Yo0Adpo8rbvXD
         W4UqOTUyaLbcrZBWK26g/G8VJwasq3cuHIOcSKtHVwGOIEH5bOfhZ3jSPTIikdA6Ov05
         sBWj5bdS2OZPAto/IsMU64Gqx/ce0qE4lbTac9gNz1OJo+jwLEFehe3vVGLuI+14s5X6
         Hrcw==
X-Gm-Message-State: AOAM5332D1GJRa2mmld452lF1U7FfPMAGGor83a8zB8kx5w6Mt6YhscX
        zZX1rVisfVEyQULtCHrE82ucez6ZkNeo0nGVQ2MHi49I+xIn3w==
X-Google-Smtp-Source: ABdhPJwaLBVmtHbB9emAmJYvMHY516NCb7Y05F8+XHAkrugVa/q9ittNUkwqHJvT3exgpuqQq/qJLkyxcDe4VkUDGLQ=
X-Received: by 2002:a17:902:e80f:b0:13b:721d:f750 with SMTP id
 u15-20020a170902e80f00b0013b721df750mr29254934plg.18.1632260490745; Tue, 21
 Sep 2021 14:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210915155946.308339-1-ben.widawsky@intel.com>
In-Reply-To: <20210915155946.308339-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 21 Sep 2021 14:41:20 -0700
Message-ID: <CAPcyv4jQN1cbeAVj4BGqz6yAx9TkovoJTqG7_gUeyVx=wUZ5ow@mail.gmail.com>
Subject: Re: [PATCH v2] cxl/core/bus: Document and tighten up decoder APIs
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

On Wed, Sep 15, 2021 at 9:00 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Since the code to add decoders for switches and endpoints is on the
> horizon, document the recently added interfaces that will be consumed by
> them.
>
> Part of the original version of this patch was subsumed by
> f5786a5aedfc ("cxl/core: Split decoder setup into alloc + add")

It's dangerous to quote 'pending' commits. The stable commit id for this is now:

48667f676189 ("cxl/core: Split decoder setup into alloc + add")

...I would have just fixed this up on applying, but some notes below.

This overall feels like a patch that should wait to go in with first
introduction of endpoint decoders.

>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
> v2:
> - Dropped removal of host from cxl_decoder_add (Ben)
> - Change nr_targets to unsigned int (Jonathan)
> - Move description of 0 special case to param kdoc (Dan, Ben)
> - Reword kdocs to be more accurate (Jonathan, Ben)
> - Add back debug message to decoder_populate_targets (Ben)
> ---
>
>  drivers/cxl/core/bus.c | 34 ++++++++++++++++++++++++++++++++--
>  drivers/cxl/cxl.h      |  2 ++
>  2 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 396252749477..d242afe08402 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -474,6 +474,7 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
>                         rc = -ENXIO;
>                         goto out_unlock;
>                 }
> +               dev_dbg(&cxld->dev, "%s: target: %d\n", dev_name(dport->dport), i);

Seems like this deserves its own patch since it's not related to $subject.

>                 cxld->target[i] = dport;
>         }
>
> @@ -483,13 +484,28 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
>         return rc;
>  }
>
> -struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> +/**
> + * cxl_decoder_alloc - Allocate a new CXL decoder
> + * @port: owning port of this decoder
> + * @nr_targets: downstream targets accessible by this decoder. All upstream
> + *             ports and root ports must have at least 1 target. Endpoint
> + *             devices will have 0 targets. Callers wishing to register an
> + *             endpoint device should specify 0.
> + *
> + * A port should contain one or more decoders. Each of those decoders enable
> + * some address space for CXL.mem utilization. A decoder is expected to be
> + * configured by the caller before registering.
> + *
> + * Return: A new cxl decoder to be registered by cxl_decoder_add()
> + */
> +struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> +                                     unsigned int nr_targets)
>  {
>         struct cxl_decoder *cxld;
>         struct device *dev;
>         int rc = 0;
>
> -       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
> +       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets == 0)

This looks broken as the above text says that 0 is now an allowed
value. Shouldn't this be:

-    if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
+    if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)

...?

>                 return ERR_PTR(-EINVAL);
>
>         cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> @@ -521,6 +537,20 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>  }
>  EXPORT_SYMBOL_GPL(cxl_decoder_alloc);
>
> +/**
> + * cxl_decoder_add - Add a decoder with targets
> + * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
> + * @target_map: A list of downstream ports that this decoder can direct memory
> + *              traffic to. These numbers should correspond with the port number
> + *              in the PCIe Link Capabilities structure.
> + *
> + * Certain types of decoders may not have any targets. The main example of this
> + * is an endpoint device. A more awkward example is a hostbridge whose root
> + * ports get hot added (technically possible, though unlikely).

I don't think this is possible, certainly not worth calling out unless
you want to prompt someone to go audit the PCI side for proper
operation in this case.

The endpoint note is enough.

> + *
> + * Return: Negative error code if the decoder wasn't properly configured; else
> + *        returns 0.
> + */
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>  {
>         struct cxl_port *port;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7d6b011dd963..e632cc8da091 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -289,6 +289,8 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
>  struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets);
> +struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> +                                     unsigned int nr_targets);

Why are there now 2 different cxl_decoder_alloc() function signatures?
