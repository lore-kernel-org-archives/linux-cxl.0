Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690844C6D
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738371881; cv=none; b=iZZwk0uO2ticm7JusuK+V2VPyZBergXr5sPAhGc7BrlLb1B4Fy2bjdh/zjr8o+3EHz7WzCh+Jc4vjQ1+xDq0APUuY4sZmYFUdGlOn8pRwMK9BdVVNteAxvVXbAiiCOm2xf4pN3E4EESn9OvTIruLh7odSmpEw1+ZygZXNI13Ix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738371881; c=relaxed/simple;
	bh=ufLNIYXfgHeOolWaFoQdDAys0g122nNCPbzLC/5mxlc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nflJ73Tw5qlPD4GSF3lKGnZUHH6alU8l9Mo1WIxfVfGSQvdIor78tiVtLYgGAD2fnLnA+WYb1pxHBVCobLkD7uwZmYLbMzsbRKCqOdUerWul1EWoP2qpIch0+u8QXMgi2l92hUQcGQevoP0Alhnol8xbL7h0fsmTHZYN6MbmuW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DldC9YEY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DldC9YEY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738371879; x=1769907879;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ufLNIYXfgHeOolWaFoQdDAys0g122nNCPbzLC/5mxlc=;
  b=DldC9YEYfAQJjaWHgz+H3pZltNWrFxE6rMDvGT8CpEoxYuOGUQq98FQO
   fIbdQyFQ8BtE2gyZOqqMvQOJnGrAvS4/SfS//Vm4Ir7pf+6Daw+fWNV9/
   vgeKz309ER8K93XIcsA2WddRSAQ8Y1mAnXd5+euqKNj48jooUWyz5Moiy
   huoDcyFXaqiou+nOspnjkYblCo6QmYlqM6iox3EdU9XO4jicI0//r0SMT
   dOwgw8uFwcor/wov4rS/imPFO7NSzKEQehTCYbxWMcyE5xLtRwztwcBGU
   McDb6Glcww1+PvubBAcLxcmNThkkqZ4sFVKvHzqGuYashmgdYx0A5YHXO
   Q==;
X-CSE-ConnectionGUID: h9jsylNlQQ+3GB8JIvm7lw==
X-CSE-MsgGUID: 78m47dYsSaWrQe+9tO/TYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="56492420"
X-IronPort-AV: E=Sophos;i="6.13,250,1732608000"; 
   d="scan'208";a="56492420"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 17:04:38 -0800
X-CSE-ConnectionGUID: x4V8lWO2RAeTHjRxBdonGA==
X-CSE-MsgGUID: QWxwDserT7iiD/FsgnGMFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="114766728"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.72]) ([10.125.109.72])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 17:04:38 -0800
Message-ID: <49044e97-fe18-446b-8eb6-1affff84f4c1@intel.com>
Date: Fri, 31 Jan 2025 18:04:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] cxl: Add FWCTL support to the CXL memdev driver
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250201004459.466499-1-dave.jiang@intel.com>
 <20250201004459.466499-9-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20250201004459.466499-9-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/31/25 5:42 PM, Dave Jiang wrote:
> Add fwctl support code to allow sending of CXL feature commands from
> userspace through as ioctls via FWCTL. Provide initial setup bits.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Associate FWCTL with the 'cxl_memdev' through the memdev driver. (Dan)
> - I'm leaving Jonathan's tag off to get this looked at again.
> - Hide FWCTL code behind CONFIG_CXL_FWCTL (Dan)
> ---
>  drivers/cxl/Kconfig        | 15 +++++++
>  drivers/cxl/Makefile       |  1 +
>  drivers/cxl/features.c     | 35 ++++++++++++---
>  drivers/cxl/features.h     |  2 +
>  drivers/cxl/fwctl.c        | 88 ++++++++++++++++++++++++++++++++++++++
>  include/cxl/features.h     |  3 ++
>  include/uapi/fwctl/fwctl.h |  1 +
>  tools/testing/cxl/Kbuild   |  1 +
>  8 files changed, 140 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/cxl/fwctl.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 876469e23f7a..34731890bc8e 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -102,6 +102,21 @@ config CXL_MEM
>  
>  	  If unsure say 'm'.
>  
> +config CXL_FWCTL
> +	bool "CXL: Firmware Control support"
> +	depends on CXL_MEM
> +	select FWCTL
> +	help
> +	  Enable support for firmware control of CXL devices. This allows
> +	  a FWCTL char device to be created in order to issue ioctls from
> +	  user space to exercise the CXL Features commands supported by
> +	  a CXL mailbox. There are some Features defined in the CXL spec
> +	  such as memory sparing. However a lof of those features are

