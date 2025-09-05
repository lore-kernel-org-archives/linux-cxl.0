Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3C811713;
	Fri,  5 Sep 2025 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757032299; cv=none; b=Zgf5uFFCXy0HHV9eo/v2fnCDvvNQlhBvy3PPMoKRpygw5cYeiByYC52noQ4pnbPyrYQkvK6dt5eZmXSgDoY4MsnNqy2mi+jHfZGsKlGEgRAKw7cmcpxnkdkL0+gGauFfNnBb+BH4ig0IPYIP/nih7OB5GtAgzDE6ngZ3du78acs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757032299; c=relaxed/simple;
	bh=MtaM6MJRYiWj468qUfK5Gj2xB/cGY9DCNrHHM8R8AEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tagmf8zfLsjWZ7/iltx4bQmABLJeRNZsTJHWbhXNZ8+/FoD9wUxXEnmZBL80JjVJEWeykxqehxfsT4f+tgWBjAcZ5BAjRUg4FfnldTVDak0n658Nsq1YbUWE3G0cnKTofrBx3p875I7raFsD3LNpEEs2obA5nTG96Hujb+Pf5DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZmOfFPE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZmOfFPE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757032297; x=1788568297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MtaM6MJRYiWj468qUfK5Gj2xB/cGY9DCNrHHM8R8AEA=;
  b=eZmOfFPEUwvjIxLL/ax4g+HY8z7R0gNJL2Ox2fxbKh6nReUxW1ASm51y
   ORZY33hdbTqtfD6fV7dAOcpyIgYOiBv/eyTBxDLlxEmtxTPOIGqFP6y0V
   xx0cWERF+97l/CaWxGHRlcoMw7Wf3B/q4p+IfTdlLc2l327K4KTP1lJVd
   1LxpN3JPPMYIM7Hh2ziH8T5rhzuV2ohMT4lIewQjShtw4WvQFKWxhUFzM
   8RK07PT0NpMSZoKiGSIn0VvYTpL1QHnGj/gR+1mea6ip37eQ50Zk6Z9cR
   Ajfrouj/D4X8Ew675f0jBlft6GOUMhauxCil1PIJXxOrJpDipRzlMyEkP
   A==;
X-CSE-ConnectionGUID: DtadlWd6S7i+PEN2rgA1cQ==
X-CSE-MsgGUID: eLQTiPXFS3CDGHvxS/x+rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="58420982"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="58420982"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 17:31:36 -0700
X-CSE-ConnectionGUID: d2hYv9L+T+WEfDeJSVizDA==
X-CSE-MsgGUID: ZtJcEb56RCKyUqKSu/NNmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="202973192"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.24]) ([10.125.110.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 17:31:35 -0700
Message-ID: <11c7160f-14cc-4e1f-959a-187c7959acbe@intel.com>
Date: Thu, 4 Sep 2025 17:31:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4 v4] cxl/core: Change match_*_by_range() signatures
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
 ming.li@zohomail.com, linux-kernel@vger.kernel.org
References: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
 <20250724142144.776992-2-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250724142144.776992-2-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/25 7:20 AM, Fabio M. De Francesco wrote:
> Replace struct range parameter with struct cxl_endpoint_decoder of
> which range is a member in the match_*_by_range() functions and rename
> them according to their semantics.
> 
> This is in preparation for expanding these helpers to perform arch
> specific Root Decoders and Region matchings with
> cxl_endpoint_decoder(s).
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/region.c | 60 +++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6e5e1460068d..f607e7f97184 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1759,27 +1759,29 @@ static int cmp_interleave_pos(const void *a, const void *b)
>  	return cxled_a->pos - cxled_b->pos;
>  }
>  
> -static int match_switch_decoder_by_range(struct device *dev,
> -					 const void *data)
> +static int match_switch_and_ep_decoders(struct device *dev, const void *data)

match_cxlsd_to_cxled_by_range()?

