Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F45D8E4
	for <linux-cxl@vger.kernel.org>; Fri, 17 May 2024 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956430; cv=none; b=B4iTD2JBSo4AWoFAh1zZGF5G+ohKT6M/GyIckg7n6JOQaDlTOZYern+Whqo0CXCu2jL4vFeGZgbJTzazN+19po8WnYEMVZ+T33D8GF61BWes8mCnTpgWKjJagSsvM4LkRAKgvlxY46GnoyOKw4pjCRBcSLqAvYpM8++3+Asr/nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956430; c=relaxed/simple;
	bh=98j9NZjrfdN288mtFpMrVZUb+cjQtxrEHE/Xm1Ubv6Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acHdtpnFfrhZBIbuHw281TN8rYYnegybTJwNYAoP3vG4zjYp6fr79AzXmIpFISbCXQVxZbfrlPyDKf3oZJaIclqcwS1K4MDBaSDR1gDoaMTf38mbAx8+YVoTR3qh8bxY85BM66d60iwD+sYrM1AM5Cf1oRwBzvV72R8qAaiJYo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vgq9s6RVFz6F94h;
	Fri, 17 May 2024 22:30:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 11C16140B39;
	Fri, 17 May 2024 22:33:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 May
 2024 15:33:44 +0100
Date: Fri, 17 May 2024 15:33:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alucerop@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
Subject: Re: [RFC PATCH 04/13] cxl: allow devices without mailbox capability
Message-ID: <20240517153343.000066e6@Huawei.com>
In-Reply-To: <20240516081202.27023-5-alucerop@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
	<20240516081202.27023-5-alucerop@amd.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 16 May 2024 09:11:53 +0100
<alucerop@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> A device not implementing the CXL memory-device class code, aka Type2
> devices, has mailbox capability as optional. If the device registers
> mapping does not show such capability, do not treat that as an error.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
If you are removing this check from the shared code, it needs to be
in the more specific code, or you need to state why that isn't
a problem (i.e. it is caught later anyway)

Jonathan

> ---
>  drivers/cxl/core/regs.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index fd165e718cf2..5434a7c899fd 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -437,11 +437,10 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
>  		cxl_probe_device_regs(host, base, dev_map);
> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> +		if (!dev_map->status.valid ||
>  		    !dev_map->memdev.valid) {
> -			dev_err(host, "registers not found: %s%s%s\n",
> +			dev_err(host, "registers not found: %s%s\n",
>  				!dev_map->status.valid ? "status " : "",
> -				!dev_map->mbox.valid ? "mbox " : "",
>  				!dev_map->memdev.valid ? "memdev " : "");
>  			return -ENXIO;
>  		}

