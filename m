Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188C214806
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072573; cv=none; b=mzXPwymyUETDN2e+FUIA3q205kX/Hz4EwKNtga7vcVFDCMO5+ecBFTSN81CcFa9r3bICaxaeh3qFKbin3YfuwwiQLs2mPOfb794t+axItdQIoMV4Av2lUUeyDzp4z5fptNFALFkI78AcjSwk7fOP5os8ftsOV1vxeBXWf7tnCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072573; c=relaxed/simple;
	bh=wAgrsNrANLY4hTapFAYgvQ8AlrdUx9xGaX7VENshF1c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGOC5ZjQrVAm9Qh+sOClFC5F32upjgAygCrhPG4llAmQxZARIU/QG0VySR5rl2I1GkeZ8+B0dzjPVZHSjb8Oo0EbYpnSxZPODHmFmT74pWeE+6OkHrsbb0EL/afl3yTjJVfvGu/xyMqElQ0NvOrz5ok9cXMdYKIvj6/ToseSogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzKw432W9z6HJfl;
	Fri, 21 Feb 2025 01:27:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6ECC41404F5;
	Fri, 21 Feb 2025 01:29:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Feb
 2025 18:29:26 +0100
Date: Thu, 20 Feb 2025 17:29:25 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>, <ming.li@zohomail.com>,
	<a.manzanares@samsung.com>, <fan.ni@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/4] cxl/pmem: Export dirty shutdown count via sysfs
Message-ID: <20250220172925.000044f2@huawei.com>
In-Reply-To: <20250220013604.263489-4-dave@stgolabs.net>
References: <20250220013604.263489-1-dave@stgolabs.net>
	<20250220013604.263489-4-dave@stgolabs.net>
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

On Wed, 19 Feb 2025 17:36:03 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Similar to how the acpi_nfit driver exports Optane dirty shutdown count,
> introduce:
> 
>   /sys/bus/cxl/devices/nvdimm-bridge0/ndbusX/nmemY/cxl/dirty_shutdown
> 
> Under the conditions that 1) dirty shutdown can be set, 2) Device GPF
> DVSEC exists, and 3) the count itself can be retrieved.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
One trivial thing otherwise
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 6b284962592f..cb039cfc62cb 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -38,19 +38,48 @@ static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_dev_state *cxlds = cxl_nvd->cxlmd->cxlds;
>  
> -	return sysfs_emit(buf, "%lld\n", cxlds->serial);
> +	return sysfs_emit(buf, "%llu\n", cxlds->serial);

I guess you 'fixed' the wrong one?

>  }
>  static DEVICE_ATTR_RO(id);
>  
> +static ssize_t dirty_shutdown_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct nvdimm *nvdimm = to_nvdimm(dev);
> +	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
> +
> +	return sysfs_emit(buf, "%lld\n", cxl_nvd->dirty_shutdowns);

It's unsigned so %llu though I hope no one ever tests that by
doing that many dirty shutdowns.

> +}
> +static DEVICE_ATTR_RO(dirty_shutdown);


