Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9125C6FF
	for <linux-cxl@vger.kernel.org>; Tue,  9 Sep 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434838; cv=none; b=RXLoe5nkyVA+LBLTJBjv/4fFSlxEaGWZtOxnkaR0mB+lmHh7lqJuzz06Hz+1t2YXsBbsrrcpDjFHQlCxDpchiOwRn6pJOA/LQk+AQALTJMcHEsizYCQFCsOpFf1PWbhZwm4pAyqhJOR5czIJrrfAy5q4u6kIVNcmVbu7MSqkpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434838; c=relaxed/simple;
	bh=xNkpv5ER0QMDDQtcUD0/cNOnBE5uReo3udyWJvATAPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dLQmEYdCNmnlgYSBWQDjvGOqZOpLC2TNHNtFu6zNBdRbQSplGTlcZDouNkNgqs98TkfE1eRDwkX4IoOzL0q5YSq3tQ+loE6R2GGSC8HuKbXLgP1QnCMHhjw3NtHNe6UsHYy46TrdMuz1BI6nQOwBB72kLAYCbwGeVbXQK54rsr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0dGLH7r; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H0dGLH7r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757434836; x=1788970836;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=xNkpv5ER0QMDDQtcUD0/cNOnBE5uReo3udyWJvATAPs=;
  b=H0dGLH7rrSZbYXKH1cjDUUrrJbt7Ap9nD/eqrzB85ZzSJVdIz7Dk0+SI
   S29EvuFjCnuiLN+Z6BGeLAZ6x8ysbX7rY1z59hDNuqvJdJDdLarZEqQaM
   M1rIKd1f5A/VZwTmBz6/jM3ShB082xv8nrvai0RJ2kiIOoPnQDkpiTUKP
   yM0aY62AesnpqrK+Ew9tXoRzqSvSibooWeGfULrxoUoLwL5hxAWWJGhkK
   YABgvkRDtH0hyoY0l2CqQAb7l9zmeykP2kCT5tzGexMZozaFUe5Hlp5WU
   7ZkeJr/U7SHNqM0C6JTMAjtuMpfIR+vZcYlEeK9b/Kmhk3ir+jZIqqAIm
   w==;
X-CSE-ConnectionGUID: pxEYlzuPSe+SI0chwB47Wg==
X-CSE-MsgGUID: 3x3UCyIVRpSrCCWb9b42iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="63558633"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="63558633"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 09:20:36 -0700
X-CSE-ConnectionGUID: pQi2yWwERbO8pWKfkF7B1A==
X-CSE-MsgGUID: wtUkr3CkT/ue0eQMJy9GOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="177416672"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.110.155]) ([10.125.110.155])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 09:20:35 -0700
Message-ID: <00f7077d-cd8c-4788-92ad-e98327e9f6ec@intel.com>
Date: Tue, 9 Sep 2025 09:20:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/18] cxl/port: Update switch_port_probe() for CXL
 cache devices
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, linux-cxl@vger.kernel.org
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-9-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250812212921.9548-9-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/25 2:29 PM, Ben Cheatham wrote:
> CXL switch port probe currently assumes there are only CXL.mem-capable
> devices below the switch with preconfigured HDM decoders. Now that
> CXL.cache devices can be added below a switch port, it's possible that
> they either have no HDM decoders (type 1) or the CXL.mem capabilities of
> the endpoint haven't been set up yet (type 2).
> 
> The HDM decoders being disabled (if present) is no longer a gauranteed
> failure condition when only cache devices are present below the port.
> Knowing what kind of devices are under the switch port isn't possible
> until the endpoints are probed, so delay HDM setup and validation until
> endpoint port probe.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/cxl/core/hdm.c | 31 +++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  1 +
>  drivers/cxl/port.c     | 23 +++++++++++++----------
>  3 files changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 865a71bce251..6e04f1f4c166 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -205,6 +205,37 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, "CXL");
>  
> +int cxl_validate_endpoint_hdm_setup(struct cxl_port *endpoint)
> +{
> +	struct cxl_port *sp = parent_port_of(endpoint);
> +	struct cxl_hdm *cxlhdm;
> +	int rc;
> +
> +	for (; sp && !is_cxl_root(sp); sp = parent_port_of(sp)) {
> +		cxlhdm = dev_get_drvdata(&sp->dev);
> +		if (cxlhdm && cxlhdm->decoder_count > 0)
> +			continue;
> +
> +		if (!sp->reg_map.component_map.hdm_decoder.valid || !cxlhdm) {
> +			dev_err(&sp->dev, "Missing HDM decoder capability\n");
> +			return -ENXIO;
> +		}
> +
> +		if (sp->total_dports == 1) {
> +			dev_dbg(&sp->dev, "Fallback to passthrough decoder\n");
> +			rc = devm_cxl_add_passthrough_decoder(sp);

This doesn't match the function name. We are no longer just validating. Although this whole patch may change if you take a look at my delayed dport series for v9. Just heads up.

DJ
 
> +			if (rc)
> +				return rc;
> +		}
> +	}
> +
> +	if (is_cxl_root(sp))
> +		return 0;
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_validate_endpoint_hdm_setup, "CXL");
> +
>  static void __cxl_dpa_debug(struct seq_file *file, struct resource *r, int depth)
>  {
>  	unsigned long long start = r->start, end = r->end;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c857c112772f..0dc4e5c96459 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -932,6 +932,7 @@ struct cxl_endpoint_dvsec_info {
>  struct cxl_hdm;
>  struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  				   struct cxl_endpoint_dvsec_info *info);
> +int cxl_validate_endpoint_hdm_setup(struct cxl_port *endpoint);
>  int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  				struct cxl_endpoint_dvsec_info *info);
>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index fbff4900c69d..56030066a652 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -75,18 +75,17 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	if (!IS_ERR(cxlhdm))
>  		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
>  
> -	if (PTR_ERR(cxlhdm) != -ENODEV) {
> -		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
> -		return PTR_ERR(cxlhdm);
> -	}
> -
> -	if (port->total_dports == 1) {
> -		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
> -		return devm_cxl_add_passthrough_decoder(port);
> +	/*
> +	 * This isn't an error if only CXL.cache devices are below the port or
> +	 * a passthrough is possible. Finish set up in
> +	 * cxl_validate_endpoint_hdm_setup() during CXL.mem endpoint probe.
> +	 */
> +	if (PTR_ERR(cxlhdm) == -ENODEV) {
> +		dev_dbg(&port->dev, "HDM decoder capability not found\n");
> +		return 0;
>  	}
>  
> -	dev_err(&port->dev, "HDM decoder capability not found\n");
> -	return -ENXIO;
> +	return PTR_ERR(cxlhdm);
>  }
>  
>  static int cxl_cache_endpoint_port_probe(struct cxl_port *port)
> @@ -116,6 +115,10 @@ static int cxl_mem_endpoint_port_probe(struct cxl_port *port)
>  		return PTR_ERR(cxlhdm);
>  	}
>  
> +	rc = cxl_validate_endpoint_hdm_setup(port);
> +	if (rc)
> +		return rc;
> +
>  	/* Cache the data early to ensure is_visible() works */
>  	read_cdat_data(port);
>  	cxl_endpoint_parse_cdat(port);

