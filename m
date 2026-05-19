Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B84B14BF97
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779232243; cv=none; b=diqxlpfmLM6VbmGeoxj/ZTKeBDiAVnRKFmpqPY5xCVgHshM9HIsxB9LBfwTfQZuXk8NBKQNrHF5WzhuVpZeE4+l8oxaxbrM2FL8ws8Vot2iAeseL6enImKMPS/blWwPqa3OaVQIOtOEdAmXSHj0oUF+YYGavScUfyw4sgkyEpII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779232243; c=relaxed/simple;
	bh=WS2PrWyPcwWNmQaBkwAoh3xQopQeYY+NU/1yFq93XQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhNMLgJVKYNLT/AFq1sLaDTXIx+DQEEmtn2a/cm3E9kIK4UhjxjCmT/FbFUAZa0NYvZtXwjDKDNUvkK2OWczORSvTZig/MQLr3oXwPhL2Jw3x6x+3W35yUAnx06CxLc7d8QKiiA6+IgI+VmNudFJ6TbuGIPdoqQIG5cS64mRqsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0raCQIk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0raCQIk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779232242; x=1810768242;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WS2PrWyPcwWNmQaBkwAoh3xQopQeYY+NU/1yFq93XQo=;
  b=a0raCQIkiOTp1uXHN7D3+8UbIKHJVvepdV+MN9cuynY4+m0CRzzUATgB
   3d7TRRHArJaMnHoEoA7eUgpL06VoU7lilKy64/IaLBeSmIOIxs0mzM3/T
   vJT7MVSGwWadG1dJXGP/9wJGRLbOIbv0plrAp7Z0Vu0irD1pT9dKsxsE2
   mn0pb3HAa/OiFAgti2Up7mbP4o7ti7K+uFLT7lZJol94EGzBc9hp3AABF
   5wIBTpG8AyQp9Tcse/B9NKaI7kE3Pv/6edmm3QgREg3Amx67iu1we1t7w
   vePyt3XwwWPBCR5Bd/KM5bxqdG1juVvewu/2vx6TlGPCTy1nCE/sQT0r7
   A==;
X-CSE-ConnectionGUID: pZ1zUQp3QRGtWPqfug2H1Q==
X-CSE-MsgGUID: WHrDhboaQLyjHaJLqNWQcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79272647"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79272647"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 16:10:42 -0700
X-CSE-ConnectionGUID: hM6V4ppDSy6v57kW+wuiMQ==
X-CSE-MsgGUID: KAxKchOSQeOSbZHQa8Mq2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235501373"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.143]) ([10.125.109.143])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 16:10:41 -0700
Message-ID: <43d46939-dd16-46bd-9447-a4bce5941f5e@intel.com>
Date: Tue, 19 May 2026 16:10:40 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cxl/fwctl: Fix __fortify_panic
To: Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
References: <20260519221204.1517773-1-djbw@kernel.org>
 <20260519221204.1517773-2-djbw@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260519221204.1517773-2-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/19/26 3:12 PM, Dan Williams wrote:
> Fix a runtime assertion in cxlctl_get_supported_features(). Fortify
> complains that it is potentially overflowing the entries array per
> __counted_by_le(num_entries). Quiet the false positive by initializing
> @num_entries earlier.
> 
>  memcpy: detected buffer overflow: 48 byte write of buffer size 0
>  WARNING: lib/string_helpers.c:1036 at __fortify_report+0x4d/0xa0, CPU#7: fwctl/1398
>  RIP: 0010:__fortify_report+0x50/0xa0
>  Call Trace:
>   __fortify_panic+0xd/0xf
>   cxlctl_get_supported_features.cold+0x23/0x35 [cxl_core]
> 
> Fixes: 4d1c09cef2c2 ("cxl: Add support for fwctl RPC command to enable CXL feature commands")
> Signed-off-by: Dan Williams <djbw@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/features.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 3435db9ea6b1..85185af46b72 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -423,6 +423,7 @@ static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
>  
>  	rpc_out->size = struct_size(feat_out, ents, requested);
>  	feat_out = &rpc_out->get_sup_feats_out;
> +	feat_out->num_entries = cpu_to_le16(requested);
>  
>  	for (i = start, pos = &feat_out->ents[0];
>  	     i < cxlfs->entries->num_features; i++, pos++) {
> @@ -444,7 +445,6 @@ static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
>  		}
>  	}
>  
> -	feat_out->num_entries = cpu_to_le16(requested);
>  	feat_out->supported_feats = cpu_to_le16(cxlfs->entries->num_features);
>  	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
>  	*out_len = out_size;

