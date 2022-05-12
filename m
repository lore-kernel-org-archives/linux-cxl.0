Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7278BC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 12 May 2022 19:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354363AbiELTTB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 May 2022 15:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347472AbiELTTA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 May 2022 15:19:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D325C2B7
        for <linux-cxl@vger.kernel.org>; Thu, 12 May 2022 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652383138; x=1683919138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wjPUSzKUUYft3oC5ZKjmTmKwYasf70pBVMBarE80YmU=;
  b=N+g8/WnedJECTePhxNcMDVHGkbeNa6JHKiuoZynMoZRibTpFkUHL+Ccy
   /6YsE8ycz2TNA37BVc06Xdmvpvm0OiVBEsoqCJjK9v0fofG0IasMfhP23
   ICXrBz/hBXGKLjYmb+XFnkQvUDKXMuoK+fTn9EoD3oC+W4c3Oc8D5hGWN
   AyHCBq9VO4XacIEW751o1lQQDUNj1LSxOYwqYheTV8NDvoUP4iS0Op5Lm
   zDB3Vvp5kTeF1An+A2orgUxfEBRUwFIrBASo2p8Y5oQBNRWd+XhxZbn6X
   2pW33JFfMuExYLUyHyClScTqcpV6Rz6NcZrq14Llqjq4WuWU40PIEYChf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="295370680"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="295370680"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 12:18:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="553908542"
Received: from wcogara-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.129.107])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 12:18:54 -0700
Date:   Thu, 12 May 2022 12:18:48 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 06/15] cxl/acpi: Manage root decoder's address space
Message-ID: <20220512191848.5piyvjtsryht3hbg@intel.com>
References: <20220413183720.2444089-1-ben.widawsky@intel.com>
 <20220413183720.2444089-7-ben.widawsky@intel.com>
 <CAPcyv4hD93d20Sq25tPNMQ1T68uQmTTQo7aDXMKN36wrCTa1-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hD93d20Sq25tPNMQ1T68uQmTTQo7aDXMKN36wrCTa1-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-04-18 15:15:47, Dan Williams wrote:
> On Wed, Apr 13, 2022 at 11:38 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > Use a gen_pool to manage the physical address space that is routed by
> > the platform decoder (root decoder). As described in 'cxl/acpi: Resereve
> > CXL resources from request_free_mem_region' the address space does not
> > coexist well if part of all of it is conveyed in the memory map to the
> > kernel.
> >
> > Since the existing resource APIs of interest all rely on the root
> > decoder's address space being in iomem_resource,
> 
> I do not understand what this is trying to convey. Nothing requires
> that a given 'struct resource' be managed under iomem_resource.
> 
> > the choices are to roll
> > a new allocator because on struct resource, or use gen_pool. gen_pool is
> > a good choice because it already has all the capabilities needed to
> > satisfy CXL programming.
> 
> Not sure what comparison to 'struct resource' is being made here, what
> is the tradeoff as you see it? In other words, why mention 'struct
> resource' as a consideration?
> 
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/acpi.c | 36 ++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h  |  2 ++
> >  2 files changed, 38 insertions(+)
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 0870904fe4b5..a6b0c3181d0e 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> >  #include <linux/platform_device.h>
> > +#include <linux/genalloc.h>
> >  #include <linux/module.h>
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> > @@ -79,6 +80,25 @@ struct cxl_cfmws_context {
> >         struct acpi_cedt_cfmws *high_cfmws;
> >  };
> >
> > +static int cfmws_cookie;
> > +
> > +static int fill_busy_mem(struct resource *res, void *_window)
> > +{
> > +       struct gen_pool *window = _window;
> > +       struct genpool_data_fixed gpdf;
> > +       unsigned long addr;
> > +       void *type;
> > +
> > +       gpdf.offset = res->start;
> > +       addr = gen_pool_alloc_algo_owner(window, resource_size(res),
> > +                                        gen_pool_fixed_alloc, &gpdf, &type);
> 
> The "_owner" variant of gen_pool was only added for p2pdma as a way to
> coordinate reference counts across p2pdma space allocation and a
> 'strcuct dev_pagemap' instance. The use here seems completely
> vestigial and can just move to gen_pool_alloc_algo.
> 

The problem that it's trying to solve is for the case when gpdf.offset is 0. I
think that's a highly unlikely case with the current plan, however, if
reparenting comes into play, you could very likely have offset 0, and then you
have no way to distinguish error from success without the cookie.

Thoughts?

> > +       if (addr != res->start || (res->start == 0 && type != &cfmws_cookie))
> > +               return -ENXIO;
> 
> How can the second condition ever be true?
> 

0 offset but failure.

> > +
> > +       pr_devel("%pR removed from CFMWS\n", res);
> > +       return 0;
> > +}
> > +
> >  static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >                            const unsigned long end)
> >  {
> > @@ -88,6 +108,8 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >         struct device *dev = ctx->dev;
> >         struct acpi_cedt_cfmws *cfmws;
> >         struct cxl_decoder *cxld;
> > +       struct gen_pool *window;
> > +       char name[64];
> >         int rc, i;
> >
> >         cfmws = (struct acpi_cedt_cfmws *) header;
> > @@ -116,6 +138,20 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >         cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
> >         cxld->interleave_granularity = CFMWS_INTERLEAVE_GRANULARITY(cfmws);
> >
> > +       sprintf(name, "cfmws@%#llx", cfmws->base_hpa);
> > +       window = devm_gen_pool_create(dev, ilog2(SZ_256M), NUMA_NO_NODE, name);
> > +       if (IS_ERR(window))
> > +               return 0;
> > +
> > +       gen_pool_add_owner(window, cfmws->base_hpa, -1, cfmws->window_size,
> > +                          NUMA_NO_NODE, &cfmws_cookie);
> 
> Similar comment about the "_owner" variant serving no visible purpose.
> 
> These seems to pre-suppose that only the allocator will ever want to
> interrogate the state of free space, it might be worth registering
> objects for each intersection that are not cxl_regions so that
> userspace explicitly sees what the cxl_acpi driver sees in terms of
> available resources.
> 
> > +
> > +       /* Area claimed by other resources, remove those from the gen_pool. */
> > +       walk_iomem_res_desc(IORES_DESC_NONE, 0, cfmws->base_hpa,
> > +                           cfmws->base_hpa + cfmws->window_size - 1, window,
> > +                           fill_busy_mem);
> > +       to_cxl_root_decoder(cxld)->window = window;
> > +
> >         rc = cxl_decoder_add(cxld, target_map);
> >         if (rc)
> >                 put_device(&cxld->dev);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 85fd5e84f978..0e1c65761ead 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -246,10 +246,12 @@ struct cxl_switch_decoder {
> >  /**
> >   * struct cxl_root_decoder - A toplevel/platform decoder
> >   * @base: Base class decoder
> > + * @window: host address space allocator
> >   * @targets: Downstream targets (ie. hostbridges).
> >   */
> >  struct cxl_root_decoder {
> >         struct cxl_decoder base;
> > +       struct gen_pool *window;
> >         struct cxl_decoder_targets *targets;
> >  };
> >
> > --
> > 2.35.1
> >
