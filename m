Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A1258CD9
	for <linux-cxl@vger.kernel.org>; Tue,  9 Sep 2025 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453400; cv=none; b=X3SYOUOIoIdhEpUujFUTwnaSoZ44JHxCcxwwQqKRMy4BXNeQQ6rF0DG88ucA3MR0PpiRWcxRzFrlV478dEHxD+93wnYyEV8uFPFwCT7eg8DO/LC6QT6EC0bnR+EDmRK7mbExykv7QfyGF3mzL/MkuffwayFPj3NTb82nwVHsrfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453400; c=relaxed/simple;
	bh=W7RX5xkqjtYWEq2Z4bUPREAFHo5HKqtcw3KXbBqnXiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M3FVfzg6e5aKb+VZ8aJysbRtRuiExsTvBL4G7P72h/Gis02McZAsrjCq1Zxl5dPNC5aQq3j6ixTV994HqX4MYGGj4oknhMpDmG4l6vhJjtSvHKKlfyy4S3L3G67AHcuDrTpf5tvHWmg43tSI9RJ9E5SSG7lCncsW4ZiPyiTkQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzhT7tG7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzhT7tG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757453400; x=1788989400;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=W7RX5xkqjtYWEq2Z4bUPREAFHo5HKqtcw3KXbBqnXiM=;
  b=ZzhT7tG7TLvsuL2UGxyrgLYVaGyNtyme3IirV6U7jaxD5+3N0lNGUcfe
   V5XHBNcCrD9MyY7Mcqx3dMW4rtgt4LuiaLRymoVEcSkgDD6dIcyLdpuPt
   +RJHRpPM0N6SUFoddY5OsNVDd80ApJzYSpynXULi3UlowvwritbvLa4n6
   V7vyHxwwriVWmFmYSR8hCpYvdk8W0tX3Aye/iEDz90tpexpdxziXADqM/
   Y8ALtGXOmBcd0iV+/TvTow6g6Buj3MjzPOZs1AQRaSUh22M0oojnYCPB3
   G9D1d7wnQiRrVSTylvw4Cywg1UPHA72vJYcP+CfQJ1UPy/XYTz0ExglcK
   A==;
X-CSE-ConnectionGUID: XTfaD6MlR32L+FBiBaAIIw==
X-CSE-MsgGUID: r+CzvTe3SZ6ZuM72+tTzHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59896849"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="59896849"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 14:29:59 -0700
X-CSE-ConnectionGUID: +oMG7yErRjaITh+lC5DEIg==
X-CSE-MsgGUID: wMBfFbmITTukigpfCnAgLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="172774757"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.110.155]) ([10.125.110.155])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 14:29:58 -0700
Message-ID: <d0bb728f-f993-4b5b-ad02-336c8b1bff6d@intel.com>
Date: Tue, 9 Sep 2025 14:29:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/18] cxl/cache: Add cxl_cache driver
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, linux-cxl@vger.kernel.org
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-11-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250812212921.9548-11-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/25 2:29 PM, Ben Cheatham wrote:
> Add the cxl_cache driver which will manage struct cxl_cachdev devices.
> This driver will provide common management functions for some of a cache
> capable endpoint. This driver will also be responsible for validating
> the system's CXL.cache configuration.

Is it the expectation that a vendor specific driver will add a cachedev when it probes?

DJ

