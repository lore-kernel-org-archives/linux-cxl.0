Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFAE334C25
	for <linux-cxl@vger.kernel.org>; Fri,  7 Nov 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537928; cv=none; b=BJRjKl4ssfccbnLvDTBF4i6VkUWtJTUtb63dymB7TFR/nNjb4TvI78VM4owRfArhqLzfPDp+CCGyul31mkJJUObqH538wmXSM5GPKrlT6FDsu+4SPRI1lOCHVKtVXqwIe2nnL9BTasrwNAIat49lWq8yEnTru3G9WoIz4xcQ5+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537928; c=relaxed/simple;
	bh=SGeRjMu9S3QJWRyWTNIJ9+7YYwIQQ1GTDcfXWFqHol8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dg9yFFWxa0KS0xttdVLWj8KppqfXnLc3EGUtr2m3WQOeQpCHGMdGG8CBWy/+7cBVzPFPLFf/qrP0Wk+kdy5Wo3xuRFkIUB7LGaT4oHGzdNm8FtVclCKvRgQ6+zdRXAtC3938i1KGH4GorfxEe7nJo8Q/uNyrb65xqajQES45yw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaWXYzcs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaWXYzcs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762537928; x=1794073928;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=SGeRjMu9S3QJWRyWTNIJ9+7YYwIQQ1GTDcfXWFqHol8=;
  b=SaWXYzcs3MDAv1rDhrBns6qCyIV5oMcjoGFYC528MU4QBxADkfV26X02
   UGfMGek6vpI2PIKEFQyBZ7fizqo25+SiSeYhTFJ4/QkN7oA3j4ce0kPAJ
   kBT0AKCx8n7lfutl4KcSkoLFR/49UW4IsIgE/PYQIFygq6ear/tE8edbH
   a49tL5okaZhqdlvNvsTcBPP0Dwe63YZZ8BRtdOEYMsilMHdARCZIIiQNr
   Gfsr5ECyZr+u4REVIA6C9s9U5240oSwdwmnmBIPTn4IHoV2eK7Wtxe39K
   qfPhl0u3Pns8qRvuK0CxonoKABMW7zSQoFZtyiE6rGUNnVl9Royur7kBF
   g==;
X-CSE-ConnectionGUID: qTEY0bLSRIaAcCMhT3hOcg==
X-CSE-MsgGUID: oppdgCl4RsanDqg8tNJ0sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64598711"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64598711"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 09:52:07 -0800
X-CSE-ConnectionGUID: JN/PyAZkSWOqW7+SaxQhdA==
X-CSE-MsgGUID: 8sskFmDASi2t/k7vqnRstQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="187345984"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.112]) ([10.125.111.112])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 09:52:06 -0800
Message-ID: <e5cde8e3-2a48-4bb9-b28c-cdbf5b328360@intel.com>
Date: Fri, 7 Nov 2025 10:52:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cxl: Adjust offset calculation for poison injection
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20251031173224.3537030-1-dave.jiang@intel.com>
 <20251031173224.3537030-5-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251031173224.3537030-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/25 10:32 AM, Dave Jiang wrote:
> The HPA to DPA translation for poison injection assumes that the
> base address starts from where the CXL region begins. When the
> extended linear cache is active, the offset can be within the DRAM
> region. Adjust the offset so that it correctly reflects the offset
> within the CXL region.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

This specific patch is applied to cxl/fixes
b6cfddd26ec55e865b4715f73e9bbb17a15091ed

> ---
>  drivers/cxl/core/region.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 095f5dcd17a1..eaf085aa44c4 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3731,6 +3731,7 @@ static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
>  	if (validate_region_offset(cxlr, offset))
>  		return -EINVAL;
>  
> +	offset -= cxlr->params.cache_size;
>  	rc = region_offset_to_dpa_result(cxlr, offset, &result);
>  	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
>  		dev_dbg(&cxlr->dev,
> @@ -3763,6 +3764,7 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>  	if (validate_region_offset(cxlr, offset))
>  		return -EINVAL;
>  
> +	offset -= cxlr->params.cache_size;
>  	rc = region_offset_to_dpa_result(cxlr, offset, &result);
>  	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
>  		dev_dbg(&cxlr->dev,

