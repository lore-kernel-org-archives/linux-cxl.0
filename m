Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B1E1D6188;
	Fri, 16 May 2025 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409083; cv=none; b=C9yCEZ1sMZ4BNIu32VH0bFeDobkRyxzgFcb6qqQc7SmNsA7gmdFvzuKyUsXHRREd0wbfadWCN2D68eCaxzApWgsJAYm6G2708Govumu0yKP/ZjUGbzdYK849ZWuse8Ofph/0dLHcmWyCt8A/bW5sOB9NnTkfwimZty+ZbQJtACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409083; c=relaxed/simple;
	bh=34twSl6TeXp2IsOgg+g+j37cRqBdIcgf6MZT2aX7nKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/e5SplDJU2f38U1uZ+xonD3flSpq0L3mnrOBI+HIdIAlmtrYfMjmGV2pQ+VGlIfnLZFv/kqyr/XDXR711FK137YvDiRNk1ktTzQyidTrDCbpultwBSpJFKgvS9ONqN+AJLDARz+J5w8y9BYrIx74GQmdFKdcZ/zas4aYuq38ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwVsOsqh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwVsOsqh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747409082; x=1778945082;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=34twSl6TeXp2IsOgg+g+j37cRqBdIcgf6MZT2aX7nKo=;
  b=jwVsOsqhjCkCVddTWnaTv6XVItOA6tH4pfy7VHP0p35qQlRXHAci54Je
   oxGM5lE7SEg7Z/l6zD3A9wy7Rwv79wwOeERlW/3xw+lz1xo0NadAWmY3P
   C3Ejgv7XhArMS3hkdybpIA2ulbFXC4P7+B+Oki0UFuLIYjUcgmcDqIg9t
   ZFHoEzqZwjXgN+/dm3bAKT11IZF/GeN33c5Rdma+4CNz4V8IOSq5/+SIE
   Gbc5vvXI4b1dUCCu9zsYbHY0oUVuTpsz1VgHBiME1iYHkreh7PGzARmtt
   j1/srdVNY9EYRBwChYFzu6o0lHHgrAFgG4Kfs32gZMnoPuJYYTBoHIgdu
   w==;
X-CSE-ConnectionGUID: cmy7r0qnSWKWBLYxMthMag==
X-CSE-MsgGUID: YuGwin+/QfyvXyaRVtj+AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="60775080"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="60775080"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 08:24:42 -0700
X-CSE-ConnectionGUID: P0wdUR4ER9KhHMhaeXQarQ==
X-CSE-MsgGUID: 9TYou/inQ2G7yQiwKnnwxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="139124042"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.60]) ([10.125.109.60])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 08:24:41 -0700
Message-ID: <580d2aa6-0384-4c06-9d1b-f2f7d25fc9f7@intel.com>
Date: Fri, 16 May 2025 08:24:39 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/feature: Remove redundant code of get supported
 features
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250516143220.35302-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250516143220.35302-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/16/25 7:32 AM, Li Ming wrote:
> In cxlctl_get_supported_features(), there is a code block that handles
> the case where the requested is equal to 0. But the code following the
> code block can also handle this situation. So the code block is not
> needed.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3 v6.15-rc6
> ---
>  drivers/cxl/core/features.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 1498e2369c37..2d3a6d36a761 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -416,14 +416,6 @@ static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
>  
>  	rpc_out->size = struct_size(feat_out, ents, requested);
>  	feat_out = &rpc_out->get_sup_feats_out;
> -	if (requested == 0) {
> -		feat_out->num_entries = cpu_to_le16(requested);
> -		feat_out->supported_feats =
> -			cpu_to_le16(cxlfs->entries->num_features);
> -		rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> -		*out_len = out_size;
> -		return no_free_ptr(rpc_out);
> -	}
>  
>  	for (i = start, pos = &feat_out->ents[0];
>  	     i < cxlfs->entries->num_features; i++, pos++) {

