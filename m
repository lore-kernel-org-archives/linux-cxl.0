Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80201C47089
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 22:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiK3Wvx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 17:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiK3Wvu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 17:51:50 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C82A8FD43
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 14:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669848709; x=1701384709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cRokIqIAzr1rDjScM+gHrtHe+ComQYGiJ3HMfjch13Q=;
  b=bjiV/2p5wlrFu0tJybqVjj3mewbrOHfWtK3UG1CO76hpKoeA8K3RSwTg
   /3gthN60xUu+ogzjG9jmghM3u8WhyZ+XqfqWe9B9F9qq59U7GMrTaQdlt
   d/Xk29T3EU+TnTfU1DwLB3asfnSx4olEgFx05LgwQ9uMPg6r63+BK07ZA
   riBksCTTPw2b1TFkMjSDssrcIjXvpPxzybOGDwZli+ZJmYdVwa7loW52l
   iQFXQSczU+Uq26W2rpvVck41My/wQpRZWniRwQGsVkpjvjbw0Ya4bmSxu
   JhmONwsCSiWdplok1rE6kze6yhv0ld/1afshgn4H8ZhInhU/Bw6DYM6d6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="303133454"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="303133454"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 14:51:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="712989459"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="712989459"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.3.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 14:51:47 -0800
Date:   Wed, 30 Nov 2022 14:51:45 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 2/3] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Message-ID: <Y4fegb3v1R1Uxmu8@aschofie-mobl2>
References: <cover.1669153633.git.alison.schofield@intel.com>
 <168ca3d06756bade7d2d11f2fc9122c19206ff9a.1669153633.git.alison.schofield@intel.com>
 <20221130181436.0000782f@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130181436.0000782f@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Nov 30, 2022 at 06:14:36PM +0000, Jonathan Cameron wrote:
> On Tue, 22 Nov 2022 14:52:24 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When the CFMWS is using XOR math, parse the corresponding
> > CXIMS structure and store the xormaps in the root decoder
> > structure. Use the xormaps in a new lookup, cxl_hb_xor(),
> > to find a targets entry in the host bridge interleave
> > target list.
> > 
> > Defined in CXL Specfication 3.0 Section: 9.17.1
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> I've been avoiding reading this because the xormap stuff gives me a headache..
> Anyhow, finally looked at it properly and maths looks right to me.
> A few queries and minor suggestions inline but nothing important.
> 
> With or without dragging the refactoring into here from your new patch series
> (to avoid introducing code only to factor a chunk out a few patches later).
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for the review Jonathan.

I did pull that little refactor fwd to this patch, even though I think
this patch may precede that address translation work for a while.
Pulling that calc out to the separate function just looked better!
I hope it flies.

I tidy'd up per your suggestions. I chose 'trailing' commas because
one should always expect more. (and there wasn't a clear precedence
in the file)

Alison

