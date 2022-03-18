Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAE3C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Mar 2022 17:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiCRRPE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Mar 2022 13:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbiCRRPD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Mar 2022 13:15:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FBB15FDB
        for <linux-cxl@vger.kernel.org>; Fri, 18 Mar 2022 10:13:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e6so5462696pgn.2
        for <linux-cxl@vger.kernel.org>; Fri, 18 Mar 2022 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/GutwBJVZBDT4ZVpQlKfjM8i6ASlMzT8ih0C1p3e3k=;
        b=blpcAdIPW3F08OxKyQJJrpHUC2s+UYBMU5vzcrkGgac39jt6Ud4Hk0Gt5irraCU6ob
         w8GN4C9ctPWo10eE1jofVkgGgZSTFoCGzJAREiw6AKRL9NnqseojQwCTh1gjfqizOP7f
         abpIDzqYsILDAFuGO5DKl2u8kFDLfS1lcmwrkaBdh+1ZTnLu8St7Kj8GYQXd2KGn7beJ
         LbGAUzJpfilO6hobiI5OAuokwNI0YCQFafSOHO8A732+gkZ6aj0hC7lzKskHTneuCxpn
         XYt+j+fUIwnkhFge1DotlDdIcQPkO9TcZ7M8yAakzw0t719UzI247KdN36stiqYsa0ye
         40KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/GutwBJVZBDT4ZVpQlKfjM8i6ASlMzT8ih0C1p3e3k=;
        b=7PPaWhajKjXSvPk8zb6+5dKMuOUQI5LG4U52u9K6bHzBoPt89volfQeinIhN1nloWe
         299qb3lQtE15ewL61LhOiafmLLdWYfs10I7qZw+2MWUiyHy0AbX3ZF3jJUq1lr3YrNpn
         r22qLQf6cn2ghycx2M4kVhkLIFpRuyi5msKw2FOq2Fw6h2tnEhhUXQ5yhlr4TaEd190u
         2t9rFIrCpIDp7ZptDYKTLwVhpfGDcMXdmOloHnFSNGmWujEXC67RRwR8tSWCp6W2oZM3
         EkRYs/lemArSlGQG0t+EQL7flhUew16epY0Mmqi1r3Cwyd6JHXJu3cSj4U89Gxt/NUg5
         qM3A==
X-Gm-Message-State: AOAM533UGm3/3/+xx53CY/Bb1Lxv8an1P4MIDinRBKzmmnAcijhdW5NE
        +qJfpr6fNHLn7q8JRBcwafR16a368U+xkNJMnfIxsw==
X-Google-Smtp-Source: ABdhPJxH0FGfFKt283r5GUdkvrdhnVUMzxTWmOGe9MV0ft0KmCjPEMJnALJmM7RuLWZAjhy5nyVCk5mYcOk9jMhNEkc=
X-Received: by 2002:a63:5c53:0:b0:381:309e:e72c with SMTP id
 n19-20020a635c53000000b00381309ee72cmr8673934pgm.40.1647623623502; Fri, 18
 Mar 2022 10:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164740403286.3912056.2514975283929305856.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220317100757.00005f2b@Huawei.com>
In-Reply-To: <20220317100757.00005f2b@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Mar 2022 10:13:33 -0700
Message-ID: <CAPcyv4iEMw7pd2ZdYEK48Pj-Er72thkcKCUmCoBOTzcg_rZrcw@mail.gmail.com>
Subject: Re: [PATCH 2/8] cxl/pci: Cleanup cxl_map_device_regs()
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 17, 2022 at 3:08 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 15 Mar 2022 21:13:52 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Use a loop to reduce the duplicated code in cxl_map_device_regs(). This
> > is in preparation for deleting cxl_map_regs().
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Trivial style comments inline.  Otherwise LGTM
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> > ---
> >  drivers/cxl/core/regs.c |   51 ++++++++++++++++++-----------------------------
> >  1 file changed, 20 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > index bd6ae14b679e..bd766e461f7d 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -211,42 +211,31 @@ int cxl_map_device_regs(struct pci_dev *pdev,
> >                       struct cxl_device_regs *regs,
> >                       struct cxl_register_map *map)
> >  {
> > +     resource_size_t phys_addr =
> > +             pci_resource_start(pdev, map->barno) + map->block_offset;
>
> I'm not totally convinced by this refactoring as it's ugly either
> way...  Still your code, and I don't care that strongly ;)

Fair enough, but isn't there intrinsic beauty in a diff that deletes
more code than it adds?

The cleaner aspect to me is that the RAS Capability Structure support
can be added with a one line change rather than a new if block in
cxl_map_component_regs().

>
> >       struct device *dev = &pdev->dev;
> > -     resource_size_t phys_addr;
> > -
> > -     phys_addr = pci_resource_start(pdev, map->barno);
> > -     phys_addr += map->block_offset;
> > -
> > -     if (map->device_map.status.valid) {
> > -             resource_size_t addr;
> > +     struct mapinfo {
> > +             struct cxl_reg_map *rmap;
> > +             void __iomem **addr;
> > +     } mapinfo[] = {
> > +             { .rmap = &map->device_map.status, &regs->status, },
>
> Combining c99 style .rmap for first parameter and then not doing it
> for the second is a bit odd looking.  Was there a strong reason for
> doing this?  I'd just drop the ".rmap =" as it's not as though
> we need to look far to see what it's setting.

Good catch, yeah, not sure why I typed it that way, will fix.
