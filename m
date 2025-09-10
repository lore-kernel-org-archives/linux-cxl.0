Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF18287255
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545371; cv=none; b=hpnMUw9W36nbTaBQXuzL2F3rn2xmpYZA4GhepAjDEpXiMDZSw88w4282CriGW1K+HAMeib+NQZ5ztYX57xQdcLRxf0Q12W4lr10R6RMZ1/oD8aFfjf7ECte9QleSxRCOpZjE4onHTQf5rvTwCbwTkl5O/R3xqL/37PGmVCVOtKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545371; c=relaxed/simple;
	bh=w4vxswVQoQpp16mAyaQ99G9fkm2bDL9zpORHW6S12pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KbGDSaJDsHO/2mrdZEkhUMAzJYvHu9q3iEckELXwiMd65SlhMrUQADOQFZ+FwOHbAWu5HS72m2GaIXpWi0rScOu/YN3DPm3ybSsqn79DqYvO3XOdWQ93+P94rI/wugEmvAxOlf38cMX6VR7izBrh9pBeizpGevo1BkrUiO4IO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJS8Q4HG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJS8Q4HG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757545369; x=1789081369;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=w4vxswVQoQpp16mAyaQ99G9fkm2bDL9zpORHW6S12pQ=;
  b=VJS8Q4HGOemwQKxuBmFLTDVmx4wC6uSrrwRAgB8/lc4j8vkkgXPBohhX
   KSjaVwSwKOWpSSCdiUDf9JlJfqd+KAEYXkPzW0TChO08ONz1HR0iAhWDU
   rxbwTeu3fXsXF2yDxtdqb9K+0IijZ/1Btwg83ky5CwHHXinLzCk5CdOsV
   YpMyBfav0G9XnhfOm8UxgC1lfnj8Py4ob3Zf0dnkFkiH2fk4CvyjDF4Rn
   dF03zVlbalyFJXmv2Pab6axXAgIivXVE3a8EBNLzBkIRuB1YSuQ8uHclP
   RYExWzqv9XgR0PJEm0A9XAdKQy0elcEPCBq3n3ZJpFG76vA22M+4apLYG
   A==;
X-CSE-ConnectionGUID: BOYWiph7RnS/Nm2OYw6kOw==
X-CSE-MsgGUID: 99l6MuXpTcSKHRknHAW8LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="70486918"
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="70486918"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 16:02:47 -0700
X-CSE-ConnectionGUID: knWuNQwyQrO1K4/TClXWXQ==
X-CSE-MsgGUID: H76Z4qf3ROCjaNu7HYSF+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="173902220"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.110.219]) ([10.125.110.219])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 16:02:47 -0700
Message-ID: <29b9953a-8367-4545-a783-dfabbfa488d7@intel.com>
Date: Wed, 10 Sep 2025 16:02:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 18/18] cxl/core: Add cache device cache management
 attributes
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, linux-cxl@vger.kernel.org
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-19-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250812212921.9548-19-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/25 2:29 PM, Ben Cheatham wrote:
> Add functions to cxl/core/pci.c to manage the cache of a CXL.cache
> enabled endpoint. Add these new functions to sysfs attributes for
> userspace accessibility.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/cxl/core/cachedev.c | 99 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/pci.c      | 89 +++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlcache.h      |  4 ++
>  drivers/cxl/cxlpci.h        |  6 +++
>  4 files changed, 198 insertions(+)
> 
> diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
> index 1cdd94520ceb..85989cdd1eb8 100644
> --- a/drivers/cxl/core/cachedev.c
> +++ b/drivers/cxl/core/cachedev.c
> @@ -5,6 +5,7 @@
>  #include <linux/pci.h>
>  
>  #include "../cxlcache.h"
> +#include "../cxlpci.h"
>  #include "private.h"
>  
>  static DEFINE_IDA(cxl_cachedev_ida);
> @@ -125,9 +126,107 @@ static struct attribute_group cxl_cachedev_cache_attribute_group = {
>  	.is_visible = cxl_cachedev_cache_visible,
>  };
>  
> +static ssize_t cache_disable_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t n)
> +{
> +	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
> +	struct cxl_dev_state *cxlds = cxlcd->cxlds;
> +	bool disable;
> +	int rc;
> +
> +	rc = kstrtobool(buf, &disable);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_accel_set_cache_disable(cxlds, disable);
> +	if (rc)
> +		return rc;
> +
> +	return n;
> +}
> +
> +static ssize_t cache_disable_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
> +	struct cxl_dev_state *cxlds = cxlcd->cxlds;
> +	int rc;
> +
> +	rc = cxl_accel_caching_disabled(cxlds);
> +	if (rc < 0)
> +		return rc;
> +
> +	return sysfs_emit(buf, "%d\n", rc);
> +}
> +static DEVICE_ATTR_RW(cache_disable);
> +
> +static ssize_t cache_invalid_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
> +	struct cxl_dev_state *cxlds = cxlcd->cxlds;
> +	int rc;
> +
> +	rc = cxl_accel_cache_invalid(cxlds);
> +	if (rc < 0)
> +		return rc;
> +
> +	return sysfs_emit(buf, "%d\n", rc);
> +}
> +static DEVICE_ATTR_RO(cache_invalid);
> +
> +static ssize_t init_wbinvd_store(struct device *dev,
> +				 struct device_attribute *attr, const char *buf,
> +				 size_t n)
> +{
> +	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
> +	struct cxl_dev_state *cxlds = cxlcd->cxlds;
> +	int rc;
> +
> +	rc = cxl_accel_initiate_wbinvd(cxlds);
> +	return rc ? rc : n;
> +}
> +static DEVICE_ATTR_WO(init_wbinvd);
> +
> +static struct attribute *cxl_cachedev_mgmt_attributes[] = {
> +	&dev_attr_cache_disable.attr,
> +	&dev_attr_cache_invalid.attr,
> +	&dev_attr_init_wbinvd.attr,
> +	NULL,
> +};
> +
> +static umode_t cxl_cachedev_mgmt_visible(struct kobject *kobj,
> +					 struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
> +	struct cxl_dev_state *cxlds = cxlcd->cxlds;
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	u16 cap;
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, cxlds->cxl_dvsec + CXL_DVSEC_CAP_OFFSET,
> +				  &cap);
> +	if (rc)
> +		return 0;
> +
> +	if (!(cap & CXL_DVSEC_WBINVD_CAPABLE) &&
> +	    a == &dev_attr_init_wbinvd.attr)
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +static struct attribute_group cxl_cachedev_mgmt_attribute_group = {
> +	.attrs = cxl_cachedev_mgmt_attributes,
> +	.is_visible = cxl_cachedev_mgmt_visible,
> +};
> +
>  static const struct attribute_group *cxl_cachedev_attribute_groups[] = {
>  	&cxl_cachedev_attribute_group,
>  	&cxl_cachedev_cache_attribute_group,
> +	&cxl_cachedev_mgmt_attribute_group,
>  	NULL,
>  };
>  
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 2279c2690c59..667f75043f9e 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1232,3 +1232,92 @@ int cxl_accel_get_cache_info(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_accel_get_cache_info, "CXL");
> +
> +int cxl_accel_caching_disabled(struct cxl_dev_state *cxlds)

