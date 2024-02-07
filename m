Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D826F134AA
	for <linux-cxl@vger.kernel.org>; Wed,  7 Feb 2024 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707348727; cv=none; b=qjWxIZmoLYxLSDKmkZ6y6q2na7+7npAyo71jZqOltCaOVyStVTUS1mhADAAzLOhFg3tI1Vlrqf6qvSbS3EJRdyQfOgSeVllHbH2fF5+QWZYVS28QNjeIPMlJQlnBQxOFijOOB6PAMljLy5ey/1NQn81fOhCUI2lu+ue9S7m96ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707348727; c=relaxed/simple;
	bh=h+8/LV6hKXfo2H7Yrw+MF1xV5NTFBtLmrzQGxdEFs4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arySE+eXIIYW1sv42BFgXaHdySXN56silUIYBuUCumXgDbmiWwXXhZJNu9hzMpLgwyJquEX9moMknhXR8Vyim5MiDlk9fHRUpLBClU5t/gqG+LUhLmnICh+g4ot081fmoZuFpPdtdyDdyVky8QWOgxUsuuKIroqpvmvnnENmObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+MuZJp1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+MuZJp1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707348726; x=1738884726;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h+8/LV6hKXfo2H7Yrw+MF1xV5NTFBtLmrzQGxdEFs4E=;
  b=I+MuZJp1WYnB/g34ykRS4jJQel3Aoz3tImjQ0fOnuWPl9iR9gH4F1Z+Z
   h2nFZLjKNgeIPjI6YsB7w3IavMkD0qPF3h5plR+iPSF7Q//6QUFhYaVK0
   SGOSwEx3qZl7se3VtyftCiokZ6jAWw8nSd5jefXXiLLzE5wCq6SdMe7ll
   oILPRI6bNhk2rxat9hYYQDrO/dlb+pSXkuNXsbHa4RfXk5ChohPliScGm
   KAiCAjxmpXb0w1d4r48VMctZD42ahQEeRdaIk7nZSTabgAzRdR9osXDCL
   ivm6HLHQvxp0Q7mIYbqSNZYq4mbAYAZgQAINnaZBorKfP0xAlwXUNMm9j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1250723"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1250723"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 15:32:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1787462"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.163]) ([10.246.112.163])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 15:32:04 -0800
Message-ID: <4419c4dd-91e8-4ab3-8d1c-a59f339eb13e@intel.com>
Date: Wed, 7 Feb 2024 16:32:03 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [NDCTL PATCH v6 3/4] ndctl: cxl: add QoS class check for CXL
 region creation
Content-Language: en-US
To: "Verma, Vishal L" <vishal.l.verma@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Cc: "Schofield, Alison" <alison.schofield@intel.com>
References: <20240207172055.1882900-1-dave.jiang@intel.com>
 <20240207172055.1882900-4-dave.jiang@intel.com>
 <51b7c1c3f354b2fe0f0ac7fca9a35de07c5b7f23.camel@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <51b7c1c3f354b2fe0f0ac7fca9a35de07c5b7f23.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/7/24 2:02 PM, Verma, Vishal L wrote:
> On Wed, 2024-02-07 at 10:19 -0700, Dave Jiang wrote:
>> The CFMWS provides a QTG ID. The kernel driver creates a root decoder that
>> represents the CFMWS. A qos_class attribute is exported via sysfs for the root
>> decoder.
>>
>> One or more QoS class tokens are retrieved via QTG ID _DSM from the ACPI0017
>> device for a CXL memory device. The input for the _DSM is the read and write
>> latency and bandwidth for the path between the device and the CPU. The
>> numbers are constructed by the kernel driver for the _DSM input. When a
>> device is probed, QoS class tokens  are retrieved. This is useful for a
>> hot-plugged CXL memory device that does not have regions created.
>>
>> Add a QoS check during region creation. Emit a warning if the qos_class
>> token from the root decoder is different than the mem device qos_class
>> token. User parameter options are provided to fail instead of just
>> warning.
>>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v6:
>> - Check return value of create_region_validate_qos_class() (Wonjae)
>> ---
>>  Documentation/cxl/cxl-create-region.txt |  9 ++++
>>  cxl/region.c                            | 58 ++++++++++++++++++++++++-
>>  2 files changed, 66 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/cxl/cxl-create-region.txt b/Documentation/cxl/cxl-create-region.txt
>> index f11a412bddfe..d5e34cf38236 100644
>> --- a/Documentation/cxl/cxl-create-region.txt
>> +++ b/Documentation/cxl/cxl-create-region.txt
>> @@ -105,6 +105,15 @@ include::bus-option.txt[]
>>  	supplied, the first cross-host bridge (if available), decoder that
>>  	supports the largest interleave will be chosen.
>>  
>> +-e::
>> +--strict::
>> +	Enforce strict execution where any potential error will force failure.
>> +	For example, if qos_class mismatches region creation will fail.
>> +
>> +-q::
>> +--no-enforce-qos::
>> +	Parameter to bypass qos_class mismatch failure. Will only emit warning.
> 
> Hm, -q is usually synonymous with --quiet, it might be nice to reserve
> it for that in case we ever need to add a quiet mode. Maybe use -Q?

Sure. I'll change it. 
> 
> 
> 
