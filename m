Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BA939CEC0
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114298; cv=none; b=bPo1zLsHvTbMgDH7O7yrgcCbufRox82fyeRf187mzyra8XwootFXOY2aD+tGIwFRTJA7BA9fej8GTAn+0JnN1QdCVeXQuygJBuUbNM9ZoihuwK//E7qtFIjW9onPj3A7s+24ycU+SfyIijlqht677lEl7kDpMc2AvvmrxZIWe1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114298; c=relaxed/simple;
	bh=yAwTpPvKi5OxgYc69ilxZBP7SjgTwb5Yp9HhIjNj7Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNy7FNxUE2w4GNGLS0MNM9fVRE1rJI12eNX3QpnGHKV5A/WAU+LlTH7jzgF815YSRfuc4thh764q6ge8PEeTiS0mlZjf2t3GxZIPY/PEZpHWZn5lYi/BdYPXYaJ6dTiC4ctVlZN+f3Y+xtx1PHAIbPOt1lnX4zMAN8mRahPUIyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnhysHB/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnhysHB/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769114294; x=1800650294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yAwTpPvKi5OxgYc69ilxZBP7SjgTwb5Yp9HhIjNj7Uc=;
  b=hnhysHB/vA/1BvIUdN700VwN+ttCOK/jg5vMF8esfilm29trsywDvwLs
   qakRCl29OYCphkkRXeOvQwvtqEJhfuUrS8Sy99dX+KtLbJoY4/Y2mM6Xp
   9AP7sCiwKnpZCkHVjByqiN2hAgLI4KERXal/7Kc9VlEXj2FsLpvuoK65G
   nl7Ryo+Lo7oTRH0TuuH/l/ZKLWGuWF3tcTiKaW2h41sqC0FVt1wHDqSBg
   zt564go0Zvk4jVf0ydr5DzuFAGFQPzD2mcwnx7zJQ6FFnyHsuJppwCUwP
   bTi9h+L2UKJZs6zvaMqYP8L5x0KvxwT2sZ3v/mTJJq/WHSxnBsV2Ypi0R
   A==;
X-CSE-ConnectionGUID: RL8Uq+cNRACppiPoZPB4Aw==
X-CSE-MsgGUID: Ct94gi/7SWi6MBoa1rsnlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70340333"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70340333"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 12:38:09 -0800
X-CSE-ConnectionGUID: 0vZJWSPQQwCAKtn6yFw5rg==
X-CSE-MsgGUID: RZvXLYqhTZW6DPwMazJMLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211685699"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.186]) ([10.125.108.186])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 12:38:08 -0800
Message-ID: <d96a59ad-b22f-4baa-9f9d-7adc503c967d@intel.com>
Date: Thu, 22 Jan 2026 13:38:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] cxl/port: Move decoder setup before dport creation
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dave@stgolabs.net,
 alison.schofield@intel.com, ira.weiny@intel.com, terry.bowman@amd.com
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
 <20260122033330.1622168-5-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260122033330.1622168-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/21/26 8:33 PM, Dan Williams wrote:
> There are port setup actions that run on first dport arrival, and there are
> setup actions that run per dport.
> 
> RAS register setup is a future additional setup action to run per-port
> (once the first dport arrives), and each dport also has RAS registers to
> map.
> 
> Before adding that, flip the order of "first dport" and "per-dport"
> actions. This makes allocation symmetric with teardown, "first dport"
> actions unwind after last dport removed. It also allows for using a devres
> group to collect the unrelated decoder, RAS, and dport setup actions into
> one group release action.
> 
> The new cxl_port_open_group() collects "first dport" and "per-dport" into
> one group that can be released on any failure. This group's lifetime only
> needs to span the short duration of cxl_port_add_dport() to cleanup all
> potential damage from failing to add a dport. Contrast that to the "dport"
> devres group that is called upon to destruct fully formed dport objects.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/port.c | 43 +++++++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f2723bf948e2..f69395ea0c14 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1650,10 +1650,24 @@ static bool dport_exists(struct cxl_port *port, struct device *dport_dev)
>  	return false;
>  }
>  
> -DEFINE_FREE(del_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) del_dport(_T))
> +static void *cxl_port_open_group(struct cxl_port *port)
> +{
> +	return devres_open_group(&port->dev, port, GFP_KERNEL);
> +}
> +
> +/* note this implicitly casts @port_group back to its @port */
> +DEFINE_FREE(cxl_port_release_group, struct cxl_port *,
> +	    if (_T) devres_release_group(&_T->dev, _T))
> +
> +static void cxl_port_remove_group(struct cxl_port *port, void *port_group)
> +{
> +	devres_remove_group(&port->dev, port_group);
> +}
> +
>  static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  					    struct device *dport_dev)
>  {
> +	struct cxl_dport *dport;
>  	int rc;
>  
>  	device_lock_assert(&port->dev);
> @@ -1664,14 +1678,13 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  	if (!port->dev.driver)
>  		return ERR_PTR(-ENXIO);
>  
> -	struct cxl_dport *dport __free(del_cxl_dport) =
> -		devm_cxl_add_dport_by_dev(port, dport_dev);
> -	if (IS_ERR(dport))
> -		return dport;
> -
> -	cxl_switch_parse_cdat(dport);
> +	/* Temp group for all "first dport" and "per dport" setup actions */
> +	void *port_group __free(cxl_port_release_group) =
> +		cxl_port_open_group(port);
> +	if (!port_group)
> +		return ERR_PTR(-ENOMEM);
>  
> -	if (port->nr_dports == 1) {
> +	if (port->nr_dports == 0) {
>  		/*
>  		 * Some host bridges are known to not have component regsisters
>  		 * available until a root port has trained CXL. Perform that
> @@ -1684,18 +1697,24 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  		rc = devm_cxl_switch_port_decoders_setup(port);
>  		if (rc)
>  			return ERR_PTR(rc);
> -		dev_dbg(&port->dev, "first dport%d:%s added with decoders\n",
> -			dport->port_id, dev_name(dport_dev));
> -		return no_free_ptr(dport);
>  	}
>  
> +	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
> +	if (IS_ERR(dport))
> +		return dport;
> +
> +	/* This group was only needed for early exit above */
> +	cxl_port_remove_group(port, no_free_ptr(port_group));
> +
> +	cxl_switch_parse_cdat(dport);
> +
>  	/* New dport added, update the decoder targets */
>  	device_for_each_child(&port->dev, dport, update_decoder_targets);
>  
>  	dev_dbg(&port->dev, "dport%d:%s added\n", dport->port_id,
>  		dev_name(dport_dev));
>  
> -	return no_free_ptr(dport);
> +	return dport;
>  }
>  
>  static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,

