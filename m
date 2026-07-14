Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B53C9ED5;
	Tue, 14 Jul 2026 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052334; cv=none; b=G3SNgJZqwFHNyLbAUY/XgEzOr9nFU3BAVqDDThjj5DzttdifV4yT597BrcMYv4FUI3+KuGl9CKjcz3RhjxX24b4omFat2gojSqGQe5CfdBHwf/0HvW6F/1QsAUy6TY5wJpRGay6BK0uoIVh1c3eIIHeSTkEA07Q5fI9fQHUuvVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052334; c=relaxed/simple;
	bh=D1TUSdG3tJPB5zMY35puNrbr8J5v5FI55ZwFLwE0vn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWiNFGEehHnrQPuDWC2XEY06SS6MFyvN8a5aYSek9livbdtBebdaJqw7WOYbdTc82tmglpRXPS2VEtzH+D/Y/LWC0+c20txTM1ltQqBwQ70qxnEtREw8HkzpMCFmF4ffG/9YuGjp+lRv7IVmfcwJnbAb7KDLHlIzsVYV5q6bsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItG0U/nV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItG0U/nV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784052332; x=1815588332;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D1TUSdG3tJPB5zMY35puNrbr8J5v5FI55ZwFLwE0vn4=;
  b=ItG0U/nVo8ClAKrNYs6gXPQdeuq+jPtBKXdntkMU/vAVffzuu8GE1ypx
   PqmwPYczhGvP3VwrtaBB683b7JMioEkmJnmJWB4oTXYbXLqzqYR2UiXuh
   a1g7LbdgKZLgJBovYylu6pw7tOLz/70SKU4SI5VK1wqGrBd+0uk9WDl3B
   ZG+0Pblw0bhzFqI8SlKw2WHgauU9IaaqMuC3Ptb+vkP8iDwERPsDyl/xP
   OX8MaWK8RywGWLy70J+32Q/kZVrDRb3j/HQM7Sv37grW73UGcVhlCPPo8
   3jyAxq7oIiGPwQJTQ0TNUAWwNniXf4kcF+ALn+LWYamx+QzIHxlUXrc2P
   g==;
X-CSE-ConnectionGUID: uvKaPCpPRQ+wsBsfIG1BoA==
X-CSE-MsgGUID: uYkFiKazSVi3xdfx4k9mrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="83669309"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="83669309"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:05:32 -0700
X-CSE-ConnectionGUID: YMzEeyXWRluOegjl9+XfmQ==
X-CSE-MsgGUID: LTCFEwh2SeamNaU2x+9wpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="254805108"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.131]) ([10.125.108.131])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:05:30 -0700
Message-ID: <9b4fa4d0-78fe-44a8-9d32-c6dc599888ef@intel.com>
Date: Tue, 14 Jul 2026 11:05:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] cxl/features: Reject Set Features output buffer
 smaller than the header
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, kobak@nvidia.com,
 kaihengf@nvidia.com, kees@kernel.org, newtonl@nvidia.com,
 kristinc@nvidia.com, mochs@nvidia.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260626104102.53892-1-icheng@nvidia.com>
 <20260626104102.53892-3-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260626104102.53892-3-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/26 3:41 AM, Richard Cheng wrote:
> cxlctl_set_feature() sizes its output buffer from the user's
> fwctl_rpc.out_len but never checks it is large enough to hold even the
> fwctl_rpc_cxl_out header. With out_len == 0 , kvzalloc() returns
> ZERO_SIZE_PTR, which passes the !rpc_out check, the subsequent
> rpc_out->size = 0 then writes through the poison pointer.
> 
> Reject requests whose output buffer can't hold the response header,
> before allocating. The Set Feature reply carries no payload, so the
> header is all that is required.
> 
> Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changelog:
> 
> v2 -> v3:
>     - New patch.
> 
>  drivers/cxl/core/features.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 9c714ee42a41..ed18ccb5e236 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -520,6 +520,9 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
>  	flags = le32_to_cpu(feat_in->flags);
>  	out_size = *out_len;
>  
> +	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload))
> +		return ERR_PTR(-EINVAL);
> +
>  	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
>  		kvzalloc(out_size, GFP_KERNEL);
>  	if (!rpc_out)

