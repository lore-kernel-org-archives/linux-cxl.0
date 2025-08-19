Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89783314B4
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604095; cv=none; b=V3CyU90LglFvC1D8DJrj1mzYtVNZXioUxgNxq2qo/IBHRc4cM/yoleRUQ+HMsaQDB6YyJoIuD2L9j6UOx4xxPlvfwtXGuHBlSS5EejhkzMyGsViK6Poc/LSG32c1Le7FMqI5M2PMROaGdLOoa/+molqfh0GHzlGfTPReJvO+hF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604095; c=relaxed/simple;
	bh=/rjkaVAWeOaE1GtKQudYOfhx4mgmPiBaLL0CuhBiN28=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbeAhEFj+Sa2tzrKqUysCWedA4h+c9prdRZcjMl3lp57yIJRtfn2sxfcUxQTQfdcK7WvURq0omYDyuwGpU8cj9bu/7H+zQC5ZvkoqIb/W+aZF8yLawwkUlR2PgpZTWy1nFddSDi4rDqyGXlcEll6JI+rkYmQzYaIWDBltvXgg/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5nrv5s89z6D8vd;
	Tue, 19 Aug 2025 19:47:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0355114038F;
	Tue, 19 Aug 2025 19:48:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 13:48:09 +0200
Date: Tue, 19 Aug 2025 12:48:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 03/18] cxl/core: Add CXL.cache device struct
Message-ID: <20250819124808.0000670f@huawei.com>
In-Reply-To: <20250812212921.9548-4-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<20250812212921.9548-4-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Aug 2025 16:29:06 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add a new CXL.cache device (struct cxl_cachedev) that is the cache
> analogue to struct cxl_memdev. This device will be created by
> endpoint vendor-specific drivers to enable and manage the cache
> capabilities of the endpoint.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Whilst this creates the device it never adds which seems like an odd omission.
If that's intentional add some more text on why.

Jonathan

> diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
> new file mode 100644
> index 000000000000..aaf4a1b94178
> --- /dev/null
> +++ b/drivers/cxl/core/cachedev.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Advanced Micro Devices, Inc. */
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +
> +#include "../cxlcache.h"
> +#include "private.h"
> +
> +static DEFINE_IDA(cxl_cachedev_ida);
> +
> +static void cxl_cachedev_release(struct device *dev)
> +{
> +	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
> +
> +	ida_free(&cxl_cachedev_ida, cxlcd->id);
> +	kfree(cxlcd);
> +}
> +
> +static void cxl_cachedev_unregister(void *dev)
> +{
> +	struct cxl_cachedev *cxlcd = dev;
> +

It's not doing what we'd normally expect in an unregister
as no device_del()  Which is fair because it was never added below.

> +	cxlcd->cxlds = NULL;
> +	put_device(&cxlcd->dev);
> +}
> +

> +struct cxl_cachedev *devm_cxl_cachedev_add_or_reset(struct device *host,
> +						    struct cxl_cachedev *cxlcd)
> +{
> +	int rc;

Odd to not have a device_add() of any type in here.
Maybe introduced in later patches, but I think you need to drag that into
this one for it to make any real sense. 

> +
> +	rc = devm_add_action_or_reset(host, cxl_cachedev_unregister, cxlcd);
> +	if (rc)
> +		return ERR_PTR(rc);
I'd throw a blank line in here.

> +	return cxlcd;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_cachedev_add_or_reset, "CXL");


> diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
> new file mode 100644
> index 000000000000..3ccbeba9fcd6
> --- /dev/null
> +++ b/drivers/cxl/cxlcache.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __CXL_CACHE_H__
> +#define __CXL_CACHE_H__
> +#include <linux/pci.h>
> +
> +#include "cxl.h"
> +

I'd add docs from the start.

> +struct cxl_cachedev {
> +	struct device dev;
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_port *endpoint;
> +	const struct cxl_dev_ops *ops;
> +	int id;
> +	int depth;
> +};
> +
> +static inline struct cxl_cachedev *to_cxl_cachedev(struct device *dev)
> +{
> +	return container_of(dev, struct cxl_cachedev, dev);
> +}
> +
> +bool is_cxl_cachedev(const struct device *dev);
> +#endif