> 
> The driver expects the device's cache capabilities to be prefetched by
> the endpoint-specific driver. The required capabilities can be gotten by
> calling cxl_accel_get_cache_info().
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/cxl/Kconfig    |  14 +++++
>  drivers/cxl/Makefile   |   2 +
>  drivers/cxl/cache.c    | 116 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlcache.h |   3 ++
>  4 files changed, 135 insertions(+)
>  create mode 100644 drivers/cxl/cache.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..6b07212b554a 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -233,4 +233,18 @@ config CXL_MCE
>  	def_bool y
>  	depends on X86_MCE && MEMORY_FAILURE
>  
> +config CXL_CACHE
> +	tristate "CXL: Cache Management Support"
> +	depends on CXL_BUS
> +	help
> +	  Enables a driver that manages the CXL.cache capabilities of a CXL.cache
> +	  capable CXL device. This driver validates and provides support for
> +	  programming the CXL cache device topology. This driver is required for
> +	  using multiple CXL.cache devices (Type 1 or Type 2) below a given
> +	  CXL 3.0+ capable PCIe Root Port. This driver only provides CXL cache
> +	  management and reporting capabilities, a vendor-specific device driver
> +	  is expected to enable the full capabilities of the device.
> +
> +	  If unsure, say 'm'.
> +
>  endif
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index 2caa90fa4bf2..1017206d6780 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -13,9 +13,11 @@ obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>  obj-$(CONFIG_CXL_MEM) += cxl_mem.o
>  obj-$(CONFIG_CXL_PCI) += cxl_pci.o
> +obj-$(CONFIG_CXL_CACHE) += cxl_cache.o
>  
>  cxl_port-y := port.o
>  cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o security.o
>  cxl_mem-y := mem.o
>  cxl_pci-y := pci.o
> +cxl_cache-y := cache.o
> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
> new file mode 100644
> index 000000000000..6e5161ae3107
> --- /dev/null
> +++ b/drivers/cxl/cache.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Advanced Micro Devices, Inc. */
> +#include "cxlcache.h"
> +#include "private.h"
> +
> +/**
> + * DOC: cxl cache
> + *
> + * The cxl_cache driver is responsible for validating the CXL.cache system
> + * configuration and managing portions of the CXL cache of CXL.cache enabled
> + * devices in the system. This driver does not discover devices, a
> + * device-specific driver is required for discovery and portions of set up.
> + */
> +
> +/**
> + * devm_cxl_add_cachedev - Add a CXL cache device
> + * @host: devres alloc/release context and parent for the cachedev
> + * @cxlds: CXL device state to associate with the cachedev
> + * @ops: optional operations to run in cxl_cache::{probe,remove}() context
> + *
> + * Upon return the device will have had a chance to attach to the
> + * cxl_cache driver. This may fail if the CXL topology is not ready
> + * (hardware CXL link down, or software platform CXL root not attached)
> + * or the CXL.cache system configuration is invalid.
> + */
> +struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
> +					   struct cxl_dev_state *cxlds,
> +					   const struct cxl_dev_ops *ops)
> +{
> +	struct cxl_cachedev *cxlcd;
> +	int rc;
> +
> +	cxlcd = cxl_cachedev_alloc(cxlds, ops);
> +	if (IS_ERR(cxlcd))
> +		return cxlcd;
> +
> +	rc = dev_set_name(&cxlcd->dev, "cache%d", cxlcd->id);
> +	if (rc) {
> +		put_device(&cxlcd->dev);
> +		return ERR_PTR(rc);
> +	}
> +
> +	cxlcd = devm_cxl_cachedev_add_or_reset(host, cxlcd);
> +	if (IS_ERR(cxlcd))
> +		return cxlcd;
> +
> +	guard(device)(&cxlcd->dev);
> +	if (ops && !cxlcd->dev.driver) {
> +		if (IS_ERR(cxlcd->endpoint))
> +			return ERR_CAST(cxlcd->endpoint);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	return cxlcd;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_cachedev, "CXL");
> +
> +static int cxl_cache_probe(struct device *dev)
> +{
> +	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
> +	struct device *endpoint_parent;
> +	struct cxl_dport *dport;
> +	int rc;
> +
> +	rc = devm_cxl_enumerate_ports(&cxlcd->dev);
> +	if (rc)
> +		return rc;
> +
> +	struct cxl_port *parent_port __free(put_cxl_port) =
> +		cxl_dev_find_port(&cxlcd->dev, &dport);
> +	if (!parent_port) {
> +		dev_err(dev, "CXL port topology not found\n");
> +		return -ENXIO;
> +	}
> +
> +	if (dport->rch)
> +		endpoint_parent = parent_port->uport_dev;
> +	else
> +		endpoint_parent = &parent_port->dev;
> +
> +	scoped_guard(device, endpoint_parent) {
> +		if (!endpoint_parent->driver) {
> +			dev_err(dev, "CXL port topology %s not enabled\n",
> +				dev_name(endpoint_parent));
> +			return -ENXIO;
> +		}
> +
> +		rc = devm_cxl_add_endpoint(endpoint_parent, &cxlcd->dev, dport);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (cxlcd->ops) {
> +		rc = cxlcd->ops->probe(&cxlcd->dev);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct cxl_driver cxl_cache_driver = {
> +	.name = "cxl_cache",
> +	.probe = cxl_cache_probe,
> +	.drv = {
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
> +	},
> +	.id = CXL_DEVICE_ACCELERATOR,
> +};
> +
> +module_cxl_driver(cxl_cache_driver);
> +
> +MODULE_DESCRIPTION("CXL: Cache Management");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("CXL");
> +MODULE_ALIAS_CXL(CXL_DEVICE_ACCELERATOR);
> diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
> index 3880312cd49d..a707e402b000 100644
> --- a/drivers/cxl/cxlcache.h
> +++ b/drivers/cxl/cxlcache.h
> @@ -22,4 +22,7 @@ static inline struct cxl_cachedev *to_cxl_cachedev(struct device *dev)
>  bool is_cxl_cachedev(const struct device *dev);
>  
>  int cxl_accel_get_cache_info(struct cxl_dev_state *cxlds);
> +struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
> +					   struct cxl_dev_state *cxlds,
> +					   const struct cxl_dev_ops *ops);
>  #endif

