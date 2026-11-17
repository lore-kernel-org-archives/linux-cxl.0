Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932717;
	b=tK8ZlQDO+ZL4EFyUVXs5nRmeU/+Atphc5rmd3eL1OFFg5VgbgbmaJJIG0rlyeMzGG/ph
	 Q3gG/fSpOEm9HAKy25tm5N7GG23tKr3C/Kuq+PlHSIn9IwiTyd0s119YIA49DoMG4vmp/
	 vfHbqCV4Ge62cOyMQw+nLPNbo03q5HvItwX12H9iYVmVgZG/hboBFLDlp96QcE3mRxqCq
	 Prn3vFUMCqCpIXNydi7ppaXBo+Olg6MoeB4sxtSZc/iSCT+2qMmSUrDhHOjGmV1Obug+u
	 8R3tnMBtj8Nc6a88UaO7/lghhmHr5vcVWB3HFJFY8VJTkIujXO3raR3HVPxHiB/ZEng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932717;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:From:Content-Language:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TYGnqxjRx4EgMpoxNW1utg52fdmYHWxLBJJI5WVomwQ=;
	b=d9Z+gWIxhDlhnE0pk9nLiF64OS9Z+RjHOYC7qem9d914x4VwqgQW9ohvCwZu/C4ncJCr
	 mNqMWR83DsWBiJ3eKKYS3yh+hsJDOrlhAj1VUQjBd2ZfGDrwTHDIKEbMBuvxKIv1qEA1D
	 ejEtbU2yo2/fu3tIBZCeYIg070rO2iFRPOKt548QCG2InM/6TZ6qCXeBn+lUwrsKEvD6m
	 xWMmzJJsDDlplh7luvv8cS8sbLYPniTwr1jct6zqR5M5tfItzqwWDzecVoNvWgFJPKTDw
	 emaxml9zYgQtR7K53YqjOYyiT5fo8E9t3wQCtNvgS/2N+EJO2KJibXlmHpuURjOpKKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cY73tynu;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC0606A32C
	for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2026 16:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BDC0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cY73tynu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794932717; x=1826468717;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=wsgR2cqSqtbSqm68RhcS4M7xz88i9IbIG8gHzV1H/9o=;
  b=cY73tynuRI+G7cPvGU58QsEmzj4s30ubHj2F6+IZMBLfuhtth4GaqHfi
   9RsT6Mhw0j6Zui2owsu1g/ftq+vT7BuKIdYhn0PNqXkz2ZgvtsNDNRNzu
   X+Q8Ac7vx4GfupezNV79wlV1wXPAjyfWnXPnRQbN6GDbpt/HsqMBdUo9J
   stsktQrw4z38IOjJflc+Z0leJmKKb8utwcvSLzwaZTIXWSNgfssraF+v+
   C3fbnqVVdcQEbnSRFFHwsXNYHzaFbT06yDTodCA0aMnLxDp0fXEa1b0TJ
   LBflV6SIy2vuIyHG9NeJ8douPlaX7EOg46AZ+Qv6sEASIR/oJ5nTvNHI3
   w==;
X-CSE-ConnectionGUID: IXfHMXjETJ+xkzADWpBulg==
X-CSE-MsgGUID: j4x0gMLjTCCCSPtz5rckEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3611753"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3611753"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:25:17 -0800
X-CSE-ConnectionGUID: c1VZSMoAQTiHwm+uyRbViQ==
X-CSE-MsgGUID: n84nhriiTgejkbJbKbLhuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10196757"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.197]) ([10.125.108.197])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:25:16 -0800
Message-ID: <64d46a46-6d68-419c-998b-c8a3f494c7eb@intel.com>
Date: Tue, 17 Nov 2026 09:25:15 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ndctl PATCH v3 2/3] cxl/region: allow region granularity finer
 than the root
To: Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org
References: <cover.1791863817.git.alison.schofield@intel.com>
 <263b128ca78071b0484533813ed7d75b9b81c294.1791863817.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <263b128ca78071b0484533813ed7d75b9b81c294.1791863817.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/12/26 9:14 PM, Alison Schofield wrote:
