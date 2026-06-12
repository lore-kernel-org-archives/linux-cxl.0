Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8D2DB795;
	Fri, 12 Jun 2026 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781229241; cv=none; b=pxFtCUZ9WZFGbAIEXX/gbj9CliVNiYt2LZkknEGdLH8rXaQX66ZI6WQOXhSNkIXmuRNjrFzROTWd+kCAzCvwJGWr0mmQGdZAd/I+DexQl5F7zn0RPFiiWSTtdcjb+sEl8iCFH0nwE/LS8y+QgYQiEnkTBAmreLAGTl74QKsOjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781229241; c=relaxed/simple;
	bh=qJz0ufZ6nuCVo6x3zNaFpBI8suvK8qFXxUqw1Tinvgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkJs9nZtxU9eSmp+PsITjd0s03X4D4WcCFUIrpWeQ9mIkTwdxGumcabj2VYd1mHNIuSlgaqlTfbwx1arxy4PdhmbirZG1poy72U4EX49CaIuCUUxnVAL7eajntby2WMh/HKxEriG9D9MUoq2wr34dcVybEfqfXpA0wvVEtIqgR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K2NANqeo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2NANqeo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781229240; x=1812765240;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qJz0ufZ6nuCVo6x3zNaFpBI8suvK8qFXxUqw1Tinvgk=;
  b=K2NANqeoR2TnwWI2ECIJe41BUb75RbIDfsviZIfLDZaPOztgAUYhCVtc
   yaTweL8ym4NBogZQFOP5QZMcirgL+mlfctpIJrefagHeBJhK1zQZqRVu6
   ydq2JdZpwHWxkA5IjYmE/Do7CXnML0sRa0Ax/bR3mmbvMi/JD0Jh6oRnN
   vY27JPgCNptHqcjZWeqEi9l3+hrhqhfu9H/XSDvY/B3BeCiPCModCSkl0
   4URh8+Rcu2xWJaJG1osFE00LRmejZcEMhpuGi9GHshpIGQlQc7aBvrf5V
   T37MLPYjYCUndIH9K0riYqGGkklsyss63DykVwDV4MX8D+P2SY4F8AKGf
   w==;
X-CSE-ConnectionGUID: EtB5Jw4oSaqrxLz1rgN5jQ==
X-CSE-MsgGUID: 8clIKOtISb+TL07v28fBRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81965990"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81965990"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:53:59 -0700
X-CSE-ConnectionGUID: JvgcCuHMS8S4FDyDg3cTIw==
X-CSE-MsgGUID: 5k0loyq6T0Go1eWWRUYMwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="250614435"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.105]) ([10.125.110.105])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:53:57 -0700
Message-ID: <f678ebb7-ec1b-4e48-b0ed-d223566ffe7e@intel.com>
Date: Thu, 11 Jun 2026 18:53:56 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] tools/testing/cxl: Resolve auto-region decoder
 targets like real HW
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 djbw@kernel.org, shiju.jose@huawei.com, ming.li@zohomail.com
Cc: alucerop@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260612011227.4220-1-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260612011227.4220-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/11/26 6:12 PM, Richard Cheng wrote:
> The mock auto-region created at module load wrote switch and host-bridge
> decoder target[] directly, in addition to target_map[]. Real HW programs
> only target_map[] and resolves target[] as dports enumerate, via
> update_decoder_targets(). Region replay already follows that ordering,
> the initial auto-region did not.
> 
> Drop the direct target[] writes and call
> cxl_port_update_decoder_targets() so target[] is resolved the same way
> as real HW and region replay, exercising more of the auto-region driver
> path.
> 
> This is inspired by the discussion [1] below:
> 
> [1]: https://lore.kernel.org/all/20260521084806.28232-1-icheng@nvidia.com/
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Dave Jiang <dave.jiang@intel.com>

> ---
> cxl_mock_mem didn't load together when I manually modprobe cxl_test
> module, should we make them loaded together automatically for better
> user experience?
> 
> Best regards,
> Richard Cheng.
> ---
>  tools/testing/cxl/test/cxl.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 418669927fb0..5266aa3733cb 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1181,15 +1181,11 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  		cxlsd = to_cxl_switch_decoder(dev);
>  		if (i == 0) {
>  			/* put cxl_mem.4 second in the decode order */
> -			if (pdev->id == 4) {
> -				cxlsd->target[1] = dport;
> +			if (pdev->id == 4)
>  				cxlsd->cxld.target_map[1] = dport->port_id;
> -			} else {
> -				cxlsd->target[0] = dport;
> +			else
>  				cxlsd->cxld.target_map[0] = dport->port_id;
> -			}
>  		} else {
> -			cxlsd->target[0] = dport;
>  			cxlsd->cxld.target_map[0] = dport->port_id;
>  		}
>  		cxld = &cxlsd->cxld;
> @@ -1212,6 +1208,16 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  		cxld->commit = mock_decoder_commit;
>  		cxld->reset = mock_decoder_reset;
>  
> +		/*
> +		 * Only target_map[] is programmed above, mimicking
> +		 * firmware. On real hardware target[] is populated as
> +		 * dports enumerate, via update_decoder_targets(). The
> +		 * mock's dports are already bound by now, so fire that
> +		 * resolution explicitly here rather than stamping
> +		 * target[] directly.
> +		 */
> +		cxl_port_update_decoder_targets(iter, dport);
> +
>  		cxld_registry_update(cxld);
>  		put_device(dev);
>  	}

