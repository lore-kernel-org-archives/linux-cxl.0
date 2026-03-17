Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BBD8462;
	Tue, 17 Mar 2026 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706105; cv=none; b=DJ4eelFxSGbBxvDUjMIbKI0YzXwCiTiCErA0ODLIeZrymgqnkw9fpTbxoCScykbVj2wtRJY2swrZemb/YzbawZ+yl28TAgh1EeJ4yDOZfq8jCuSz2niIcQMwJcwTj/no71LpHpUV1W+V2Trq5nMlFf06Au7KqjLxybaXD2hRIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706105; c=relaxed/simple;
	bh=JXTwf4yA/GvpO722Dl0m1S9QRMo1Th4+HVw+KsHAEXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0ZOzdNVWzRVbQVR5/aaXdbbI+DiWNIjyLBwu3nZpR6igW+Fqj6SWN2sOk7PmkT6J7AiSgY0p49dv5vJaqVeAbqWrHr7moDc9ZaWfiGo4PspmU0LMuWHl7qOccEbQtIesuU2xt1beKYKhtPHhw3CNIkplT4xquvs/dhGHvofz8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1auCEyS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1auCEyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773706103; x=1805242103;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JXTwf4yA/GvpO722Dl0m1S9QRMo1Th4+HVw+KsHAEXA=;
  b=H1auCEySj0DQ0Hg2NIs1MQjA18VYlAxKvXWParGphkME06HfpiyTz634
   nsCxi8jglMX/62tdYIVAw+nG6Y1pHJcF84pv+FirXnZrVjrRGCKnebZsm
   /Gdlhxy8FPvSMH08xGxSnS79XibfwIrNzmvROC1MU+z52pDCvEcdsnbQT
   BQ6L+vLhJu0McpA9blQOX8gsvgYDkgKhBPRMfdblfmWczO5Kl+O2CHfIJ
   Xu+D+XTQ05oHKHRG1CzBSJ8/ikrhGJQiLncnGJ8KZBzhNqBR9eFnLyhFI
   QRV43risQFvfclP6rVgY7R/lySR3E0eunS0II9DxZAqr4oRW/DHvdoAtj
   Q==;
X-CSE-ConnectionGUID: k2HV9d8RQfK6guk6M6Sy8w==
X-CSE-MsgGUID: wSELVP+MQ+2eaKy+ugZqag==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85429534"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85429534"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 17:08:23 -0700
X-CSE-ConnectionGUID: Se/9/dwkTlWBAGhDsZWfiQ==
X-CSE-MsgGUID: xk+KbCFsTOaWcPLiAEHDNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226531343"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.111]) ([10.125.108.111])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 17:08:22 -0700
Message-ID: <d87ff3d2-de30-4c47-8f47-3633507b4e48@intel.com>
Date: Mon, 16 Mar 2026 17:08:21 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/hdm: Avoid incorrect DVSEC fallback when HDM
 decoders are enabled
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>
References: <20260316201950.224567-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260316201950.224567-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/16/26 1:19 PM, Smita Koralahalli wrote:
> Check the global CXL_HDM_DECODER_ENABLE bit instead of looping over
> per-decoder COMMITTED bits to determine whether to fall back to DVSEC
> range emulation. When the HDM decoder capability is globally enabled,
> ignore DVSEC range registers regardless of individual decoder commit
> state.
> 
> should_emulate_decoders() currently loops over per-decoder COMMITTED
> bits, which leads to an incorrect DVSEC fallback when those bits are
> zero. One way to trigger this is to destroy a region and bounce the
> memdev:
> 
>   cxl disable-region region0
>   cxl destroy-region region0
>   cxl disable-memdev mem0
>   cxl enable-memdev mem0
> 
> Region teardown zeroes the HDM decoder registers including the committed
> bits. The subsequent memdev re-probe finds uncommitted decoders and falls
> back to DVSEC emulation, even though HDM remains globally enabled.
> 
> Observed failures:
> 
>   should_emulate_decoders: cxl_port endpoint6: decoder6.0: committed: 0 base: 0x0_00000000 size: 0x0_00000000
>   devm_cxl_setup_hdm: cxl_port endpoint6: Fallback map 1 range register
>   ..
>   devm_cxl_add_region: cxl_acpi ACPI0017:00: decoder0.0: created region0
>   __construct_region: cxl_pci 0000:e1:00.0: mem1:decoder6.0:
>   __construct_region region0 res: [mem 0x850000000-0x284fffffff flags 0x200] iw: 1 ig: 4096
>   cxl region0: pci0000:e0:port1 cxl_port_setup_targets expected iw: 1 ig: 4096 ..
>   cxl region0: pci0000:e0:port1 cxl_port_setup_targets got iw: 1 ig: 256 state: disabled ..
>   cxl_port endpoint6: failed to attach decoder6.0 to region0: -6
>   ..
>   devm_cxl_add_region: cxl_acpi ACPI0017:00: decoder0.0: created region4
>   alloc_hpa: cxl region4: HPA allocation error (-34) ..
> 
> Fixes: 52cc48ad2a76 ("cxl/hdm: Limit emulation to the number of range registers")
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Smita,

Applied to cxl/fixes
75cea0776de5 cxl/hdm: Avoid incorrect DVSEC fallback when HDM decoders are enabled

Any chance to add the issue reproduce steps to a regression test script in CXL CLI test please? Thanks!

> ---
> v2:
>   Reworded commit message to focus on root cause per Dan's feedback.
>   Dropped downstream details (IG/construct_region/hpa_alloc)
>   Added error signatures.
>   Link to v1: https://lore.kernel.org/r/20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com
> ---
>  drivers/cxl/core/hdm.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index c222e98ae736..cb5d5a047a9d 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -94,7 +94,6 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  	struct cxl_hdm *cxlhdm;
>  	void __iomem *hdm;
>  	u32 ctrl;
> -	int i;
>  
>  	if (!info)
>  		return false;
> @@ -113,22 +112,16 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  		return false;
>  
>  	/*
> -	 * If any decoders are committed already, there should not be any
> -	 * emulated DVSEC decoders.
> +	 * If HDM decoders are globally enabled, do not fall back to DVSEC
> +	 * range emulation. Zeroed decoder registers after region teardown
> +	 * do not imply absence of HDM capability.
> +	 *
> +	 * Falling back to DVSEC here would treat the decoder as AUTO and
> +	 * may incorrectly latch default interleave settings.
>  	 */
> -	for (i = 0; i < cxlhdm->decoder_count; i++) {
> -		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
> -		dev_dbg(&info->port->dev,
> -			"decoder%d.%d: committed: %ld base: %#x_%.8x size: %#x_%.8x\n",
> -			info->port->id, i,
> -			FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl),
> -			readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i)),
> -			readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i)),
> -			readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i)),
> -			readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i)));
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> -			return false;
> -	}
> +	ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	if (ctrl & CXL_HDM_DECODER_ENABLE)
> +		return false;
>  
>  	return true;
>  }
> 
> base-commit: 93d0fcdddc9e7be9d4f42acbe57bc90dbb0fe75d