> cxl_region_determine_granularity() rejects any user-supplied granularity
> that does not exactly match the root decoder's granularity, making it
> impossible to create a region with a granularity finer than the root from
> userspace even when the kernel driver accepts it.
> 
> Relax the check to allow region_gran <= root_gran. This function only needs
> to reject what it can determine on its own is always wrong - a region
> granularity greater than the root decoder's. The kernel does the rest of
> the validation.
> 
> Reject a granularity that is not a power of two, or is below 256, since the
> previous exact-match test that screened those out implicitly is now gone.
> 
> Update the cxl-create-region man page to document the new behavior.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  Documentation/cxl/cxl-create-region.txt | 21 ++++++++++++++++-----
>  cxl/region.c                            | 25 +++++++++++++++++++------
>  2 files changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/cxl/cxl-create-region.txt b/Documentation/cxl/cxl-create-region.txt
> index b244af60b8a6..131fb069fd53 100644
> --- a/Documentation/cxl/cxl-create-region.txt
> +++ b/Documentation/cxl/cxl-create-region.txt
> @@ -93,11 +93,22 @@ include::bus-option.txt[]
>  
>  -g::
>  --granularity=::
> -	The interleave granularity for the new region. Must match the selected
> -	root decoder's (if provided) granularity. If the root decoder is
> -	interleaved across more than one host-bridge then this value must match
> -	that granularity. Otherwise, for non-interleaved decode windows, any
> -	granularity can be specified as long as all devices support that setting.
> +	The interleave granularity for the new region. A granularity coarser
> +	than the root decoder's is never legal. If the root decoder is
> +	interleaved across more than one host bridge, then for a given number
> +	of ways at most two granularities are legal:
> +
> +	  * "root_ways * root_granularity / ways", which creates a region
> +	    finer than the root. The root interleaves at its own coarser
> +	    granularity and the levels below it, host bridges and switches,
> +	    refine monotonically toward the region granularity.
> +	  * The root decoder granularity itself, which repeats the root
> +	    interleave pattern across a wider region. This is available only
> +	    when the root decoder ways are a power of two.
> +
> +	The two coincide when the region ways equal the root decoder ways. For
> +	non-interleaved root decoders, any granularity can be specified as
> +	long as all devices support that setting.
>  
>  -d::
>  --decoder=::
> diff --git a/cxl/region.c b/cxl/region.c
> index 9d727216b9b8..69421771ad10 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -620,6 +620,18 @@ static int cxl_region_determine_granularity(struct cxl_region *region,
>  	if (!p->granularity)
>  		return granularity;
>  
> +	/*
> +	 * The CXL specification defines interleave granularities of 256 through
> +	 * 16K in powers of two. Reject anything else here, rather than leave the
> +	 * user with a bare EINVAL from the kernel.
> +	 */
> +	if (p->granularity < 256 || !is_power_of_2(p->granularity)) {
> +		log_err(&rl,
> +			"%s: granularity (%d) must be a power of 2, 256 or greater\n",
> +			devname, p->granularity);
> +		return -EINVAL;
> +	}
> +
>  	ways = cxl_decoder_get_interleave_ways(p->root_decoder);
>  	if (ways == 0 || ways == -1) {
>  		log_err(&rl, "%s: unable to determine root decoder ways\n",
> @@ -632,15 +644,16 @@ static int cxl_region_determine_granularity(struct cxl_region *region,
>  		return p->granularity;
>  
>  	/*
> -	 * For ways > 1, only allow the same granularity as the selected
> -	 * root decoder
> +	 * For ways > 1, allow any region granularity up to and including the
> +	 * root decoder granularity. The kernel validates a finer region
> +	 * granularity, and a coarser one is always invalid.
>  	 */
> -	if (p->granularity == granularity)
> -		return granularity;
> +	if (p->granularity <= granularity)
> +		return p->granularity;
>  
>  	log_err(&rl,
> -		"%s: For an x%d root, only root decoder granularity (%d) permitted\n",
> -		devname, ways, granularity);
> +		"%s: region granularity (%d) cannot exceed root decoder granularity (%d)\n",
> +		devname, p->granularity, granularity);
>  	return -EINVAL;
>  }
>  

