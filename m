Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D56C2ECD0E
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452910; cv=none; b=WQJKJSmvVPvZQgGOvk23o3MKdHfwtjGtPdVp4r+wGtlU8h4QVuDikJGblHAboJTzif2iYKkYamuc2x4e0hvRP+Qs4xN3VCh7t8WYqprqOxaDgwibhn7l/RZQlSNK3OohZSNfGu2diWz7BvFsxeDnDCEA7WSFabV1JbCq2E1hDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452910; c=relaxed/simple;
	bh=TN9f88y+7OIfnTNyilLAxxsQeA8cwi6Rw6tBxv6bxjA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oA3bGFBYzapNOxhRPMsHeXnOBp2iDLl0ZKQgSBaODfqBrB/psjXtaHMhQtFyCf3b8nOjc3Ho0nyNGdxjmDO2VKMZEdTvLSoYK6tOudyG2pBg/MuUy596t5ETbYYbLCj9a1bPBor7zfmFpNPZInbX/lbChVMX520pHS4uxI/Gs1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSNk+taa; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSNk+taa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760452908; x=1791988908;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=TN9f88y+7OIfnTNyilLAxxsQeA8cwi6Rw6tBxv6bxjA=;
  b=KSNk+taaG/Yrnpy8wR7VpagFnFoHsoslzxx88elbuN3FvAWn3hzxdb8P
   zCwYSXtSE/wyOyU7zMn1C0B7ymjkZ62W5GE3uW3LSXPBLz77ThLjzxoSp
   6r3DCDv4hxFrPyjrBxplRzR/bISjG5P1GoTrlKa0Hiv2Gmbn/7YM08hPV
   e2HvAiaA9HHxfFBPhtNQmnM+/loZTUF9/PJoXsPqJVVekPSM39+UlMtoj
   5oRI+9FkSBZxqHegfUAV/OGzP/k4Hw7CVU7Kbu1Jn3xqArZRN11xNkNhP
   9lcAxMJgnNavLyFMmZ/2KWtNT6XTZMvNTcImriinLanVHMpkJfYgV90ki
   g==;
X-CSE-ConnectionGUID: 5a1KIDDaSXat8vKmwmU50A==
X-CSE-MsgGUID: DZwgAZVCTAK8nb6o3qneSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73955230"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="73955230"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:41:48 -0700
X-CSE-ConnectionGUID: EXgaj7KuRSqalfSNtVMpUA==
X-CSE-MsgGUID: CKKc5XJpTGeGuh6KGN4QpQ==
X-ExtLoop1: 1
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.111.176]) ([10.125.111.176])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:41:47 -0700
Message-ID: <f84d4e0d-6d98-46ae-884d-6de04a3c0da7@intel.com>
Date: Tue, 14 Oct 2025 07:41:46 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cxl: Fixes for extended linear cache
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20251010205755.205280-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251010205755.205280-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/10/25 1:57 PM, Dave Jiang wrote:
> This patch series contains 2 fixes for extended-linear cache to make
> it functional again. One is a regression from code refactoring. The
> other is a missed range compare during region matching.
> 
> Dave Jiang (3):
>   cxl/acpi: Fix setup of memory resource in cxl_acpi_set_cache_size()
>   cxl: Set range param for region_res_match_cxl_range() as const
>   cxl: Fix match_region_by_range() to use region_res_match_cxl_range()
> 
>  drivers/cxl/acpi.c        | 2 +-
>  drivers/cxl/core/region.c | 7 ++-----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> 
> base-commit: c8e0f4f4be40a20f976344a821615e2b1bdb1f2b

applied to cxl/fixes

