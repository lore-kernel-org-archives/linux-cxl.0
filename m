Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46232C325C;
	Fri, 13 Jun 2025 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811638; cv=none; b=FzBPzfLobbxlCpJGLld14de8qrXr90OnyVOJn5XELiz/n+YWmgKJir+fFdyvAZQTc09RmDtT2UjhTXsL5ZGCJZjhcu8CdPB/TRtBA5j3bZ6/rixA4cnHaSycX3LRuP4NDtuFUlJxo75b13ynnhjQ5BIUSoY51D9BqrXvstCCmqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811638; c=relaxed/simple;
	bh=Vt+FW/ZS4rx7l52IohrB1KrNA9y9o5BPQNjlupHWHEU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ype/b1olujmN1xJhHkP2CXoejO9txmHwcp+nkGguhaygTdbHkdqG4aTzitNrjwng+vTysyB/yXJvknYIsZ03lPQCE9JGlLBID1BT6lzlsxJRhUuhaOEHsWZWdbYzmr4Q+AhABw73PFPpl0s14iUTGeJQxlp/l9MTSWHUwwBaC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJbZb5m7Vz6L4s9;
	Fri, 13 Jun 2025 18:42:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F6FF14010C;
	Fri, 13 Jun 2025 18:47:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Jun
 2025 12:47:11 +0200
Date: Fri, 13 Jun 2025 11:47:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] cxl/core: Consolidate auto region attachment
 logic
Message-ID: <20250613114708.00000807@huawei.com>
In-Reply-To: <20250603053645.3099299-1-lizhijian@fujitsu.com>
References: <20250603053645.3099299-1-lizhijian@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue,  3 Jun 2025 13:36:45 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

> Move all auto-attach handling from cxl_region_attach() into the
> cxl_region_attach_auto() function. This combines the partial handling
> previously in cxl_region_attach_auto() with the remaining logic that
> was directly implemented in cxl_region_attach().
> 
> Specifically, cxl_region_attach_auto() now handles:
> - Adding new targets when in auto-discovery mode
> - Waiting for all required targets
> - Sorting and validating targets when ready
> 
> This improves code organization by:
> - Keeping all auto-attach logic in a single function
> - Reducing complexity in the main attach function
> - Making the control flow easier to follow
> 
> No functional change intended.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Hi.

One minor comment inline.  More generally I don't feel that strongly
either way on this one.  Lets see if others think the improvements
are worth the churn.

Jonathan

