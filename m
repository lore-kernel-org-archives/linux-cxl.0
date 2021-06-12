Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4D7C48BE6
	for <linux-cxl@archiver.kernel.org>; Sat, 12 Jun 2021 00:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C0F613CC
	for <linux-cxl@archiver.kernel.org>; Sat, 12 Jun 2021 00:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhFLAUF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 20:20:05 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:45811 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLAUE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 20:20:04 -0400
Received: by mail-pg1-f169.google.com with SMTP id q15so3694767pgg.12
        for <linux-cxl@vger.kernel.org>; Fri, 11 Jun 2021 17:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=82VEF0jU1aJg9IivNM3m8n8dgHxa1D7N8oMOze7zYHk=;
        b=f50m71z8fzdIGfE7Y1k4CF+fILypd/f+RSCP+5hsPzlV2yOkbMSY1Exh8cX28+6nPv
         y1v0NCmCAh5Jav98nPF4m/swPoYLRACuydpXqKNnJU34gmhBj8AA70sYv0+wn0N3BBSy
         /Cjda73UeW/5QwZoypoj4TDloXzEYjVYcFQilHT2AuW3I9Sgd6xngdQbBRO2WJkc7NdI
         PYtc31+vH4vS5c2rtuQEV7Ugz2InitN+YsxbdQrZ6WTMZLkiFw0OVaCmFSRbdwKNCDli
         299HZ+aqoHoiuoDXHT2lGGh+QsYi1BjnPa5lFWv5QCfULYiOdCfTOLh/DCE7lXRcPaCi
         KmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82VEF0jU1aJg9IivNM3m8n8dgHxa1D7N8oMOze7zYHk=;
        b=CkbhFDw7LQTz0O128zC9yhKpVFfmE/Q0F0vRh3/Pv+RM7sTs1NlYmfRPGIggSQ5Bqa
         +74Z5inTqykrmoJHL3w4+YNu/w+O3eQJUgzjCDnbcIga4NfDveYowifQHcA0gjFxWAre
         b7yG6zIEJuO6kW7iyShfMqoiouIu/XYYQ4CrUEPbY0eNl8bdyauX3afsWhr+EahrO35i
         3s+PxJF+foCmcGhh8WsFhpnNZkEOBPjZCa8rVeYM/wavYTnHfmLJt+ojLJDfXhazNJ5a
         1jaShWuFNpgUtI4cRPcGmPHIR2PACUNaBat9qA5YcsQTCZ3W0f7h/x6b2mmCzfuRKTyb
         +NUg==
X-Gm-Message-State: AOAM531q8Nd4iVQ0W+AYWjtkptygQD7zFicOpUxAfPo45X40FGo4xD+p
        wrG79OoXfPIZztcl6E4ncVyy3dRyXnXVWPXCPhNQxw==
X-Google-Smtp-Source: ABdhPJyOAEteNdyg6O8Dbz88K+bj8bLFU6PbLJJ0CFXNCtRPQWcQl42nzP4m6yawNlLjvphveb+OHCg5pp83hphY18s=
X-Received: by 2002:a62:8647:0:b029:2c4:b8d6:843 with SMTP id
 x68-20020a6286470000b02902c4b8d60843mr4616917pfd.71.1623457026192; Fri, 11
 Jun 2021 17:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <162336395765.2462439.11368504490069925374.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162336397948.2462439.5230237265829121099.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210611124703.000033af@Huawei.com>
In-Reply-To: <20210611124703.000033af@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 11 Jun 2021 17:16:55 -0700
Message-ID: <CAPcyv4gjA-AmYkUphLBmmnM1GFWcJ4WJHNobyw833DVp3XPwqw@mail.gmail.com>
Subject: Re: [PATCH 4/5] libnvdimm: Drop unused device power management support
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jun 11, 2021 at 4:47 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 10 Jun 2021 15:26:19 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > LIBNVDIMM device objects register sysfs power attributes despite nothing
> > requiring that support. Clean up sysfs remove the power/ attribute
> > group. This requires a device_create() and a device_register() usage to
> > be converted to the device_initialize() + device_add() pattern.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Trivial comment below. Looks good.
>
> > ---
> >  drivers/nvdimm/bus.c |   45 +++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 37 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> > index a11821df83b5..e6aa87043a95 100644
> > --- a/drivers/nvdimm/bus.c
> > +++ b/drivers/nvdimm/bus.c
> > @@ -363,8 +363,13 @@ struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
> >       nvdimm_bus->dev.groups = nd_desc->attr_groups;
> >       nvdimm_bus->dev.bus = &nvdimm_bus_type;
> >       nvdimm_bus->dev.of_node = nd_desc->of_node;
> > -     dev_set_name(&nvdimm_bus->dev, "ndbus%d", nvdimm_bus->id);
> > -     rc = device_register(&nvdimm_bus->dev);
> > +     device_initialize(&nvdimm_bus->dev);
> > +     device_set_pm_not_required(&nvdimm_bus->dev);
> > +     rc = dev_set_name(&nvdimm_bus->dev, "ndbus%d", nvdimm_bus->id);
> > +     if (rc)
> > +             goto err;
>
> Maybe mention in patch description that you also now handle errors in
> dev_set_name()?

Yeah, that's a philosophy change from when this code was first written.
