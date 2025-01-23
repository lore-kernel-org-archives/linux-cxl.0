Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F663288A2
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737647367; cv=none; b=sY06GcQ23/djYeieBAYMV3mNUe01ZBJRLNnBtkUgOdyptks+WnR6S59OJerw1oB1hf28IKaj0EDnXPyrTH4FJjeVhwKEFjjb6CRis8l/9UF60bP4/5HNKILHYl39JyX0AZyKlQLvFKbaRqH1wGtOjnIn0Iwu10izPH8osXJ46PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737647367; c=relaxed/simple;
	bh=bm0WdbggNU2J3YsImOc1HqQ4NxK1WNaYxysGz5pH2ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRXD6lGuHxKOoTRc6fUMN6My3pP29CcyQ0YNGBcgX5ebcx6d3rr9fxyvQ4vMIXIEUgJsxp6WM0A2ZD3zdeNibBf7X6QDYkHHRJMZ3MbHdqgBrb0l6gSfIX+IgUh2W1fYGSVK73RVpBxB3Fs+62tu280T0XaB9bLFkZd19M538u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yq4mDHRO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yq4mDHRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737647365; x=1769183365;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bm0WdbggNU2J3YsImOc1HqQ4NxK1WNaYxysGz5pH2ao=;
  b=Yq4mDHROC7SWIgr3j9xhKYlHue36CDYCSs3+Tmg1OiMbf9vOwdqQ/H8B
   /JkMa3LPNH/5t3k2vfPVx1kad6cQAib8y4kxhH3lxIERSIviHPJFo+Wj7
   YwX5hGexFiAJMr9Yu6abRGL4K/ZICcrSafoP0AtZkEyhEG/k9+DYuY/14
   FeHEXvjvnpLF9cOnjYNsFPMXu6fWqR6NKF0EEEsNtEOijlL2TVhshrEQU
   7boER2v3/4VkhNqT0w/VguOqTZilD4oZTx5tp3+nzTIRCrUaux2GGmEv1
   MO0Gt3mKAn26b1+LeFub0QDQUoPWqwg+H3jxEwjiBqTzALT4cd33Yt8/y
   w==;
X-CSE-ConnectionGUID: TE/D4sl0Rj6tqGXpb9RbaQ==
X-CSE-MsgGUID: gMZPZWzJSq+os7mUc2v/CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38401538"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="38401538"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 07:49:25 -0800
X-CSE-ConnectionGUID: 9VnpOaMoRxmtvQ44M0R+rA==
X-CSE-MsgGUID: QYlvp3fmR4qAW1TiEWJeGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108359739"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.110.229]) ([10.125.110.229])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 07:49:24 -0800
Message-ID: <ad962652-395e-4bdd-ba8d-a82d5dfe27e3@intel.com>
Date: Thu, 23 Jan 2025 08:49:23 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/19] cxl: Add skeletal features driver
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-3-dave.jiang@intel.com>
 <6791be94971b2_9b92294d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6791be94971b2_9b92294d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/22/25 8:59 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> Add the basic bits of a features driver to handle all CXL feature related
