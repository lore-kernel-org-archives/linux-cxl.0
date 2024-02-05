Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AAB13AA40
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166850; cv=none; b=QGnNNw8nAbJ6JgVBNQxoPtl+xI28DCq5tAsdc1/qVcGkapq54fPB+YvHnmlrG9WlE8dGAiOs7jQvS2LvDoJG8jmzIq1HFXfXaHc9N0dDxPKsVvuf6o49HqCDkSBo+skWRJicn6VdnWZVOES9leoTxBRTrpTSQiQXp5RVIOWvtUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166850; c=relaxed/simple;
	bh=xZT7QChF14M4q4KnucQImK8AvQ2cWS1tTnY4lr7tDcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXpDODYJVg+e45Wlbs6F5mpRerTWsj9ZdPRuYDreQHRR7NGTgzYjliuf1K3qeL1NDn78nCJ2e+Ja4gS2sItqcb1uMHpUvmqSJyoRXjhb3iahFYa4a6gN5YZYJn2+B+r9jFvH13nr/rxwGOL0XsdzJeaN8yVhexBf78/K+hBjS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sxb0OGPI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sxb0OGPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707166849; x=1738702849;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xZT7QChF14M4q4KnucQImK8AvQ2cWS1tTnY4lr7tDcs=;
  b=Sxb0OGPIufea0rsiFNFPSrVuifVSXpTYOx+2j/TWVjp+AYCOyYfbHydr
   1Xt5IP8QEShiciAB2N1NLGSpiFs78VxeZY098RIYwAR+4jWUULhZqIViH
   xECurHeb9VuLwdLBlez+TaQV/YwACNdQF8syaqzVg9egA/K6D69EDSFWK
   EX390o0dkTp3oukiHToBxU1FThmwl7gGuE2xQ5BdV6RG5TZio2FawdFBE
   z1DWlGRJTmLDgFIiJpejvg8llCvsBK0LbFLD3AWy19nrixi2T9Fj3XWvv
   kz1Gn+P4Ib/Xmk0YlVxsm+geKYsEkhS3UgxrZmzs0EDHQHOjLkzSliGbx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11253528"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11253528"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:00:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="844029"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.181]) ([10.246.112.181])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:00:47 -0800
Message-ID: <bc2f72d7-424a-46db-94b3-6e9bcde2a4e6@intel.com>
Date: Mon, 5 Feb 2024 14:00:44 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] cxl: Fix sysfs export of qos_class for memdev
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
References: <20240205193218.1657243-1-dave.jiang@intel.com>
 <20240205193218.1657243-4-dave.jiang@intel.com>
 <65c1474dc8ce7_4e7f52946@dwillia2-xfh.jf.intel.com.notmuch>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <65c1474dc8ce7_4e7f52946@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/5/24 1:38 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> Current implementation exports only to
