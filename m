Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7937E1C1F01
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732211732; cv=none; b=oqO/yJsYz5vEkfxFwBmEOLqrkXoYej5fT+neygimkkrmlHQQOfnXKIs3LwvMu4jfz1sNZktSG2qEmy/DKFr8r6CseNIAPNmbPWPbujNknscwAjUVpDRddgiYITrOVx0E9W1gcBA/g6VG+xo3GMCV1Kw933b2xU/mIlfExWGll90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732211732; c=relaxed/simple;
	bh=eGTrvYcL5Gi9lGaPWaIhYWj9DNXQZ9qoUHOkE1yD5Vg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gk1naMpOqdUvZoTJ1jwugQ4dX+zSNhCt/r2fKjx9OwAKQXqdaFthcaMQuwyHLbFCMUuCMKHl9OKqVpththuSynXjzZFfaIKMIaLI+pwP5Vd+n3ekt9sa8XE5v3xOFQUaAUZId2m2WzBTEVml3751ci6UugLr3P1L2mPR5H7k2gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvQnG425Gz6K5ry;
	Fri, 22 Nov 2024 01:53:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D6DC1400F4;
	Fri, 22 Nov 2024 01:55:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 18:55:26 +0100
Date: Thu, 21 Nov 2024 17:55:25 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 08/20] cxl: Move cxl_driver related bits to be
 usable by external drivers
Message-ID: <20241121175525.00001197@huawei.com>
In-Reply-To: <20241115212745.869552-9-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-9-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Nov 2024 14:25:41 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Move the code related to cxl_driver to allow external drivers such as
> cxl_fwctl to utilize the cxl_bus.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Hmm. Will have to see if this can allow dropping of at least some
of the includes in the cxl_pmu driver 

#include "../cxl/cxlpci.h"
#include "../cxl/cxl.h"
currently which isn't pretty.  I can't remember exactly what we
need though and that can definitely follow this series as an
additional cleanup.

In general sensible thing to do.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/cxl.h | 32 +-------------------------------
>  include/cxl/cxl.h | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 31 deletions(-)
>  create mode 100644 include/cxl/cxl.h
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5406e3ab3d4a..18e78b2c3612 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -11,6 +11,7 @@
>  #include <linux/log2.h>
>  #include <linux/node.h>
>  #include <linux/io.h>
> +#include <cxl/cxl.h>
>  
>  extern const struct nvdimm_security_ops *cxl_security_ops;
>  
> @@ -819,37 +820,6 @@ bool is_cxl_region(struct device *dev);
>  
>  extern struct bus_type cxl_bus_type;
>  
> -struct cxl_driver {
> -	const char *name;
> -	int (*probe)(struct device *dev);
> -	void (*remove)(struct device *dev);
> -	struct device_driver drv;
> -	int id;
> -};
> -
> -#define to_cxl_drv(__drv)	container_of_const(__drv, struct cxl_driver, drv)
> -
> -int __cxl_driver_register(struct cxl_driver *cxl_drv, struct module *owner,
> -			  const char *modname);
> -#define cxl_driver_register(x) __cxl_driver_register(x, THIS_MODULE, KBUILD_MODNAME)
> -void cxl_driver_unregister(struct cxl_driver *cxl_drv);
> -
> -#define module_cxl_driver(__cxl_driver) \
> -	module_driver(__cxl_driver, cxl_driver_register, cxl_driver_unregister)
> -
> -#define CXL_DEVICE_NVDIMM_BRIDGE	1
> -#define CXL_DEVICE_NVDIMM		2
> -#define CXL_DEVICE_PORT			3
> -#define CXL_DEVICE_ROOT			4
> -#define CXL_DEVICE_MEMORY_EXPANDER	5
> -#define CXL_DEVICE_REGION		6
> -#define CXL_DEVICE_PMEM_REGION		7
> -#define CXL_DEVICE_DAX_REGION		8
> -#define CXL_DEVICE_PMU			9
> -
> -#define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
> -#define CXL_MODALIAS_FMT "cxl:t%d"
> -
>  struct cxl_nvdimm_bridge *to_cxl_nvdimm_bridge(struct device *dev);
>  struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
>  						     struct cxl_port *port);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> new file mode 100644
> index 000000000000..07a2983275a0
> --- /dev/null
> +++ b/include/cxl/cxl.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2024 Intel Corporation. */
> +#ifndef __CXL_GLOBAL_H__
> +#define __CXL_GLOBAL_H__
> +
> +struct cxl_driver {
> +	const char *name;
> +	int (*probe)(struct device *dev);
> +	void (*remove)(struct device *dev);
> +	struct device_driver drv;
> +	int id;
> +};
> +
> +#define to_cxl_drv(__drv)      container_of_const(__drv, struct cxl_driver, drv)
> +
> +int __cxl_driver_register(struct cxl_driver *cxl_drv, struct module *owner,
> +			  const char *modname);
> +#define cxl_driver_register(x) __cxl_driver_register(x, THIS_MODULE, KBUILD_MODNAME)
> +void cxl_driver_unregister(struct cxl_driver *cxl_drv);
> +
> +#define module_cxl_driver(__cxl_driver) \
> +	module_driver(__cxl_driver, cxl_driver_register, cxl_driver_unregister)
> +
> +#define CXL_DEVICE_NVDIMM_BRIDGE	1
> +#define CXL_DEVICE_NVDIMM		2
> +#define CXL_DEVICE_PORT			3
> +#define CXL_DEVICE_ROOT			4
> +#define CXL_DEVICE_MEMORY_EXPANDER	5
> +#define CXL_DEVICE_REGION		6
> +#define CXL_DEVICE_PMEM_REGION		7
> +#define CXL_DEVICE_DAX_REGION		8
> +#define CXL_DEVICE_PMU			9
> +
> +#define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
> +#define CXL_MODALIAS_FMT "cxl:t%d"
> +
> +#endif

