Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2383C433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Sep 2021 17:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B9360FED
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Sep 2021 17:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhIKR0w (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 11 Sep 2021 13:26:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:54767 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhIKR0w (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 11 Sep 2021 13:26:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10104"; a="200840889"
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="scan'208";a="200840889"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2021 10:25:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="scan'208";a="471006485"
Received: from vksouw-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.129.104])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2021 10:25:39 -0700
Date:   Sat, 11 Sep 2021 10:25:37 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 02/13] cxl/core/bus: Add kernel docs for decoder ops
Message-ID: <20210911172537.dqtiwv2msgvqbfo7@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
 <20210902195017.2516472-3-ben.widawsky@intel.com>
 <CAPcyv4gF12w-rF5Qh0Y8=JxxDEdahnX4KVvy7SwJhY2hLBhChw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gF12w-rF5Qh0Y8=JxxDEdahnX4KVvy7SwJhY2hLBhChw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-09-10 11:51:14, Dan Williams wrote:
> On Thu, Sep 2, 2021 at 12:50 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > Since the code to add decoders for switches and endpoints is on the
> > horizon, document the new interfaces that will be consumed by them.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/core/bus.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > index 3991ac231c3e..9d98dd50d424 100644
> > --- a/drivers/cxl/core/bus.c
> > +++ b/drivers/cxl/core/bus.c
> > @@ -453,6 +453,19 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
> >  }
> >  EXPORT_SYMBOL_GPL(cxl_add_dport);
> >
> > +/**
> > + * cxl_decoder_alloc - Allocate a new CXL decoder
> > + * @port: owning port of this decoder
> > + * @nr_targets: downstream targets accessible by this decoder
> > + *
> > + * A port should contain one or more decoders. Each of those decoders enable
> > + * some address space for CXL.mem utilization. Therefore, it is logical to
> 
> I think a "therefore it is logical" statement is changelog fodder.
> Once the code is in the kernel it does not need to keep justifying its
> existence.

I agree. This is more appropriate as a commit message.

> 
> > + * allocate decoders while enumerating a port. While >= 1 is defined by the CXL
> > + * specification, due to error conditions it is possible that a port may have 0
> > + * decoders.
> 
> This comment feels out of place. Why does cxl_decoder_alloc() care how
> many decoders a port has? I would expect this comment on a cxl_port
> api that is trying to walk decoders.
> 

I partially agree. The function implementation cares simply for heap allocation
and this detail shouldn't be a part of kdocs. However, as a public API in core,
I think it's warranted to mention cases which might not immediately be obvious.
The main purpose was to change this text when adding endpoints. I didn't
actually end up doing that unfortunately. As such, I think I will move this bit
to the description of nr_targets above.

> > + *
> > + * Return: A new cxl decoder which wants to be added with cxl_decoder_add()
> 
> s/which wants to be added/to be registered by/
> 
> > + */
> >  struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> >  {
> >         struct cxl_decoder *cxld;
> > @@ -491,6 +504,21 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> >  }
> >  EXPORT_SYMBOL_GPL(cxl_decoder_alloc);
> >
> > +/**
> > + * cxl_decoder_add - Add a decoder with targets
> > + * @host: The containing struct device. This is typically the PCI device that is
> > + *        CXL capable
> 
> No, this is the device doing the enumeration. After the devm removal
> for decoder creation it's now only being used to print a debug
> message. Do you have another use for it? Perhaps it should just be
> deleted. The new cxl_decoder_autoremove() handles what @host was used
> for previously.

I have no use for it beyond what's there. Looks like it should be dropped to me
as well. I'll resend with that removal.

> 
> > + * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
> > + * @target_map: A list of downstream ports that this decoder can direct memory
> > + *              traffic to. These numbers should correspond with the port number
> > + *              in the PCIe Link Capabilities structure.
> > + *
> > + * Return: 0 if decoder was successfully added.
> > + *
> > + * Certain types of decoders may not have any targets. The main example of this
> > + * is an endpoint device. A more awkward example is a hostbridge whose root
> > + * ports get hot added (technically possible, though unlikely).
> > + */
> >  int cxl_decoder_add(struct device *host, struct cxl_decoder *cxld,
> >                     int *target_map)
> >  {
> > --
> > 2.33.0
> >
