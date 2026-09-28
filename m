Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169B38333A;
	Mon, 28 Sep 2026 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619693; cv=none; b=P3M/NmDLWwoIQAJjT7ArfwEfwT8eKAoxRMZcNl0BURHTgrGMKsuj46r213ZLgqZKe7m9uIGEmKbM//UlAytnqsdublV/aEeVq19+6o3SMFn8ByT1vjE7pSlTvAH2pshtnE36DEqepHzDwO627tN6utSb2ThstIHmEvzj6q5VrT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619693; c=relaxed/simple;
	bh=s2tsQKHUzn1NMF9iclAXB1A3Gy/joyPQ+aTH9c8pRUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJnsFyWwMnLVbe8726SE76L69JtiCXksFK7OxZcd1NAN9tQZCPmBY2pV8ykNvapPn4qYMYQwNnIWRC9Z5zEl64JNvYlZM8Be3j5Ew8OKGAbHpb/SMJEdNF4XRaN28VCiG46UwEA1/zVNvG0mDUIAULUwihDwJe/lHwkwcjaXmzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EY0zAZ+O; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EY0zAZ+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790619692; x=1822155692;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s2tsQKHUzn1NMF9iclAXB1A3Gy/joyPQ+aTH9c8pRUI=;
  b=EY0zAZ+ObULIQ8StZEsiT03Mv3CNfv8zczvQdsftLudDnFfQ+yE5+qFq
   UI8bfawC9X4tm7BQKcaENtr7Fs/z8JP/CwQ5P9o3umNnF/sRg4aB7ktmI
   p+u+Mxkq74+oKhCJqYjcS/+vWwFd5gvMyh8v74TPAAjtCj25YTRUWlCe5
   mESbNjP43pF3o0uBfAgznmBfo9UUQ7pTz7/jjby9BrFPK2U14G+nM/fas
   Jv+Ze0SoHQcszIyKBHqD5ADlXCZhUqi8QbgSEnzC9WqnkQmHY13NvimFw
   6Fi+eGkO85FQ9WB4S2G8jrMNc/eVHLOH2ZzfsFqi5C2ilQTkyKk0KYZ5C
   g==;
X-CSE-ConnectionGUID: uIUxe1ORSzGavQ3EpkE13A==
X-CSE-MsgGUID: waClS0D1SDqK99EXFvQiIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90092671"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90092671"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 11:21:31 -0700
X-CSE-ConnectionGUID: TflOUfHhRHC74YF93lEBgQ==
X-CSE-MsgGUID: ggTk/IAcTeqqwfk4KJIpng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="278329622"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.79]) ([10.125.111.79])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 11:21:31 -0700
Message-ID: <51e4cfe6-b3c7-43ff-8b1c-512cfb23b9be@intel.com>
Date: Mon, 28 Sep 2026 11:21:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/edac: Bounds-check ECS threshold index from device
To: Yili Zhang <zhangyili01@baidu.com>, linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Shiju Jose <shiju.jose@huawei.com>, linux-kernel@vger.kernel.org
References: <20260928073553.85669-1-zhangyili01@baidu.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260928073553.85669-1-zhangyili01@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/28/26 12:35 AM, Yili Zhang wrote:
> cxl_get_ecs_threshold() extracts a 3-bit index (0-7) from the
> device-supplied ECS config word and uses it to
> index ecs_supp_threshold[], which only has 6 elements. A device reporting
> index 6 or 7 causes an out-of-bounds read of adjacent .rodata, whose
> value is then returned to userspace via the EDAC 'threshold' sysfs
> attribute (small info leak and wrong reported threshold).
> 
> Return 0 for indices outside the table.

Why return 0 instead of errno?

DJ

> 
> Fixes: 85fb6a16ad14 ("cxl/edac: Add CXL memory device ECS control feature")
> Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
> ---
>  drivers/cxl/core/edac.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index b321971fef58..73335b980b11 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -633,6 +633,9 @@ static u16 cxl_get_ecs_threshold(u8 log_cap, u16 config)
>  {
>  	u8 index = FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK, config);
>  
> +	if (index >= ARRAY_SIZE(ecs_supp_threshold))
> +		return 0;
> +
>  	return ecs_supp_threshold[index];
>  }
>  

