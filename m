Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CB32EBDE9
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278547; cv=none; b=U1+3nPHOzkbzMD+FYr59mQybaqpx2KWdbvkwj4SfZDIBORX1PloPz0W+jbI/Ay/9uyki9iuOEp15uhYWNkDgsOY+RfEIktOeEindHUHazIdgcPXzO25rtGub5+rfCEc3fN4slJyRk0edXNGMysGfvl0XijEA8UoMixyE/TqtZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278547; c=relaxed/simple;
	bh=GZ0HucKEYHQX1M9VWiReyvvuKAUDmldWGQ92b75c2zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIWGcj2ziG/ehoAchKrezt5goYdhkh3/xxwKmI+dQfEjSrXY8rgvH0VT3h87s5XJUgq8fn4dMW0h74aWpOKKTTvK49VySx99sFJMSWaYFZLZexyCTlHKWTbtoadc+Asf+3nu+YQ9/kFDfTj/cAjfDWjwgDhD/o9+TY+pkiWzo2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3YIfNxj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3YIfNxj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781278546; x=1812814546;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GZ0HucKEYHQX1M9VWiReyvvuKAUDmldWGQ92b75c2zg=;
  b=Z3YIfNxjJhOKHW7bkEVQ0ha+FG/ZIIncfbwCPFAKYVlh0PWwORlVBxwd
   7TrC0NICEzpVkCw04y73YqlWwu5LXcACmwo0psuCidYCmalOPzp8GkZGh
   /YCpDVBeF8vsw8pkCpvOayO2+KQ8tgo04rkq1x0u2R0x68KIQHuCOZZgR
   K4Jb1UnpxnM2+gqCkZUjxD1AhWUqaPO4bbvbXqq5WKksLCk7jF5Hq43Sw
   cgyxcvomG/SfTjTDA2uNtvSTE4dKpxjDmupQLqebW2fcGBfCuMYL3o/JY
   fdbCf8JHbmoK3xMOkEffDe3jAzdze9zg5qxtBBkSs35ldfomMm9FB57Y7
   g==;
X-CSE-ConnectionGUID: 9XQivX82T+C8Wol4nobZzw==
X-CSE-MsgGUID: i/9E7/ddTzCzyF2PUj0mtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="92432287"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="92432287"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 08:35:45 -0700
X-CSE-ConnectionGUID: CIQHs7MgTHW2EBqrF5r6tQ==
X-CSE-MsgGUID: PIkdON8BSy+0P1UmaDQsbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="270513180"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 08:35:45 -0700
Message-ID: <5cf32fe7-da4a-46ab-b1ff-8cc5b0678dc3@intel.com>
Date: Fri, 12 Jun 2026 08:35:43 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] cxl/test: Add test for module parameters
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org, djbw@kernel.org, dave@stgolabs.net,
 jic23@kernel.org, alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20260611234409.256765-1-dave.jiang@intel.com>
 <20260611234409.256765-2-dave.jiang@intel.com> <aittuDSmdIzR7X5U@MWDK4CY14F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aittuDSmdIzR7X5U@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/11/26 7:33 PM, Richard Cheng wrote:
> On Thu, Jun 11, 2026 at 04:44:04PM +0800, Dave Jiang wrote:
>> Add a test for module paraters during module init to make sure that
>> only one is activated.
> 
> "paraters" -> "parameters".

ok

> 
>>
>> Suggested-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v5:
>> - Add test for hmem_test module parameters. (sashiko)
>> ---
>>  tools/testing/cxl/test/cxl.c       | 20 ++++++++++++++++++++
>>  tools/testing/cxl/test/hmem_test.c |  3 ++-
>>  tools/testing/cxl/test/mock.h      |  2 ++
>>  3 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index 296516eecfd6..1c8ac8bdd8f7 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
>> @@ -1814,11 +1814,31 @@ static struct attribute *cxl_acpi_attrs[] = {
>>  };
>>  ATTRIBUTE_GROUPS(cxl_acpi);
>>  
>> +static bool __init have_multiple_modparms(void)
>> +{
>> +	int count = 0;
>> +
>> +	if (interleave_arithmetic)
>> +		count++;
> 
> Should we make it a boolean ?
> It should only work with 0 or 1 right ?

I don't follow. The intention is that if there are >1 parameters then it fails.

DJ

> 
> --Richard
> 
>> +	if (extended_linear_cache)
>> +		count++;
>> +	if (fail_autoassemble)
>> +		count++;
>> +	if (hmem_test)
>> +		count++;
>> +
>> +	return count > 1;
>> +}
>> +
>>  static __init int cxl_test_init(void)
>>  {
>>  	int rc, i;
>>  	struct range mappable;
>>  
>> +	/* Enforce a single module param active at a time */
>> +	if (have_multiple_modparms())
>> +		return -EINVAL;
>> +
>>  	cxl_acpi_test();
>>  	cxl_core_test();
>>  	cxl_mem_test();
>> diff --git a/tools/testing/cxl/test/hmem_test.c b/tools/testing/cxl/test/hmem_test.c
>> index 3a1a089e1721..0fa00f7e16db 100644
>> --- a/tools/testing/cxl/test/hmem_test.c
>> +++ b/tools/testing/cxl/test/hmem_test.c
>> @@ -3,8 +3,9 @@
>>  #include <linux/moduleparam.h>
>>  #include <linux/workqueue.h>
>>  #include "../../../drivers/dax/bus.h"
>> +#include "mock.h"
>>  
>> -static bool hmem_test;
>> +bool hmem_test;
>>  
>>  static void hmem_test_work(struct work_struct *work)
>>  {
>> diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
>> index 4f57dc80ae7d..846d7c5d6eaa 100644
>> --- a/tools/testing/cxl/test/mock.h
>> +++ b/tools/testing/cxl/test/mock.h
>> @@ -5,6 +5,8 @@
>>  #include <linux/dax.h>
>>  #include <cxl.h>
>>  
>> +extern bool hmem_test;
>> +
>>  struct cxl_mock_ops {
>>  	struct list_head list;
>>  	bool (*is_mock_adev)(struct acpi_device *dev);
>> -- 
>> 2.54.0
>>
>>

