Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A219C433DB
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Jan 2021 21:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F259123122
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Jan 2021 21:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436668AbhALVhM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436661AbhALUHV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Jan 2021 15:07:21 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43E7C061794
        for <linux-cxl@vger.kernel.org>; Tue, 12 Jan 2021 12:06:40 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id g12so3099709ejf.8
        for <linux-cxl@vger.kernel.org>; Tue, 12 Jan 2021 12:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/Bid2Bzf98jE1/ALAKGTMu2+XIpeX//lGOiyhOAPLE=;
        b=vhrrzDmitO32JAO3cpPHjbqdMSMUZDuwupYPaErRNdmyLCV9CGhPdYK6oTrgJG74+m
         I9dA7oEIptk1EhB30sBwuzhsn5ped+8hrj1SEpOIehrqgvt9hLGZusi5QYNsLyb0Ojr7
         B5CZvlBXkQak1yX5cCoTDYZjpURO/BDj90CBV2xV11nCqustJMw6QGBur7B+HWFMThJz
         1UOpx1uPYSC7PIQzDXmNwWVBl2xqVAawLUUMn5pIwD3C/PuDUKVuv9cePx/NSJz7tGiC
         JaIZx/W2kwjLwrF97+S1fQrkm406AotYB5qwe5dQ+9CSge06C4wEogikQR+XPc1DtPae
         9wSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/Bid2Bzf98jE1/ALAKGTMu2+XIpeX//lGOiyhOAPLE=;
        b=AfyJwplU0OXduFrUwu+pKKuoxvEIcL0p6hqnT8uTpdeE1/HlSlzbkZexsdDAlJHA7r
         38fTNZJ/Gb9VH9HPrCyp/s32UjPk09o24dXN0Uy1niKBw1ilbsq0Fj/4vQIwrpp+nV0T
         T6HEzWmSYqOY4T3R14lQMOgqYf7UKmFvBWiJKcoVLxdUSynHLBPhlI/vy8eXVw7qL4jB
         ObvU9wNF906AZS+r12gHTW1G9OXoz/RdkDuZPqtbwtTP8sww9epdbuPeBuyqWnznvMVb
         8uktVEfdlWV89Ywj/ZAJNPMKYKJYzrqSV/ud0iFl883PEyxRSKqpEO7b4l8ckINeJgbd
         PVbw==
X-Gm-Message-State: AOAM533I6ma12/gM/sZR3AJV/EVpNRVS0tHt9uXTAhSh4LfeQ9kWSL6w
        VhbMaYzgtr92FHj0vka0KM5FwGJiZs5vj36uDp4abA==
X-Google-Smtp-Source: ABdhPJyfN4mVkZqUgmpVifgODbiKiUV7zPHfN/mvTykoOz6wGwySd2pfuLRTAFzoWqiTJ14Yjd/67QsQSjvEqEh7UX8=
X-Received: by 2002:a17:906:2707:: with SMTP id z7mr357027ejc.418.1610481999273;
 Tue, 12 Jan 2021 12:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-5-ben.widawsky@intel.com> <20210112190103.00004644@Huawei.com>
In-Reply-To: <20210112190103.00004644@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Jan 2021 12:06:30 -0800
Message-ID: <CAPcyv4iGVPgu_c0GOYTuAQyFJgfMuU5S45Ukd968+DV--Y6miw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/16] cxl/mem: Introduce a driver for
 CXL-2.0-Type-3 endpoints
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 12, 2021 at 11:03 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 11 Jan 2021 14:51:08 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > From: Dan Williams <dan.j.williams@intel.com>
> >
> > The CXL.mem protocol allows a device to act as a provider of "System
> > RAM" and/or "Persistent Memory" that is fully coherent as if the memory
> > was attached to the typical CPU memory controller.
> >
> > With the CXL-2.0 specification a PCI endpoint can implement a "Type-3"
> > device interface and give the operating system control over "Host
> > Managed Device Memory". See section 2.3 Type 3 CXL Device.
> >
> > The memory range exported by the device may optionally be described by
> > the platform firmware memory map, or by infrastructure like LIBNVDIMM to
> > provision persistent memory capacity from one, or more, CXL.mem devices.
> >
> > A pre-requisite for Linux-managed memory-capacity provisioning is this
> > cxl_mem driver that can speak the mailbox protocol defined in section
> > 8.2.8.4 Mailbox Registers.
> >
> > For now just land the driver boiler-plate and fill it in with
> > functionality in subsequent commits.
> >
> > Link: https://www.computeexpresslink.org/download-the-specification
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> Just one passing comment inline.
>
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > new file mode 100644
> > index 000000000000..005404888942
> > --- /dev/null
> > +++ b/drivers/cxl/mem.c
> > @@ -0,0 +1,69 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/io.h>
> > +#include "acpi.h"
> > +#include "pci.h"
> > +
> > +static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>
> Is it worth pulling this out to a utility library now as we are going
> to keep needing this for CXL devices?
> Arguably, with a vendor_id parameter it might make sense to have
> it as a utility function for pci rather than CXL alone.

Sure, cxl_mem_dvsec() can move to a central location, but I'd wait for
the first incremental user to split it out.
