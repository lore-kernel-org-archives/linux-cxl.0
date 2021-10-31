Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D783C433F5
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 18:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B7861077
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 18:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhJaSNK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 31 Oct 2021 14:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhJaSNG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 31 Oct 2021 14:13:06 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112AFC061714
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 11:10:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p20so9026094pfo.12
        for <linux-cxl@vger.kernel.org>; Sun, 31 Oct 2021 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v1V3Miu55/zjpF20qO5ZuVSd9w/SLMsRk3crZSxeUuM=;
        b=nuFTOtepmWhVes0BRcOKd+3k0FAUbY5Zus6KfLB1iFRpSFVC846a+rujQZtAi1me3t
         Kgdn7msFbwJN/9piNGt6v0M4ZH99Orwb5pflrnc+84n+TScglegNoGx5DiavpvGLZhZq
         zkYdwcYvNPu9B7jEkuBqpYALBI9nf9/JdDB01XUzdUqStZuby/BDopbIuDVlVJXjYsmy
         eVrtwQmFMNfvdpdwdZZjAZLPP+d3+AMF7ctMRsFc4EfVHnMCqyz7KR1A92AUQan0yJyr
         QBRuRwWQ1Db0kS1VKtHqtu7EFdodH1mhnxfqNRzg03VfI2f26QN90FpFmiLOYsTL+zVJ
         Nz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1V3Miu55/zjpF20qO5ZuVSd9w/SLMsRk3crZSxeUuM=;
        b=rjOYFGa0nXegQ3xmvxCw9meuFOkT5/hFv9gbpXZdaLwBrJ7rYqeDkkM1uyP2oYb5nB
         y0t6UpLFxDdQKwXkcJZqMj7O9FaoFgrX5ARLYSaSRRvOwzYVMDv1MXPRnKxRuA7rENP6
         yAUmGOVpbu3JOO7hZeNU8q1aeVkzYeLwBYfJ+ssnWOjbNcWU7GyfYjwBS/XgncbXxm9O
         HvI8+xeaIT2C2+49JxydSVGfp5fEE4dpJafQIaDzducr2iHshxuSfPqzK0Wo7wh4O1I7
         d3orcVxAg8qdX3tS3eYuGwSAfbR0o6+apmc/aGQksHO3JIz9tRdzpXeG6LDjjE9IUw+4
         CvDA==
X-Gm-Message-State: AOAM530AjIYSnTMVEoAc1BeIh3q5M42PV2E3F2Uo9LaEC+gdjsZBTfHG
        7kvws2VfuE0jrzFcdv65LGljPyswYOmEIGgoFCbY6w==
X-Google-Smtp-Source: ABdhPJzMuwzUuEWAAY1kTa4TdqA9ThixRHaAzb0L0uX4Or/C/aY4KmHTvS8v0BCMwSAH4lJT0h/ZicT3HRjMLkrtESQ=
X-Received: by 2002:a63:6302:: with SMTP id x2mr766472pgb.5.1635703833935;
 Sun, 31 Oct 2021 11:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-9-ben.widawsky@intel.com> <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
 <CAPcyv4jUDXuV-R8HFzJb1K5HK6xaGMor3JH-4AFKJqPJk9FtdA@mail.gmail.com>
In-Reply-To: <CAPcyv4jUDXuV-R8HFzJb1K5HK6xaGMor3JH-4AFKJqPJk9FtdA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 31 Oct 2021 11:10:23 -0700
Message-ID: <CAPcyv4gpA=DH0SQvRdmF6dY01mZ1S-gGEWTSDbb+0ajYtyNv0A@mail.gmail.com>
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

On Sun, Oct 31, 2021 at 10:53 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Oct 29, 2021 at 6:37 PM Dan Williams <dan.j.williams@intel.com> wrote:
> [..]
> >
> > Proposed infrastructure for a new cxl_port_decoder_autoremove():
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 3163167ecc3a..78f8313a1069 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -374,6 +374,11 @@ static int add_root_nvdimm_bridge(struct device
> > *match, void *data)
> >         return 1;
> >  }
> >
> > +static void clear_cxl_topology_host(void *data)
> > +{
> > +       set_cxl_topology_host(NULL);
> > +}
> > +
> >  static int cxl_acpi_probe(struct platform_device *pdev)
> >  {
> >         int rc;
> > @@ -382,6 +387,11 @@ static int cxl_acpi_probe(struct platform_device *pdev)
> >         struct acpi_device *adev = ACPI_COMPANION(host);
> >         struct cxl_cfmws_context ctx;
> >
> > +       set_cxl_topology_host(host);
> > +       rc = devm_add_action_or_reset(host, clear_cxl_topology_host, host);
> > +       if (rc)
> > +               return rc;
> > +
> >         root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
> >         if (IS_ERR(root_port))
> >                 return PTR_ERR(root_port);
> > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > index 17a4fff029f8..3146b6aa0a2f 100644
> > --- a/drivers/cxl/core/bus.c
> > +++ b/drivers/cxl/core/bus.c
> > @@ -3,6 +3,7 @@
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> > +#include <linux/rwsem.h>
> >  #include <linux/pci.h>
> >  #include <linux/slab.h>
> >  #include <linux/idr.h>
> > @@ -563,6 +564,84 @@ int cxl_decoder_autoremove(struct device *host,
> > struct cxl_decoder *cxld)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_decoder_autoremove, CXL);
> >
> > +void trigger_decoder_autoremove(void *data)
> > +{
> > +       struct cxl_decoder *cxld = data;
> > +       struct device *host = get_cxl_topology_host();
> > +
> > +       /* The topology host driver beat us to the punch */
> > +       if (!host)
> > +               return;
>
> This can be dropped or turned into a WARN_ON() because something is
> wrong if the port removal is being triggered after the topology host
> has already went away.

It further occurs to me that if all ports are guaranteed to be torn
down by topology host removal, then we might not even need to play
these games at all. cxl_acpi is already unregistering all of its child
ports, we just need the property that if a port adds a child port it
remove it. Then I don't think we even need cxl_topology_host games.
