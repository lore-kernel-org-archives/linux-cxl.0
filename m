Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3120CCDD
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738669854; cv=none; b=lvvMTOW0uuuKiU04oyeFGprYzHuFdkxlukNfdgJzMboIA1EF0AUaD/fx+U6F8smYfHeTsVh47VL2aH0ss/WTqBlR9n9rCVgWnszj0MHsA2FYBn9oxdaeWFIED3SvhP7bBQdTA7xjC1B7ZLQqkv3c8n/QOYoAJbTVqRkQnqlUbF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738669854; c=relaxed/simple;
	bh=HzzbjC3z7BwRY6woTiHjCEQVXunSr+OXDuqoMERV72w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0vZmqRpOPE7lTDTNo29EbYv2NmVW8BHmTbtAQbXoEPIceaOqsRKOGFLjpIA9/gKstE8ia9Tw6j3UvarfoeiowZRzp78+XGe5JVIVJ1yEho+Z/203KQQ0RM01oEyIbRYmilkW4BdMzTA5OgG8BEEe+6WS0yTsqnJ5rxqiIc6jJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnM8323J7z6D9wP;
	Tue,  4 Feb 2025 19:48:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E0B0140A71;
	Tue,  4 Feb 2025 19:50:49 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 12:50:49 +0100
Date: Tue, 4 Feb 2025 11:50:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v3 3/6] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <20250204115047.00006a9f@huawei.com>
In-Reply-To: <173864305827.668823.13978794102080021276.stgit@dwillia2-xfh.jf.intel.com>
References: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
	<173864305827.668823.13978794102080021276.stgit@dwillia2-xfh.jf.intel.com>
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

Hi Dan,

My only real question in here is whether the ram partition must
be zero is worth explicitly optimizing for.  It reduces
some chances for code reuse.

Either way, this is fine.  A few other tiny things inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> Link: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com [1]
> Link: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com [2]
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/cdat.c      |   15 ++-----
>  drivers/cxl/core/hdm.c       |   88 +++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/mbox.c      |   68 ++++++++++---------------------
>  drivers/cxl/core/memdev.c    |    2 -
>  drivers/cxl/cxlmem.h         |   93 +++++++++++++++++++++++++++++-------------
>  drivers/cxl/pci.c            |    7 +++
>  tools/testing/cxl/test/cxl.c |   15 ++-----
>  tools/testing/cxl/test/mem.c |    7 +++
>  8 files changed, 195 insertions(+), 100 deletions(-)

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 48b26d3dad26..ea4e792f789f 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c

> +/* if this fails the caller must destroy @cxlds, there is no recovery */
> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
...

> +EXPORT_SYMBOL_GPL(cxl_dpa_setup);

Trivial but other exports in here are explicitly name spaced. Does it make
sense to relad this one?

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index c5f8320ed330..be0eb57086e1 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -80,7 +80,7 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	unsigned long long len = resource_size(to_ram_res(cxlds));
> +	unsigned long long len = cxl_ram_size(cxlds);

Belongs in previous patch perhaps?

>  
>  	return sysfs_emit(buf, "%#llx\n", len);
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 78e92e24d7b5..e33b2d5efed9 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -97,6 +97,24 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,

>  
> -static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> +
> +/* Static RAM is only expected at partition 0. */

I'm not sure this simplification is worth it.  After all can define
a helper if it is useful to have the to_x_res functions and define
them in terms of it.

static inline const struct resource *to_mem_res(struct cxl_dev_state *cxlds,
					        enum cxl_partition_mode mode)
{
	for (int i = 0; i < cxlds->nr_partitions; i++)
		if (cxlds->part[i].mode == mode)
			return &cxlds->part[i].res;
	return NULL;
}

static inline const struct resource *to_ram_res(struct cxl_dev_state *cxlds)
{
	return to_mem_res(cxlds, CXL_PARTMODE_RAM);
}
static inline const struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
{
	return to_mem_res(cxlds, CXL_PARTMODE_PMEM);

Or just use the to_mem_res() throughout and drop the to_pmem/ram_res() helpers.

}
					        
> +static inline const struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> +{
> +	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
> +		return NULL;
> +	return &cxlds->part[0].res;
> +}
> +
> +/*
> + * Static PMEM may be at partition index 0 when there is no static RAM
> + * capacity.
> + */
> +static inline const struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> +{
> +	for (int i = 0; i < cxlds->nr_partitions; i++)
> +		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
> +			return &cxlds->part[i].res;
> +	return NULL;
> +}
> +
> +static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)

Similar. Is it worth position 0 optimization?

>  {
> -	return &cxlds->_ram_res;
> +	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
> +		return NULL;
> +	return &cxlds->part[0].perf;
>  }
>  
> -static inline struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> +static inline struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
>  {
> -	return &cxlds->_pmem_res;
> +	for (int i = 0; i < cxlds->nr_partitions; i++)
> +		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
> +			return &cxlds->part[i].perf;
> +	return NULL;
>  }
