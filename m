Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97EDA59
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768350245; cv=none; b=uaZlVx9z4C3roiFL10bA7YQjBJZagd83QUx6mdp4lbaphz42rUJw4ILoH1gYlVsqrT/uGphdILk4Bzm5Xcek89Ma8C7eyuAa7+UJaAwxm92uvMW8qumgWRSUFejnggiQ++aEv0HkhZip6j9z7B3jgMxHFO18SP0yjJHO6jQNHNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768350245; c=relaxed/simple;
	bh=XNGKFmO02XCBV3N4IQZ4NvhRIlQuTiJx+A+Z+y1mN3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKF/fefpmaSME5j3lXLhFkwvKWmboRBywRhcLtCtQ4gvEwGCI4sTwln9W7Yh1gx8ivmEOqLhyASz/alTmtmcpfGc9+x7h//lGs7rHZ1GANKJPr3RmkBux5n7b3y2lRZou/WpaSmIZrIL6fH22mtBgz87eSBnTljwKTnSs4tzR1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6emwftP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6emwftP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768350243; x=1799886243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XNGKFmO02XCBV3N4IQZ4NvhRIlQuTiJx+A+Z+y1mN3o=;
  b=d6emwftPIpt6kptqSue5nR8QMALLvIPx+tK74BUXxTDnn09T+quBvfGW
   tjBN4X1/mP/coVwFe1tFT34kz7PR0vZ6wRhHmdfa8JhjAS03nQDh1ChJU
   EkVA9g3cGMcW6U/jfe8silXH6+Bl/SBBz5NgsACM4WUFFDM8k5x6waDWC
   yrbapcrmNBHwytlLtZEkBSbiqjXTlWgBDT2PtM0q+DhNsnFA3iJvia3M2
   E+mWKIp2cNl8KZgyxXv6Cd0fYTn5AqajhhjnDrfO+ogeEEbn6+5JaCCdU
   bzEPSlZBpawezUZKEWKvFdkjS96Ouca1lVVn4MSj1CipgBFqA70RhNB2n
   A==;
X-CSE-ConnectionGUID: nSlyQpdQTpKBFeCJDBhGEg==
X-CSE-MsgGUID: 7AzTUTzER8iwwRPbk8QIJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69698769"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69698769"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 16:24:03 -0800
X-CSE-ConnectionGUID: mQBfQGFrQWizvJagIKqbig==
X-CSE-MsgGUID: cGhZ6uLQR+O1wsxFfrLtgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204941971"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 16:24:02 -0800
Message-ID: <f6ac66b9-ab65-49fc-a4e2-2759edd0f1b1@intel.com>
Date: Tue, 13 Jan 2026 17:24:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cxl/region: Translate DPA->HPA in unaligned MOD3
 regions
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Qing Huang <qing.huang@intel.com>
References: <cover.1768008522.git.alison.schofield@intel.com>
 <b20339e518bb69af38199a5bb2a0c5e1aa373694.1768008522.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <b20339e518bb69af38199a5bb2a0c5e1aa373694.1768008522.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/26 6:54 PM, Alison Schofield wrote:
> The CXL driver implementation of DPA->HPA address translation depends
> on a region's starting address always being aligned to Host Bridge
> Interleave Ways * 256MB. The driver follows the decode methods
> defined in the CXL Spec[1] and expanded upon in the CXL Driver Writers
> Guide[2], which describe bit manipulations based on power-of-2
> alignment to translate a DPA to an HPA.
> 
> With the introduction of MOD3 interleave way support, platforms may
> create regions at starting addresses that are not power-of-2 aligned.
> This allows platforms to avoid gaps in the memory map, but addresses
> within those regions cannot be translated using the existing bit
> manipulation method.
> 
> Introduce an unaligned translation method for DPA->HPA that
> reconstructs an HPA by restoring the address first at the port level
> and then at the host bridge level.
> 
> [1] CXL Spec 3.2 8.2.4.20.13 Implementation Note Device Decoder Logic
> [2] CXL Type 3 Memory Software Guide 1.1 2.13.25 DPA to HPA Translation
> 
> Suggested-by: Qing Huang <qing.huang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Just a nit below

