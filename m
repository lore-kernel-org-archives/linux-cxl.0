Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD252842E;
	Fri,  9 Oct 2026 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570863; cv=none; b=ZlETjjnXRIQQrDvT2zv5OwPUNfcYTlBWnt+M8LPRMSbFp0hGPZzpcZJqYvu3zH39GdFZUzTxCsYfjUQHVdBWa05qt/XLKqKK1tT4FFwltcGb8X7xguFXZ/eStp2HWfjJBInX/NZymcdNuV1iKQUW0NmteoV5NpH/a9j640p/DpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570863; c=relaxed/simple;
	bh=5F4c48jROiSEVif1QpDn2HMRBODLSuMZpft2HMVumck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ru5oPmbi3wFiEWkElUp4PP8I06cbwex58vqSDUHh6OoOYtgkgbI0f/nkrDmbeLXsK06a7mGn7ORS+YzAdnWEOV4wENbn5Bkw8lQV4nQo/c68OejfaUN0mCrpa1s+MiU4WN9pg8qwvR3M9xORxZGOdiXwan75MCUs/yBZxCQb7J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZeZe5ytu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZeZe5ytu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791570858; x=1823106858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5F4c48jROiSEVif1QpDn2HMRBODLSuMZpft2HMVumck=;
  b=ZeZe5ytuR16sEejTPcIqwLDWa50ORoL1evNc0KJIbzgxZJ3nnSrCXlxF
   3tRDAgV3RgL3DYJ6dK11UgcnKl4CFAtPCavycSpewDPPG8iRXruJBSeJq
   AUIVk2n3OpG4mOGX4nMIqZGslNreeBbm5QmMRLGfqZOUnh7ztuO2dZgkT
   rkL8NRp1DX78KJuUzsdsJ9I4uSSyqLWuy+CEijDrU5yvc0FVQ3ppxzMFV
   c2M09/PFPWDRm3tfy6qTCk5w7PkGJKNOCwEai2wyJ/NsJ3LFo28VbOkkx
   HG5TNBeZ2KAvoM0jbfgLp7jEyOS33Uz5OdOdM4kku3COsFJVjgMhkh7lL
   A==;
