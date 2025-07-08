Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8533993;
	Tue,  8 Jul 2025 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016291; cv=none; b=jbRYjxyBwpXTmSQJ8AlvrAODL8BW8gczMQPNdp7o6QbmbZFAseraiurm8Yaiopcgi+zYL4vd/cu5qYFLFvzHPgo4Fmlaes4B8lR6J2/cJOYLDN1bWVaUg8CFOy/W8eTyC2s2Z22sTNVzsWWgAgOvAk90tsD0mAf7EjFzZWFzwM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016291; c=relaxed/simple;
	bh=lL6Erx1uLhCLGcLhPz8cJ2N77um6OQ3TVPp34qGw1DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5ePN7dADgHtVHW3/V7hMttr7JydxfIxy6FQB06PuL+cHm5lPJjKqmp+L54wGJI9ToiYybZSCSaEsGBzj3HkK1bJwvflFOs+vw0tssjJEIJN7cA96nV9krY5foi/CBohmbNUw8emjIZgqukhz15oS1jKc0poTFXB8XeuKSnCwuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iw7CF3Lc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iw7CF3Lc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752016290; x=1783552290;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lL6Erx1uLhCLGcLhPz8cJ2N77um6OQ3TVPp34qGw1DA=;
  b=iw7CF3LcWHT/WrjWlAkd+yC9eyzH4nhpBe4ZeBQeyPnih+glC/1bokkC
   hW0elcSzuyvVEjr8c5POh/wW38uOTe+uGpilRA9Isvuu/wistv0jYh72r
   bSWDWfEWEstVRiyk74xUty1MsgCbpvNvEw+nDbXAG0njVOGzWMQccyLsW
   ALP0/KfdQYQVDbRN0CeIwK1a05UETrCoY765zvz0zq/J1ozoNNMhsWI61
   mFbA/R3COB6X42gZiQSTB/iUmjWDvNOwRZJ6Aaxl0+6vbeTRDpXyThg/E
   OU4dPTPft4IUPMcXu7z4R+abcxCH+nRjACuzi92L/H9NhyTJIwXIft1vH
   g==;
X-CSE-ConnectionGUID: 9mXu8L0sR1CAoxLl9p8i/w==
X-CSE-MsgGUID: tqnN58WGQhGdbug+msFBIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65329699"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="65329699"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:11:29 -0700
X-CSE-ConnectionGUID: z5+e5fOvQ8WBmbQ4OoptIA==
X-CSE-MsgGUID: tU0AV1tLTfKl79OWjQ4zEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155244021"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.152]) ([10.125.110.152])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:11:26 -0700
Message-ID: <094e7862-d981-4c37-8941-57b4513caf2d@intel.com>
Date: Tue, 8 Jul 2025 16:11:23 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] cxl/edac: Fix wrong dpa checking for PPR operation
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com
Cc: andriy.shevchenko@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250708051536.92119-1-ming.li@zohomail.com>
 <20250708051536.92119-3-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250708051536.92119-3-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/7/25 10:15 PM, Li Ming wrote:
> DPA 0 is considered invalid in cxl_do_ppr(), but per Table 8-143. "Get
> Partition Info Output Payload" in CXL r3.2 section 8.2.10.9.2.1 "Get
> Partition Info(Opcode 4100h)", it mentions that DPA 0 is a valid address
> of a CXL device. So the correct implementation should be checking if the
> DPA is in the DPA range of the CXL device rather than checking if the
> DPA is equal to 0.
> 
> Fixes: be9b359e056a ("cxl/edac: Add CXL memory device soft PPR control feature")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/edac.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 623aaa4439c4..1cf65b1538b9 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -1923,8 +1923,11 @@ static int cxl_ppr_set_nibble_mask(struct device *dev, void *drv_data,
>  static int cxl_do_ppr(struct device *dev, void *drv_data, u32 val)
>  {
>  	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
> +	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> -	if (!cxl_ppr_ctx->dpa || val != EDAC_DO_MEM_REPAIR)
> +	if (!resource_contains_addr(&cxlds->dpa_res, cxl_ppr_ctx->dpa) ||
> +	    val != EDAC_DO_MEM_REPAIR)
>  		return -EINVAL;
>  
>  	return cxl_mem_perform_ppr(cxl_ppr_ctx);

