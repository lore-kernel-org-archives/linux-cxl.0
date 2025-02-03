Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F061FCF4F
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738584373; cv=none; b=SVX01IdaHq9hJ6jZsw4LL8KFo0wkUKmYwYWgyvnc9pNStxQOm0QHiuOrYreta9zK08G9x7y63BA5cKczy5VNHrpA+6XGFA4XVfioy5HVaURsPX29n8Oj4uAI0K9ATQa8zoqtky3TIXbEpQS8FZA5R1Kq9qfgk3BJ1f/yPnkv4tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738584373; c=relaxed/simple;
	bh=QrE5q3PFQOS+7QNU9xfi8IbmpOaMzogHFZAhcMmk5vA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FymnhtW6TC8i7/Q3P2RgkV8+TVCZGyK4ZycsBbzC4b+hb4VQoTA8Pklt55MUlzgl7u1wUVB8ZOra8rSGA8XFav7LcK2x5wk6n3SGRTS0ECewWn4COSZ8mi2XzIkqVybeFKp8pilwHBnK89SVQn6CdAej7cjeVzBNYfsnr3YzB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YmlWs1zmWz6L4yK;
	Mon,  3 Feb 2025 20:03:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 246101400CA;
	Mon,  3 Feb 2025 20:06:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 13:06:08 +0100
Date: Mon, 3 Feb 2025 12:06:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v2 02/16] cxl: Enumerate feature commands
Message-ID: <20250203120607.0000606a@huawei.com>
In-Reply-To: <20250201004459.466499-3-dave.jiang@intel.com>
References: <20250201004459.466499-1-dave.jiang@intel.com>
	<20250201004459.466499-3-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 31 Jan 2025 17:41:55 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add feature commands enumeration code in order to detect and enumerate
> the 3 feature related commands "get supported features", "get feature",
> and "set feature". The enumeration will help determine whether the driver
> can issue any of the 3 commands to the device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Setup allocation of cxlfs and move enumeration of commands to
>   the setup function.
> - Introduce features_capability enum. (Dan)
> - Name the setup function devm_cxl_add_features(). (Dan)
> - Drop 'cxl_mem_command' support. (Dan)
> - Move feature support to mem probe. (Dan)
> - Remove comma at last entry of data structs. (Jonathan)
Got carried away on this one.   Only drop them for termination
entries.  So MAX or NULL or similar.

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index bdb8f060f2c1..25fb7bd770b3 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -69,6 +69,29 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
>  };
>  
> +static u16 cxl_feature_commands[] = {
> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> +	CXL_MBOX_OP_GET_FEATURE,
> +	CXL_MBOX_OP_SET_FEATURE

This one does want a trailing comma. Might be more feature commands in future.

> +};

> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> new file mode 100644
> index 000000000000..13b0b29ee102
> --- /dev/null
> +++ b/drivers/cxl/features.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <cxl/mailbox.h>
> +#include <cxl/features.h>
> +#include "cxl.h"
> +#include "cxlmem.h"
> +#include "features.h"
> +
> +static void enumerate_feature_cmds(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
> +	struct cxl_features_state *cxlfs = cxlds->cxlmd->cxlfs;
Going in circles?
	cxlmd->cxlfs;


> +	int fid;
> +
> +	fid = cxl_get_feature_command_id(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
> +	if (!test_bit(fid, cxl_mbox->feature_cmds))
> +		return;
> +
> +	fid = cxl_get_feature_command_id(CXL_MBOX_OP_GET_FEATURE);
> +	if (!test_bit(fid, cxl_mbox->feature_cmds))
> +		return;
> +
> +	cxlfs->cap = CXL_FEATURES_RO;
> +
> +	fid = cxl_get_feature_command_id(CXL_MBOX_OP_SET_FEATURE);
> +	if (!test_bit(fid, cxl_mbox->feature_cmds))
> +		return;
> +
> +	cxlfs->cap = CXL_FEATURES_RW;
> +}
> +
> +/**
> + * devm_cxl_add_features() - Allocate and initialize features context
> + * @cxlmd: CXL memory device
> + *
> + * Return 0 on success or -errno on failure.
> + */
> +int devm_cxl_add_features(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_features_state *cxlfs;
> +	struct device *dev = &cxlmd->dev;
> +
> +	cxlfs = devm_kzalloc(dev, sizeof(*cxlfs), GFP_KERNEL);
> +	if (!cxlfs)
> +		return -ENOMEM;
> +
> +	cxlmd->cxlfs = cxlfs;

So I was curious about this one and why we leave the pointer
hanging in the remove path + whether the two way pointer nest
is needed.

That gets dealt with in patch 8.

I'd be tempted to drag the bones of dev_cxlfs_allocate() to this
patch so that you can do that cleanup now and avoid some of the churn
of the later patches.

As for the two way pointer nest. I'm not sure it is needed.
Seems like most if not all places we use cxlmd->cxlfs have
just gotten it in the caller from cxlfs->cxlmd.
e.g. cxl_cxlfs_free() in patch 8. For here we could
just pass it into enumerate_feature_cmds.

Maybe Shiju's set needs it. I haven't checked.




> +	cxlfs->cxlmd = cxlmd;
> +	enumerate_feature_cmds(cxlmd);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_features, "CXL");

> diff --git a/include/cxl/features.h b/include/cxl/features.h
> new file mode 100644
> index 000000000000..eadf0d56553f
> --- /dev/null
> +++ b/include/cxl/features.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2024-2025 Intel Corporation. */
> +#ifndef __CXL_FEATURES_H__
> +#define __CXL_FEATURES_H__
> +
> +struct cxl_mailbox;
> +
> +/* Index IDs for CXL mailbox Feature commands */
> +enum feature_cmds {
> +	CXL_FEATURE_ID_GET_SUPPORTED_FEATURES = 0,
> +	CXL_FEATURE_ID_GET_FEATURE,
> +	CXL_FEATURE_ID_SET_FEATURE,
> +	CXL_FEATURE_ID_MAX
> +};
> +
> +/* Feature commands capability supported by a device */
> +enum cxl_features_capability {
> +	CXL_FEATURES_NONE = 0,
> +	CXL_FEATURES_RO,
> +	CXL_FEATURES_RW

Trivial but this one should have a trailing comma.  Maybe
we'll have a write only one!  Anyhow, it's not a terminating
entry so we shouldn't assume nothing comes after it.

> +};
> +
> +/**
> + * struct cxl_features_state - The Features state for the device
> + * @cxlmd: Pointer to cxl mem device
> + * @cap: Feature commands capability
> + * @num_features: total Features supported by the device
> + */
> +struct cxl_features_state {
> +	struct cxl_memdev *cxlmd;
> +	enum cxl_features_capability cap;
> +	int num_features;
> +};
> +
> +#endif

