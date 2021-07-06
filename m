Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D57C07E96
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jul 2021 18:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA4A61C5B
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jul 2021 18:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhGFSkv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhGFSku (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jul 2021 14:40:50 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE20C061574
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jul 2021 11:38:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 17so20075633pfz.4
        for <linux-cxl@vger.kernel.org>; Tue, 06 Jul 2021 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kmi8lhOEMufwxPa7pRw1X1bSmsLZOQu/JsgtEnQzI5s=;
        b=UmIf6oOeCrYzepwb4HgkBpO2g4EPsU6EXBBzwznOBQV4yqY766fvqkr+JFyH/r4MJb
         t60Da3uE8hBThoW1BqUxyOC1fDAMDl5W1FX7NRqlSPs/3xTrvtXS4A4NrHKeySvBK0FH
         dHO7yhWaji1srssW/25m0fSgRSYl9+5y4tB6Zdyhd9lk2uRicnkRkCS9jQzkKXChppLQ
         3CesBH6zv1iHoB9qdaKGdMjEvffzSMEQA951hoTKw6TwP6umvExhr2TPuOiY81cCXqYn
         6835cTscX08jgcELviC8Ei27boA6HFCcb6r+Gk4q/FBXcntduGfwr6v1/RS8qlCWGxCZ
         FFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kmi8lhOEMufwxPa7pRw1X1bSmsLZOQu/JsgtEnQzI5s=;
        b=aroI6rwYadJ0PDAY87I3DBnqQ8XwShHoYTF0oOMWLIpk5FrPJ2UKR2t3v8RltoIoxm
         IMDCL56KAGlfQ8ZCME8D9YZtuTiTtqahtkgL45f8KGWsZT0BH17LnZoPs12iCeV4x7v/
         x4enoBrA/eKo8UB/TwGV2LK+Zkx5JSosSo9adV7HwfWiItaGqSmRNf8JDdlJq5eCOTHM
         MAhAX8y5Py26fQawzBBNROPa/Hl9n+ekFEEtTe7tAmoGRVXLXaYpR5iuAUHJxgMHotsS
         q6hgeG9U89G1v4VsgxZIDYpI/ceSV1jzKYfphaJwZrIuJ3CxrrAPyQHuf08nelVda56Z
         cFyg==
X-Gm-Message-State: AOAM531QQ+r3HyU5niWFXigxT/laUaX63X7bUF9BAmMtisYl/SFVyfY3
        H/jY0LLsNIHeQXjOAW76TOp5JSCAYAol85bd3tE60w==
X-Google-Smtp-Source: ABdhPJz+rSAUwID0+4dpUd6NdqhGejKi6IIORAJeAA5+iuuWRel0mCS/6XqKitfVKr4f2cytN3KFkZ1xamnbH/Hnbew=
X-Received: by 2002:a63:4c3:: with SMTP id 186mr11971788pge.240.1625596691564;
 Tue, 06 Jul 2021 11:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210706165914.575990-1-ben.widawsky@intel.com>
In-Reply-To: <20210706165914.575990-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 6 Jul 2021 11:38:00 -0700
Message-ID: <CAPcyv4hyc+JwbM02msaTSx730F-kCyAGMGc1QSYT7SW2vcr=kQ@mail.gmail.com>
Subject: Re: [PATCH] cxl: Convert driver id to an enum
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

On Tue, Jul 6, 2021 at 9:59 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> CXL drivers can be of only one type. As such, an enum is the most
> logical way to represent that singleton nature. By converting to an
> enum, it's easy and obvious how to add new driver types.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/cxl.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ec90b32d4bd8..dd005a5e296b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -328,12 +328,17 @@ devm_cxl_add_passthrough_decoder(struct device *host, struct cxl_port *port)
>
>  extern struct bus_type cxl_bus_type;
>
> +enum cxl_driver_id {
> +       CXL_DEVICE_NVDIMM_BRIDGE,
> +       CXL_DEVICE_NVDIMM,
> +};
> +
>  struct cxl_driver {
>         const char *name;
>         int (*probe)(struct device *dev);
>         void (*remove)(struct device *dev);
>         struct device_driver drv;
> -       int id;
> +       enum cxl_driver_id id;
>  };
>
>  static inline struct cxl_driver *to_cxl_drv(struct device_driver *drv)
> @@ -346,9 +351,6 @@ int __cxl_driver_register(struct cxl_driver *cxl_drv, struct module *owner,
>  #define cxl_driver_register(x) __cxl_driver_register(x, THIS_MODULE, KBUILD_MODNAME)
>  void cxl_driver_unregister(struct cxl_driver *cxl_drv);
>
> -#define CXL_DEVICE_NVDIMM_BRIDGE       1
> -#define CXL_DEVICE_NVDIMM              2
> -
>  #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
>  #define CXL_MODALIAS_FMT "cxl:t%d"

Doesn't this break module aliasing? I.e. __stringfy(CXL_DEVICE_NVDIMM)
changes from:

"2" to "CXL_DEVICE_NVDIMM"

?
