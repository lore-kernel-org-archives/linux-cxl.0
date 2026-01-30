Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C39322C6D;
	Fri, 30 Jan 2026 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769789797; cv=none; b=kHO+S35NeZVeNjZ/lay+EHOVTimYyqGpGBlyffSjjbRAW+MES3qHdkit04w/kb0Ko8rrojU4FXtufy2gxWYS5LUwBMEmuIqPIzrzuWDQSTDxIdK/svu6NRF7AFHkjLkN5ct170BJprZY2qqjw2PrJTcv4nyap0FNMJC0HX02fcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769789797; c=relaxed/simple;
	bh=a08R7At14iLETkJhDRZv2x/762OKRpDrVK1IpmHtzgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPse6eRG1knyBqnwEUTt/U0oZ6hbj0+/XnuLB+Qvl3VFTaX5AD02FGopDTzIVNeLg8ISdMEimSBfvy5ac5dA0L1aLNrFJPUPD+eh7EEZQJ4l1nzNHCBovfEK779dnFuAhmTm99mDh76gPGBYYaToOzL7YY3PzR/uzHSbwxZkcH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjGyUj+p; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjGyUj+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769789796; x=1801325796;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a08R7At14iLETkJhDRZv2x/762OKRpDrVK1IpmHtzgo=;
  b=kjGyUj+pTqBI4uYzRYuJPrvO6+4Bt5+nORNXvA/JiV6CV7hnmyX9f3rQ
   5SZgA7Sw+GvPX8bS1Fy9QoU/80z6ie8yKYR7+ILzgdU3lxgJ+7QmdFD/T
   UvoSBn83QlwHpazDeD5l8kicHdXniKyd1T0K+CJZPZ0pBhAg++5nZKap6
   VrEUhV95DgWq0j7paVrCmAr68mnyvQIu50EuDRUgY/QrfswwKXroExHV0
   B1LhXAkaF5/BjmmenOmg6y2S0Be2MKf6ggBIsacm6Z3UlWqlPkfu9wKXn
   8Yq4PltWIGKQ4HQX9Z0WSeSOqE07zl91VAShGVg1QlPy6JFK1lOGquWf0
   g==;
X-CSE-ConnectionGUID: 0rkV4LZQTW6f3D/YHMGiKg==
X-CSE-MsgGUID: dR++IHq8SM6hVnzMskXDCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82466407"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="82466407"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 08:16:35 -0800
X-CSE-ConnectionGUID: aXC/XQP+TTWeDmHdsroEHg==
X-CSE-MsgGUID: z9psR/C0TACmj6KNb06Xvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="208007516"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.110.67]) ([10.125.110.67])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 08:16:35 -0800
Message-ID: <fbdd48cb-3ae4-453d-8447-4261c2b725fa@intel.com>
Date: Fri, 30 Jan 2026 09:16:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Fix premature commit_end increment on decoder commit
 failure
To: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: ming.li@zohomail.com, rrichter@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Huang Ying <ying.huang@linux.alibaba.com>
References: <20260129064552.31180-1-yuxiong.wang@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260129064552.31180-1-yuxiong.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/28/26 11:45 PM, Yuxiong Wang wrote:
> In cxl_decoder_commit(), commit_end is incremented before verifying whether the
> commit succeeded, and the CXL_DECODER_F_ENABLE bit in cxld->flags is only set
> after a successful commit. As a result, if the commit fails, commit_end has been
> incremented and cxld->reset() has no effect since the flag is not set, so commit_end
> remains incorrectly incremented. The inconsistency between commit_end and
> CXL_DECODER_F_ENABLE causes failure during subsequent either commit or reset
> operations.
> 
> Fix this by incrementing commit_end only after confirming the commit succeeded.
> Also, remove the ineffective cxld->reset() call. According to CXL 3.2 Spec 8.2.4.20.12
> Committing Decoder Programming, since cxld_await_commit() has cleared the decoder
> commit bit on failure, no additional reset is required.
> 
> Fixes: 176baef ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
> Acked-by: Huang Ying <ying.huang@linux.alibaba.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/next
7b6f9d9b1ea05c9c22570126547c780e8c6c3f62

> ---
> Change log:
>  * Added CXL 3.2 Spec 8.2.4.20.12 Committing Decoder Programming statement. Thanks
>    Alison.
>  * Collected reviewed-by. Thanks Dave and Alison.
> RFC Link: https://lore.kernel.org/linux-cxl/aXqKC-bscufh1ggq@aschofie-mobl2.lan/
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

