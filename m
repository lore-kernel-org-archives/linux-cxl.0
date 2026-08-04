Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6B2EEE61
	for <linux-cxl@vger.kernel.org>; Tue,  4 Aug 2026 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785885861; cv=none; b=d0MViEEDWYni+54B4ScBK5LkP6AVBthhLIFtWduSbs0C4AJhQ19vJS9RRnjJquatD88ptEjmVnwZSUf+aTEmdlnLwSyY0Z3kPpIgbDf6XvujcrDLLyBoiUa+N1n8NGTp0U+KMzBYDEU1XiMSVRHjoaRvzn6KusxioA/Al6feaS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785885861; c=relaxed/simple;
	bh=ZF5I0hiLioPzRlEvhWw3jlMctgpzHM5+evZW4f9fjXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDUdSj5rwyaL5QFFNCQvJt3MQ6pL0q8I3fcWFYlWQt7mTIuumzloFPxFGDO9ClGAiUUctA0Wt8aN5vbNewZ/4pZEltfYKEV7k5auf1HgoNhXWnhey0C0aVL12Stdo8CJc1AsVNVdoNtRPPa8XkwkJWrHp4l2I6ayWz2YUARXhtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGVSnUNm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGVSnUNm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785885860; x=1817421860;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZF5I0hiLioPzRlEvhWw3jlMctgpzHM5+evZW4f9fjXs=;
  b=nGVSnUNmvrIsggBXJXGRH7EKQ6A4n3vyoA5PoQhQ1MDJNpm2wCC/z5iY
   quawKwsm40ZQVi3nBcxiPSyZbiOJa4CGV8rZcC7C33O5I+lip8x5WC3BC
   zH1j3d8l1v4ZLffW+fYT0ON8YaEHrbqaQ5wfTOYrQUq4kgKm7bhSnNmwJ
   488ube/JcXAHntIRx+etFcUCg8GBUWovGLhOF9E60bFFa+RQFR29Z3Q9S
   Zc6G+U0UK7i5i4DPo7Msyuj/4V6ncEx67P0YDlIJXD6eOR7eJLFaOhkFn
   JGohqaPt7w6c9asJuc7EqHBI1DeE84e/6rLoibVXcoGe4lPgOaSlxFlMg
   A==;
X-CSE-ConnectionGUID: 4pbqhZa4Slmr5e/qKK/tAg==
X-CSE-MsgGUID: /knRPx4vRK2ZNv7p+2WDjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86305889"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="86305889"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:24:19 -0700
X-CSE-ConnectionGUID: FLFF6lXlQsCeNtHDluZT3Q==
X-CSE-MsgGUID: UBmRpa4UTsiHp4uBJeqxnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257766723"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.7]) ([10.125.109.7])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:24:18 -0700
Message-ID: <850eb9c4-8f3e-4fa1-b8b5-46f83f5f20c1@intel.com>
Date: Tue, 4 Aug 2026 16:24:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/Documentation: Spell out globbed sysfs attribute
 names
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260804232014.2286549-1-alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260804232014.2286549-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/26 4:20 PM, Alison Schofield wrote:
> Four entries in sysfs-bus-cxl use braced globs to document groups of
> attributes. Where the glob factors out a common prefix, as in
> cap_{pmem,ram,type2,type3}, no individual attribute name appears in
> the file at all and none can be found by grep or get_abi.py search. In
> every case the glob also keys get_abi.py validate on the glob string,
> so duplicates against separately documented attributes go undetected.
> 
> Replace the globs with consecutive What: lines for each attribute.
> These lines continue to share the existing metadata and description
> and follow the format used in sysfs-driver-ufs and sysfs-bus-iio.
> 
> Also restore one missing blank line between entries.
> 
> Verify with:
>   python3 tools/docs/get_abi.py -D Documentation/ABI/testing validate
>   python3 tools/docs/get_abi.py search cap_pmem
>   python3 tools/docs/get_abi.py search create_ram_region
> 
> validate reports no sysfs-bus-cxl warning, and both searches now return
> the stanza where they returned nothing before.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Seems reasonable. One comment below.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> 
> This caught my eye when reading DavidLohr's Back-Invalidate series
> that adds cap_bi to the cap_{pmem,ram,type2,type3} glob and then
> references it. I couldn't find it, not w grep and not w 'get_abi.py
> search'. None of the existing cap_* names can be found. This patch
> is independent of that series and happy to spin this to include
> cap_bi if needed.
> 
> This intentionally does not address `get_abi.py undefined`, which still
> fails to match decoderX.Y attributes due to a bug in the ABI tooling.
> That will be fixed separately in linux-doc.
> 
>  Documentation/ABI/testing/sysfs-bus-cxl | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 16a9b3d2e2c0..7352dbd70bc7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -201,7 +201,8 @@ Description:
>  		capability.
>  
>  
> -What:		/sys/bus/cxl/devices/{port,endpoint}X/parent_dport
> +What:		/sys/bus/cxl/devices/portX/parent_dport
> +What:		/sys/bus/cxl/devices/endpointX/parent_dport
>  Date:		January, 2023
>  KernelVersion:	v6.3
>  Contact:	linux-cxl@vger.kernel.org
> @@ -258,7 +259,8 @@ Description:
>  		instance id of a given decoder resource.
>  
>  
> -What:		/sys/bus/cxl/devices/decoderX.Y/{start,size}
> +What:		/sys/bus/cxl/devices/decoderX.Y/start
> +What:		/sys/bus/cxl/devices/decoderX.Y/size
>  Date:		June, 2021
>  KernelVersion:	v5.14
>  Contact:	linux-cxl@vger.kernel.org
> @@ -297,7 +299,10 @@ Description:
>  		Each entry in the list is a dport id.
>  
>  
> -What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3}
> +What:		/sys/bus/cxl/devices/decoderX.Y/cap_pmem
> +What:		/sys/bus/cxl/devices/decoderX.Y/cap_ram
> +What:		/sys/bus/cxl/devices/decoderX.Y/cap_type2
> +What:		/sys/bus/cxl/devices/decoderX.Y/cap_type3
>  Date:		June, 2021
>  KernelVersion:	v5.14
>  Contact:	linux-cxl@vger.kernel.org
> @@ -410,7 +415,8 @@ Description:
>  		interleave_granularity).
>  
>  
> -What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
> +What:		/sys/bus/cxl/devices/decoderX.Y/create_pmem_region
> +What:		/sys/bus/cxl/devices/decoderX.Y/create_ram_region
>  Date:		May, 2022, January, 2023
>  KernelVersion:	v6.0 (pmem), v6.3 (ram)
>  Contact:	linux-cxl@vger.kernel.org
> @@ -500,6 +506,7 @@ Description:
>  		cache is present, the size indicates extended linear cache size
>  		plus the CXL region size.
>  
> +

Stray blank line?

>  What:		/sys/bus/cxl/devices/regionZ/extended_linear_cache_size
>  Date:		October, 2025
>  KernelVersion:	v6.19
> 

