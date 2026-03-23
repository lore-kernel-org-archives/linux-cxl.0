Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD135959;
	Mon, 23 Mar 2026 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280244; cv=none; b=CaP9CsGwtYb2fYqKtlu9hNBsWzg4ZkzpvDwABI3ZGVG1QDLnXv6shLFzofQ3J0m2eju8/vQ7/o3l/B62pvhc6M1B8LJbcWx5wvliyoxq/ALwJFqjs9KbG+L76KGQd+33tRU8fGfTt7X3g9Fg+OwosYCALK04TyaZbf/7Lo+JVvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280244; c=relaxed/simple;
	bh=+DFMZ6j793GnAQHE/LPOA0p6fRA65y5HJXR8MybH6oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jlnl96MnYHvrHWLuBwtQ4VyYJyqHXGCLDZDzdkHpgfRgqRIknVkDYlomk+xErMVs90ONMX+B0RIjiXXhm6QoJJlbZHIPbzsq5UJsuylVVXRWo+CTRF0GM6a5F1FQtxyNsOSilPEondnUKNqFpBOq45ag696yeLIa6fyARyC6Y7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLFPJe1b; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLFPJe1b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774280243; x=1805816243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+DFMZ6j793GnAQHE/LPOA0p6fRA65y5HJXR8MybH6oU=;
  b=mLFPJe1bcH373XyBkv7lifV1UTCDTtTm+jF1kC6Ll0o0Qer3J6rtCp4z
   tYdXwiamQ6X+v59r6MvZrLTUknHAzen6nksZdOvuAdlpNua2cGvq5MThY
   lic4xXYrPav1dxx8ERhzcEl7fmwv82s5WnYQG/pNnCMhW8AdDcGJoigSI
   rrYT1dOwi1mffBS9JhlrUoit/b8Uv2I8padwpzSUERZ587RPOJ4h5N/ew
   ff2RrXx9KlIT0XyMzRjeClpEExRImbA6SPKNagAn2WfcPplPVkL74djST
   ssBy96/3j0i+kcQRPKEXPrzchZ4rHwXv4ygms5rdK1sZgYaPj60B1lQ3d
   g==;
X-CSE-ConnectionGUID: eV2o5XGUTCevnEbLo4Kiiw==
X-CSE-MsgGUID: 4O4Dmt4XQ7iNnN0GRuyOpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75168919"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75168919"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 08:37:23 -0700
X-CSE-ConnectionGUID: zgvyRHoVTrWgFAzqS0rIsA==
X-CSE-MsgGUID: 73QSFGMPSXGcgac9dcabEQ==
X-ExtLoop1: 1
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.109.216]) ([10.125.109.216])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 08:37:20 -0700
Message-ID: <a77fd9a3-e1e7-447d-8d60-d5c6b7dff9a8@intel.com>
Date: Mon, 23 Mar 2026 08:37:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/hdm: Add support for 32 switch decoders
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260321061459.1910205-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260321061459.1910205-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/20/26 11:14 PM, Li Ming wrote:
> Per CXL r4.0 section 8.2.4.20.1. CXL host bridge and switch ports can
> support 32 HDM decoders. Current implementation misses some decoders on
> CXL host bridge and switch in the case that the value of Decoder Count
> field in CXL HDM decoder Capability Register is greater than or equal to
> 9.
> 
> Update calculation implementation to ensure the decoder count calculation
> is correct for CXL host bridge/switch ports.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
> Changes from v1:
> - Return -ENXIO if the value violates SPEC. (Dave & Alison)
> ---
>  drivers/cxl/core/hdm.c |  2 +-
>  drivers/cxl/cxl.h      | 11 ++++++++++-
>  drivers/cxl/cxlmem.h   |  2 +-
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index c222e98ae736..3930e130d6b6 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -177,7 +177,7 @@ static struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  	}
>  
>  	parse_hdm_decoder_caps(cxlhdm);
> -	if (cxlhdm->decoder_count == 0) {
> +	if (cxlhdm->decoder_count < 0) {
>  		dev_err(dev, "Spec violation. Caps invalid\n");
>  		return ERR_PTR(-ENXIO);
>  	}
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9b947286eb9b..0a5301049cf3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -77,7 +77,16 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  {
>  	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
>  
> -	return val ? val * 2 : 1;
> +	switch (val) {
> +	case 0:
> +		return 1;
> +	case 1 ... 8:
> +		return val * 2;
> +	case 9 ... 12:
> +		return (val - 4) * 4;
> +	default:
> +		return -ENXIO;
> +	}
>  }
>  
>  /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index e21d744d639b..399b150b404c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -923,7 +923,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
>   */
>  struct cxl_hdm {
>  	struct cxl_component_regs regs;
> -	unsigned int decoder_count;
> +	int decoder_count;
>  	unsigned int target_count;
>  	unsigned int interleave_mask;
>  	unsigned long iw_cap_mask;

