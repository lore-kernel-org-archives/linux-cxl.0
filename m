Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9C911C83
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jul 2024 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014923; cv=none; b=DIq5satRnp3pzzCZHhnXgHXqsHvIJrzIx9Wu9htj4QSJiZ7uXpBipZOMzQ2Et6sdIUw5NwQhLXsxIf3g7ybID97wKVR0pnS+3By8liQRAEXPEOjmyXmSel8OL02ZlXfwbjfVDktFoPAgqk9uGxI3uVvVoQ1Snm2WijPoKliGtLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014923; c=relaxed/simple;
	bh=1kdqDlV2WbqFutXV70Ds38/PJCNSa/9oqPpu2C7H/Cs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyBg1sAB57qj8bCsWD7IWvZbdWNcL0JWjpcVzKN/1lIJb7oOiSjUTlUTLFdoAr8lefo4ZLs7Ut2yi0n98O8kENH4PcosAYxnaZuOt3HfGmwKqJsyCwvcpgI7WeblIgomTFAlCD1hSPXYCs2M5NNO6WwCmXYmuy0EWsrA/PaZLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVvmr3bzDz6K6Ct;
	Sat, 27 Jul 2024 01:26:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B24B140517;
	Sat, 27 Jul 2024 01:28:37 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 18:28:37 +0100
Date: Fri, 26 Jul 2024 18:28:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH 01/13] cxl: Move mailbox related bits to the same
 context
Message-ID: <20240726182836.000026c4@Huawei.com>
In-Reply-To: <20240718213446.1750135-2-dave.jiang@intel.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
	<20240718213446.1750135-2-dave.jiang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 18 Jul 2024 14:32:19 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
> it. This allows isolation of all CXL mailbox data in order to export
> some of the calls to external caller (fwctl) and avoid exporting of
> CXL driver specific bits such has device states.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Some minor comments inline.

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..783cb5ed823f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c



> @@ -1411,6 +1424,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  {
>  	struct cxl_memdev_state *mds;
> +	struct cxl_mailbox *cxl_mbox;
>  
>  	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>  	if (!mds) {
> @@ -1418,7 +1432,9 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> -	mutex_init(&mds->mbox_mutex);
> +	cxl_mbox = &mds->cxlds.cxl_mbox;
> +	mutex_init(&cxl_mbox->mbox_mutex);

Probably factor out a cxl_mbox_init()
Maybe you do that in later patches...


>  	/*
>  	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
> @@ -315,10 +320,10 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>  
>  		timeout = mbox_cmd->poll_interval_ms;
>  		for (i = 0; i < mbox_cmd->poll_count; i++) {
> -			if (rcuwait_wait_event_timeout(&mds->mbox_wait,
> -				       cxl_mbox_background_complete(cxlds),
> -				       TASK_UNINTERRUPTIBLE,
> -				       msecs_to_jiffies(timeout)) > 0)
> +			if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
> +						       cxl_mbox_background_complete(cxlds),
> +						       TASK_UNINTERRUPTIBLE,
> +						       msecs_to_jiffies(timeout)) > 0)
Keep original indent - will reduce diff.



> diff --git a/include/linux/cxl/mailbox.h b/include/linux/cxl/mailbox.h
> new file mode 100644
> index 000000000000..654df6175828
> --- /dev/null
> +++ b/include/linux/cxl/mailbox.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2024 Intel Corporation. */
> +#ifndef __CXL_MBOX_H__
> +#define __CXL_MBOX_H__
> +
> +#include <linux/auxiliary_bus.h>

> +/**
> + * struct cxl_mailbox - context for CXL mailbox operations
> + * @host: device that hosts the mailbox
> + * @adev: auxiliary device for fw-ctl
> + * @payload_size: Size of space for payload
> + *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
> + * @mbox_mutex: mutex protects device mailbox and firmware
> + * @mbox_wait: rcuwait for mailbox
> + * @mbox_send: @dev specific transport for transmitting mailbox commands
> + */
> +struct cxl_mailbox {
> +	struct device *host;
> +	struct auxiliary_device adev; /* For fw-ctl */
I'm not sure the embedding makes sense here.
Also not used yet, so don't do it in this patch.


> +	size_t payload_size;
> +	struct mutex mbox_mutex; /* lock to protect mailbox context */
Maybe drop the mbox_prefix on this.
> +	struct rcuwait mbox_wait;
and this
> +	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
and this
as now they are inside struct cxl_mailbox the mbox bit is pretty obvious
and we all love shorter line lengths.



> +};
> +
> +#endif



