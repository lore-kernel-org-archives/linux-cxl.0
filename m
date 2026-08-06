Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7F4399368
	for <linux-cxl@vger.kernel.org>; Thu,  6 Aug 2026 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036572; cv=none; b=BcbolIn8EesFUAtbwlRIwe6fQjqeNGcg61b5n3KFzZUo+m/SG2LhZNR8cULXBSdEXpOox0JlCfMRnLPIFDj5noVCRTdOltFklokGrAQxwihjBIvs41112HtYA7jGhwJsTGpCF6jz8ASo58h61VKUCdAuzWUn54l00jGMhH1yXKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036572; c=relaxed/simple;
	bh=0buP9eEimcNGJTMvtIZiV/oU0eoXIFGQFJ3sFl4Q1UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDpXHMOjPJRqwP/hJmnufBsRSVnyKi4tNeDAw+fFxHplyFFek6r95trIVxOV1SZVLWzqxdEY92TmflitxqUgcRkcUkVC03SqxxF/TcvHxISDxEHoMRw44ah7kTfVia8Cf3C3qlc1sKVvemoIJspKV+3aKRKZJinkzQGzUKSo8uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOOa78u2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOOa78u2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786036571; x=1817572571;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0buP9eEimcNGJTMvtIZiV/oU0eoXIFGQFJ3sFl4Q1UA=;
  b=UOOa78u2VqMoZeHPqAm8xkEji9BlV0LYh11E0WM5/Gfr2Gq1iivfOeiZ
   P2PxuugoJvykFkCVvYuPNoeOMfoOxCRT6AJe5l8EwfIorIjIJbeQyMny7
   Se7mEDHZFmYdcDFipK+A+5cLSEIpzLL49TSjJJGOOHmUQZMIriy3c/pmb
   9WKQlHn0KTTuWUTXpPhxZccsTej0fmZ4raT8DDG9w5hlNHMkod6t1TSUR
   EVwL2jyVWC1/Zgy6DaANbzt1o6ThuHYy1LvZIboxIQ6S4oUvkCdEKuX6d
   XjleOLjrR2QV3WIW1k3q89nosxvrr24vQpqscjp/lpKTbcbvKNDZC+1R1
   w==;
X-CSE-ConnectionGUID: d9fjSzAJSs+yMB7c0PZmVg==
X-CSE-MsgGUID: 1qi5yH3tQqGEt5k3cvWLiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="98001946"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="98001946"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 10:16:09 -0700
X-CSE-ConnectionGUID: t35CSj9/SjOGsoXncLzF5A==
X-CSE-MsgGUID: lC+ic9sPSPq/2gJelIxs2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="255911954"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.117]) ([10.125.109.117])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 10:16:08 -0700
Message-ID: <3d761f1f-6ff2-42d6-a451-e013c45ce959@intel.com>
Date: Thu, 6 Aug 2026 10:16:07 -0700
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

Applied to cxl/next
d7066cfc4187

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
>  What:		/sys/bus/cxl/devices/regionZ/extended_linear_cache_size
>  Date:		October, 2025
>  KernelVersion:	v6.19
> 

