Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6C525CC49
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747778151; cv=none; b=DoUCstmQJ76Rs/izqk0xoX+7Z937P4JabKfWJmrP/mbsr85pL6M47y2wIcunOYparDP7an6lNvoxrIU7SGgGlwl3mR3IP4ZZV2bdy3VOJitxcnUQDGyy1eOEDiBtB14CJZ+GeLNSB6PWwX77fg9vI3JsyDblBqUQ2EB92ltrUNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747778151; c=relaxed/simple;
	bh=DgOKOItOu/D2o9pHDYCFktSy0HZ7KCzUNQ0v742iQZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8lcrbMzQkIg9I99dYSQf6ruUeVqQhTnjXl1WQjy8qzpAPBC5fBXJxjFJlHcBnqRkwugKxkKXTwBGb0mS6JEYGT12gKR5LRBkWpCVy1gEAXVj/gemrZRgDkpnXmICCIlI+9KmNjV4GVFWs99QTJjyh94bs7pRkrZoDtJ/TlfPpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oy7CBhlw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oy7CBhlw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747778150; x=1779314150;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DgOKOItOu/D2o9pHDYCFktSy0HZ7KCzUNQ0v742iQZM=;
  b=Oy7CBhlwTE23AwL0s49UsztlAjSBxQFO4X0Frxm+yUOzCLQlubMuiILK
   3XjwOaQhML9k/K14Diufp6eI9VVb/0s/hm5I0icSI0jaIRSJumMwV8QyH
   YKZuQ6PKEHPH/q6WpV1QwEdC02U82rYMhIIUU7IDcTm8sAN3okndAXcsY
   /4kRHzhIYDwXLrNGvM+NzZnhNuLksxa92MkQZhITba6GYlJd1RlwDCuTG
   kQfimktLcxB7b6OPGtfsjTtRhrsV6Uw+Vdl3pzb0fyDk856x3LyFS3Yh9
   Z694EV9yyfOX52t5rcAT7vnOAIBMJaHxQrzAXjLM2bJhDToWMmE8hPk7M
   A==;
X-CSE-ConnectionGUID: ty0XiUPHSQ2cxgzi1uYZwA==
X-CSE-MsgGUID: HnFbgDtMQDOWk7ibU76kjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49888068"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49888068"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 14:55:49 -0700
X-CSE-ConnectionGUID: kKrbddbOSt2O1xQB6oy2gQ==
X-CSE-MsgGUID: 1+VKXqYySJWDPvHEly9j3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="143815509"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.92]) ([10.125.109.92])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 14:55:47 -0700
Message-ID: <907f6125-49b3-40ea-9a8a-ceea85009b51@intel.com>
Date: Tue, 20 May 2025 14:55:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] cxl: Add helper to detect top of CXL device
 topology
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com,
 rrichter@amd.com, ming.li@zohomail.com
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-9-dave.jiang@intel.com>
 <20250520133429.000056ab@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250520133429.000056ab@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/20/25 5:34 AM, Jonathan Cameron wrote:
> On Tue, 6 May 2025 17:43:08 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add a helper to replace the open code detection of CXL device hierarchy
>> root. The helper will be used for delayed hostbridge port creation later
>> on.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Another one that I think can be yanked out ahead of the
> main series so we can focus on the more substantial stuff.

Yeah I'll move this to the beginning.
> 
> Reviewed-by: Jonathan Cameron <Jonsathan.Cameron@huawei.com>
> 
>> ---
>>  drivers/cxl/core/port.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index e212bc2faada..259b217e812f 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -39,6 +39,15 @@ DECLARE_RWSEM(cxl_region_rwsem);
>>  static DEFINE_IDA(cxl_port_ida);
>>  static DEFINE_XARRAY(cxl_root_buses);
>>  
>> +/*
>> + * The terminal device in PCI is NULL and @platform_bus
>> + * for platform devices (for cxl_test)
>> + */
>> +static bool is_cxl_hierarchy_head(struct device *dev)
>> +{
>> +	return (!dev || dev == &platform_bus);
>> +}
>> +
>>  int cxl_num_decoders_committed(struct cxl_port *port)
>>  {
>>  	lockdep_assert_held(&cxl_region_rwsem);
>> @@ -1774,11 +1783,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  		struct device *uport_dev;
>>  		struct cxl_dport *dport;
>>  
>> -		/*
>> -		 * The terminal "grandparent" in PCI is NULL and @platform_bus
>> -		 * for platform devices
>> -		 */
>> -		if (!dport_dev || dport_dev == &platform_bus)
>> +		if (is_cxl_hierarchy_head(dport_dev))
>>  			return 0;
>>  
>>  		uport_dev = dport_dev->parent;
> 
> 

