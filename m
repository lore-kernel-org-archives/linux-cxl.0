Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06BA3A1A5B;
	Mon, 30 Mar 2026 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774906521; cv=none; b=b4LYNOFk2t5BORfpBJ/g5JC0fNWF4bhSUw0vR/rbnHMvkqO9o1Zj2j4wQ1Xt8fiPPcTfJo29o+OHlipWTQkVmgXAblb1LMjJJ74q1RTVk2m/9bcgAldjKKTEBbL7cUq61e4nI5Tx2CJP23WfZRpZSz1BmLPfIZ/f9YkM8oH6Vzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774906521; c=relaxed/simple;
	bh=GiXx9OOVGkmZlcoKDDyou0j2GJivARNX9WHCLSnL9Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvx4PUADIkjJ9uojAymg1sBFTVucT5X/BcE0DWSbS/pZZ5NcHVYohQyZ401oe3XotvSoM3mq+/FzdpL8Lc91NeqkBHUJvvqm3bSGoLC64NfdTaHx8F5gn8UR6wX6zyuftoPgRbOjbuD7GjNmcZatU8gyGOzXSGZeY1L/+KuopJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNO5XLSl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNO5XLSl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774906520; x=1806442520;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GiXx9OOVGkmZlcoKDDyou0j2GJivARNX9WHCLSnL9Ww=;
  b=RNO5XLSlyPUfEp3QeJv0MZ+v3zYFx2pp4qmoeQMofpfS0HBm/MmQ6Aep
   bm+21dLaswqJLJ53MnQ/TcgFgAdZZjO6O7ACZF+SaEIfWfBlF08akdBtK
   EN8YAFrlX3qoQEUsljVPfdXy1xyBfHBZ/KSIQ0LLEsXIjG6oxHoaGzGNR
   d4I4rDCLNvOPc5Kdg4IOfYjVXKuyo0PL7rZITmyCBB4U8oJ3VQh5nvtLA
   YxwwRSTEUC5ErRTyxD4yOeCdYrwrGR8XnVSjNl4M0k/jle5mESV3kFYly
   IYa91Yfj0l6vg9lp+5hh94WRWEfPSb/nt4A6Wuf2026tkhbtOy/GFCL2x
   A==;
X-CSE-ConnectionGUID: NFJ1SZTiRGW6zvBucG2+iA==
X-CSE-MsgGUID: QAojMDg/SJug42ssPwrXaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75794671"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="75794671"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:35:20 -0700
X-CSE-ConnectionGUID: 6T4gE0Z/T1WPOjzlZMsyDg==
X-CSE-MsgGUID: xUgDDC2kT86P8kpS0s9QXg==
X-ExtLoop1: 1
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.4]) ([10.125.111.4])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:35:18 -0700
Message-ID: <a9b88efb-320c-4cfd-98d9-508a237c4444@intel.com>
Date: Mon, 30 Mar 2026 14:35:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/hdm: fix a warning in devm_remove_action()
To: Sungwoo Kim <iam@sung-woo.kim>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>
Cc: Dave Tian <daveti@purdue.edu>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260330130156.2212694-3-iam@sung-woo.kim>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260330130156.2212694-3-iam@sung-woo.kim>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/30/26 6:01 AM, Sungwoo Kim wrote:
> In the following race scenario, devm_remove_action() can be called
> before devm_add_action(), triggering a warning because there is no
> action to remove.
> 
> To fix this, __cxl_dpa_reserve() performs devm_add_action(). This
> extends the critical section that embraces cxled->dpa_res = res and
> devm_add_action(), so cxl_dpa_free() cannot observe dpa_res without
> the devres action.
> 
> task 1:
> cxl_dpa_alloc()
>   __cxl_dpa_alloc()
>     guard(&cxl_rwsem.dpa)
>     cxled->dpa_res = res;  ...(1)
>   devm_add_action()        ...(4)
> 
> task 2:
> cxl_dpa_free()
>   guard(&cxl_rwsem.dpa)
>   if (!cxled->dpa_res)     ...(2) pass, due to (1)
>     return 0;
>   devm_cxl_dpa_release()
>     devm_remove_action()   ...(3) warning, no action is added yet
> 
> Splat:
> 
> WARNING: ./include/linux/device/devres.h:160 at devm_remove_action include/linux/device/devres.h:160 [inline], CPU#0: syz.1.6464/25993
> WARNING: ./include/linux/device/devres.h:160 at devm_cxl_dpa_release drivers/cxl/core/hdm.c:290 [inline], CPU#0: syz.1.6464/25993
> WARNING: ./include/linux/device/devres.h:160 at cxl_dpa_free+0x2a4/0x320 drivers/cxl/core/hdm.c:572, CPU#0: syz.1.6464/25993
> 
> Fixes: cf880423b6a0 ("cxl/hdm: Add support for allocating DPA to an endpoint decoder")
> Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
> V1: https://lore.kernel.org/linux-cxl/20260309000810.2632065-2-iam@sung-woo.kim/
> V1->V2:
> - Let __cxl_dpa_reserve() handle devm_remove_action() to reduce
>   duplicated patches. (Thanks to Dan for the suggestion)
> - Make the comment concise (Reflect Dan and Alison's comments)
> - Make a warning log in a commit message concise
> 
>  drivers/cxl/core/hdm.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index cb5d5a047a9d..63bd0d5f31df 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -408,7 +408,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  
>  	port->hdm_end++;
>  	get_device(&cxled->cxld.dev);
> -	return 0;
> +
> +	/*
> +	 * Perform devres registration while holding cxl_rwsem.dpa so
> +	 * cxl_dpa_free() cannot observe dpa_res without a matching devres
> +	 * action.
> +	 */
> +	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);

With this function added the devm_add_action_or_reset(), I think it needs to be renamed to __devm_cxl_add_dpa_reserve().

DJ

>  }
>  
>  static int add_dpa_res(struct device *dev, struct resource *parent,
> @@ -499,16 +505,8 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  				resource_size_t base, resource_size_t len,
>  				resource_size_t skipped)
>  {
> -	struct cxl_port *port = cxled_to_port(cxled);
> -	int rc;
> -
> -	scoped_guard(rwsem_write, &cxl_rwsem.dpa)
> -		rc = __cxl_dpa_reserve(cxled, base, len, skipped);
> -
> -	if (rc)
> -		return rc;
> -
> -	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	return __cxl_dpa_reserve(cxled, base, len, skipped);
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, "CXL");
>  
> @@ -606,7 +604,8 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	struct resource *p, *last;
>  	int part;
>  
> -	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	lockdep_assert_held_write(&cxl_rwsem.dpa);
> +
>  	if (cxled->cxld.region) {
>  		dev_dbg(dev, "decoder attached to %s\n",
>  			dev_name(&cxled->cxld.region->dev));
> @@ -669,14 +668,8 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  
>  int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  {
> -	struct cxl_port *port = cxled_to_port(cxled);
> -	int rc;
> -
> -	rc = __cxl_dpa_alloc(cxled, size);
> -	if (rc)
> -		return rc;
> -
> -	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	return __cxl_dpa_alloc(cxled, size);
>  }
>  
>  static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)