> ---
>  drivers/cxl/core/region.c | 164 +++++++++++++++++++-------------------
>  1 file changed, 82 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c3f4dc244df7..e7618d59b548 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1702,44 +1702,6 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	return rc;
>  }
>  
> -static int cxl_region_attach_auto(struct cxl_region *cxlr,
> -				  struct cxl_endpoint_decoder *cxled, int pos)
> -{
> -	struct cxl_region_params *p = &cxlr->params;
> -
> -	if (cxled->state != CXL_DECODER_STATE_AUTO) {
> -		dev_err(&cxlr->dev,
> -			"%s: unable to add decoder to autodetected region\n",
> -			dev_name(&cxled->cxld.dev));
> -		return -EINVAL;
> -	}
> -
> -	if (pos >= 0) {
> -		dev_dbg(&cxlr->dev, "%s: expected auto position, not %d\n",
> -			dev_name(&cxled->cxld.dev), pos);
> -		return -EINVAL;
> -	}
> -
> -	if (p->nr_targets >= p->interleave_ways) {
> -		dev_err(&cxlr->dev, "%s: no more target slots available\n",
> -			dev_name(&cxled->cxld.dev));
> -		return -ENXIO;
> -	}
> -
> -	/*
> -	 * Temporarily record the endpoint decoder into the target array. Yes,
> -	 * this means that userspace can view devices in the wrong position
> -	 * before the region activates, and must be careful to understand when
> -	 * it might be racing region autodiscovery.
> -	 */
> -	pos = p->nr_targets;
> -	p->targets[pos] = cxled;
> -	cxled->pos = pos;
> -	p->nr_targets++;
> -
> -	return 0;
> -}
> -
>  static int cmp_interleave_pos(const void *a, const void *b)
>  {
>  	struct cxl_endpoint_decoder *cxled_a = *(typeof(cxled_a) *)a;
> @@ -1905,6 +1867,86 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> +static int cxl_region_attach_auto(struct cxl_region *cxlr,
> +				  struct cxl_endpoint_decoder *cxled, int pos)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_port *root_port;
> +	int i, rc;
> +
> +	if (cxled->state != CXL_DECODER_STATE_AUTO) {
> +		dev_err(&cxlr->dev,
> +			"%s: unable to add decoder to autodetected region\n",
> +			dev_name(&cxled->cxld.dev));
> +		return -EINVAL;
> +	}
> +
> +	if (pos >= 0) {
> +		dev_dbg(&cxlr->dev, "%s: expected auto position, not %d\n",
> +			dev_name(&cxled->cxld.dev), pos);
> +		return -EINVAL;
> +	}
> +
> +	if (p->nr_targets >= p->interleave_ways) {
> +		dev_err(&cxlr->dev, "%s: no more target slots available\n",
> +			dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Temporarily record the endpoint decoder into the target array. Yes,
> +	 * this means that userspace can view devices in the wrong position
> +	 * before the region activates, and must be careful to understand when
> +	 * it might be racing region autodiscovery.
> +	 */
> +	pos = p->nr_targets;
> +	p->targets[pos] = cxled;
> +	cxled->pos = pos;
> +	p->nr_targets++;
> +
> +	/* await more targets to arrive... */
> +	if (p->nr_targets < p->interleave_ways)
> +		return 0;
> +
> +	/*
> +	 * All targets are here, which implies all PCI enumeration that
> +	 * affects this region has been completed. Walk the topology to
> +	 * sort the devices into their relative region decode position.
> +	 */
> +	rc = cxl_region_sort_targets(cxlr);
> +	if (rc)
> +		return rc;
> +
> +	root_port = cxlrd_to_port(cxlrd);
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct cxl_port *ep_port;
> +		struct cxl_dport *dport;
> +
> +		cxled = p->targets[i];

I don't much like this reuse of the cxled here given it's a totally different
one to the code above (which was the parameter passed in).

Maybe just use
		ep_port = cxled_to_port(p->targets[i]);
...
		rc = cxl_region_attach_popsition(cxlr, cxlrd, p->targets[i],
						 dport, i);

or call it target_cxled or similar.

 
> +		ep_port = cxled_to_port(cxled);
> +		dport = cxl_find_dport_by_dev(root_port,
> +					      ep_port->host_bridge);
> +		rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
> +						dport, i);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	rc = cxl_region_setup_targets(cxlr);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * If target setup succeeds in the autodiscovery case
> +	 * then the region is already committed.
> +	 */
> +	p->state = CXL_CONFIG_COMMIT;
> +	cxl_region_shared_upstream_bandwidth_update(cxlr);
> +
> +	return 0;
> +}
> +
>  static int cxl_region_attach(struct cxl_region *cxlr,
>  			     struct cxl_endpoint_decoder *cxled, int pos)
>  {
> @@ -1986,50 +2028,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  
>  	cxl_region_perf_data_calculate(cxlr, cxled);
>  
> -	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> -		int i;
> -
> -		rc = cxl_region_attach_auto(cxlr, cxled, pos);
> -		if (rc)
> -			return rc;
> -
> -		/* await more targets to arrive... */
> -		if (p->nr_targets < p->interleave_ways)
> -			return 0;
> -
> -		/*
> -		 * All targets are here, which implies all PCI enumeration that
> -		 * affects this region has been completed. Walk the topology to
> -		 * sort the devices into their relative region decode position.
> -		 */
> -		rc = cxl_region_sort_targets(cxlr);
> -		if (rc)
> -			return rc;
> -
> -		for (i = 0; i < p->nr_targets; i++) {
> -			cxled = p->targets[i];
> -			ep_port = cxled_to_port(cxled);
> -			dport = cxl_find_dport_by_dev(root_port,
> -						      ep_port->host_bridge);
> -			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
> -							dport, i);
> -			if (rc)
> -				return rc;
> -		}
> -
> -		rc = cxl_region_setup_targets(cxlr);
> -		if (rc)
> -			return rc;
> -
> -		/*
> -		 * If target setup succeeds in the autodiscovery case
> -		 * then the region is already committed.
> -		 */
> -		p->state = CXL_CONFIG_COMMIT;
> -		cxl_region_shared_upstream_bandwidth_update(cxlr);
> -
> -		return 0;
> -	}
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
> +		return cxl_region_attach_auto(cxlr, cxled, pos);
>  
>  	rc = cxl_region_validate_position(cxlr, cxled, pos);
>  	if (rc)

