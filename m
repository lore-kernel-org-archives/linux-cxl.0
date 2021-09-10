Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D858FC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 19:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DBE611CC
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 19:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhIJTUx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbhIJTUr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 15:20:47 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9ACC061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 12:19:35 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q68so2713601pga.9
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 12:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FFUPNmcpi0fbVrdhZiUCTe49bCRQ8pwPY+Ucyew4Q8=;
        b=wbBZOvk0r06K9c8DRoMFgJegj09Nf00q3H48X0oVV4IKoQ57gOfynrUBnfHyv5NXDy
         igCI1CbI3H7gmaQnMNSWusdHtT8P5+kABRs3uOAqrfYyvsF3gtsPvsviD55o+Yg0HOCB
         PvXUsshCmt+NticfDGNP+s6tKe4Dk/HSrcpJWfZxWUe2HgIoPNXRuparcNq/o9o7AQ4t
         maw8FipBR7elr7zU8EC5itrrPVvm6+sCyaVjOvPgCNbkUJSENu60CNQ3uVgQ57v30s5g
         PigT85/1IIaili4adryyGgVMNMViPGYy54sxbz0YXvHhkWJ6Irbe6e1ZZIsGkhgNKcUa
         cN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FFUPNmcpi0fbVrdhZiUCTe49bCRQ8pwPY+Ucyew4Q8=;
        b=H6sFzQs8I8Lv+CAzxVqdfDEYcNI0PT01P2QRnf/BbNyZZDjrx+eug10cYb31aHW9+z
         bf+u2m3IgYnVipVaPZDEczFEF0sNHCyA2Cmym6atOyctRAcrtcODxi+OrFwWIaXQDzE8
         ANI1QRg3UItxiTKPPn97YSZMTG1ckpUS7YaMXWiFLakwkM7I+Y0vwWeq5HBxyN9cmW7g
         IXrFxPXhRG9eWzAchlyhCUDXBL0Q4XEUx2FwL6yZEuR5vNrvvnAqxwLToNcGDE3xnnD/
         GJW7JXS6gET3h1wvY65Qmr1WRl7x7PyyScj3v0V7FXN56BS2kuqFqDeM7SxJfNdYsk7B
         syBg==
X-Gm-Message-State: AOAM531KJDIoAHrFcMPepHISScYmmc82VkTVo2vxOJleN6Kj53N9mksi
        w2XOuftWLxJXZqcUEnXgocUco1q9cyDFVfZgjFwkiw==
X-Google-Smtp-Source: ABdhPJwae/fIA3HfZ9N6remklOazWDQtrIk0HjH1y/Zp0rzqdWSPsfaPmWg+rC8B/lLo9Mm24SPRYgb5Hr4GnYZYEUU=
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id
 b140-20020a621b92000000b003eb3f920724mr9496650pfb.3.1631301575421; Fri, 10
 Sep 2021 12:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com> <20210902195017.2516472-5-ben.widawsky@intel.com>
In-Reply-To: <20210902195017.2516472-5-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 12:19:24 -0700
Message-ID: <CAPcyv4gbVtZywtzYVFS_KAQ_aHGHDQtke=eeVSv3pdz=CfVOhA@mail.gmail.com>
Subject: Re: [PATCH 04/13] cxl: Introduce endpoint decoders
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
> Endpoints have decoders too. It is useful to share the same
> infrastructure from cxl_core. Endpoints do not have dports (downstream
> targets), only the underlying physical medium. As a result, some special
> casing is needed.
>
> There is no functional change introduced yet as endpoints don't actually
> enumerate decoders yet.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/core/bus.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 8d5061b0794d..6202ce5a5ac2 100644
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
> @@ -472,7 +489,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>         struct device *dev;
>         int rc = 0;
>
> -       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
> +       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
>                 return ERR_PTR(-EINVAL);
>
>         cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> @@ -491,8 +508,11 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>         dev->parent = &port->dev;
>         dev->bus = &cxl_bus_type;
>
> +       /* Endpoints don't have a target list */
> +       if (nr_targets == 0)
> +               dev->type = &cxl_decoder_endpoint_type;

Do you also plan to introduce the concept of endpoint ports, and if
yes should that come before this patch? That would seem to be more
robust than, for example, allowing a switch port to carry an endpoint
decoder object as this allows.
