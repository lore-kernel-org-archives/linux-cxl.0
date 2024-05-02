Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB51F947
	for <linux-cxl@vger.kernel.org>; Thu,  2 May 2024 04:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714624498; cv=none; b=V7NLTo7+8hACJ0KZbMcfH0qKXiaJkZ3fKSypBi01B6u8NdPjvEhElb88KOp0ef4JkCyv5Wu72oXTUCkFG8neId7rv6pDmdjh2AcdCQ6qhaaTiWGmsNYmnNpd8cRbCnOwlTtazMeZjCjmWN5y2JU1uhmW8COl6niNC5aJo/4hmEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714624498; c=relaxed/simple;
	bh=RPKtDNhnCJEOuzGFG7ObTopfIQCL1KDcoN8SlyExBmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aB+k2c9c+MOEe0xhQ3pW1T90+lJVJijb5nRIvMppalGAwGNnZPTTAfijCdnUQRlstt03uESolNg+Sq7DAOjBi5s164aZkFbRLSOMWOFZ4wNDR0/KeEGImi3nx8+IKEviabDeiOITHGC0Q+VbA0b4E2IlecJN07gbMl3PNzffNIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPrU7ww+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPrU7ww+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714624496; x=1746160496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RPKtDNhnCJEOuzGFG7ObTopfIQCL1KDcoN8SlyExBmA=;
  b=fPrU7ww+eD93twIDNhV0MttS0P1ylrxZyberX9NgUadY7A3Nuq4J9k9L
   FfiPnT8TqfUKCGLg8iiOHhE3o3hJLX9wITtzboDOj8rBzVZjNpcoFUk7K
   PqyzKthQhXsrjBL7V6WpMM/4QHb17Dx/1SzJF9g+MRB1joEP6FrX/4cLS
   aL1XZ/2eErquV5dg8RjgMo44SpI2Y1dL1kSmB5j8h6G6bf7Z67Y+wdAwK
   xxDfOA42vWGUpBzyeE9mb00eO08VtL3zjkhBb3WiEtoGCbV3D2KM840pn
   ObjUOMvSsVCAXD5oGKTpbri+j0UpJ5AqVjYKCD2k+bsGDnF6xRWbzTW7Q
   Q==;
X-CSE-ConnectionGUID: BjjCIp9gSkaHAuWLuoMRIg==
X-CSE-MsgGUID: pvw9g3p0TvWCH3eKGIPiPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10544290"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10544290"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 21:34:55 -0700
X-CSE-ConnectionGUID: hHG/ifHyQ6y20sHUtOIiqQ==
X-CSE-MsgGUID: Bl9KF5sdSXGBN8rws35kdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27005840"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.193.14])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 21:34:56 -0700
Date: Wed, 1 May 2024 21:34:53 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/acpi: Restore XOR'd position bits during address
 translation
Message-ID: <ZjMX7djDOSkhmqtV@aschofie-mobl2>
References: <cover.1714159486.git.alison.schofield@intel.com>
 <d4e689f9a9645cbddb943188d508807da33bf91f.1714159486.git.alison.schofield@intel.com>
 <662c4fef695d6_b6e029460@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZjG531aOXtjx209a@aschofie-mobl2>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjG531aOXtjx209a@aschofie-mobl2>

On Tue, Apr 30, 2024 at 08:41:19PM -0700, Alison Schofield wrote:
> On Fri, Apr 26, 2024 at 06:07:59PM -0700, Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > When a CXL region is created in a CXL Window (CFMWS) that uses XOR
> > > interleave arithmetic XOR maps are applied during the HPA->DPA
> > > translation. The XOR function changes the interleave selector
> > > bit (aka position bit) in the HPA thereby varying which host bridge
> > > services an HPA. The purpose is to minimize hot spots thereby
> > > improving performance.
> > > 
> > > When a device reports a DPA in events such as poison, general_media,
> > > and dram, the driver translates that DPA back to an HPA. Presently,
> > > the CXL driver translation only considers the modulo position and
> > > will report the wrong HPA for XOR configured CFMWS's.
> > > 
> > > Add a helper function that restores the XOR'd bits during DPA->HPA
> > > address translation. Plumb a root decoder callback to the new helper
> > > when XOR interleave arithmetic is in use. For MODULO arithmetic, just
> > > let the callback be NULL - as in no extra work required.
> > > 
> > > Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  drivers/cxl/acpi.c       | 49 +++++++++++++++++++++++++++++++++++++---
> > >  drivers/cxl/core/port.c  |  5 +++-
> > >  drivers/cxl/core/trace.c |  5 ++++
> > >  drivers/cxl/cxl.h        |  6 ++++-
> > >  4 files changed, 60 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index af5cb818f84d..519e933b5a4b 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -74,6 +74,44 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
> > >  	return cxlrd->cxlsd.target[n];
> > >  }
> > >  
> > > +static u64 restore_xor_pos(u64 hpa, u64 map)
> > > +{
> > > +	int restore_value, restore_pos = 0;
> > > +
> > > +	/*
> > > +	 * Restore the position bit to its value before the
> > > +	 * xormap was applied at HPA->DPA translation.
> > > +	 *
> > > +	 * restore_pos is the lowest set bit in the map
> > > +	 * restore_value is the XORALLBITS in (hpa AND map)
> > 
> > Might be worth finally clarifying why there is no "XOR" operation in
> > this xor_pos routine, i.e. that XORALLBITS is identical to asking if the
> > hweight of the (hpa & map) is odd or even.
> > 
> 
> Thanks for the review Dan!
> 
> Well, I would except that a few lines below, you suggest I use
> an XOR operand ;) but I know what you mean. Edited in v2.
> 
> Actually, I've abandoned this separate function in v2. Since
> the LOC have been whittled down, seems useless.
> 
> > > +	 */
> > > +
> > > +	while ((map & (1ULL << restore_pos)) == 0)
> > > +		restore_pos++;
> > 
> > This is just open coded ffs()?
> > 
> So it is!  Using ffs() in v2.
> 
> > > +
> > > +	restore_value = (hweight64(hpa & map) & 1);
> > > +	if (restore_value)
> > > +		hpa |= (1ULL << restore_pos);
> > > +	else
> > > +		hpa &= ~(1ULL << restore_pos);
> > 
> > It feels like this conditional mask / set can just be an xor operation?
> > 
> >     hpa ^= ((hweight64(hpa & map) & 1) << restore_pos);
> 
> I've taken the XOR operand piece, but didn't collapse into the
> one-liner you suggest.  See what you think in v1 please.

I jumped on the Dan-Bandwagon too hastily. The hpa ^= doesn't
work because it toggles the bit. ie It won't clear hpa[restore_pos]
if restore_value is not set, and it needs to.

This works and is more concise than the original if-else:
	hpa = (hpa & ~(1ULL << pos)) | (val << pos);

I've changed a few things around it, but didn't want to leave
this dangling out here for another reviewer to ponder.

> 
> > 
> > Otherwise I question the & and | operations relative to the HPA bit
> > position already being 0 or 1.
> > 
> 
> They are gone in next rev, but FWIW here's the truth about those ops:
> 
> if restore_value == 1, using |= always sets the bit at restore_pos
> like this:
> 	restore_value  current_value  |= value
> 	1		0		1
> 	1		1		1
> 
> if restore_value == 0, using &= always clears the bit at restore_pos
> like this:
> 	restore_value  current_value  |= value
> 	0		0		0
> 	0		1		0
> 
> > > +
> > > +	return hpa;
> > > +}
> > > +
> > > +static u64 cxl_xor_trans(struct cxl_root_decoder *cxlrd, u64 hpa, int iw)
> > 
> > Ok, so the driver has cxl_trace_hpa() and now cxl_xor_trans() and
> > "addr_trans". Can these all just be called "translate" because "trace"
> > feels like tracing, "trans" is only saving 4 characters, and "addr" is
> > redundant as nothing else needs translating besides addresses in CXL
> > land.
> 
> I think i've got it:
> 
> Existing:
> cxl_trace_hpa() -> cxl_translate()
> 
> Introduced in this set:
> cxl_addr_trans_fn -> cxl_translate_fn
> addr_trans -> translate
> cxl_xor_trans() -> cxl_xor_translate()
> 
> > 
> > [..]
> > > diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
> > > index d0403dc3c8ab..a7ea4a256036 100644
> > > --- a/drivers/cxl/core/trace.c
> > > +++ b/drivers/cxl/core/trace.c
> > > @@ -36,6 +36,7 @@ static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
> > >  static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
> > >  			  struct cxl_endpoint_decoder *cxled)
> > >  {
> > > +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> > >  	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
> > >  	struct cxl_region_params *p = &cxlr->params;
> > >  	int pos = cxled->pos;
> > > @@ -75,6 +76,10 @@ static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
> > >  	/* Apply the hpa_offset to the region base address */
> > >  	hpa = hpa_offset + p->res->start;
> > >  
> > > +	/* An addr_trans helper is defined for XOR math */
> > 
> > Rather then calling out XOR math since that is an ACPI'ism I would just
> > say something like: "root decoder overrides typical modulo decode"
> 
> Got it.
> 
> -- Alison
> 
