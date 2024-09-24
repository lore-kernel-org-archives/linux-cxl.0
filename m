Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF80146D78
	for <linux-cxl@vger.kernel.org>; Tue, 24 Sep 2024 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727221268; cv=none; b=peRzgukxYb6zsKV0NBhuSB/80IaqVe/wzSrhuCf2WU5wiQD20h81FcUkXE4C9fKlVyTvXisVR5svGpES1+SapbNeQfXKvt3DVmW1afkXiNwmwx+aZbIIUvJmG7/+jhTnWx/Ahhw3FNW3FL6+lbqTrf5es4PD5T7SS+sHZkRJhgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727221268; c=relaxed/simple;
	bh=nsQDOpT++VquSK9yCSTqo6ydwK3PWSL0lSscIkhbtB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXlMrC9GQEhl3vEECso4X8uW1pU+cryMT1ST9NCnJ5LLv2ekdGDraaY0jstrZCDDxkIptbk1AXxJKfCbQS+TgoHhbo5kmCxnukJip3ahd9fxR5+EiGgvEFlynRQLw+O/CHAgZ3BLXFt0zfRAend7wgGzIyJ9dycp5bhv1oi+Vwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdeeFMqi; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdeeFMqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727221267; x=1758757267;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nsQDOpT++VquSK9yCSTqo6ydwK3PWSL0lSscIkhbtB4=;
  b=ZdeeFMqixIgXY6Gwou7GLKT6i95oyMaqXmeJiCAJAc8BWEbx65TAI7Qb
   raOfLtlFRu400WMncauB7uldIF3pgcOCN8P9OFQ8t3frYnbeLBgH6ImEk
   eJ2Nakn6pvdBmZUGvjrexc+SM8hGX70h4fz5+oXWMi9QMDFGv8jafnV5A
   is6dVG49beI3V4eGBlBKhwJmqBYKSqj3dJJS7it6lNRRuYnTCBzCl4OwX
   4q+tlKdiZn+AxmzQuH8JZ6jbIMYrJ7bb2OHchTiCCSCN1vzix5CZSiZas
   ne3DWA3KVqN8xAr+K5nOp1W55RV/kXNpjk+ITDHYHDsi9w1ZL3NPFgpF/
   w==;
X-CSE-ConnectionGUID: mzFO5amgQFqv/eouSYFBpQ==
X-CSE-MsgGUID: 9ewGuOKoSpGxqdJGcjE3Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="37621657"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="37621657"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 16:41:07 -0700
X-CSE-ConnectionGUID: xL3rLDdEQN+l5gLYFwEFtA==
X-CSE-MsgGUID: ld43r86ETOqaOr5ajaOPPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71682916"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.11]) ([10.125.111.11])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 16:41:06 -0700
Message-ID: <c21783e8-3ab6-4aee-9532-206fcffec5d9@intel.com>
Date: Tue, 24 Sep 2024 16:41:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/13] cxl: Fix comment regarding cxl_query_cmd()
 return data
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-3-dave.jiang@intel.com>
 <20240726182926.000050b7@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240726182926.000050b7@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/26/24 10:29 AM, Jonathan Cameron wrote:
> On Thu, 18 Jul 2024 14:32:20 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> The code indicates that the min of n_commands and total commands
>> is returned. The comment incorrectly says it's the max(). Correct
>> comment to min().
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Send this one separately.

Yup. This one is now queued for 6.12.

>> ---
>>  drivers/cxl/core/mbox.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 783cb5ed823f..433819ac36b7 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -547,7 +547,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>>  		return put_user(ARRAY_SIZE(cxl_mem_commands), &q->n_commands);
>>  
>>  	/*
>> -	 * otherwise, return max(n_commands, total commands) cxl_command_info
>> +	 * otherwise, return min(n_commands, total commands) cxl_command_info
>>  	 * structures.
>>  	 */
>>  	cxl_for_each_cmd(cmd) {

