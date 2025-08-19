Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74024169A
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617945; cv=none; b=lfzggGL/r60O3UNtOFgJ5tUXCvVZsrsubCuAHtS/Pj2CwnAPTJDHLyr2q4xJlxFFaJZIBQ4sMKinbxnjpjTQRECI218H+kzogHE2EFMgSGTvylyhvmJ7nOa1iWhviQJDvYustodliMmn6neEZ63NP4QFVgDrH4ek80NQQ+fUtwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617945; c=relaxed/simple;
	bh=WCEORwA3/ABFrrz3Ue7yimfV9EZ+5SRxdqhdKh4Zecs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKRHb1XUD55kgDt6/fhgoGzpf6Ia8S1mhAn8FIIP/61ZwjnVY2Dg9WabhCYU4gY6gF3kYsnFPzsHxLx6of1D+k6tlpB8pV5sg8vn+Gsd18CU2AIOaqksoyCZP306C09b6pBk5O1YgUtRvOaUYmeAz5F58RxNzdiS4FCIX/g+c+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5tx22K0dz6GFkf;
	Tue, 19 Aug 2025 23:36:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8586214037D;
	Tue, 19 Aug 2025 23:39:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 17:39:00 +0200
Date: Tue, 19 Aug 2025 16:38:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 17/18] cxl/core: Add cache device attributes
Message-ID: <20250819163858.000063a7@huawei.com>
In-Reply-To: <20250812212921.9548-18-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<20250812212921.9548-18-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Aug 2025 16:29:20 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add sysfs attributes for getting the serial number, numa node, CXL cache
> unit, and CXL cache size to struct cxl_cachedev.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
A few minor comments inline.

> ---
>  drivers/cxl/core/cachedev.c | 102 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
> index aaf4a1b94178..1cdd94520ceb 100644
> --- a/drivers/cxl/core/cachedev.c
> +++ b/drivers/cxl/core/cachedev.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (C) 2025 Advanced Micro Devices, Inc. */
> +#include <linux/string_helpers.h>
>  #include <linux/device.h>
>  #include <linux/pci.h>
>  
> @@ -30,10 +31,111 @@ static char *cxl_cachedev_devnode(const struct device *dev, umode_t *mode,
>  	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
>  }
>  
> +static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
> +	struct cxl_dev_state *cxlds = cxlcd->cxlds;
> +
> +	return sysfs_emit(buf, "%#llx\n", cxlds->serial);
Just as an FYI there is a discussion about putting similar in place for the pci device.

https://lore.kernel.org/linux-pci/20250811173931.8068-2-thepacketgeek@gmail.com/

> +}
> +static DEVICE_ATTR_RO(serial);
> +
> +static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", dev_to_node(dev));

I grumped about this when it was added for the memdev (duplication) but lost
then so I'll give in this time without a fight :)

> +}
> +static DEVICE_ATTR_RO(numa_node);
> +
> +static struct attribute *cxl_cachedev_attributes[] = {
> +	&dev_attr_serial.attr,
> +	&dev_attr_numa_node.attr,

Missing NULL?

> +};
> +
> +static umode_t cxl_cachedev_visible(struct kobject *kobj, struct attribute *a,
> +				    int n)
> +{
> +	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
> +		return 0;
> +	return a->mode;
> +}

> +static DEVICE_ATTR_RO(cache_unit);
> +
> +static struct attribute *cxl_cachedev_cache_attributes[] = {
> +	&dev_attr_cache_size.attr,
> +	&dev_attr_cache_unit.attr,
> +	NULL,

No comma.

> +};

> +
> +static const struct attribute_group *cxl_cachedev_attribute_groups[] = {
> +	&cxl_cachedev_attribute_group,
> +	&cxl_cachedev_cache_attribute_group,
> +	NULL,

No trailing comma needed given it's a terminator.

> +};
> +
>  static const struct device_type cxl_cachedev_type = {
>  	.name = "cxl_cachedev",
>  	.release = cxl_cachedev_release,
>  	.devnode = cxl_cachedev_devnode,
> +	.groups = cxl_cachedev_attribute_groups,
>  };
>  
>  bool is_cxl_cachedev(const struct device *dev)

