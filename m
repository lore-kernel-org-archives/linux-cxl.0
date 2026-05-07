Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511533B6F9
	for <linux-cxl@vger.kernel.org>; Thu,  7 May 2026 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197060; cv=none; b=YQ1RCxcHbh9FNZ6GBIdS0chAEjk8ZJL3Pln35F49IsfWb0rcLJZrAvnUWCey7ob4T+tA7jbLKgYKkSo3/a/fIRpqJtytT7MWwGE5+gh/WdY8qMm4CY0hBhQ6OpEPw79xsFK9CcnZM8PZstL3Y1ygQ+N6w7yvcZgeAiv+43ywOoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197060; c=relaxed/simple;
	bh=d5dIxM1K3gq3yefoCIJ0MybYRzp7Sp+u/qgkNXKVbdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJCXDgjWfs06qo5Ds5YE4psOz/L9eCklsY0PfDCxFIfpED/EW8w5Jy+Hv69pACre7exIb11shLtwZ0+ECqR8AmWAB/aWccCxlzOM7gYW7e9ucvLObbR71Jpt8vi73QglkbrHuzX0G5usqb5DvzsQekPacdhdBcRrcdzyKpziKf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzRTG3eX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzRTG3eX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778197059; x=1809733059;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d5dIxM1K3gq3yefoCIJ0MybYRzp7Sp+u/qgkNXKVbdY=;
  b=mzRTG3eX0qx+rLtJTrdRGoz+bA/yQwgbpmc14eXYcqBAONrrMV+XFe3W
   jSzbFEoIyU9amjYICSv0IgZ1z22Y6+2ZMypuVgJQ+MZPZP26IBn75yA1b
   8qbvs6X+kXz50J5o2E+KoJj2vMZqiS5ByhYqx/aCyLkcuSMBg75f24QJG
   rrNpkiU5wc7cZ2djMe5kDNYQ6tkhzcZ09wh7W9Bzbj8VUT+EeAs3jMZ75
   2opnCPmioKmn+YlqXiClk7fnKiU7COA29pZPjrhVieHjgBPSuK8x5BlP0
   JqYM1udkg+poeIcvqib58Zq1KBn/t/sFI5p3g64bozaX610Kq2d1u7fh/
   g==;
X-CSE-ConnectionGUID: EhgA5tRZQneQZj45uiqx3w==
X-CSE-MsgGUID: hIkI+4BlT/2YmqIC3aM2fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90622731"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="90622731"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 16:37:39 -0700
X-CSE-ConnectionGUID: 3mvaks+1ScScmFYIKk+oDw==
X-CSE-MsgGUID: W5D7l4R/Q0iI3IYbpzd5VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="238401267"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.240]) ([10.125.110.240])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 16:37:38 -0700
Message-ID: <5d72934e-c9c9-4709-9518-7d8f8d178fbe@intel.com>
Date: Thu, 7 May 2026 16:37:36 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] cxl/test: Add hierarchy enumeration support for type2
 device
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org
References: <20260422230237.2599333-1-dave.jiang@intel.com>
 <20260422230237.2599333-5-dave.jiang@intel.com>
 <afrMEbtJf2m7ZFTF@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <afrMEbtJf2m7ZFTF@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 10:05 PM, Alison Schofield wrote:
> On Wed, Apr 22, 2026 at 04:02:34PM -0700, Dave Jiang wrote:
>> Add enumeration of type2 device hierarchy in cxl-test. The type2 device
>> is setup to be directly attached to a root port instead of rp -> switch
>> -> device that type3 hierarchy is setup..
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  tools/testing/cxl/test/cxl.c | 110 ++++++++++++++++++++++++++++++++---
>>  1 file changed, 103 insertions(+), 7 deletions(-)
>>
> 
> skip
> 
> 
>> +static int cxl_type2_mem_init(void)
>> +{
>> +	int i, rc;
>> +
>> +	for (i = 0; i < NR_CXL_ROOT_PORTS; i++) {
> 
> I'd like to drop the artifact we carry here after copying type3 setup.
> Type 2 doesn't use the second pdev. I think we can make the one accel
> one region constraint explicit.
> 
> How about:
> 
> 	#define NR_CXL_TYPE2_ACCEL 1  /* One Type2 dev, One Region */
> 
> and then in cxl_type2_mem_init():
> 
> replace this:
> 	for (i = 0; i < NR_CXL_ROOT_PORTS; i++) {
> with this:
> 	for (i = 0; i < NR_CXL_TYPE2_ACCEL; i++) {
> 

ok

> 
> 
>> +		struct platform_device *dport = cxl_root_port[i];
>> +		struct platform_device *pdev;
>> +
>> +		pdev = platform_device_alloc("cxl_type2_accel", i);
>> +		if (!pdev)
>> +			goto err_mem;
>> +		pdev->dev.parent = &dport->dev;
>> +		set_dev_node(&pdev->dev, i % 2);
>> +
>> +		rc = platform_device_add(pdev);
>> +		if (rc) {
>> +			platform_device_put(pdev);
>> +			goto err_mem;
>> +		}
>> +		cxl_mem[i] = pdev;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_mem:
>> +	for (i = NR_CXL_ROOT_PORTS - 1; i >= 0; i--) {
>> +		struct platform_device *pdev = cxl_mem[i];
>> +
>> +		if (!pdev)
>> +			break;
>>  		platform_device_unregister(cxl_mem[i]);
>> +	}
>> +	return rc;
>>  }
> 
> snip
> 
>>  
>> +static int cxl_mem_init(void)
>> +{
>> +	if (type2_test)
>> +		return cxl_type2_mem_init();
>> +	return cxl_type3_mem_init();
>> +}
> 
> The precedent above would be good to follow for the topology helpers.
> Now we have scattered 'if (type2_test) return 0;' at 7 sites that need
> to know which topology this is. How about:
> 
> static int cxl_type3_topo_init(void)
> {
> 	/* inits all the things */
> }
> 
> static int cxl_type2_topo_init(void)
> {
> 	return cxl_rootports_populate();
> }
> 
> static int cxl_topo_init(void)
> {
> 	if (type2_test)
> 		return cxl_type2_topo_init();
> 	return cxl_type3_topo_init();
> }
> 
> static void cxl_topo_exit(void)
> {
> 	if (type2_test) {
> 		cxl_rootports_remove();
> 	return;
> 	}
> 
> 	cxl_rch_topo_exit();
> 	cxl_single_topo_exit();
> 	cxl_switches_remove();
> 	cxl_rootports_remove();
> }

ok

> 
>> +
>>  static ssize_t
>>  decoder_reset_preserve_registry_show(struct device *dev,
>>  				     struct device_attribute *attr, char *buf)
>> @@ -2008,6 +2098,9 @@ static int cxl_dsps_populate(void)
>>  
>>  static void cxl_switches_remove(void)
>>  {
>> +	if (type2_test)
>> +		return;
>> +
>>  	cxl_usps_remove();
>>  	cxl_dsps_remove();
>>  }
>> @@ -2016,6 +2109,9 @@ static int cxl_switches_populate(void)
>>  {
>>  	int rc;
>>  
>> +	if (type2_test)
>> +		return 0;
>> +
>>  	BUILD_BUG_ON(ARRAY_SIZE(cxl_switch_uport) != ARRAY_SIZE(cxl_root_port));
>>  	rc = cxl_usps_populate();
>>  	if (rc)
>> -- 
>> 2.53.0
>>

