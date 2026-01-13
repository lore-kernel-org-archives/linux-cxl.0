Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E01D31062D;
	Tue, 13 Jan 2026 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339089; cv=none; b=fz68w0L+dUdZWR/960VT+AlTgUFwY2NmTfHQlt/01JygJjCOYgzrXOE6cN5G3CrlyygF7/eqSqldhV6fcx+U1dXWMIhzRwFC27kSAUiela1WPlel+PrSI9wuX21KN0Y4SSEWz47e6iV5JT536AMWv6RBEWNugmy6MeDg5zQ14AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339089; c=relaxed/simple;
	bh=Z5+TweCl1GrfS/fSkZNaLPQSNoqVpKH1R+pptMrkQhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8AVHPCUqaT0Rj1opgfC1i4MGeCyOHq92B5/BX72lV4P/kKDAO/KwFySoI9BPgLfbJ8K6pPg4iqurVfYcuL3yeyTr/Hzjf/OPDw6lmYI0Jd+M5ifxsfnehUnd8ADj+i79DF2bVuGzcrgHhmuPtdnR9qbb2gOkekIpTsQuhoo0XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DML3YVaU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DML3YVaU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768339087; x=1799875087;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z5+TweCl1GrfS/fSkZNaLPQSNoqVpKH1R+pptMrkQhA=;
  b=DML3YVaUyfeNT7XSRrA0/9y3O1aw1KrRvDRyTyZnIS3RjAovjdEKAr9R
   CKWyXSO6HdZpUWfuMqQqQttn1YYvmiuQTjJLbtqdYSk0uaM8oa4lpPBsr
   qmcGyG93wYOAMtGs8M9L4hN3eRAqQmx9yE8tiAIfUD2p8HMtJSUR7k6Tb
   0t1csmiA1QJfk6Zo4hMR9aTXP/qEAGYCob3A/3J/8va4yV1W0MOnARQ16
   /KIHSEzw9TrILGayYCFf2iJd/+8sRmoQlyBM7XWhjlOcrhAqWqIiF9i+Y
   7Wc1/Qi7k/q/Wc/eLoCC0SoRw1hxaZH7KAtJGHSfB6Qx0ziX4aK2vBFhR
   g==;
X-CSE-ConnectionGUID: iSfxlwt1Tq6O9ZegjGf/Ag==
X-CSE-MsgGUID: wzMQ4kNxQmmSF8eJHfwH5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69796328"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69796328"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:18:07 -0800
X-CSE-ConnectionGUID: C4PRAXRgQp6IR77NqHdRXA==
X-CSE-MsgGUID: mcXMH6i2SsGzU2MgWyxIug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="208654922"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:18:06 -0800
Message-ID: <d25cb143-f679-4cf7-a44f-1998ecbd373d@intel.com>
Date: Tue, 13 Jan 2026 14:18:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cxl/core/region: move pmem region driver logic
 into pmem_region
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20260113202138.3021093-1-gourry@gourry.net>
 <20260113202138.3021093-2-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260113202138.3021093-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/13/26 1:21 PM, Gregory Price wrote:
