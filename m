Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296E219CCE5
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588640; cv=none; b=oqNqd5Yn+NCuySw2TJ9AYk1/NBgasFukgoojC5eXJ3+f1CxDNtWnpSGrr8R7SzNGH35IgZ/4TYj0mg8VVQgf37lW9OLv6kbOyep4Hy3KMKUvY+f4LgN3fKytqEkWTeczns2A2GStQszNpc2Cx1U+M5+T4Fs2djjovBYty5jKdWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588640; c=relaxed/simple;
	bh=qiVoYUD2ZE7jVr9tfLc/iVtpO33WJj5NuUdPWeOGORA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qY9jBuntH6STeDMGih/msuOAw9XxfIL0vSvLF8g+gqTYxO6eGNE/rCetuEkd/t3Zp48C87jralZ/7iBiuTIv+kCoEaVzp4Ikte9NF/tJAaoeGvS8LjHLEOUWuct1PYSsjpxNBDNNdB8FcxJ8Rg/OJU+Tr6O2SN1mOvClvHm1FqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvQnZ5VmVz6JBfd;
	Wed,  5 Jun 2024 19:52:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 136F71408F9;
	Wed,  5 Jun 2024 19:57:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 12:57:08 +0100
Date: Wed, 5 Jun 2024 12:57:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Li Ming <ming4.li@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/1] cxl/mem: Fix no cxl_nvd during pmem region
 auto-assembing
Message-ID: <20240605125707.000064f8@Huawei.com>
In-Reply-To: <20240531070229.1596811-1-ming4.li@intel.com>
References: <20240531070229.1596811-1-ming4.li@intel.com>
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

On Fri, 31 May 2024 15:02:29 +0800
Li Ming <ming4.li@intel.com> wrote:

> When CXL subsystem is auto-assembling a pmem region during cxl
> endpoint port probing, always output below calltrace.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000078
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  RIP: 0010:cxl_pmem_region_probe+0x22e/0x360 [cxl_pmem]
>  Call Trace:
>   <TASK>
>   ? __die+0x24/0x70
>   ? page_fault_oops+0x82/0x160
>   ? do_user_addr_fault+0x65/0x6b0
>   ? exc_page_fault+0x7d/0x170
>   ? asm_exc_page_fault+0x26/0x30
>   ? cxl_pmem_region_probe+0x22e/0x360 [cxl_pmem]
>   ? cxl_pmem_region_probe+0x1ac/0x360 [cxl_pmem]
>   cxl_bus_probe+0x1b/0x60 [cxl_core]
>   really_probe+0x173/0x410
>   ? __pfx___device_attach_driver+0x10/0x10
>   __driver_probe_device+0x80/0x170
>   driver_probe_device+0x1e/0x90
>   __device_attach_driver+0x90/0x120
>   bus_for_each_drv+0x84/0xe0
>   __device_attach+0xbc/0x1f0
>   bus_probe_device+0x90/0xa0
>   device_add+0x51c/0x710
>   devm_cxl_add_pmem_region+0x1b5/0x380 [cxl_core]
>   cxl_bus_probe+0x1b/0x60 [cxl_core]
> 
> Because the cxl_nvd of the memdev is necessary during pmem region
> probing, but the cxl_nvd can be registered only after endpoint port
> probing done, that is a collision dependency, so adjust the sequence
> between cxl_nvd registration and endpoint port registration to guarantee
> there is a cxl_nvd in memdev during the pmem region auto-assembling.

Perhaps call out that the root above a parent port is the same as the root
above the endpoint seeing as I think you are starting the search from
a different location after this change.

Other than that looks correct to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> 
> Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming4.li@intel.com>
> ---
>  drivers/cxl/core/pmem.c   | 15 ++++++++++-----
>  drivers/cxl/core/region.c |  2 +-
>  drivers/cxl/cxl.h         |  4 ++--
>  drivers/cxl/mem.c         | 17 +++++++++--------
>  4 files changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index e69625a8d6a1..31b398c13be9 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -62,10 +62,14 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
>  	return is_cxl_nvdimm_bridge(dev);
>  }
>  
> -struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
> +/**
> + * cxl_nvdimm_bridge() - find a bridge device relative to a port
> + * @port: any descendant port of an nvdimm-bridge associated
> + *        root-cxl-port
> + */
> +struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port)
>  {
> -	struct cxl_root *cxl_root __free(put_cxl_root) =
> -		find_cxl_root(cxlmd->endpoint);
> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);

This is a different port in the now earlier query (not the other path you update).
As you say any descendant is fine though.
I'd mention this subtle change in the patch description though.
(noted above)

>  	struct device *dev;
>  
>  	if (!cxl_root)
> @@ -242,18 +246,19 @@ static void cxlmd_release_nvdimm(void *_cxlmd)
>  
>  /**
>   * devm_cxl_add_nvdimm() - add a bridge between a cxl_memdev and an nvdimm
> + * @port: parent port for the (to be added) @cxlmd endpoint port

Would calling it parent_port make more sense?

>   * @cxlmd: cxl_memdev instance that will perform LIBNVDIMM operations
>   *
>   * Return: 0 on success negative error code on failure.
>   */
> -int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd)
> +int devm_cxl_add_nvdimm(struct cxl_port *port, struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_nvdimm *cxl_nvd;
>  	struct device *dev;
>  	int rc;
>  
> -	cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
> +	cxl_nvb = cxl_find_nvdimm_bridge(port);
>  	if (!cxl_nvb)
>  		return -ENODEV;
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3c2b6144be23..f0cafc7ffb45 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2847,7 +2847,7 @@ static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
>  		 * bridge for one device is the same for all.
>  		 */
>  		if (i == 0) {
> -			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
> +			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd->endpoint);
>  			if (!cxl_nvb)
>  				return -ENODEV;
>  			cxlr->cxl_nvb = cxl_nvb;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 603c0120cff8..e8fca6c6952b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -855,8 +855,8 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
>  struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
>  bool is_cxl_nvdimm(struct device *dev);
>  bool is_cxl_nvdimm_bridge(struct device *dev);
> -int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd);
> -struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd);
> +int devm_cxl_add_nvdimm(struct cxl_port *port, struct cxl_memdev *cxlmd);
> +struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_REGION
>  bool is_cxl_pmem_region(struct device *dev);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 0c79d9ce877c..2f1b49bfe162 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -152,6 +152,15 @@ static int cxl_mem_probe(struct device *dev)
>  		return -ENXIO;
>  	}
>  
> +	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> +		rc = devm_cxl_add_nvdimm(parent_port, cxlmd);
> +		if (rc) {
> +			if (rc == -ENODEV)
> +				dev_info(dev, "PMEM disabled by platform\n");
> +			return rc;
> +		}
> +	}
> +
>  	if (dport->rch)
>  		endpoint_parent = parent_port->uport_dev;
>  	else
> @@ -174,14 +183,6 @@ static int cxl_mem_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> -	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> -		rc = devm_cxl_add_nvdimm(cxlmd);
> -		if (rc == -ENODEV)
> -			dev_info(dev, "PMEM disabled by platform\n");
> -		else
> -			return rc;
> -	}
> -
>  	/*
>  	 * The kernel may be operating out of CXL memory on this device,
>  	 * there is no spec defined way to determine whether this device

