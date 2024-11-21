Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558BC19E97E
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212723; cv=none; b=hnjxhrkTkI6FhQRpVYfYFIgcDpUcEGIeq4TI0Yy0uBIku+V9aJcW1yzIzEAyNwcFsRYyByZbwIWdexGTa71EftgIXww+nLP2dSD/C1F86m6zGkrud9IaY/XCWW9d1hDGX3uOC5besKR/oalGuwPoX82rW7zkUWWz7IM9a3XDanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212723; c=relaxed/simple;
	bh=nzhQVDt2cmUjtwZj0CB6zkDgdr2BpBZPEzNLIr65C/Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVQdLqIFui1Nm15wa89nsAXZL2PPbCvlrexhjg21nOwiRVwjgTMBV9zvMRjxQAEvSv9E4sf09ZTQPvRHpe2CrGeZKqUNb/mcqOo5E7IewiphljwENpe1oHTA/NZlKli95VPvofya6nXx46ZLw+w4k6+QeNa1UHMO7ve9CsjZpdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvRBZ4k9yz6LD5D;
	Fri, 22 Nov 2024 02:11:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 00ADB140157;
	Fri, 22 Nov 2024 02:11:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 19:11:58 +0100
Date: Thu, 21 Nov 2024 18:11:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 10/20] fwctl/cxl: Add support for get driver
 information
Message-ID: <20241121181157.00006eee@huawei.com>
In-Reply-To: <20241115212745.869552-11-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-11-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Nov 2024 14:25:43 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add definition for fwctl_ops->info() to return driver information. The
> function will return the number of device mailbox commands supported by the
> fwctl char device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Few minor things inline

Jonathan
> ---
> v2:
> - Change driver info to report number of commands supported by the driver and device.
> ---
>  drivers/cxl/core/mbox.c  | 46 ++++++++++++++++++++++++++++++++++++++++
>  drivers/fwctl/cxl/cxl.c  | 23 ++++++++++++++++++--
>  include/cxl/cxl.h        |  2 ++
>  include/cxl/mailbox.h    |  1 +
>  include/uapi/fwctl/cxl.h | 22 +++++++++++++++++++
>  5 files changed, 92 insertions(+), 2 deletions(-)
>  create mode 100644 include/uapi/fwctl/cxl.h
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 12758e763650..f464eb42f08a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -118,6 +118,14 @@ static u8 security_command_sets[] = {
>  	0x46, /* Security Passthrough */
>  };
>  
> +#define FWCTL_CXL_MAX_COMMANDS 3

Use this to size the array? Will let us know if it gets
out of sync.

> +/* Command set that is allowed with FWCTL-CXL */
> +static u16 fwctl_command_sets[] = {
> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> +	CXL_MBOX_OP_GET_FEATURE,
> +	CXL_MBOX_OP_SET_FEATURE,
> +};
> +

>  static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 6bfd7942a3f7..d0939e3bcbc0 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -3,6 +3,8 @@
>  #ifndef __CXL_GLOBAL_H__
>  #define __CXL_GLOBAL_H__
>  
> +#include <linux/device.h>

Why in this patch?

> +
>  struct cxl_driver {
>  	const char *name;
>  	int (*probe)(struct device *dev);

