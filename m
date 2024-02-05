Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CDA47F5B
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157397; cv=none; b=CeF8RC4XhPozybS+44jtLlMScE2Mf59CQ9jXd7c+6h3v/eYL/hoUdfXpgH4gi0qW3ojeLxGIfKm2cPMoqcpr4xQZLebBrx4aVDGHMVA+5no9L4MeKOcg4lmM8pmRu/rv60K3s5vvtUfJHCR3KyYNEuhHhbiL7Ta6H5g2OFSrGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157397; c=relaxed/simple;
	bh=PBleCaI7RBbyxunhxw84xPorX1Xqh1CM8SxQLXMtfD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdans+A0Vfpkbbk2iIC425dg5cFkCYl7oqXGwXmOQRpNWAyp49ZDm06zrtob17nkWoHuHDMdIOJGC9ECVu2BBrfrX9HZ5bhv1FMfENJ4bX73oegGqDLJjFaxZwUrUi834kcxiH2KJN1tuBnxHIBnc4Kb5ilXgwz1LnXr7Iz2s7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJgJXxtW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJgJXxtW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707157394; x=1738693394;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PBleCaI7RBbyxunhxw84xPorX1Xqh1CM8SxQLXMtfD0=;
  b=WJgJXxtWRx64zEHqoEBjVPo2hElVBIRD78sIm7Te26cgKiKyL4rVH/mN
   pQhFrKshoMnS3oJW8I0sTBB7QejsOpxJe3Gnsa322PyHCq9Dpe/ua1JXT
   jVyLH5D2mt3jxN3oST9ylM8Y3uDqMMAETQzMVSa0ahP51BlD0/3l+uRFI
   /5V77TlX7HevUTMfH3Vb18htb+kKSwDOZp+6y+eYLBIxXA/1M8IIaYaq+
   xB+SKT0hyXOj/pEmDW58TzmICKysTFk7PqG/RZRxv8xQPOujtcc88bFAD
   a62XZAQM1LBbtxT1rcD0eeOVcUhygVPuhCGe0z6ZQ9eu4XWV3gyd20fNT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18001673"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="18001673"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:23:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5537499"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.181]) ([10.246.112.181])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:23:12 -0800
Message-ID: <1ca61aea-d1c1-44e9-93dc-42d0eef16203@intel.com>
Date: Mon, 5 Feb 2024 11:23:10 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] cxl: Fix sysfs export of qos_class for memdev
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net
References: <20240201214731.1297389-1-dave.jiang@intel.com>
 <20240201214731.1297389-2-dave.jiang@intel.com>
 <20240205114049.000073e6@Huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240205114049.000073e6@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/5/24 4:40 AM, Jonathan Cameron wrote:
> On Thu, 1 Feb 2024 14:47:30 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
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
> Some comments inline.  Only think I really care about though is a comment
> in the code to say why sysfs_update_groups() is not appropriate.

Didn't realize that helper existed. I'll move over to using that. 
DJ

> 
>> ---
>> v3:
>> - Updated based on pervious patch changes
>> ---
>>  drivers/cxl/core/cdat.c   |  1 +
>>  drivers/cxl/core/memdev.c | 71 +++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h         |  2 ++
>>  drivers/cxl/mem.c         | 36 --------------------
>>  4 files changed, 74 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 55b82dfd794b..5c93bf9d5253 100644
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
>> index dae8802ecdb0..ed85096a33fb 100644
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
>> @@ -519,6 +575,21 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
>>  	NULL,
>>  };
>>  
>> +void cxl_memdev_update_attribute_groups(struct cxl_memdev *cxlmd)
>> +{
>> +	const struct attribute_group *grp = cxl_memdev_attribute_groups[0];
>> +
>> +	for (int i = 0; grp; i++) {
>> +		int rc = sysfs_update_group(&cxlmd->dev.kobj, grp);
>> +
>> +		if (rc)
>> +			dev_dbg(&cxlmd->dev,
>> +				"Unable to update memdev attribute group.\n");
>> +		grp = cxl_memdev_attribute_groups[i + 1];
> We don't need i explicitly so maybe cleaner as something like.
> 
> 	for (const struct attribute_group **grp = &cxl_memdev_attribute_groups[0];
> 	     grp; grp++)
> 		if (sysfs_update_group(&cxlmd->dev.kobj, *grp)
> 			dev_dbg(....)
> 
> Mind you I'm not that convinced, so fine if you want to stick with current code :)
> 
> I'd also like a comment on why sysfs_update_groups() is not appropriate here.
> 
>> +	}
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_update_attribute_groups, CXL);
>> +
>>  static const struct device_type cxl_memdev_type = {
>>  	.name = "cxl_memdev",
>>  	.release = cxl_memdev_release,
> 
>>  
> 
