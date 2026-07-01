Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9283B4B8DEA
	for <linux-cxl@vger.kernel.org>; Wed,  1 Jul 2026 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929418; cv=none; b=uCc2JcUMHgxuVtnFqumqW4pKgkMlY5Miogg4Q9ODgwvBP7ZNgcXp+mlUdv5nasOWz6Il9V4sYoSq/a8T/4XGBzvCj+L4QY/ZhcBjz/bPLPu/dYu4l3RyLAHanyKQSuRsj8ElGxYydJ1Lrbwhta5He1P6OLTeYbijjG9XYCu3DHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929418; c=relaxed/simple;
	bh=oS2bnJRXq/tgOy6r7meqDn3QhxC4W1YDTqvmgl5byT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMnvtx1eQaI1PnTvHGLF3nkrjnTAW1uX8lg8kT7eFKb26W9Y3EGQakFKFIaG3CG4lpswWME46vtD0OUF8bnKtP1fhqWkLApfZKNGODFEOldybViWTmFGLZV5mzMgHyyXxYttS/JZ8S0hW0Z+QU6wJ9Enz0Ba+GHMB851LbMJ1lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrEiPNYp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrEiPNYp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782929416; x=1814465416;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oS2bnJRXq/tgOy6r7meqDn3QhxC4W1YDTqvmgl5byT8=;
  b=HrEiPNYpTBhPUVush51+D8yJLhVQpbTMTm+0kRdp6x56cxtro9SJ95ha
   l/6wgv4VVOLWfz5xUw1tYePXzpC3iEqMf4wQiWOl34xMoSLM1MVTuJPtx
   D2QZlNfUrEld5iGk4PfcLbQsHRwF7FmwBdAEXn+eKxEoAJ4ZpbZC8dk3e
   wPZHH0D/v0BHNB51wHk/r4LDTDuWHuzyNWjCm0Tqt0qis52kvV65NRbjf
   HDGeL81t/MvH4HNuFkjQ7DTeabmKL/OLXXTydlsu1E5sK420Kkv5tErpp
   e30P/5q5y5SL397jBox10alhdO69uNYK2zEk7uhA5Z53UnYBGTPli+w5v
   g==;
X-CSE-ConnectionGUID: bsb+DKtdRxybpqN4HMNhRw==
X-CSE-MsgGUID: 1l3+qQA4Q0ajMZObOMNwig==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="94271019"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="94271019"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 11:10:16 -0700
X-CSE-ConnectionGUID: F/NKt4NGTleMB9vFHdtxSg==
X-CSE-MsgGUID: VXMk+MC+R2m7pUuuhwbfNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="254570456"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.66]) ([10.125.110.66])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 11:10:15 -0700
Message-ID: <fcb3aded-f69b-40b1-a472-f100bd667101@intel.com>
Date: Wed, 1 Jul 2026 11:10:14 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] cxl/hdm: Add BI coherency support for endpoint
 decoders
To: Davidlohr Bueso <dave@stgolabs.net>, djbw@kernel.org
Cc: jic23@kernel.org, benjamin.cheatham@amd.com, icheng@nvidia.com,
 alucerop@amd.com, alison.schofield@intel.com, gourry@gourry.net,
 dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
References: <20260615145529.13848-1-dave@stgolabs.net>
 <20260615145529.13848-4-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260615145529.13848-4-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/15/26 7:55 AM, Davidlohr Bueso wrote:
> Cache the HDM decoder's Supported Coherency Models on struct cxl_hdm.
> Region attach consults this to verify the HDM supports the region's
> coherency type.
> 
> For uncommitted endpoint decoders, init_hdm_decoder() defaults
> target_type from supported_coherency: Type 3 devices default to
> HDM-DB when the HDM is device-coherent-only, HDM-H otherwise.
> 
> Pre-committed decoders with the BI bit set are not supported because
> endpoint and port enumerations are independent -- at decoder
> enumeration cxlds->bi is not yet known, so the topology cannot be
> verified.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Just a small request below

> ---
>  drivers/cxl/core/hdm.c | 24 +++++++++++++++++++++---
>  drivers/cxl/cxl.h      |  6 ++++++
>  drivers/cxl/cxlmem.h   |  2 ++
>  3 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..4a41cde9fdba 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -87,6 +87,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
>  		cxlhdm->iw_cap_mask |= BIT(16);
> +	cxlhdm->supported_coherency =
> +		FIELD_GET(CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK, hdm_cap);
>  }
>  
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> @@ -1023,6 +1025,14 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		else
>  			cxld->target_type = CXL_DECODER_DEVMEM;
>  
> +		/*
> +		 * Autocommit BI-enabled decoders is not supported.
> +		 * At this point cxlds->bi is not yet setup, so there
> +		 * are no guarantees that the platform supports BI.
> +		 */
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl))
> +			return -ENXIO;
> +
>  		guard(rwsem_write)(&cxl_rwsem.region);
>  		if (cxld->id != cxl_num_decoders_committed(port)) {
>  			dev_warn(&port->dev,
> @@ -1042,12 +1052,20 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		if (cxled) {
>  			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  			struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +			struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>  
>  			/*
> -			 * Default by devtype until a device arrives that needs
> -			 * more precision.
> +			 * HDMs that advertise support for both coherency
> +			 * modes (CXL_HDM_DECODER_COHERENCY_BOTH) default to
> +			 * host-only here; the region attach path will switch
> +			 * target_type to device-coherent if the region's
> +			 * root decoder has the CFMWS BI bit set. Only HDMs
> +			 * that strictly support device-coherent mode default
> +			 * to HDM-DB.
>  			 */
> -			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
> +			if (cxlds->type == CXL_DEVTYPE_CLASSMEM &&
> +			    cxlhdm->supported_coherency !=
> +			    CXL_HDM_DECODER_COHERENCY_DEV)
>  				cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  			else
>  				cxld->target_type = CXL_DECODER_DEVMEM;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 89c0c6ce24a3..917a6aee5936 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -57,6 +57,11 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
>  #define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
>  #define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> +#define   CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK GENMASK(22, 21)
> +#define     CXL_HDM_DECODER_COHERENCY_UNKNOWN 0x0
> +#define     CXL_HDM_DECODER_COHERENCY_DEV 0x1
> +#define     CXL_HDM_DECODER_COHERENCY_HOST 0x2
> +#define     CXL_HDM_DECODER_COHERENCY_BOTH 0x3

Can you update the CXL spec reference at the top of this block to r4.0?

DJ


>  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>  #define   CXL_HDM_DECODER_ENABLE BIT(1)
>  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> @@ -71,6 +76,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
>  #define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
>  #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
> +#define   CXL_HDM_DECODER0_CTRL_BI BIT(13)
>  #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>  #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
>  #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 776c50d1db51..f41d39cc3795 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -837,6 +837,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
>   * @target_count: for switch decoders, max downstream port targets
>   * @interleave_mask: interleave granularity capability, see check_interleave_cap()
>   * @iw_cap_mask: bitmask of supported interleave ways, see check_interleave_cap()
> + * @supported_coherency: HDM Decoder Capability supported coherency mask
>   * @port: mapped cxl_port, see devm_cxl_setup_hdm()
>   */
>  struct cxl_hdm {
> @@ -845,6 +846,7 @@ struct cxl_hdm {
>  	unsigned int target_count;
>  	unsigned int interleave_mask;
>  	unsigned long iw_cap_mask;
> +	unsigned int supported_coherency;
>  	struct cxl_port *port;
>  };
>  

