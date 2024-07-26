Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C073987B
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jul 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016983; cv=none; b=gy4AvsHPSlOg8ZLTF96HXR5t8JrbrogyTVxpD9M5nBLKBpXjaJQSGG3qWtDNGZG43R5N6cDS+SsPOqGvXvG4eQwill7ia/7LlWLlBmcrKm4ZiP2A07LK6YmlByS+Ughoh0IewjgCXI2uC4tPvRJA6Whpi3IFIXlvqlDIkUrfHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016983; c=relaxed/simple;
	bh=WEGo8+r9A9RO/3HbXIyamqfuDUdtHHoASqrso2f5VP0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1lrj1ix+H5uK4+k9J7IQfGRUyeWmize/wiEuB+FI9k8plySAl7tN1Itwkw1c4f9m6f0nHGIa3vp2v1iLU5a8u9gAkH0XHxzbYX4i/SbtPd58CjHwqBGrHcu8VpdWeR1rY4FdElBjJu6Qiv0v29zAdvdoX2lwmxh96nSTt3V7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVwXV0r8rz6K662;
	Sat, 27 Jul 2024 02:00:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 140E01404FC;
	Sat, 27 Jul 2024 02:02:59 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 19:02:58 +0100
Date: Fri, 26 Jul 2024 19:02:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH 08/13] fwctl/cxl: Add driver for CXL mailbox for
 handling CXL features commands
Message-ID: <20240726190257.00003a60@Huawei.com>
In-Reply-To: <20240718213446.1750135-9-dave.jiang@intel.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
	<20240718213446.1750135-9-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 18 Jul 2024 14:32:26 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add an fwctl (auxiliary bus) driver to allow sending of CXL feature
> commands from userspace through as ioctls. Create a driver skeleton for
> initial setup.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Main question is why auxiliary bus?
We already do similar stuff in CXL on the cxl bus (e.g.
the CPMU devices etc) that then register a class
device with another subsystem.

>  GALAXYCORE GC0308 CAMERA SENSOR DRIVER
>  M:	Sebastian Reichel <sre@kernel.org>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 9f0fe698414d..0f6ec85ef9c4 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -13,6 +13,8 @@
>  
>  static DECLARE_RWSEM(cxl_memdev_rwsem);
>  
> +#define CXL_ADEV_NAME "fwctl-cxl"
> +
>  /*
>   * An entire PCI topology full of devices should be enough for any
>   * config
> @@ -1030,6 +1032,7 @@ static const struct file_operations cxl_memdev_fops = {
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlds)
>  {
> +	struct auxiliary_device *adev;

Why an auxdev? It can be any convienient dev to which a driver
will bind. Why not spin one on the CXL bus for this purpose?

Maybe that creates and implied relationship you don't want, but
we already spin lots of devices there like the pmus, so not sure
why one more is a problem.

>  	struct cxl_memdev *cxlmd;
>  	struct device *dev;
>  	struct cdev *cdev;
> @@ -1056,11 +1059,27 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  	if (rc)
>  		goto err;
>  
> +	adev = &cxlds->cxl_mbox.adev;
> +	adev->id = cxlmd->id;
> +	adev->name = CXL_ADEV_NAME;
> +	adev->dev.parent = dev;
> +
> +	rc = auxiliary_device_init(adev);
> +	if (rc)
> +		goto err;
> +
> +	rc = auxiliary_device_add(adev);
> +	if (rc)
> +		goto aux_err;
> +
>  	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>  	if (rc)
>  		return ERR_PTR(rc);
>  	return cxlmd;
>  
> +aux_err:
> +	auxiliary_device_uninit(adev);
> +
>  err:
>  	/*
>  	 * The cdev was briefly live, shutdown any ioctl operations that

> diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
> new file mode 100644
> index 000000000000..518ba2afada8
> --- /dev/null
> +++ b/drivers/fwctl/cxl/cxl.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, Intel Corporation
> + */
> +#include <linux/fwctl.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/cxl/mailbox.h>
> +#include <linux/auxiliary_bus.h>

Pick a standard ordering for header.
Any ordering is fine.

> +
> +static void cxlctl_remove(struct auxiliary_device *adev)
> +{
> +	struct cxlctl_dev *ctldev __free(cxlctl) = auxiliary_get_drvdata(adev);
> +
> +	fwctl_unregister(&ctldev->fwctl);

Same question on reference counting I asked in the set Jason posted
I don't get why we need the __free()

> +}
> +
> +static const struct auxiliary_device_id cxlctl_id_table[] = {
> +	{ .name = "CXL.fwctl", },
> +	{},
No trailing ,

> +};
> +MODULE_DEVICE_TABLE(auxiliary, cxlctl_id_table);
> +
> +static struct auxiliary_driver cxlctl_driver = {
> +	.name = "cxl_fwctl",
> +	.probe = cxlctl_probe,
> +	.remove = cxlctl_remove,
> +	.id_table = cxlctl_id_table,
> +};
> +
> +module_auxiliary_driver(cxlctl_driver);
> +
> +MODULE_IMPORT_NS(CXL);
> +MODULE_IMPORT_NS(FWCTL);
> +MODULE_DESCRIPTION("CXL fwctl driver");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL");

