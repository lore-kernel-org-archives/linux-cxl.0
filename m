Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928ACC433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 17:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbiKNRjO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 12:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbiKNRjE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 12:39:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A117884
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 09:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668447543; x=1699983543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lc90haM9CwEZXFkriyX7iN97q7e5GiW12EM3QGD5RvY=;
  b=RWT0F8meKw8gmyn+2eoKfD5G7pVwgImY+Obrs5CL/Mh/IbooCyXURaEI
   aA02LAM1fy8TJxiNaWil8RNVlhwuC30kBppLRWMgnJByxEJRSHSgobOrS
   HtACMTg5uXOPBYQe7GH+h604fSPD2SPbnLtPdwENNCexC70r5ZNOUym75
   bJ+Uya5/XUAd5iZO4QmepdGmcz/HpJirtVxzlLF1JLfsGithZdwmUbhCF
   IqLl46ZTC2Fb3DvIJ5CEEKP39M1x/WVTBb+hOKj6gWUyk4jDIK4gYVhmD
   1BtiYOkPdit1gmdZx+8/ijNfumXK2UhHySl29HK0Dp4sCXsSGCDw8HTEY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="295396133"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="295396133"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 09:39:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="640861601"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="640861601"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.56.53])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 09:39:02 -0800
Date:   Mon, 14 Nov 2022 09:39:00 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 2/3] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Message-ID: <Y3J9NCmVX7t34DYD@aschofie-mobl2>
References: <cover.1668227077.git.alison.schofield@intel.com>
 <37ac2e3d3580af13755edd6f8e0bbdf11d5c206b.1668227077.git.alison.schofield@intel.com>
 <20221112062823.4mrp4kz6hxsd3uxw@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112062823.4mrp4kz6hxsd3uxw@offworld>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Nov 11, 2022 at 10:28:23PM -0800, Davidlohr Bueso wrote:

Thanks for the review David!

> On Fri, 11 Nov 2022, alison.schofield@intel.com wrote:
> 
> > +static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
> > +			   const unsigned long end)
> > +{
> > +	struct acpi_cedt_cxims *cxims = (struct acpi_cedt_cxims *)header;
> > +	struct cxl_cxims_context *ctx = arg;
> > +	struct cxl_root_decoder *cxlrd = ctx->cxlrd;
> > +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> > +	struct device *dev = ctx->dev;
> > +	struct cxims_data *cximsd;
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
> > +			dev_dbg(dev, "CXIMS nr_xormaps[%d] expected[%d]\n",
> > +				cxims->nr_xormaps, nr_maps);
> > +			return -ENXIO;
> > +		}
> > +
> > +		cximsd = devm_kzalloc(dev,
> > +				      struct_size(cximsd, xormaps, nr_maps),
> > +				      GFP_KERNEL);
> 
> Need to check for failed kzalloc.
> 

Got it, thanks!

> > +		memcpy(cximsd->xormaps, cxims->xormap_list,
> > +		       nr_maps * sizeof(*cximsd->xormaps));
> > +		cximsd->nr_maps = nr_maps;
> > +		cxlrd->platform_data = cximsd;
> > +		cxlrd->calc_hb = cxl_hb_xor;
> > +	}
> > +	return 0;
> > +}
> > +
> > static unsigned long cfmws_to_decoder_flags(int restrictions)
> > {
> > 	unsigned long flags = CXL_DECODER_F_ENABLE;
> > @@ -33,11 +130,6 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
> > 	int rc, expected_len;
> > 	unsigned int ways;
> > 
> > -	if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
> > -		dev_err(dev, "CFMWS Unsupported Interleave Arithmetic\n");
> > -		return -EINVAL;
> > -	}
> 
> It seems more robust to keep the check and just add the ACPI_CEDT_CFMWS_ARITHMETIC_XOR case.
> 

The reasoning behind removing the check, versus expanding it, is that the
check shouldn't have been there in the first place. The ACPI driver is
responsible for parsing the CFMWS's but it is the responsibility of the
region driver to decide which CFMWS's it can use. 

If you believe that premise, then we let all interleave arithmetics
'get through' to the region driver.

More below on same topic...

> > -
> > 	if (!IS_ALIGNED(cfmws->base_hpa, SZ_256M)) {
> > 		dev_err(dev, "CFMWS Base HPA not 256MB aligned\n");
> > 		return -EINVAL;
> > @@ -84,6 +176,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> > 	struct cxl_cfmws_context *ctx = arg;
> > 	struct cxl_port *root_port = ctx->root_port;
> > 	struct resource *cxl_res = ctx->cxl_res;
> > +	struct cxl_cxims_context cxims_ctx;
> > 	struct cxl_root_decoder *cxlrd;
> > 	struct device *dev = ctx->dev;
> > 	struct acpi_cedt_cfmws *cfmws;
> > @@ -148,7 +241,33 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> > 		ig = CXL_DECODER_MIN_GRANULARITY;
> > 	cxld->interleave_granularity = ig;
> > 
> > +	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
> > +		if (ways == 1 || ways == 3)	{
> > +			/* Skip CXIMS parsing for IW 1 or 3. No xormaps used */
> > +			cxlrd->calc_hb = cxl_hb_xor;
> > +			goto decoder_add;
> > +		}
> > +
> > +		cxims_ctx = (struct cxl_cxims_context) {
> > +			.dev = dev,
> > +			.cxlrd = cxlrd,
> > +		};
> > +
> > +		rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CXIMS,
> > +					   cxl_parse_cxims, &cxims_ctx);
> > +		if (rc < 0)
> > +			goto err_xormap;
> > +
> > +		if (cxlrd->calc_hb != cxl_hb_xor) {
> > +			rc = -ENXIO;
> > +			goto err_xormap;
> > +		}
> > +	}
> > +
> 
> I'm not crazy about now having different layers setting the ->calc_hb callback. Normally
> this is done when cxl_root_decoder_alloc(), and now it gets overwritten and reassigned in
> both parser calls (cfmws and cxims). How about just moving it out of the cxlrd allocation
> call and doing it all here in cxl_parse_cfmws()? You can also avoid the decoder_add goto.

Following on the theme of maintaining the separation of ACPI and REGION
driver responsibilities, the decision on the calc_hb callback doesn't
belong to the ACPI driver. Polluting the ACPI driver w knowledge of
cxl_hb_xor() is not a clean soln either, as you point out.

How about this as a clean(er) separation:

ACPI Driver
-  adds cxlrd->interleave arithmetic field
-  adds fields: .interleave_arithemetic and .callback to the new
   platform data field (ie. cxims_data)

Region Driver
- uses the cxlrd->interleave_arithmetic field to assign callback
- If that interleave_arithmetic is not 'known' to the region driver,
  it can lookup the callback in the cxlrd platform data 
  
I will try the above flow out, and await further discussion on
the separation or ACPI & REGION driver responsibilites.

Thanks for bringing it up David,
Alison

> 
snip
> 
