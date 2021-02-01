Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63963C433E9
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB4D64ED7
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhBAWC6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBAWC4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Feb 2021 17:02:56 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B022AC0613D6
        for <linux-cxl@vger.kernel.org>; Mon,  1 Feb 2021 14:02:15 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bl23so26776923ejb.5
        for <linux-cxl@vger.kernel.org>; Mon, 01 Feb 2021 14:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHpWXQOSv7s9aWUS8YqFMt0x/4KDBay3sfDCNqdteVQ=;
        b=yRi8mguQqwGyP74Lz8HnidEorwfF7klt4qQMuE6uyPGrI0nnVf3UO1/tbJR+kWOOGR
         dWmIQcJgh8tUURN0ieUfGpl3soucjW0wrSDuKx6Y9XL66sU8opnIg7sxdwSNSWp0fLIr
         nQTxV7ahPPxceFtgJKNxCIJWgLTD7hfKHYxTCqUPpp1scoT0JWUDr3XWsuBhkaWsp2Ko
         ku9Jrb6DLqZ+8d/xmEcVgGxMbIkRA+sIynA/F4cTTRjVtBfrkLzvKwBPHtBFKCEVpHC4
         s94dtYIxVabjk/YTMSmQlvYnC5/uXpJNxnnYFAza3R9pXfMZNpwI9PbJpgEUEG7m6ZhM
         cCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHpWXQOSv7s9aWUS8YqFMt0x/4KDBay3sfDCNqdteVQ=;
        b=onKRwtSwWH/u7M3gqMmSH0Vveg+gWLp70UEHvgM3hDn1zA53NnqwS8qg4P8kynU3Bo
         aus/eX650iyMOlsdlT0QSL8W+xCp9tK+OvhREK05F9Dw1XHNAIy08SSPwwTeEg6SV3J0
         0xTQiIqtHtTJKCOy89MJU2sRcLAoE4WnX9TqxH8kr9O3NU3UyWZ1g5TY4JhbkaySB7N3
         UB00s/5BDI3acinhG9nV2Y396iSmfPujTgd8q8E9q4AM1CKZJ7IXh4zb0693h0wCy+b7
         G8fB/xYtz0c1vXPfc2+R3bX9ViXY9Cy8ZLCj+I5nI34Sg0WLmXEgSHRUxpUVrve3yAT7
         k6PA==
X-Gm-Message-State: AOAM531rj2KxoCH8YkRmTWNJIHiUqNEDBD/YwLgo6/7Aah2ttQaaYc3a
        6uWNZyWow/BrC1pLgptgQCnCAk2jkllRpyrKENw0O6vlz0w=
X-Google-Smtp-Source: ABdhPJwx5HQJkiYYzBPXX7BYLe1eriXrLIkYHDMYupmuWFH/I1Xqh4x+vyz3z88NdGsEK2HXTHd3EhXx58RQNYJdZQ8=
X-Received: by 2002:a17:906:af6b:: with SMTP id os11mr8117536ejb.472.1612216934397;
 Mon, 01 Feb 2021 14:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com> <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com>
 <20210201165352.wi7tzpnd4ymxlms4@intel.com> <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
In-Reply-To: <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Feb 2021 14:02:11 -0800
Message-ID: <CAPcyv4jyojkRqkXPK=ZgMfUATVNUf71GZsgQuarygz4QEM1o-w@mail.gmail.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
To:     David Rientjes <rientjes@google.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 1, 2021 at 1:51 PM David Rientjes <rientjes@google.com> wrote:
>
> On Mon, 1 Feb 2021, Ben Widawsky wrote:
>
> > On 21-01-30 15:51:49, David Rientjes wrote:
> > > On Fri, 29 Jan 2021, Ben Widawsky wrote:
> > >
> > > > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > > > +{
> > > > + const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > > > +
> > > > + cxlm->mbox.payload_size =
> > > > +         1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> > > > +
> > > > + /* 8.2.8.4.3 */
> > > > + if (cxlm->mbox.payload_size < 256) {
> > > > +         dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> > > > +                 cxlm->mbox.payload_size);
> > > > +         return -ENXIO;
> > > > + }
> > >
> > > Any reason not to check cxlm->mbox.payload_size > (1 << 20) as well and
> > > return ENXIO if true?
> >
> > If some crazy vendor wanted to ship a mailbox larger than 1M, why should the
> > driver not allow it?
> >
>
> Because the spec disallows it :)

Unless it causes an operational failure in practice I'd go with the
Robustness Principle and be liberal in accepting hardware geometries.
