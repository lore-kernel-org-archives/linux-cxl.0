Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6584E15E90
	for <linux-cxl@vger.kernel.org>; Wed,  4 Sep 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464155; cv=none; b=QPAZ9cVahPq9UTxcVZSb35bcBxvh2jDM/n4TO/IU3x6hBtfRIgB6p8x21RggwfdihXFVgC5IgHCl2OHyrRXWzM6m29s+8rBFp/42NrKP5EG0sGbKsZ3FMxAfu55sLZXaqJTyUWJByd8cT8jNkE9fV7jEPm3u9rBDfMdbVhZq4m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464155; c=relaxed/simple;
	bh=vpFApYTvmyNEy7mIQyKYgI6QXGszmX3fvKZBobszQeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k78+R6XPzcwUHeL8jY/RSex82y64gH7Wwf8dP0Z23JBAQBKrHI2NcaXh8wPCQpHVKYnIb+rRiuS1SWDVXZm/ThzTwyfb12pOxg7aV+nfhFiezV/R4eA+6Fqhhed0WY9w9yyJgPcad691SsKqvwYtlC31CN1GCXijGABnG7xcT3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M45A4/LW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M45A4/LW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725464154; x=1757000154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vpFApYTvmyNEy7mIQyKYgI6QXGszmX3fvKZBobszQeg=;
  b=M45A4/LWwHZXOYZ5ho/J7u4QfCymRHkEKziLl6efALLmTVSC+bsvtGTS
   +7Io6bakz0Jz69fZ0XFs7mwHLGA0m2EcvWlzhpJk3IGXLPxI71TlcM6oy
   E+KNz0GGDkgp6iPsIYadK5h67ktyyegiS4kVco4DWJTblGebYWQA/FyHm
   cN/7nhL1y/Eip4DrAFL24nDYmnFSeLMsQ7IBHGYsm6Xb5MGkkZaRMK0Em
   u/kDpQ5DV+jbjStuqkcjiOoeEUc53MP4xN1TrxbDSSqRRQJqnRdzjHNfW
   WoMsRruP9jtnz9rWe37HmzR4TPU0eHfCuTZPVnmMtmnCX0p4adX1xtsc/
   A==;
X-CSE-ConnectionGUID: RnXHO9i0SMymST+0pOUmuA==
X-CSE-MsgGUID: AQM0b61cTYqR/BOnFHiuBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="35494062"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="35494062"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 08:35:53 -0700
X-CSE-ConnectionGUID: 3UAA17klTpa5gslkpyLDZQ==
X-CSE-MsgGUID: kaLhPTcpTs6+iFJyhnnmQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="96048781"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.157]) ([10.125.109.157])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 08:35:52 -0700
Message-ID: <ab157ed7-7b4f-497d-b004-9b4e12f091c5@intel.com>
Date: Wed, 4 Sep 2024 08:35:51 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] cxl: move cxl headers to new linux/cxl/ directory
To: Alejandro Lucero Palau <alucerop@amd.com>, linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, fan.ni@samsung.com
References: <20240904000020.1686611-1-dave.jiang@intel.com>
 <20240904000020.1686611-4-dave.jiang@intel.com>
 <e6cdb731-c2f1-5791-79ff-ff5835009475@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <e6cdb731-c2f1-5791-79ff-ff5835009475@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/3/24 11:52 PM, Alejandro Lucero Palau wrote:
> 
> On 9/4/24 00:59, Dave Jiang wrote:
>> Group all cxl related kernel headers into include/linux/cxl directory.
> 
> 
> I tried to do this in the RFC for Type2 support.
> 
> I was told to just move the required bits for accel drivers able to do CXL initialization,
> 
> What has changed since then?

I guess I wasn't there for that discussion. But this make sense to me and Alison seems to agree. The number of cxl related bits are expanding and we probably should group them into its own directory now. I guess we can see if Dan and/or Jonathan objects.

> 
> 
> 
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   MAINTAINERS                                | 2 --
>>   drivers/acpi/apei/einj-cxl.c               | 2 +-
>>   drivers/acpi/apei/ghes.c                   | 2 +-
>>   drivers/cxl/core/port.c                    | 2 +-
>>   drivers/cxl/cxlmem.h                       | 2 +-
>>   include/linux/{einj-cxl.h => cxl/einj.h}   | 0
>>   include/linux/{cxl-event.h => cxl/event.h} | 0
>>   7 files changed, 4 insertions(+), 6 deletions(-)
>>   rename include/linux/{einj-cxl.h => cxl/einj.h} (100%)
>>   rename include/linux/{cxl-event.h => cxl/event.h} (100%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index bf59c003da76..45a56af42a79 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5620,8 +5620,6 @@ L:    linux-cxl@vger.kernel.org
>>   S:    Maintained
>>   F:    Documentation/driver-api/cxl
>>   F:    drivers/cxl/
>> -F:    include/linux/einj-cxl.h
>> -F:    include/linux/cxl-event.h
>>   F:    include/linux/cxl/
>>   F:    include/uapi/linux/cxl_mem.h
>>   F:    tools/testing/cxl/
>> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
>> index 8b8be0c90709..54ef0eef18fe 100644
>> --- a/drivers/acpi/apei/einj-cxl.c
>> +++ b/drivers/acpi/apei/einj-cxl.c
>> @@ -7,7 +7,7 @@
>>    *
>>    * Author: Ben Cheatham <benjamin.cheatham@amd.com>
>>    */
>> -#include <linux/einj-cxl.h>
>> +#include <linux/cxl/einj.h>
>>   #include <linux/seq_file.h>
>>   #include <linux/pci.h>
>>   diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 623cc0cb4a65..55ec68aa417a 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -27,7 +27,7 @@
>>   #include <linux/timer.h>
>>   #include <linux/cper.h>
>>   #include <linux/cleanup.h>
>> -#include <linux/cxl-event.h>
>> +#include <linux/cxl/event.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/mutex.h>
>>   #include <linux/ratelimit.h>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 1d5007e3795a..6506dc2a71b1 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -3,7 +3,7 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/memregion.h>
>>   #include <linux/workqueue.h>
>> -#include <linux/einj-cxl.h>
>> +#include <linux/cxl/einj.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/device.h>
>>   #include <linux/module.h>
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 579d5c647189..838f8f16e7dd 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -6,7 +6,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/cdev.h>
>>   #include <linux/uuid.h>
>> -#include <linux/cxl-event.h>
>> +#include <linux/cxl/event.h>
>>   #include <linux/node.h>
>>   #include <linux/cxl/mailbox.h>
>>   #include "cxl.h"
>> diff --git a/include/linux/einj-cxl.h b/include/linux/cxl/einj.h
>> similarity index 100%
>> rename from include/linux/einj-cxl.h
>> rename to include/linux/cxl/einj.h
>> diff --git a/include/linux/cxl-event.h b/include/linux/cxl/event.h
>> similarity index 100%
>> rename from include/linux/cxl-event.h
>> rename to include/linux/cxl/event.h
> 
