Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAD6632;
	Tue, 13 Jan 2026 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339126; cv=none; b=cDA8sGhlhFmnzcqJUW35CUPrzkkuyhbsEWFtEv3XY9XrUNyjYxrYIX9OUtxWLfX7HFUxVvSXnwi4NiqDXiNu2EZdIppEkvCiKX7eSl0RO03VGJG1KotCYKMiCXwmZWO4f736pr1JR6GuVOCi0V1mieVT5BZDPwm6f+k2UW8B/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339126; c=relaxed/simple;
	bh=RH+iGIEhbflrg/P7TTl38oeWYUTHbiwrLgYRLkwqF6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfmn+aX+MFSe8DlYKvOfS7lup8Wzdlzs6MynKTM0raq6z4sPZiaeRB5X7IqqVokoqb2Si+ab2e1Wr5ilIUAIpa8c4QeKozUFiN0Xip7MrCiXrZoujFD92LfG4oBmCn/B4x+RejQ3LVQvEznRVcKrYthSV8s2z6gBhSxShwDGCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HOSaZR5j; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOSaZR5j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768339124; x=1799875124;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RH+iGIEhbflrg/P7TTl38oeWYUTHbiwrLgYRLkwqF6Q=;
  b=HOSaZR5jiBq+wD2WQSk+Vrffuyqt9reH3WLRAaZHQ8A3wbqfGDfvXSJN
   +Tpphz7AyoXop0aIz6UzJLQQnl0+nnqjEYrdIIsUI+Pat/dhq7nCpaOia
   ZAQEXvqa+te7T4Glg4QqSTmf1fdUCJE7CRGJ/hEzz9U/qouQftoEyInxz
   qU04DdtO9bv5hlXHOiyA12sfhd439t68JFgyJwhrWa9CpiLUDSk9pkq0Z
   1/uVu4KwfNmmi038EyKNhKRTLteIZUlqJF2NSB7UrPspBnemiUU2vmyT8
   0Po2NYYbVF+khYMDGAZ5OzRDVuXfyX4wps7aJ+PN6+Qdck0ltcaAvmx91
   Q==;
X-CSE-ConnectionGUID: 95YrhwUlS46kW7OFV6y3+Q==
X-CSE-MsgGUID: QqwBoyqBQEK17ZgvWhWbIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69716474"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69716474"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:18:44 -0800
X-CSE-ConnectionGUID: yYB36DfwRH6apMUROqjRMQ==
X-CSE-MsgGUID: tkxNnEaHSD2+Qs9gl1y7DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204768845"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:18:43 -0800
Message-ID: <b29a73dd-985f-47f9-84d2-b822ed385e4f@intel.com>
Date: Tue, 13 Jan 2026 14:18:42 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cxl/core/region: move dax region driver logic into
 dax_region
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20260113202138.3021093-1-gourry@gourry.net>
 <20260113202138.3021093-3-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260113202138.3021093-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/13/26 1:21 PM, Gregory Price wrote:
