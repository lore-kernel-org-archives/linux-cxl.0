Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1D408608
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192492; cv=none; b=HypuBpNllyUXfsFJG+7gSisDCCSUKly2+3q/bqPkOGm1vZo8kERMDt1vujUaGeABnSTn4kMT7uY43BLmGx/E5AwRE7pksP2tPAF6ggPz1vhCISNJNreiGzUOUu4rrbK3rJuFixCfV1B014mFFwN+OrEu8GgyWf3SRieKhdW0oSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192492; c=relaxed/simple;
	bh=8rapZTi8F+11Ci/kQ6UASbqnB6Wa+4Y3kaONLs2Y9Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IX+VAC6Q8zAlCvU59KV6aPrm/pgXWSBpv7SONksteJDMH4vWs+d4/yCm9vv2xxD5+wJdYfpRJ70L1hzdZLHCx8GT6Ns+tKTt/agEkGeq3FrhQSNOCup6jnKXhnYWUK3bPx4pJ1XPzD9ZPp2TSKp+ChvOuXdIvkzWktbhMNtl46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSmoV1hG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSmoV1hG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781192490; x=1812728490;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8rapZTi8F+11Ci/kQ6UASbqnB6Wa+4Y3kaONLs2Y9Cg=;
  b=PSmoV1hGj8+xDgaWoRUoVUDYym/rpySaPS+pEjtGcV8B0VFW/U67i3rE
   oszUxjody3/VCICPSsFFm6MaQGSMqygYj5nqUEu8YfBQdCuaYDVaAw3rv
   p+eDIFxilVU3YKc0O6WcoQQ/4vpwXixciO4M4OubZqgDe55Peraz3QPWJ
   OIxUl8rxdYxd9gAXcJLXFYWznY46cMc1Q9n6amHOQlJs9LuMKoEn0/eZ7
   pPMIh6QS9fCALDSu6iQK7YpPknqCGeTl2tpOAvkisfgvQu59++zxu2hCi
   hRYSjN+x7DDj2wT7UrMUjuTOswGRaB0dsMwegpCSk26cq+nNG7UQBXw6l
   A==;
X-CSE-ConnectionGUID: O4iC6btPRD2SV5gukld2Ng==
X-CSE-MsgGUID: ftNMd1AdQZywuG3YZqm/dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="104676327"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="104676327"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 08:41:30 -0700
X-CSE-ConnectionGUID: JRnlg7SmQwOg6Xz7ePJDIA==
X-CSE-MsgGUID: 1AOTgHwoR3ia9IdwSzAFNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246598148"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.105]) ([10.125.110.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 08:41:29 -0700
Message-ID: <69ca9378-749e-43ce-afbe-435c66076b4d@intel.com>
Date: Thu, 11 Jun 2026 08:41:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] cxl/test: Add cxl_test accelerator driver
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
References: <20260611152124.3656434-7-dave.jiang@intel.com>
 <20260611153241.33B931F00898@smtp.kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260611153241.33B931F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/11/26 8:32 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Undeclared API Usage / Build Failure due to missing functions `cxl_set_capacity` and `devm_cxl_probe_mem`.

False positive

> --
> 
> commit fd0aec5a2701e0475907c9138fa0ea33cfb68569
> Author: Dave Jiang <dave.jiang@intel.com>
> 
> cxl/test: Add cxl_test accelerator driver
> 
> This commit adds a mock platform driver simulating a CXL type 2 accelerator
> device. It is designed to test minimal API calls required by real CXL type 2
> drivers.
> 
>> diff --git a/tools/testing/cxl/test/accel.c b/tools/testing/cxl/test/accel.c
>> new file mode 100644
>> index 0000000000000..9c8235f9d97b7
>> --- /dev/null
>> +++ b/tools/testing/cxl/test/accel.c
> [ ... ]
>> +static int cxl_mock_accel_probe(struct platform_device *pdev)
>> +{
> [ ... ]
>> +	cxlds = &cxl_accel->cxlds;
>> +	cxlds->media_ready = true;
>> +	rc = cxl_set_capacity(cxlds, SZ_512M);
>> +	if (rc)
>> +		return rc;
>> +
>> +	cxlmd = devm_cxl_probe_mem(cxlds, &mock_range);
> 
> [Severity: Low]
> Are the cxl_set_capacity and devm_cxl_probe_mem functions defined anywhere in
> the kernel source tree?
> 
> It appears these functions do not exist, which causes an implicit declaration
> error and undefined references during compilation. Will this lead to an
> immediate build failure for the test module?
> 

