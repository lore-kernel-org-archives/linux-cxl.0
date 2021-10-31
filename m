Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E1DC433F5
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 17:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BAEB6108C
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 17:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhJaR4F (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 31 Oct 2021 13:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhJaR4F (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 31 Oct 2021 13:56:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E791C061570
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 10:53:33 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t11so10120469plq.11
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RILX+yoIcYvGxjGiHlxPt4Yycxsxx7YKOHTuHZIgJRI=;
        b=i8ciwZDv7OxRW+eKuChsRJZf0OeYb3VCdaeaCODT3ZAYktyaYJpW9g1cmoc/tokqFe
         kD5FPT19tuq93ylR1NtOhEn740ca1XW1OP+nnRwH0nMPtWab5BcDkyoN+ZeWLpo8GhFi
         OOwkVC1nNYr/iGV0Kh4H/02606I5W6WtpSEqRWWgGzZvE7j46lfa0jzH8mj4g/gXBSYs
         W9lWwNDLpR31FcPD0FwnWep3N74qEe0cDdzrWfFmhe/gwliQTS9kv2zbObUpxXT17yRo
         TZORozkq7KLHcyaX2I5jIFFLDH5SbiqWHi3PN8mJF1+4+rPq/1Blo9lU5sRIMPHKfdhp
         w8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RILX+yoIcYvGxjGiHlxPt4Yycxsxx7YKOHTuHZIgJRI=;
        b=HQySPICDibFkdhubyQgrYmKpvHewzvm0ugjzbp5392GnRuPyI2wzGseoJOsk44pDW1
         M8yxUStA0x/UYeUg/DH6NWvCH9WZfT+u05v13g+YBgfaW5uLbb4lttk9LP64dIFskz79
         cDP2xQkRGscI/lK+Ar7gR1Gcp12N16aVy4Ir2+iCilIvqf8aK42ssMkBOaGKM8E2miqw
         Yi+r4Esqu3izfLsiCUtChkTX2SAbsmRkDzCfr7Rz5xmjqTNrpOlsH/konVQNPlmZKn2f
         RdKHe8vh6SfvxsG3IvH5qgsnlA1qmy5gogk8ShBHv5VxI+oxxm8xL33qj7OSxeHNcVwr
         pLtA==
X-Gm-Message-State: AOAM531D3Fe57xNalqwI/G2zNJmottw4up6JiV4Nwn013w5aUBhUT02U
        moCv2oC6KywY5LlrsRPZVCHKZM4MQ3LuTujeJpzcUg==
X-Google-Smtp-Source: ABdhPJyeg6PCDBUfpaxNDiIsbKXunGSedZyZ0s26d/+IBKfmkVius1YC0ewx5SJcCjddJ/DgNopVM2lFY4C6yc3SmYE=
X-Received: by 2002:a17:90b:3b88:: with SMTP id pc8mr24025278pjb.93.1635702813049;
 Sun, 31 Oct 2021 10:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-9-ben.widawsky@intel.com> <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
In-Reply-To: <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 31 Oct 2021 10:53:22 -0700
Message-ID: <CAPcyv4jUDXuV-R8HFzJb1K5HK6xaGMor3JH-4AFKJqPJk9FtdA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/28] cxl/port: Introduce a port driver
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

On Fri, Oct 29, 2021 at 6:37 PM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
>
> Proposed infrastructure for a new cxl_port_decoder_autoremove():
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3163167ecc3a..78f8313a1069 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -374,6 +374,11 @@ static int add_root_nvdimm_bridge(struct device
> *match, void *data)
>         return 1;
>  }
>
> +static void clear_cxl_topology_host(void *data)
> +{
> +       set_cxl_topology_host(NULL);
> +}
> +
>  static int cxl_acpi_probe(struct platform_device *pdev)
>  {
>         int rc;
> @@ -382,6 +387,11 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>         struct acpi_device *adev = ACPI_COMPANION(host);
>         struct cxl_cfmws_context ctx;
>
> +       set_cxl_topology_host(host);
> +       rc = devm_add_action_or_reset(host, clear_cxl_topology_host, host);
> +       if (rc)
> +               return rc;
> +
>         root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
>         if (IS_ERR(root_port))
>                 return PTR_ERR(root_port);
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 17a4fff029f8..3146b6aa0a2f 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -3,6 +3,7 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/rwsem.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/idr.h>
> @@ -563,6 +564,84 @@ int cxl_decoder_autoremove(struct device *host,
> struct cxl_decoder *cxld)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_decoder_autoremove, CXL);
>
> +void trigger_decoder_autoremove(void *data)
> +{
> +       struct cxl_decoder *cxld = data;
> +       struct device *host = get_cxl_topology_host();
> +
> +       /* The topology host driver beat us to the punch */
> +       if (!host)
> +               return;

This can be dropped or turned into a WARN_ON() because something is
wrong if the port removal is being triggered after the topology host
has already went away.

> +
> +       devm_remove_action(host, cxld_unregister, &cxld->dev);

Should be devm_release_action().
