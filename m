Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62BC361640
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349486; cv=none; b=k/QpER8quwV3ef7vMIjh9N8+Wug61tLpIKppS5t31xRU4rsUa5qQoqn4YEjnB+StRkMaUa2V+r46G0nN46PQMkZW83iA8VLWZWCxbva7T9DgpP9GnlpRTjv89Cgh9UCsVLNc8W8iCbvQIWRTGXTo/0mFZgz31ScqsdXS/+PPUJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349486; c=relaxed/simple;
	bh=N+8TzZw2aJrwhLnUA9j+hKHNHeC0EHkepfmoLo4LInE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITacA6QS5HiUfAXzooPSOmRkM8oEQF1R+ek2x7snFpGD4x6AavoUOt6WvJUX/5XpNQIG0+S1YZgOj3tmMvCIs5K8NYdylxFd6q0fHhVayRAlNUFDuZLGzBmYi0A1nQ/MiUJjNxFseVeEXVLDS5CoAdmTGMOO70ZyI4c6UjdEwbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h46omt3L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h46omt3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA5F1F000E9;
	Fri, 21 Aug 2026 21:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787349485;
	bh=zZm2fEDabSmCIkMcaBLv8BA2cKHy7UPR/0FE3KdxErA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h46omt3LU+7Tv00YAUKi/Wx42vDt1EUumXxsZUNdXoB6eCuck8F2dkuv7iYxKcqAz
	 VIT5TFwsiK3Yv5Cb/uzaNugJs7stjGMuIu1Uh3PWnEmHgMMaejbXveXQzpFUbdKD8X
	 DWoLu3h5cwu/ANxZ6KPXXbRoWVUCukgjUitudrC7u463Q0V7il41Dl9sVS/3Hd8eDc
	 qkWlvo/+BPfVQOnhbitxKFJDIEyQm7PKXzpWE/Q1wGoH0ROvjjC6UOZj0DSnQdnQOg
	 0hgKEpz9Zpvkv/HFJjqqjlv3NBdmT3ns7QL4LI91rDT7IgLQmP676lBarxJV02GdG0
	 dlHEj37ivWG7A==
Date: Fri, 21 Aug 2026 22:57:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 3/6] cxl/region: Support mixed-granularity auto
 regions
Message-ID: <20260821225759.6cfec077@jic23-huawei>
In-Reply-To: <465a9a3e68144a41af45ca1cdfa642e7af553c4e.1787255388.git.alison.schofield@intel.com>
References: <cover.1787255388.git.alison.schofield@intel.com>
	<465a9a3e68144a41af45ca1cdfa642e7af553c4e.1787255388.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 16:31:21 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> The CXL Specification permits a region's interleave granularity to
> differ between levels of the decoder hierarchy. For an auto region,
> the CXL driver reconstructs that hierarchy from the decoder
> configuration programmed by platform firmware.

With my fussy hat on (I blame Friday!), guidance for commit message wrap is
75 chars so bit longer than here.

> 
> The CXL driver currently assumes the interleaving root has the same
> granularity as the region, with each successive interleaving level
> becoming coarser toward the endpoints. This prevents the driver from
> assembling an auto region where the root granularity is coarser than
> the region granularity.
> 
> Support mixed-granularity auto regions in the CXL driver, restricted
> to coarse-to-fine layouts. Derive each interleaving decoder's
> granularity from its parent:
> 
>         child_ig = parent_ig / child_iw
> 
> The topology determines each decoder's interleave ways, so the parent
> granularity and child ways determine the child granularity. Use that
> relationship to validate the decoder geometry while assembling an auto
> region.
> 
> Require the root and region to describe the same interleave span:
> 
>         root_iw * root_ig == region_iw * region_ig
> 
> The same span relationship covers the CXL Specification's Mod3
> configurations. For example, a 6-way region at IGB across three host
> bridges uses a 3-way root interleave at 2 * IGB and a 2-way interleave
> at IGB below it, as described in CXL 4.0 Section 9.13.1.1.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

This interleave stuff is a rapid path to a headache :( - I vaguely wondered if
we can use a few local variable names to make it clear which ig and which iw
each one is.

I'll go as far as I saying I ran some "paper tests" and it seems right
but I've been out of this stuff long enough I'm not feeling that confident.
Good thing you have tests in a later patch :)

> ---
>  drivers/cxl/core/region.c | 114 ++++++++++++++++++++++++--------------
>  1 file changed, 73 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4f367feaf6c8..637d1b60a570 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1434,6 +1434,16 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	return 0;
>  }
>  
> +/* Mixed granularity has a region IG finer than the interleaving root IG */
> +static bool cxl_region_is_mixed_gran(struct cxl_region *cxlr)
> +{
> +	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
> +
> +	return cxld->interleave_ways > 1 &&
> +	       cxld->interleave_granularity >
> +		       cxlr->params.interleave_granularity;

	return cxld->interleave_ways > 1 &&
	       cxld->interleave_granularity > cxlr->params.interleave_granularity;

I'd go a little long to improve readability.

> +}

...
  
> +static int cxl_region_validate_interleave(struct cxl_region *cxlr)
> +{
> +	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p = &cxlr->params;
> +	int root_iw = cxld->interleave_ways;
> +	int root_ig = cxld->interleave_granularity;
> +
> +	if (root_iw == 1)
> +		return 0;
> +
> +	if (p->interleave_granularity > root_ig) {

This took me a while.  It's specific case of more general one that region
granularity can't be greater than any decoder granularity in the path.
I was trying to figure out what was special about the root :(

> +		dev_dbg(&cxlr->dev,
> +			"granularity %d exceeds root decoder granularity %d\n",
> +			p->interleave_granularity, root_ig);
> +		return -ENXIO;
> +	}
> +
> +	/* Same-gran power-of-two regions may span multiple root targets */
> +	if (is_power_of_2(root_iw) && p->interleave_granularity == root_ig)

So this is our original fine to coarse check dropping out nice and early?
What is this letting through that doesn't get through next check anyway?
If power of 2 and root_ig == region_ig aren't we guaranteed that
root_iw == region_iw and next test passes anyway.
Basically I'm lost on what this test is here for.  What do you mean by
span multiple root targets that isn't true of the x12?

> +		return 0;
> +
> +	/* Mixed-gran regions must span exactly one root interleave */

Maths is fine, but I'm getting confused by terms.  This is talking I think
about complete interleave cycles or maybe strides depending on definitions?

> +	if (root_iw * root_ig != p->interleave_ways * p->interleave_granularity) {
> +		dev_dbg(&cxlr->dev,
> +			"%d ways at %d does not span root decoder %d ways at %d\n",
> +			p->interleave_ways, p->interleave_granularity, root_iw,
> +			root_ig);
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}

