Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3AA22FE0A;
	Wed, 10 Dec 2025 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765388667; cv=none; b=cyfaObTKl4lVjV7M1D5sCnNPWykMpuD/P1LBY3QFe1UFdsRThXVqGvvBOLXTXtT9UfrBKBJ/ViNMy69zYzzlD0Wh652S9n29zhqVtW6t41MZOy1UkcnRpIeZwasOnyvchZidoJxsdog1B8eJETdJHo8lJCikGV0UWU9fhSVysTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765388667; c=relaxed/simple;
	bh=d274ld5rBlVfqZFv1licFy1ssifbec0TrkvLSfRgfjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8x3SMz9kQXz+1WGfFWDPPn1HlZ7eM65EWnq+3DM27KBoFJ7Bb28QidEF+xIjSdkBMyoa0fWcp8TW1ZmxIKHTbLQNNBMSB/Rcy2hYpwOA3dzlQrQ9YqPOroyhQ/9jbb15rZsFPlA1qIfnc5xaJylWaHV6m+rOGyVMOIQLVmXMyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3lmTIzh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3lmTIzh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765388665; x=1796924665;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d274ld5rBlVfqZFv1licFy1ssifbec0TrkvLSfRgfjc=;
  b=A3lmTIzhOjOma+4qIn1ATWVmgChU/hfQGHkTbtweK4dx8Ti9R92+/hbz
   m+JNznizU7QnesyIybZzsIWyArrLtw7kdM+INdJKuIGOgnqDuqNFafXXT
   j5HztcV9w7eXB+oiSmbsl5Y7Cr+P5g3Lt47CXB3fPrayW/ApEygDjOJSw
   vqc791K0U4YXyDt3kXivyJIc80OnmpU9Hv05wKVCSxzk5hqJoW24mniPv
   8RoaR7x3Fs/GuaeTO5Fav66Q5ZupOYLCrFwvMIzNyEQQMPCzIHG7HdMU5
   IFeJzYvTQHkVzCmPT4Sdl8BnsfW5MmNk5mZa9Xmj5odONT63Ox70QM3PC
   w==;
X-CSE-ConnectionGUID: XRw4+KUuQpSWlFqBzYMT/g==
X-CSE-MsgGUID: JcMQez/BQV6i9iZcUGuDRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67414098"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="67414098"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 09:44:25 -0800
X-CSE-ConnectionGUID: YRZ1xlhWTPSXRYg1UGivHw==
X-CSE-MsgGUID: O1ohR3HqSkmSZBF4aloTnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="197364691"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.138]) ([10.125.109.138])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 09:44:23 -0800
Message-ID: <7e9a44be-7360-44dc-8a6a-7b899514f979@intel.com>
Date: Wed, 10 Dec 2025 10:44:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/13] cxl: Disable HPA/SPA translation handlers for
 Normalized addressing
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251209180659.208842-1-rrichter@amd.com>
 <20251209180659.208842-14-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251209180659.208842-14-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/9/25 11:06 AM, Robert Richter wrote:
