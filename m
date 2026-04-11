Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AB715A85A;
	Sat, 11 Apr 2026 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775867204; cv=none; b=KcpMGBMa81HQLICird9YvjSYgnVdjeIyTxnpVw99wXsOrmKAcv7T4sVvFZlnomsxvNZBGbnedBfYNVyvHZKl3luS+4mBvQvxwzIdzI+T0ZEhElQW/zTxYmzPS7Pb8+8j/3oYv6D7VMCH4JVT0lI1yqTk+0EnIT3Rn9qHpgVLDzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775867204; c=relaxed/simple;
	bh=c+SsL19JC/o+AVjh6aOeWw3r953XMGGouDCkSdhFlHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUPngCon0dY2whdj4rxbE5Ncia0iKoK2G251C+TecnC76j8aUpZW1BMcSW+neAsXErkkFbcYsHkXxZ2tcpgxJTZcf9k1S3YyMEbLrRhCmBJW2kz/cwXiF5vwE5gILOl+ZO1EiKK3JMqPcC+jgXo/w02wvMEv3uTolZFsJvktd2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vg+UIAGE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vg+UIAGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775867203; x=1807403203;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c+SsL19JC/o+AVjh6aOeWw3r953XMGGouDCkSdhFlHQ=;
  b=Vg+UIAGEaAvR6LDZBeb9o/z/Hj9FHTgMcj0vI8YVNX7hxGIYE0Gzlr1s
   DsdSxjG42ktVUpnhGT9dWRmwRBSxwscveBg/alQq6cmlm4O8W1LvAB4PH
   HJsdPij7Omk5HD3fqravvz5s/JOWFMX0ocBNdY9S4P8ahqQekjXAeO7iU
   3qM5CcApfrSFt8lnqJPwOkMJLAGa7DxYQvdjJ47TaAc01S4ohz2ijv7Ko
   H1IjLSp5OrzQgnIOUt6zbGMXuBzWED0KqKYXB2kn/+wcF8e9d/6aLta2Y
   z7EDEfvU4V3A9NOcHy9038XvxzOU9LEg2d26tRFeNGMZ+X/4VlTQGTscx
   Q==;
X-CSE-ConnectionGUID: bmZg6RuISFSh6FYvhn+vZQ==
X-CSE-MsgGUID: tz+txrTBRWS4T8Qo1QkIjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="94467397"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="94467397"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 17:26:42 -0700
X-CSE-ConnectionGUID: a85PNF3jQSi+ZGcKGlNrvQ==
X-CSE-MsgGUID: ULvIMXcDS42kEhyOrSJRlA==
X-ExtLoop1: 1
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.54]) ([10.125.109.54])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 17:26:41 -0700
Message-ID: <be09006d-e01f-4d20-9f0d-b2afc88796a4@intel.com>
Date: Fri, 10 Apr 2026 17:26:39 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] cxl/core/region: move dax region device logic into
 region_dax.c
To: Anisa Su <anisa.su887@gmail.com>, Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20260327020203.876122-1-gourry@gourry.net>
 <20260327020203.876122-3-gourry@gourry.net>
 <admPeJv7mjDZPhJv@4470NRD-ASU.ssi.samsung.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <admPeJv7mjDZPhJv@4470NRD-ASU.ssi.samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/10/26 5:02 PM, Anisa Su wrote:
