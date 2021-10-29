Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AB1C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 21:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53FC61075
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 21:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhJ2V3Z (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:29:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:4985 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhJ2V3Y (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 29 Oct 2021 17:29:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="230616199"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="230616199"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 14:26:55 -0700
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="665973522"
Received: from applebex-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.137.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 14:26:55 -0700
Date:   Fri, 29 Oct 2021 14:26:54 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 05/28] cxl/core: Convert decoder range to resource
Message-ID: <20211029212654.cnge45a3tj3abj4s@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-6-ben.widawsky@intel.com>
 <CAPcyv4iiR_HT_9ExRvgLixWnQg8y-id1zpmRYurFSfw3OiVaYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iiR_HT_9ExRvgLixWnQg8y-id1zpmRYurFSfw3OiVaYQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-29 13:50:29, Dan Williams wrote:
> On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > Regions will use the resource API in order to help manage allocated
> > space. As regions are children of the decoder, it makes sense that the
> > parent host the main resource to be suballocated by the region.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/acpi.c     | 12 ++++--------
> >  drivers/cxl/core/bus.c |  4 ++--
> >  drivers/cxl/cxl.h      |  4 ++--
> >  3 files changed, 8 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 7d13e7f0aefc..b972abc9f6ef 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -126,10 +126,9 @@ static void cxl_add_cfmws_decoders(struct device *dev,
> >
> >                 cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> >                 cxld->target_type = CXL_DECODER_EXPANDER;
> > -               cxld->range = (struct range) {
> > -                       .start = cfmws->base_hpa,
> > -                       .end = cfmws->base_hpa + cfmws->window_size - 1,
> > -               };
> > +               cxld->res = (struct resource)DEFINE_RES_MEM_NAMED(cfmws->base_hpa,
> > +                                                                 cfmws->window_size,
> > +                                                                 "cfmws");
> 
> I think this should just be DEFINE_RES_MEM(), and then set the name of
> it inside cxl_decoder_add() to the dev_name() of the decoder device.
> That way a dump of the resource tree hierarchy makes sense compared to
> the device hierarchy with actual device names not a series of
> repeating "cfmws" entries.
> 
> >                 cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
> >                 cxld->interleave_granularity =
> >                         CFMWS_INTERLEAVE_GRANULARITY(cfmws);
> > @@ -339,10 +338,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >         cxld->interleave_ways = 1;
> >         cxld->interleave_granularity = PAGE_SIZE;
> >         cxld->target_type = CXL_DECODER_EXPANDER;
> > -       cxld->range = (struct range) {
> > -               .start = 0,
> > -               .end = -1,
> > -       };
> > +       cxld->res = (struct resource)DEFINE_RES_MEM(0, 0);
> >
> >         device_lock(&port->dev);
> >         dport = list_first_entry(&port->dports, typeof(*dport), list);
> > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > index ebd061d03950..454d4d846eb2 100644
> > --- a/drivers/cxl/core/bus.c
> > +++ b/drivers/cxl/core/bus.c
> > @@ -47,7 +47,7 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
> >  {
> >         struct cxl_decoder *cxld = to_cxl_decoder(dev);
> >
> > -       return sysfs_emit(buf, "%#llx\n", cxld->range.start);
> > +       return sysfs_emit(buf, "%#llx\n", cxld->res.start);
> >  }
> >  static DEVICE_ATTR_RO(start);
> >
> > @@ -56,7 +56,7 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
> >  {
> >         struct cxl_decoder *cxld = to_cxl_decoder(dev);
> >
> > -       return sysfs_emit(buf, "%#llx\n", range_len(&cxld->range));
> > +       return sysfs_emit(buf, "%#llx\n", resource_size(&cxld->res));
> 
> It's not clear to me that anything other than root decoders will host
> a resource tree, every decoder downstream of the root would reference
> a subset of the root decoder range. Something like:
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5e2e93451928..00bf742396e0 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -200,7 +200,8 @@ enum cxl_decoder_type {
>   * struct cxl_decoder - CXL address range decode configuration
>   * @dev: this decoder's device
>   * @id: kernel device name id
> - * @range: address range considered by this decoder
> + * @res: platform address range hosted by a root decoder
> + * @range: address range programmed in the (non-root) decoder
>   * @interleave_ways: number of cxl_dports in this decode
>   * @interleave_granularity: data stride per dport
>   * @target_type: accelerator vs expander (type2 vs type3) selector
> @@ -211,7 +212,10 @@ enum cxl_decoder_type {
>  struct cxl_decoder {
>         struct device dev;
>         int id;
> -       struct range range;
> +       union {
> +               struct resource res;
> +               struct range range;
> +       };
>         int interleave_ways;
>         int interleave_granularity;
>         enum cxl_decoder_type target_type;
> 
> ...because regions will __request_region(&cxld->res, ...) from the
> root decoder, and all the intervening decoders in that stack will be
> updated to make that mapping happen.
> 
> Note, this is just how I had it roughly mapped out in my head, I defer
> making it a hard recommendation until I get deeper into this set to
> see if we diverge.
> 

You're correct.

I had changed this already for my v3. I ended up with this:
+       union {
+               struct resource cfmws_res;
+               struct resource *decoder_res;
+       };

Not sure if you prefer one way or another.

> >  }
> >  static DEVICE_ATTR_RO(size);
> >
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 4483e1a39fc3..7f2e2bdc7883 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -195,7 +195,7 @@ enum cxl_decoder_type {
> >   * struct cxl_decoder - CXL address range decode configuration
> >   * @dev: this decoder's device
> >   * @id: kernel device name id
> > - * @range: address range considered by this decoder
> > + * @res: address space resources considered by this decoder
> >   * @interleave_ways: number of cxl_dports in this decode
> >   * @interleave_granularity: data stride per dport
> >   * @target_type: accelerator vs expander (type2 vs type3) selector
> > @@ -206,7 +206,7 @@ enum cxl_decoder_type {
> >  struct cxl_decoder {
> >         struct device dev;
> >         int id;
> > -       struct range range;
> > +       struct resource res;
> >         int interleave_ways;
> >         int interleave_granularity;
> >         enum cxl_decoder_type target_type;
> > --
> > 2.33.1
> >
