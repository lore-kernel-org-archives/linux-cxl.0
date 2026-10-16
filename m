Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA123494267
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176989; cv=none; b=U7ncQAXlwx1XGcOzceE4N8YiY6UEbkeESSD0sGAED5rSOQPzpvoUm6QO6EQ5Nlgc07VtcNLhGVA14WCRC6SjnhOblzWYdostikVmkLE4pZWX9KTVHvWCOZNBs80nBUUa5p+qOo+TYEwlBVuao12Ik+0C4wHR09T1rPkLe59xU6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176989; c=relaxed/simple;
	bh=QVXMDiYWY/JC3Ct6yCnIOGBu4zkc1SjrIpRMvCOW/IA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ox0pOsarX7mr2jBodb0GXgTJ0ov8W4MUYJ/HKANpZSXfsVZTRyylKK9TERwmBY/S+txOd/zuqSiUUzY7bzUJ3ibCpp4RbxdvmWN+pILiYcJnb/sfXfoXOehPha2Fg2NfLyxnWmFsRn0Qc6Oulm5J9cvBsx7U+Gki4SloyT9HtoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeuRYVGb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeuRYVGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6161F000C4;
	Fri, 16 Oct 2026 18:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792176987;
	bh=woiNd4+uWUZHA0wBE8mFM4hlZOXaPp4nzRVoe+HadqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GeuRYVGb9og2Ta0TYE2kN1azW+iDLlCO6bSdiP6NMRr6SSow52p+jSEood2lYsO9M
	 4mJ4MdQ6Qkrj4BlzDd+rrNt1/HbLDnoE8e5HCu3ZQeGDi2P1OnZjlHbyoyh+Km8QyG
	 Cz04MCwbrnZSSzgJFp/7hXEdsAcBN/mSaMOHLBrQ4GNOMN3TjhEJ3dmEQ9Eqnqr6A6
	 9xqloXR/1pWoWfsvvt8Sk8CV3FbOU7bbob30exiWTTrY54SxPPlX7ZmJRGeQUv9pbS
	 T7bsqb5QlIw+J0XQavzWhSCa59aVAr8lXSDFZkmqG6HCXGfrxbOPH47d75+3Gsfk0A
	 mY3c/3c0mKJLg==
Date: Fri, 16 Oct 2026 19:56:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 7/7] cxl/region: Factor out
 cxl_switch_port_add_target()
Message-ID: <20261016195623.59453de1@jic23-hlaptop>
In-Reply-To: <97c96f804a383b13ff83f81e9e9255f4ea0887ec.1791860305.git.alison.schofield@intel.com>
References: <cover.1791860305.git.alison.schofield@intel.com>
	<97c96f804a383b13ff83f81e9e9255f4ea0887ec.1791860305.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 21:26:03 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> cxl_switch_port_setup_targets() adds an endpoint's downstream port to a
> port's decoder target list. For an auto region it checks that the decoder
> already targets that downstream port at the next position. For a user
> created region it programs the downstream port at that position. That step
> is open coded behind an add_target label that the target search jumps to.
> 
> Move that step to a new helper, cxl_switch_port_add_target(). The helper
> takes the switch decoder whose target list it updates, rather than the
> port, which makes its scope explicit. With the decoder setup and the
> target add now in helpers, the path for the first endpoint to reach a port
> becomes an else branch of the target search, so the add_target label is
> no longer needed.

That else doesn't really have much to do with the helper I think?  It is
an unrelated change wrt to the helper added in this patch.

Maybe I am missing something but to me looks like you should split
that bit out.

Otherwise, LGTM
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  drivers/cxl/core/region.c | 80 ++++++++++++++++++++++++---------------
>  1 file changed, 49 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 229372123271..50f4830c225d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1608,15 +1608,50 @@ static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr
>  	return 0;
>  }
>  
> +static int cxl_switch_port_add_target(struct cxl_switch_decoder *cxlsd,
> +				      struct cxl_region *cxlr,
> +				      struct cxl_region_ref *cxl_rr,
> +				      struct cxl_endpoint_decoder *cxled,
> +				      struct cxl_ep *ep)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *port = cxl_rr->port;
> +	int pos = cxled->pos;
> +
> +	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s: targets full trying to add %s:%s at %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
> +		return -ENXIO;
> +	}
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> +		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
> +			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
> +				dev_name(port->uport_dev), dev_name(&port->dev),
> +				dev_name(&cxlsd->cxld.dev),
> +				dev_name(ep->dport->dport_dev),
> +				cxl_rr->nr_targets_set);
> +			return -ENXIO;
> +		}
> +	} else {
> +		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
> +		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
> +	}
> +	cxl_rr->nr_targets_set++;
> +
> +	return 0;
> +}
> +
>  static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
>  					 struct cxl_endpoint_decoder *cxled)
>  {
> -	int iw, ig, rc, pos = cxled->pos;
>  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
>  	struct cxl_decoder *cxld = cxl_rr->decoder;
>  	struct cxl_switch_decoder *cxlsd;
> +	int rc, pos = cxled->pos;
>  
>  	/*
>  	 * While root level decoders support x3, x6, x12, switch level
> @@ -1641,38 +1676,21 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
>  					return rc;
>  				goto out_target_set;
>  			}
> -		goto add_target;
> -	}
> -
> -	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
> -	if (rc)
> -		return rc;
> -add_target:
> -	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
> -		dev_dbg(&cxlr->dev,
> -			"%s:%s: targets full trying to add %s:%s at %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
> -		return -ENXIO;
> -	}
> -	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> -		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
> -			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
> -				dev_name(port->uport_dev), dev_name(&port->dev),
> -				dev_name(&cxlsd->cxld.dev),
> -				dev_name(ep->dport->dport_dev),
> -				cxl_rr->nr_targets_set);
> -			return -ENXIO;
> -		}
>  	} else {
> -		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
> -		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
> +		int iw, ig;
> +
> +		rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> +		if (rc)
> +			return rc;
> +
> +		rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
> +		if (rc)
> +			return rc;
>  	}

Smells like two patches to me.   First one does this else bit rather
than the goto, second adds the cxl_switch_port_add_target()
helper.


> -	cxl_rr->nr_targets_set++;
> +
> +	rc = cxl_switch_port_add_target(cxlsd, cxlr, cxl_rr, cxled, ep);
> +	if (rc)
> +		return rc;
>  out_target_set:
>  	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
>  		dev_name(port->uport_dev), dev_name(&port->dev),

