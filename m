Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56301288521;
	Mon, 19 May 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671151; cv=none; b=PK8SYWXGfteJQghtr1Pg6Q0Yf035PUSPyXy7Ekc0UbWbSQd88dpMgzpJMVzI/nmr5iOSm2nugPVBUmHkC0Vy8/8ns3r4b7uL9U/ASCXSrCbtRtHemESCRuRc14997E6aGEc7QVqJOZpbMhguYA6B0b2WF8az4uTaVR3exo16ueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671151; c=relaxed/simple;
	bh=PY2I9yTwT6C5ruxhzvlkSuqMbl6xpAox2SDDWbmYmh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/pywljuKOieOWyhdgpiek63sLcqytaGuKmE7eQOl40/ME2p4GA0HCrN0XIRwYxNT5+wsUo/2TTlIry6/r+Z89b3u5ZhxZHNoaXHJqyNYYbuzKsfPoTfFre7RavKl0/cLhh7uNlZ9cTIL2xMCEY40/f6OhveqsWwUHg4oRYySBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9+zDp7k; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9+zDp7k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747671150; x=1779207150;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PY2I9yTwT6C5ruxhzvlkSuqMbl6xpAox2SDDWbmYmh4=;
  b=A9+zDp7k0hAbgiUE5NkyM7Nv8pkp20Sxnm2znp0eCwYW7xjRsu7YEEx/
   o637lSlPe4KYmS6iPLdi+/3lvgJdqyuRMPfnM07CcEb4tNmbx11NuWCw3
   Waz4Er1uJs37RHJI9sMV7XPHfJDGwDIsZHx4tdmVm5RTMWP/Jy2qAQyET
   +b5+w4R5Nkfy3x2M1OuBoM2YSq82YdJ69E4ToOHxs3TjyNtenhUfmwe//
   oEgonMCvirQ2caYgS9Jj68jG1/mRcIL+R6fjIP1dY3B+kFmiCcOGFVVYT
   bpp6uBre6U2DrJ/RjkudEWVyAQ05E1e7LIjH2w/GQbECDNhQ1h2680e0K
   A==;
X-CSE-ConnectionGUID: kmcVCu32S/eIAlGgwXGeyg==
X-CSE-MsgGUID: bV8RcWBmRYSnI8fFaEWEKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49642002"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="49642002"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 09:12:29 -0700
X-CSE-ConnectionGUID: ZqRJybsFT+umOBJrXQogXg==
X-CSE-MsgGUID: 0yOQx4DcTBuFFuLfPqKPJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="139300892"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.109.80]) ([10.125.109.80])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 09:12:27 -0700
Message-ID: <6ed977c8-a5f2-4437-80a5-977c0a6cb8bb@intel.com>
Date: Mon, 19 May 2025 09:12:26 -0700
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

Applied to cxl/next

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

