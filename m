Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E594285C87
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094155; cv=none; b=hnJ10KxwjoX1a7FrgRvU63mjyFzhaaWq7Pqpi62CWXh6Prp5b5XKgNJSNb6OmrfRKKJgDLWeYbb6c+yCMbwUXVAq3cYxkw6UbSjZjg3JeKjMu5vRvitO3C/j9ZBdoGIuiG5gC0fKFVeHpQAekuTXaVJnr9PPeQI9GMRJs03n5Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094155; c=relaxed/simple;
	bh=Vtm4XdxZwgeAvnlm6RY0eCclELyAMeUZTWsaRXukuo0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLd1sldrTCGRF9kUY6SgA8XAMw/w6BUhYpRcQBS578LcNO7+mIJXyn2XhAqrpAC/i/aT6GcUzPl+tTc9QyNO+Nc70QX5dzHcO5ln25yMWvZhdWdLGjEQCDb58O7tpa8mumCDprxq7+h0RnqfCgWqU6fXeS6e2Fs2leNd/EasFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4blxXg3k2vz6L4sy;
	Mon, 21 Jul 2025 18:32:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D544140114;
	Mon, 21 Jul 2025 18:35:50 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 21 Jul
 2025 12:35:50 +0200
Date: Mon, 21 Jul 2025 11:35:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] cxl/region: Introduce SPA to DPA address
 translation
Message-ID: <20250721113548.0000520d@huawei.com>
In-Reply-To: <aHgZEbvyuf4h0Kk6@aschofie-mobl2.lan>
References: <cover.1752365427.git.alison.schofield@intel.com>
	<28eeffc8905e658dc3ed62a7c52e030cbcfd5158.1752365427.git.alison.schofield@intel.com>
	<20250716115226.000067fc@huawei.com>
	<aHgZEbvyuf4h0Kk6@aschofie-mobl2.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 16 Jul 2025 14:26:41 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Wed, Jul 16, 2025 at 11:52:26AM +0100, Jonathan Cameron wrote:
> > On Sat, 12 Jul 2025 19:37:55 -0700
> > alison.schofield@intel.com wrote:
> >   
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > Add infrastructure to translate System Physical Addresses (SPA) to
> > > Device Physical Addresses (DPA) within CXL regions. This capability
> > > will be used by follow-on patches that add poison inject and clear
> > > operations at the region level.
> > > 
> > > The SPA-to-DPA translation process follows these steps:
> > > 1. Apply root decoder transformations (SPA to HPA) if configured.
> > > 2. Extract the position in region interleave from the HPA offset.
> > > 3. Extract the DPA offset from the HPA offset.
> > > 4. Use position to find endpoint decoder.
> > > 5. Use endpoint decoder to find memdev and calculate DPA from offset.
> > > 6. Return the result - a memdev and a DPA.
> > > 
> > > It is Step 1 above that makes this a driver level operation and not
> > > work we can push to user space. Rather than exporting the XOR maps for
> > > root decoders configured with XOR interleave, the driver performs this
> > > complex calculation for the user.
> > > 
> > > Steps 2 and 3 follow the CXL Spec 3.2 Section 8.2.4.20.13
> > > Implementation Note: Device Decode Logic.
> > > 
> > > These calculations mirror much of the logic introduced earlier in DPA
> > > to SPA translation, see cxl_dpa_to_hpa(), where the driver needed to
> > > reverse the spec defined 'Deivce Decode Logic'.  
> > 
> > Device
> >   
> > > 
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>  
> > Hi Alison,
> > 
> > A few minor things inline.   
> > > ---
> > > 
> > > Changes in v3:
> > > Check return of ways_to_eiw() & granularity_to_eig() (Jonathan)
> > > Collapse a header comment into pos and offset blocks (Jonathan)
> > > Calc pos for 3,6,12 using actual ways, not always 3 (Jonathan)
> > > Mask off bottom bits in < 8 offset case (Jonathan)
> > > Wrap code comments closer to column 80 (Jonathan)
> > > Use a continue to un-nest a for loop. (Jonathan)
> > > 
> > >  drivers/cxl/core/region.c | 93 +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 93 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index a2ba19151d4f..404f69864d61 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -2956,6 +2956,99 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> > >  	return hpa;
> > >  }
> > >  
> > > +struct dpa_result {
> > > +	struct cxl_memdev *cxlmd;
> > > +	u64 dpa;
> > > +};
> > > +
> > > +static int __maybe_unused region_offset_to_dpa_result(struct cxl_region *cxlr,
> > > +						      u64 offset,
> > > +						      struct dpa_result *result)
> > > +{
> > > +	struct cxl_region_params *p = &cxlr->params;
> > > +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> > > +	struct cxl_endpoint_decoder *cxled;
> > > +	u64 hpa, hpa_offset, dpa_offset;
> > > +	u64 bits_upper, bits_lower;
> > > +	u16 eig = 0;
> > > +	u8 eiw = 0;
> > > +	int pos;
> > > +
> > > +	lockdep_assert_held(&cxl_rwsem.region);
> > > +	lockdep_assert_held(&cxl_rwsem.dpa);
> > > +
> > > +	if (granularity_to_eig(p->interleave_granularity, &eig) ||
> > > +	    ways_to_eiw(p->interleave_ways, &eiw))
> > > +		return -ENXIO;  
> > 
> > Why eat return values to replace with ENXIO? I'd prefer
> > 
> > 	rc = granularity_to_eig(p->interleave_granularity, &eig);
> > 	if (rc)
> > 		return rc;
> > 
> > 	rc = ways_to_eiw(p->interleave_ways, &eiw);
> > 	if (rc)
> > 		return rc;  
> 
> Ah, I should never have tried to appease you with a shortcut.
> Let's revisit.
> 
> In v1,v2 it was this-
> +       ways_to_eiw(p->interleave_ways, &eiw);
> +       granularity_to_eig(p->interleave_granularity, &eig);
> 
> And you asked to check the return value. I *should* have said "No, the
> input validation ensures these are valid. That is, when storing these
> values in the region params, we do eiw_to_ways() and check that rc
> value when storing. I'll note that this is not the first instance of
> using these functions without checking return value. 
> 
> How about one of these:
> 
> Original:
> +       ways_to_eiw(p->interleave_ways, &eiw);
> +       granularity_to_eig(p->interleave_granularity, &eig);
> 
> Original w comment:
> + 	/* Input validation ensures valid ways and gran */
> +       ways_to_eiw(p->interleave_ways, &eiw);
> +       granularity_to_eig(p->interleave_granularity, &eig);

That's fine.

Personally I'd just check them separately and return the errors.
Sometimes it's less effort to add long hand error checks that
never fail (in slow paths!) than it is to explain why not ;)

Jonathan

> 
> Original w caution:
> +	if (!p->interleave_ways || !p->interleave_granularity)
> +		return -ENXIO;
> +       ways_to_eiw(p->interleave_ways, &eiw);
> +       granularity_to_eig(p->interleave_granularity, &eig);
> 
> 
> -- Alison
> 
> 

