Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6102F60D1
	for <linux-cxl@vger.kernel.org>; Thu,  4 Sep 2025 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757028065; cv=none; b=XyNrY/kkn9Qo6ks2azW1w+DDopT78HAAA9eqQU0wg/RYRajBsh4y9eiiRiDY4x3HynYBewseWAPm4BuptpO1yqMfapHvd2fNe7DjPoTlMsTzgNhuBoPQN2vmQJqNl9Za+MadBR5yksGfhBVQJYj2Q+l264KmEohOJaHoagXlRDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757028065; c=relaxed/simple;
	bh=lgpY6maW8AjMWiEtxhSHsdjnjnFwVx2mvDFV3MIoaeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bwx6KT0vaqL1oSg77NJRYXTQ13wsTvFJ2ErtLC/6zXHqOmNtrog29mzzZvNPIZStZCnAPusC+2WL8blEqsnGGiMhLksiFmqwmQ0OIK6a91UZtIy+1N7qB9dlYlfxXf4cXf+dHoqM81DwbQCljqfJI+dLjrNrAMJN4qL2lQMtYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gn6oLWSQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gn6oLWSQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757028064; x=1788564064;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lgpY6maW8AjMWiEtxhSHsdjnjnFwVx2mvDFV3MIoaeo=;
  b=Gn6oLWSQgv8l7IEjBgE9zyDhvQBanZpY/xRsXlk8RFQLFzn0rrWHtYIB
   Pd5f9HKls0Z56/ZtqWCDb/c0NwSrBi/xX1+mho5bop3kLrj7SxLzc1z00
   ikwfaDA7yPlX7Dw3WacWbhLQDTH5/JCi9/X/hzpp9Q+9jTIjibDQrr2Iw
   lutJLSHbY9N2r3uuWaiFnCqfmPdOkI8+PT3atek+GTX9+66YmtccGvgD4
   8i/xpEMQio5lJf/Oa1YsSZpbsKj/9VABgIhCfCE17s+bOSYf++gmwDIY/
   XW77t4Vzvt8wk+nqctQu3KvNYAJLRlPLDLtbMx9CKg6j2/0sMSLGCVUdV
   Q==;
X-CSE-ConnectionGUID: /rFRj8x0Q02vja1u795QyA==
X-CSE-MsgGUID: w5FSGA6/R0KnRlhGIEuitA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="62013560"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="62013560"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 16:21:03 -0700
X-CSE-ConnectionGUID: W5htyzl4SXa1zbrkZJWOnw==
X-CSE-MsgGUID: 0d3AvvjVTYaDv/rgzFK4yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="202852953"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.24]) ([10.125.110.24])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 16:21:02 -0700
Message-ID: <1d0080dc-484f-4929-a633-152b9e2a3328@intel.com>
Date: Thu, 4 Sep 2025 16:21:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cxl/acpi: Make the XOR calculations available for
 testing
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1756446925.git.alison.schofield@intel.com>
 <1474b223f2b50da36f36f07820a8708fcbb8441a.1756446925.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <1474b223f2b50da36f36f07820a8708fcbb8441a.1756446925.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/29/25 12:21 AM, Alison Schofield wrote:
> In preparation for adding a test module that can exercise the address
> translation functions performed by the CXL Driver, refactor the XOR
> implementation like this:
> 
> - Extract the core calculation into a standalone helper function,
> - Mark the new helper function as __mock_export to make it available
>   to test modules while keeping it otherwise static,
> - Enhance the parameter validation since this new function will be
>   called from a test module with no guarantee of valid rameters.
> - Move the define of struct cxl_cxims_data to include/linux/acpi.h
>   so the test module can build and pass xormap data.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  drivers/cxl/acpi.c   | 35 ++++++++++++++++++++++++-----------
>  include/linux/acpi.h |  7 +++++++
>  2 files changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 26c494704437..f924058dbd4c 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -11,11 +11,6 @@
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> -struct cxl_cxims_data {
> -	int nr_maps;
> -	u64 xormaps[] __counted_by(nr_maps);
> -};
> -
>  /*
>   * There is one CXIMS, therefore one set of XOR maps, that all CXL Windows with
>   * the same host bridge granularity share. The number of maps to apply at address
> @@ -28,20 +23,31 @@ static const int hbiw_to_nr_maps[HBIW_TO_NR_MAPS_SIZE] = {
>  	[1] = 0, [2] = 1, [3] = 0, [4] = 2, [6] = 1, [8] = 3, [12] = 2, [16] = 4
>  };
>  
> +static const int valid_hbiw[] = { 1, 2, 3, 4, 6, 8, 12, 16 };
> +
>  static const guid_t acpi_cxl_qtg_id_guid =
>  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
>  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
>  
> -static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
> +__mock_export u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw)
>  {
> -	int nr_maps_to_apply = hbiw_to_nr_maps[cxlrd->cxlsd.nr_targets];
> -	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> +	int nr_maps_to_apply = -1;
>  	u64 val;
>  	int pos;
>  
> -	/* No xormaps for host bridge interleave ways of 1 or 3 */
> -	if (!nr_maps_to_apply)
> -		return addr;
> +	/*
> +	 * Strictly validate hbiw since this function is used for testing and
> +	 * that nullifies any expectation of trusted parameters from the CXL
> +	 * Region Driver.
> +	 */
> +	for (int i = 0; i < ARRAY_SIZE(valid_hbiw); i++) {
> +		if (valid_hbiw[i] == hbiw) {
> +			nr_maps_to_apply = hbiw_to_nr_maps[hbiw];
> +			break;
> +		}
> +	}
> +	if (nr_maps_to_apply == -1 || nr_maps_to_apply > cximsd->nr_maps)
> +		return ULLONG_MAX;
>  
>  	/*
>  	 * In regions using XOR interleave arithmetic the CXL HPA may not
> @@ -73,6 +79,13 @@ static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
>  	return addr;
>  }
>  
> +static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
> +{
> +	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> +
> +	return cxl_do_xormap_calc(cximsd, addr, cxlrd->cxlsd.nr_targets);
> +}
> +
>  struct cxl_cxims_context {
>  	struct device *dev;
>  	struct cxl_root_decoder *cxlrd;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 1c5bb1e887cd..78e639a529c2 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1616,4 +1616,11 @@ static inline bool acpi_node_backed_by_real_pxm(int nid)
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_CXL_ACPI)
> +struct cxl_cxims_data {
> +	int nr_maps;
> +	u64 xormaps[] __counted_by(nr_maps);
> +};
> +#endif

Maybe move this to drivers/cxl/cxl.h instead?

> +
>  #endif	/*_LINUX_ACPI_H*/

