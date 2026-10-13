Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5E49B5DE
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 06:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874460; cv=pass; b=mCyaPU0XHwx4fG2M6FHH7BMLqHgMukUNTHlUKA+bVktjkIRi4y8GA01FplT6C4KWb/cqYjYIsZMeX1eDVVsL8iSQSYtVyyMhJRLtVK7/Q3OKy7OqmHaTqR6PpzUhfQ1iFZdz1l4c79pXBuAUQoce9ar0j+18QahyPXayqmeq5hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874460; c=relaxed/simple;
	bh=MzgI+F7LY/XcORTD8wvmhizbLOIM3+qWWd8qQjkZsbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q34J131tymYs76QCx6xOBWsjTRpV4rtwvflp9LFmsxtBz4MbOSNLuZ/e9bTOmjw2IFHb1FQQjyiTtnk6Ad2jqld7+vY3fKWT9XRJxUJl2lJJDGqsImx2l8gNZLmZP/d+HWgZo+SiAb0t5gnTiuNVnnMEdabLmaUahDniJ7ZyaCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Mr1Zzjst; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Mr1Zzjst"
ARC-Seal: i=1; a=rsa-sha256; t=1791874450; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mOxo7WPXv5hsVKaCMUkUZzaoqwD3ejmnQkXFWIPu/Q1yo0ZJJu17SCvI3nRYVpL71Dra+P8DEAJ5J4QEEnYxr9R7zwJlHWTgWTKLTliK+ViOSFaNCKm8uar4aag8h+iWPBw0a+nTDXz3n5EP1XKkX3yDORYZJM9l634hoKQo+K8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791874450; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YwobUD+muoGhRCMU9XwnMv84sTREAIjBnHg+pt6Ixbs=; 
	b=j4lGhK3NvUN4j1KPBBlzRU0KuSqNgj5t8M5+4BxC6rhwLyzchMrS3bZnrRnBc3ldBI4GMuWnfN3M/wgstuZGVt6R/THiu6eP/PVusTgQNHwKbWl3Q2t6P4h911D4tsEbC65fsSzy1cjEZrTj3L5FDbMW9haRvBs1mPpxQnsxIuU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791874450;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=YwobUD+muoGhRCMU9XwnMv84sTREAIjBnHg+pt6Ixbs=;
	b=Mr1ZzjstO5l9+Qmott+7xXAQ3UiX4e3WASzZn5tLAIcj1lhR7z4crL2ZfhoERxEc
	5ku0PrzxopQceVvIHa1LWlM2Gb1m+sD79jjWtnkD54xLPER76ik4+oWpigKz77K2+ox
	il3YALBAW/cc4B2q8lbHFeTF47Dwq2pBV91S7K0A=
Received: by smtp.zohomail.com with SMTPS id 1791874450605812.5836697847351;
	Mon, 12 Oct 2026 23:54:10 -0700 (PDT)
Message-ID: <e6262cf0-0658-4e8d-9a21-c7553f746777@zohomail.com>
Date: Tue, 13 Oct 2026 14:54:07 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] cxl/region: Factor out cxl_port_calc_interleave()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791860305.git.alison.schofield@intel.com>
 <bb60900fd7e57b8494b93b3ca5cb7960b31ae8e0.1791860305.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <bb60900fd7e57b8494b93b3ca5cb7960b31ae8e0.1791860305.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227d728406937e7ef28f6c0bc0f0000e15d823b6daee1856f4295261e50226d81832bfc59951b0797:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/13 12:26, Alison Schofield 写道:
> cxl_switch_port_setup_targets() calculates the interleave ways and
> granularity of a port's decoder from the parent interleave and the number
> of targets below the port, then validates the result. That calculation and
> its checks are open coded between the target search and the decoder setup.
>
> Move the calculation and its checks to a new helper,
> cxl_port_calc_interleave(), so that the interleave for the port's decoder
> is calculated and validated in one place.
>
> No functional change.
>
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/core/region.c | 81 ++++++++++++++++++++++++---------------
>   1 file changed, 50 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c14ac041c4ac..ee9e615a9a4c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1513,11 +1513,58 @@ static int cxl_port_parent_interleave(struct cxl_port *port, struct cxl_region *
>   	return 0;
>   }
>   
> +static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cxlr,
> +				    struct cxl_region_ref *cxl_rr, int *out_iw,
> +				    int *out_ig)
> +{
> +	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> +	struct cxl_decoder *cxld = cxl_rr->decoder;
> +	int parent_iw, parent_ig, iw, ig, rc;
> +	struct cxl_switch_decoder *cxlsd;
> +
> +	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
> +	if (rc)
> +		return rc;
> +
> +	iw = cxl_rr->nr_targets;
> +	if (!ways_valid(iw)) {
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Interleave granularity is a multiple of @parent_port granularity.
> +	 * Multiplier is the parent port interleave ways.
> +	 */
> +	ig = parent_ig * parent_iw;
> +
> +	if (!granularity_valid(ig)) {
> +		dev_dbg(&cxlr->dev,
> +			"%s: invalid granularity calculation (%d * %d)\n",
> +			dev_name(&parent_port->dev), parent_ig, parent_iw);
> +		return -EINVAL;
> +	}
> +
> +	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +	if (iw > 8 || iw > cxlsd->nr_targets) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s:%s: ways: %d overflows targets: %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> +		return -ENXIO;
> +	}
> +
> +	*out_iw = iw;
> +	*out_ig = ig;
> +
> +	return 0;
> +}
> +
>   static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
>   					 struct cxl_endpoint_decoder *cxled)
>   {
> -	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> -	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> +	int iw, ig, rc, pos = cxled->pos;
>   	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>   	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> @@ -1551,38 +1598,10 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
>   		goto add_target;
>   	}
>   
> -	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
> +	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
>   	if (rc)
>   		return rc;
>   
> -	iw = cxl_rr->nr_targets;
> -	if (!ways_valid(iw)) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * Interleave granularity is a multiple of @parent_port granularity.
> -	 * Multiplier is the parent port interleave ways.
> -	 */
> -	ig = parent_ig * parent_iw;
> -
> -	if (!granularity_valid(ig)) {
> -		dev_dbg(&cxlr->dev,
> -			"%s: invalid granularity calculation (%d * %d)\n",
> -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> -		return -EINVAL;
> -	}
> -
> -	if (iw > 8 || iw > cxlsd->nr_targets) {
> -		dev_dbg(&cxlr->dev,
> -			"%s:%s:%s: ways: %d overflows targets: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> -		return -ENXIO;
> -	}
> -
>   	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>   		if (cxld->interleave_ways != iw ||
>   		    (iw > 1 && cxld->interleave_granularity != ig) ||
