Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC59282F2C
	for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776464784; cv=none; b=CUwrboxOkGUe6/9YwOeJwXpkBPUSOnanwnLfc1/JFdFlE5iwySMtREgGmpNgMJ6UVzijGVhWYGjqKXDMqtnfgT0HIUfaACJO0Dx0nfj+OVKoqO3tPSVbukIbWLSbrEchBdRbbwkZl4Metzc8nNHE3pMWGUO1j52NmUi/A8VcoYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776464784; c=relaxed/simple;
	bh=0gmZVfnvY4nauFmlGmFFwcKw9MuYH7Umrfj9toi4v0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQy6U47lve9HcFdQYNbFFOzTVFxgO4ANU+zxxBmvgI9emwAr4WcAAM5Dv1wWNVvI7oTGhrJe+9SZkhtWC7lEHqNhNTzH7P/Ew18VdYpslWuTHx7QRqv+zFcfC1TQGIbzzAzRECrNCQXd/9o+gcZSejLH1Q/kTxzFeC706J0+1PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dB9JnQ0k; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dB9JnQ0k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776464782; x=1808000782;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0gmZVfnvY4nauFmlGmFFwcKw9MuYH7Umrfj9toi4v0Q=;
  b=dB9JnQ0k1Mpo5iFGelYeo2MtgJvzzWexZkMs6vs8/QHF/zlU8UOEuedX
   9QVokhSCTvqRK/mDyIWDkc1j6KBbzU/SfAzbwpr3xjncHNMTwtH6Hf7pa
   saEM6ftZt/9Rsxm/FSGG0hm+bH3GKapq7zyF8+WmMmXYjMZTMQuxZxlwY
   L4YIUyp1cX7zG4pTl3SXZM5Hx1ZpU9clRS4AyWRsmk7mnKW3ujOFgYWM2
   siMx/QrI6cUKIPTgZeckdKxdmh0t+G4kA4nYs2v91YRrndxsMZnLvoc/P
   hD/cYwl+cKvHypBMH2V3DgA9TO8khJ7RrFhljFI7CBGIceR/ifSwt2Qna
   Q==;
X-CSE-ConnectionGUID: zlf4Q9BqTTyUu2ySDQG+aw==
X-CSE-MsgGUID: GDY9YD5NQy+Hil/S/VZ/ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77358593"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="77358593"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 15:26:22 -0700
X-CSE-ConnectionGUID: iUkpyT70Qj229hNJrjbEGg==
X-CSE-MsgGUID: I7QhllYITiOpX8I82z0Zig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="228462114"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.204]) ([10.125.110.204])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 15:26:20 -0700
Message-ID: <f55fd271-1951-4a2d-9d3a-e84e165ab33c@intel.com>
Date: Fri, 17 Apr 2026 15:26:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: Update the CXL Maturity Map
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org
References: <20260417201300.3438995-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260417201300.3438995-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/17/26 1:12 PM, Alison Schofield wrote:
> Here are a few updates to scores of existing items.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

With the expectation of Terry's protocol error series merged for 7.2.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
> 
> Changes in v2:
> - Update after walkthru w DaveJ 
> 
> 
>  Documentation/driver-api/cxl/maturity-map.rst | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> index 282c1102dd81..1ba528c82755 100644
> --- a/Documentation/driver-api/cxl/maturity-map.rst
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -52,12 +52,12 @@ in place, but there are several corner cases that are pending closure.
>  * [2] CXL Window Enumeration
>  
>    * [2] :ref:`Extended-linear memory-side cache <extended-linear>`
> -  * [0] Low Memory-hole
> +  * [X] Low Memory-hole
>    * [X] Hetero-interleave
>  
>  * [2] Switch Enumeration
>  
> -  * [0] CXL register enumeration link-up dependency
> +  * [2] CXL register enumeration link-up dependency
>  
>  * [2] HDM Decoder Configuration
>  
> @@ -78,7 +78,7 @@ in place, but there are several corner cases that are pending closure.
>  * [2] Hotplug
>    (see CXL Window Enumeration)
>  
> -  * [0] Handle Soft Reserved conflicts
> +  * [2] Handle Soft Reserved conflicts
>  
>  * [0] :ref:`RCH link status <rch-link-status>`
>  * [0] Fabrics / G-FAM (chapter 7)
> @@ -95,15 +95,15 @@ mainly caused by the enumeration corner cases above.
>  * [2] Component events (FFM)
>  * [1] Endpoint protocol errors (OS)
>  * [1] Endpoint protocol errors (FFM)
> -* [0] Switch protocol errors (OS)
> +* [1] Switch protocol errors (OS)
>  * [1] Switch protocol errors (FFM)
>  * [2] DPA->HPA Address translation
>  
> -    * [1] XOR Interleave translation
> +    * [2] XOR Interleave translation
>        (see CXL Window Enumeration)
>  
>  * [1] Memory Failure coordination
> -* [0] Scrub control
> +* [1] Scrub control
>  * [2] ACPI error injection EINJ
>  
>    * [0] EINJ v2
> @@ -112,8 +112,8 @@ mainly caused by the enumeration corner cases above.
>  * [2] Native error injection
>  * [3] RCH error handling
>  * [1] VH error handling
> -* [0] PPR
> -* [0] Sparing
> +* [1] PPR
> +* [1] Sparing
>  * [0] Device built in test
>  
>  
> 
> base-commit: 028ef9c96e96197026887c0f092424679298aae8