> On Thu, Mar 26, 2026 at 10:02:02PM -0400, Gregory Price wrote:
>> core/region.c is overloaded with per-region control logic (pmem, dax,
>> sysram, etc). Move the CXL DAX region device infrastructure from
>> region.c into a new region_dax.c file.
>>
>> This will also allow us to add additional dax-driver integration paths
>> that don't further dirty the core region.c logic.
>>
>> No functional changes.
>>
>> Signed-off-by: Gregory Price <gourry@gourry.net>
>> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>> ---
>>  drivers/cxl/core/Makefile     |   2 +-
>>  drivers/cxl/core/core.h       |   1 +
>>  drivers/cxl/core/region.c     |  99 ------------------------------
>>  drivers/cxl/core/region_dax.c | 109 ++++++++++++++++++++++++++++++++++
>>  tools/testing/cxl/Kbuild      |   2 +-
>>  5 files changed, 112 insertions(+), 101 deletions(-)
>>  create mode 100644 drivers/cxl/core/region_dax.c
>>
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index f73776fe323b..ce7213818d3c 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -15,7 +15,7 @@ cxl_core-y += hdm.o
>>  cxl_core-y += pmu.o
>>  cxl_core-y += cdat.o
>>  cxl_core-$(CONFIG_TRACING) += trace.o
>> -cxl_core-$(CONFIG_CXL_REGION) += region.o region_pmem.o
>> +cxl_core-$(CONFIG_CXL_REGION) += region.o region_pmem.o region_dax.o
>>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index ef03966eeabd..82ca3a476708 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -50,6 +50,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
>>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>>  		   u64 dpa);
>> +int devm_cxl_add_dax_region(struct cxl_region *cxlr);
>>  int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
>>  
>>  #else
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 72aee1408efb..6a2ef3475764 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3436,105 +3436,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>>  	return -ENXIO;
>>  }
>>  
>> -static void cxl_dax_region_release(struct device *dev)
>> -{
>> -	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
>> -
>> -	kfree(cxlr_dax);
>> -}
>> -
>> -static const struct attribute_group *cxl_dax_region_attribute_groups[] = {
>> -	&cxl_base_attribute_group,
>> -	NULL,
>> -};
>> -
>> -const struct device_type cxl_dax_region_type = {
>> -	.name = "cxl_dax_region",
>> -	.release = cxl_dax_region_release,
>> -	.groups = cxl_dax_region_attribute_groups,
>> -};
>> -
>> -static bool is_cxl_dax_region(struct device *dev)
>> -{
>> -	return dev->type == &cxl_dax_region_type;
>> -}
>> -
>> -struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
>> -{
>> -	if (dev_WARN_ONCE(dev, !is_cxl_dax_region(dev),
>> -			  "not a cxl_dax_region device\n"))
>> -		return NULL;
>> -	return container_of(dev, struct cxl_dax_region, dev);
>> -}
>> -EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
>> -
>> -static struct lock_class_key cxl_dax_region_key;
>> -
>> -static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
>> -{
>> -	struct cxl_region_params *p = &cxlr->params;
>> -	struct cxl_dax_region *cxlr_dax;
>> -	struct device *dev;
>> -
>> -	guard(rwsem_read)(&cxl_rwsem.region);
>> -	if (p->state != CXL_CONFIG_COMMIT)
>> -		return ERR_PTR(-ENXIO);
>> -
>> -	cxlr_dax = kzalloc_obj(*cxlr_dax);
>> -	if (!cxlr_dax)
>> -		return ERR_PTR(-ENOMEM);
>> -
>> -	cxlr_dax->hpa_range.start = p->res->start;
>> -	cxlr_dax->hpa_range.end = p->res->end;
>> -
>> -	dev = &cxlr_dax->dev;
>> -	cxlr_dax->cxlr = cxlr;
>> -	device_initialize(dev);
>> -	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
>> -	device_set_pm_not_required(dev);
>> -	dev->parent = &cxlr->dev;
>> -	dev->bus = &cxl_bus_type;
>> -	dev->type = &cxl_dax_region_type;
>> -
>> -	return cxlr_dax;
>> -}
>> -
>> -static void cxlr_dax_unregister(void *_cxlr_dax)
>> -{
>> -	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
>> -
>> -	device_unregister(&cxlr_dax->dev);
>> -}
>> -
>> -static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>> -{
>> -	struct cxl_dax_region *cxlr_dax;
>> -	struct device *dev;
>> -	int rc;
>> -
>> -	cxlr_dax = cxl_dax_region_alloc(cxlr);
>> -	if (IS_ERR(cxlr_dax))
>> -		return PTR_ERR(cxlr_dax);
>> -
>> -	dev = &cxlr_dax->dev;
>> -	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
>> -	if (rc)
>> -		goto err;
>> -
>> -	rc = device_add(dev);
>> -	if (rc)
>> -		goto err;
>> -
>> -	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
>> -		dev_name(dev));
>> -
>> -	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
>> -					cxlr_dax);
>> -err:
>> -	put_device(dev);
>> -	return rc;
>> -}
>> -
>>  static int match_root_decoder(struct device *dev, const void *data)
>>  {
>>  	const struct range *r1, *r2 = data;
>> diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
>> new file mode 100644
>> index 000000000000..fe367759ac69
>> --- /dev/null
>> +++ b/drivers/cxl/core/region_dax.c
>> @@ -0,0 +1,109 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright(c) 2022 Intel Corporation. All rights reserved.
>> + * Copyright(c) 2026 Meta Technologies Inc. All rights reserved.
>> + */
>> +#include <linux/device.h>
>> +#include <linux/slab.h>
>> +#include <cxlmem.h>
>> +#include <cxl.h>
>> +#include "core.h"
>> +
>> +static void cxl_dax_region_release(struct device *dev)
>> +{
>> +	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
>> +
>> +	kfree(cxlr_dax);
>> +}
>> +
>> +static const struct attribute_group *cxl_dax_region_attribute_groups[] = {
>> +	&cxl_base_attribute_group,
>> +	NULL
>> +};
>> +
>> +const struct device_type cxl_dax_region_type = {
>> +	.name = "cxl_dax_region",
>> +	.release = cxl_dax_region_release,
>> +	.groups = cxl_dax_region_attribute_groups,
>> +};
>> +
>> +static bool is_cxl_dax_region(struct device *dev)
>> +{
>> +	return dev->type == &cxl_dax_region_type;
>> +}
>> +
>> +struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
>> +{
>> +	if (dev_WARN_ONCE(dev, !is_cxl_dax_region(dev),
>> +			  "not a cxl_dax_region device\n"))
>> +		return NULL;
>> +	return container_of(dev, struct cxl_dax_region, dev);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
>> +
>> +static struct lock_class_key cxl_dax_region_key;
>> +
>> +static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
>> +{
>> +	struct cxl_region_params *p = &cxlr->params;
>> +	struct cxl_dax_region *cxlr_dax;
>> +	struct device *dev;
>> +
>> +	guard(rwsem_read)(&cxl_rwsem.region);
>> +	if (p->state != CXL_CONFIG_COMMIT)
>> +		return ERR_PTR(-ENXIO);
>> +
>> +	cxlr_dax = kzalloc_obj(*cxlr_dax);
>> +	if (!cxlr_dax)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	cxlr_dax->hpa_range.start = p->res->start;
>> +	cxlr_dax->hpa_range.end = p->res->end;
>> +
>> +	dev = &cxlr_dax->dev;
>> +	cxlr_dax->cxlr = cxlr;
> 	cxlr->cxlr_dax = cxlr_dax;
> 
> Running into segfaults without this ^

Can you pls create a fixes patch?

DJ

>> +	device_initialize(dev);
>> +	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
>> +	device_set_pm_not_required(dev);
>> +	dev->parent = &cxlr->dev;
>> +	dev->bus = &cxl_bus_type;
>> +	dev->type = &cxl_dax_region_type;
>> +
>> +	return cxlr_dax;
>> +}
>> +
>> +static void cxlr_dax_unregister(void *_cxlr_dax)
>> +{
>> +	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
>> +
>> +	device_unregister(&cxlr_dax->dev);
>> +}
>> +
>> +int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>> +{
>> +	struct cxl_dax_region *cxlr_dax;
>> +	struct device *dev;
>> +	int rc;
>> +
>> +	cxlr_dax = cxl_dax_region_alloc(cxlr);
>> +	if (IS_ERR(cxlr_dax))
>> +		return PTR_ERR(cxlr_dax);
>> +
>> +	dev = &cxlr_dax->dev;
>> +	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
>> +	if (rc)
>> +		goto err;
>> +
>> +	rc = device_add(dev);
>> +	if (rc)
>> +		goto err;
>> +
>> +	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
>> +		dev_name(dev));
>> +
>> +	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
>> +					cxlr_dax);
>> +err:
>> +	put_device(dev);
>> +	return rc;
>> +}
>> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
>> index f53d79a05661..d2b291e5f842 100644
>> --- a/tools/testing/cxl/Kbuild
>> +++ b/tools/testing/cxl/Kbuild
>> @@ -59,7 +59,7 @@ cxl_core-y += $(CXL_CORE_SRC)/hdm.o
>>  cxl_core-y += $(CXL_CORE_SRC)/pmu.o
>>  cxl_core-y += $(CXL_CORE_SRC)/cdat.o
>>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
>> -cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o $(CXL_CORE_SRC)/region_pmem.o
>> +cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o $(CXL_CORE_SRC)/region_pmem.o $(CXL_CORE_SRC)/region_dax.o
>>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
>>  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
>>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
>> -- 
>> 2.53.0
>>