> Move the pmem region driver logic from region.c into pmem_region.c.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/Makefile      |   1 +
>  drivers/cxl/core/core.h        |   1 +
>  drivers/cxl/core/pmem_region.c | 191 +++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c      | 184 -------------------------------
>  4 files changed, 193 insertions(+), 184 deletions(-)
>  create mode 100644 drivers/cxl/core/pmem_region.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 5ad8fef210b5..23269c81fd44 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -17,6 +17,7 @@ cxl_core-y += cdat.o
>  cxl_core-y += ras.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +cxl_core-$(CONFIG_CXL_REGION) += pmem_region.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1fb66132b777..cd589e81f55e 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -42,6 +42,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa);
> +int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
>  
>  #else
>  static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
> diff --git a/drivers/cxl/core/pmem_region.c b/drivers/cxl/core/pmem_region.c
> new file mode 100644
> index 000000000000..81b66e548bb5
> --- /dev/null
> +++ b/drivers/cxl/core/pmem_region.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <cxlmem.h>
> +#include <cxl.h>
> +#include "core.h"
> +
> +static void cxl_pmem_region_release(struct device *dev)
> +{
> +	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
> +	int i;
> +
> +	for (i = 0; i < cxlr_pmem->nr_mappings; i++) {
> +		struct cxl_memdev *cxlmd = cxlr_pmem->mapping[i].cxlmd;
> +
> +		put_device(&cxlmd->dev);
> +	}
> +
> +	kfree(cxlr_pmem);
> +}
> +
> +static const struct attribute_group *cxl_pmem_region_attribute_groups[] = {
> +	&cxl_base_attribute_group,
> +	NULL,
> +};
> +
> +const struct device_type cxl_pmem_region_type = {
> +	.name = "cxl_pmem_region",
> +	.release = cxl_pmem_region_release,
> +	.groups = cxl_pmem_region_attribute_groups,
> +};
> +bool is_cxl_pmem_region(struct device *dev)
> +{
> +	return dev->type == &cxl_pmem_region_type;
> +}
> +EXPORT_SYMBOL_NS_GPL(is_cxl_pmem_region, "CXL");
> +
> +struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
> +{
> +	if (dev_WARN_ONCE(dev, !is_cxl_pmem_region(dev),
> +				"not a cxl_pmem_region device\n"))
> +		return NULL;
> +	return container_of(dev, struct cxl_pmem_region, dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, "CXL");
> +static struct lock_class_key cxl_pmem_region_key;
> +
> +static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct device *dev;
> +	int i;
> +
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	if (p->state != CXL_CONFIG_COMMIT)
> +		return -ENXIO;
> +
> +	struct cxl_pmem_region *cxlr_pmem __free(kfree) =
> +		kzalloc(struct_size(cxlr_pmem, mapping, p->nr_targets), GFP_KERNEL);
> +	if (!cxlr_pmem)
> +		return -ENOMEM;
> +
> +	cxlr_pmem->hpa_range.start = p->res->start;
> +	cxlr_pmem->hpa_range.end = p->res->end;
> +
> +	/* Snapshot the region configuration underneath the cxl_rwsem.region */
> +	cxlr_pmem->nr_mappings = p->nr_targets;
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +		struct cxl_pmem_region_mapping *m = &cxlr_pmem->mapping[i];
> +
> +		/*
> +		 * Regions never span CXL root devices, so by definition the
> +		 * bridge for one device is the same for all.
> +		 */
> +		if (i == 0) {
> +			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd->endpoint);
> +			if (!cxl_nvb)
> +				return -ENODEV;
> +			cxlr->cxl_nvb = cxl_nvb;
> +		}
> +		m->cxlmd = cxlmd;
> +		get_device(&cxlmd->dev);
> +		m->start = cxled->dpa_res->start;
> +		m->size = resource_size(cxled->dpa_res);
> +		m->position = i;
> +	}
> +
> +	dev = &cxlr_pmem->dev;
> +	device_initialize(dev);
> +	lockdep_set_class(&dev->mutex, &cxl_pmem_region_key);
> +	device_set_pm_not_required(dev);
> +	dev->parent = &cxlr->dev;
> +	dev->bus = &cxl_bus_type;
> +	dev->type = &cxl_pmem_region_type;
> +	cxlr_pmem->cxlr = cxlr;
> +	cxlr->cxlr_pmem = no_free_ptr(cxlr_pmem);
> +
> +	return 0;
> +}
> +
> +static void cxlr_pmem_unregister(void *_cxlr_pmem)
> +{
> +	struct cxl_pmem_region *cxlr_pmem = _cxlr_pmem;
> +	struct cxl_region *cxlr = cxlr_pmem->cxlr;
> +	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> +
> +	/*
> +	 * Either the bridge is in ->remove() context under the device_lock(),
> +	 * or cxlr_release_nvdimm() is cancelling the bridge's release action
> +	 * for @cxlr_pmem and doing it itself (while manually holding the bridge
> +	 * lock).
> +	 */
> +	device_lock_assert(&cxl_nvb->dev);
> +	cxlr->cxlr_pmem = NULL;
> +	cxlr_pmem->cxlr = NULL;
> +	device_unregister(&cxlr_pmem->dev);
> +}
> +
> +static void cxlr_release_nvdimm(void *_cxlr)
> +{
> +	struct cxl_region *cxlr = _cxlr;
> +	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> +
> +	scoped_guard(device, &cxl_nvb->dev) {
> +		if (cxlr->cxlr_pmem)
> +			devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
> +					cxlr->cxlr_pmem);
> +	}
> +	cxlr->cxl_nvb = NULL;
> +	put_device(&cxl_nvb->dev);
> +}
> +
> +/**
> + * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
> + * @cxlr: parent CXL region for this pmem region bridge device
> + *
> + * Return: 0 on success negative error code on failure.
> + */
> +int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_pmem_region *cxlr_pmem;
> +	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct device *dev;
> +	int rc;
> +
> +	rc = cxl_pmem_region_alloc(cxlr);
> +	if (rc)
> +		return rc;
> +	cxlr_pmem = cxlr->cxlr_pmem;
> +	cxl_nvb = cxlr->cxl_nvb;
> +
> +	dev = &cxlr_pmem->dev;
> +	rc = dev_set_name(dev, "pmem_region%d", cxlr->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> +			dev_name(dev));
> +
> +	scoped_guard(device, &cxl_nvb->dev) {
> +		if (cxl_nvb->dev.driver)
> +			rc = devm_add_action_or_reset(&cxl_nvb->dev,
> +					cxlr_pmem_unregister,
> +					cxlr_pmem);
> +		else
> +			rc = -ENXIO;
> +	}
> +
> +	if (rc)
> +		goto err_bridge;
> +
> +	/* @cxlr carries a reference on @cxl_nvb until cxlr_release_nvdimm */
> +	return devm_add_action_or_reset(&cxlr->dev, cxlr_release_nvdimm, cxlr);
> +
> +err:
> +	put_device(dev);
> +err_bridge:
> +	put_device(&cxl_nvb->dev);
> +	cxlr->cxl_nvb = NULL;
> +	return rc;
> +}
> +
> +
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f8262d2169ea..a61805542b56 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2808,46 +2808,6 @@ static ssize_t delete_region_store(struct device *dev,
>  }
>  DEVICE_ATTR_WO(delete_region);
>  
> -static void cxl_pmem_region_release(struct device *dev)
> -{
> -	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
> -	int i;
> -
> -	for (i = 0; i < cxlr_pmem->nr_mappings; i++) {
> -		struct cxl_memdev *cxlmd = cxlr_pmem->mapping[i].cxlmd;
> -
> -		put_device(&cxlmd->dev);
> -	}
> -
> -	kfree(cxlr_pmem);
> -}
> -
> -static const struct attribute_group *cxl_pmem_region_attribute_groups[] = {
> -	&cxl_base_attribute_group,
> -	NULL,
> -};
> -
> -const struct device_type cxl_pmem_region_type = {
> -	.name = "cxl_pmem_region",
> -	.release = cxl_pmem_region_release,
> -	.groups = cxl_pmem_region_attribute_groups,
> -};
> -
> -bool is_cxl_pmem_region(struct device *dev)
> -{
> -	return dev->type == &cxl_pmem_region_type;
> -}
> -EXPORT_SYMBOL_NS_GPL(is_cxl_pmem_region, "CXL");
> -
> -struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
> -{
> -	if (dev_WARN_ONCE(dev, !is_cxl_pmem_region(dev),
> -			  "not a cxl_pmem_region device\n"))
> -		return NULL;
> -	return container_of(dev, struct cxl_pmem_region, dev);
> -}
> -EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, "CXL");
> -
>  struct cxl_poison_context {
>  	struct cxl_port *port;
>  	int part;
> @@ -3279,64 +3239,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	return -ENXIO;
>  }
>  
> -static struct lock_class_key cxl_pmem_region_key;
> -
> -static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
> -{
> -	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> -	struct device *dev;
> -	int i;
> -
> -	guard(rwsem_read)(&cxl_rwsem.region);
> -	if (p->state != CXL_CONFIG_COMMIT)
> -		return -ENXIO;
> -
> -	struct cxl_pmem_region *cxlr_pmem __free(kfree) =
> -		kzalloc(struct_size(cxlr_pmem, mapping, p->nr_targets), GFP_KERNEL);
> -	if (!cxlr_pmem)
> -		return -ENOMEM;
> -
> -	cxlr_pmem->hpa_range.start = p->res->start;
> -	cxlr_pmem->hpa_range.end = p->res->end;
> -
> -	/* Snapshot the region configuration underneath the cxl_rwsem.region */
> -	cxlr_pmem->nr_mappings = p->nr_targets;
> -	for (i = 0; i < p->nr_targets; i++) {
> -		struct cxl_endpoint_decoder *cxled = p->targets[i];
> -		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -		struct cxl_pmem_region_mapping *m = &cxlr_pmem->mapping[i];
> -
> -		/*
> -		 * Regions never span CXL root devices, so by definition the
> -		 * bridge for one device is the same for all.
> -		 */
> -		if (i == 0) {
> -			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd->endpoint);
> -			if (!cxl_nvb)
> -				return -ENODEV;
> -			cxlr->cxl_nvb = cxl_nvb;
> -		}
> -		m->cxlmd = cxlmd;
> -		get_device(&cxlmd->dev);
> -		m->start = cxled->dpa_res->start;
> -		m->size = resource_size(cxled->dpa_res);
> -		m->position = i;
> -	}
> -
> -	dev = &cxlr_pmem->dev;
> -	device_initialize(dev);
> -	lockdep_set_class(&dev->mutex, &cxl_pmem_region_key);
> -	device_set_pm_not_required(dev);
> -	dev->parent = &cxlr->dev;
> -	dev->bus = &cxl_bus_type;
> -	dev->type = &cxl_pmem_region_type;
> -	cxlr_pmem->cxlr = cxlr;
> -	cxlr->cxlr_pmem = no_free_ptr(cxlr_pmem);
> -
> -	return 0;
> -}
> -
>  static void cxl_dax_region_release(struct device *dev)
>  {
>  	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
> @@ -3400,92 +3302,6 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
>  	return cxlr_dax;
>  }
>  
> -static void cxlr_pmem_unregister(void *_cxlr_pmem)
> -{
> -	struct cxl_pmem_region *cxlr_pmem = _cxlr_pmem;
> -	struct cxl_region *cxlr = cxlr_pmem->cxlr;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> -
> -	/*
> -	 * Either the bridge is in ->remove() context under the device_lock(),
> -	 * or cxlr_release_nvdimm() is cancelling the bridge's release action
> -	 * for @cxlr_pmem and doing it itself (while manually holding the bridge
> -	 * lock).
> -	 */
> -	device_lock_assert(&cxl_nvb->dev);
> -	cxlr->cxlr_pmem = NULL;
> -	cxlr_pmem->cxlr = NULL;
> -	device_unregister(&cxlr_pmem->dev);
> -}
> -
> -static void cxlr_release_nvdimm(void *_cxlr)
> -{
> -	struct cxl_region *cxlr = _cxlr;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> -
> -	scoped_guard(device, &cxl_nvb->dev) {
> -		if (cxlr->cxlr_pmem)
> -			devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
> -					    cxlr->cxlr_pmem);
> -	}
> -	cxlr->cxl_nvb = NULL;
> -	put_device(&cxl_nvb->dev);
> -}
> -
> -/**
> - * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
> - * @cxlr: parent CXL region for this pmem region bridge device
> - *
> - * Return: 0 on success negative error code on failure.
> - */
> -static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
> -{
> -	struct cxl_pmem_region *cxlr_pmem;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> -	struct device *dev;
> -	int rc;
> -
> -	rc = cxl_pmem_region_alloc(cxlr);
> -	if (rc)
> -		return rc;
> -	cxlr_pmem = cxlr->cxlr_pmem;
> -	cxl_nvb = cxlr->cxl_nvb;
> -
> -	dev = &cxlr_pmem->dev;
> -	rc = dev_set_name(dev, "pmem_region%d", cxlr->id);
> -	if (rc)
> -		goto err;
> -
> -	rc = device_add(dev);
> -	if (rc)
> -		goto err;
> -
> -	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> -		dev_name(dev));
> -
> -	scoped_guard(device, &cxl_nvb->dev) {
> -		if (cxl_nvb->dev.driver)
> -			rc = devm_add_action_or_reset(&cxl_nvb->dev,
> -						      cxlr_pmem_unregister,
> -						      cxlr_pmem);
> -		else
> -			rc = -ENXIO;
> -	}
> -
> -	if (rc)
> -		goto err_bridge;
> -
> -	/* @cxlr carries a reference on @cxl_nvb until cxlr_release_nvdimm */
> -	return devm_add_action_or_reset(&cxlr->dev, cxlr_release_nvdimm, cxlr);
> -
> -err:
> -	put_device(dev);
> -err_bridge:
> -	put_device(&cxl_nvb->dev);
> -	cxlr->cxl_nvb = NULL;
> -	return rc;
> -}
> -
>  static void cxlr_dax_unregister(void *_cxlr_dax)
>  {
>  	struct cxl_dax_region *cxlr_dax = _cxlr_dax;

