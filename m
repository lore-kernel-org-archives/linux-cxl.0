Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEA440B398
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349617; cv=none; b=D2l4HeeX9f60jiiCLL22kK2dpoodZflpC+40hZ071BZcyOwf6bcJcdjxJGeMQifHpkdvKZc9aKBTu1+6jKTgCwz9QCV9nAqWuQmF+k5fco6aqTVcu9z33fLPKLrTmsamlkq+P9XYI62ziSHtg+dQeltlsDw5clj5q3RNhOQnj/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349617; c=relaxed/simple;
	bh=CFTsCG9lVPvSd1i34Q5Lks/Zm4aT6X7HMcDN8uIgNxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcpH44L0/PDX+qys9IpTb7jf88/Xemd8uJUC0Vsx4ccZhKWFct4pjnD56EXT7Kw4B/AAx5vPcXK+yis9ojAe+O+OBVgNVEerdnKm1STf8yl9T4REtoKvZc2o4ZGXIGN6iMDysZ7KmbDuLwpIUEURUgYD3mki6woGclUNIf9C3Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqPwY+fS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqPwY+fS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01541F000E9;
	Fri, 21 Aug 2026 22:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787349616;
	bh=YmgwfVNQoVBo30iC/LO5QeMf4JCqhQj+lyPxc7JDlII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aqPwY+fSyIjpIoxQ2BFkklAEUnbzplt3WNEtFKkIbeElO16+lVUKqOGtNw3ayEDxt
	 9e1Pe8yaAO7RVEV1VLgBiNxUwcmJD5bFJN00NKFTFU7SIxZ5FaUgO9P+G00ZbTHfBc
	 WXakiOd0RzRFcuxFe6AKsPK5F3vsf4wENmO+HivDOOHcTp5hrnRAr2VqS+IIpIoJen
	 LYt32nflcrMVAeadzXt0RVq+3o5lNVrPXnfiQugGyEDoCajSP20DRCLR7IFZVOyrCy
	 IB0YPY+B90OLxZA7yE+n38rsDSxqgCOyRbN1sNeVjsOYHLAULI63BJfMlRS9RyE2Tq
	 Lk+0kxWkZQW1A==
Date: Fri, 21 Aug 2026 23:00:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 4/6] cxl/region: Support mixed-granularity user
 created regions
Message-ID: <20260821230009.245382d2@jic23-huawei>
In-Reply-To: <9ad72488ca2b45c4568fd74bd6c857612a37a5e0.1787255388.git.alison.schofield@intel.com>
References: <cover.1787255388.git.alison.schofield@intel.com>
	<9ad72488ca2b45c4568fd74bd6c857612a37a5e0.1787255388.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 16:31:22 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> User region creation currently requires an interleaving root to have
> the same granularity as the region.
> 
> That rejects valid mixed-granularity layouts where the region
> granularity is finer than the root granularity. A region granularity
> coarser than the root remains invalid because it produces incorrect
> DPA translations.
> 
> Allow a region granularity finer than an interleaving root and
> continue to reject a coarser granularity. Validate the complete
> ways/granularity relationship when the region endpoints are attached.
> 
> For example, CXL 4.0 Section 9.13.1.1 Table 9-7 describes a 6-way
> region at IGB across three host bridges as a 3-way root interleave at
> 2 * IGB with a 2-way interleave at IGB below it.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/cxl/core/region.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 637d1b60a570..4bbfb7cd7e01 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -571,15 +571,8 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
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
> +	if (cxld->interleave_ways > 1 && val > cxld->interleave_granularity)
>  		return -EINVAL;
>  
>  	lockdep_assert_held_write(&cxl_rwsem.region);

