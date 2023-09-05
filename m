Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C441CA100C
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 21:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbjIEVDz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 17:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjIEVDz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 17:03:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B134B8
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693947829; x=1725483829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+LZBwdvNdtOsYOtpWAjVYBtERZl8fDvY8o5XzRlvBxE=;
  b=Vgc2W0DcmdEPYAlDdpAzsd2+g1rT7QGSb5cOteywqdbXRSbCPxo+F7He
   XUWQQL7+DRaSHqwYrQ/vgQd0ISue4bwt/F38j8GCBBnN3/uLIeihmxWfR
   D02Q2kh4FVCdB+S3/rBmho/z0iYJeU+blN56CcnfR2JEpXjab4T1YTqTk
   814y/QODxzffL4NiuHITZC0QBCa6RNlvQ0HhHMveF1vAR/vyeRVoN/+EG
   CS+lGnhNGc+G4DiFmzXIBnmP1xSOZ/ab/iudt3eTY4vcknALf06MepjY0
   efYvy0iTnWaUyik6n6lPYd6HGC9Mv6B5dO5KlPtc8hWy+ICtVihVo0aRS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="357212545"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="357212545"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 14:03:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="831389470"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="831389470"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.50.9])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 14:03:48 -0700
Date:   Tue, 5 Sep 2023 14:03:46 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/region: Match auto-discovered region decoders by
 HPA range
Message-ID: <ZPeXskWqx+Exv++C@aschofie-mobl2>
References: <20230822014303.110509-1-alison.schofield@intel.com>
 <20230829142115.000019bf@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829142115.000019bf@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Aug 29, 2023 at 02:21:15PM +0100, Jonathan Cameron wrote:
> On Mon, 21 Aug 2023 18:43:03 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Currently, when the region driver attaches a region to a port, it
> > selects the ports next available decoder to program.
> > 
> > With the addition of auto-discovered regions, a port decoder has
> > already been programmed so grabbing the next available decoder can
> > be a mismatch when there is more than one region using the port.
> > 
> > The failure appears like this with CXL DEBUG enabled:
> > 
> > [] cxl_core:alloc_region_ref:754: cxl region0: endpoint9: HPA order violation region0:[mem 0x14780000000-0x1478fffffff flags 0x200] vs [mem 0x880000000-0x185fffffff flags 0x200]
> > [] cxl_core:cxl_port_attach_region:972: cxl region0: endpoint9: failed to allocate region reference
> > 
> > When CXL DEBUG is not enabled, there is no failure message. The region
> > just never materializes. Users can suspect this issue if they know their
> > firmware has programmed decoders so that more than one region is using
> > a port. Note that the problem may appear intermittently, ie not on
> > every reboot.
> > 
> > Add a matching method for auto-discovered regions that finds a decoder
> > based on an HPA range. The decoder range must exactly match the region
> > resource parameter.
> > 
> > Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Bikeshed time...

Not bikeshed, good catch -

> 
> > ---
> > 
> > Changes in v2:
> > - Use cxlr->params for HPA match rather than requiring cxled (Dan)
> > - dev_warn() if decoder already assigned to a region (Dan)
> > - Add failure footprint to commit log (Dan)
> > - Add Fixes Tag (Dan)
> > - v1: https://lore.kernel.org/linux-cxl/20230804213004.1669658-1-alison.schofield@intel.com/
> > 
> >  drivers/cxl/core/region.c | 29 ++++++++++++++++++++++++++++-
> >  1 file changed, 28 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index e115ba382e04..b08aec9f0af8 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -717,13 +717,40 @@ static int match_free_decoder(struct device *dev, void *data)
> >  	return 0;
> >  }
> >  
> > +static int match_auto_decoder(struct device *dev, void *data)
> 
> Does more than matching a decoder and in the warning path doesn't actually
> match it (not returning 1 so we carry on).
> 
> So perhaps a rename?

I've updated to just do the match.  Checking for an attached region
was redundant as it's already done in the call path.

Thanks for the review!


> 
> > +{
> > +	struct cxl_region_params *p = data;
> > +	struct cxl_decoder *cxld;
> > +	struct range *r;
> > +
> > +	if (!is_switch_decoder(dev))
> > +		return 0;
> > +
> > +	cxld = to_cxl_decoder(dev);
> > +	r = &cxld->hpa_range;
> > +
> > +	if (p->res && p->res->start == r->start && p->res->end == r->end) {
> > +		if (cxld->region) {
> > +			dev_WARN(dev, "decoder already attached to %s\n",
> > +				 dev_name(&cxld->region->dev));
> > +			return 0;
> 
> Not obvious to me why we carry on looking for matching regions if we have
> found a precise match (even if it's already attached).  
> I'd expect return 1 here.  Maybe a comment on why it makes sense to keep trying?
> 
> > +		}
> > +		return 1;
> > +	}
> > +	return 0;
> > +}
> > +
> >  static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
> >  						   struct cxl_region *cxlr)
> >  {
> >  	struct device *dev;
> >  	int id = 0;
> >  
> > -	dev = device_find_child(&port->dev, &id, match_free_decoder);
> > +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
> > +		dev = device_find_child(&port->dev, &cxlr->params,
> > +					match_auto_decoder);
> > +	else
> > +		dev = device_find_child(&port->dev, &id, match_free_decoder);
> >  	if (!dev)
> >  		return NULL;
> >  	/*
> > 
> > base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
> 
