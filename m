Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335C29B20D
	for <linux-cxl@vger.kernel.org>; Mon, 17 Nov 2025 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403218; cv=none; b=LK/zQNc0xNUtgWXhZ+txZOttZJSbshFuJf0p0anRWd/ObGXFPaO6WlgeXYHIVDQqOw+N875GNjIcN8EBAHnMzJda40jI89Ig6TvF2yKKFOSrWt1nFnjSKzZpqVhwqzTH02tZg97IQXJoHSgLvUdONy4RMcq/9SrjteYEnmHsFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403218; c=relaxed/simple;
	bh=90R3wzazKW0QXxHJW2q2x+J/FjVRjvzHCZns8xo33LA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sfnmvOLeW+Gaj8bauFW++L/7JsYlLvODkWT8/OyNhSnQCVZlMDX8z9YRxA14UY0zoW9TpCaPyfvrMiL89SfCuQnbEfuMDL30jaCW0BVJiqMhh/FAYxpRdyajNQAMYogC0p6dkUEGLKyuFqXIqDpjwgVllZeU7cfeT2dK/VsSE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3ypit+l; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3ypit+l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763403217; x=1794939217;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=90R3wzazKW0QXxHJW2q2x+J/FjVRjvzHCZns8xo33LA=;
  b=O3ypit+lkVyE64tM8raY3R5E5nGYwJxM1aJqbyhiuijgyjMn4hEzgrIc
   qkUWJxbY+xxL1hT/KN7JGjYqMRUDefUq08VjwMl6oNCgihFqtplDXIJug
   EK76Ps9jueWk/WAktxQrTjWOVCXJkHG0/bEHNNBSZTRw1nqlgCITPV3gv
   ZrfqVttgB+GoSdtq96XLlvfcI939TiITAvSkgcjyu6iHyQL5EG+zPcmyg
   icqk85IpoeUzqTEuykLjzKAjA5WO52ZtMs3WrjB+AMViepiDIP+jddBT+
   WdTdVt3xEX9BWTWAUDz+OPIAJscinhaqxvuS4+hxQII27QTO+a1WZZ4KB
   Q==;
X-CSE-ConnectionGUID: /lXYjdBrQT2IE7isqHxp/A==
X-CSE-MsgGUID: K26+1P0OSM+GhYzqr3uzyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76874262"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="76874262"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 10:13:36 -0800
X-CSE-ConnectionGUID: lxFmxSdkQdaIrateXnAAXQ==
X-CSE-MsgGUID: +S6vIeX9Qa+4M2NT2AvKOA==
X-ExtLoop1: 1
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.109.43]) ([10.125.109.43])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 10:13:35 -0800
Message-ID: <35b71f1f-6260-4cd0-840e-75e501d06dbc@intel.com>
Date: Mon, 17 Nov 2025 11:13:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] cxl/test: Add unit testing for extended linear
 cache
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20251117144611.903692-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251117144611.903692-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/17/25 7:46 AM, Dave Jiang wrote:
> v2:
> - Use a global variable 'mock_auto_region_size' instead of a static define.
>   Expectation is LMH will change that value for its testing.
> 
> The series adds support for mocking of extended linear cache support
> in cxl_test. A module parameter is introduced to activate the mocking.
> Tests will be added to CXL CLI user tools for regression testing.
> 
> This series depends on the patch [1] that provides the extended linear
> cache size via sysfs.
> 
> [1]: https://lore.kernel.org/linux-cxl/20251022203052.4078527-1-dave.jiang@intel.com/
> 
> Dave Jiang (3):
>   cxl/test: Standardize CXL auto region size
>   cxl/test: Add cxl_test CFMWS support for extended linear cache
>   cxl/test: Add support for acpi extended linear cache
> 
>  tools/testing/cxl/Kbuild      |  1 +
>  tools/testing/cxl/test/cxl.c  | 56 ++++++++++++++++++++++++++++++++---
>  tools/testing/cxl/test/mock.c | 20 +++++++++++++
>  tools/testing/cxl/test/mock.h |  3 ++
>  4 files changed, 76 insertions(+), 4 deletions(-)
> 
> 
> base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c

applied to cxl/next
68f4a852e183 cxl/test: Add support for acpi extended linear cache
4b1c0466c8fb cxl/test: Add cxl_test CFMWS support for extended linear cache
fa59c35167af cxl/test: Standardize CXL auto region size

