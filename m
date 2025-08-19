Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6A11798F
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618821; cv=none; b=MTP3G0D/pJk5kZnSHmkHbIfP0dZh8R/9wAxhyRxZIZEWg+1PkgetgSPaqBeYAnfP5mxojMV/1J1+HOPuV7RYwHpRlXWO8jLQAP1W1YpFvBn5/bAf9u477xeJ5FDD0hYeJLXcc+vTIvGgVfe7IVASq5MsMywYU00f/E/zPVeAlZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618821; c=relaxed/simple;
	bh=RrQSx0qtutjIDXEdamxbcVCu0JuUByZUqmQiZQnXOAI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgatakVFq8v1++3hmhhj8tZKIDLQiKf8pEUMgTPAeMS06auko2ezMIZJdMJQZSWl4Gu8DMsfbRoHbUiQ+EVkwXtxDTzKS/ZgTQZqGYUYR7GTLOVGdktb94Pud1Qsw6aSkDdFab05zJtu7HtMqUFylkTDaE+rdOgBul1ZhsguPSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5vDl0tk7z6GCDf;
	Tue, 19 Aug 2025 23:50:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9056B14020C;
	Tue, 19 Aug 2025 23:53:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 17:53:31 +0200
Date: Tue, 19 Aug 2025 16:53:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 18/18] cxl/core: Add cache device cache management
 attributes
Message-ID: <20250819165329.000022f7@huawei.com>
In-Reply-To: <20250812212921.9548-19-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<20250812212921.9548-19-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Aug 2025 16:29:21 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add functions to cxl/core/pci.c to manage the cache of a CXL.cache
> enabled endpoint. Add these new functions to sysfs attributes for
> userspace accessibility.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Documentation/ABI needs something on this.

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

Can return 1 which is unlikely to be what want.

> +
> +	return n;
> +}

> +
> +static struct attribute *cxl_cachedev_mgmt_attributes[] = {
> +	&dev_attr_cache_disable.attr,
> +	&dev_attr_cache_invalid.attr,
> +	&dev_attr_init_wbinvd.attr,
> +	NULL,

No comma.

> +};


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
No comma

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
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int dvsec, rc;
> +	u16 ctrl2;
> +
> +	device_lock_assert(cxlds->dev);
What took this and why do we need to check?
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

Maybe FIELD_GET() is cleaner than the !!

> +		return 1;
> +
> +	ctrl2 &= ~CXL_DVSEC_DISABLE_CACHING;
> +	ctrl2 |= FIELD_PREP(CXL_DVSEC_DISABLE_CACHING, disable);
> +	return pci_write_config_word(pdev, dvsec + CXL_DVSEC_DISABLE_CACHING,
> +				     ctrl2);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_cache_disable, "CXL");

