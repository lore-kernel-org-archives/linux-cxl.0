Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086FCC48BCD
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Jun 2021 15:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E496C6128A
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Jun 2021 15:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhFIPSw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:18:52 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:43611 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239156AbhFIPSs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Jun 2021 11:18:48 -0400
Received: by mail-pf1-f174.google.com with SMTP id m7so5687997pfa.10
        for <linux-cxl@vger.kernel.org>; Wed, 09 Jun 2021 08:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEXfhkKVesgl6rTue33hw4E6sTEKyZJepGu+zWkT2iU=;
        b=BJWfG2wc6L609hn4iK5PVJ6q7CCJdQ15qzZjlc8msYNL8f6Cm6/ZNEG0Nlf6w8xGAt
         mV47DsmF3QozhtMPibLGcn/GN3Wf5XBQcw2o+HCKPKXYFlFAGAFC4sfS8/X8kFx3GtAV
         G3P4hE5yTwbkahUUtAflgPp7IKR2eUsUmiXD/8wm3nbvvgW0TJD9ymcxIYAYu6ZLICo9
         SQdRbDGxEu/8wkxf/g4LbG6S4cY+hyAAw2WZEhMKhjXpQc8LBj3g3tEDK8U1SoKmhlIo
         5v4v1g48mkRKas3vujw+pDX29QueVhzvJZ+2j2mqQT1gcVyD1No/YGVjYnMbCUQhr0Qn
         TwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEXfhkKVesgl6rTue33hw4E6sTEKyZJepGu+zWkT2iU=;
        b=R0t+hW33dgJ+XteA5ZTyYWqRlAzYQHxkycw2b+PmksDPVwkjhTuChNkY7/9XyTTrFc
         bgce5ZoboZOOPLP7uTONjl9UUNKcsUhojH/NVmSZe5w3OjUy33czVaBr4Nc0j1754C5I
         sy/tYd0XqbjglmE5eRWM1UKNFomA2wGqHEnmMCgbXlGW6X++n+x9UCOVZLHxbrcW3tgm
         hRDqfO7kzCMdotDv/WUwT5iT254ipMZ7gkRFi9q2wrO1qHUr3HS3+xk7rHNVGo7+dt9l
         tQXjQ+sbgs+FM3BgPJjujpWWrt5rJ25oecQ06DxPdcsJxvI5a4MN86uwPzmlzqzjtGuV
         eKyQ==
X-Gm-Message-State: AOAM531IrBGUDl15hRv9FWuek/u/pDuZ3Q+EKKtBgZjxuowBVtfJp/gd
        L8pYnNC4ifB45vkao+4GZomAuNvN6/Frtwcr1ZfQxnI6kUwx/g==
X-Google-Smtp-Source: ABdhPJz7D5POILkdNfndhQKsZ7TKN7wCSaLY+EAtSIjbThxEZlR34xGyi0vEnTc53yaXD5O4gl5dAZbK/xKG21SV950=
X-Received: by 2002:a63:5c4a:: with SMTP id n10mr170203pgm.279.1623251753728;
 Wed, 09 Jun 2021 08:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162295951736.1109360.12642726343803988356.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210608124910.0000329e@Huawei.com> <CAPcyv4jc07GuoOu8HPwVucj7PcdNjLjE1ScwRBDTyQ788Ot4tw@mail.gmail.com>
 <20210609122814.00005ed1@Huawei.com>
In-Reply-To: <20210609122814.00005ed1@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Jun 2021 08:15:42 -0700
Message-ID: <CAPcyv4i9Xv1MceTDzo-9XF70MSWi5FKzw8c56-SFYe55=83p1Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] cxl/acpi: Add downstream port data to cxl_port instances
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jun 9, 2021 at 4:28 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> > > This is a bit inconsistent wrt to what functions get full kernel-doc.
> > > My personal preference would be all the exported functions + any others
> > > where it is particularly useful.
> >
> > I agree with the sentiment for globally exported symbols. In this case
> > they are in the "CXL" module namespace and privately defined in
> > drivers/cxl/ headers. That said, I did document devm_add_cxl_port(),
> > so there's no good reason to skip the documentation on the other
> > devm_cxl_add_* routines... will fix.
>
> Maybe we should consider using symbol namespaces for CXL?
> EXPORT_SYMBOL_NS_GPL() etc

In fact, we already are using that, it's just implicit from the
Makefile with this line:

ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL

> > > > + * Append downstream port data to a cxl_port, note that all allocations
> > > > + * and links are undone by cxl_port deletion and release.
> > > > + */
> > > > +int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
> > > > +               resource_size_t component_reg_phys)
> > > > +{
> > > > +     char link_name[CXL_TARGET_STRLEN];
> > > > +     struct cxl_dport *dport;
> > > > +     int rc;
> > > > +
> > > > +     if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
> > > > +         CXL_TARGET_STRLEN)
> > > > +             return -EINVAL;
> > > > +
> > > > +     dport = kzalloc(sizeof(*dport), GFP_KERNEL);
> > > > +     if (!dport)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     INIT_LIST_HEAD(&dport->list);
> > > > +     dport->dport = get_device(dport_dev);
> > > > +     dport->port_id = port_id;
> > > > +     dport->component_reg_phys = component_reg_phys;
> > > > +     dport->port = port;
> > > > +
> > > > +     rc = add_dport(port, dport);
> > > > +     if (rc)
> > >
> > > If you get an error here, it's not been added to the list, but
> > > in the cxl_dport_release() you remove it from the list. I think you
> > > just want to put and free the device here.
> >
> > The delete is innocuous because of the INIT_LIST_HEAD() above. So the
> > delete will end up doing the right thing and leaving the entry empty
> > again, and that saves the need for custom code to handle that case.
>
> Ah fair enough. I'd missed that INIT.  Not sure I'm keen on that
> approach as it's not in the 'obviously correct' category but it's your
> code to maintain so I'm not that fussed.

I think it's in a similar spirit to devm and the lack of
ida_destroy(), try not to write unwind code if at all possible...
