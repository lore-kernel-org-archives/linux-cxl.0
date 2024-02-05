Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41AF47F7B
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 18:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156317; cv=none; b=JnIxipQYh/2aLo8BCNlJvrjY1axAxcHlYrvmZWI5wcusKuMTKTtoOkHaBSeNKIY8N6GixvVd6UVsEK30FGG6RzMb8zYJDptJmMR4G27/HhFjrDkFN5BHAjgJW/H5hI7Gpo+3wUutdgKJzR3F6V+WX18T/dmBI+8mhd11BBMg9ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156317; c=relaxed/simple;
	bh=K6oTfg5LN2eYzL7XSL315BSXdHOq6hew174KQoNKth0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rar16UV24sKqENxmOYx5n1K7Fn4HKxKOEEoP9IWuLNvEmEoxGg8mnY/9PRsLY9D/7Rv0EgCDHtRSNCQWFUya96FMfUGvR8cuMZnL/yVCbKAIPQ5btvrg0sJbjZWWrfyyRKkXdHSvL9s8NHyLtyUUNOE2BRe12wvvMD9HF9jjjJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8d666Pr; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8d666Pr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707156316; x=1738692316;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K6oTfg5LN2eYzL7XSL315BSXdHOq6hew174KQoNKth0=;
  b=Q8d666Prq8NbDNbhGqVK+dvhCAJtndBcPy2UhuuoHwvZKoOWpDXGdpYX
   oRvbehCYGR6zc/meTAjvhwNoRZjBOOacns5jmWn3HjofNOhnsC/SjzCCE
   ulER0SBiS0wQjael8AaR+Tlo1pUwuSWMA921dZzuuNl1+9M6GhNDQIa98
   +70lNgbD3ZSzEYr2o+6aF1CyvVpV9laGZKsJ/KeMNoX/w2hRoZ+xsQSsS
   itP4FLDACA4u8txb/ZsKBb1vwjLwPJJb8i/xABkuJOcdmM3NtzOBpldZk
   K++VSBQ74H5JxmMHC4qnStqrZn0gdBWq+8hsbYn5kFjmTtyt9mtd+tQHb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="476684"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="476684"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:05:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="994033"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.181]) ([10.246.112.181])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:05:14 -0800
Message-ID: <c395404b-dd15-4dc7-aa95-7439d03f9054@intel.com>
Date: Mon, 5 Feb 2024 11:05:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] cxl: Change 'struct cxl_memdev_state' *_perf_list
 to single 'struct cxl_dpa_perf'
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net
References: <20240201214731.1297389-1-dave.jiang@intel.com>
 <20240205113206.00004f1f@Huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240205113206.00004f1f@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/5/24 4:32 AM, Jonathan Cameron wrote:
> On Thu, 1 Feb 2024 14:47:29 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> In order to address the issue with being able to expose qos_class sysfs
>> attributes under 'ram' and 'pmem' sub-directories, the attributes must
>> be defined as static attributes rather than under driver->dev_groups.
>> To avoid implementing locking for accessing the 'struct cxl_dpa_perf`
>> lists, convert the list to a single 'struct cxl_dpa_perf' entry in
>> preparation to move the attributes to statically defined.
>>
>> While theoretically a partition may have multiple qos_class via CDAT, this
>> has not been encountered with testing on available hardware. The code is
>> simplified for now to not support the complex case until a use case is
>> needed to support that.
>>
>> Link: https://lore.kernel.org/linux-cxl/65b200ba228f_2d43c29468@dwillia2-mobl3.amr.corp.intel.com.notmuch/
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> A few comments inline.
> 
> Jonathan
> 
>> ---
>> v3:
>> - Add to commit log about simplification (Dan)
>> - Remove check for dev->driver (Dan)
>> - Remove check for invalid qos_class (Dan)
>> ---
>>  drivers/cxl/core/cdat.c | 81 ++++++++++++-----------------------------
>>  drivers/cxl/core/mbox.c |  4 +-
>>  drivers/cxl/cxlmem.h    | 10 ++---
>>  drivers/cxl/mem.c       | 28 ++------------
>>  4 files changed, 33 insertions(+), 90 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 6fe11546889f..55b82dfd794b 100644
>> --- a/drivers/cxl/core/cdat.c
> 
>>  static void cxl_qos_match(struct cxl_port *root_port,
>> -			  struct list_head *work_list,
>> -			  struct list_head *discard_list)
>> +			  struct cxl_dpa_perf *dpa_perf)
>>  {
>> -	struct cxl_dpa_perf *dpa_perf, *n;
>> +	int rc;
>>  
>> -	list_for_each_entry_safe(dpa_perf, n, work_list, list) {
>> -		int rc;
>> +	if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
>> +		return;
>>  
>> -		if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
>> -			return;
>> -
>> -		rc = device_for_each_child(&root_port->dev,
>> -					   (void *)&dpa_perf->qos_class,
>> -					   match_cxlrd_qos_class);
>> -		if (!rc)
>> -			list_move_tail(&dpa_perf->list, discard_list);
>> -	}
>> +	rc = device_for_each_child(&root_port->dev,
> 
> Over aggressive wrap.

Will fix

> 
>> +				   &dpa_perf->qos_class,
>> +				   match_cxlrd_qos_class);
>> +	if (!rc)
>> +		reset_dpa_perf(dpa_perf);
> 
> I'm not particularly keen on a function that on failure to match resets
> some internal state in one of it's inputs.
> Would prefer to see this return a bool then the caller decide to reset it.

Ok I'll change.
> 
>>  }
>>  
>>  static int match_cxlrd_hb(struct device *dev, void *data)
>> @@ -334,23 +312,10 @@ static int match_cxlrd_hb(struct device *dev, void *data)
>>  	return 0;
>>  }
>>  
> 
>>  static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>>  {
>>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> -	LIST_HEAD(__discard);
>> -	struct list_head *discard __free(dpa_perf) = &__discard;
>>  	struct cxl_port *root_port;
>>  	int rc;
>>  
>> @@ -363,16 +328,16 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>>  	root_port = &cxl_root->port;
>>  
>>  	/* Check that the QTG IDs are all sane between end device and root decoders */
>> -	cxl_qos_match(root_port, &mds->ram_perf_list, discard);
>> -	cxl_qos_match(root_port, &mds->pmem_perf_list, discard);
>> +	cxl_qos_match(root_port, &mds->ram_perf);
>> +	cxl_qos_match(root_port, &mds->pmem_perf);
>>  
>>  	/* Check to make sure that the device's host bridge is under a root decoder */
>>  	rc = device_for_each_child(&root_port->dev,
>>  				   (void *)cxlmd->endpoint->host_bridge,
> 
> Why is the explicit void * cast needed?  It's not removing const or anything like
> that so usual c rules on it being fine to implicitly cast to void * should apply.

I'll fix that in a different patch.

> 
> 
>>  				   match_cxlrd_hb);
>>  	if (!rc) {
>> -		list_splice_tail_init(&mds->ram_perf_list, discard);
>> -		list_splice_tail_init(&mds->pmem_perf_list, discard);
>> +		reset_dpa_perf(&mds->ram_perf);
>> +		reset_dpa_perf(&mds->pmem_perf);
>>  	}
>>  
>>  	return rc;