s/lof/lot/

> +	  exclusive to the kernel. Most likely the Features maniulated
s/maniulated/manipulated/

wonder why checkpatch did not catch these but caught others

> +	  by CXL_FWCTL will be vendor defined Features.
> +
> +	  If unsure say 'n'.
> +
>  config CXL_PORT
>  	default CXL_BUS
>  	tristate
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index 12fbc35081bb..cd28fb3bf855 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -18,4 +18,5 @@ cxl_port-y := port.o
>  cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o security.o
>  cxl_mem-y := mem.o features.o
> +cxl_mem-$(CONFIG_CXL_FWCTL) += fwctl.o
>  cxl_pci-y := pci.o
> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> index 82598a409acc..2dcfefdfa6b3 100644
> --- a/drivers/cxl/features.c
> +++ b/drivers/cxl/features.c
> @@ -1,8 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
> +#include <linux/pci.h>
>  #include <linux/device.h>
> +#include <linux/module.h>
>  #include <cxl/mailbox.h>
>  #include <cxl/features.h>
> +

stray blank line, will remove

DJ

>  #include "cxl.h"
>  #include "cxlmem.h"
>  #include "features.h"
> @@ -168,11 +171,31 @@ static void enumerate_feature_cmds(struct cxl_memdev *cxlmd,
>  	cxlfs->cap = CXL_FEATURES_RW;
>  }
>  
> +/* The __weak symbol gets replaced by FWCTL allocation function in fwctl.c */
> +struct cxl_features_state * __weak devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
> +{
> +	struct device *dev = &cxlmd->dev;
> +	struct cxl_features_state *cxlfs =
> +		devm_kzalloc(dev, sizeof(*cxlfs), GFP_KERNEL);
> +
> +	if (!cxlfs)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlfs->cxlmd = cxlmd;
> +
> +	return cxlfs;
> +}
> +
> +/* The __weak symbol gets replaced by FWCTL free function in fwctl.c */
> +void __weak devm_cxlfs_free(struct cxl_memdev *cxlmd)
> +{
> +	devm_kfree(&cxlmd->dev, cxlmd->cxlfs);
> +	cxlmd->cxlfs = NULL;
> +}
> +
>  static void cxl_cxlfs_free(struct cxl_features_state *cxlfs)
>  {
> -	struct device *dev = &cxlfs->cxlmd->dev;
> -
> -	devm_kfree(dev, cxlfs);
> +	devm_cxlfs_free(cxlfs->cxlmd);
>  }
>  
>  DEFINE_FREE(free_cxlfs, struct cxl_features_state *, if (_T) cxl_cxlfs_free(_T))
> @@ -185,15 +208,13 @@ DEFINE_FREE(free_cxlfs, struct cxl_features_state *, if (_T) cxl_cxlfs_free(_T))
>   */
>  int devm_cxl_add_features(struct cxl_memdev *cxlmd)
>  {
> -	struct device *dev = &cxlmd->dev;
>  	int rc;
>  
>  	struct cxl_features_state *cxlfs __free(free_cxlfs) =
> -		devm_kzalloc(dev, sizeof(*cxlfs), GFP_KERNEL);
> +		devm_cxlfs_allocate(cxlmd);
>  	if (!cxlfs)
>  		return -ENOMEM;
>  
> -	cxlfs->cxlmd = cxlmd;
>  	enumerate_feature_cmds(cxlmd, cxlfs);
>  	rc = get_supported_features(cxlmd, cxlfs);
>  	if (rc)
> @@ -204,3 +225,5 @@ int devm_cxl_add_features(struct cxl_memdev *cxlmd)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_features, "CXL");
> +
> +MODULE_IMPORT_NS("CXL");
> diff --git a/drivers/cxl/features.h b/drivers/cxl/features.h
> index 8706f944b476..e487c24ff06f 100644
> --- a/drivers/cxl/features.h
> +++ b/drivers/cxl/features.h
> @@ -5,6 +5,8 @@
>  
>  struct cxl_feat_entry;
>  
> +struct cxl_features_state *devm_cxlfs_allocate(struct cxl_memdev *cxlmd);
> +void devm_cxlfs_free(struct cxl_memdev *cxlmd);
>  int devm_cxl_add_features(struct cxl_memdev *cxlmd);
>  bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry);
>  
> diff --git a/drivers/cxl/fwctl.c b/drivers/cxl/fwctl.c
> new file mode 100644
> index 000000000000..d8fd68ac8982
> --- /dev/null
> +++ b/drivers/cxl/fwctl.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2025 Intel Corporation. All rights reserved. */
> +#include <linux/fwctl.h>
> +#include <linux/device.h>
> +#include <cxl/features.h>
> +#include "cxlmem.h"
> +#include "features.h"
> +
> +static int cxlctl_open_uctx(struct fwctl_uctx *uctx)
> +{
> +	return 0;
> +}
> +
> +static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
> +{
> +}
> +
> +static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
> +{
> +	/* Place holder */
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> +			   void *rpc_in, size_t in_len, size_t *out_len)
> +{
> +	/* Place holder */
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static const struct fwctl_ops cxlctl_ops = {
> +	.device_type = FWCTL_DEVICE_TYPE_CXL,
> +	.uctx_size = sizeof(struct fwctl_uctx),
> +	.open_uctx = cxlctl_open_uctx,
> +	.close_uctx = cxlctl_close_uctx,
> +	.info = cxlctl_info,
> +	.fw_rpc = cxlctl_fw_rpc,
> +};
> +
> +static void remove_cxlfs(void *_cxlfs)
> +{
> +	struct cxl_features_state *cxlfs = _cxlfs;
> +	struct cxl_memdev *cxlmd = cxlfs->cxlmd;
> +	struct fwctl_device *fwctl = &cxlfs->fwctl;
> +
> +	cxlmd->cxlfs = NULL;
> +	fwctl_unregister(fwctl);
> +	fwctl_put(fwctl);
> +}
> +
> +DEFINE_FREE(free_cxlfs, struct cxl_features_state *, if (_T) fwctl_put(&_T->fwctl))
> +
> +static struct cxl_features_state *
> +__devm_cxl_cfs_allocate(struct cxl_memdev *cxlmd, const struct fwctl_ops *ops)
> +{
> +	struct device *dev = &cxlmd->dev;
> +	int rc;
> +
> +	struct cxl_features_state *cxlfs __free(free_cxlfs) =
> +		fwctl_alloc_device(dev, ops, struct cxl_features_state, fwctl);
> +	if (!cxlfs)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlfs->cxlmd = cxlmd;
> +	rc = fwctl_register(&cxlfs->fwctl);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	rc = devm_add_action_or_reset(dev, remove_cxlfs, cxlfs);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	return no_free_ptr(cxlfs);
> +}
> +
> +struct cxl_features_state *devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
> +{
> +	return __devm_cxl_cfs_allocate(cxlmd, &cxlctl_ops);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxlfs_allocate, "CXL");
> +
> +void devm_cxlfs_free(struct cxl_memdev *cxlmd)
> +{
> +	devm_release_action(&cxlmd->dev, remove_cxlfs, cxlmd);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxlfs_free, "CXL");
> +
> +MODULE_IMPORT_NS("FWCTL");
> diff --git a/include/cxl/features.h b/include/cxl/features.h
> index 7ae84696d6dd..7c43ac021a8c 100644
> --- a/include/cxl/features.h
> +++ b/include/cxl/features.h
> @@ -4,6 +4,7 @@
>  #define __CXL_FEATURES_H__
>  
>  #include <linux/uuid.h>
> +#include <linux/fwctl.h>
>  
>  /* Feature UUIDs used by the kernel */
>  #define CXL_FEAT_PATROL_SCRUB_UUID						\
> @@ -57,6 +58,7 @@ enum cxl_features_capability {
>  
>  /**
>   * struct cxl_features_state - The Features state for the device
> + * @fwctl: FWCTL device
>   * @cxlmd: Pointer to cxl mem device
>   * @cap: Feature commands capability
>   * @num_features: total Features supported by the device
> @@ -64,6 +66,7 @@ enum cxl_features_capability {
>   * @entries: Feature detail entries fetched from the device
>   */
>  struct cxl_features_state {
> +	struct fwctl_device fwctl;
>  	struct cxl_memdev *cxlmd;
>  	enum cxl_features_capability cap;
>  	int num_features;
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index f9b27fb5c161..4e4d30104667 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -43,6 +43,7 @@ enum {
>  enum fwctl_device_type {
>  	FWCTL_DEVICE_TYPE_ERROR = 0,
>  	FWCTL_DEVICE_TYPE_MLX5 = 1,
> +	FWCTL_DEVICE_TYPE_CXL = 2,
>  };
>  
>  /**
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 6b0a992af4a7..6396d1296cef 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -47,6 +47,7 @@ cxl_port-y += cxl_port_test.o
>  obj-m += cxl_mem.o
>  
>  cxl_mem-y := $(CXL_SRC)/mem.o $(CXL_SRC)/features.o
> +cxl_mem-$(CONFIG_CXL_FWCTL) += $(CXL_SRC)/fwctl.o
>  cxl_mem-y += config_check.o
>  cxl_mem-y += cxl_mem_test.o
>  

