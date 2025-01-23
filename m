Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E882114D6F6
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653097; cv=none; b=b+id/FyQkY7kWAiMXlxpW92hqdGQa71tjuzMap9WUwBj09kejIahvCRWN+oi7A0jitsISyf6T35lt/Vn3s4dM7uBZOpBaubJc6WXaO+SXOEOrC5rSTja9QCOTQPGM1f9i+RMI6L+qnNNWhcz9qg/WgGcXpQ5PTVpFprEuQvT+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653097; c=relaxed/simple;
	bh=5UtYosM4vslbR0EVHUocL0MtwLvxIpujbD35KU9aVQY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AI3KXfdpcsYVczc3VKfw/W4NF+Ys36PXXw2QxyXbEJTpecNdGswgiXXLUmJ8wIdaAwTfntl1YnHqzgJ9MH15jPjgf6DkmCqxH+1o9T2MqpsfcEPnsNkXubvX+WyAX+zEcvIhivNZdJl+H/9O+yklzolChNzjtwOQ+J70KSE/xEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf77N2zRPz6M4Mt;
	Fri, 24 Jan 2025 01:22:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C38A9140736;
	Fri, 24 Jan 2025 01:24:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 18:24:53 +0100
Date: Thu, 23 Jan 2025 17:24:51 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 02/19] cxl: Add skeletal features driver
Message-ID: <20250123172451.0000103f@huawei.com>
In-Reply-To: <20250122235159.2716036-3-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-3-dave.jiang@intel.com>
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

On Wed, 22 Jan 2025 16:50:33 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add the basic bits of a features driver to handle all CXL feature related
> services. The driver is expected to handle all CXL mailbox feature command
> related operations.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
I've tried not to duplicate Dan's feedback but might well
have done in places.

I have more or less completely forgotten earlier discussions
so may well repeat comments long addressed.

Jonathan


> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> new file mode 100644
> index 000000000000..eb6eb191a32e
> --- /dev/null
> +++ b/drivers/cxl/core/features.c
> @@ -0,0 +1,71 @@

> +struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
> +					struct device *parent)
> +{
> +	struct device *dev;
> +	int rc;
> +
> +	struct cxl_features *features __free(kfree) =
> +		kzalloc(sizeof(*features), GFP_KERNEL);
> +	if (!features)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rc = ida_alloc_max(&cxl_features_ida, CXL_FEATURE_MAX_DEVS - 1,
> +			   GFP_KERNEL);
> +	if (rc < 0)
> +		return ERR_PTR(rc);
> +
> +	features->id = rc;
> +	features->cxl_mbox = cxl_mbox;
> +	dev = &features->dev;
> +	device_initialize(dev);
> +	device_set_pm_not_required(dev);
> +	dev->parent = parent;
> +	dev->bus = &cxl_bus_type;
> +	dev->type = &cxl_features_type;
> +	rc = dev_set_name(dev, "features%d", features->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	rc = devm_add_action_or_reset(parent, remove_features_dev, dev);
> +	if (rc)
		return rc;

If this fails the or_reset() means it has called device_unregister()
so put_device() should not be needed I think (though I may have missed
a reference counter increase somewhere).

On top of the release freeing features that Dan called out.


> +		goto err;
> +
> +	return no_free_ptr(features);
> +
> +err:
> +	put_device(dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_features_alloc, "CXL");

> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> new file mode 100644
> index 000000000000..644add26975f
> --- /dev/null
> +++ b/drivers/cxl/features.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024,2025 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <cxl/features.h>
> +
> +#include "cxl.h"
> +
> +static int cxl_features_probe(struct device *dev)
> +{
> +	struct cxl_features *features = to_cxl_features(dev);
> +	struct cxl_features_state *cfs __free(kfree) =
> +		kzalloc(sizeof(*cfs), GFP_KERNEL);

Maybe devm_ and no need for the scoped free handling
or for now the remove function?


> +
> +	if (!cfs)
> +		return -ENOMEM;
> +
> +	cfs->features = features;
> +	dev_set_drvdata(dev, no_free_ptr(cfs));
> +
> +	return 0;
> +}
> +
> +static void cxl_features_remove(struct device *dev)
> +{
> +	struct cxl_features_state *cfs = dev_get_drvdata(dev);
> +
> +	kfree(cfs);
> +}
> +
> +static struct cxl_driver cxl_features_driver = {
> +	.name = "cxl_features",
> +	.probe = cxl_features_probe,
> +	.remove = cxl_features_remove,
> +	.id = CXL_DEVICE_FEATURES,
> +};
> +
> +module_cxl_driver(cxl_features_driver);
> +
> +MODULE_DESCRIPTION("CXL: Features");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("CXL");
> +MODULE_ALIAS_CXL(CXL_DEVICE_FEATURES);

> diff --git a/include/cxl/features.h b/include/cxl/features.h
> new file mode 100644
> index 000000000000..b92da1e92780
> --- /dev/null
> +++ b/include/cxl/features.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2024-2025 Intel Corporation. */
> +#ifndef __CXL_FEATURES_H__
> +#define __CXL_FEATURES_H__

#include <linux/device.h> for struct device definition.

> +
> +struct cxl_mailbox;
> +
> +struct cxl_features {
> +	int id;
> +	struct device dev;

Trivial thing but I'd put the device first as we tend
to end up with maths like to_cxl_features() that can be simpler
if it is there.


> +	struct cxl_mailbox *cxl_mbox;
> +};
> +#define to_cxl_features(dev) container_of(dev, struct cxl_features, dev)
> +
> +struct cxl_features_state {
> +	struct cxl_features *features;
> +	int num_features;
> +};
> +
> +struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
> +					struct device *parent);
> +
> +#endif