> ---
>  drivers/cxl/core/region.c | 159 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 151 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ae899f68551f..146ae9e42496 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3112,13 +3112,139 @@ u64 cxl_calculate_hpa_offset(u64 dpa_offset, int pos, u8 eiw, u16 eig)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_calculate_hpa_offset, "cxl_translate");
>  
> +static int decode_pos(int reg_ways, int hb_ways, int pos, int *pos_port,

s/reg_ways/region_ways/ makes it more readable.

DJ

> +		      int *pos_hb)
> +{
> +	int devices_per_hb;
> +
> +	/*
> +	 * Decode for 3-6-12 way interleaves as defined in the CXL
> +	 * Spec 3.2 9.13.1.1 Legal Interleaving Configurations.
> +	 */
> +	switch (hb_ways) {
> +	case 3:
> +		if (reg_ways != 3 && reg_ways != 6 && reg_ways != 12)
> +			return -EINVAL;
> +		break;
> +	case 6:
> +		if (reg_ways != 6 && reg_ways != 12)
> +			return -EINVAL;
> +		break;
> +	case 12:
> +		if (reg_ways != 12)
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	/* Calculate port and host bridge positions */
> +	devices_per_hb = reg_ways / hb_ways;
> +	*pos_port = pos % devices_per_hb;
> +	*pos_hb = pos / devices_per_hb;
> +
> +	return 0;
> +}
> +
> +/*
> + * restore_parent() reconstruct the address in parent
> + *
> + * This math, specifically the bitmask creation 'mask = gran - 1' relies
> + * on the CXL Spec requirement that interleave granularity is always a
> + * power of two.
> + *
> + * [mask]		isolate the offset with the granularity
> + * [addr & ~mask]	remove the offset leaving the aligned portion
> + * [* ways]		distribute across all interleave ways
> + * [+ (pos * gran)]	add the positional offset
> + * [+ (addr & mask)]	restore the masked offset
> + */
> +static u64 restore_parent(u64 addr, u64 pos, u64 gran, u64 ways)
> +{
> +	u64 mask = gran - 1;
> +
> +	return ((addr & ~mask) * ways) + (pos * gran) + (addr & mask);
> +}
> +
> +/*
> + * unaligned_dpa_to_hpa() translates a DPA to HPA when the region resource
> + * start address is not aligned at Host Bridge Interleave Ways * 256MB.
> + *
> + * Unaligned start addresses only occur with MOD3 interleaves. All power-
> + * of-two interleaves are guaranteed aligned.
> + */
> +static u64 unaligned_dpa_to_hpa(struct cxl_decoder *cxld,
> +				struct cxl_region_params *p, int pos, u64 dpa)
> +{
> +	int ways_port = p->interleave_ways / cxld->interleave_ways;
> +	int gran_port = p->interleave_granularity;
> +	int gran_hb = cxld->interleave_granularity;
> +	int ways_hb = cxld->interleave_ways;
> +	int pos_port, pos_hb, gran_shift;
> +	u64 hpa_port = 0;
> +
> +	/* Decode an endpoint 'pos' into port and host-bridge components */
> +	if (decode_pos(p->interleave_ways, ways_hb, pos, &pos_port, &pos_hb)) {
> +		dev_dbg(&cxld->dev, "not supported for region ways:%d\n",
> +			p->interleave_ways);
> +		return ULLONG_MAX;
> +	}
> +
> +	/* Restore the port parent address if needed */
> +	if (gran_hb != gran_port)
> +		hpa_port = restore_parent(dpa, pos_port, gran_port, ways_port);
> +	else
> +		hpa_port = dpa;
> +
> +	/*
> +	 * Complete the HPA reconstruction by restoring the address as if
> +	 * each HB position is a candidate. Test against expected pos_hb
> +	 * to confirm match.
> +	 */
> +	gran_shift = ilog2(gran_hb);
> +	for (int position = 0; position < ways_hb; position++) {
> +		u64 shifted, hpa;
> +
> +		hpa = restore_parent(hpa_port, position, gran_hb, ways_hb);
> +		hpa += p->res->start;
> +
> +		shifted = hpa >> gran_shift;
> +		if (do_div(shifted, ways_hb) == pos_hb)
> +			return hpa;
> +	}
> +
> +	dev_dbg(&cxld->dev, "fail dpa:%#llx region:%pr pos:%d\n", dpa, p->res,
> +		pos);
> +	dev_dbg(&cxld->dev, "     port-w/g/p:%d/%d/%d hb-w/g/p:%d/%d/%d\n",
> +		ways_port, gran_port, pos_port, ways_hb, gran_hb, pos_hb);
> +
> +	return ULLONG_MAX;
> +}
> +
> +static bool region_is_unaligned_mod3(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p = &cxlr->params;
> +	int hbiw = cxld->interleave_ways;
> +	u64 rem;
> +
> +	if (is_power_of_2(hbiw))
> +		return false;
> +
> +	div64_u64_rem(p->res->start, (u64)hbiw * SZ_256M, &rem);
> +
> +	return (rem != 0);
> +}
> +
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled = NULL;
>  	u64 dpa_offset, hpa_offset, hpa;
> +	bool unaligned = false;
>  	u16 eig = 0;
>  	u8 eiw = 0;
>  	int pos;
> @@ -3132,15 +3258,32 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	if (!cxled)
>  		return ULLONG_MAX;
>  
> -	pos = cxled->pos;
> -	ways_to_eiw(p->interleave_ways, &eiw);
> -	granularity_to_eig(p->interleave_granularity, &eig);
> -
>  	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> +
> +	/* Unaligned calc for MOD3 interleaves not hbiw * 256MB aligned */
> +	unaligned = region_is_unaligned_mod3(cxlr);
> +	if (unaligned) {
> +		hpa = unaligned_dpa_to_hpa(cxld, p, cxled->pos, dpa_offset);
> +		if (hpa == ULLONG_MAX)
> +			return ULLONG_MAX;
> +
> +		goto skip_aligned;
> +	}
> +	/*
> +	 * Aligned calc for all power-of-2 interleaves and for MOD3
> +	 * interleaves that are aligned at hbiw * 256MB
> +	 */
> +	pos = cxled->pos;
> +	ways_to_eiw(p->interleave_ways, &eiw);
> +	granularity_to_eig(p->interleave_granularity, &eig);
> +
>  	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, eiw, eig);
>  
>  	/* Apply the hpa_offset to the region base address */
> -	hpa = hpa_offset + p->res->start + p->cache_size;
> +	hpa = hpa_offset + p->res->start;
> +
> +skip_aligned:
> +	hpa += p->cache_size;
>  
>  	/* Root decoder translation overrides typical modulo decode */
>  	if (cxlrd->ops.hpa_to_spa)
> @@ -3151,9 +3294,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
>  		return ULLONG_MAX;
>  	}
> -
> -	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
> -	if (!cxlrd->ops.hpa_to_spa && !cxl_is_hpa_in_chunk(hpa, cxlr, pos))
> +	/* Chunk check applies to aligned modulo decodes only */
> +	if (!unaligned && !cxlrd->ops.hpa_to_spa &&
> +	    !cxl_is_hpa_in_chunk(hpa, cxlr, pos))
>  		return ULLONG_MAX;
>  
>  	return hpa;