X-CSE-ConnectionGUID: UvIxvMPZSamJEsTOHG48Yg==
X-CSE-MsgGUID: +kHl2+rHSTyaVcfIQRhdvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="369121"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="369121"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 11:34:17 -0700
X-CSE-ConnectionGUID: KFBfzYl7T2OqbWJNfABKqw==
X-CSE-MsgGUID: z9y6jD5fR9qAWo+uuE4skw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="828225"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.99]) ([10.125.109.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 11:34:16 -0700
Message-ID: <c35be235-00e6-4920-84bf-d01f3f6f3117@intel.com>
Date: Fri, 9 Oct 2026 11:34:14 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/3] cxl/test: Exercise explicit Type-2 RAM region
 creation
To: Richard Cheng <icheng@nvidia.com>, jic23@kernel.org, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org,
 ming.li@zohomail.com
Cc: kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com,
 kristinc@nvidia.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261007090540.43817-1-icheng@nvidia.com>
 <20261007090540.43817-4-icheng@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261007090540.43817-4-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/7/26 2:05 AM, Richard Cheng wrote:
> Add a second mock Type-2 accelerator without a FW-provided region.
> Register its memdev, try attachment, and explicitly create a 256 MB RAM
> region when needed.
> 
> Check the returned HPA range and retain the original accelerator on
> devm_cxl_probe_mem(). Preserve MANUAL DEVMEM configuration after
> disabled reply or failed saved-state restoration.
> 

Thanks for doing this Richard! Really appreciate it. Also nice to see an example of how it will be used.

DJ

> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> Changelog:
> 
> v1 -> v2:
> - Use separate registration, creation and attachment APIs
> - Request 256 MB from 512 MB capacity
> - Preserve DEVMEM config after failed restoration
> ---
>  tools/testing/cxl/test/accel.c | 28 +++++++++++++++++++-
>  tools/testing/cxl/test/cxl.c   | 47 +++++++++++++++++++++++++++++-----
>  2 files changed, 68 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/accel.c b/tools/testing/cxl/test/accel.c
> index 8e6f4687ca02..83962702145d 100644
> --- a/tools/testing/cxl/test/accel.c
> +++ b/tools/testing/cxl/test/accel.c
> @@ -20,6 +20,7 @@ static int cxl_mock_accel_probe(struct platform_device *pdev)
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_memdev *cxlmd;
>  	struct range mock_range;
> +	u64 region_size = pdev->id == 0 ? SZ_512M : SZ_256M;
>  	int rc;
>  
>  	cxl_accel = devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM,
> @@ -35,9 +36,34 @@ static int cxl_mock_accel_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> -	cxlmd = devm_cxl_probe_mem(cxlds, &mock_range);
> +	/* Keep the firmware-configured accelerator on the legacy API. */
> +	if (pdev->id == 0)
> +		cxlmd = devm_cxl_probe_mem(cxlds, &mock_range);
> +	else
> +		cxlmd = devm_cxl_register_mem(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
> +
> +	if (pdev->id != 0) {
> +		rc = devm_cxl_attach_mem_region(cxlmd, &mock_range);
> +		if (rc == -ENXIO) {
> +			/* The provider chooses to map half its volatile capacity. */
> +			rc = devm_cxl_create_ram_region(cxlmd, region_size);
> +			if (rc)
> +				return rc;
> +			rc = devm_cxl_attach_mem_region(cxlmd, &mock_range);
> +		}
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (mock_range.start > mock_range.end ||
> +	    range_len(&mock_range) != region_size) {
> +		dev_err(dev,
> +			"accelerator%d returned invalid HPA range %pra (expected %llu bytes)\n",
> +			pdev->id, &mock_range, region_size);
> +		return -ERANGE;
> +	}
>  	cxl_accel->cxlmd = cxlmd;
>  
>  	dev_dbg(dev, "Probed mock accelerator with range %pra\n", &mock_range);
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 3eb1051b1ee8..4fab2572a1aa 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -29,7 +29,7 @@ static bool mock_zero_size_decoders;
>  #define NR_CXL_SWITCH_PORTS 2
>  #define NR_CXL_PORT_DECODERS 8
>  #define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
> -#define NR_CXL_TYPE2_ACCEL 1
> +#define NR_CXL_TYPE2_ACCEL 2
>  
>  #define MOCK_AUTO_REGION_SIZE_DEFAULT SZ_512M
>  static int mock_auto_region_size = MOCK_AUTO_REGION_SIZE_DEFAULT;
> @@ -494,7 +494,17 @@ static void cfmws_elc_update(struct acpi_cedt_cfmws *window, int index)
>  
>  static void update_type2_cfmws(void)
>  {
> +	struct acpi_cedt_cfmws *window = &mock_cedt.cfmws1.cfmws;
> +
>  	memcpy(&mock_cedt.cfmws0.cfmws, &type2_cfmws0, sizeof(type2_cfmws0));
> +
> +	/* Give the unconfigured accelerator its own single-target window. */
> +	window->header.length = sizeof(*window) +
> +				sizeof(mock_cedt.cfmws1.target[0]);
> +	window->interleave_ways = 0;
> +	window->restrictions = ACPI_CEDT_CFMWS_RESTRICT_DEVMEM |
> +			       ACPI_CEDT_CFMWS_RESTRICT_VOLATILE;
> +	mock_cedt.cfmws1.target[0] = 1;
>  }
>  
>  static int populate_cedt(void)
> @@ -1122,6 +1132,7 @@ enum cxld_init_type {
>  	MOCK_DECODER_INIT_SAVED,
>  	MOCK_DECODER_INIT_TYPE3_AUTO,
>  	MOCK_DECODER_INIT_TYPE2_AUTO,
> +	MOCK_DECODER_INIT_TYPE2_MANUAL,
>  };
>  
>  static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
> @@ -1131,12 +1142,13 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
>  {
>  	struct cxl_test_decoder *found_td = cxld_registry_find(cxld);
>  
> -	if (found_td) {
> -		*td = found_td;
> -		return MOCK_DECODER_INIT_SAVED;
> -	}
> +	*td = found_td;
> +	if (type2_test && is_endpoint_decoder(&cxld->dev) && pdev->id == 1 &&
> +	    cxld->id == 0)
> +		return MOCK_DECODER_INIT_TYPE2_MANUAL;
>  
> -	*td = NULL;
> +	if (found_td)
> +		return MOCK_DECODER_INIT_SAVED;
>  
>  	/*
>  	 * The first decoder on the first 2 devices on the first switch
> @@ -1170,6 +1182,27 @@ static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_
>  	return false;
>  }
>  
> +static bool mock_init_hdm_type2_manual(struct cxl_endpoint_decoder *cxled,
> +				       struct cxl_test_decoder *td)
> +{
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +
> +	if (td) {
> +		if (mock_decoder_handle_saved(cxld, td))
> +			return true;
> +	} else {
> +		init_disabled_mock_decoder(cxld);
> +	}
> +
> +	/* Preserve DEVMEM on disabled replay and failed saved-state restore. */
> +	cxld->target_type = CXL_DECODER_DEVMEM;
> +	cxld->interleave_granularity = CXL_DECODER_MIN_GRANULARITY;
> +	if (!td)
> +		WARN_ON_ONCE(!cxld_registry_new(cxld));
> +
> +	return false;
> +}
> +
>  static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
>  				      struct cxl_port *port)
>  {
> @@ -1445,6 +1478,8 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	case MOCK_DECODER_INIT_TYPE2_AUTO:
>  		mock_init_hdm_type2_cxled(cxled, port);
>  		return false;
> +	case MOCK_DECODER_INIT_TYPE2_MANUAL:
> +		return mock_init_hdm_type2_manual(cxled, td);
>  	default:
>  		return false;
>  	}

