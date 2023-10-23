Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E324204
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzKg23np"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDF9CC
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 16:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698103813; x=1729639813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XwiDFg0DMHv3Bbj24GSFTjrNjNP4XoNl8HVJBaSAKSY=;
  b=JzKg23np1P50hwSEJaI6majWBpvU6bxX+dJNY+uWPaOHBsZre0RTSDKF
   e3Q0OtQSZnfIwlo91AP47u0yUewRPO2qgP5xg6eBGkXvT36zcgitUujy/
   yCrURb+OjVVdAHoHmFeLhOZDVKbDsDj7Ff/t1Lk5ilnvDfaJLCeOd1xDF
   bW05otKUn66YoEZHJRrBcve+61yZJAjfTlF2AOm+JPl9CJ06J7fPqw9ks
   h2Jun6tyAZiUZCEKsd2hCXzteoLjTJ5RsjESSl7Hq3riyiKHNAFNNHta3
   uQTk6pXCSF8VoaQuDU00k13/ZeOWNYnDZ6MBx51nppJer5+bdM3pQvg3I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="389795235"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="389795235"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:30:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="5973155"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.152.143])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:28:56 -0700
Date: Mon, 23 Oct 2023 16:30:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	Dmytro Adamenko <dmytro.adamenko@intel.com>
Subject: Re: [PATCH v2 1/3] cxl/region: Prepare the decoder match range
 helper for reuse
Message-ID: <ZTcCAvus2giVK7ry@aschofie-mobl2>
References: <cover.1697433770.git.alison.schofield@intel.com>
 <8dd4210f464e971a7989c7c923747cf2e10409ef.1697433770.git.alison.schofield@intel.com>
 <6536dd82d3b6d_725832949a@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6536dd82d3b6d_725832949a@dwillia2-xfh.jf.intel.com.notmuch>

On Mon, Oct 23, 2023 at 01:54:26PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > match_decoder_by_range() and decoder_match_range() both determine
> > if an HPA range matches a decoder. The first does it for root
> > decoders and the second one operates on switch decoders.
> > 
> > Tidy these up with clear naming and make the switch helper more
> > like the root decoder helper in style and functionality. Make it
> > take the actual range, rather than an endpoint decoder from which
> > it extracts the range.
> > 
> > Aside from aesthetics and maintainability, this is in preparation
> > for reuse.
> 
> Some minor changelog comments:
> 
> > 
> > Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> 
> Save "Fixes:" for commits that need to be backported to address an
> issue. This will be a dependency for backporting patch2, but on its own
> it does not fix anything.
> 
> > Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
> 
> Along the same lines this probably moves to the patch that fixes the
> report.
> 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/cxl/core/region.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)

snip

> > 
> > +static int match_switch_decoder_by_range(struct device *dev, void *data)
> >  {
> > -	struct cxl_endpoint_decoder *cxled = data;
> > +	struct range *r1, *r2 = data;
> >  	struct cxl_switch_decoder *cxlsd;
> >  
> >  	if (!is_switch_decoder(dev))
> >  		return 0;
> >  
> >  	cxlsd = to_cxl_switch_decoder(dev);
> > -	return range_contains(&cxlsd->cxld.hpa_range, &cxled->cxld.hpa_range);
> > +	r1 = &cxlsd->cxld.hpa_range;
> > +	return range_contains(r1, r2);
> 
> I know this is just maintaining the status quo, but thinking about it a
> bit deeper I think range_contains() is only correct for root decoders.
> For a given region the root decoder will contain the region, but all the
> switch decoders must be a 1:1 mapping. Linux only supports scenarios
> where all endpoint decoders map the same HPA range and identify only 1
> decoder per-switch port to map that region.
> 
> So "range_contains(r1, r2)" becomes "return *r1 == *r2".

Thanks Dan - picked up your changelog suggestions and replace this
range_contains w an 1:1 comparison.

Alison


