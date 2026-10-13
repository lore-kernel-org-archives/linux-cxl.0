Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC937A83D
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874412; cv=pass; b=JRuscD7YUNgDqdKiaVDtQljS4vdwwncDvE16+pldP9zhV3NBUKMf5bg3QwEx65Dt74wW/y6t3462Iusw+1t/nDO6fAFMwNg1BgvUJbxoMXV2REuYuwuWFpVYI2tG+QadXFj1bas1YXrUTtXPcdUE5p0ioh/gakWqTcaJ76mCtP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874412; c=relaxed/simple;
	bh=ps3qCP8JjBHGCBrtqOxm9X/CGEEexy3Wm2LTcDAqrRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITZZeSUa12JiWQCy8cqD9unxRrQQP0+PrORKCt7119e2RmnGlGKmOQlCheBED5cBDyF9uPJnmcQigBR+UQ9rUn3K4leHtMo2DmpTzBEVw7hFI8aY8/sqlfc/Yibr018zPYqK7VPAPd4wKMGDYkoDoTbF5yKYV+iywsiuwFynza0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=D7oRmC+4; arc=pass smtp.client-ip=165.173.180.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="D7oRmC+4"
ARC-Seal: i=1; a=rsa-sha256; t=1791874405; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OBDf/zzMbqTPWGbXltEzwNR1GbWImCGAhf9CvU30XjvVbIMt1YCOoSegj072cHHrR3nItCK1DXCZ/We/yuo9bfalAclSEQ6VGvmD20R6fSyuFBrxleTPvo2L5lt4dDe5NjqZJa+g3uOmXtbGgw84TLVcZO/Y0Qo/y49UM8WT6+8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791874405; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yoiAXUeAppxoY/jVcNindM71wxPZfK1Jl3FTRBHlymQ=; 
	b=ADL43n1fEA2LuQ4e6Eq7FyXV/K4rer4nNVdIwbNf3MdautQKv1vU6OB3yjcLCmq0TJRN0vQaj+zjvH012uEEEsjXubf3rGUNZpevjuVVvTyzFXkqRHN2efto10jKtAuQ0nuejlcwEBnp6YChaLekxXtXf7pRQF1DZfOgZ9F2A24=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791874405;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=yoiAXUeAppxoY/jVcNindM71wxPZfK1Jl3FTRBHlymQ=;
	b=D7oRmC+4W/p2whITlrXus+7glqzOOHyV3KZkw+hz3a4M2s96DfhNfqag7M6FjhjL
	T+11eCh88FgjY99x0dw0fYPJW10GA1TZOn5qyYHCeIpStjgnWwtEN7cFEEWbEframKA
	HeNJXLt0uz44yWVWnzHPypjz3wl1lPDd2OfgSRV0=
Received: by smtp.zohomail.com with SMTPS id 1791874404223373.7184402005894;
	Mon, 12 Oct 2026 23:53:24 -0700 (PDT)
Message-ID: <b2518861-fd88-478d-a729-c49ce3fd3b19@zohomail.com>
Date: Tue, 13 Oct 2026 14:53:21 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] cxl/region: Factor out
 cxl_port_parent_interleave()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791860305.git.alison.schofield@intel.com>
 <85eeb8ae3272c57cb5f1a5ea8b4e0b635b71b188.1791860305.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <85eeb8ae3272c57cb5f1a5ea8b4e0b635b71b188.1791860305.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112272d88c4c043a6eba0b4508aad000024d46067037892294759697618d425e2cec651fd7345f67333:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/13 12:26, Alison Schofield 写道:
> cxl_switch_port_setup_targets() derives a decoder's interleave from the
> interleave of the decoder above it. That parent interleave comes from
> either the root decoder or a switch decoder, and each case is open coded
> along with the parent validity checks.
>
> Move the parent interleave lookup and validation to a new helper,
> cxl_port_parent_interleave().
>
> No functional change.
>
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
>   drivers/cxl/core/region.c | 88 +++++++++++++++++++++++----------------
>   1 file changed, 52 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ea281ce4ec49..c14ac041c4ac 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1459,45 +1459,13 @@ static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr
>   	return distance;
>   }
>   
> -static int cxl_switch_port_setup_targets(struct cxl_port *port,
> -					 struct cxl_region *cxlr,
> -					 struct cxl_endpoint_decoder *cxled)
> +static int cxl_port_parent_interleave(struct cxl_port *port, struct cxl_region *cxlr,
> +				      int *out_iw, int *out_ig)
>   {
> -	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> -	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
>   	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> -	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>   	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_decoder *cxld = cxl_rr->decoder;
> -	struct cxl_switch_decoder *cxlsd;
> -
> -	/*
> -	 * While root level decoders support x3, x6, x12, switch level
> -	 * decoders only support powers of 2 up to x16.
> -	 */
> -	if (!is_power_of_2(cxl_rr->nr_targets)) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			cxl_rr->nr_targets);
> -		return -EINVAL;
> -	}
> -
> -	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> -	if (cxl_rr->nr_targets_set) {
> -		int distance = cxl_port_peer_distance(port, cxlr);
> -
> -		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> -			if (ep->dport == cxlsd->target[i]) {
> -				rc = check_last_peer(cxled, ep, cxl_rr,
> -						     distance);
> -				if (rc)
> -					return rc;
> -				goto out_target_set;
> -			}
> -		goto add_target;
> -	}
> +	int parent_iw, parent_ig;
>   
>   	if (is_cxl_root(parent_port)) {
>   		/*
> @@ -1539,6 +1507,54 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
>   		return -EINVAL;
>   	}
>   
> +	*out_iw = parent_iw;
> +	*out_ig = parent_ig;
> +
> +	return 0;
> +}
> +
> +static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
> +					 struct cxl_endpoint_decoder *cxled)
> +{
> +	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> +	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> +	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_decoder *cxld = cxl_rr->decoder;
> +	struct cxl_switch_decoder *cxlsd;
> +
> +	/*
> +	 * While root level decoders support x3, x6, x12, switch level
> +	 * decoders only support powers of 2 up to x16.
> +	 */
> +	if (!is_power_of_2(cxl_rr->nr_targets)) {
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			cxl_rr->nr_targets);
> +		return -EINVAL;
> +	}
> +
> +	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +	if (cxl_rr->nr_targets_set) {
> +		int distance = cxl_port_peer_distance(port, cxlr);
> +
> +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> +			if (ep->dport == cxlsd->target[i]) {
> +				rc = check_last_peer(cxled, ep, cxl_rr,
> +						     distance);
> +				if (rc)
> +					return rc;
> +				goto out_target_set;
> +			}
> +		goto add_target;
> +	}
> +
> +	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
> +	if (rc)
> +		return rc;
> +
>   	iw = cxl_rr->nr_targets;
>   	if (!ways_valid(iw)) {
>   		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
