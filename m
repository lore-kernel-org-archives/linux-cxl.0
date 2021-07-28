Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F78C4338F
	for <linux-cxl@archiver.kernel.org>; Wed, 28 Jul 2021 22:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A27F61019
	for <linux-cxl@archiver.kernel.org>; Wed, 28 Jul 2021 22:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhG1Wem (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 28 Jul 2021 18:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhG1Wel (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 28 Jul 2021 18:34:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E369C061757
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jul 2021 15:34:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e21so4521617pla.5
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jul 2021 15:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJsnOKNYVFNnkRHuFInpXvsd8Blfyo3lMMwHRbUJ6kY=;
        b=zdKR34Sn3zd53NpOlI3kYiM3k87fCa3qBp4tAyZIUuYpvc75nGcyKXh3e27pXsDzkT
         ShooUQcbI5y92FgH9y62THlcCtmc9YwVV4bSxvfx0PP5/2O9pBeCLaWfilRrZLNy0UWE
         wM1hgiVhe+wWxmX6s8FNZwo4cTWHW3weNrhTIjWQjewfA0goXZQ4ft8K3QPd1L7JXn7D
         YResKojv4giTYq77XK+Voq3sBfV0grTP/O5SxHqASdYQXWL29xM/IZ3otdSDKTfci3kg
         kg24dN1bD9t6rY1jpQvBiu1Gha+ugsvf+y9cIxcpwDG834seAs/0CH8xgFygdM8yuPoo
         zYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJsnOKNYVFNnkRHuFInpXvsd8Blfyo3lMMwHRbUJ6kY=;
        b=oDKf7IGCats/m+cxHxNNKqladOnpXPdtXCi2aAlsEZPBfGNkdzjhKgsSi7ZmFM8L8I
         nZ7asM/8+ObJaXY469Uir9GComd2Ui9gs/0wa65yvxgXcPgtfx8ghM6mJSyqB5C6WYDm
         qSG0ALbRYfJvUDMh+ePUWylQjqNxAVfDfyd0hcNVZrTcNJNa5twYe8lMEPxefrYTkrsd
         y/7mkQr8P1nVVxUB6wSA/SY+ErL2TlYcHMwHGoiVzFOme3VfZ/DMeKWCw7xm/y6D4wL7
         EALbK48OHkvCFMtNBdwcPlguhUrozm6k3JM66KBZiGrP0NWkg9vfEbrKf4Smqir0wWUe
         fGKQ==
X-Gm-Message-State: AOAM531+rRnZIKcru5WskJ7DzPVqcfa7c1LE8MotwT3lXzSzdHOk/Bb3
        UX36RMVtNKkZRjN6yeAATeGdh+ngrInu+6EmPJgZdw==
X-Google-Smtp-Source: ABdhPJxqd7OOIQoY+kabMoUGXwd6aKd80ySJ1OuSP3Me2KNwns9492Spe14lVDRtbuzt8Bzsg8iAyGXP+Mi3G9LsPSs=
X-Received: by 2002:a65:5544:: with SMTP id t4mr1048552pgr.240.1627511678611;
 Wed, 28 Jul 2021 15:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210715194125.898305-1-ben.widawsky@intel.com> <20210715194125.898305-5-ben.widawsky@intel.com>
In-Reply-To: <20210715194125.898305-5-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 28 Jul 2021 15:34:27 -0700
Message-ID: <CAPcyv4ivzCJ=6OU2CcWB0ZuVkyK18g8KuBysc6cNjsmDf1nrzg@mail.gmail.com>
Subject: Re: [PATCH 4/6] cxl/mem: Move character device region creation
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
> In order to merge the memdev specific functionality of cxl_pci into
> core, the character device creation currently handled by cxl_pci need to
> be moved. The rest of the changes are largely cut/paste, the actual
> functional change is done here in preparation.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/core/bus.c | 12 ++++++++++++
>  drivers/cxl/mem.h      |  2 ++
>  drivers/cxl/pci.c      | 14 +-------------
>  3 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 33196813ebcb..8c2351c52d2b 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -22,6 +22,8 @@
>   * instantiated by the core.
>   */
>
> +int cxl_mem_major;
> +EXPORT_SYMBOL_GPL(cxl_mem_major);

This symbol export is necessary here, but it's not needed by the end
of the series which leads me to question this fine grained split. I
think the shutdown patch is suitable to split, but this one and the
last can be squashed.

>  static DEFINE_IDA(cxl_port_ida);
>
>  static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
> @@ -632,12 +634,22 @@ EXPORT_SYMBOL_GPL(cxl_bus_type);
>
>  static __init int cxl_core_init(void)
>  {
> +       dev_t devt;
> +       int rc;
> +
> +       rc = alloc_chrdev_region(&devt, 0, CXL_MEM_MAX_DEVS, "cxl");
> +       if (rc)
> +               return rc;
> +
> +       cxl_mem_major = MAJOR(devt);

I'd rather have cxl_core_{init,exit}() call something like
cxl_memdev_{init,exit}() that way cxl_mem_major can become static
again.
