Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8902E3112DA
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787337044; cv=none; b=cqVjjkWD7uBqz6dBAXXDVk3OSXQiQM2UCwH9K52tyhJLFVcqzJwZsvDi4WHmDsgCdoAi5yI32Y2oRpPB1tSIyNuaPWSHy/87J0QuBeKJvQZjazKlDTSHmmFROQlR4r8jbTbvS7GwZTHquoOuv75Yh77zJVf7rya3vel7T8oxP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787337044; c=relaxed/simple;
	bh=P8sSTB+j5NwEL3kr5HNmCwi1hjrxjKzsGoW+cZzOH2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUtvjHj9Z+Fq+pC6q7bafB3/WhwME8anof0+lk4sL13uuLSuALsoE2Rq+IEH0/c8mjCc5KT6U32Fj3aiCbHu3JXrrjViE2OmYAMgSWq2Au+vzhzMsyvVGEbzLV2oUEYxp80znwNC2dkycSSq3vqFbe7VGT/pcC7e2RPLZq6ubEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsqn61pO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsqn61pO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C820E1F000E9;
	Fri, 21 Aug 2026 18:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787337043;
	bh=VSdotHHIOy+R9p9E6NoeDuVpdqHDYlleeNLezc6iz7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lsqn61pORK7Knm1Ki2GoHejD+UBw53s2lI/8KWODvgj1kVfrL4BP0f3gS5w3KOIR2
	 dG8jiTqZr6dLQLhN86fCG50ya9jmELNgyaSam8V4wHXVO8Hpxv6wmU9c7zL6fh3Yn8
	 RfckGM0dGEEFwhpMWO3McBWag8FeB4UnYu24bwFIcPed8pXTZvCt+S8ahV5RhQle18
	 ggGYKr9g7LsntAe4XtQ2NqwQu8RGEq3h0JJe1ddoE5ZwjMCQ9Dg+xXc5t4eky471DU
	 OSDDPpiwXPqhEQIA7qt5E+hb1mvlTJ31COmz8wmE1pUkiSeBNU6PkFcMLZyG/oryiW
	 LvARB0KLLHhyA==
Date: Fri, 21 Aug 2026 19:30:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Richard Cheng <icheng@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, Li Ming
 <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] cxl/region: Account for mixed-granularity in
 position calculations
Message-ID: <20260821193039.652baaf4@jic23-huawei>
In-Reply-To: <ajIQH0cA6A95TEQ2@aschofie-mobl2.lan>
References: <cover.1781199122.git.alison.schofield@intel.com>
	<94ec26d420e0e40a2a991c1a4205e9e93cab44de.1781199122.git.alison.schofield@intel.com>
	<aiuhReNj4Q_-HMzF@MWDK4CY14F>
	<ajIQH0cA6A95TEQ2@aschofie-mobl2.lan>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 20:10:23 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Fri, Jun 12, 2026 at 02:21:07PM +0800, Richard Cheng wrote:
> > On Thu, Jun 11, 2026 at 10:47:27AM +0800, Alison Schofield wrote:  
> > > Mixed-granularity regions place the root decoder at outer HPA bits.
> > > A root target then owns root_gran / region_gran inner positions
> > > before the root advances to the next target. That ratio becomes the
> > > root target stride in region positions.
> > > 
> > > Account for that stride in endpoint placement, position calculation,
> > > and peer-distance checks.
> > > 
> > > Remove the temporary mixed-granularity attach reject now that position
> > > arithmetic matches the selector layout.
> > > 
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  drivers/cxl/core/region.c | 79 ++++++++++++++++++++++++++++-----------
> > >  1 file changed, 58 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index d5d19ed62171..9fff538a9ce1 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -1444,12 +1444,34 @@ static inline u64 get_selector(int ways, int gran)
> > >  	return (u64)(ways - 1) * gran;
> > >  }
> > >  
> > > +/**
> > > + * root_pos_stride() - Return root target stride in region positions
> > > + * @cxlr: region
> > > + *
> > > + * Return: root_gran / region_gran when the root granularity is larger
> > > + * than the region granularity, or 1 otherwise.
> > > + */
> > > +static inline int root_pos_stride(struct cxl_region *cxlr)
> > > +{
> > > +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> > > +	int root_gran = cxlrd->cxlsd.cxld.interleave_granularity;
> > > +	int region_gran = cxlr->params.interleave_granularity;
> > > +
> > > +	if (cxlrd->cxlsd.cxld.interleave_ways <= 1)
> > > +		return 1;
> > > +
> > > +	if (region_gran == 0 || root_gran <= region_gran)
> > > +		return 1;
> > > +
> > > +	return root_gran / region_gran;
> > > +}
> > > +  
> > 
> > Hi Alison,
> > 
> > This helper computes stride from gran ratio, but nothing from downstream
> > checks that the stride equals the number of endpoints actually fanned out
> > under one root target.
> > The patch assumes each root target each own stride consecutive region position,
> > when that does not hold, the additive recurrence below and peer-distance seed
> > both mis-account, and we walk off into a foreign endpoint.
> >  
> 
> addressed below...
> 
> 
> snip
> 
> > > @@ -2010,6 +2042,11 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> > >  		if (rc)
> > >  			return rc;
> > >  
> > > +		if (stride > 1 && is_cxl_root(parent_port_of(iter))) {
> > > +			pos = pos + stride * parent_pos;
> > > +			break;
> > > +		}
> > > +
> > >  		pos = pos * parent_ways + parent_pos;
> > >  	}
> > >   
> > 
> > I have a question here, on AUTO path, the check are bitwise and order-independent,
> > so they accept it, then pos comes out d*2+u+4*hb where HPA decodes reads d+2*u+4*hb,
> > so 6 of 12 endpoints get the wrong pos and the region is rejected or mis-mapped.
> > 
> > If my inference is true, it contradicts the cover-letter's "every arrangement" claim.
> > 
> > --Richard  
> 
> Hi Richard,
> 
> (Oh, this got long! Spoiler, I'm proposing we limit to configs where
> root->endpoint gran is only coarser->finer, ie. monotonically
> decreasing. No coarser->finer->coarser(again))
> 
> Thanks for digging into the position arithmetic!  You are right, and your
> two points land on the same root cause that Sashiko raised from the
> peer-distance side. The position calculator assumes every level slices
> inside the chunk of the level above it, root carving the biggest pieces
> and each switch below it slicing finer. When that is true, the math is
> correct. So courser->finer granularity as we go from root to endpoints
> all is good!
> 
> However, when a switch slices at a coarser granularity than the level
> above it, the bits are out of order, the calculator places those
> endpoints wrong, and the region is either rejected or mapped wrong. The
> selector checks don't catch it because they only look at which bits are
> used, not their order, exactly as you described.
> 
> First I revisited the CXL spec. The spec does not explicitly forbid
> courser->finer->courser? It doesn't. Section 9.13.1 only requires that
> the levels use different, consecutive HPA bits. It doesn't actually mandate
> an ordering, so the out-of-order layouts are legal.
> 
> I looked at the CXL Spec and the Driver Writers Guide examples. Every
> example is coarse->fine:
> CXL Spec Figures 9-16, 9-17, 9-18, and SW Guide 2.7.2, 2.7.3, 2.7.4
> 
> The CXL spec enumeration tables go further. Table 9-16 (a 12 way) lists an
> out of order ordering, but that has an equivalent coarse->fine config that
> produces the same results.

Same result in some sense, but not for what pattern goes down a given
link.

> 
> The gist of all that spec talk, is that I cannot say we won't add the
> suppport based on what the spec says.
> 
> Next, I considered teaching the calculator to handle arbitrary bit
> ordering, but I don't think it's the right thing for this series. It
> would mean reworking the core position calculation to gain a case that
> nothing, no spec figure, no table, no firmware I'm aware of, actually
> produces, and that users can already reach another way.
> 
> So what I'd like to do instead is define the scope explicitly as support
> for coarse-to-fine mixed-granularity. That is everything this series set
> out to enable, and a clear superset of today's behavior, where any
> region granularity different from the root's was rejected outright.
> Gracefully fail anything out-of-order with a clear error rather than
> letting it mis-map or oops.
> 
> I also believe it meets Robert Richters (AMD) needs because that original
> patch did not add that support in the selector bit accounting.
> Find link to Roberts original patch in cover letter.
> 
> Does a clean rejection of the out-of-order case work for you?
> 
> Other folks?

To cut to the chase, I don't personally care if we limit the
non fine to coarse cases.

It's not hard to come up with a hardware design where say
128 / 64 / 256 makes sense.

The coarse at the top would be the host wanting to use most efficient
size for the impdef interconnect pre CXL.

With that in mind the system designer may then want to get the overall
granularity down as quick as possible to reduce hot spots on the root
ports where contention is likely to be highest. So splits things
down to 64 bytes.

When we reach the switch, 64 and 128 are gone, so best it can do is 256.

Anyhow, this is one of those - for completeness - messages, if anyone
really really cares then can rework things again!

Jonathan



> 
> 
> -- Alison
> 
> 

