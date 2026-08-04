Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A41AAE17
	for <linux-cxl@vger.kernel.org>; Tue,  4 Aug 2026 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785883918; cv=none; b=bdEwC/iSFhGdqFiwLq3nZrXcLyKDj3SDS2tBeSLV4fJ62hbIWGI6F9ngRzBROj5oPDkeLDLG1VDfbWUDqufJkki8JhSUarQDuBoUC+g3EKGYFBpzvm4acN2QKJJ0D+SCkVV1eA5S0SuFeGS9/c1yC6FQY3++CCA63UT+Cl0EXqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785883918; c=relaxed/simple;
	bh=5hkjvN4lSTbp7mbt8vHAbUYnK+6IWcT2JXX2oIeNG2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6QMQDObd+LAUO3isMTcOmr7MpVuIb797hYF27Mq/n+yg6NjDVSAi2NtnuSBei236Ylvn3bCNoJ1Z6itLuwH4O8yaV2RH+9ks5PxDxYBBiLc8rJ2jbdWfJeHYwZ+iEpuGCecxoCoFfOzEN033d9rlABe+NUt8ldKdLMh+MY9tZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WeG9SAcr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WeG9SAcr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785883917; x=1817419917;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5hkjvN4lSTbp7mbt8vHAbUYnK+6IWcT2JXX2oIeNG2Q=;
  b=WeG9SAcroPGpB3u0m7KZdSydR9PTlBx12sL1Ctlrmm6sgu17T6k86yPS
   YVDIbDfROt3kGPAtaDIO5p+n2rKUg1a9Xtf+0eiSqobnfgWLuQFXPt//s
   d0hDaJq9bb1zAVt/Zchu4UsZ9aWMqe8EUzjoAH1Qi4FgnkXONA+is0wiT
   aSh8bS1IybbDn9K2R9A2y5TKN562uWGjAVcU44SJBVznMfAXtClL5MClr
   xsz4OHGwCudMNZJHpCfiSh38tOllZQ2W0X/MKjiS/ySAVSarDqEemWM4Z
   dzcsYk8/xFc2qABtZ/nETvj/9AR1YFtHOkMo8LrhmBzcHSXHevttSPZf8
   g==;
X-CSE-ConnectionGUID: Tz01xzFBSaiMTcRGLYqIsw==
X-CSE-MsgGUID: ywTQjL4VRNeei9OnzO41iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86479578"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="86479578"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 15:51:56 -0700
X-CSE-ConnectionGUID: uF7Ci5doT4qn4ShaxSsPgA==
X-CSE-MsgGUID: 556E2vCvSaiLTmXgVORqZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="265884801"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.7]) ([10.125.109.7])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 15:51:56 -0700
Message-ID: <fae7ad62-aa7e-4b18-9092-e91bf57b0755@intel.com>
Date: Tue, 4 Aug 2026 15:51:54 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/8] cxl/region: Log the coherency model at region
 creation
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
 benjamin.cheatham@amd.com, alucerop@amd.com, dongjoo.seo1@samsung.com,
 linux-cxl@vger.kernel.org
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-7-dave@stgolabs.net>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260728144136.709882-7-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/26 7:41 AM, Davidlohr Bueso wrote:
> Region assembly emits plenty of debug information - resources,
> interleave geometry, target placement - but not the coherency model
> the region operates in.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 840acc330ede..76c6dc28a407 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2741,6 +2741,17 @@ void kill_regions(struct cxl_root_decoder *cxlrd)
>  		unregister_region(cxlr);
>  }
>  
> +static const char *cxl_region_coherency(struct cxl_region *cxlr)
> +{
> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
> +		return "HDM-H";
> +
> +	if (cxl_root_decoder_is_bi(cxlr->cxlrd))
> +		return "HDM-DB";
> +
> +	return "HDM-D";
> +}
> +
>  /**
>   * devm_cxl_add_region - Adds a region to a decoder
>   * @cxlrd: root decoder
> @@ -2785,8 +2796,9 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  		return ERR_PTR(rc);
>  	}
>  
> -	dev_dbg(port->uport_dev, "%s: created %s\n",
> -		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
> +	dev_dbg(port->uport_dev, "%s: created %s %s\n",
> +		dev_name(&cxlrd->cxlsd.cxld.dev), cxl_region_coherency(cxlr),
> +		dev_name(dev));
>  	return cxlr;
>  err:
>  	put_device(dev);

