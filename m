Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A80392803
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278697; cv=none; b=EvMNGmGCBIYQ3ndFVtOhFvPgUEAufzXHOR5dlrX6JwDO6Q+WTlhzZUjo30VIbFyO9BieYjjIeSWjI154KcAs+6+a8Lkn7tqHfGYEyOtnZf612j8/FGRQ8mSmwYilcMHXDGZZ/9mMNKuLUwyKyqiNdfmLaRpXDknBM95EtlNl+qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278697; c=relaxed/simple;
	bh=Kqh337emE8H4j8onn/WAIlFtyAsZ4lRhLtYovMDr1nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5YGJ3McxaYPBSzsAoNoDW+r9DPClLh//1yhWEoKtQYo9axLmtuw94F4PuCXeeZdTroKp0SOqYii5Z/0BhY3LBhou6PXy/0g+gTfmTBRIXq1cN2SFtHULCbWFLR7Lz4HF5ewfq8bJJPRqRLHYFgx+I1gozU/Xl55tyGBN/rOsdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iozXmv6f; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iozXmv6f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781278696; x=1812814696;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kqh337emE8H4j8onn/WAIlFtyAsZ4lRhLtYovMDr1nU=;
  b=iozXmv6fWJn8oOf4MQQOWjwSp/PgwAT2aw6gUP40fOZrEjhOOiIEC7rT
   cbC/GCFqohzeheCDli3ClXZhr//LeB0pDl2/IlGVYuClrQpZP15U6LjZc
   8nRjmmRqOWUGOIlvWILjwfUldVJP1LGuA+cwFvRpneIb3OiLyVDDYdPKW
   5ChmK31JrDeM/4+rd5caZW7Y9igfPSoW9juAjjpJi95V2Mtw3VFnRkqc5
   DS4VhNfFUQ082lhtNUIgEgL4YT0q/JcatpXtcq3wRFWS12uiTSsYQt/TS
   XauKzrEN5FS/d8NwMAOZUzWAhM/JOjzJ6VLLCMIznQfppGoGJD1xd5f5P
   g==;
X-CSE-ConnectionGUID: 3Hg4tdlKRniPsr3ocrSzNg==
X-CSE-MsgGUID: qL8eb1Z2StyKeYksgbfGbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="92432584"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="92432584"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 08:38:14 -0700
X-CSE-ConnectionGUID: 6aVxWGz8QiCz5mt8MwKxog==
X-CSE-MsgGUID: Qmti3CX4R2GZbmjSv/E8bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="270513726"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 08:38:13 -0700
Message-ID: <92ef48e0-0028-47ba-b545-d284e3e772f7@intel.com>
Date: Fri, 12 Jun 2026 08:38:12 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] cxl/test: Add cxl_test accelerator driver
To: Richard Cheng <icheng@nvidia.com>, sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
References: <20260611234409.256765-7-dave.jiang@intel.com>
 <20260611235806.021F71F000E9@smtp.kernel.org> <aityLD46iQR5I6B6@MWDK4CY14F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aityLD46iQR5I6B6@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/11/26 7:44 PM, Richard Cheng wrote:
> On Thu, Jun 11, 2026 at 11:58:05PM +0800, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Low] The patch invokes non-existent functions `cxl_set_capacity()` and `devm_cxl_probe_mem()`, resulting in a build failure.
>> --
>>
>> commit b886732115c0a94e1bae2a16b1299055ba5c99ea
>> Author: Dave Jiang <dave.jiang@intel.com>
>>
>> cxl/test: Add cxl_test accelerator driver
>>
>> Add a type2 accelerator mock driver for the platform device that
>> simulates a CXL type2 device.
>>
>>> diff --git a/tools/testing/cxl/test/accel.c b/tools/testing/cxl/test/accel.c
>>> new file mode 100644
>>> index 0000000000000..9c8235f9d97b7
>>> --- /dev/null
>>> +++ b/tools/testing/cxl/test/accel.c
>> [ ... ]
>>> +static int cxl_mock_accel_probe(struct platform_device *pdev)
>>> +{
>> [ ... ]
>>> +	cxlds = &cxl_accel->cxlds;
>>> +	cxlds->media_ready = true;
>>> +	rc = cxl_set_capacity(cxlds, SZ_512M);
>>> +	if (rc)
>>> +		return rc;
>>> +
>>> +	cxlmd = devm_cxl_probe_mem(cxlds, &mock_range);
>>
>> [Severity: Low]
>> Does this code cause a build failure? 
>>
>> It appears that cxl_set_capacity() and devm_cxl_probe_mem() are not defined 
>> anywhere in the CXL core subsystem, which would lead to unresolved symbol 
>> errors during compilation.
>>
>>> +	if (IS_ERR(cxlmd))
>>> +		return PTR_ERR(cxlmd);
>>> +	cxl_accel->cxlmd = cxlmd;
>>
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260611234409.256765-1-dave.jiang@intel.com?part=6
>>
> 
> This should be a false positive. devm_cxl_probe_mem() is introduced by Dan's series.
> cxl_set_capacity() is from Alejandro's series.
> 

Right definitely a false positive. Sashiko struggles a bit with cxl_test and it's outside of kernel tree structure. 


> --Richard
>  

