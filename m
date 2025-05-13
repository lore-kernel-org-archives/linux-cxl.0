Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D664C6C
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174920; cv=none; b=gobdr6xVzjvhnA+7fqhTCl+HehShl53Cl2d86XvXqMc7y5VsZsyNtpMrKc/2AeoXUixBbpMDv2Ix5e8TstLr6QkM3jIYiHYUIgH3B7TP3xxnL20vDR6FGCxmSDmLe8gD/Pro5bkn8JJ5Gs/lNR1EoQ6hNbZ/R5vLo+bW6z25NiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174920; c=relaxed/simple;
	bh=vnHF6nOXJvQNzU/577QKjm1Zj1hor3At5ueFPXuDyek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s94doWVh7IykbfzAwIZ0fQ1p8ZeDoSpDG46M26rXu5B5RNfPZVlilasjvLAoMjSa9GtttpqVZzQDwAWIi+BYBG4VvdqgrS5yF3yM7DsVpLjBP8U4No66Xb+wwgBV+QrHmHT8hsLeSYUMOs3rjLsEneJ5g1FTJQPx3F/iSRKJn5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxV3O2JR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxV3O2JR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747174918; x=1778710918;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vnHF6nOXJvQNzU/577QKjm1Zj1hor3At5ueFPXuDyek=;
  b=UxV3O2JRFncnDIPowF1on3SHuoOVqEF5BzQR2h5o7BKLIKVA2fWGlFi5
   L/H8JlirQBm9AlIQXwif0ldPDs9LaA52vYN6tpdctvJT4PynI1PJGmLG7
   YeNq7ImuhLsyWZ5oUDHR6wer6tdxGeVc9+GCV15QqL3DewOZNZ6Jnm6OG
   RvBXWOSSGhn5T4UdKAVgp5FrEs8Te1ucuytnIfKuRcuJ+dk9kkkpO/nZg
   KKGyXnyN1ZzjMJ559Gq+IYpU/P6kYycxxPuS32Klj9t1gA2FZU7OlPjbp
   sErv+xblZqBYzErFaZuh5nq2DOKOOE2TA71CP5FTPA55+1ZGcqQhSHOCw
   w==;
X-CSE-ConnectionGUID: n7kHyvVJTgKg8LMZj0aCMw==
X-CSE-MsgGUID: GSVj/atHTZGPpJaW6ub41g==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="48156888"
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="48156888"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 15:21:58 -0700
X-CSE-ConnectionGUID: ySEOZSPOQUSJfluCdw1ylg==
X-CSE-MsgGUID: Sv/MAlKxRGq1mri6sYK6/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="138826134"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.109.16]) ([10.125.109.16])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 15:21:57 -0700
Message-ID: <fda37467-8e1b-4901-a80f-39264149edc9@intel.com>
Date: Tue, 13 May 2025 15:21:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: Update the CXL Maturity Map
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20250512214225.1389484-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250512214225.1389484-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/25 2:42 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Changes for extended-linear cache, hetero-interleave, and HPA->DPA
> address translation.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/next

> ---
> Change in v2:
> - Make ELC a '2' (DaveJ)
> 
>  Documentation/driver-api/cxl/maturity-map.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> index a2288f9df658..1330f3f52129 100644
> --- a/Documentation/driver-api/cxl/maturity-map.rst
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -51,9 +51,9 @@ in place, but there are several corner cases that are pending closure.
>  
>  * [2] CXL Window Enumeration
>  
> -  * [0] :ref:`Extended-linear memory-side cache <extended-linear>`
> +  * [2] :ref:`Extended-linear memory-side cache <extended-linear>`
>    * [0] Low Memory-hole
> -  * [0] Hetero-interleave
> +  * [X] Hetero-interleave
>  
>  * [2] Switch Enumeration
>  
> @@ -173,7 +173,7 @@ Accelerator
>  User Flow Support
>  -----------------
>  
> -* [0] HPA->DPA Address translation (need xormaps export solution)
> +* [0] Inject & clear poison by HPA
>  
>  Details
>  =======