> The root decoder implements callbacks hpa_to_spa and spa_to_hpa to
> perform Host Physical Address (HPA) and System Physical Address
> translations respectively. The callbacks are needed in cases where HPA
> != SPA to convert addresses for tracing and error handling and to
> setup Poison injection. Currently this is used for XOR interleaving.
> 
> In AMD Zen5 systems with Normalized addressing, the addresses of
> endpoints are not SPA and those callbacks need to be implemented.
> 
> Now, as ACPI PRM translation could be expensive in tracing or error
> handling code paths, do not yet enable this direction of translation
> (hpa_to_spa) to avoid its intensive use. Instead, mark the HPA invalid
> and return an error for this case.
> 
> The spa_to_hpa callback will be used in region_offset_to_dpa_result()
> to determine the endpoint by the position in the interleaving
> chunk. With Normalized addressing, the order of endpoints in the
> interleaving chunk is implementation defined. Do not use this approach
> and and return an error instead.
> 
> Disable both HPA/SPA translation handlers for Normalized addressing by
> returning an error (ULLONG_MAX).
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/atl.c    | 35 +++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c | 21 ++++++++++++++++++++-
>  drivers/cxl/cxl.h         |  1 +
>  3 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
> index 4bd2289b8bbb..9d05a83bde73 100644
> --- a/drivers/cxl/core/atl.c
> +++ b/drivers/cxl/core/atl.c
> @@ -57,6 +57,39 @@ static u64 prm_cxl_dpa_spa(struct pci_dev *pci_dev, u64 dpa)
>  	return spa;
>  }
>  
> +static u64 atl_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> +{
> +	/*
> +	 * PRM translation could be expensive in tracing or error
> +	 * handling code paths. Avoid this for now and return an
> +	 * error instead.
> +	 */
> +
> +	return ULLONG_MAX;
> +}
> +
> +static u64 atl_spa_to_hpa(struct cxl_root_decoder *cxlrd, u64 spa)
> +{
> +	/*
> +	 * The callback will be used in region_offset_to_dpa_result()
> +	 * to determine the endpoint by the position in the
> +	 * interleaving chunk. With Normalized addressing, the order
> +	 * of endpoints in the interleaving chunk is implementation
> +	 * defined. Do not use this approach and and return an error
> +	 * instead.
> +	 */
> +
> +	return ULLONG_MAX;
> +}
> +
> +static int cxl_prm_setup_region(struct cxl_region *cxlr)
> +{
> +	cxlr->cxlrd->ops.hpa_to_spa = atl_hpa_to_spa;
> +	cxlr->cxlrd->ops.spa_to_hpa = atl_spa_to_hpa;
> +
> +	return 0;
> +}
> +
>  static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
>  {
>  	struct cxl_region_context *ctx = data;
> @@ -183,6 +216,8 @@ static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
>  	ctx->interleave_ways = ways;
>  	ctx->interleave_granularity = gran;
>  
> +	cxl_root->ops.translation_setup_region = cxl_prm_setup_region;
> +
>  	dev_dbg(&cxld->dev,
>  		"address mapping found for %s (hpa -> spa): %#llx+%#llx -> %#llx+%#llx ways:%d granularity:%d\n",
>  		dev_name(cxlmd->dev.parent), base, len, hpa_range.start,
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2c070c7c7bfe..130af1cf95b7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -623,6 +623,21 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(mode);
>  
> +static int cxl_region_setup_translation(struct cxl_region *cxlr)
> +{
> +	struct cxl_port *root = to_cxl_port(cxlr->dev.parent->parent);
> +	struct cxl_root *cxl_root;
> +
> +	if (!root || !is_cxl_root(root))
> +		return 0;
> +
> +	cxl_root = to_cxl_root(root);
> +	if (!cxl_root || !cxl_root->ops.translation_setup_region)
> +		return 0;
> +
> +	return cxl_root->ops.translation_setup_region(cxlr);
> +}
> +
>  static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  {
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> @@ -666,7 +681,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  	p->res = res;
>  	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
>  
> -	return 0;
> +	return cxl_region_setup_translation(cxlr);
>  }
>  
>  static void cxl_region_iomem_release(struct cxl_region *cxlr)
> @@ -3663,6 +3678,10 @@ static int __construct_region(struct cxl_region *cxlr,
>  	p->interleave_granularity = ctx->interleave_granularity;
>  	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
>  
> +	rc = cxl_region_setup_translation(cxlr);
> +	if (rc)
> +		return rc;
> +
>  	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>  	if (rc)
>  		return rc;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 20b0fd43fa7b..f4623728a815 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -653,6 +653,7 @@ struct cxl_root_ops {
>  			 struct access_coordinate *coord, int entries,
>  			 int *qos_class);
>  	int (*translation_setup_root)(struct cxl_root *cxl_root, void *data);
> +	int (*translation_setup_region)(struct cxl_region *cxlr);
>  };
>  
>  /**

