Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E2835F179
	for <linux-cxl@vger.kernel.org>; Wed,  1 Jul 2026 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917626; cv=none; b=qlcTQml7t8fPZkngTmWqv8h1zrAWxEFugbhD+Io3KqHTCJT/o52MVXnaUFyE222tmbwR8asi9PdN0/afbUwiApnyL0OmAuavjn6aD6rX8dYbmkYYRcxTBEwgkFuel4/cUbFZqtIUGvDa/0zKDnRx0angTTWXkGqbiS0SR/aWEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917626; c=relaxed/simple;
	bh=Z4UEkkisuysiM+uplBuybXQVfR+ozEZlcDfe7arlmcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDt4RMCsXPwgBOykH5RIRLG4Kc94swAqI5gForf7CeA3NT123ZUL2+bDWrA6j0clx7pEodSki0IllxXt/039KIhTT31LXV0SwgUvWQdOQn+t6hMDYE+cmR0lfvJhPZThKfJPUY03TkuQIQEF0FPi3DuyZ8Fdh3Mk7XWzZGgO0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hgsff2GA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hgsff2GA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782917624; x=1814453624;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z4UEkkisuysiM+uplBuybXQVfR+ozEZlcDfe7arlmcM=;
  b=Hgsff2GA5bNiYBJ6rGFlv3Nilgb6kR5tR3fH8Q6VX+Ojyzghj0sS++th
   R70M1BRCBwmdpMSeUUQcemT/tokfLLHcrsyZgRDM+fdpm7UWSAJEGI7M2
   YqXifwlWlgnFvOWS/GKlg1pKUFqTtLmgvUp/WoRWGzzKrdI43g/s/TozD
   vYPUQm/MYLv/T15JzAWRCLRt2M/JyJnnBlqFm6hI8yiPY3NPKI8OiDPnE
   bW/Qsqi5MRHERKLhYEG0VNV33HELDgTQgDk1K4t0c16GbiX3Md/yUV1VZ
   6iRE+de+kClE7bNpbqPxt+LaTxoCTVtR6bbu/h43le57qfBE2kPLbgqEc
   w==;
X-CSE-ConnectionGUID: wocdIXBLQMqwse6pcf6fhA==
X-CSE-MsgGUID: bFOIZQMEST2bQb3rmbK9mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="87333896"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="87333896"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 07:53:44 -0700
X-CSE-ConnectionGUID: YkLeFMbhR9uA0tBaCU8smw==
X-CSE-MsgGUID: T6sTOTxFQ2inyevfQr7RdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="282665602"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.66]) ([10.125.110.66])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 07:53:43 -0700
Message-ID: <f44dc381-01b6-4992-ba94-f77b3a5e35c8@intel.com>
Date: Wed, 1 Jul 2026 07:53:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] cxl/test: Add hierarchy enumeration support for
 type2 device
To: Li Ming <ming.li@zohomail.com>
Cc: djbw@kernel.org, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 linux-cxl@vger.kernel.org
References: <20260629221104.3891733-1-dave.jiang@intel.com>
 <20260629221104.3891733-5-dave.jiang@intel.com>
 <e0ef1308-f26a-4869-b5d4-5d14db539973@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <e0ef1308-f26a-4869-b5d4-5d14db539973@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/1/26 12:31 AM, Li Ming wrote:
