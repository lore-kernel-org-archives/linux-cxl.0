Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03377200BF
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="es/p8sUe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBF610C2
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698083479; x=1729619479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qk386+k6+ylLkHcmfsqZyYFU8e73F4GJ9FvWFWzEl3Y=;
  b=es/p8sUeyZKoNOZbh+TE4z+kEQrBp9MBsb619jowT4CrfTwVGgujUMPQ
   GyrCsqebq/64GPI0f6N4LXWqlVPg4dfVTFIRJbf8Gn0ncCq6ahAZjayDe
   /ig4e+dIl7HXe/cCTrkXsSd3vSofNAqJxbM2WT5AyL3YKRf7CdGUtNiRn
   jplsnnuKXC+MU04R5KoM2+lbnlyOrtTX5X36tjLULMjCxp7dFqGyWyVTP
   sh0Dyk5bafD/gAtuG384s0KnEcRlfCLOoqQw5WPSubFrHoFR4NDsnkw58
   LEPYrroHLzN1upqR4zdz3vUeNR2hi1bZBMefImARdVvFgJZYwu5qODu4r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="8450849"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="8450849"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 10:51:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="708014166"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="708014166"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.152.143])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 10:51:18 -0700
Date: Mon, 23 Oct 2023 10:51:16 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jim Harris <jim.harris@samsung.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	Dmytro Adamenko <dmytro.adamenko@intel.com>
Subject: Re: [PATCH v2 1/3] cxl/region: Prepare the decoder match range
 helper for reuse
Message-ID: <ZTaylNA5Y2LSiULv@aschofie-mobl2>
References: <cover.1697433770.git.alison.schofield@intel.com>
 <CGME20231016060244uscas1p15e15e2d44388f12511a67c003dc2bff5@uscas1p1.samsung.com>
 <8dd4210f464e971a7989c7c923747cf2e10409ef.1697433770.git.alison.schofield@intel.com>
 <CDA18391-931B-4564-8B97-9DE92790C9CA@ssi.samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CDA18391-931B-4564-8B97-9DE92790C9CA@ssi.samsung.com>

On Tue, Oct 17, 2023 at 04:21:06PM +0000, Jim Harris wrote:
> 
> 
> > On Oct 15, 2023, at 11:02 PM, alison.schofield@intel.com wrote:
> > 
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
> > 
> > Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> > Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > drivers/cxl/core/region.c | 16 ++++++++++------
> > 1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 6d63b8798c29..64206fc4d99b 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1487,16 +1487,19 @@ static struct cxl_port *next_port(struct cxl_port *port)
> > return port->parent_dport->port;
> > }
> > 
> > -static int decoder_match_range(struct device *dev, void *data)
> > +static int match_switch_decoder_by_range(struct device *dev, void *data)
> > {
> > - struct cxl_endpoint_decoder *cxled = data;
> > + struct range *r1, *r2 = data;
> > struct cxl_switch_decoder *cxlsd;
> > 
> > if (!is_switch_decoder(dev))
> > return 0;
> > 
> > cxlsd = to_cxl_switch_decoder(dev);
> > - return range_contains(&cxlsd->cxld.hpa_range, &cxled->cxld.hpa_range);
> > + r1 = &cxlsd->cxld.hpa_range;
> > + return range_contains(r1, r2);
> > +}
> 
> Hi Alison,
> 
> This stray closing brace needs to be removed from this patch.

Got it, thanks!


> 
> Rest of the patch looks good, I agree the naming is much better with these
> changes.
> 
> Reviewed-by: Jim Harris <jim.harris@samsung.com>
> 
> > +
> > }
> > 
> > static void find_positions(const struct cxl_switch_decoder *cxlsd,
> > @@ -1565,7 +1568,8 @@ static int cmp_decode_pos(const void *a, const void *b)
> > goto err;
> > }
> > 
> > - dev = device_find_child(&port->dev, cxled_a, decoder_match_range);
> > + dev = device_find_child(&port->dev, &cxled_a->cxld.hpa_range,
> > + match_switch_decoder_by_range);
> > if (!dev) {
> > struct range *range = &cxled_a->cxld.hpa_range;
> > 
> > @@ -2696,7 +2700,7 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> > return rc;
> > }
> > 
> > -static int match_decoder_by_range(struct device *dev, void *data)
> > +static int match_root_decoder_by_range(struct device *dev, void *data)
> > {
> > struct range *r1, *r2 = data;
> > struct cxl_root_decoder *cxlrd;
> > @@ -2827,7 +2831,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
> > int rc;
> > 
> > cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
> > -      match_decoder_by_range);
> > +      match_root_decoder_by_range);
> > if (!cxlrd_dev) {
> > dev_err(cxlmd->dev.parent,
> > "%s:%s no CXL window for range %#llx:%#llx\n",
> > -- 
> > 2.37.3
> > 
> > 
> 
