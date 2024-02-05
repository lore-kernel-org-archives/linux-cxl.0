Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD04318E08
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133256; cv=none; b=c2a9HSXzotXgMINpeV+2DQwer+ayADoZZv0ZyJdEVcnU8A0tEW2iNNZoPrNEgpHFEAJeVKwSCd0kzePAKGJ6/2ToLcbRVaBkOHF5Axu4/XlmQIHUjCxW/JmJqzA8w4F3T9mmK6l00K71fi1BrxjaKKPwzMW0aUPal3mwGgG7hKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133256; c=relaxed/simple;
	bh=kqXggVW5AcYnXEdAzbhpSMfxYxf0JGshgot3G/X8JK4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlNz1AHgVYZtJd8i0v/a9fn6AcOhFRYfiJqf5MWxjsytkKloqv36c2dGyRrIcZiNdoivQtUmquonIxzoaWJyuv9KIU9dfPKEQeGXSSQLie+UTOGEzXycIQR8WUmpMOvjG461CaprHIxmntAtBdc0kubpGV72IymxevZeyUlEP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT49s1Yrmz67Dk5;
	Mon,  5 Feb 2024 19:37:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C229B140A36;
	Mon,  5 Feb 2024 19:40:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 5 Feb
 2024 11:40:50 +0000
Date: Mon, 5 Feb 2024 11:40:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v3 2/3] cxl: Fix sysfs export of qos_class for memdev
Message-ID: <20240205114049.000073e6@Huawei.com>
In-Reply-To: <20240201214731.1297389-2-dave.jiang@intel.com>
References: <20240201214731.1297389-1-dave.jiang@intel.com>
	<20240201214731.1297389-2-dave.jiang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 1 Feb 2024 14:47:30 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Current implementation exports only to
> /sys/bus/cxl/devices/.../memN/qos_class. With both ram and pmem exposed,
> the second registered sysfs attribute is rejected as duplicate. It's not
> possible to create qos_class under the dev_groups via the driver due to
> the ram and pmem sysfs sub-directories already created by the device sysfs
> groups. Move the ram and pmem qos_class to the device sysfs groups and add
> a call to sysfs_update() after the perf data are validated so the
> qos_class can be visible. The end results should be
> /sys/bus/cxl/devices/.../memN/ram/qos_class and
> /sys/bus/cxl/devices/.../memN/pmem/qos_class.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Some comments inline.  Only think I really care about though is a comment
in the code to say why sysfs_update_groups() is not appropriate.

> ---
> v3:
> - Updated based on pervious patch changes
> ---
>  drivers/cxl/core/cdat.c   |  1 +
>  drivers/cxl/core/memdev.c | 71 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  drivers/cxl/mem.c         | 36 --------------------
>  4 files changed, 74 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 55b82dfd794b..5c93bf9d5253 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -382,6 +382,7 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
>  
>  	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
>  	cxl_qos_class_verify(cxlmd);
> +	cxl_memdev_update_attribute_groups(cxlmd);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
>  
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index dae8802ecdb0..ed85096a33fb 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -447,13 +447,41 @@ static struct attribute *cxl_memdev_attributes[] = {
>  	NULL,
>  };
>  
> +static ssize_t pmem_qos_class_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +
> +	return sysfs_emit(buf, "%d\n", mds->pmem_perf.qos_class);
> +}
> +
> +static struct device_attribute dev_attr_pmem_qos_class =
> +	__ATTR(qos_class, 0444, pmem_qos_class_show, NULL);
> +
>  static struct attribute *cxl_memdev_pmem_attributes[] = {
>  	&dev_attr_pmem_size.attr,
> +	&dev_attr_pmem_qos_class.attr,
>  	NULL,
>  };
>  
> +static ssize_t ram_qos_class_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +
> +	return sysfs_emit(buf, "%d\n", mds->ram_perf.qos_class);
> +}
> +
> +static struct device_attribute dev_attr_ram_qos_class =
> +	__ATTR(qos_class, 0444, ram_qos_class_show, NULL);
> +
>  static struct attribute *cxl_memdev_ram_attributes[] = {
>  	&dev_attr_ram_size.attr,
> +	&dev_attr_ram_qos_class.attr,
>  	NULL,
>  };
>  
> @@ -477,14 +505,42 @@ static struct attribute_group cxl_memdev_attribute_group = {
>  	.is_visible = cxl_memdev_visible,
>  };
>  
> +static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	if (a == &dev_attr_ram_qos_class.attr)
> +		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
> +			return 0;
> +
> +	return a->mode;
> +}
> +
>  static struct attribute_group cxl_memdev_ram_attribute_group = {
>  	.name = "ram",
>  	.attrs = cxl_memdev_ram_attributes,
> +	.is_visible = cxl_ram_visible,
>  };
>  
> +static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	if (a == &dev_attr_pmem_qos_class.attr)
> +		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
> +			return 0;
> +
> +	return a->mode;
> +}
> +
>  static struct attribute_group cxl_memdev_pmem_attribute_group = {
>  	.name = "pmem",
>  	.attrs = cxl_memdev_pmem_attributes,
> +	.is_visible = cxl_pmem_visible,
>  };
>  
>  static umode_t cxl_memdev_security_visible(struct kobject *kobj,
> @@ -519,6 +575,21 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
>  	NULL,
>  };
>  
> +void cxl_memdev_update_attribute_groups(struct cxl_memdev *cxlmd)
> +{
> +	const struct attribute_group *grp = cxl_memdev_attribute_groups[0];
> +
> +	for (int i = 0; grp; i++) {
> +		int rc = sysfs_update_group(&cxlmd->dev.kobj, grp);
> +
> +		if (rc)
> +			dev_dbg(&cxlmd->dev,
> +				"Unable to update memdev attribute group.\n");
> +		grp = cxl_memdev_attribute_groups[i + 1];
We don't need i explicitly so maybe cleaner as something like.

	for (const struct attribute_group **grp = &cxl_memdev_attribute_groups[0];
	     grp; grp++)
		if (sysfs_update_group(&cxlmd->dev.kobj, *grp)
			dev_dbg(....)

Mind you I'm not that convinced, so fine if you want to stick with current code :)

I'd also like a comment on why sysfs_update_groups() is not appropriate here.

> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_update_attribute_groups, CXL);
> +
>  static const struct device_type cxl_memdev_type = {
>  	.name = "cxl_memdev",
>  	.release = cxl_memdev_release,

>  

