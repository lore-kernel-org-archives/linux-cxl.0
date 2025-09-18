Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40C1EDA26
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236280; cv=none; b=Ct/YGis9B93WMq76aQtHMBQ4e0fklMN8836cWyYY4VI3TS3hp+8ZnQ0msR/wNXKlAie+Yy1BG4jn8LVqGV8JisolRu2FxmZ0yEY0L2n59FeQI/s3EPN1Q3NwQ7gALVN2ASYRu7rD1xY3EPY9Hi13wdnkapQrzc4Ce4gg3gRAb10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236280; c=relaxed/simple;
	bh=9biOPHFX7gBeG3mu96FJHI38n+4nOemezkBQeDZ4mLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvHbA7bv0FxwlVu5Pe4Kjse+Fk0OZPCpR71ZtTvAwGutusLvGp0m9oXY+tSi2hlq7ynTSFwxT/O0oxPOKIGBFGHD0nzNFnW2TiYO9nQpyDWNaJnzkvynotnnevaG9b7EyiMw7iFUcWJRmlKMU5VWBapw0HrF5RjB76Vd2H669+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6ZHhctg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6ZHhctg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758236278; x=1789772278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9biOPHFX7gBeG3mu96FJHI38n+4nOemezkBQeDZ4mLY=;
  b=R6ZHhctgBvjGDWgo68S6ik5w1pygdPX3GFtvM39opGPfYZU/MxeXO87M
   icwFkZv92WIiRjmzZsbM0fdIPmTyMpSsLnSFoBfN8KBeuU8eeDUuFyDUZ
   oUEZPV1x+bTAKL1X4jVVW+c1MDPA5X6YIG4nTBzWnDCJ1kOW7SfdDS30x
   qWzjF4HYqww71XHkpyuF75fKOvrXc4aDEjOagrHWwCBU0Nlvs5oas9yKI
   ntUCBH/2r4ykZGNaZlRptLjxiKXz5QnxuI8NMRKOFkjde1u5mAkRiqpBV
   pCzLKPhkXrcfbuMXBDW7LYc31sSubC+bkAez5jOwOG3Xy6tSsEnV0ynLj
   w==;
X-CSE-ConnectionGUID: 5KyPWW8jTsetdfFrtFyDOw==
X-CSE-MsgGUID: 07KJYMw1RkOsPjlLq+bibQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="59621954"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="59621954"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 15:57:58 -0700
X-CSE-ConnectionGUID: Saf6CzhOTr+BWF5yKI0f5g==
X-CSE-MsgGUID: Z4qDSOVwSV6zL2efKkLg7w==
X-ExtLoop1: 1
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.28]) ([10.125.108.28])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 15:57:57 -0700
Message-ID: <bbdec504-c1b7-40d6-b879-d2460254bc56@intel.com>
Date: Thu, 18 Sep 2025 15:57:56 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] cxl/acpi: Make the XOR calculations available for
 testing
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1758150087.git.alison.schofield@intel.com>
 <76808ea6eb83a33dad50abc9707a4cf972d822d3.1758150087.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <76808ea6eb83a33dad50abc9707a4cf972d822d3.1758150087.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/25 5:10 PM, Alison Schofield wrote:
> In preparation for adding a test module that can exercise the address
> translation functions performed by the CXL Driver, refactor the XOR
> implementation like this:
> 
> - Extract the core calculation into a standalone helper function,
> - Export the new function for use by test module cxl_translate only,
> - Enhance the parameter validation since this new function will be
>   called from a test module with no guarantee of valid parameters,
> - Move the define of struct cxl_cxims_data to cxl.h so the test module
>   can build xormaps.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/acpi.c | 41 ++++++++++++++++++++++++++++++-----------
>  drivers/cxl/cxl.h  | 13 +++++++++++++
>  2 files changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index d7a5539d07d4..f981dcec463c 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -11,25 +11,36 @@
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> -struct cxl_cxims_data {
> -	int nr_maps;
> -	u64 xormaps[] __counted_by(nr_maps);
> -};
> -
>  static const guid_t acpi_cxl_qtg_id_guid =
>  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
>  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
>  
> -static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
> +#define HBIW_TO_NR_MAPS_SIZE (CXL_DECODER_MAX_INTERLEAVE + 1)
> +static const int hbiw_to_nr_maps[HBIW_TO_NR_MAPS_SIZE] = {
> +	[1] = 0, [2] = 1, [3] = 0, [4] = 2, [6] = 1, [8] = 3, [12] = 2, [16] = 4
> +};
> +
> +static const int valid_hbiw[] = { 1, 2, 3, 4, 6, 8, 12, 16 };
> +
> +u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw)
>  {
> -	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> -	int hbiw = cxlrd->cxlsd.nr_targets;
> +	int nr_maps_to_apply = -1;
>  	u64 val;
>  	int pos;
>  
> -	/* No xormaps for host bridge interleave ways of 1 or 3 */
> -	if (hbiw == 1 || hbiw == 3)
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
> @@ -60,6 +71,14 @@ static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
>  
>  	return addr;
>  }
> +EXPORT_SYMBOL_GPL_FOR_MODULES(cxl_do_xormap_calc, "cxl_translate");
> +
> +static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
> +{
> +	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> +
> +	return cxl_do_xormap_calc(cximsd, addr, cxlrd->cxlsd.nr_targets);
> +}
>  
>  struct cxl_cxims_context {
>  	struct device *dev;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ee33fabfec4a..2b1f891049a2 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -741,6 +741,19 @@ int cxl_validate_translation_params(u8 eiw, u16 eig, int pos);
>  u64 cxl_calculate_hpa_offset(u64 dpa_offset, int pos, u8 eiw, u16 eig);
>  u64 cxl_calculate_dpa_offset(u64 hpa_offset, u8 eiw, u16 eig);
>  int cxl_calculate_position(u64 hpa_offset, u8 eiw, u16 eig);
> +struct cxl_cxims_data {
> +	int nr_maps;
> +	u64 xormaps[] __counted_by(nr_maps);
> +};
> +
> +#if IS_ENABLED(CONFIG_CXL_ACPI)
> +u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw);
> +#else
> +static inline u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw)
> +{
> +	return ULLONG_MAX;
> +}
> +#endif
>  
>  int cxl_num_decoders_committed(struct cxl_port *port);
>  bool is_cxl_port(const struct device *dev);

