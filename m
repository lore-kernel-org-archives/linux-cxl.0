Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42C3E559F;
	Fri, 12 Jun 2026 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282393; cv=none; b=Jbsl04QfHBGsQOi11eJzGTBI8lZBOIv6lwiJ5JiPd3wb7xAjQHhuUn4PxocFzdPDNrOEbiNt+sG3/mrJ8v4sxVUapgcDJvA1uVieXUpycN8IiYPnjZjOupOhfSXTodHR7SfaRgIBWuj5WceEMgohb5fvl0xbiHcnKFV+CBG8TNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282393; c=relaxed/simple;
	bh=F5Vq+L9gpF/xDTtLnp7hqKJ5vdakOA0i2mHI8PyCLgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/6Nvc36IOlFvTiGemmUZ2wlWiuLXg53iiqbeK67rYRiiRIsvFQ+GW0Y3df6OW0yzOXwjcV/Nef28XPgHkDQkJ48JIjM4yqCOvvo0dU/NlhyU5tC2PGi6Qwb+kDHfh9TrK1U+PrQ7QTcKhsuxoCLRbnmREuyqsgUpVdKL5J56Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+ftD+v9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+ftD+v9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781282389; x=1812818389;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F5Vq+L9gpF/xDTtLnp7hqKJ5vdakOA0i2mHI8PyCLgk=;
  b=Z+ftD+v9vaBU/Z7IbH1M9WzEXqRKfBSjd74r0mx3bc37yh3DYv9Emx4R
   bLiRXHxnGZM49AV4PAKMABWGC4L3OzYj2+qFDvlsQf3mqXYKvgc8KYtX9
   FGFoIjYYB4NifNScc7oXCohXWXoA8PZiiU0BZ9eIoyQBONAWV1R6m5uGG
   ivUCspfdGDYfTYYuwWr40dLq2cmaSC1aUKtflI7dbvYl047tXm0AJevle
   jwLh1T6vneVSZ+ZgDd2xw81K5sZnEW/1fcK99ivh8FLbwdD8sZUwQUBrq
   YLH5rvNY4+ACbv9yQNMeoT73TzAM16EEIQu+y9/fviKOiKTfUOQgWXPSt
   A==;
X-CSE-ConnectionGUID: VKz9al9yTnCDne7X5BWrUw==
X-CSE-MsgGUID: A/NblBWtQAWwubYXrnMmOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="81859549"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81859549"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 09:39:48 -0700
X-CSE-ConnectionGUID: j+GrTojuQ9eUKojGXopsnw==
X-CSE-MsgGUID: TLi2MgXERzCq2XwV8nt7jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="242490511"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 09:39:46 -0700
Message-ID: <52a11d36-a3fe-4a4e-b7e5-6ea2c02136e8@intel.com>
Date: Fri, 12 Jun 2026 09:39:45 -0700
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

Applied to cxl/next
769f0b350c81

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

