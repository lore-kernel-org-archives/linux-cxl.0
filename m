Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A1739BFF2
	for <linux-cxl@vger.kernel.org>; Tue,  4 Aug 2026 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785885774; cv=none; b=WeUxQSKJ7yUlEES6+Ar3EANMKlR6ELwmK6IUhDKh1epBHpn6Q0GDLpnfyt8jxZNNGsLu87+EKhh+iR7qtv+4+qdHT9xdxaDFlZMeqlh4G7jtpi4bsGdlbxsNHIILd1Dt3K/hL/u/ZfGZXAeEwmFmdiDXNEPqJQUAejpb6+dxblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785885774; c=relaxed/simple;
	bh=24VBQXDSyc8tYrEBTVdp5NEPlMlnxLk152F/9LBpX3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zp8M7OyHhipZ/Wq+OhOzfKLGMTh9EXP1J18FpvqFhN4wiO6LjYhc2E+3yEhms6zCMhes0upL6Bw/mZVB01zqQPEq5NhO9PygEfib8ijyjIIiHvpCpzGn7EjvGkqK0yj0uf0VVKt7NSV8dRVQ3HVudIOTwWVd2j82EArqW0GFPWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gO7pxz5l; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gO7pxz5l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785885773; x=1817421773;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=24VBQXDSyc8tYrEBTVdp5NEPlMlnxLk152F/9LBpX3k=;
  b=gO7pxz5l1z7YXX2UXK+A9ioOq5hH1X22a8eakQt/PBmEHaOnH/zjHdTF
   xPHIM51IFZzECHWAtp1SJwpXaNDmHc1Q80Ckn6ePS4W3qsGDTzppAZtzf
   hsG18TIu/SnaOwIjEbv3PWTeNriMasJtfs5mZHEYbtRbpiXAGGySyiTEd
   fqjN3BZ36P+EcL3NuDqgwIOqwTKKwamv1cVfZkjd5hHhLa+cqaJXi+jaZ
   RAl9LnfPArAYjKwgT3ClkAAyE6NO85X+eZ1a5l4u0YDxpnqpnCi+SkRmj
   oHk9rwzZ9EB0mKkW7j9Z3NqHcJVjc6oCpDyFqFZC1KTZTHADsvb/du4Ql
   g==;