> On 6/30/2026 6:11 AM, Dave Jiang wrote:
>> Add enumeration of type2 device hierarchy in cxl-test. The type2 device
>> is setup to be directly attached to a root port instead of rp -> switch
>> -> device that type3 hierarchy is setup..
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v7:
>> - Replace platform_device_put() with platform_device_unregister(). (sashiko)
>> ---
>>  tools/testing/cxl/test/cxl.c | 238 ++++++++++++++++++++++++++++-------
>>  1 file changed, 192 insertions(+), 46 deletions(-)
>>
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index 8abe066080bc..801d42ac1bad 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
>> @@ -28,6 +28,7 @@ static bool type2_test;
>>  #define NR_CXL_SWITCH_PORTS 2
>>  #define NR_CXL_PORT_DECODERS 8
>>  #define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
>> +#define NR_CXL_TYPE2_ACCEL 1
>>  
>>  #define MOCK_AUTO_REGION_SIZE_DEFAULT SZ_512M
>>  static int mock_auto_region_size = MOCK_AUTO_REGION_SIZE_DEFAULT;
>> @@ -1747,19 +1748,93 @@ static void cxl_single_topo_exit(void)
>>  	}
>>  }
>>  
>> +static void cxl_type3_mem_exit(void)
>> +{
>> +	struct platform_device *pdev;
>> +	int i;
>> +
>> +	for (i = ARRAY_SIZE(cxl_rcd) - 1; i >= 0; i--) {
>> +		pdev = cxl_rcd[i];
>> +		if (!pdev)
>> +			continue;
>> +		platform_device_unregister(cxl_rcd[i]);
>> +	}
>> +
>> +	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--) {
>> +		pdev = cxl_mem_single[i];
>> +		if (!pdev)
>> +			continue;
>> +		platform_device_unregister(cxl_mem_single[i]);
>> +	}
>> +
>> +	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--) {
>> +		pdev = cxl_mem[i];
>> +		if (!pdev)
>> +			continue;
>> +		platform_device_unregister(pdev);
>> +	}
>> +}
>> +
>> +static void cxl_type2_mem_exit(void)
>> +{
>> +	for (int i = NR_CXL_TYPE2_ACCEL - 1; i >= 0; i--) {
>> +		struct platform_device *pdev = cxl_mem[i];
>> +
>> +		if (!pdev)
>> +			continue;
>> +		platform_device_unregister(pdev);
>> +	}
>> +}
>> +
>>  static void cxl_mem_exit(void)
>>  {
>> -	int i;
>> -
>> -	for (i = ARRAY_SIZE(cxl_rcd) - 1; i >= 0; i--)
>> -		platform_device_unregister(cxl_rcd[i]);
>> -	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--)
>> -		platform_device_unregister(cxl_mem_single[i]);
>> -	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--)
>> -		platform_device_unregister(cxl_mem[i]);
>> +	if (type2_test) {
>> +		cxl_type2_mem_exit();
>> +		return;
>> +	}
>> +
>> +	cxl_type3_mem_exit();
>> +}
>> +
>> +static int cxl_type2_mem_init(void)
>> +{
>> +	int i, rc;
>> +
>> +	for (i = 0; i < NR_CXL_TYPE2_ACCEL; i++) {
>> +		struct platform_device *dport = cxl_root_port[i];
>> +		struct platform_device *pdev;
>> +
>> +		pdev = platform_device_alloc("cxl_type2_accel", i);
>> +		if (!pdev) {
>> +			rc = -ENOMEM;
>> +			goto err_mem;
>> +		}
>> +		pdev->dev.parent = &dport->dev;
>> +		set_dev_node(&pdev->dev, i % 2);
>> +
>> +		rc = platform_device_add(pdev);
>> +		if (rc) {
>> +			rc = -ENOMEM;
>> +			platform_device_put(pdev);
>> +			goto err_mem;
>> +		}
>> +		cxl_mem[i] = pdev;
> 
> Hi Dave,
> 
> Sorry for the delayed review.
> 
> I think that we should use cxl_mock_platform_device_add() helper here when adding the device, otherwise it may hit the issue resolved by the patch[1].
> 
> If we confirm that we need to use the helper here, I can send out a fixup patch for this, or you can make the change directly.

Please send a fixup patch. Thanks!

> 
> 
> Ming
> 
> [1]: https://lore.kernel.org/all/20260520121457.234404-1-ming.li@zohomail.com/
> 
> 

