Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30323C433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Dec 2021 21:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344098AbhLCVKH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbhLCVKH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Dec 2021 16:10:07 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBEBC061751
        for <linux-cxl@vger.kernel.org>; Fri,  3 Dec 2021 13:06:43 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so3516489pjb.1
        for <linux-cxl@vger.kernel.org>; Fri, 03 Dec 2021 13:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQpzrxuS1C20zBM7chBd7cN+Lfuz0ToH/W6JL8/xVXU=;
        b=M8MSih3OUfPx/BnQbGdeL2n8Y+T86NY9fgLbTypD+vIilYHrGqf1MVmsS+zbv0i6J4
         +Jtodh7R+FwpAQUqt7wwXHG51OAIwjMUafpsnLtTEiW6TVK6FgKfXDbQc1PIXuRhU3A4
         7mhjEOuBd78aR0pf2qlRda2wWVMehOKVFJp5RJJJpGOP+XZfR2sn6Ad/rC33z14yKB1S
         97d5RIVeQHgHK4NhSA9YdjW5uZkXkSTyLKwI3c15Ga5ffO5ATfdj7HdQ5tA5ij/YMQQU
         gKXiWONTFqokrwXlZIM2UaljVtbmV4VMFNyPmO2D9eN9uHbSwB1XwQjWO0dNPG8q2Znc
         Wjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQpzrxuS1C20zBM7chBd7cN+Lfuz0ToH/W6JL8/xVXU=;
        b=S3L1hzsvsBhCzDDwoQLg8D9v6+XmJRmm7/SBaljYj+CynujyuY3lNZ74L/ltg1Up7k
         UlMUXpx+M0tVjvImcAItkqBSGt9OdZcDy8nIcy8PAuZh3bveb3NbjNi8m7uHWYkyLzEB
         XgDAlYhF5UvrDFQOqIajL5WQCHQ4RQg+yQoJN3OuQOLDvQQDTID/vgnYRd/5z1DXBReU
         lQL/3lvULtOHCvk5hjtcEhcwWMLeJg3HN/3Lx8pFOA8W1X9RHr/7IfwL/PcYXDaOiZph
         KteTqLnn8e8XdgPnCCeh8prZXd/Y9TuMpYw4Uy4IG4cxBl8ttbpAaf5n4GpP2+QM/FJQ
         72DA==
X-Gm-Message-State: AOAM531oBUTwCS9v/NwLmtlt5AVmDmawqQZT2+bElz7s1phDLR4tLxfH
        /+KvJTACnQ5VvvVn+v6LZL9u64NhD5z0vwzgONR0lQ==
X-Google-Smtp-Source: ABdhPJxdpQWaA02LM0ZZ8qZv8106leQXE+gttnb+9AOuJearOz+VgO5pMlFCaEb4zyCY6nHGSh0kXsVjA4r7lXmE0+w=
X-Received: by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr25212527plb.4.1638565602654; Fri, 03
 Dec 2021 13:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20211202043750.3501494-1-ben.widawsky@intel.com>
 <20211202043750.3501494-5-ben.widawsky@intel.com> <CAPcyv4gQGeeBvPHwLC3h0mE75+dZ=5SujRY1+vZuUyCjvjUA6w@mail.gmail.com>
In-Reply-To: <CAPcyv4gQGeeBvPHwLC3h0mE75+dZ=5SujRY1+vZuUyCjvjUA6w@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 3 Dec 2021 13:06:34 -0800
Message-ID: <CAPcyv4iWS++obGT96HT0CGHjffEcufwg0iNSeja3PDRSEZoZow@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] cxl: Introduce topology host registration
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Dec 1, 2021 at 9:58 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Dec 1, 2021 at 8:40 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > The description of the CXL topology will be conveyed by a platform
> > specific entity that is expected to be a singleton. For ACPI based
> > systems, this is ACPI0017. This cxl_topology_host is needed as a
> > constraint for when CXL.mem connectivity can be verified from root to
> > endpoint. Given that endpoints can attach at any point in time relative
> > to when the root arrives CXL.mem connectivity needs to be revalidated at
> > every topology host arrival / depart event.
> >
> > cxl_test makes for an interesting case. cxl_test creates an alternate
> > universe where there are possibly two root topology hosts (a real
> > ACPI0017/CEDT, and a fake ACPI0017/CEDT). For this to work in the
> > future, cxl_acpi (or some future platform host driver) will need to be
> > unloaded first.
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> > Changes since v1
> > - Commit message overhaul (Dan)
>
> More critically this fixes an uninitialized variable bug in the call
> to create the root port.

Oh wait, I misread it didn't fix it, see below...

>
> So this is missing:
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> However, I have line of sight to fixup all the get_topology_host users
> to just walk the device tree, so I think we can get by without this
> facility for now.
>
> > ---
> >  drivers/cxl/acpi.c     | 18 ++++++++++---
> >  drivers/cxl/core/bus.c | 57 +++++++++++++++++++++++++++++++++++++++---
> >  drivers/cxl/cxl.h      |  5 +++-
> >  3 files changed, 73 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 9f88dec03b33..7bcb54e9fe00 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -225,8 +225,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >                 return 0;
> >         }
> >
> > -       port = devm_cxl_add_port(host, match, dport->component_reg_phys,
> > -                                root_port);
> > +       port = devm_cxl_add_port(match, dport->component_reg_phys, root_port);
> >         if (IS_ERR(port))
> >                 return PTR_ERR(port);
> >         dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
> > @@ -377,6 +376,11 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
> >         return 1;
> >  }
> >
> > +static void clear_topology_host(void *data)
> > +{
> > +       cxl_unregister_topology_host(data);
> > +}
> > +
> >  static int cxl_acpi_probe(struct platform_device *pdev)
> >  {
> >         int rc;
> > @@ -385,7 +389,15 @@ static int cxl_acpi_probe(struct platform_device *pdev)
> >         struct acpi_device *adev = ACPI_COMPANION(host);
> >         struct cxl_cfmws_context ctx;
> >
> > -       root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
> > +       rc = cxl_register_topology_host(host);
> > +       if (rc)
> > +               return rc;
> > +
> > +       rc = devm_add_action_or_reset(host, clear_topology_host, host);
> > +       if (rc)
> > +               return rc;
> > +
> > +       root_port = devm_cxl_add_port(host, CXL_RESOURCE_NONE, root_port);

@root_port can't be an argument and a result to devm_cxl_add_port.

I have this fixed up in my reworks.