X-CSE-ConnectionGUID: FmyAYrWSQwaftC8VQFWrEw==
X-CSE-MsgGUID: fsa3LZGbR8y2Hp15JWLTPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86305835"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="86305835"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:22:52 -0700
X-CSE-ConnectionGUID: iE0jV6j8QdiYxEwPHbtQkg==
X-CSE-MsgGUID: hijlmDHLSJGVWmFPCaIxxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257766649"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.7]) ([10.125.109.7])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:22:51 -0700
Message-ID: <9c66fc88-830a-4fe0-a0a5-6b17d453a93d@intel.com>
Date: Tue, 4 Aug 2026 16:22:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] cxl: Allow auto-committed BI hdm decoders
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
 benjamin.cheatham@amd.com, alucerop@amd.com, dongjoo.seo1@samsung.com,
 linux-cxl@vger.kernel.org
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-9-dave@stgolabs.net>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260728144136.709882-9-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/26 7:41 AM, Davidlohr Bueso wrote:
> Allow auto-committed BI hdm decoders on sane platforms, rejecting
> only broken paths (ie: one that cannot route BISnp, or BI paired
> with a host-only target range type).
> 
> The respective region creation is done like any other committed
> decoder - with cxlds->bi set by the time an decoder attaches.
> 
> A committed BI decoder under a window without the BI restriction is
> refused (undefined behavior per the CFMWS Window Restrictions), as
> is a committed decoder attaching to a region of a different
> coherency model.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/hdm.c    | 24 +++++++++++++++++-------
>  drivers/cxl/core/pci.c    | 36 +++++++++++++++++++++++++++++-------
>  drivers/cxl/core/region.c | 33 +++++++++++++++++++++++++++++++++
>  drivers/cxl/port.c        |  4 ++++
>  4 files changed, 83 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index f437fe15c6df..c5be6fe4c77a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1061,13 +1061,23 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		else
>  			cxld->target_type = CXL_DECODER_DEVMEM;
>  
> -		/*
> -		 * Autocommit BI-enabled decoders is not supported.
> -		 * At this point cxlds->bi is not yet setup, so there
> -		 * are no guarantees that the platform supports BI.
> -		 */
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl))
> -			return -ENXIO;
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl)) {
> +			struct cxl_dev_state *cxlds = cxled ?
> +				cxled_to_memdev(cxled)->cxlds : NULL;
> +
> +			if (cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
> +				dev_warn(&port->dev,
> +					 "decoder%d.%d: BI with host-only\n",
> +					 port->id, cxld->id);
> +				return -ENXIO;
> +			}
> +			if (cxlds && !cxlds->bi_capable) {
> +				dev_warn(&port->dev,
> +					 "decoder%d.%d: path not BI capable\n",
> +					 port->id, cxld->id);
> +				return -ENXIO;
> +			}
> +		}
>  
>  		guard(rwsem_write)(&cxl_rwsem.region);
>  		if (cxld->id != cxl_num_decoders_committed(port)) {
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 554058ccb1e9..8d2651e06a79 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1083,6 +1083,18 @@ static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
>  				    scale, base);
>  }
>  
> +/* Committed, or no explicit commit required */
> +static bool cxl_bi_decoder_committed(void __iomem *bi)
> +{
> +	u32 caps = readl(bi + CXL_BI_DECODER_CAPS_OFFSET);
> +	u32 sts = readl(bi + CXL_BI_DECODER_STATUS_OFFSET);
> +
> +	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ, caps))
> +		return true;
> +
> +	return FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMITTED, sts);
> +}
> +
>  /* Enable or dealloc BI-ID changes in the given level of the topology. */
>  static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
>  {
> @@ -1127,6 +1139,16 @@ static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
>  		return 0;
>  	case PCI_EXP_TYPE_DOWNSTREAM:
>  		if (enable) {
> +			/*
> +			 * Adopt a dport that was already programmed and
> +			 * committed by firmware: nothing new is enabled
> +			 * below it, so no commit is due.
> +			 */
> +			if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl) &&
> +			    !FIELD_GET(CXL_BI_DECODER_CTRL_BI_FW, ctrl) &&
> +			    cxl_bi_decoder_committed(bi))
> +				return 0;
> +
>  			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
>  			value |= CXL_BI_DECODER_CTRL_BI_ENABLE;
>  		} else {
> @@ -1173,11 +1195,11 @@ static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
>  
>  	if (enable) {
>  		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> -			if (cxlds->bi)
> -				return 0;
> -			dev_err(cxlds->dev,
> -				"BI already enabled in hardware\n");
> -			return -EBUSY;
> +			/* adopt firmware enabled */
> +			if (!cxlds->bi)
> +				dev_dbg(cxlds->dev,
> +					"adopting firmware-enabled BI\n");
> +			goto done;
>  		}
>  		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
>  	} else {
> @@ -1192,11 +1214,11 @@ static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
>  	}
>  
>  	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
> -	cxlds->bi = enable;
>  
>  	dev_dbg(cxlds->dev, "BI requests %s\n",
>  		str_enabled_disabled(enable));
> -
> +done:
> +	cxlds->bi = enable;
>  	return 0;
>  }
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 76c6dc28a407..5578ef68034d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1827,6 +1827,21 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	return rc;
>  }
>  
> +/* Read back the committed BI bit of an auto-discovered decoder */
> +static bool cxled_committed_bi(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	u32 ctrl;
> +
> +	if (!cxlhdm || !cxlhdm->regs.hdm_decoder)
> +		return false;
> +
> +	ctrl = readl(cxlhdm->regs.hdm_decoder +
> +		     CXL_HDM_DECODER0_CTRL_OFFSET(cxled->cxld.id));
> +	return FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl);
> +}
> +
>  static int cxl_region_attach_auto(struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled, int pos)
>  {
> @@ -1839,6 +1854,16 @@ static int cxl_region_attach_auto(struct cxl_region *cxlr,
>  		return -EINVAL;
>  	}
>  
> +	/* A committed decoder may only join a region of its own flavor */
> +	if (cxled_committed_bi(cxled) !=
> +	    (cxlr->type == CXL_DECODER_DEVMEM &&
> +	     cxl_root_decoder_is_bi(cxlr->cxlrd))) {
> +		dev_err(&cxlr->dev, "%s:%s coherency model mismatch\n",
> +			dev_name(&cxled_to_memdev(cxled)->dev),
> +			dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +
>  	if (pos >= 0) {
>  		dev_dbg(&cxlr->dev, "%s: expected auto position, not %d\n",
>  			dev_name(&cxled->cxld.dev), pos);
> @@ -3806,6 +3831,14 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	if (part < 0)
>  		return ERR_PTR(-EBUSY);
>  
> +	/* avoid UB */
> +	if (cxled_committed_bi(cxled) && !cxl_root_decoder_is_bi(cxlrd)) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s BI decoder in a non-BI window\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return ERR_PTR(-ENXIO);
> +	}
> +
>  	do {
>  		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
>  				       atomic_read(&cxlrd->region_id),
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index ab3317fc1388..0c666ce00aa2 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -181,6 +181,10 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * Must precede region discovery so that any firmware-committed BI
> +	 * decoder is adopted before its region is assembled.
> +	 */
>  	rc = cxl_bi_setup(port);
>  	if (rc)
>  		dev_dbg(&port->dev, "BI setup failed rc=%d\n", rc);

