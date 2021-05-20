Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE82C433ED
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 17:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F9C6105A
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 17:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhETRoI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 May 2021 13:44:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:24888 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231752AbhETRoG (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 20 May 2021 13:44:06 -0400
IronPort-SDR: S/OPJ86AZO2lbF5TsvDZb9VAyh2+S9ILg1lNSRY8deXsg57Ihs88nU95dl1+nzmROwLgdgpL2k
 nxwp524Z1qyQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="198203329"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="198203329"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 10:42:44 -0700
IronPort-SDR: gw1dT1YGXSyJqiXemMXFCkgirIiONYPZhGPCwMaIc8hKRuMDKMjycdp26Yn+pY4/cM9ITae7rb
 fLT/sFHxVbwQ==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="543682823"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 10:42:44 -0700
Date:   Thu, 20 May 2021 10:42:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] cxl/mem: Fully decode device capability header
Message-ID: <20210520174244.GC1837122@iweiny-DESK2.sc.intel.com>
References: <20210506223654.1310516-1-ira.weiny@intel.com>
 <20210506223654.1310516-2-ira.weiny@intel.com>
 <CAPcyv4iV-Xq7eGBHavETiKW=kfucxDnua3a4j6MKtswz=n4gRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iV-Xq7eGBHavETiKW=kfucxDnua3a4j6MKtswz=n4gRA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, May 19, 2021 at 05:50:44PM -0700, Dan Williams wrote:
> On Thu, May 6, 2021 at 3:37 PM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > Previously only the capability ID and offset were decoded.
> >
> > Create a version MASK and decode the additional version and length
> > fields of the header.
> >
> 
> I'm not seeing a justification for why Linux would want this patch?
> 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/cxl/core.c | 15 ++++++++++++---
> >  drivers/cxl/cxl.h  |  1 +
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> > index b3c3532b53f7..21553386e218 100644
> > --- a/drivers/cxl/core.c
> > +++ b/drivers/cxl/core.c
> > @@ -501,12 +501,21 @@ void cxl_setup_device_regs(struct device *dev, void __iomem *base,
> >
> >         for (cap = 1; cap <= cap_count; cap++) {
> >                 void __iomem *register_block;
> > -               u32 offset;
> > +               u32 hdr, offset, __maybe_unused length;
> 
> What's the point of reading the length and not using it?

Then length is needed in a future patch and it seemed easier to split by saying
we are just going to decode the entire header as a patch.

Ben caught this too because sparse found the unused variable...

Let me see about squashing this into the future patch.

> If this is
> used in a future patch then wait until then to add it.

ok.

> 
> >                 u16 cap_id;
> > +               u8 version;
> > +
> > +               hdr = readl(base + cap * 0x10);
> > +
> > +               cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK, hdr);
> > +               version = FIELD_GET(CXLDEV_CAP_HDR_VERSION_MASK, hdr);
> > +               if (version != 1)
> > +                       dev_err(dev, "Vendor cap ID: %x incorrect version (0x%x)\n",
> > +                               cap_id, version);
> 
> It's not an error. Any future version needs to be backwards
> compatible. All this is doing is ensuring that when hardware is
> updated old kernels will start spamming the log.

Yep...

After deleting this I think I should just 'forward squash' the length into the
patch where I need it.

Ira

> 
> >
> > -               cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
> > -                                  readl(base + cap * 0x10));
> >                 offset = readl(base + cap * 0x10 + 0x4);
> > +               length = readl(base + cap * 0x10 + 0x8);
> > +
> >                 register_block = base + offset;
> >
> >                 switch (cap_id) {
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 0211f44c95a2..9b315c069557 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -15,6 +15,7 @@
> >  #define   CXLDEV_CAP_ARRAY_COUNT_MASK GENMASK_ULL(47, 32)
> >  /* CXL 2.0 8.2.8.2 CXL Device Capability Header Register */
> >  #define CXLDEV_CAP_HDR_CAP_ID_MASK GENMASK(15, 0)
> > +#define CXLDEV_CAP_HDR_VERSION_MASK GENMASK(23, 16)
> >  /* CXL 2.0 8.2.8.2.1 CXL Device Capabilities */
> >  #define CXLDEV_CAP_CAP_ID_DEVICE_STATUS 0x1
> >  #define CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX 0x2
> > --
> > 2.28.0.rc0.12.gb6a658bd00c9
> >
