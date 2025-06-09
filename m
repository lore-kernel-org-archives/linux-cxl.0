Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAD822FAC3
	for <linux-cxl@vger.kernel.org>; Mon,  9 Jun 2025 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749513561; cv=none; b=JECUDsgHTBD3Y4GkfIK/J9SNAFV2MjBAsGXTahl4uMcRFjjRz7hdhI8tspYb41Ks36xTt4dooB+debp2XI72DQX3ar1+NYTplkOvxkZ6wB0/jmDYDOt/2Jwbuyyk+lNdxRmuCeX9bjcRH8V7/EDRNYJYxnReQU3NWXTR616ICiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749513561; c=relaxed/simple;
	bh=EinrBncJH3YtvbiItbkUi1TQO9oqgXR1jXRxZVJpg0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ocip4cVLAD+turnUJXn2/hrRmx0wcXkKl2YlF2Gmkgf5iNf+UHSE4B7d5KyUemKUNqsHvh0H8smHfYbUc4G5UhA4qqZO5iy+FlR/UMeeJfqmOGhlkV8KsmIKjxuRZu71TWc5MkrbXUVmNRwxeaE0E/09wFWJr773Z74DS5CCHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXO7stf6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXO7stf6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749513559; x=1781049559;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EinrBncJH3YtvbiItbkUi1TQO9oqgXR1jXRxZVJpg0I=;
  b=OXO7stf6JMY0ns2Yc2rckoWlQWRTPpjdwpeQeT9cX+igpoyy/XkL7YuW
   lhbuSQNCW8l0mZ3FqsQW33Sz8STjuoCcjNmmnipVccL8MIKC6qkt1xBIg
   2KLxgS6QXCu9cMSfs1Y/1vp73tDkRpq41w5Vvb9L8UbBTd4OGHeQy2NTT
   EsyilmfD/XW8xYoLPYfmf/BaDc7u3q6r5S8dUKhe0U5Do5szUl5Z0AKyT
   24wyFt/NPrVLXvLjNRDo6pN2oJ18D+x+HKaIsWtrZZ0/54nwhtWMavPzk
   /D51LG4gyl9ouUtGnsX0Uy/FjXt5SU83RQ2AGP4nfzb7bhKbBGxGkV+9q
   g==;
X-CSE-ConnectionGUID: n1Ky1/RhRf6+QVR0KONFWg==
X-CSE-MsgGUID: gqsE/46sTF2dQw2VHFAj6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51701290"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="51701290"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 16:59:15 -0700
X-CSE-ConnectionGUID: ltSd0PAkTvyGvpfxyaTrPA==
X-CSE-MsgGUID: ab0l3rV5TGmHuO2+w6kxTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="147017404"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.99]) ([10.125.111.99])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 16:59:13 -0700
Message-ID: <ea55b113-510c-470d-934c-38915cd7137e@intel.com>
Date: Mon, 9 Jun 2025 16:59:12 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Remove core/acpi.c and cxl core dependency on ACPI
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250605001148.1698633-1-dave.jiang@intel.com>
 <2529357.LH7GnMWURc@fdefranc-mobl3>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <2529357.LH7GnMWURc@fdefranc-mobl3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/9/25 10:03 AM, Fabio M. De Francesco wrote:
> Hi Dave,
> 
> On Thursday, June 5, 2025 2:11:47 AM Central European Summer Time Dave Jiang wrote:
>> It was a mistake to introduce core/acpi.c and putting ACPI dependency on
>> cxl_core when adding the extended linear cache support. Add a callback
>> in the cxl_root_decoder to retrieve the extended linear cache size from
>> ACPI via the cxl_acpi driver.
>>
>> In order to deal with cxl_test, a device parameter had to be introduced
>> to the hmat_get_extended_linear_cache_size() call in order to help with
>> the mock wrapped function from ACPI. Even though the 'struct device' is
>> not used by the actual hmat_get_extended_linear_cache_size() function.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/acpi/numa/hmat.c      |  4 +++-
>>  drivers/cxl/acpi.c            | 15 ++++++++++++++-
>>  drivers/cxl/core/Makefile     |  1 -
>>  drivers/cxl/core/acpi.c       | 11 -----------
>>  drivers/cxl/core/core.h       |  2 --
>>  drivers/cxl/core/port.c       |  5 ++++-
>>  drivers/cxl/core/region.c     |  6 +++++-
>>  drivers/cxl/cxl.h             | 12 +++++++++++-
>>  include/linux/acpi.h          |  6 ++++--
>>  tools/testing/cxl/Kbuild      |  2 +-
>>  tools/testing/cxl/test/cxl.c  | 20 ++++++++++++++++++++
>>  tools/testing/cxl/test/mock.c | 23 +++++++++++++++++++++++
>>  tools/testing/cxl/test/mock.h |  4 ++++
>>  13 files changed, 89 insertions(+), 22 deletions(-)
>>  delete mode 100644 drivers/cxl/core/acpi.c
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index 9d9052258e92..bc8441dc7fe2 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -110,6 +110,7 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
>>  
>>  /**
>>   * hmat_get_extended_linear_cache_size - Retrieve the extended linear cache size
>> + * @dev: device for debug output
> 
> Isn't dev used to find a port check if it is a mock one?
> BTW, should the test part go to a separate patch? 

I'm dropping the dev parameter. So this change should go away.

> 
>>   * @backing_res: resource from the backing media
>>   * @nid: node id for the memory region
>>   * @cache_size: (Output) size of extended linear cache.
>> @@ -117,7 +118,8 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
>>   * Return: 0 on success. Errno on failure.
>>   *
>>   */
>> -int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
>> +int hmat_get_extended_linear_cache_size(struct device *dev,
>> +					struct resource *backing_res, int nid,
>>  					resource_size_t *cache_size)
>>  {
>>  	unsigned int pxm = node_to_pxm(nid);
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index cb14829bb9be..7076d471ada5 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -337,6 +337,19 @@ static int add_or_reset_cxl_resource(struct resource *parent, struct resource *r
>>  	return rc;
>>  }
>>  
>> +static int cxl_acpi_get_extended_linear_cache_size(struct cxl_root_decoder *cxlrd,
>> +						   struct resource *backing_res,
>> +						   int nid,
>> +						   resource_size_t *size)
>> +{
>> +	return hmat_get_extended_linear_cache_size(&cxlrd->cxlsd.cxld.dev,
>> +						   backing_res, nid, size);
>> +}
>> +
>> +static const struct cxl_rcd_ops acpi_rcd_ops = {
> 
> What does _rcd_ stand for?

Not sure why I named it rcd. Going to change it to rd for root decoder.
> 
>> +	.get_extended_linear_cache_size = cxl_acpi_get_extended_linear_cache_size,
>> +};
>> +
> 
> [skip]
> 
>>  };
>>  
>> +static int mock_hmat_get_extended_linear_cache_size(struct device *dev,
>> +						    struct resource *backing_res,
>> +						    int nid, resource_size_t *size)
>> +{
>> +	struct cxl_decoder *cxld;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return -EINVAL;
> 
> Is there any real chance that dev is not a root decoder? Is that check necessary?

dev getting dropped.

> 
> Thanks,
> 
> Fabio
> 
> 
> Thanks,
> 
> Fabio
> 
> 
> 