>> services. The driver is expected to handle all CXL mailbox feature command
>> related operations.
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/Kconfig                   | 11 +++++
>>  drivers/cxl/Makefile                  |  3 ++
>>  drivers/cxl/core/Makefile             |  1 +
>>  drivers/cxl/core/core.h               |  1 +
>>  drivers/cxl/core/features.c           | 71 +++++++++++++++++++++++++++
>>  drivers/cxl/core/port.c               |  3 ++
>>  drivers/cxl/cxl.h                     |  1 +
>>  drivers/cxl/features.c                | 44 +++++++++++++++++
>>  drivers/cxl/pci.c                     | 19 +++++++
>>  include/cxl/features.h                | 23 +++++++++
>>  include/cxl/mailbox.h                 |  3 ++
>>  tools/testing/cxl/Kbuild              |  7 +++
>>  tools/testing/cxl/cxl_features_test.c |  6 +++
>>  13 files changed, 193 insertions(+)
>>  create mode 100644 drivers/cxl/core/features.c
>>  create mode 100644 drivers/cxl/features.c
>>  create mode 100644 include/cxl/features.h
>>  create mode 100644 tools/testing/cxl/cxl_features_test.c
>>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 876469e23f7a..9a6ffd81ac0e 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -146,4 +146,15 @@ config CXL_REGION_INVALIDATION_TEST
>>  	  If unsure, or if this kernel is meant for production environments,
>>  	  say N.
>>  
>> +config CXL_FEATURES
>> +	tristate "CXL: Features support"
>> +	default CXL_BUS
> 
> Not sure this default makes sense. All of the other "default CXL_BUS" is
> because only an expert config would ever turn on CXL.mem support but
> leave one of CONFIG_CXL_{PCI,ACPI,MEM,REGION,PORT} disabled.
> 
> Features are purely incremental.
> 
>> +	help
>> +	  Enable CXL features support that are tied to a CXL mailbox.
>> +	  The support for features including the feature mailbox
>> +	  commands and also FWCTL support of the commands via user
>> +	  space.
> 
> Perhaps a couple prominent examples of Features an end user might know
> by name? Otherwise "Features" is too generic a term for making the case
> for turning this on.
> 
>> +
>> +	  If unsure say 'y'.
> 
> ...say 'n', someone had better have a feature in mind for this optional
> functionality.
> 
>> +
>>  endif
>> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
>> index 2caa90fa4bf2..4696fc218df4 100644
>> --- a/drivers/cxl/Makefile
>> +++ b/drivers/cxl/Makefile
>> @@ -7,15 +7,18 @@
>>  # - 'mem' and 'pmem' before endpoint drivers so that memdevs are
>>  #   immediately enabled
>>  # - 'pci' last, also mirrors the hardware enumeration hierarchy
>> +# - 'features' comes after pci device is enumerated
>>  obj-y += core/
>>  obj-$(CONFIG_CXL_PORT) += cxl_port.o
>>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>>  obj-$(CONFIG_CXL_MEM) += cxl_mem.o
>>  obj-$(CONFIG_CXL_PCI) += cxl_pci.o
>> +obj-$(CONFIG_CXL_FEATURES) += cxl_features.o
>>  
>>  cxl_port-y := port.o
>>  cxl_acpi-y := acpi.o
>>  cxl_pmem-y := pmem.o security.o
>>  cxl_mem-y := mem.o
>>  cxl_pci-y := pci.o
>> +cxl_features-y := features.o
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index 9259bcc6773c..73b6348afd67 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -14,5 +14,6 @@ cxl_core-y += pci.o
>>  cxl_core-y += hdm.o
>>  cxl_core-y += pmu.o
>>  cxl_core-y += cdat.o
>> +cxl_core-y += features.o
>>  cxl_core-$(CONFIG_TRACING) += trace.o
>>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 23761340e65c..e8a3df226643 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -9,6 +9,7 @@
>>  extern const struct device_type cxl_nvdimm_bridge_type;
>>  extern const struct device_type cxl_nvdimm_type;
>>  extern const struct device_type cxl_pmu_type;
>> +extern const struct device_type cxl_features_type;
>>  
>>  extern struct attribute_group cxl_base_attribute_group;
>>  
>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>> new file mode 100644
>> index 000000000000..eb6eb191a32e
>> --- /dev/null
>> +++ b/drivers/cxl/core/features.c
>> @@ -0,0 +1,71 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
>> +#include <linux/device.h>
>> +#include "cxl.h"
>> +#include "core.h"
>> +
>> +#define CXL_FEATURE_MAX_DEVS 65536
>> +static DEFINE_IDA(cxl_features_ida);
>> +
>> +static void cxl_features_release(struct device *dev)
>> +{
>> +	struct cxl_features *features = to_cxl_features(dev);
> 
> Perhaps make this and other local 'struct cxl_feature' pointers 'cxlf'?
> 
> Just to keep with the theme of 'cxl<short-suffix>' for local pointers?
> 
> 
>> +
>> +	ida_free(&cxl_features_ida, features->id);
>> +	kfree(features);
>> +}
>> +
>> +static void remove_features_dev(void *dev)
>> +{
>> +	device_unregister(dev);
>> +}
>> +
>> +const struct device_type cxl_features_type = {
>> +	.name = "features",
>> +	.release = cxl_features_release,
>> +};
>> +EXPORT_SYMBOL_NS_GPL(cxl_features_type, "CXL");
>> +
>> +struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
>> +					struct device *parent)
> 
> So this function is alloc + add + devm auto-release. I would call it:
> 
>     devm_cxl_add_features()
> 
>> +{
>> +	struct device *dev;
>> +	int rc;
>> +
>> +	struct cxl_features *features __free(kfree) =
>> +		kzalloc(sizeof(*features), GFP_KERNEL);
>> +	if (!features)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	rc = ida_alloc_max(&cxl_features_ida, CXL_FEATURE_MAX_DEVS - 1,
>> +			   GFP_KERNEL);
> 
> Does this need its own ida? I expect it could just use the same id as
> the memdev, and that saves some potential confusion of which
> memory-devices support features and which features interface correlates
> with which device.
> 
> ...or how do you imagine that working?

One of the issue was that the feature commands query happens before memdev is created. So that ida doesn't exist yet. In order to share, we'll need to do a split initialization of the feature device. But really I was trying to separate the association of features from the memdev as they are independent of each other. i.e a type2 may not have memdev but have mailbox and features.

DJ 

> 
>> +	if (rc < 0)
>> +		return ERR_PTR(rc);
>> +
>> +	features->id = rc;
>> +	features->cxl_mbox = cxl_mbox;
>> +	dev = &features->dev;
>> +	device_initialize(dev);
> 
> At this point @features stops being freed by kzalloc and starts being
> freed by put_device(). Which means that no_free_ptr() on @features needs
> to be called before put_device().
> 
> So I would put all of that in a function that does the
> alloc+device_initialize() then you can do:
> 
> DEFINE_FREE(put_cxl_features, struct cxl_features *,
>             if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
> struct cxl_features *cxlf = __free(put_cxl_features) = alloc_features(...);
> 
>> +	device_set_pm_not_required(dev);
>> +	dev->parent = parent;
>> +	dev->bus = &cxl_bus_type;
>> +	dev->type = &cxl_features_type;
>> +	rc = dev_set_name(dev, "features%d", features->id);
>> +	if (rc)
>> +		goto err;
>> +
>> +	rc = device_add(dev);
>> +	if (rc)
>> +		goto err;
>> +
>> +	rc = devm_add_action_or_reset(parent, remove_features_dev, dev);
>> +	if (rc)
>> +		goto err;
> 
> ...otherwise all of the gotos above causes a double-free of @features as
> far as I can see.
> 
> Mixing goto and scoped-base-cleanup... often a bug.
> 
>> +
>> +	return no_free_ptr(features);
>> +
>> +err:
>> +	put_device(dev);
>> +	return ERR_PTR(rc);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_features_alloc, "CXL");
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 78a5c2c25982..cc53a597cae6 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -74,6 +74,9 @@ static int cxl_device_id(const struct device *dev)
>>  		return CXL_DEVICE_REGION;
>>  	if (dev->type == &cxl_pmu_type)
>>  		return CXL_DEVICE_PMU;
>> +	if (dev->type == &cxl_features_type)
>> +		return CXL_DEVICE_FEATURES;
>> +
>>  	return 0;
>>  }
>>  
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index f6015f24ad38..ee29d1a1c8df 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -855,6 +855,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
>>  #define CXL_DEVICE_PMEM_REGION		7
>>  #define CXL_DEVICE_DAX_REGION		8
>>  #define CXL_DEVICE_PMU			9
>> +#define CXL_DEVICE_FEATURES		10
>>  
>>  #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
>>  #define CXL_MODALIAS_FMT "cxl:t%d"
>> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
>> new file mode 100644
>> index 000000000000..644add26975f
>> --- /dev/null
>> +++ b/drivers/cxl/features.c
>> @@ -0,0 +1,44 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright(c) 2024,2025 Intel Corporation. All rights reserved. */
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <cxl/features.h>
>> +
>> +#include "cxl.h"
>> +
>> +static int cxl_features_probe(struct device *dev)
>> +{
>> +	struct cxl_features *features = to_cxl_features(dev);
>> +	struct cxl_features_state *cfs __free(kfree) =
>> +		kzalloc(sizeof(*cfs), GFP_KERNEL);
> 
> Just makes this:
> 
> 	struct cxl_features_state *cfs = devm_kzalloc(sizeof(*cfs), GFP_KERNEL);
>> +
>> +	if (!cfs)
>> +		return -ENOMEM;
>> +
>> +	cfs->features = features;
>> +	dev_set_drvdata(dev, no_free_ptr(cfs));
> 
> ...skip the no_free_ptr()
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static void cxl_features_remove(struct device *dev)
>> +{
>> +	struct cxl_features_state *cfs = dev_get_drvdata(dev);
>> +
>> +	kfree(cfs);
>> +}
> 
> ...and skip the need for a ->remove() routine altogether.
> 
>> +
>> +static struct cxl_driver cxl_features_driver = {
>> +	.name = "cxl_features",
>> +	.probe = cxl_features_probe,
>> +	.remove = cxl_features_remove,
>> +	.id = CXL_DEVICE_FEATURES,
>> +};
>> +
>> +module_cxl_driver(cxl_features_driver);
>> +
>> +MODULE_DESCRIPTION("CXL: Features");
> 
> Maybe a few more words:
> 
>     "CXL 'Feature' command support via FWCTL"
> 
>> +MODULE_LICENSE("GPL");
>> +MODULE_IMPORT_NS("CXL");
>> +MODULE_ALIAS_CXL(CXL_DEVICE_FEATURES);
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 6d94ff4a4f1a..eb68dd3f8b21 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -386,6 +386,21 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>>  	return rc;
>>  }
>>  
>> +static int cxl_pci_setup_features(struct cxl_memdev_state *mds)
>> +{
>> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> 
> Looks like this function wants to take @cxlds directly and skip passing
> in @mds.
> 
>> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>> +	struct cxl_features *features;
>> +
>> +	features = cxl_features_alloc(cxl_mbox, cxlds->dev);
>> +	if (IS_ERR(features))
>> +		return PTR_ERR(features);
>> +
>> +	cxl_mbox->features = features;
>> +
>> +	return 0;
>> +}
>> +
>>  static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>>  {
>>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>> @@ -980,6 +995,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  	if (rc)
>>  		return rc;
>>  
>> +	rc = cxl_pci_setup_features(mds);
>> +	if (rc)
>> +		return rc;
>> +
>>  	rc = cxl_set_timestamp(mds);
>>  	if (rc)
>>  		return rc;
>> diff --git a/include/cxl/features.h b/include/cxl/features.h
>> new file mode 100644
>> index 000000000000..b92da1e92780
>> --- /dev/null
>> +++ b/include/cxl/features.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright(c) 2024-2025 Intel Corporation. */
>> +#ifndef __CXL_FEATURES_H__
>> +#define __CXL_FEATURES_H__
>> +
>> +struct cxl_mailbox;
>> +
>> +struct cxl_features {
>> +	int id;
>> +	struct device dev;
>> +	struct cxl_mailbox *cxl_mbox;
> 
> A bit uncomfortable with a 'struct cxl_features' instance having a
> pointer to a 'struct cxl_mailbox' without holding a refcount.
> 
> This all works becase cxl_pci_setup_features() knows that the @parent
> it is passing to cxl_features_alloc() is device that will also
> unregister the @features device before destroying the 'struct
> cxl_mailbox' instance in @cxlds.
> 
> 
>> +};
>> +#define to_cxl_features(dev) container_of(dev, struct cxl_features, dev)
>> +
>> +struct cxl_features_state {
>> +	struct cxl_features *features;
>> +	int num_features;
>> +};
>> +
>> +struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
>> +					struct device *parent);
> 
> ...but this is proposed as a public function outside of cxl_pci. How
> does cxl_features_alloc() understand the lifetime relationships between
> its @cxl_mbox and @parent arguments?
> 
> I would have cxl_features_alloc() (devm_cxl_add_features()) take a
> 'struct cxl_dev_state *' argument which makes it clear that the features
> device must be unregistered before 'struct cxl_dev_state *' can be
> destroyed.
> 
> ...or something to constrain the freedom of a new globally public
> export. Does this need to be made available to any other drivers besides
> cxl_pci for now?
> 
> I.e. should this be include/cxl/features.h or drivers/cxl/features.h?

