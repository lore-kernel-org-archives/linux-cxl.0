Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9A10F2
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 00:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788825812; cv=none; b=ZyyAJcFVYnMccYeku1/cNDdZHlXdTbYwH5wrR2bGUjX94zDnfd0a0lR3+5eX9kRIb9c0NBkQOU/SBIBuDMavVtIlw1v3YQe2BJhMZtnpo8upIkDQYntFnC+lgRzw1gIsrf2sr3MHSUkyz8Sjuet37fujrqM+UVnAm9hy3ftbJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788825812; c=relaxed/simple;
	bh=z82noY0gBMqTOZBoYy7fB7+DlwyZ6xtW8/zMc+7uZs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBTOiF/5ZHV+hlFIY9uezAeFQ69soLkH4xBvMuHHyrVLsORSqM33Wq9XUsGkqyNDAvLIIIFt2vsFFZLRmis5/OCK2NQg/8pUQp2shk7/Ex+OtWzb7uQS3iz/iJh1gsm7pwmO9552qaKc73XtiTC9RgBOean53iDNe60HzXrsrhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTFAgUQ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTFAgUQ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5983E1F00A3A;
	Tue,  8 Sep 2026 00:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788825810;
	bh=CyTjVbXA9PUQL9U9rrmjwuc5C5JXkQCcmgjOEyxTCaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TTFAgUQ976vByFm1XkfdA4jiQdZO1SFRJ8kEaqqxo09BJa4Yi5G2e3E96LvZxpoGR
	 HZk/yEa2en2U5I1pvj22pFrzg+MJvN/VAsalyTeyMXxTmEmnBUmE8rH2jfxlVghWXt
	 pU4xkssfBScyWE4+XBI3kmL+2i3w9HLevFGvYNnu1qf8kubSySJ7PXiTfxtHspayYz
	 Hija26ev+NlOClVulY+EA2jBpnqEKQuAXDiItqyrorXCGGOAB8eFtki0eQIP5a9ytC
	 QMe6UKZ/yTC4qbxiB8fOMHEq74RJhLoeP6CmnciaZaY7gTVB/ZBHaYV7fODmAZjsfQ
	 CWQgfJYvH0/Fg==
Date: Tue, 8 Sep 2026 01:03:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
 linux-cxl@vger.kernel.org, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 6/7] cxl/region: Support mixed-granularity user
 created regions
Message-ID: <20260908010324.519e0aa4@jic23-huawei>
In-Reply-To: <9929a7f5a2d8c05fe345252bef28c11fc36867c6.1788475206.git.alison.schofield@intel.com>
References: <cover.1788475206.git.alison.schofield@intel.com>
	<9929a7f5a2d8c05fe345252bef28c11fc36867c6.1788475206.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 16:23:48 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> User region creation currently requires an interleaving root to have the
> same granularity as the region.
> 
> That rejects mixed-granularity layouts, those where the region granularity
> is finer than the granularity of the interleaving root decoder. A region
> granularity coarser than the root remains invalid because it produces
> incorrect DPA translations.
> 
> Allow a region granularity finer than an interleaving root and continue to
> reject a coarser granularity. Validate the complete ways/granularity
> relationship when the region endpoints are attached.
> 
> For example, CXL 4.0 Section 9.13.1.1 Table 9-7 describes a 6-way region at
> IGB across three host bridges as a 3-way root interleave at 2 * IGB with a
> 2-way interleave at IGB below it.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Follow on for earlier comment. Not important though.

> ---
>  drivers/cxl/core/region.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5b7104a55fdd..374d8c2c32d1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -572,16 +572,13 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
>  	if (rc)
>  		return rc;
>  
> -	/*
> -	 * When the host-bridge is interleaved, disallow region granularity !=
> -	 * root granularity. Regions with a granularity less than the root
> -	 * interleave result in needing multiple endpoints to support a single
> -	 * slot in the interleave (possible to support in the future). Regions
> -	 * with a granularity greater than the root interleave result in invalid
> -	 * DPA translations (invalid to support).
> -	 */
> -	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
> +	/* Region granularity must not be coarser than an interleaving root's */

This is same as I raised earlier. To me the description of it the other way
around as any given decoder can't have granularity finer than the root is easier
to understand but meh, up to you.

> +	if (cxld->interleave_ways > 1 && val > cxld->interleave_granularity) {
> +		dev_dbg(&cxlr->dev,
> +			"granularity %d exceeds root decoder granularity %d\n",
> +			val, cxld->interleave_granularity);
>  		return -EINVAL;
> +	}
>  
>  	lockdep_assert_held_write(&cxl_rwsem.region);
>  

