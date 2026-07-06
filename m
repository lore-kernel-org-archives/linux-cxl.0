Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCAA3AB496;
	Mon,  6 Jul 2026 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359211; cv=none; b=V4h9IDpVkIULecTNBoHgihuexSxzKr5TcFCe1QDjFhmjzH27zW/WILZ3FeC3voQm0h0v33fTgX1JgubqVf7c3Re3XUPW4C7lSsxO5DORHkrmxPtYA6u2VREGiFP+TKh/iuenu/thLkodY0/OqWtA58sUIEHxdkrYmSRKDYmzOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359211; c=relaxed/simple;
	bh=Zn/stTFn0QaLbaG/id/Q79JL6pSBsxEMKR46vJrdOfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lt/SIwoOtu4UlBSdmaFCeRxSyGW7a3twXM6lbcFmS30/vEGmPBDcWntyFyDcjrMvmwLjELj7yX3ZujDFwQL1kgbeSzK9oVaa42M6PPFtz6YzRnOOVKi3zWrCI42bDr2QFdgIvN/bQQ77m+Jfo92HD5CFu8Osjrg298f8CpQ/TYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpAIRjST; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpAIRjST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783359210; x=1814895210;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zn/stTFn0QaLbaG/id/Q79JL6pSBsxEMKR46vJrdOfU=;
  b=LpAIRjSTvcjTGIky2c+w266UUOALVA+hgnHC8Y9AuOkxj1KRoU3EMnQv
   Um26bPvJSwZAce7CjXO4xdYAJlu21lgQW9JwSTO9NxoGPcNqqVs5EEFrv
   L4slaezYYxgb4WxmY/2D6U4qVI2mjs+67aYKOZgkRDpEHzm4QwAXL1lco
   s6Zyg6Tc0cDos8+W3rxKPdwWLq4P6BguF+IpvowFrDzONhsb3wUFyhlC1
   F4Q9kriI+KGLTjOGffztBxha9wCHB0oDYZCzhaJfSsac1xDD9tXucMvCL
   Sl3CxPWMe4f0RkGEl1bHYCh92TCyP9VlKk3o8fZiYcBajPwESrKPf9HjZ
   w==;
X-CSE-ConnectionGUID: W8v2RfDjTH+/COthTD2+Uw==
X-CSE-MsgGUID: VQYVsxSPTJe/SckGmXHAWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="83773219"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="83773219"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 10:33:30 -0700
X-CSE-ConnectionGUID: HljJXmkUSumvNmZ17Kvh0A==
X-CSE-MsgGUID: LZMOchDUSAenK+PRsdOaow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="257350372"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.202]) ([10.125.110.202])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 10:33:28 -0700
Message-ID: <aa5d1efd-9492-46c2-96d5-0a0e1be9d204@intel.com>
Date: Mon, 6 Jul 2026 10:33:27 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] cxl/memdev: Don't overwrite the error from an
 earlier partition poison query
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, mochs@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260702090849.47501-1-icheng@nvidia.com>
 <20260702090849.47501-6-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260702090849.47501-6-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/2/26 2:08 AM, Richard Cheng wrote:
> cxl_get_poison_by_memdev() queries Get Poison List per partition but
> never checks the result inside the loop, so a later partition's success
> overwrites an earlier partition's failure and the whole scan reports
> success while that partition's poison went unlisted. Before the loop
> conversion the PMEM query returned early on error. Stop the loop on any
> error not already tolerated as a RAM -EFAULT.
> 
> Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
> Changelog:
> 
> v1->v2:
>     - New added patch ( sashiko-bot's report )
> ---
>  drivers/cxl/core/memdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 33a3d2e7b13a..8718964b9c5e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  		 */
>  		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
>  			rc = 0;
> +		if (rc)
> +			break;
>  	}
>  	return rc;
>  }

