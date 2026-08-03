Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC97420477;
	Mon,  3 Aug 2026 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777927; cv=none; b=TyUuJdCAKpJTYCPctYXRQduxSah9ycEvSX2jfXTMJg7jkb+Uos1BE4TejNhiwr/iz8Ei11qphi0LiyIwmY1L8lKjIv8kDNVeoJbQGWR6l3YsPfYZxeF/STvNWFpCHBoY/AjQ07OpftfP60RiuSzDtUD2HdEPU2r14lGQgE62IHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777927; c=relaxed/simple;
	bh=BwQTjJtZ2m0X7m+fdf1g6Ah+qcqEHi7eMaa/RXFZpZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5mG+GLffmHk58aIBpIkSyjkzF7QryduwE8lNG7Fuye1I8uNaN5xFEJ4d4rhQz1AGMB7ZI2qjSkMlQFZJxsto9JarMoejIMVybXYqD67DqG4j9KiOVpBrj67WFZtlXxv2XbMIMDSkwYOPR4DWtRktdRnlWIftY8IG25Q+7gHMk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjQDWM+L; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjQDWM+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785777926; x=1817313926;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BwQTjJtZ2m0X7m+fdf1g6Ah+qcqEHi7eMaa/RXFZpZk=;
  b=RjQDWM+L9qUqVI8rIz1Wrf6HK6M1zhxG+3ff/gGRDY6tXjTBqxLnP+bv
   Yfeg87ToAylRQCfjIGG5y0rb5GoeRr3wdbsJBLWp37enJHA1zUQacAKVQ
   ZAlh4br41dgVnp5vgvgDTtOFqso/Lz8jloo0TwiShmkYdWkpV6GiCm33U
   b+KqW2gcO7540/kBeYYEPEVknYE+SPjjguED9dNJfuNH8yemcabclQ4XT
   R+HN94uULTSOc7Ys71S/bXSgPNz7OipZ4iICvKRVASOyERNYAfBj87rGa
   uDx9PqwT5+zoRdssQSrfkbl8xZnbf+yOYLivqWeY0nauCKWgNbmucFUVV
   g==;
X-CSE-ConnectionGUID: xjoNNAOnTs+1lA8rxqq0JA==
X-CSE-MsgGUID: w9UamWGITz6N0UkyK+R50g==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103862045"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="103862045"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 10:25:25 -0700
X-CSE-ConnectionGUID: S4sC2SGwTXqOquoJkWzuZg==
X-CSE-MsgGUID: 2h239fGKQOaauCQCOWKfQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="260027488"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.108.187]) ([10.125.108.187])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 10:25:24 -0700
Message-ID: <6e97cf9a-d992-4157-8040-7769ad6f3f80@intel.com>
Date: Mon, 3 Aug 2026 10:25:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Use %pe to print error pointers
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Robert Richter <rrichter@amd.com>, Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260802112029.28767-1-shaikhkamal2012@gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260802112029.28767-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/2/26 4:20 AM, Shaikh Kamaluddin wrote:
> Use the %pe printk format specifier to report error pointers directly
> instead of printing PTR_ERR() as a long value.  A failed dport addition
> then reports -EBUSY rather than -16, which is easier to follow when
> tracing port and region setup with dynamic debug enabled.
> 
> Convert the five affected sites in drivers/cxl/core/port.c and
> drivers/cxl/core/region.c.  PTR_ERR() uses in return statements are
> unaffected and left unchanged.
> 
> drivers/cxl was scanned in full; these are the only conversion
> candidates.
> 
> Found by: make coccicheck MODE=report M=drivers/cxl/
> No functional change intended.
> 
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

Applied to cxl/next
4ee75140669c

> ---
> Compile tested only with cxl config on x86.
> 
> v2:
>  - Reword commit message: lead with the code improvement, note coccinelle
>    only as the tool used to locate the sites (Alison)
>  - Capitalise subject per CXL convention (Alison)
>  - Note that drivers/cxl was scanned in full and these are the only
>    candidates (Alison)
>  - Clarify that the patch is compile tested only
>  - No code changes
> Link to v1: https://lore.kernel.org/linux-cxl/20260801101217.12778-1-shaikhkamal2012@gmail.com/
> 
>  drivers/cxl/core/port.c   | 13 ++++++-------
>  drivers/cxl/core/region.c |  8 ++++----
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1215ee4f4035..c9875e6af9f6 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -932,11 +932,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>  
>  	parent_port = parent_dport ? parent_dport->port : NULL;
>  	if (IS_ERR(port)) {
> -		dev_dbg(uport_dev, "Failed to add%s%s%s: %ld\n",
> +		dev_dbg(uport_dev, "Failed to add%s%s%s: %pe\n",
>  			parent_port ? " port to " : "",
>  			parent_port ? dev_name(&parent_port->dev) : "",
> -			parent_port ? "" : " root port",
> -			PTR_ERR(port));
> +			parent_port ? "" : " root port", port);
>  	} else {
>  		dev_dbg(uport_dev, "%s added%s%s%s\n",
>  			dev_name(&port->dev),
> @@ -1271,8 +1270,8 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
>  				     component_reg_phys, CXL_RESOURCE_NONE);
>  	if (IS_ERR(dport)) {
> -		dev_dbg(dport_dev, "failed to add dport to %s: %ld\n",
> -			dev_name(&port->dev), PTR_ERR(dport));
> +		dev_dbg(dport_dev, "failed to add dport to %s: %pe\n",
> +			dev_name(&port->dev), dport);
>  	} else {
>  		dev_dbg(dport_dev, "dport added to %s\n",
>  			dev_name(&port->dev));
> @@ -1305,8 +1304,8 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
>  				     CXL_RESOURCE_NONE, rcrb);
>  	if (IS_ERR(dport)) {
> -		dev_dbg(dport_dev, "failed to add RCH dport to %s: %ld\n",
> -			dev_name(&port->dev), PTR_ERR(dport));
> +		dev_dbg(dport_dev, "failed to add RCH dport to %s: %pe\n",
> +			dev_name(&port->dev), dport);
>  	} else {
>  		dev_dbg(dport_dev, "RCH dport added to %s\n",
>  			dev_name(&port->dev));
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..894df68a6074 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -682,8 +682,8 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  				    dev_name(&cxlr->dev));
>  	if (IS_ERR(res)) {
>  		dev_dbg(&cxlr->dev,
> -			"HPA allocation error (%ld) for size:%pap in %s %pr\n",
> -			PTR_ERR(res), &size, cxlrd->res->name, cxlrd->res);
> +			"HPA allocation error (%pe) for size:%pap in %s %pr\n",
> +			res, &size, cxlrd->res->name, cxlrd->res);
>  		return PTR_ERR(res);
>  	}
>  
> @@ -3773,9 +3773,9 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	if (IS_ERR(cxlr)) {
>  		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s failed assign region: %ld\n",
> +			"%s:%s: %s failed assign region: %pe\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			__func__, PTR_ERR(cxlr));
> +			__func__, cxlr);
>  		return cxlr;
>  	}
>  
> 
> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff

