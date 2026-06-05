Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6753B38AF
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673860; cv=none; b=e8IeqvdFIrRIMi6hljWbBDM3RHVyuNvDrwcC8lWAxFziI6mFrfKnhYSO2dd9mytPIe7vRfvZqqiTmjMQ0ZDXQqB5amHxsyfQBlXLYAX4oNAi2W6XVtLvlnn08tOH/MT3umLFXo25vbgR3mPd1I4aT3MrbR6GJNusizjocjmkSvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673860; c=relaxed/simple;
	bh=F4HhXeMx9Pr8Jq+vemDQhP8q8tffNpKVscaHJCz/peE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5aQKuXul7Lu62fh+mgYJsdrl6aRqpxnv373ykKS92KYiD/Q1ZhPpxiis0V5HaXnRX4sQMW81ABcavmNzs02lwfjGSNuGTPPA9b57kWX4YgvTMntSNpqA1ZT1T5pthlPK90VzNgqQRXvhr3WBWj41k9nZ4tHLZla0wkv8rqYEz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XcMmfcYu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XcMmfcYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780673859; x=1812209859;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F4HhXeMx9Pr8Jq+vemDQhP8q8tffNpKVscaHJCz/peE=;
  b=XcMmfcYuNtveaMuGVnve+zYm5dDwhUiTbrtYXBBCU8oC629eVXJdlMfq
   GUa0nflOJyBSfKIqu8vaoGxPZvblyDC22dn5qRc3MMpcSzA8sK/htV9rK
   tQBtY5ReqcO8w9QSZCxUweTi7/0lWq8Vh1L0tkZwr85HhBVRd46lIEo+E
   jTKFwJZbJ8q5xCzJR2/f0N2LSJeN4h3rcEvh32qbspI6UHYCXwPoLa/ys
   ZR8qlEXPbgekWxt/Rx/7zirJ/8rp/nq/RfCnb7gGKYxxLHidpWKYBsNd5
   FW3ZNqSV2F/B/i+LVz9JylYR2nzrncX7VV5f5zmS/4nG/CPlZ/vw5zp4X
   A==;
