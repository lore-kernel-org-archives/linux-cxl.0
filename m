Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430CDC388F9
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Nov 2020 17:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C78C02072C
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Nov 2020 17:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1DH8VH1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgKKRRu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Nov 2020 12:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgKKRRu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Nov 2020 12:17:50 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABBFC0613D1
        for <linux-cxl@vger.kernel.org>; Wed, 11 Nov 2020 09:17:49 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id v22so3084470edt.9
        for <linux-cxl@vger.kernel.org>; Wed, 11 Nov 2020 09:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQoq2RQCuafra2/12uiljwu+rCNgXWp3T6t2+sz8FTY=;
        b=1DH8VH1JKBZbEDlGbtroiVXOVC0/URrnHQ4E8/tzT86j+/9Tva1H6wuleBdwke7NC0
         OtOJ5SRmQEMcfqXHix2vJ5Kn8HKTL1/oLfya12FbOsO3FsuLYwnjILQiqYj0mmVqQmXe
         Cuzt9YWBUz/3UdIPnqCEFjRKthmWHf8atJVS3KK4AVkpnTPVBpBpbAZHnG8I43hcBvXW
         Dk0rimoptgAKqXt+ANHhaSihWslTP3l33/U4JZ+UD25Y7G9behZfPGt1U9buudqH9QV0
         03q5re0g52eZpMu1pz1uDdM8rCL00SnesUh0Gsb1iRIs7nPiQag7jBP9pfO1pyFr2IEo
         Ll0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQoq2RQCuafra2/12uiljwu+rCNgXWp3T6t2+sz8FTY=;
        b=e6fr7UDMSTCDYm7NN1h9OEfb/+wE3eHn93l/oMLpSZCb/fZbQkG3GkXH8T2Kga1oWp
         g47IdLRJsXrg9jdOjnqCpLs+qSXxJqNNLTp9SQ2CuU4mIBveGYZEyfD4S1G3Ky36kNiu
         DB4lkn+wrOsTj9wPxmXxVoBC2l7GNfZqXvnvo3tMts8pQcbd32qmnUITvDFPbO1HsWuO
         wsJDlLgXbNxlYIYgeogpt0YNeuNKrF0RPYP6UAvjAlQGVBTzNT95Y/KLI4yuJ6IJKGNC
         SfdMnTucnE0rWV8re8wkesq/QbzZZAhYvbdE5c69yXJJOKK3kIp8rueRAmFVQO4TSjSW
         hbqQ==
X-Gm-Message-State: AOAM533GYLqFn+oUxeq2TQvhyfLI5d7sSbQYU54D2pBWVBhz+jxDcMkN
        2F+Shqx0716mGcNBDoMUUFH/7K9wOhyxHPI51k14hQ==
X-Google-Smtp-Source: ABdhPJwTwbtangRhABKsob3Xr0CrmoBXrd71z27l2ZDvApiVBFS1mPJU50IdPt5HUcdZ+QRQ7ssj77pEMJ8fTBox2mA=
X-Received: by 2002:aa7:ca44:: with SMTP id j4mr511437edt.354.1605115068596;
 Wed, 11 Nov 2020 09:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-4-ben.widawsky@intel.com> <20201111071231.GC7829@infradead.org>
In-Reply-To: <20201111071231.GC7829@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Nov 2020 09:17:37 -0800
Message-ID: <CAPcyv4iA_hNc=xdcbR-eb57W9o4br1BognSr5Sj4pAO3uMm69g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] cxl/mem: Add a driver for the type-3 mailbox
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Nov 10, 2020 at 11:12 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Nov 10, 2020 at 09:43:50PM -0800, Ben Widawsky wrote:
> > +config CXL_MEM
> > +        tristate "CXL.mem Device Support"
> > +        depends on PCI && CXL_BUS_PROVIDER != n
>
> depend on PCI && CXL_BUS_PROVIDER
>
> > +        default m if CXL_BUS_PROVIDER
>
> Please don't set weird defaults for new code.  Especially not default
> to module crap like this.

This goes back to what people like Dave C. asked for LIBNVDIMM / DAX,
a way to blanket turn on a subsystem without needing to go hunt down
individual configs. All of CXL is "default n", but if someone turns on
a piece of it they get all of it by default. The user can then opt-out
on pieces after that first opt-in. If there's a better way to turn on
suggested configs I'm open to switch to that style. As for the
"default m" I was worried that it would be "default y" without the
specificity, but I did not test that... will check. There have been
times when I wished that distros defaulted bleeding edge new enabling
to 'm' and putting that default in the Kconfig maybe saves me from
needing to file individual config changes to distros after the fact.

>
> > +// Copyright(c) 2020 Intel Corporation. All rights reserved.
>
> Please don't use '//' for anything but the SPDX header.

Ok, I find // following by /* */ a bit ugly, but I don't care enough to fight.

>
> > +
> > +             pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_OFFSET, &vendor);
> > +             pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
> > +             if (vendor == PCI_DVSEC_VENDOR_CXL && dvsec == id)
> > +                     return pos;
> > +
> > +             pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
>
> Overly long lines again.

I thought 100 is the new 80 these days?

> > +static void cxl_mem_remove(struct pci_dev *pdev)
> > +{
> > +}
>
> No need for the empty remove callback.

True, will fix.

>
> > +MODULE_AUTHOR("Intel Corporation");
>
> A module author is not a company.

At least I don't have a copyright assignment clause, I don't agree
with the vanity of listing multiple people here especially when
MAINTAINERS has the contact info, and I don't want to maintain a list
as people do drive-by contributions and we need to figure out at what
level of contribution mandates a new MODULE_AUTHOR line. Now, that
said I would be ok to duplicate the MAINTAINERS as MODULE_AUTHOR
lines, but I otherwise expect MAINTAINERS is the central source for
module contact info.
