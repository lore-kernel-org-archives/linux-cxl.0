Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269062E3F8
	for <linux-cxl@vger.kernel.org>; Tue, 17 Oct 2023 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPR7zHSc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84219F
	for <linux-cxl@vger.kernel.org>; Tue, 17 Oct 2023 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697575398; x=1729111398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KWZSUf3Sx4lu1sknu+OXDvkvk+paiZKV6KKDC8Z3dok=;
  b=OPR7zHSc2NOsd+0I1YIWb/lMRIOfxTXb896aL/0gThSWmr1ZyyzM+uYZ
   wsp9bgQwZWgxPIEKfAy0/u0A8JAlW0iRYkrBlkL6BtzEyWrMHFbS2d95G
   My3eEZ/MCpVRapyfaELmMVKJ1YSrwll3vUp3M0v5c2h8DABt9SlUnXCVO
   aOSsSBC9bL81bnWiEVIFKR2Ds4nM7Ah/fDK4Ie9ESwpq5YjgWvuvJrlEo
   fMxQaoAOjiPv9OlQMXDA9CEVL+SbLQcyCvSd5ng9PwuttG06ToH/Kg9e8
   9vhE/tD34nT/bKI52Pa6BBLN/N14ppjCCxqHl474JskQoHrOtybBKIgYp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="4475220"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="4475220"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="4076513"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.28.249])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:42:11 -0700
Date: Tue, 17 Oct 2023 13:43:15 -0700
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
Message-ID: <ZS7x48xnvGzkyBF1@aschofie-mobl2>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
> 
> Rest of the patch looks good, I agree the naming is much better with these
> changes.
> 
> Reviewed-by: Jim Harris <jim.harris@samsung.com>
>

Thanks for the review.

Your replies are removing the leading indentation from the original
patch. I see it viewing in my mailer and w browser:
https://lore.kernel.org/linux-cxl/cover.1697433770.git.alison.schofield@intel.com/T/#m1d4fba325a175520b8a43964ae44a28424177448

So, I think it's something on your end.

???

Alison

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
