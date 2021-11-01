Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C657C433FE
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 21:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F95360FD9
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 21:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhKAVxe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 17:53:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:2731 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231192AbhKAVxd (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Nov 2021 17:53:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="211183027"
X-IronPort-AV: E=Sophos;i="5.87,201,1631602800"; 
   d="scan'208";a="211183027"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 14:50:43 -0700
X-IronPort-AV: E=Sophos;i="5.87,201,1631602800"; 
   d="scan'208";a="576365693"
Received: from jisears-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.137.88])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 14:50:42 -0700
Date:   Mon, 1 Nov 2021 14:50:40 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 12/28] cxl/core: Store component register base for
 memdevs
Message-ID: <20211101215040.tfapgsw66acn4up4@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-13-ben.widawsky@intel.com>
 <CAPcyv4gR0w4CFPsDoiBd6o=ZyToiyRWFuj8GfTNieOeopHwLEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gR0w4CFPsDoiBd6o=ZyToiyRWFuj8GfTNieOeopHwLEg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-31 13:13:32, Dan Williams wrote:
> On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >

[snip]

> > -       cxlmd = devm_cxl_add_memdev(cxlm);
> > +       /*
> > +        * If the component registers can't be found, the cxl_pci driver may
> > +        * still be useful for management functions so don't return an error.
> 
> This comment makes sense...
> 
> > +        *
> > +        * XXX: Creating the device is going to kick of the cxl_mem probing.
> > +        * That probe requires the component registers. Therefore, the register
> > +        * block must always be found first.
> > +        */
> 
> ..., but I don't understand the point of this comment. Given that
> devm_cxl_add_memdev() takes the base address as an argument it's
> already clear that the component registers need to be found before
> devm_cxl_add_memdev().
> 

That comment was created before devm_cxl_add_memdev() took the base. Indeed the
comment no longer makes sense.

> > +       rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> > +       if (rc)
> > +               dev_warn(&cxlmd->dev, "No component registers (%d)\n", rc);
> > +       else
> > +               creg = cxl_reg_block(pdev, &map);
> > +
> > +       cxlmd = devm_cxl_add_memdev(cxlm, creg);
> >         if (IS_ERR(cxlmd))
> >                 return PTR_ERR(cxlmd);
> >
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index 12a8437a9ca0..471fc7fb5418 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -227,7 +227,8 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> >         if (rc)
> >                 return rc;
> >
> > -       cxlmd = devm_cxl_add_memdev(cxlm);
> > +       /* TODO: mock component registers, or... */
> 
> How about:
> 
> /* cxl_test does not emulate registers, any memdev operations that
> imply component register access will be mocked at the memdev
> operations interface */
> 

Sounds good to me.

> > +       cxlmd = devm_cxl_add_memdev(cxlm, CXL_RESOURCE_NONE);
> >         if (IS_ERR(cxlmd))
> >                 return PTR_ERR(cxlmd);
> >
> > --
> > 2.33.1
> >
