Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493E37A83D
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 06:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874552; cv=pass; b=LD0HMCcQK5ts+73I1hKAiqex4xTLBfJtwxXtkLOYAWg4xveenyZfa8JMDIMDDj9w9HG2/XZv2S/mW7CyFLxSVdc2epaVXG2vdSxTTBUABUF8eco45L5OCCnwpIGdjwd5ufYcvFeEgsRC1DRVqN5yy/8x4ZzO0pVuZOqdVHwNlf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874552; c=relaxed/simple;
	bh=b9Zzbm0voiC7MXkEl6faft3QouwNl8ydxTmAAD89NSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eE/nlm9aLVlJKBc5DexH7L1N/37bC9bYdW8BswrLa7qkNGRtc+kDq5k4qdXPgsav/B9yQD/t6qrWsDq1O/gCdsP8NRDngW+CwdH7LG2hKjqFwFmm9BhcKZYan0tfzBZbh/e9yOB1bbSD7YJC4zYp7TZ7S+bqhX1M+qGaCcJyly0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=E/SwXDAg; arc=pass smtp.client-ip=165.173.180.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="E/SwXDAg"
ARC-Seal: i=1; a=rsa-sha256; t=1791874544; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fQW0UVUL4gZsOWrECROaYTUeMlKqgRJjRVGDdJp2sBUGBXFL7D87RfhZmqo45vZ34jWdOogdKRHGVpc0Z9z2PQoRparRoCGUCpQK5oUYHq+cti6IhTVkqjYnI0288UJPYbA4/skmtw7pulf/36R5CJEt5AcUiWBYfguxZjIn1PE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791874544; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WyMz92mmGLEVl72nhxfdv9vbKza/NdA4ZFEW/d5KvIM=; 
	b=XFxUyHpP73jIWCGZhJKhbBGhTQANEExsbCGvkqGh6Q3pDiHw89ehOUTrHHi9pYZT2vjUFrRpa11JX76XG3DYULmwaZblnSNXSrJqoo6LKyarEr+RcyXUdSjbBnYf/jXs4LoMyeMyT3NWpdj5hV12+1iN/YpMTuXvATgN3+Acnrg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791874544;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=WyMz92mmGLEVl72nhxfdv9vbKza/NdA4ZFEW/d5KvIM=;
	b=E/SwXDAglGDZZaVw2lOVl0hy/9N87o0+H2FJBPDSBg2f28Q3vD+a+KhRbvFkV65z
	5YropfBbyZIHnhpGN6qv0I6rmkiXcjgOPVIyqzCX5RXRIwUpcqTMnESv4hS+tO1oPvC
	qYGhcXgNkzGfJnqgxtIJGlkA0I0duNFPGBCW/3lM=
Received: by smtp.zohomail.com with SMTPS id 1791874543388404.81828891170574;
	Mon, 12 Oct 2026 23:55:43 -0700 (PDT)
Message-ID: <8322d18a-19ce-47a3-b926-ac0dcff59c70@zohomail.com>
Date: Tue, 13 Oct 2026 14:55:39 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] cxl/region: Factor out cxl_port_setup_decoder()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791860305.git.alison.schofield@intel.com>
 <b518a60cae9a472c6463195f0173800378990d2f.1791860305.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <b518a60cae9a472c6463195f0173800378990d2f.1791860305.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227fcd3245efff7a67b8de6db9a0000aac71da32e5d72928b5d3dee9463f5481658383a6f7fbf5c22:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/13 12:26, Alison Schofield 写道:
> Once cxl_switch_port_setup_targets() has calculated the interleave for a
> port's decoder, it either checks that interleave against the decoder
> settings found for an auto region, or checks the decoder's interleave
> capabilities and programs the decoder for a user created region. Both paths
> are open coded in cxl_switch_port_setup_targets().
>
> Move both paths to a new helper, cxl_port_setup_decoder().
>
> No functional change.
>
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>


See my comment in patch #7.

> ---
>   drivers/cxl/core/region.c | 88 ++++++++++++++++++++++-----------------
>   1 file changed, 50 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ee9e615a9a4c..229372123271 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1561,46 +1561,11 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
>   	return 0;
>   }
>   
> -static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
> -					 struct cxl_endpoint_decoder *cxled)
> +static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr,
> +				  struct cxl_decoder *cxld, int iw, int ig)
>   {
> -	int iw, ig, rc, pos = cxled->pos;
> -	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
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
> -
> -	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> -	if (rc)
> -		return rc;
> +	int rc;
>   
>   	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>   		if (cxld->interleave_ways != iw ||
> @@ -1639,6 +1604,53 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
>   	}
>   	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport_dev),
>   		dev_name(&port->dev), iw, ig);
> +
> +	return 0;
> +}
> +
> +static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
> +					 struct cxl_endpoint_decoder *cxled)
> +{
> +	int iw, ig, rc, pos = cxled->pos;
> +	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
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
> +	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
> +	if (rc)
> +		return rc;
>   add_target:
>   	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
>   		dev_dbg(&cxlr->dev,
