Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E591E884
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655758; cv=none; b=UXviaz617MDlxKNWhSyUmH105IDu+1hNZaQ1EDoZw6FVfGTgFg0t06I3bQmv0yp31nGNmMiKE9YvqunQqE52W2RgwNgOSfmkjPoRqGe+jUD6MHU5YUxVXnPlvB4aGoACrNvpNvPO9xNEZxiWBF/o9XSeUUR2voH19OjCPpxdZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655758; c=relaxed/simple;
	bh=f2OnCacBxhf2CeGS+YpVrCDSH/fECW68uHacAuXr7NA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soyyJRip7+ZxCuk0f7Ddz39Pwigk5riGASxzRQ84/kGR+G/0dXWqDLT66LO+IAQA+F9QLfLiWMsajQND/N6/xUtzU3nUZYf3kn84djy6hmcU2X0WQtfDutgPcPikODfn+J57UItBI5CJtp2s/bpOiKWoINAUiK/ggB7wKHtGMy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf88Q67wwz6K5bx;
	Fri, 24 Jan 2025 02:08:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 32F981400C8;
	Fri, 24 Jan 2025 02:09:14 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 19:09:13 +0100
Date: Thu, 23 Jan 2025 18:09:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 11/19] cxl: Add support for get driver information
Message-ID: <20250123180912.00001cbb@huawei.com>
In-Reply-To: <20250122235159.2716036-12-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-12-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 16:50:42 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add definition for fwctl_ops->info() to return driver information. The
> function will return a mask of the feature mailbox commands supported
> by the fwctl char device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

One follow through style thing otherwise lgtm
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
> new file mode 100644
> index 000000000000..79b822dbfafd
> --- /dev/null
> +++ b/include/uapi/fwctl/cxl.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2024, Intel Corporation
> + *
> + * These are definitions for the mailbox command interface of CXL subsystem.
> + */
> +#ifndef _UAPI_FWCTL_CXL_H_
> +#define _UAPI_FWCTL_CXL_H_
> +
> +#include <linux/types.h>
> +
> +enum feature_cmds {
> +	CXL_FEATURE_ID_GET_SUPPORTED_FEATURES = 0,
> +	CXL_FEATURE_ID_GET_FEATURE,
> +	CXL_FEATURE_ID_SET_FEATURE,
> +	CXL_FEATURE_ID_MAX,

No trailing comma on this terminating item.

> +};
> +
> +/**
> + * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
> + * @cmd_mask: Mask indicate which commands are supported based on 'enum feature_cmds'
> + *
> + * Return basic information about the FW interface available.
> + *
> + * nr_commands is number of hardware commands the driver supports. Use
> + * FWCTL_CMD_HW_INFO ioctl to request additional information.
> + */
> +struct fwctl_info_cxl {
> +	__u32 cmd_mask;
> +};
> +#endif

