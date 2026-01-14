Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC92D877B;
	Wed, 14 Jan 2026 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411105; cv=none; b=CWzG40thCAYIFAQgeHq5qk7bQLdKqaL9ria9J8OrX8voWy+K+2OoNziK+6SFysX1IZKEpb8aaQdzgEC4NksqjyKHzsEZzzSnU+/ho30LqneqAtsSemtDwCjsGouu5iP/oQ3AL8XmLrsTgmUR0JDYlLT1pzTKzheZHZUxIAUxsU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411105; c=relaxed/simple;
	bh=tH0HPekY/K2bAe7C0UN/X1KeIfocXxi/IVIFPZi1xdY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WA3CkxXA61FMkphhu8iNCyqKkthQRbWbdPQLRStXMkRdeLETxEY/ThCGGP6/K+9DxidEW3NZnSXtYvMxVo28/Z+YHWMnLczeFU7hqL4BedeRZbfoJlz4vwRF4ETvqeiCesSXpuyhvCEMpB+iFkiAmggLtC266SpRKj4rDiZ+/hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drt9J6dTXzHnGhr;
	Thu, 15 Jan 2026 01:17:56 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C52C40584;
	Thu, 15 Jan 2026 01:18:17 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 17:18:10 +0000
Date: Wed, 14 Jan 2026 17:18:08 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/6] drivers/cxl: add cxl_memctrl_mode and
 region->memctrl
Message-ID: <20260114171808.000067e2@huawei.com>
In-Reply-To: <20260112163514.2551809-2-gourry@gourry.net>
References: <20260112163514.2551809-1-gourry@gourry.net>
	<20260112163514.2551809-2-gourry@gourry.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 12 Jan 2026 11:35:09 -0500
Gregory Price <gourry@gourry.net> wrote:

> The CXL driver presently hands policy management over to DAX subsystem
> for sysram regions, which makes building policy around the entire region
> clunky and at time difficult (e.g. multiple actions to offline and
> hot-unplug memory reliably).
> 
> To support multiple backend controllers for memory regions (for example
> dax vs direct hotplug), implement a memctrl field in cxl_region allows
> switching uncomitted regions between different "memory controllers".
> 
> CXL_CONTROL_NONE: No selected controller, probe will fail.
> CXL_CONTROL_AUTO: If memory is already online as SysRAM, no controller
>                   otherwise register a dax_region
> CXL_CONTROL_DAX : register a dax_region
> 
> Auto regions will either be static sysram (BIOS-onlined) and has no
> region controller associated with it - or if the SP bit was set a
> DAX device will be created.
> 
> Rather than default all regions to the auto-controller, only default
> auto-regions to the auto controller.
> 
> Non-auto regions will be defaulted to CXL_CONTROL_NONE, which will cause
> a failure to probe unless a controller is selected.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
Trivial comments whilst I try to get my head around the series.

...

> diff --git a/drivers/cxl/core/memctrl/Makefile b/drivers/cxl/core/memctrl/Makefile
> new file mode 100644
> index 000000000000..8165aad5a52a
> --- /dev/null
> +++ b/drivers/cxl/core/memctrl/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +cxl_core-$(CONFIG_CXL_REGION) += memctrl/memctrl.o
> +cxl_core-$(CONFIG_CXL_REGION) += memctrl/dax_region.o
> diff --git a/drivers/cxl/core/memctrl/dax_region.c b/drivers/cxl/core/memctrl/dax_region.c
> new file mode 100644
> index 000000000000..90d7fdb97013
> --- /dev/null
> +++ b/drivers/cxl/core/memctrl/dax_region.c

Can we break the code move out as a precursor with a bit of explanation of
why?  I want to be able to spot functional changes more easily.


> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <cxlmem.h>
> +#include <cxl.h>
> +#include "../core.h"
> +
> +static struct lock_class_key cxl_dax_region_key;

> +
> +/*
> + * The dax controller is the default controller and simply hands the
> + * control pattern over to the dax driver.  It does with a dax_region
> + * built by dax/cxl.c
> + */
> +int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_dax_region *cxlr_dax;
> +	struct device *dev;
> +	int rc;
> +
> +	cxlr_dax = cxl_dax_region_alloc(cxlr);

Nice to spinkle __free magic on this one though obviously 
unrelated to what you are focused on here!


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
> diff --git a/drivers/cxl/core/memctrl/memctrl.c b/drivers/cxl/core/memctrl/memctrl.c
> new file mode 100644
> index 000000000000..24e0e14b39c7
> --- /dev/null
> +++ b/drivers/cxl/core/memctrl/memctrl.c
...

> +int cxl_enable_memctrl(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +
> +	switch (cxlr->memctrl) {
> +	case CXL_MEMCTRL_AUTO:
> +		/*
> +		 * The region can not be manged by CXL if any portion of
> +		 * it is already online as 'System RAM'
> +		 */
> +		if (walk_iomem_res_desc(IORES_DESC_NONE,
> +					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +					p->res->start, p->res->end, cxlr,
> +					is_system_ram) > 0)
> +			return 0;
> +		return devm_cxl_add_dax_region(cxlr);
> +	case CXL_MEMCTRL_DAX:
> +		return devm_cxl_add_dax_region(cxlr);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
I can't resist pointing out the trivial.  One line sufficient.

> +
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ae899f68551f..02d7d9ae0252 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -626,6 +626,50 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(mode);
>  
> +static ssize_t ctrl_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	const char *desc;
> +
> +	switch (cxlr->memctrl) {
> +	case CXL_MEMCTRL_AUTO:
> +		desc = "auto";

If any expectation of non trivial number of these, look up in an array rather
than a switch statement. I'll scale better.

> +		break;
> +	case CXL_MEMCTRL_DAX:
> +		desc = "dax";
> +		break;
> +	default:

I'd call this out as NONE simply as then the compiler will point out if you
missed adding code here when a new type is added.

> +		desc = "";
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%s\n", desc);
> +}

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ba17fa86d249..b8fabaa77262 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -502,6 +502,19 @@ enum cxl_partition_mode {
>  	CXL_PARTMODE_PMEM,
>  };
>  
> +
> +/*
> + * Memory Controller modes:

Give it kernel-doc. 

> + *   None - No controller selected
> + *   Auto - either BIOS-configured as SysRAM, or default to DAX
> + *   DAX  - creates a dax_region controller for the cxl_region
> + */
> +enum cxl_memctrl_mode {
> +	CXL_MEMCTRL_NONE,
> +	CXL_MEMCTRL_AUTO,
> +	CXL_MEMCTRL_DAX,
> +};
> +
>  /*
>   * Indicate whether this region has been assembled by autodetection or
>   * userspace assembly. Prevent endpoint decoders outside of automatic
> @@ -543,6 +556,7 @@ struct cxl_region {
>  	struct device dev;
>  	int id;
>  	enum cxl_partition_mode mode;
> +	enum cxl_memctrl_mode memctrl;
Needs kernel-doc.

>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_pmem_region *cxlr_pmem;

