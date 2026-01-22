Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F764325729
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100857; cv=none; b=Z/WCBFGeEHo4dsGMwGyP0xs7u8XZu1+2ruZDVV2De88M7PPbRbe5JuIPMTveVESWsTQAJ7zP2hz4gyQkSFeS5x0U/xc2RFrQ92OUQn7TFwqpLpokVfctr2540VRlZ62Fcf0suhQ+Z3uC3HM6RC7fT9EMijwYAHCy/XHhiFkBtsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100857; c=relaxed/simple;
	bh=mk8kp0zf27/DlIWuu8/XjqVUVP3ieqcQE2eljpVFITA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYhBGumhX8Esbh8hpGOURFx3JIRrYALXVVEsLj1MHytNblrHys7+iJ10ZBs4og+ugXh+u9MPYJkL1epuarxd96TRBEDh6j9fyz5RTCx6tePJR0UMsnlm3r/rgH2y91VRXyM58BJ5s7A1CQO+6e3mWkYvnb3gOWHdogAvyBTYEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMZHU7lp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMZHU7lp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769100848; x=1800636848;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mk8kp0zf27/DlIWuu8/XjqVUVP3ieqcQE2eljpVFITA=;
  b=QMZHU7lpzZ5KFEQOS40e6yOBzOYcEmFZ+/S8RafReXVDm0bdjPgt6nYf
   6Y9vtmZWlfXbIpVOZ6x6ILVJK4T/5Twwes455sOELMdxPSDaiN1ODCWWk
   snZQK5Sq3r8Yl5ASschHexDnwFvWXPaK6QvfV7pFK6MzKAMFZpW3Bs2Ss
   SBcbbI+07P5HU9qinfVQL/CFgulQ930x+AeHfJrgliWoDhfiP6q409n9w
   Xkjk82m365El2SFD1TKMPavV45dzvxGnp6V1LDw9v8ChEXixeUZ428atY
   WohZ4n4aE3RPVZpIxocZSbLCC2VOIiwZtaXliFwu0oAePVCYUwoIPmEw0
   g==;
X-CSE-ConnectionGUID: cdoQZPTGQcStUq7tOGBdKQ==
X-CSE-MsgGUID: C6GoJ94eQACdZ/000E0P7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70322242"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70322242"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 08:54:03 -0800
X-CSE-ConnectionGUID: zexLLND9RTCS9MIQw07o/Q==
X-CSE-MsgGUID: mBm05ZInR46r+gnwTH30ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="229743138"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.157]) ([10.125.108.157])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 08:54:03 -0800
Message-ID: <6190d2f9-d0fc-4051-96eb-87099587b5f4@intel.com>
Date: Thu, 22 Jan 2026 09:54:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] cxl/port: Reduce number of @dport variables in
 cxl_port_add_dport()
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dave@stgolabs.net,
 alison.schofield@intel.com, ira.weiny@intel.com, terry.bowman@amd.com
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
 <20260122033330.1622168-3-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260122033330.1622168-3-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/21/26 8:33 PM, Dan Williams wrote:
> In preparation for refactoring cxl_port_add_dport() to add RAS register
> setup, cleanup the number of dport variables with a dport_exists() helper.
> 
> Kill the @dport needed to check for duplicates, rename @new_dport to
> @dport.
> 
> Reported-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Closes: http://lore.kernel.org/20260116150119.00003bbd@huawei.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/port.c | 43 +++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index ff899c690d85..1637e97f6805 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1587,30 +1587,39 @@ static int update_decoder_targets(struct device *dev, void *data)
>  	return 0;
>  }
>  
> +static bool dport_exists(struct cxl_port *port, struct device *dport_dev)
> +{
> +	struct cxl_dport *dport = cxl_find_dport_by_dev(port, dport_dev);
> +
> +	if (dport) {
> +		dev_dbg(&port->dev, "dport%d:%s already exists\n",
> +			dport->port_id, dev_name(dport_dev));
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  DEFINE_FREE(del_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) del_dport(_T))
>  static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  					    struct device *dport_dev)
>  {
> -	struct cxl_dport *dport;
>  	int rc;
>  
>  	device_lock_assert(&port->dev);
> -	if (!port->dev.driver)
> -		return ERR_PTR(-ENXIO);
>  
> -	dport = cxl_find_dport_by_dev(port, dport_dev);
> -	if (dport) {
> -		dev_dbg(&port->dev, "dport%d:%s already exists\n",
> -			dport->port_id, dev_name(dport_dev));
> +	if (dport_exists(port, dport_dev))
>  		return ERR_PTR(-EBUSY);
> -	}
>  
> -	struct cxl_dport *new_dport __free(del_cxl_dport) =
> +	if (!port->dev.driver)
> +		return ERR_PTR(-ENXIO);
> +
> +	struct cxl_dport *dport __free(del_cxl_dport) =
>  		devm_cxl_add_dport_by_dev(port, dport_dev);
> -	if (IS_ERR(new_dport))
> -		return new_dport;
> +	if (IS_ERR(dport))
> +		return dport;
>  
> -	cxl_switch_parse_cdat(new_dport);
> +	cxl_switch_parse_cdat(dport);
>  
>  	if (port->nr_dports == 1) {
>  		/*
> @@ -1626,17 +1635,17 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  		if (rc)
>  			return ERR_PTR(rc);
>  		dev_dbg(&port->dev, "first dport%d:%s added with decoders\n",
> -			new_dport->port_id, dev_name(dport_dev));
> -		return no_free_ptr(new_dport);
> +			dport->port_id, dev_name(dport_dev));
> +		return no_free_ptr(dport);
>  	}
>  
>  	/* New dport added, update the decoder targets */
> -	device_for_each_child(&port->dev, new_dport, update_decoder_targets);
> +	device_for_each_child(&port->dev, dport, update_decoder_targets);
>  
> -	dev_dbg(&port->dev, "dport%d:%s added\n", new_dport->port_id,
> +	dev_dbg(&port->dev, "dport%d:%s added\n", dport->port_id,
>  		dev_name(dport_dev));
>  
> -	return no_free_ptr(new_dport);
> +	return no_free_ptr(dport);
>  }
>  
>  static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,

