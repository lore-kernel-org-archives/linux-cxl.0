Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BAC3EA82
	for <linux-cxl@vger.kernel.org>; Wed, 31 Jan 2024 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732123; cv=none; b=spu+3Ovnc0WrQlIO3FHnTpUvEgqP4VF3AeWyzTytMIp5H/jSqii39p89Z4B97IOgt9xUEkGDUstzsOA4ZXhvS9NTr629cNXwCZhuJoJ+MAtmj0WI44bznnBfXhwXImo6ch2UJEv2NRk5Daa10zz6HoIlOSiWjwsC2K3+dcL0MmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732123; c=relaxed/simple;
	bh=6E8y+m/5W7Gd//VXf4tnyUG4YWoNNhcUGAPBQkJL350=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJup/Wx4hJm50hxtjV8/DQkRYeXFiQKPaGef8u+cLyS9NsJTsbicZyN4XKJbYzSaXud4+g6Xby2LGqGyHonaoZgVBTSKVBDBAf8P5BiPdjP4XrUI8IeeHI8AwZSDGWgEpjwihL9euN5zi56tI7AqL3xXSsZzQAoZompZ4LxvRBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQSjxWiL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQSjxWiL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706732122; x=1738268122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6E8y+m/5W7Gd//VXf4tnyUG4YWoNNhcUGAPBQkJL350=;
  b=TQSjxWiL4y3BrL3K9SX2j3pkUMvBOqAJHwoB4QjHuY5X5t9NsjqUxtw0
   IZkPs9193vGZgn8GrOX5YmxUgSxNyUU4kfOxug/rwMmFOWkZ+T4litKJu
   QQsuLNVwCOEYUDXyvcyb59cHV3mdi08ogBTZe9ns6piZPQ+KCzfXj04bb
   4wHBDG4gK/e+ZBg4HIBGNAOIC2xuweDwCuKaK45Q1tERNfVR30F5OS1T/
   LoL2Bnc+mMxMxjDFN0iaZKfdLuG1EZjyTtAQR2RXDl0cT3pahivsHsQgJ
   E+QQ2pp72SqQebsur3710LtCKD+OcpWVDU61+NokHT61FjiwVo65nVmMq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17097814"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="17097814"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 12:15:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4196622"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.39.51])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 12:15:14 -0800
Date: Wed, 31 Jan 2024 12:15:12 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	Wonjae Lee <wj28.lee@samsung.com>
Subject: Re: [PATCH v2] cxl/region: Allow out of order assembly of
 autodiscovered regions
Message-ID: <ZbqqUEdIq+2/I8Ae@aschofie-mobl2>
References: <20240131020726.1790160-1-alison.schofield@intel.com>
 <65ba0b2be2775_5a9dd2945b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ba0b2be2775_5a9dd2945b@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Wed, Jan 31, 2024 at 12:56:11AM -0800, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Autodiscovered regions can fail to assemble if they are not discovered
> > in HPA decode order. The user will see failure messages like:
> > 
> > [] cxl region0: endpoint5: HPA order violation region1
> > [] cxl region0: endpoint5: failed to allocate region reference
> > 
> > The check that is causing the failure helps the CXL driver enforce
> > a CXL spec mandate that decoders be committed in HPA order. The
> > check is needless for autodiscovered regions since their decoders
> > are already programmed. Trying to enforce order in the assembly of
> > these regions is useless because they are assembled once all their
> > member endpoints arrive, and there is no guarantee on the order in
> > which endpoints are discovered during probe.
> > 
> > Keep the existing check, but for autodiscovered regions, allow the
> > out of order assembly after a sanity check that the lesser numbered
> > decoder has the lesser HPA starting address.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > 
> > Changes since v1: 
> > - Get decoder via available struct cxled_endpoint_decoder. (Wonjae)
> > - Check F_AUTO in alloc_region_ref()
> > - Fold assignments into the declarations in auto_order_ok()
> > - Drop Tested-by tag due to changes
> > Link to v1: https://lore.kernel.org/linux-cxl/20240126045446.1750854-1-alison.schofield@intel.com/
> > 
> > 
> >  drivers/cxl/core/region.c | 47 ++++++++++++++++++++++++++++++---------
> >  1 file changed, 36 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 0f05692bfec3..28e8af1e54a2 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -753,8 +753,32 @@ static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
> >  	return to_cxl_decoder(dev);
> >  }
> >  
> > -static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
> > -					       struct cxl_region *cxlr)
> > +static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_iter,
> > +			  struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct cxl_region_ref *rr = cxl_rr_load(port, cxlr_iter);
> > +	struct cxl_decoder *cxld_iter = rr->decoder;
> > +	struct cxl_decoder *cxld = &cxled->cxld;
> > +
> > +	/*
> > +	 * Allow the out of order assembly of auto-discovered regions.
> > +	 * Per CXL Spec 3.1 8.2.4.20.12 software must commit decoders
> > +	 * in HPA order. Confirm that the decoder with the lesser HPA
> > +	 * starting address has the lesser id.
> > +	 */
> > +	dev_dbg(&cxld->dev, "check for HPA violation %s:%d < %s:%d\n",
> > +		dev_name(&cxld->dev), cxld->id,
> > +		dev_name(&cxld_iter->dev), cxld_iter->id);
> > +
> > +	if (cxld_iter->id > cxld->id)
> 
> This only works if @port is an endpoint port. The order violations can
> also happen within switch ports and in that case it is invalid to
> compare a switch port decoder-id with an endpoint decoder id. So I think
> this needs cxl_region_find_decoder(), and cxl_region_find_decoder()
> needs to handle endpoint ports:

