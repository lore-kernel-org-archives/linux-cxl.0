Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13263189535
	for <linux-cxl@vger.kernel.org>; Tue, 24 Sep 2024 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727221463; cv=none; b=sgZ9I1gi0DgLPMFSievhme/CStSP78rGKFxYbRCQuSCLMFqYWIcJY7K1ZZ+C9pdqwdBTya0vlj9ePV36K7/ulQkbl3YeoTkCjvbtJd5rAvnnjJYMfIu86EMXADP8zGL01I90Vi6KLZzoiiNI9Ov9UE5lIgVR4jsvdYpAQdLp8lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727221463; c=relaxed/simple;
	bh=8Ewnw2w55FEjP7cBA/rQyICGyjlQOlQHh6oTt6Uc65E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8kP7b2B6DkiNu8kDjMPQi1CCWB+DhAillXPaFe4+dmqKlAi7cYHIi9xRtjgoFvN+NGA+61kdz+G+FYfbGeMCz9c+WLgdsuBuFC21jPxLe5mZ3/d9UNQM96dEC3hQHClurB4bJh/rO/A8Z7v0ammbHKl1qq4Dc4H3tOhO8ILLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A1lqIfBo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A1lqIfBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727221462; x=1758757462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Ewnw2w55FEjP7cBA/rQyICGyjlQOlQHh6oTt6Uc65E=;
  b=A1lqIfBoEkv9cagvDkYIKyRmXK/ZZw4UGhiJCZFeDuwDr1Aqd1zKP09J
   zmSGNsJUZKfXc02ZkSb+lu17+B8cYTb/y5Cll41spi5eIKnfMMZeYav27
   bFMUuAM1rh2NlwbmUdI+jPhB3/ba+DanMAmBZq+UYfcnPnXvY7sMi6RQ6
   4GonavG6UVmVvI57pLFIhMjVkSxoNHnWaNrxHh6VnyqiMS1u81aEn2cj3
   kuX1zl/ZJdRWL+xO83bOVNIBvC4Rq75cs8tmxXZrjwTbmQ4GegcMGEULw
   oA6rSaW7q2wMFE7dOOvnRBO+V9lqkCF+9LqmEmU/vnrmENYLLMVsgAbVG
   g==;
X-CSE-ConnectionGUID: IECUVTo+SF+/QmT871cnkg==
X-CSE-MsgGUID: oQm95X4ERTWJsokP8PtlyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="29135817"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="29135817"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 16:44:21 -0700
X-CSE-ConnectionGUID: WpD0Tdx/SkaRYosPQq05tw==
X-CSE-MsgGUID: 3Mul28FWQueeSBa29J/6XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71728162"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.11]) ([10.125.111.11])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 16:44:20 -0700
Message-ID: <f57c9889-450f-40de-a3be-55c1fa5d7eaa@intel.com>
Date: Tue, 24 Sep 2024 16:44:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/13] fwctl/cxl: Add driver for CXL mailbox for
 handling CXL features commands
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-9-dave.jiang@intel.com>
 <20240726190257.00003a60@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240726190257.00003a60@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/26/24 11:02 AM, Jonathan Cameron wrote:
> On Thu, 18 Jul 2024 14:32:26 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add an fwctl (auxiliary bus) driver to allow sending of CXL feature
>> commands from userspace through as ioctls. Create a driver skeleton for
>> initial setup.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Main question is why auxiliary bus?

It was convenient at the time. I just copied what Jason had in the mlx5 driver.

> We already do similar stuff in CXL on the cxl bus (e.g.
> the CPMU devices etc) that then register a class
> device with another subsystem.

Sure. I'll adapt it to the cxl_bus. 

DJ

> 
>>  GALAXYCORE GC0308 CAMERA SENSOR DRIVER
>>  M:	Sebastian Reichel <sre@kernel.org>
>>  L:	linux-media@vger.kernel.org
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 9f0fe698414d..0f6ec85ef9c4 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -13,6 +13,8 @@
>>  
>>  static DECLARE_RWSEM(cxl_memdev_rwsem);
>>  
>> +#define CXL_ADEV_NAME "fwctl-cxl"
>> +
>>  /*
>>   * An entire PCI topology full of devices should be enough for any
>>   * config
>> @@ -1030,6 +1032,7 @@ static const struct file_operations cxl_memdev_fops = {
>>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>  				       struct cxl_dev_state *cxlds)
>>  {
>> +	struct auxiliary_device *adev;
> 
> Why an auxdev? It can be any convienient dev to which a driver
> will bind. Why not spin one on the CXL bus for this purpose?
> 
> Maybe that creates and implied relationship you don't want, but
> we already spin lots of devices there like the pmus, so not sure
> why one more is a problem.
> 
>>  	struct cxl_memdev *cxlmd;
>>  	struct device *dev;
>>  	struct cdev *cdev;
>> @@ -1056,11 +1059,27 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>  	if (rc)
>>  		goto err;
>>  
>> +	adev = &cxlds->cxl_mbox.adev;
>> +	adev->id = cxlmd->id;
>> +	adev->name = CXL_ADEV_NAME;
>> +	adev->dev.parent = dev;
>> +
>> +	rc = auxiliary_device_init(adev);
>> +	if (rc)
>> +		goto err;
>> +
>> +	rc = auxiliary_device_add(adev);
>> +	if (rc)
>> +		goto aux_err;
>> +
>>  	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>>  	if (rc)
>>  		return ERR_PTR(rc);
>>  	return cxlmd;
>>  
>> +aux_err:
>> +	auxiliary_device_uninit(adev);
>> +
>>  err:
>>  	/*
>>  	 * The cdev was briefly live, shutdown any ioctl operations that
> 
>> diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
>> new file mode 100644
>> index 000000000000..518ba2afada8
>> --- /dev/null
>> +++ b/drivers/fwctl/cxl/cxl.c
>> @@ -0,0 +1,103 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2024, Intel Corporation
>> + */
>> +#include <linux/fwctl.h>
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/cxl/mailbox.h>
>> +#include <linux/auxiliary_bus.h>
> 
> Pick a standard ordering for header.
> Any ordering is fine.
> 
>> +
>> +static void cxlctl_remove(struct auxiliary_device *adev)
>> +{
>> +	struct cxlctl_dev *ctldev __free(cxlctl) = auxiliary_get_drvdata(adev);
>> +
>> +	fwctl_unregister(&ctldev->fwctl);
> 
> Same question on reference counting I asked in the set Jason posted
> I don't get why we need the __free()
> 
>> +}
>> +
>> +static const struct auxiliary_device_id cxlctl_id_table[] = {
>> +	{ .name = "CXL.fwctl", },
>> +	{},
> No trailing ,
> 
>> +};
>> +MODULE_DEVICE_TABLE(auxiliary, cxlctl_id_table);
>> +
>> +static struct auxiliary_driver cxlctl_driver = {
>> +	.name = "cxl_fwctl",
>> +	.probe = cxlctl_probe,
>> +	.remove = cxlctl_remove,
>> +	.id_table = cxlctl_id_table,
>> +};
>> +
>> +module_auxiliary_driver(cxlctl_driver);
>> +
>> +MODULE_IMPORT_NS(CXL);
>> +MODULE_IMPORT_NS(FWCTL);
>> +MODULE_DESCRIPTION("CXL fwctl driver");
>> +MODULE_AUTHOR("Intel Corporation");
>> +MODULE_LICENSE("GPL");