X-CSE-ConnectionGUID: xhjJUaYaTD+vea8UlB564Q==
X-CSE-MsgGUID: Mri1k3MbSTqpqHUJKocHRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="91822033"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="91822033"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:37:38 -0700
X-CSE-ConnectionGUID: vajNv5FMT4KmOyfP3vRAgg==
X-CSE-MsgGUID: mML2yDJKRbaISTGYG/todw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="275106665"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.36]) ([10.125.109.36])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:37:38 -0700
Message-ID: <5eecc964-6a06-48d5-8d61-57857ee80e29@intel.com>
Date: Fri, 5 Jun 2026 08:37:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Align interleave decode/encode helpers with their
 callers
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org, Purva Yeshi <purvayeshi550@gmail.com>
References: <20260605040801.865965-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260605040801.865965-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/26 9:07 PM, Alison Schofield wrote:
> The interleave conversion helpers translate between encoded HDM
> interleave values and the granularity and way values used by the
> driver.
> 
> These helpers have been a recurring source of static analysis
> complaints that expose type mismatches and potentially uninitialized
> outputs. Fix those issues in the helpers so callers inherit the
> consistent behavior automatically.
> 
> The decode and encode helpers have different interface issues.
> 
> The decode helpers return values through unsigned int pointers, but
> the decoded values are ultimately represented as int throughout the
> driver. Align the helper interfaces with their callers by changing
> the out-parameters to int * and updating the handful of affected
> locals to match.
> 
> The encode helpers leave their out-parameters unchanged on error. That
> means callers that ignore the return value may observe uninitialized
> encoded values. Initialize the outputs so failed conversions leave
> defined values. This issue was originally reported by Purva and the
> helper-side fix was suggested by Dan [1].
> 
> Tidy up a related, pre-existing, printk format specifier mismatch in
> cxl_validate_translation_params().
> 
> No functional change for valid interleave parameters.
> 
> [1] https://lore.kernel.org/linux-cxl/20250419203530.45594-1-purvayeshi550@gmail.com/
> 
> Reported-by: Purva Yeshi <purvayeshi550@gmail.com>
> Suggested-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/acpi.c        | 10 +++++-----
>  drivers/cxl/core/region.c |  4 ++--
>  drivers/cxl/cxl.h         |  6 ++++--
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 127537628817..3b818adbd38b 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -101,8 +101,8 @@ static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct device *dev = ctx->dev;
>  	struct cxl_cxims_data *cximsd;
> -	unsigned int hbig, nr_maps;
> -	int rc;
> +	unsigned int nr_maps;
> +	int hbig, rc;
>  
>  	rc = eig_to_granularity(cxims->hbig, &hbig);
>  	if (rc)
> @@ -160,7 +160,7 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>  				 struct acpi_cedt_cfmws *cfmws)
>  {
>  	int rc, expected_len;
> -	unsigned int ways;
> +	int ways;
>  
>  	if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO &&
>  	    cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
> @@ -405,7 +405,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  	struct cxl_cxims_context cxims_ctx;
>  	struct device *dev = ctx->dev;
>  	struct cxl_decoder *cxld;
> -	unsigned int ways, i, ig;
> +	int ways, i, ig;
>  	int rc;
>  
>  	rc = cxl_acpi_cfmws_verify(dev, cfmws);
> @@ -464,7 +464,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  			if (rc < 0)
>  				return rc;
>  			if (!cxlrd->platform_data) {
> -				dev_err(dev, "No CXIMS for HBIG %u\n", ig);
> +				dev_err(dev, "No CXIMS for HBIG %d\n", ig);
>  				return -EINVAL;
>  			}
>  		}
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..61877483cbcd 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3060,7 +3060,7 @@ int cxl_validate_translation_params(u8 eiw, u16 eig, int pos)
>  		return -EINVAL;
>  	}
>  	if (pos < 0 || pos >= ways) {
> -		pr_debug("%s: invalid pos=%d for ways=%u\n", __func__, pos,
> +		pr_debug("%s: invalid pos=%d for ways=%d\n", __func__, pos,
>  			 ways);
>  		return -EINVAL;
>  	}
> @@ -3106,7 +3106,7 @@ EXPORT_SYMBOL_FOR_MODULES(cxl_calculate_dpa_offset, "cxl_translate");
>  
>  int cxl_calculate_position(u64 hpa_offset, u8 eiw, u16 eig)
>  {
> -	unsigned int ways = 0;
> +	int ways = 0;
>  	u64 shifted, rem;
>  	int pos, ret;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..66cb2293fec1 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -91,7 +91,7 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  }
>  
>  /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> -static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
> +static inline int eig_to_granularity(u16 eig, int *granularity)
>  {
>  	if (eig > CXL_DECODER_MAX_ENCODED_IG)
>  		return -EINVAL;
> @@ -100,7 +100,7 @@ static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
>  }
>  
>  /* Encode defined in CXL ECN "3, 6, 12 and 16-way memory Interleaving" */
> -static inline int eiw_to_ways(u8 eiw, unsigned int *ways)
> +static inline int eiw_to_ways(u8 eiw, int *ways)
>  {
>  	switch (eiw) {
>  	case 0 ... 4:
> @@ -118,6 +118,7 @@ static inline int eiw_to_ways(u8 eiw, unsigned int *ways)
>  
>  static inline int granularity_to_eig(int granularity, u16 *eig)
>  {
> +	*eig = 0;
>  	if (granularity > SZ_16K || granularity < CXL_DECODER_MIN_GRANULARITY ||
>  	    !is_power_of_2(granularity))
>  		return -EINVAL;
> @@ -127,6 +128,7 @@ static inline int granularity_to_eig(int granularity, u16 *eig)
>  
>  static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  {
> +	*eiw = 0;
>  	if (ways > 16)
>  		return -EINVAL;
>  	if (is_power_of_2(ways)) {
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731