Thanks! With your changes - it's looking right now:

bad compares:
[] cxl_core:auto_order_ok:769: cxl decoder8.0: check for HPA violation decoder8.0:0 < decoder8.1:1
[0 cxl_core:auto_order_ok:769: cxl decoder8.0: check for HPA violation decoder8.0:0 < decoder8.2:2
[] cxl_core:auto_order_ok:769: cxl decoder8.0: check for HPA violation decoder8.0:0 < decoder7.1:1
[] cxl_core:auto_order_ok:769: cxl decoder8.0: check for HPA violation decoder8.0:0 < decoder7.2:2
[] cxl_core:auto_order_ok:769: cxl decoder8.0: check for HPA violation decoder8.0:0 < decoder4.1:1
[] cxl_core:auto_order_ok:769: cxl decoder8.0: check for HPA violation decoder8.0:0 < decoder4.2:2

good compares:
[] cxl_core:auto_order_ok:773: cxl decoder8.0: check for HPA violation decoder8.0:0 < decoder8.1:1
[] cxl_core:auto_order_ok:773: cxl decoder8.0: check for HPA violation decoder8.0:0 < decoder8.2:2
[] cxl_core:auto_order_ok:773: cxl decoder7.0: check for HPA violation decoder7.0:0 < decoder7.1:1
[] cxl_core:auto_order_ok:773: cxl decoder7.0: check for HPA violation decoder7.0:0 < decoder7.2:2
[] cxl_core:auto_order_ok:773: cxl decoder4.0: check for HPA violation decoder4.0:0 < decoder4.1:1
[] cxl_core:auto_order_ok:773: cxl decoder4.0: check for HPA violation decoder4.0:0 < decoder4.2:2


> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ce0e2d82bb2b..f1a9d1798d21 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -730,12 +730,17 @@ static int match_auto_decoder(struct device *dev, void *data)
>         return 0;
>  }
>  
> -static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
> -                                                  struct cxl_region *cxlr)
> +static struct cxl_decoder *
> +cxl_region_find_decoder(struct cxl_port *port,
> +                       struct cxl_endpoint_decoder *cxled,
> +                       struct cxl_region *cxlr)
>  {
>         struct device *dev;
>         int id = 0;
>  
> +       if (port == cxled_to_port(cxled))
> +               return &cxled->cxld;
> +
>         if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
>                 dev = device_find_child(&port->dev, &cxlr->params,
>                                         match_auto_decoder);
> @@ -853,10 +858,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  {
>         struct cxl_decoder *cxld;
>  
> -       if (port == cxled_to_port(cxled))
> -               cxld = &cxled->cxld;
> -       else
> -               cxld = cxl_region_find_decoder(port, cxlr);
> +       cxld = cxl_region_find_decoder(port, cxled, cxlr);
>         if (!cxld) {
>                 dev_dbg(&cxlr->dev, "%s: no decoder available\n",
>                         dev_name(&port->dev));
