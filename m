Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C79318B95;
	Tue, 17 Feb 2026 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367367; cv=none; b=nOxqwtnZv8LVWcKpzpUm5k9+jtAJ3wuakI09EtvbhC+R4pEWVIPYCEoV9zuhvrw455Lk07yAfJRTgKZy0Cgojz3TNuxHlbcyvrWSN9fhQVCKiEHA5fZBme4qfC4/RI2EnaN8fmRVgNrdwNup50ZDlSadcAdcA5mGiqKnpfnO+Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367367; c=relaxed/simple;
	bh=9vocwgJYiIdXWTL9liabZjq9k/+fVs1e8SLReE5gZuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yltkgu/BSmBFSEueiNA6S9eHwNRBQAZByQc57O4DYdsN4CSYNcWMFM8iliSHd/rPWVpQvmCC7gH4YFrCyqjcG3C6O1xSnCjo9osdlu7PsLXJwRwj/C+BKyjqeXqifD5PAyKwkFHhaySI3KL3ZgZXJzfe37e5QtjD4Yn+R2Gph7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDmShwH1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDmShwH1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771367365; x=1802903365;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9vocwgJYiIdXWTL9liabZjq9k/+fVs1e8SLReE5gZuI=;
  b=LDmShwH1eL6i9JjMkFG/EPLSBuJT8A992p/HPR2tDxRY5YAx6K5LKpbK
   dra+5e8qJ+VDK2JqfRt0GFby6dmII/vqV4SFLgnChqLnbcpldg4+3Oc2D
   714utdPDgGxyNykU8/unPN/cLkpfL/3yKUbY7h67qs5bZIkYFu3kFWqzL
   /o2iet1iLPMbZpJUPjdU6v3JFedMKawkmr8Y22fzHAJNCrEf4y9EzhmRv
   xaYbzso+jDW4EDyaMdJiXZcez9/H+kXEwzLN6U8Qwg3jbM/nGd6zR4cAi
   aXdS5IXQkdBHEV1R55UT9ljzpY7I8BLAekAQMA5lvGbAfVoDY3CFnKxcu
   Q==;
X-CSE-ConnectionGUID: Kla/LaBDQROOxFEBtXndQQ==
X-CSE-MsgGUID: afF4kZivTvWSyKMc/xOeYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="75046093"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="75046093"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 14:29:25 -0800
X-CSE-ConnectionGUID: 4psb9NDtQcCidMbOp7G7KA==
X-CSE-MsgGUID: WpuqMONpS1iL11abx9cAhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="218154517"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.138]) ([10.125.109.138])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 14:29:24 -0800
Message-ID: <24dad014-2f0e-4b1f-9307-94f59b201e06@intel.com>
Date: Tue, 17 Feb 2026 15:29:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: Avoid DVSEC fallback after region teardown
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>
References: <20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/26 3:38 PM, Smita Koralahalli wrote:
> After destroy-region, cxl_region_decode_reset() clears the HDM decoder
> registers (base/size/commit). If the memdev is subsequently bounced
> (disable/enable), port probe re-evaluates decoder capability via
> should_emulate_decoders().
> 
> The existing logic checks each decoder's COMMITTED bit. Since those bits
> are cleared by region teardown, should_emulate_decoders() incorrectly
> falls back to DVSEC range emulation, even though HDM capability is still
> present.
> 
> DVSEC fallback marks the endpoint decoder as AUTO, which triggers
> cxl_add_to_region() -> construct_region(). That path copies the default
> interleave_granularity (4096) into the region parameters. The resulting
> spurious autodiscovered region consumes the CFMWS HPA space and causes a
> subsequent create-region to fail in hpa_alloc().
> 
> Use the global CXL_HDM_DECODER_ENABLE bit instead of per-decoder COMMITTED
> bits to detect HDM capability. If the HDM decoder block is enabled, zeroed
> registers indicate teardown, not absence of HDM support. This prevents the
> unintended DVSEC fallback and subsequent region creation failure.
> 
> Based on cxl/fixes.
> base-commit: 8441c7d3bd6c5a52ab2ecf77e43a5bf262004f5c

This block should go under the '---'

DJ

> 
> Fixes: 52cc48ad2a76 ("cxl/hdm: Limit emulation to the number of range registers")
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/core/hdm.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index eb5a3a7640c6..a0718cbcc355 100644
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

