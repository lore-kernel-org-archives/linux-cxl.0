Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5F22848A7;
	Tue, 27 Jan 2026 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769546833; cv=none; b=AdNDZLGxmb4MVLhWnHoljgHs7ebm0hBqA7D4TogbeMEwNheE8WCem5nvo2yPho+Lvouy17waRQnbHO2df8p4VC1Mk1CiR8Ag69KrGSe0QLXOTY2BbUYQEBdcVyZrwR/mFEp7/b4TNcp34F8tr9zg2e/DQd8KJ+6Wm7TnCH9sbnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769546833; c=relaxed/simple;
	bh=d0MXaxKLKrXpq8JUClectJZLB+ingvdenunr1sxm5mU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzwIDR/aGSgmX4lKNwLnamM8fJ/DM4ZzE/ffB2SykUon+6TLvIL+ZhoEQ07rJ3BHUXeekDhAHqy/IRhOiR4nrsaRcX9/t8yAhvgBcu+n3zN7hRejJEB/ZJFp5h835T2VJ9ctxY0wOZG62rdLTManbFGjxa3QYz/LoNXLjjrMaK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aEM/kx8E; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aEM/kx8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769546831; x=1801082831;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d0MXaxKLKrXpq8JUClectJZLB+ingvdenunr1sxm5mU=;
  b=aEM/kx8EL0tFHJEcktvgD5AcVuN3ADbJc6pfL0dVSbnlLbTxoTQEGLML
   OxO4zZBKPv6FBLfU9ow0SybQu0e84NJrU1Y3PlWYktS0fiL5glAWRwta4
   m0ZdTt9HzemUlCR7apbogbg0LPv3kmEP+BfOYbf2yrULcIPHUDx9aga+c
   UR4ah9DZpMU6RxP/A6ArRtRKo6f8wOLxNVT4icLJmdaITmvKeuXThx2yq
   wocH76RAaQA1RwKVVfY8ZfgIc6PFsJkd6tWc90CgrtN1gViINsytUYQhb
   etguwoKAw0dFnILXsIspNYltXiK/8sXBNbdOJezwJ6EX0ewod9EKKaT6Q
   Q==;
X-CSE-ConnectionGUID: ubaPL9pJSWC2W3KaB25Rag==
X-CSE-MsgGUID: WglJhKfPSaOIGaq3XhHK0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="73343177"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="73343177"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 12:47:10 -0800
X-CSE-ConnectionGUID: pWr3k2DaTLuO0yPYHQ7s3A==
X-CSE-MsgGUID: S8BD75qzQvKDhS4aNcy9sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212539700"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.136]) ([10.125.109.136])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 12:47:09 -0800
Message-ID: <421d75a1-75be-49d4-b7bc-6db16cc8fb7f@intel.com>
Date: Tue, 27 Jan 2026 13:47:08 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: Fix premature commit_end increment on decoder
 commit failure
To: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: ming.li@zohomail.com, rrichter@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Huang Ying <ying.huang@linux.alibaba.com>
References: <20260127084855.66916-1-yuxiong.wang@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260127084855.66916-1-yuxiong.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/27/26 1:48 AM, Yuxiong Wang wrote:
> In cxl_decoder_commit(), commit_end is incremented before verifying whether the
> commit succeeded, and the CXL_DECODER_F_ENABLE bit in cxld->flags is only set
> after a successful commit. As a result, if the commit fails, commit_end has been
> incremented and cxld->reset() has no effect since the flag is not set, so commit_end
> remains incorrectly incremented. The inconsistency between commit_end and
> CXL_DECODER_F_ENABLE causes failure during subsequent either commit or reset
> operations.
> 
> Fix this by incrementing commit_end only after confirming the commit succeeded.
> Since cxld_await_commit() clears the decoder commit bit on failure, no additional
> reset is required. Remove the ineffective cxld->reset() call in this case.
> 
> Fixes: 176baef ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
> Acked-by: Huang Ying <ying.huang@linux.alibaba.com>

Looks the correct fix to me.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/hdm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index eb5a3a7640c6..912f648a6b7a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -844,14 +844,13 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
>  		setup_hw_decoder(cxld, hdm);
>  
> -	port->commit_end++;
>  	rc = cxld_await_commit(hdm, cxld->id);
>  	if (rc) {
>  		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
>  			dev_name(&cxld->dev), rc);
> -		cxld->reset(cxld);
>  		return rc;
>  	}
> +	port->commit_end++;
>  	cxld->flags |= CXL_DECODER_F_ENABLE;
>  
>  	return 0;

