Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBDB3EFD09
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282344; cv=none; b=dr7vTqirVXtSjh7ATy9E5vkfjHedzqZB75DZJ9Gias6ePsJx/vpiJgBa/j6nYmdRat1EUabuvNM1qh+JclPv3ugi/GIXVrbaqCxZjb1SbY5fqb5tAsQwZkDBaQUDJc3IqHa55s7vTiyKF3nGMcEtEoAVZF9UlWqgrrGlHxWtDeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282344; c=relaxed/simple;
	bh=SmS6Ollg5NbD8on6FixZBvYnj64Dlk0eVcZKHUO/MVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffW71/7in5o98AWFvn2aLhTNe6kbWg8X0btXD/u5d188ISiXg+yWV8LHjWjxMm9rf6v6+CX3Px8jJYplzubmEEtBBupKoqNKW05XdOgFCBHWWBm6OCDrvjMkRbNvLq1QTgDm/RzsHpHA+As5Twu4SeZ6e3WEEJipz8U2k5rgMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DB1XWq+S; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DB1XWq+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781282342; x=1812818342;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SmS6Ollg5NbD8on6FixZBvYnj64Dlk0eVcZKHUO/MVs=;
  b=DB1XWq+SESTs0+/ZO5KEFTmXpcYHJ4hRigpfg2HSnoF7bxyPNEII3tHe
   /WrKXcqRcrLZ1346LNFz4y7xM29xpGXNuNBQVfmUNnZ4p/iaKUiSrhwrB
   ZnVtVGUkzUBe8AAD/FhagmeaxJbO/Z21P+j8GhtVVq7SWiwV6jupaXHT4
   kfdSbJCA8BhkMSdlazP5hNaw/8xkxLsZxfagF2mtI6s9ZscLlTSy2f3xy
   2bGbmAsoO3cmVfh/tHUJ+FS6l5gJJDaNAsdDDMa0wt/mp9MAoHqkHrIGu
   tSwc1Viel4ZmIuvtExQBRL/yEBgqK9L/1uwKNf1KklxsRnRnEc+YYdNLU
   Q==;
X-CSE-ConnectionGUID: L99njUAyRwawMm+jxrty0g==
X-CSE-MsgGUID: tAkwx1zGQsScKDWn3Ks5dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="81859479"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81859479"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 09:39:02 -0700
X-CSE-ConnectionGUID: yMEZSSyxTEOjbIGU2daHJA==
X-CSE-MsgGUID: Kp2S4AbWTm2b3Zr9HZ5ihA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="242490354"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 09:39:00 -0700
Message-ID: <7006a1f0-8101-4558-bc69-6b128cde357f@intel.com>
Date: Fri, 12 Jun 2026 09:38:59 -0700
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

Applied to cxl/next
661c092f9839

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

