Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1F287510
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676480; cv=pass; b=Z5zp1jqTk0+N+1Ecb09ElINQHiE9BWmJEWhdcxvMmt2a2/NdknXgkwGOiLgvITDDaXtIsWN8L9zKPkwZkl12Ovajs1JJ4GHhr8V1klb2reAT+PmYxUPPLW00D1giYyjTex+MnXzg5ZkqpfWSGdKd9EH4K3tOw8qc/7i9ksuPx4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676480; c=relaxed/simple;
	bh=i9RWKvOmj31ugbWv+NUPQcmU09rBXan8K/0YJafOHi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMPIBjavZv1T55T6TUEPeXYpilXgk/vuvc48jKVJNNUbWhVni/rXDCscyiOfcq2ChiIhXebU6QSriC9VcBQPH9a+DGZqN6Hk+GB5joSmE4a53oWjIqxt6Fyrd+6jIHMm4qf8iMrr7THl3SIb5rELaL/1b+66gnBaSFy2e2cRFCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=SWY5SYhR; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="SWY5SYhR"
ARC-Seal: i=1; a=rsa-sha256; t=1780676471; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c2gVAd+AnJGaN6TYTjc1TnhBIGG2wbzVMIovUqg6cKSG86wkDhbFTiiYHglsGA1Cf7WB0SHBHNlP+jVonq7bMwqs6DD26ydmcVmvpLl/RQ4dHwGLyLW41xCYwX56Z0Tp2RKdfO+ez+NZGMAr7B1rwJhSV8ipu88LZSR5oY617+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780676471; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eqQAbHQBhn6IEVAwLdXfkwpYKypYF2tyaUBjiXTwKk0=; 
	b=Q0rFsVENiZVdzZR5xmhewc/62CtiSjltpNlM6p4SVytFtXQlSRk8e47gIQbwyt5L2MR7m6Xr96D6vPYLlP11dQUdLwdq8aqHNCFW8rTtjKP50J+vXcF34KCYXMHwI1GrDVS/JN2xxi3RODVh/NDnBex7yu+QpVOK3QDdt98mcFk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780676471;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=eqQAbHQBhn6IEVAwLdXfkwpYKypYF2tyaUBjiXTwKk0=;
	b=SWY5SYhREsva8S2m3qyZ+GoRnaztPI1SyLWIgJVRCMSlbjXOiGA5S1ZMDmhXztnc
	z9qCFzpxeXqf6ttCdWNZ/raya2hmDB3Q0N9FCFnpJvIIppanFNNLCOpdpr+oSwVuAcw
	xwL/Sc7ebch7s1AvX19RbvGEa4SoGQIp3Oif7OO8=
Received: by mx.zohomail.com with SMTPS id 1780676469613586.1227167652726;
	Fri, 5 Jun 2026 09:21:09 -0700 (PDT)
Message-ID: <01f42b02-e050-401d-9b0f-f2b0fc6b8d23@zohomail.com>
Date: Sat, 6 Jun 2026 00:21:04 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Align interleave decode/encode helpers with their
 callers
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Purva Yeshi <purvayeshi550@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>
References: <20260605040801.865965-1-alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260605040801.865965-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227b893d6f643bb528ad121afde0000b88a71d1902fa482037bd14e282cbe5b15a39e2ac581720382:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/6/5 12:07, Alison Schofield 写道:
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

Reviewed-by: Li Ming <ming.li@zohomail.com>

Since the types are changed from 'unsigned int' to 'int', maybe we 
should drop the second parameter of these helpers in the future?

A negative return value indicates failure, other value is valid.

> ---
>   drivers/cxl/acpi.c        | 10 +++++-----
>   drivers/cxl/core/region.c |  4 ++--
>   drivers/cxl/cxl.h         |  6 ++++--
>   3 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 127537628817..3b818adbd38b 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -101,8 +101,8 @@ static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
>   	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>   	struct device *dev = ctx->dev;
>   	struct cxl_cxims_data *cximsd;
> -	unsigned int hbig, nr_maps;
> -	int rc;
> +	unsigned int nr_maps;
> +	int hbig, rc;
>   
>   	rc = eig_to_granularity(cxims->hbig, &hbig);
>   	if (rc)
> @@ -160,7 +160,7 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>   				 struct acpi_cedt_cfmws *cfmws)
>   {
>   	int rc, expected_len;
> -	unsigned int ways;
> +	int ways;
>   
>   	if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO &&
>   	    cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
> @@ -405,7 +405,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>   	struct cxl_cxims_context cxims_ctx;
>   	struct device *dev = ctx->dev;
>   	struct cxl_decoder *cxld;
> -	unsigned int ways, i, ig;
> +	int ways, i, ig;
>   	int rc;
>   
>   	rc = cxl_acpi_cfmws_verify(dev, cfmws);
> @@ -464,7 +464,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>   			if (rc < 0)
>   				return rc;
>   			if (!cxlrd->platform_data) {
> -				dev_err(dev, "No CXIMS for HBIG %u\n", ig);
> +				dev_err(dev, "No CXIMS for HBIG %d\n", ig);
>   				return -EINVAL;
>   			}
>   		}
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..61877483cbcd 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3060,7 +3060,7 @@ int cxl_validate_translation_params(u8 eiw, u16 eig, int pos)
>   		return -EINVAL;
>   	}
>   	if (pos < 0 || pos >= ways) {
> -		pr_debug("%s: invalid pos=%d for ways=%u\n", __func__, pos,
> +		pr_debug("%s: invalid pos=%d for ways=%d\n", __func__, pos,
>   			 ways);
>   		return -EINVAL;
>   	}
> @@ -3106,7 +3106,7 @@ EXPORT_SYMBOL_FOR_MODULES(cxl_calculate_dpa_offset, "cxl_translate");
>   
>   int cxl_calculate_position(u64 hpa_offset, u8 eiw, u16 eig)
>   {
> -	unsigned int ways = 0;
> +	int ways = 0;
>   	u64 shifted, rem;
>   	int pos, ret;
>   
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..66cb2293fec1 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -91,7 +91,7 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>   }
>   
>   /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> -static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
> +static inline int eig_to_granularity(u16 eig, int *granularity)
>   {
>   	if (eig > CXL_DECODER_MAX_ENCODED_IG)
>   		return -EINVAL;
> @@ -100,7 +100,7 @@ static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
>   }
>   
>   /* Encode defined in CXL ECN "3, 6, 12 and 16-way memory Interleaving" */
> -static inline int eiw_to_ways(u8 eiw, unsigned int *ways)
> +static inline int eiw_to_ways(u8 eiw, int *ways)
>   {
>   	switch (eiw) {
>   	case 0 ... 4:
> @@ -118,6 +118,7 @@ static inline int eiw_to_ways(u8 eiw, unsigned int *ways)
>   
>   static inline int granularity_to_eig(int granularity, u16 *eig)
>   {
> +	*eig = 0;
>   	if (granularity > SZ_16K || granularity < CXL_DECODER_MIN_GRANULARITY ||
>   	    !is_power_of_2(granularity))
>   		return -EINVAL;
> @@ -127,6 +128,7 @@ static inline int granularity_to_eig(int granularity, u16 *eig)
>   
>   static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>   {
> +	*eiw = 0;
>   	if (ways > 16)
>   		return -EINVAL;
>   	if (is_power_of_2(ways)) {
>
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