> Move the dax region driver logic from region.c into dax_region.c
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/Makefile     |   1 +
>  drivers/cxl/core/core.h       |   1 +
>  drivers/cxl/core/dax_region.c | 106 ++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c     |  99 -------------------------------
>  4 files changed, 108 insertions(+), 99 deletions(-)
>  create mode 100644 drivers/cxl/core/dax_region.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 23269c81fd44..36f284d7c500 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -17,6 +17,7 @@ cxl_core-y += cdat.o
>  cxl_core-y += ras.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +cxl_core-$(CONFIG_CXL_REGION) += dax_region.o
>  cxl_core-$(CONFIG_CXL_REGION) += pmem_region.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index cd589e81f55e..3ea850408814 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -42,6 +42,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa);
> +int devm_cxl_add_dax_region(struct cxl_region *cxlr);
>  int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
>  
>  #else
> diff --git a/drivers/cxl/core/dax_region.c b/drivers/cxl/core/dax_region.c
> new file mode 100644
> index 000000000000..d7c38447f816
> --- /dev/null
> +++ b/drivers/cxl/core/dax_region.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <cxlmem.h>
> +#include <cxl.h>
> +#include "core.h"
> +
> +static void cxl_dax_region_release(struct device *dev)
> +{
> +	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
> +
> +	kfree(cxlr_dax);
> +}
> +
> +static const struct attribute_group *cxl_dax_region_attribute_groups[] = {
> +	&cxl_base_attribute_group,
> +	NULL,
> +};
> +
> +const struct device_type cxl_dax_region_type = {
> +	.name = "cxl_dax_region",
> +	.release = cxl_dax_region_release,
> +	.groups = cxl_dax_region_attribute_groups,
> +};
> +
> +static bool is_cxl_dax_region(struct device *dev)
> +{
> +	return dev->type == &cxl_dax_region_type;
> +}
> +
> +struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
> +{
> +	if (dev_WARN_ONCE(dev, !is_cxl_dax_region(dev),
> +			  "not a cxl_dax_region device\n"))
> +		return NULL;
> +	return container_of(dev, struct cxl_dax_region, dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
> +
> +static struct lock_class_key cxl_dax_region_key;
> +
> +static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_dax_region *cxlr_dax;
> +	struct device *dev;
> +
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	if (p->state != CXL_CONFIG_COMMIT)
> +		return ERR_PTR(-ENXIO);
> +
> +	cxlr_dax = kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
> +	if (!cxlr_dax)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlr_dax->hpa_range.start = p->res->start;
> +	cxlr_dax->hpa_range.end = p->res->end;
> +
> +	dev = &cxlr_dax->dev;
> +	cxlr_dax->cxlr = cxlr;
> +	device_initialize(dev);
> +	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
> +	device_set_pm_not_required(dev);
> +	dev->parent = &cxlr->dev;
> +	dev->bus = &cxl_bus_type;
> +	dev->type = &cxl_dax_region_type;
> +
> +	return cxlr_dax;
> +}
> +
> +static void cxlr_dax_unregister(void *_cxlr_dax)
> +{
> +	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> +
> +	device_unregister(&cxlr_dax->dev);
> +}
> +
> +int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_dax_region *cxlr_dax;
> +	struct device *dev;
> +	int rc;
> +
> +	cxlr_dax = cxl_dax_region_alloc(cxlr);
> +	if (IS_ERR(cxlr_dax))
> +		return PTR_ERR(cxlr_dax);
> +
> +	dev = &cxlr_dax->dev;
> +	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> +		dev_name(dev));
> +
> +	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
> +					cxlr_dax);
> +err:
> +	put_device(dev);
> +	return rc;
> +}
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a61805542b56..1ca5f5b02b22 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3239,105 +3239,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	return -ENXIO;
>  }
>  
> -static void cxl_dax_region_release(struct device *dev)
> -{
> -	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
> -
> -	kfree(cxlr_dax);
> -}
> -
> -static const struct attribute_group *cxl_dax_region_attribute_groups[] = {
> -	&cxl_base_attribute_group,
> -	NULL,
> -};
> -
> -const struct device_type cxl_dax_region_type = {
> -	.name = "cxl_dax_region",
> -	.release = cxl_dax_region_release,
> -	.groups = cxl_dax_region_attribute_groups,
> -};
> -
> -static bool is_cxl_dax_region(struct device *dev)
> -{
> -	return dev->type == &cxl_dax_region_type;
> -}
> -
> -struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
> -{
> -	if (dev_WARN_ONCE(dev, !is_cxl_dax_region(dev),
> -			  "not a cxl_dax_region device\n"))
> -		return NULL;
> -	return container_of(dev, struct cxl_dax_region, dev);
> -}
> -EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
> -
> -static struct lock_class_key cxl_dax_region_key;
> -
> -static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
> -{
> -	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_dax_region *cxlr_dax;
> -	struct device *dev;
> -
> -	guard(rwsem_read)(&cxl_rwsem.region);
> -	if (p->state != CXL_CONFIG_COMMIT)
> -		return ERR_PTR(-ENXIO);
> -
> -	cxlr_dax = kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
> -	if (!cxlr_dax)
> -		return ERR_PTR(-ENOMEM);
> -
> -	cxlr_dax->hpa_range.start = p->res->start;
> -	cxlr_dax->hpa_range.end = p->res->end;
> -
> -	dev = &cxlr_dax->dev;
> -	cxlr_dax->cxlr = cxlr;
> -	device_initialize(dev);
> -	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
> -	device_set_pm_not_required(dev);
> -	dev->parent = &cxlr->dev;
> -	dev->bus = &cxl_bus_type;
> -	dev->type = &cxl_dax_region_type;
> -
> -	return cxlr_dax;
> -}
> -
> -static void cxlr_dax_unregister(void *_cxlr_dax)
> -{
> -	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> -
> -	device_unregister(&cxlr_dax->dev);
> -}
> -
> -static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> -{
> -	struct cxl_dax_region *cxlr_dax;
> -	struct device *dev;
> -	int rc;
> -
> -	cxlr_dax = cxl_dax_region_alloc(cxlr);
> -	if (IS_ERR(cxlr_dax))
> -		return PTR_ERR(cxlr_dax);
> -
> -	dev = &cxlr_dax->dev;
> -	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
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
> -	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
> -					cxlr_dax);
> -err:
> -	put_device(dev);
> -	return rc;
> -}
> -
>  static int match_decoder_by_range(struct device *dev, const void *data)
>  {
>  	const struct range *r1, *r2 = data;