> 
> > ---
> >  drivers/cxl/acpi.c      | 126 +++++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/core/port.c |   9 ++-
> >  drivers/cxl/cxl.h       |  13 ++++-
> >  3 files changed, 140 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index fb649683dd3a..98c84942ed37 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -6,9 +6,107 @@
> >  #include <linux/kernel.h>
> >  #include <linux/acpi.h>
> >  #include <linux/pci.h>
> > +#include <asm/div64.h>
> >  #include "cxlpci.h"
> >  #include "cxl.h"
> >  
> > +struct cxl_cxims_data {
> > +	int nr_maps;
> > +	u64 xormaps[];
> > +};
> > +
> > +/*
> > + * Find a targets entry (n) in the host bridge interleave list.
> > + * CXL Specfication 3.0 Table 9-22
> > + */
> > +static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
> > +{
> > +	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> > +	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
> > +	struct cxl_decoder *cxld = &cxlsd->cxld;
> > +	int ig = cxld->interleave_granularity;
> > +	int iw = cxld->interleave_ways;
> > +	int eiw, i = 0, n = 0;
> > +	u64 hpa;
> > +
> > +	if (dev_WARN_ONCE(&cxld->dev,
> > +			  cxld->interleave_ways != cxlsd->nr_targets,
> > +			  "misconfigured root decoder\n"))
> > +		return NULL;
> > +
> > +	if (iw == 1)
> > +		/* Entry is always 0 for no interleave */
> > +		return cxlrd->cxlsd.target[0];
> > +
> > +	hpa = cxlrd->res->start + pos * ig;
> > +
> > +	if (iw == 3)
> > +		goto no_map;
> > +
> > +	/* IW: 2,4,6,8,12,16 begin building 'n' using xormaps */
> > +	for (i = 0; i < cximsd->nr_maps; i++)
> > +		n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
> 
> > +
> > +no_map:
> > +	/* IW: 3,6,12 add a modulo calculation to 'n' */
> > +	if (!is_power_of_2(iw)) {
> > +		eiw = ilog2(iw / 3) + 8;
> 
> Obviously duplicates some checks, but ways_to_cxl() still better here I think
> because it documents that it's just the normal switch to eiw.
> 
> > +		hpa &= GENMASK_ULL(51, eiw + ig);
> > +		n |= do_div(hpa, 3) << i;
> 
> Seeing as we haven't merged this set yet, maybe just factor this out from the
> start rather than in your follow on set?
> 
> > +	}
> > +	return cxlrd->cxlsd.target[n];
> > +}
> > +
> > +struct cxl_cxims_context {
> > +	struct device *dev;
> > +	struct cxl_root_decoder *cxlrd;
> > +};
> > +
> > +static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
> > +			   const unsigned long end)
> > +{
> > +	struct acpi_cedt_cxims *cxims = (struct acpi_cedt_cxims *)header;
> > +	struct cxl_cxims_context *ctx = arg;
> > +	struct cxl_root_decoder *cxlrd = ctx->cxlrd;
> > +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> > +	struct device *dev = ctx->dev;
> > +	struct cxl_cxims_data *cximsd;
> > +	unsigned int hbig, nr_maps;
> > +	int rc;
> > +
> > +	rc = cxl_to_granularity(cxims->hbig, &hbig);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (hbig == cxld->interleave_granularity) {
> > +		/* IW 1,3 do not use xormaps and skip this parsing entirely */
> > +
> > +		if (is_power_of_2(cxld->interleave_ways))
> > +			/* 2, 4, 8, 16 way */
> > +			nr_maps = ilog2(cxld->interleave_ways);
> > +		else
> > +			/* 6, 12 way */
> > +			nr_maps = ilog2(cxld->interleave_ways / 3);
> > +
> > +		if (cxims->nr_xormaps < nr_maps) {
> 
> Why is cxims->nr_xormaps > nr_maps not an error?
> Whilst we are just going to drop the extra entries it certainly seems
> like an oddity we should perhaps report?
> 
> > +			dev_dbg(dev, "CXIMS nr_xormaps[%d] expected[%d]\n",
> > +				cxims->nr_xormaps, nr_maps);
> > +			return -ENXIO;
> > +		}
> > +
> > +		cximsd = devm_kzalloc(dev,
> > +				      struct_size(cximsd, xormaps, nr_maps),
> > +				      GFP_KERNEL);
> > +		if (!cximsd)
> > +			return -ENOMEM;
> 
> Trivial, I'd like a blank line here after the error handler.
> 
> > +		memcpy(cximsd->xormaps, cxims->xormap_list,
> > +		       nr_maps * sizeof(*cximsd->xormaps));
> > +		cximsd->nr_maps = nr_maps;
> > +		cxlrd->platform_data = cximsd;
> > +	}
> 
> For local consistency and because it is nicer in general to have
> returns separated by a blank line, put one here as well.
> 
> > +	return 0;
> > +}
> > +
> 
> 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index ac75554b5d76..d03aa1776fc8 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -324,18 +324,24 @@ struct cxl_switch_decoder {
> >  	struct cxl_dport *target[];
> >  };
> >  
> > +struct cxl_root_decoder;
> > +struct cxl_endpoint_decoder;
> 
> Looks like the cxl_endpoint_decoder is currently defined above this anyway so don't
> think this forwards ref is needed.
> 
> > +typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
> > +					    int pos);
> >  
> >  /**
> >   * struct cxl_root_decoder - Static platform CXL address decoder
> >   * @res: host / parent resource for region allocations
> >   * @region_id: region id for next region provisioning event
> >   * @calc_hb: which host bridge covers the n'th position by granularity
> > + * @platform_data: platform specific configuration data
> >   * @cxlsd: base cxl switch decoder
> >   */
> >  struct cxl_root_decoder {
> >  	struct resource *res;
> >  	atomic_t region_id;
> > -	struct cxl_dport *(*calc_hb)(struct cxl_root_decoder *cxlrd, int pos);
> > +	cxl_calc_hb_fn calc_hb;
> > +	void *platform_data;
> >  	struct cxl_switch_decoder cxlsd;
> >  };
> >  
> > @@ -580,8 +586,11 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
> >  struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
> >  bool is_root_decoder(struct device *dev);
> >  bool is_endpoint_decoder(struct device *dev);
> > +
> 
> trivial, but unrelated whitespace change shouldn't really be in here.
> 
> >  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> > -						unsigned int nr_targets);
> > +						unsigned int nr_targets,
> > +						cxl_calc_hb_fn calc_hb);
> > +struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos);
> >  struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> >  						    unsigned int nr_targets);
> >  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
> 