why not just return bool?

> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int dvsec, rc;
> +	u16 ctrl2;
> +
> +	device_lock_assert(cxlds->dev);
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return -EINVAL;
> +	pdev = to_pci_dev(cxlds->dev);
> +
> +	dvsec = cxlds->cxl_dvsec;
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	return !!(ctrl2 & CXL_DVSEC_DISABLE_CACHING);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_caching_disabled, "CXL");
> +
> +int cxl_accel_set_cache_disable(struct cxl_dev_state *cxlds, bool disable)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int dvsec, rc;
> +	u16 ctrl2;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return -EINVAL;
> +
> +	guard(device)(cxlds->dev);
> +	dvsec = cxlds->cxl_dvsec;
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	if (!!(ctrl2 & CXL_DVSEC_DISABLE_CACHING) == disable)
> +		return 1;
> +
> +	ctrl2 &= ~CXL_DVSEC_DISABLE_CACHING;
> +	ctrl2 |= FIELD_PREP(CXL_DVSEC_DISABLE_CACHING, disable);
> +	return pci_write_config_word(pdev, dvsec + CXL_DVSEC_DISABLE_CACHING,
> +				     ctrl2);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_cache_disable, "CXL");
> +
> +int cxl_accel_initiate_wbinvd(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int dvsec, rc;
> +	u16 ctrl2;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return -EINVAL;
> +
> +	if (cxl_accel_caching_disabled(cxlds) != 1)
> +		return -EBUSY;
> +
> +	guard(device)(cxlds->dev);
> +	dvsec = cxlds->cxl_dvsec;
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	ctrl2 |= CXL_DVSEC_INIT_WBINVD;
> +	return pci_write_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
> +				     ctrl2);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_initiate_wbinvd, "CXL");
> +
> +int cxl_accel_cache_invalid(struct cxl_dev_state *cxlds)

return bool?

DJ

> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int dvsec, rc;
> +	u16 stat2;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return -EINVAL;
> +
> +	guard(device)(cxlds->dev);
> +	dvsec = cxlds->cxl_dvsec;
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_STAT2_OFFSET, &stat2);
> +	if (rc)
> +		return rc;
> +
> +	return !!(stat2 & CXL_DVSEC_CACHE_INVALID);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_cache_invalid, "CXL");
> diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
> index 60563b391844..14e6f543ade9 100644
> --- a/drivers/cxl/cxlcache.h
> +++ b/drivers/cxl/cxlcache.h
> @@ -35,4 +35,8 @@ int devm_cxl_port_program_cache_idrt(struct cxl_port *port,
>  int cxl_dport_program_cache_idd(struct cxl_dport *dport,
>  				struct cxl_cachedev *cxlcd);
>  
> +int cxl_accel_set_cache_disable(struct cxl_dev_state *cxlds, bool disable);
> +int cxl_accel_caching_disabled(struct cxl_dev_state *cxlds);
> +int cxl_accel_cache_invalid(struct cxl_dev_state *cxlds);
> +int cxl_accel_initiate_wbinvd(struct cxl_dev_state *cxlds);
>  #endif
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index e5dd132be7e7..dc0800d79cf6 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -20,8 +20,14 @@
>  #define     CXL_DVSEC_CACHE_CAPABLE	BIT(0)
>  #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>  #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> +#define     CXL_DVSEC_WBINVD_CAPABLE	BIT(6)
>  #define   CXL_DVSEC_CTRL_OFFSET		0xC
>  #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> +#define   CXL_DVSEC_CTRL2_OFFSET	0x10
> +#define     CXL_DVSEC_DISABLE_CACHING	BIT(0)
> +#define     CXL_DVSEC_INIT_WBINVD	BIT(1)
> +#define   CXL_DVSEC_STAT2_OFFSET	0x12
> +#define     CXL_DVSEC_CACHE_INVALID	BIT(0)
>  #define   CXL_DVSEC_CAP2_OFFSET		0x16
>  #define     CXL_DVSEC_CACHE_UNIT_MASK	GENMASK(3, 0)
>  #define     CXL_DVSEC_CACHE_SIZE_MASK	GENMASK(15, 8)

