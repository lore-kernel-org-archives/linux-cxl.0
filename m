Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76D38F920
	for <linux-cxl@vger.kernel.org>; Tue,  4 Aug 2026 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785884838; cv=none; b=Xi+GSbt/FDrx6I8IvtO/He4vuEf5gkwyYrONyr4yWrKSTg8toCZtiAOavClFVFLjM2UgOOemGg4rOsEYnvZ/H4wnEuWDXdipLhi3nYlW0Se63YT+vMwvvG1ljt2mpFSr11ZZBcGhltKeDEzGdf+61E+X8WCYpWVHSg4r6x+zdwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785884838; c=relaxed/simple;
	bh=iO83Byh8NyCSSH+xSTA5Uc8pjLvBY75F9e5+LL9N6L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGs/Ls9HTtrQvm2GCPGx2dwi3DGPlqrBG4iJgE0iksEdNx3nTleUaYqDH8dda1kP7ay27SDstVoQkBQB9hS5zuL4/aSV5HyFfoFqlkq4TRutI8lSnjhfSES8U7tyEiMjY+SLHv7uOuuEC8YxbJ4RHQAPbxmFeDWH9ska+2SCaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAvDQNSa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAvDQNSa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785884837; x=1817420837;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iO83Byh8NyCSSH+xSTA5Uc8pjLvBY75F9e5+LL9N6L8=;
  b=dAvDQNSaKtbADoVEJ9PAzUOG4rprZLBV3HnLErGL9zhQ56Ozft3cSCx+
   ga/FwnV2TAsQgNThxwjAZ15KSieREEtCkGvJvUyrXge1xg0d7egS17DU2
   RcGMs4c/w0TOiRwgmlE5Yrz/+8oAxtFVH1kquZxHphLj6M4YFwAc9+SIp
   V63mKtcoTCNdnCr8YZav2mkYzY1RKVwL1cHwsYHZI0Fn/uPbtTus8Ab07
   idoKOF9hPS88q5j6W/EMMxEkngPLNZ/vvjnaEff1mJd13y2kSi+RYEiRk
   ItWKyPNYNGLCjIRbyfMjg7gY2l54aNdkTMJbQ+8c+CtWuYo3125Kk3dcM
   w==;
X-CSE-ConnectionGUID: 59rUtYagR8uWvDeksWq67g==
X-CSE-MsgGUID: ZHL3ah+bRzy4/XPpHgtY/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86480407"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="86480407"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:07:16 -0700
X-CSE-ConnectionGUID: QOq8SKtYTwCCN/54J6xE7g==
X-CSE-MsgGUID: Erbe2ac+Sbe5l+CLDhyeEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="265886429"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.7]) ([10.125.109.7])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:07:15 -0700
Message-ID: <3cb6199d-80d9-4bc4-942c-81941405922d@intel.com>
Date: Tue, 4 Aug 2026 16:07:14 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] cxl/pci: Split BI capability probe from setup
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
 benjamin.cheatham@amd.com, alucerop@amd.com, dongjoo.seo1@samsung.com,
 linux-cxl@vger.kernel.org
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-8-dave@stgolabs.net>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260728144136.709882-8-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/26 7:41 AM, Davidlohr Bueso wrote:
> Decouple the topology read-only capability verification phase from
> cxl_bi_setup() into cxl_bi_probe_capable(), recording the result in
> cxlds->bi_capable.
> 
> This allows further dealing with auto-committed BI hdm decoders;
> having such knowledge upon decoder enumeration time.
> 
> No functional change intended.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Just a format nit below,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/pci.c | 39 ++++++++++++++++++++++++++++-----------
>  drivers/cxl/cxl.h      |  1 +
>  drivers/cxl/port.c     |  1 +
>  include/cxl/cxl.h      |  2 ++
>  4 files changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a87c2ad9ac53..554058ccb1e9 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1290,35 +1290,38 @@ static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
>  	return rc;
>  }
>  
> -int cxl_bi_setup(struct cxl_port *endpoint)
> +/*
> + * Verify the device and every component in the path up to the root
> + * are BI capable.
> + */
> +void cxl_bi_probe_capable(struct cxl_port *endpoint)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_dport *dport = endpoint->parent_dport;
>  	struct cxl_dport *dport_iter;
>  	struct cxl_port *port_iter;
> -	int rc;
> +
> +	cxlds->bi_capable = false;
>  
>  	if (!dev_is_pci(cxlds->dev))
> -		return 0;
> +		return;
>  
>  	/* BI is VH-only */
>  	if (cxlds->rcd)
> -		return 0;
> +		return;
>  
>  	if (!cxl_is_bi_capable(to_pci_dev(cxlds->dev),
>  			       endpoint->regs.bi_decoder))
> -		return 0;
> +		return;
>  
> -	/* walkup the topology twice, first to check, then to enable */
> -	port_iter = dport->port;
> -	dport_iter = dport;
> +	dport_iter = endpoint->parent_dport;
> +	port_iter = dport_iter->port;
>  	while (!is_cxl_root(port_iter)) {
>  		/* check rp, dsp */
>  		if (!cxl_is_bi_capable(to_pci_dev(dport_iter->dport_dev),
>  				       dport_iter->regs.bi_decoder)) {
>  			dev_dbg(cxlds->dev, "BI not supported by topology\n");
> -			return 0;
> +			return;
>  		}
>  
>  		/* check usp */
> @@ -1328,13 +1331,27 @@ int cxl_bi_setup(struct cxl_port *endpoint)
>  		    !cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
>  				       port_iter->regs.bi_rt)) {
>  			dev_dbg(cxlds->dev, "BI not supported by USP\n");
> -			return 0;
> +			return;
>  		}
>  
>  		dport_iter = port_iter->parent_dport;
>  		port_iter = dport_iter->port;
>  	}
>  
> +	cxlds->bi_capable = true;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_probe_capable, "CXL");
> +
> +int cxl_bi_setup(struct cxl_port *endpoint)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_dport *dport = endpoint->parent_dport;

reverse xmas tree

DJ

> +	int rc;
> +
> +	if (!cxlds->bi_capable)
> +		return 0;
> +
>  	rc = cxl_bi_enable_path(cxlds, dport->port, dport);
>  	if (rc)
>  		return rc;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ca7051641c47..e10d642684e1 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -963,6 +963,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +void cxl_bi_probe_capable(struct cxl_port *endpoint);
>  int cxl_bi_setup(struct cxl_port *endpoint);
>  struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  					    struct device *dport_dev);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 22bd4254ba8d..ab3317fc1388 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -170,6 +170,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	cxl_endpoint_parse_cdat(port);
>  
>  	cxl_port_map_bi(port);
> +	cxl_bi_probe_capable(port);
>  
>  	get_device(&cxlmd->dev);
>  	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index e507cb0f777f..80d942eb9456 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -169,6 +169,7 @@ struct cxl_dpa_partition {
>   * @cxl_dvsec: Offset to the PCIe device DVSEC
>   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>   * @bi: device is BI (Back-Invalidate) enabled
> + * @bi_capable: device and topology path are BI capable
>   * @media_ready: Indicate whether the device media is usable
>   * @dpa_res: Overall DPA resource tree for the device
>   * @part: DPA partition array
> @@ -189,6 +190,7 @@ struct cxl_dev_state {
>  	int cxl_dvsec;
>  	bool rcd;
>  	bool bi;
> +	bool bi_capable;
>  	bool media_ready;
>  	struct resource dpa_res;
>  	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];

