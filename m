Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A048DB46
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175150; cv=none; b=hiNS6CtL0aOuXE38Wa3hqkPLd72hNUBbsmMYQHpnf4ps1WP7+scSJqfkzVuiDvm/ySUZS3Klineo4XqvNeQ0VBjkVTrLE4WTIFhiPLCtIEohQTgORx7NZSlcjjtaQ0VaPGAXBsCNCyDwNcmulDeybSBDFwctu9BipmBxVl1w8s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175150; c=relaxed/simple;
	bh=rXryzrewEk6jaDaX4NIehGWVvIN4spzIKp8E0DNr1RI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OS+Gpc0lkSuH/2ts6VnL3NSMn8GgvRu4w1S11pwcQCqTxX6jUKGJhQccoJ3Zh0SgRu/NO9vGTw6XqpzyMZGCD3aIwkwIpTE8R95aSleHK3PbURrhaHeWG/NLaD6u4CgvuyIuwOwnok9vUJ+cgwPOE0M+LkJabUTb2rKWwmeeric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXGxbjZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXGxbjZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BA81F000C4;
	Fri, 16 Oct 2026 18:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792175148;
	bh=6hoGRa6s7Ie1SvWxs3P9qxeW/XBdPXeFa/ssyA3Xowc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AXGxbjZRiaOJ1N6+tIgtm//NTITuI0HuHMDRuCLDHNpa4UPS1uu4YbI+bp4S9CE/h
	 +5gTr20qSsggxddD7xSFcKc9m7LgnrjwgaJ92unUKQwhcNNVeRxtOAzzwKBQQnvmCS
	 H1aOzGU9H94Nz8xlv/dcMMBJCEJqsmfIO0BEdX9LOQtXIUK0mOzs1VZscEG3NWhLdN
	 QjZR29wYVd+dnxA7SpBxn21N1l0xgAnkJM+SHisAUpHmr3hSRcmGYiJlxGFQUgpST7
	 OU0lDKSPMoms7uvAz1qwkyhumFX6gOb7FI9xIKhISXOOFILBVF1X4Pp0o8A7TFnPJI
	 dC8kLEL50w6/Q==
Date: Fri, 16 Oct 2026 19:25:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming
 <ming.li@zohomail.com>, linux-cxl@vger.kernel.org, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/7] cxl/region: Factor out cxl_port_peer_distance()
Message-ID: <20261016192543.5895c34c@jic23-hlaptop>
In-Reply-To: <as9E1ldLkjpdfTDr@MWDK4CY14F>
References: <cover.1791860305.git.alison.schofield@intel.com>
	<ab51546efee79855622d10a71993ef7d21ee247f.1791860305.git.alison.schofield@intel.com>
	<as9E1ldLkjpdfTDr@MWDK4CY14F>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 17:02:35 +0800
Richard Cheng <icheng@nvidia.com> wrote:

> On Mon, Oct 12, 2026 at 09:25:59PM +0800, Alison Schofield wrote:
> > cxl_switch_port_setup_targets() is nearly 200 lines long and open codes
> > each step of adding an endpoint to a port's decoder. One of those steps
> > calculates the distance between region positions that share a downstream
> > port.
> > 
> > Move that calculation to a new helper, cxl_port_peer_distance().
> > 
> > No functional change.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>  
> 
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> 
> This patch inspired me that there might be some space for optimization when
> facing different topology, while keeping this one as a generic arithmetic.
> 
> I'll try to draft a RFC patch series these days.

The patch Richard sent probably just wants rolling in here or slotting
in immediately after. 


> 
> Best regards,
> Richard Cheng.
> 
> > ---
> >  drivers/cxl/core/region.c | 50 +++++++++++++++++++++++----------------
> >  1 file changed, 29 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 9b0e2f195d1f..ea281ce4ec49 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1432,6 +1432,33 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * The "distance" between peer downstream ports represents which
> > + * endpoint positions in the region interleave a given port can
> > + * host.
> > + *
> > + * For example, at the root of a hierarchy the distance is
> > + * always 1 as every index targets a different host-bridge. At
> > + * each subsequent switch level those ports map every Nth region
> > + * position where N is the width of the switch == distance.
> > + */
> > +static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr)
> > +{
> > +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> > +	struct cxl_region_ref *cxl_rr_iter;
> > +	struct cxl_port *iter = port;
> > +	int distance = 1;
> > +
> > +	do {
> > +		cxl_rr_iter = cxl_rr_load(iter, cxlr);
> > +		distance *= cxl_rr_iter->nr_targets;
> > +		iter = to_cxl_port(iter->dev.parent);
> > +	} while (!is_cxl_root(iter));
> > +	distance *= cxlrd->cxlsd.cxld.interleave_ways;
> > +
> > +	return distance;
> > +}
> > +
> >  static int cxl_switch_port_setup_targets(struct cxl_port *port,
> >  					 struct cxl_region *cxlr,
> >  					 struct cxl_endpoint_decoder *cxled)
> > @@ -1445,7 +1472,6 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
> >  	struct cxl_region_params *p = &cxlr->params;
> >  	struct cxl_decoder *cxld = cxl_rr->decoder;
> >  	struct cxl_switch_decoder *cxlsd;
> > -	struct cxl_port *iter = port;
> >  
> >  	/*
> >  	 * While root level decoders support x3, x6, x12, switch level
> > @@ -1460,27 +1486,9 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
> >  
> >  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> >  	if (cxl_rr->nr_targets_set) {
> > -		int i, distance = 1;
> > -		struct cxl_region_ref *cxl_rr_iter;
> > +		int distance = cxl_port_peer_distance(port, cxlr);
> >  
> > -		/*
> > -		 * The "distance" between peer downstream ports represents which
> > -		 * endpoint positions in the region interleave a given port can
> > -		 * host.
> > -		 *
> > -		 * For example, at the root of a hierarchy the distance is
> > -		 * always 1 as every index targets a different host-bridge. At
> > -		 * each subsequent switch level those ports map every Nth region
> > -		 * position where N is the width of the switch == distance.
> > -		 */
> > -		do {
> > -			cxl_rr_iter = cxl_rr_load(iter, cxlr);
> > -			distance *= cxl_rr_iter->nr_targets;
> > -			iter = to_cxl_port(iter->dev.parent);
> > -		} while (!is_cxl_root(iter));
> > -		distance *= cxlrd->cxlsd.cxld.interleave_ways;
> > -
> > -		for (i = 0; i < cxl_rr->nr_targets_set; i++)
> > +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> >  			if (ep->dport == cxlsd->target[i]) {
> >  				rc = check_last_peer(cxled, ep, cxl_rr,
> >  						     distance);
> > -- 
> > 2.37.3
> >   

