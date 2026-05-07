Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833CB301704
	for <linux-cxl@vger.kernel.org>; Thu,  7 May 2026 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197268; cv=none; b=C7Grl56Ah/5FDNtZ9JB4aiyR7JCpBufdIIc4es1L9XHE41Y4dn7Ci0pR8Dz4Mrjvysvt8yfqxzIRT0EHMNM9PazvJfjCViyQ8rGUC0O7fdQ00SYQlFma0viDUl4tSkv74PBr/pEhM8I6DJTZ/25RaMqKgEAJoTEX0giIEsbgnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197268; c=relaxed/simple;
	bh=BoxkG4pwwchEl8Q6iZFGuDjulci5e3e5Zjm3aB3rCQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwuTMaDD+wgiVfpgAqUJjmM95U3Olwt36hK5etGJm/Ry+d6fqhNnsbm5u/T9qxHoMdPW29XYa4F44bjklFEHNbURTcksPr4ae0NaihqTLc8DXwWJsx+OZf8zxSSJdh96Voi5C9cf4JFXPLuWpXLRoK6t7pkU03B0la15UbHlqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JvCS1AVg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JvCS1AVg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778197267; x=1809733267;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BoxkG4pwwchEl8Q6iZFGuDjulci5e3e5Zjm3aB3rCQw=;
  b=JvCS1AVg+M9sMIWaYaK0HreWPY7DhPG6evwvq4nBvWryObO9OOuP1cz3
   zJeTyQXiWd5VTatvIgCvc9VhruWmQLJAW5qUtlnhnNtm0pZA5Uwfj3fa7
   Qa1ZSzdMeZ8A9s5ezFFI5Ql33Ij3hyEC6VNOBflFYvL9xhb2xj+vgjWGS
   P7ZNWO/WmKRnXO0+uv91ZBqGFDaLhclhyXxNIGTT53M3yNIO+gPg3S8zT
   5qf7ogBIFHODsN/Ii/uzOxfpnFImENbjeQ4jTf2bcuVG2SOwGv8hNVBkT
   xA/b3dnX4M4qhuElnhboymNsQo2YuZvsSm4iSC4/PVeJMEMUomWuFaMkh
   Q==;
X-CSE-ConnectionGUID: lHXaisBJQQmFY9huSGHxJw==
X-CSE-MsgGUID: NYSGdyXxRZWFpA7smle49w==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="78885636"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="78885636"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 16:41:06 -0700
X-CSE-ConnectionGUID: dO2G8UwIQQ28PFBVbI8RNw==
X-CSE-MsgGUID: hwiSOAxyR8+K2C38kREphA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="232249150"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.240]) ([10.125.110.240])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 16:41:05 -0700
Message-ID: <e188d51c-0076-4e87-aca2-06000009e28c@intel.com>
Date: Thu, 7 May 2026 16:41:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] cxl/test: Add cxl_test accelerator driver
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org
References: <20260422230237.2599333-1-dave.jiang@intel.com>
 <20260422230237.2599333-7-dave.jiang@intel.com>
 <afrPVjKIQEPwCUAJ@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <afrPVjKIQEPwCUAJ@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 10:19 PM, Alison Schofield wrote:
> On Wed, Apr 22, 2026 at 04:02:36PM -0700, Dave Jiang wrote:
>> Add a type2 accelerator mock driver for the platform device that
>> simulates a CXL type2 device. The driver exercises the same
>> minimal API calls that a real CXL type2 driver would utilize.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> snp
> 
>> diff --git a/tools/testing/cxl/test/accel.c b/tools/testing/cxl/test/accel.c
>> new file mode 100644
>> index 000000000000..f21fdd57034e
>> --- /dev/null
>> +++ b/tools/testing/cxl/test/accel.c
>> @@ -0,0 +1,71 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright(c) 2026 Intel Corporation. All rights reserved.
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/module.h>
>> +#include <linux/delay.h>
>> +#include <linux/sizes.h>
>> +#include <linux/bits.h>
>> +#include <cxl/mailbox.h>
>> +#include <crypto/sha2.h>
>> +#include <cxlmem.h>
> 
> 
> Unused includes: crypto/sha2.h, linux/delay.h, linux/vmalloc.h,
> linux/bits.h. Looks copy-pasted from mem.c.

ok

> 
> 
>> +
>> +struct mock_cxl_accel {
>> +	struct cxl_dev_state cxlds;
>> +	struct cxl_memdev *cxlmd;
>> +};
>> +
>> +static int cxl_mock_accel_probe(struct platform_device *pdev)
>> +{
>> +	struct cxl_attach_region attach = {
>> +		.attach = {
>> +			.probe = cxl_memdev_attach_region,
>> +		}
>> +	};
>> +	struct mock_cxl_accel *cxl_accel;
>> +	struct cxl_dev_state *cxlds;
>> +	struct cxl_memdev *cxlmd;
>> +	int rc;
>> +
>> +	cxl_accel = devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM,
>> +					      pdev->dev.id + 1, 0,
>> +					      struct mock_cxl_accel, cxlds,
>> +					      false);
>> +	if (!cxl_accel)
>> +		return -ENODEV;
> 
> devm_cxl_dev_state_create() NULL return means alloc failed, so 
> return should be -ENOMEM.
> 

ok

> 
>> +
>> +	cxlds = &cxl_accel->cxlds;
>> +	cxlds->media_ready = true;
>> +	rc = cxl_set_capacity(cxlds, SZ_512M);
>> +	if (rc)
>> +		return rc;
>> +
>> +	cxlmd = devm_cxl_add_memdev(cxlds, &attach.attach);
> 
> Above is storing pointer to stack allocated cxl_attach_region.
> The stack goes away when probe returns leaving cxlmd->attach
> dangling. I think we get away with it now because all our checks
> of it are NULL checks. Would it ever be derferenced? 
> Maybe devm_kzalloc attach or embed it in the the mock_cxl_accel
> so it sticks around.
> 
> 
> snip
> 
> 

I'll dynamically allocate it. The usage of 'attach' resolves when devm_cxl_add_memdev() returns. I think only place it runs into trouble is during devm cleanup. 

>> +module_platform_driver(cxl_mock_accel_driver);
>> +MODULE_LICENSE("GPL");
> 
> "GPL v2"

checkpatch suggested to use "GPL" instead of "GPL v2"

> 
>> +MODULE_DESCRIPTION("cxl_test: accelerator device mock module");
>> +MODULE_IMPORT_NS("CXL");
>> -- 
>> 2.53.0
>>