>  {
> +	const struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_switch_decoder *cxlsd;
> -	const struct range *r1, *r2 = data;
> -
> +	const struct range *r1, *r2;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
>  
>  	cxlsd = to_cxl_switch_decoder(dev);
>  	r1 = &cxlsd->cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;
>  
>  	if (is_root_decoder(dev))
>  		return range_contains(r1, r2);
>  	return (r1->start == r2->start && r1->end == r2->end);
>  }
>  
> -static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> -			     int *pos, int *ways)
> +static int find_pos_and_ways(struct cxl_port *port,
> +			     struct cxl_endpoint_decoder *cxled, int *pos,
> +			     int *ways)
>  {
> +	struct range *range = &cxled->cxld.hpa_range;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *parent;
>  	struct device *dev;
> @@ -1789,8 +1791,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  	if (!parent)
>  		return rc;
>  
> -	dev = device_find_child(&parent->dev, range,
> -				match_switch_decoder_by_range);
> +	dev = device_find_child(&parent->dev, cxled,
> +				match_switch_and_ep_decoders);
>  	if (!dev) {
>  		dev_err(port->uport_dev,
>  			"failed to find decoder mapping %#llx-%#llx\n",
> @@ -1876,7 +1878,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  		if (is_cxl_root(iter))
>  			break;
>  
> -		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
> +		rc = find_pos_and_ways(iter, cxled, &parent_pos, &parent_ways);
>  		if (rc)
>  			return rc;
>  
> @@ -3215,24 +3217,28 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> -static int match_decoder_by_range(struct device *dev, const void *data)
> +static int match_root_and_ep_decoders(struct device *dev, const void *data)

match_cxlrd_to_cxled_by_range()

>  {
> -	const struct range *r1, *r2 = data;
> -	struct cxl_decoder *cxld;
> +	const struct cxl_endpoint_decoder *cxled = data;
> +	const struct range *r1, *r2;
> +	struct cxl_root_decoder *cxlrd;
>  
> -	if (!is_switch_decoder(dev))
> +	if (!is_root_decoder(dev))
>  		return 0;
>  
> -	cxld = to_cxl_decoder(dev);
> -	r1 = &cxld->hpa_range;
> +	cxlrd = to_cxl_root_decoder(dev);
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;
> +
>  	return range_contains(r1, r2);
>  }
>  
>  static struct cxl_decoder *
> -cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
> +cxl_port_find_root_decoder(struct cxl_port *port,
> +			   struct cxl_endpoint_decoder *cxled)
>  {
> -	struct device *cxld_dev = device_find_child(&port->dev, hpa,
> -						    match_decoder_by_range);
> +	struct device *cxld_dev = device_find_child(&port->dev, cxled,
> +						    match_root_and_ep_decoders);
>  
>  	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
>  }
> @@ -3244,9 +3250,8 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
>  	struct cxl_decoder *root, *cxld = &cxled->cxld;
> -	struct range *hpa = &cxld->hpa_range;
>  
> -	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
> +	root = cxl_port_find_root_decoder(&cxl_root->port, cxled);
>  	if (!root) {
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s no CXL window for range %#llx:%#llx\n",
> @@ -3258,11 +3263,12 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  	return to_cxl_root_decoder(&root->dev);
>  }
>  
> -static int match_region_by_range(struct device *dev, const void *data)
> +static int match_region_and_ep_decoder(struct device *dev, const void *data)

match_region_to_cxled_by_range()

DJ

>  {
> +	const struct cxl_endpoint_decoder *cxled = data;
> +	const struct range *r = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> -	const struct range *r = data;
>  
>  	if (!is_cxl_region(dev))
>  		return 0;
> @@ -3425,12 +3431,13 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  }
>  
>  static struct cxl_region *
> -cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
> +cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
> +			 struct cxl_endpoint_decoder *cxled)
>  {
>  	struct device *region_dev;
>  
> -	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> -				       match_region_by_range);
> +	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, cxled,
> +				       match_region_and_ep_decoder);
>  	if (!region_dev)
>  		return NULL;
>  
> @@ -3439,7 +3446,6 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
>  
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
>  	bool attach = false;
>  	int rc;
> @@ -3455,7 +3461,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  	 */
>  	mutex_lock(&cxlrd->range_lock);
>  	struct cxl_region *cxlr __free(put_cxl_region) =
> -		cxl_find_region_by_range(cxlrd, hpa);
> +		cxl_find_region_by_range(cxlrd, cxled);
>  	if (!cxlr)
>  		cxlr = construct_region(cxlrd, cxled);
>  	mutex_unlock(&cxlrd->range_lock);

