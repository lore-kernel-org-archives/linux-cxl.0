Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85423288B1
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586614; cv=none; b=HTgvJGhc7a+1ySTZESRC4LMHYk2aHvRNLpVNcRnyJJQq7zuwowiOXU0wpovafiLayClQpjaP5dCQSC8UhRqOHGgTgZyL16laG1+/opn9SHGlP9yoMbr5tUxUyyKVOG9fIkXH+6Ukf0TKBza7VOWKFXhLbFSDtDnDjwXm2U23qoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586614; c=relaxed/simple;
	bh=qSktLisbP+5F0s8c4c/vv5c6COUTfPYcXwaZrRrCOUo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/9H9AeSsfksrjqBCgUe7kQyYHT5C57rftoIUkEzgQrbi1+SBRKxGDfGpi6xg1OKMljo2Up553BW9bFBdN4l+ksJq7JmxWe0rAVnMBrnrDMMDY3Igfce3Iv9UdIFPKc5sdi3NghJol+NbEca6b7j43DhWfX9JYbRXGlf+FfkSws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YmmNv63x2z6K8n5;
	Mon,  3 Feb 2025 20:42:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F3F71400CA;
	Mon,  3 Feb 2025 20:43:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 13:43:29 +0100
Date: Mon, 3 Feb 2025 12:43:28 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v2 09/16] cxl: Add support for FWCTL get driver
 information callback
Message-ID: <20250203124328.0000494a@huawei.com>
In-Reply-To: <20250201004459.466499-10-dave.jiang@intel.com>
References: <20250201004459.466499-1-dave.jiang@intel.com>
	<20250201004459.466499-10-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 31 Jan 2025 17:42:02 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add definition for fwctl_ops->info() to return driver information. The
> function will return a data structure with a reserved u32. This is setup
> for future usages.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

> diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
> new file mode 100644
> index 000000000000..4e766ffb1388
> --- /dev/null
> +++ b/include/uapi/fwctl/cxl.h
> @@ -0,0 +1,19 @@
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
> +/**
> + * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
> + * @reserved: Place older for future usages
holder.  Freudian slip?
 :)
> + */
> +struct fwctl_info_cxl {
> +	__u32 reserved;
> +};
> +#endif

