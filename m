Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9683EC0015E
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Aug 2023 00:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbjHPANy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 15 Aug 2023 20:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbjHPANb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 15 Aug 2023 20:13:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9D42100
        for <linux-cxl@vger.kernel.org>; Tue, 15 Aug 2023 17:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692144809; x=1723680809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FvdkUHJhzur0csknPxNIOEZ77aGX2cQ3mX5nW1bSbHg=;
  b=QEhl061Puy8v73L629rFx6d7B3/6uLJZvBTpLfwCXp4EMtgR9nuLc5UJ
   /NNQ7BUtMnC4B6NDcb0ALFtM1uFWCuxhgyDG6IxiVoZGx0dyQeZr4gTn8
   b2EjhqC2IFBbblAQWEGaNbaDh3XTqj3rfIqjF4cy0pVxunYvU2X0wlEWD
   +/6jzuAY/4DNk6PstVX8O1HkF0rbA5mzniZbsKkZveme7tBNS+37fl7iG
   rLHUIDXM8UUo8qKm3WQF9Rmo0GrH4h6F5oJtKzPZNr8DnCTOeiGuQsfkf
   lYptsZo30sXGxHUQR3mcUrjZEYXWjB+dQ3G73RTuQfVPe+GKMuRr1e7B8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375177725"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="375177725"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 17:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="799369221"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="799369221"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.27.4])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 17:13:28 -0700
Date:   Tue, 15 Aug 2023 17:13:27 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Match auto-discovered region decoders by HPA
 range
Message-ID: <ZNwUp2Nqu4/3m5Um@aschofie-mobl2>
References: <20230804213004.1669658-1-alison.schofield@intel.com>
 <64cd782673ff9_2138e2946a@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64cd782673ff9_2138e2946a@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Aug 04, 2023 at 03:13:58PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Today, when the region driver attaches a region to a port, it
> > selects the ports next available decoder to program.
> 
> A small nit: s/Today/Currently/
Got it.

> 
> > With the addition of auto-discovered regions, a port decoder has
> > already been programmed, so grabbing the next available decoder
> > can be a mismatch when there is more than one region using the
> > port. Match on the port HPA range for auto-discovered regions.
> 
> This patch looks correct to me, just a couple questions beloe.
> 
> It would be great if it was accompanied by a cxl_test scenario that
> tested the failing case, but barring that it would be good to have some
> logs from a scenario where people can notice if this fix applies to
> their failure.

Cxl_test:

The cxl_test regression test for this fix is to setup 2 regions for
auto-detection on the same port and load/reload enough times that
the HPA violation occurs when the fix is not in place. I'll see
about adding that in a v2 of this patch, and an ndctl PATCH for the
regression/unit test.

Dmesg logs:
The footprint of this failure is only visible with CXL DEBUG enabled:

[] cxl_core:alloc_region_ref:754: cxl region0: endpoint9: HPA order violation region0:[mem 0x14780000000-0x1478fffffff flags 0x200] vs [mem 0x880000000-0x185fffffff flags 0x200]
[] cxl_core:cxl_port_attach_region:972: cxl region0: endpoint9: failed to allocate region reference

When CXL DEBUG is not enabled, there is no failure message. The region
just never materializes. With this patch, I hope the HPA order violation
is only a dev_dbg() level message again.

Makes me wonder:

This case aside, the 'opportunistic' approach to region assembly doesn't
offer a place to make any summary statements about the auto discovery
results.

In cxl_endpoint_probe() we get here with CXL_DECODER_STATE_AUTO :

>>	/*
>>	 * Now that all endpoint decoders are successfully enumerated, try to
>>	 * assemble regions from committed decoders
>>	 */
>>	device_for_each_child(&port->dev, root, discover_region);

Do we need to do some expected/found work here?

> 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> I think this wants a "Fixes" tag:
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> 
Got it.

> > ---
> >  
> >  drivers/cxl/core/region.c | 31 ++++++++++++++++++++++++++++---
> >  1 file changed, 28 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index e115ba382e04..8bfec7a96975 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -717,13 +717,37 @@ static int match_free_decoder(struct device *dev, void *data)
> >  	return 0;
> >  }
> >  
> > +static int match_auto_decoder(struct device *dev, void *data)
> > +{
> > +	struct cxl_endpoint_decoder *cxled = data;
> > +	struct cxl_decoder *cxld;
> > +
> > +	if (!is_switch_decoder(dev))
> > +		return 0;
> 
> Is this check needed? Endpoint decoders should also match by range.
> Maybe make it explicit like:
> 
>     if (cxld == &cxled->cxld)
>     	return 0;
> 
> ...where it is obvious no further checks are needed, but I think that
> also goes away with the change proposal below:
> 
> 
> > +
> > +	cxld = to_cxl_decoder(dev);
> > +
> > +	if (!range_contains(&cxld->hpa_range, &cxled->cxld.hpa_range))
> > +		return 0;
> 
> Hmm, shouldn't it be identical and no bigger?
> 
> if (cxld->hpa_range != cxled->cxld.hpa_range)
> 
> > +
> > +	if (!cxld->region)
> > +		return 1;
> 
> Interesting, I am trying to think through the implications of failing
> here. That would only happen if the port had been setup previously with
> a different region for the same address range? How would that happen?
> 
> It feel like it should be:
> 
> 	if (cxld->region) {
> 		dev_WARN(...)
> 		return 0;
> 	}
> 
> 	return 1;
>

Understood. I picked up checks from the existing match_free_decoder() too
willy nilly.

> > +
> > +	return 0;
> > +}
> > +
> >  static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
> > -						   struct cxl_region *cxlr)
> > +						   struct cxl_region *cxlr,
> > +						   struct cxl_endpoint_decoder *cxled)
> >  {
> >  	struct device *dev;
> >  	int id = 0;
> >  
> > -	dev = device_find_child(&port->dev, &id, match_free_decoder);
> > +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
> > +		dev = device_find_child(&port->dev, cxled, match_auto_decoder);
> > +	else
> > +		dev = device_find_child(&port->dev, &id, match_free_decoder);
> > +
> >  	if (!dev)
> >  		return NULL;
> >  	/*
> > @@ -839,7 +863,8 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
> >  	if (port == cxled_to_port(cxled))
> >  		cxld = &cxled->cxld;
> >  	else
> > -		cxld = cxl_region_find_decoder(port, cxlr);
> > +		cxld = cxl_region_find_decoder(port, cxlr, cxled);
> 
> It looks like the cxled is only used to convey the range. Maybe just get
> that from cxlr->params->res and not add another parameter here? Of
> course that would then change the suggestions above where you can not
> compare 'struct range' instances directly.

Got it. Will compare the res->starts and res->ends directly and use
the cxlr->params.

Thanks Dan!