>> /sys/bus/cxl/devices/.../memN/qos_class. With both ram and pmem exposed,
>> the second registered sysfs attribute is rejected as duplicate. It's not
>> possible to create qos_class under the dev_groups via the driver due to
>> the ram and pmem sysfs sub-directories already created by the device sysfs
>> groups. Move the ram and pmem qos_class to the device sysfs groups and add
>> a call to sysfs_update() after the perf data are validated so the
>> qos_class can be visible. The end results should be
>> /sys/bus/cxl/devices/.../memN/ram/qos_class and
>> /sys/bus/cxl/devices/.../memN/pmem/qos_class.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v4:
>> - Replace open code with sysfs_update_groups() helper. (Jonathan)
>> ---
>>  drivers/cxl/core/cdat.c   |  1 +
>>  drivers/cxl/core/memdev.c | 66 +++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h         |  2 ++
>>  drivers/cxl/mem.c         | 36 ---------------------
>>  4 files changed, 69 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index ecbd209ca70a..f5bebc7e7ccf 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -382,6 +382,7 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
>>  
>>  	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
>>  	cxl_qos_class_verify(cxlmd);
>> +	cxl_memdev_update_attribute_groups(cxlmd);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
>>  
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index dae8802ecdb0..c81f2cd4bcc6 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -447,13 +447,41 @@ static struct attribute *cxl_memdev_attributes[] = {
>>  	NULL,
>>  };
>>  
>> +static ssize_t pmem_qos_class_show(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> +
>> +	return sysfs_emit(buf, "%d\n", mds->pmem_perf.qos_class);
>> +}
>> +
>> +static struct device_attribute dev_attr_pmem_qos_class =
>> +	__ATTR(qos_class, 0444, pmem_qos_class_show, NULL);
>> +
>>  static struct attribute *cxl_memdev_pmem_attributes[] = {
>>  	&dev_attr_pmem_size.attr,
>> +	&dev_attr_pmem_qos_class.attr,
>>  	NULL,
>>  };
>>  
>> +static ssize_t ram_qos_class_show(struct device *dev,
>> +				  struct device_attribute *attr, char *buf)
>> +{
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> +
>> +	return sysfs_emit(buf, "%d\n", mds->ram_perf.qos_class);
>> +}
>> +
>> +static struct device_attribute dev_attr_ram_qos_class =
>> +	__ATTR(qos_class, 0444, ram_qos_class_show, NULL);
>> +
>>  static struct attribute *cxl_memdev_ram_attributes[] = {
>>  	&dev_attr_ram_size.attr,
>> +	&dev_attr_ram_qos_class.attr,
>>  	NULL,
>>  };
>>  
>> @@ -477,14 +505,42 @@ static struct attribute_group cxl_memdev_attribute_group = {
>>  	.is_visible = cxl_memdev_visible,
>>  };
>>  
>> +static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
>> +{
>> +	struct device *dev = kobj_to_dev(kobj);
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>> +
>> +	if (a == &dev_attr_ram_qos_class.attr)
>> +		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
>> +			return 0;
>> +
>> +	return a->mode;
>> +}
>> +
>>  static struct attribute_group cxl_memdev_ram_attribute_group = {
>>  	.name = "ram",
>>  	.attrs = cxl_memdev_ram_attributes,
>> +	.is_visible = cxl_ram_visible,
>>  };
>>  
>> +static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n)
>> +{
>> +	struct device *dev = kobj_to_dev(kobj);
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>> +
>> +	if (a == &dev_attr_pmem_qos_class.attr)
>> +		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
>> +			return 0;
>> +
>> +	return a->mode;
>> +}
>> +
>>  static struct attribute_group cxl_memdev_pmem_attribute_group = {
>>  	.name = "pmem",
>>  	.attrs = cxl_memdev_pmem_attributes,
>> +	.is_visible = cxl_pmem_visible,
>>  };
>>  
>>  static umode_t cxl_memdev_security_visible(struct kobject *kobj,
>> @@ -519,6 +575,16 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
>>  	NULL,
>>  };
>>  
>> +void cxl_memdev_update_attribute_groups(struct cxl_memdev *cxlmd)
>> +{
>> +	int rc;
>> +
>> +	rc = sysfs_update_groups(&cxlmd->dev.kobj, cxl_memdev_attribute_groups);
>> +	if (rc)
>> +		dev_dbg(&cxlmd->dev, "Unable to update memdev attribute group.\n");
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_update_attribute_groups, CXL);
> 
> So I appreciate that Jonathan pointed out this helper as a replacement
> for the hand coded loop over all the attribute groups, but I don't
> understand why all the groups need to be revisited when the groups to
> update are known? It is also a red-flag to handle the result of a
> __must_check helper with a silent dev_dbg() statement.

For some reason I had it stuck in my head that you wanted a caller that updated all the groups.

> 
> Given this qos-class support is optional, sysfs_update_groups(), with
> its violent "tear it all down on failure" semantic, is too heavyweight.
> The failure can not really be handled from the endpoint port code
> because the side-effect tears down all groups even the ones registered
> before the endpoint port driver loads.
> 
> Instead, just do something like this:
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index c81f2cd4bcc6..d4e259f3a7e9 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -575,15 +575,12 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
>         NULL,
>  };
>  
> -void cxl_memdev_update_attribute_groups(struct cxl_memdev *cxlmd)
> +void cxl_memdev_update_perf(struct cxl_memdev *cxlmd)
>  {
> -       int rc;
> -
> -       rc = sysfs_update_groups(&cxlmd->dev.kobj, cxl_memdev_attribute_groups);
> -       if (rc)
> -               dev_dbg(&cxlmd->dev, "Unable to update memdev attribute group.\n");
> +       sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_ram_attribute_group);
> +       sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_pmem_attribute_group);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_memdev_update_attribute_groups, CXL);
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_update_perf, CXL);
>  
>  static const struct device_type cxl_memdev_type = {
>         .name = "cxl_memdev",
> 
> ...where failures are truly ignored.
