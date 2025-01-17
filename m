Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E02B71750
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109263; cv=none; b=hCoiPqJXJQTYsNF+kn9v1Cv5WlvWYwXFVVlcdi2nwgHikqwXkMNeL5lytq/6EsnGoMxT8tTStLEhuxRc2Bfy+djVLlj2YMgFuEe5K2Yj5mA4tacmAmn9ECcRUIQaoC60mYvQcbEiCuEJ2lPcnra8eHV/uulHNfYnOVGK6kHsk28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109263; c=relaxed/simple;
	bh=HWXnyEjHl6FNTOcGVigCeACGByP6PWz8P2RBljfaItk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExTE3dpqf9L4uK0rMRZL+LvD80aC08mneeGXbedYocOCKzQkCTXfpp8cQq28U2cmaUzR5Oh0yQHAWfFJalS3pkg/9k7+vAvjo9M9L8FCtAgaqFmMeu+ePCR8yTfysbpNRKdi0u9mWJ1RWpnOuooYKNJ4doA3QYzsgh5VurAgI64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YZG1P6nKyz6F9Bv;
	Fri, 17 Jan 2025 18:19:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D5BC140CB9;
	Fri, 17 Jan 2025 18:20:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 Jan
 2025 11:20:57 +0100
Date: Fri, 17 Jan 2025 10:20:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 2/4] cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
Message-ID: <20250117102056.0000793f@huawei.com>
In-Reply-To: <173709423850.753996.572292628436250022.stgit@dwillia2-xfh.jf.intel.com>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
	<173709423850.753996.572292628436250022.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 16 Jan 2025 22:10:38 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for consolidating all DPA partition information into an
> array of DPA metadata, introduce helpers that hide the layout of the
> current data. I.e. make the eventual replacement of ->ram_res,
> ->pmem_res, ->ram_perf, and ->pmem_perf with a new DPA metadata array a  
> no-op for code paths that consume that information, and reduce the noise
> of follow-on patches.
> 
> The end goal is to consolidate all DPA information in 'struct
> cxl_dev_state', but for now the helpers just make it appear that all DPA
> metadata is relative to @cxlds.
> 
> Note that a follow-on patch also cleans up the temporary placeholders of
> @ram_res, and @pmem_res in the qos_class manipulation code,
> cxl_dpa_alloc(), and cxl_mem_create_range_info().
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I'm not that keen on wrapping the size but not the base.
Leads to some odd looking code in places.

Various other comments inline.

> ---
>  drivers/cxl/core/cdat.c      |   70 +++++++++++++++++++++++++-----------------
>  drivers/cxl/core/hdm.c       |   26 ++++++++--------
>  drivers/cxl/core/mbox.c      |   18 ++++++-----
>  drivers/cxl/core/memdev.c    |   42 +++++++++++++------------
>  drivers/cxl/core/region.c    |   10 ++++--
>  drivers/cxl/cxlmem.h         |   58 ++++++++++++++++++++++++++++++-----
>  drivers/cxl/mem.c            |    2 +
>  tools/testing/cxl/test/cxl.c |   25 ++++++++-------
>  8 files changed, 159 insertions(+), 92 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 8153f8d83a16..b177a488e29b 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -258,29 +258,33 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
>  static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>  				     struct xarray *dsmas_xa)
>  {
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  	struct device *dev = cxlds->dev;
> -	struct range pmem_range = {
> -		.start = cxlds->pmem_res.start,
> -		.end = cxlds->pmem_res.end,
> -	};
> -	struct range ram_range = {
> -		.start = cxlds->ram_res.start,
> -		.end = cxlds->ram_res.end,
> -	};
>  	struct dsmas_entry *dent;
>  	unsigned long index;
> +	const struct resource *partition[] = {
> +		to_ram_res(cxlds),
> +		to_pmem_res(cxlds),
> +	};
As in the test code case (see later), why not just use a range
here and fill the various bits directly?

I think the code ends up simpler, particularly if you have _base()
helpers as well as size ones.

> +	struct cxl_dpa_perf *perf[] = {
> +		to_ram_perf(cxlds),
> +		to_pmem_perf(cxlds),
> +	};
>  
>  	xa_for_each(dsmas_xa, index, dent) {
> -		if (resource_size(&cxlds->ram_res) &&
> -		    range_contains(&ram_range, &dent->dpa_range))
> -			update_perf_entry(dev, dent, &mds->ram_perf);
> -		else if (resource_size(&cxlds->pmem_res) &&
> -			 range_contains(&pmem_range, &dent->dpa_range))
> -			update_perf_entry(dev, dent, &mds->pmem_perf);
> -		else
> -			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
> -				&dent->dpa_range);
> +		for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> +			const struct resource *res = partition[i];
> +			struct range range = {
> +				.start = res->start,
> +				.end = res->end,
> +			};
> +
> +			if (range_contains(&range, &dent->dpa_range))
> +				update_perf_entry(dev, dent, perf[i]);
> +			else
> +				dev_dbg(dev,
> +					"no partition for dsmas dpa: %pra\n",
> +					&dent->dpa_range);
> +		}
>  	}
>  }
>  
> @@ -304,6 +308,9 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
>  
>  static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
>  {
> +	if (!dpa_perf)
> +		return;

I don't mind the change, but this smells like a functional change that
doesn't belong in this patch.  I'm not seeing the check removed from elsewhere.

> +
>  	*dpa_perf = (struct cxl_dpa_perf) {
>  		.qos_class = CXL_QOS_CLASS_INVALID,
>  	};
> @@ -312,6 +319,9 @@ static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
>  static bool cxl_qos_match(struct cxl_port *root_port,
>  			  struct cxl_dpa_perf *dpa_perf)
>  {
> +	if (!dpa_perf)
> +		return false;
> +
>  	if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
>  		return false;
>  
> @@ -346,7 +356,8 @@ static int match_cxlrd_hb(struct device *dev, void *data)
>  static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_dpa_perf *ram_perf = to_ram_perf(cxlds),
> +			    *pmem_perf = to_pmem_perf(cxlds);
I'd just repeat the type.  To me that would be easier to read than
this (slightly).


> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index be8556119d94..7a85522294ad 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -327,9 +327,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index ae3dfcbe8938..c5f8320ed330 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -80,7 +80,7 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	unsigned long long len = resource_size(&cxlds->ram_res);
> +	unsigned long long len = resource_size(to_ram_res(cxlds));

Use the helper.

>  
>  	return sysfs_emit(buf, "%#llx\n", len);
>  }
> @@ -93,7 +93,7 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	unsigned long long len = resource_size(&cxlds->pmem_res);
> +	unsigned long long len = cxl_pmem_size(cxlds);
>  
>  	return sysfs_emit(buf, "%#llx\n", len);
>  }
> @@ -198,16 +198,20 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  	int rc = 0;
>  
>  	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
> -	if (resource_size(&cxlds->pmem_res)) {
> -		offset = cxlds->pmem_res.start;
> -		length = resource_size(&cxlds->pmem_res);
> +	if (cxl_pmem_size(cxlds)) {
> +		const struct resource *res = to_pmem_res(cxlds);
> +
> +		offset = res->start;
> +		length = resource_size(res);
>  		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>  		if (rc)
>  			return rc;
>  	}
> -	if (resource_size(&cxlds->ram_res)) {
> -		offset = cxlds->ram_res.start;
> -		length = resource_size(&cxlds->ram_res);
> +	if (cxl_ram_size(cxlds)) {
> +		const struct resource *res = to_ram_res(cxlds);
> +
> +		offset = res->start;
> +		length = resource_size(res);

Having a size helper and not using it consistently to me is ugly.
If we can keep the direct manipulation to where we actually care
about the tree of resources, that seems simpler to me.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e4885acac853..9f0f6fdbc841 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2688,7 +2688,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  
>  	if (ctx->mode == CXL_DECODER_RAM) {
>  		offset = ctx->offset;
> -		length = resource_size(&cxlds->ram_res) - offset;
> +		length = cxl_ram_size(cxlds) - offset;
>  		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>  		if (rc == -EFAULT)
>  			rc = 0;
> @@ -2700,9 +2700,11 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  		length = resource_size(&cxlds->dpa_res) - offset;
>  		if (!length)
>  			return 0;
> -	} else if (resource_size(&cxlds->pmem_res)) {
> -		offset = cxlds->pmem_res.start;
> -		length = resource_size(&cxlds->pmem_res);
> +	} else if (cxl_pmem_size(cxlds)) {
> +		const struct resource *res = to_pmem_res(cxlds);
> +
> +		offset = res->start;
> +		length = resource_size(res);
Whilst it's slightly more complex in terms of what it runs, I'd go with

		length = cxl_pmem_size(cxlds);
Could introduce a wrapper for base as well but perhaps that's a step
too far.

>  	} else {
>  		return 0;
>  	}
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..78e92e24d7b5 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 2f03a4d5606e..9675243bd05b 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -152,7 +152,7 @@ static int cxl_mem_probe(struct device *dev)
>  		return -ENXIO;
>  	}
>  
> -	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> +	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
>  		rc = devm_cxl_add_nvdimm(parent_port, cxlmd);
>  		if (rc) {
>  			if (rc == -ENODEV)
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index d0337c11f9ee..7f1c5061307b 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1000,25 +1000,28 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  		find_cxl_root(port);
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  	struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
> -	struct range pmem_range = {
> -		.start = cxlds->pmem_res.start,
> -		.end = cxlds->pmem_res.end,
> +	const struct resource *partition[] = {
> +		to_ram_res(cxlds),
> +		to_pmem_res(cxlds),
>  	};
Maybe better to use array of range, and fill the two entrees
using helpers (I'd add them for base as well as size).

> -	struct range ram_range = {
> -		.start = cxlds->ram_res.start,
> -		.end = cxlds->ram_res.end,
> +	struct cxl_dpa_perf *perf[] = {
> +		to_ram_perf(cxlds),
> +		to_pmem_perf(cxlds),
>  	};

>  
>  	if (!cxl_root)
>  		return;
>  
> -	if (range_len(&ram_range))
> -		dpa_perf_setup(port, &ram_range, &mds->ram_perf);
> +	for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> +		const struct resource *res = partition[i];
> +		struct range range = {
> +			.start = res->start,
> +			.end = res->end,

Purely a preference thing, but I'd got with not introduce the local
for just two simple dereferences.  Keeping it clearly associated with
the definitions above looks better to me.

			.start = partition[i]->start,
			.end = partition[i]->end,	
Or switch to range for your paritions array and do the conversion in one
place.

		
> +		};
>  
> -	if (range_len(&pmem_range))
> -		dpa_perf_setup(port, &pmem_range, &mds->pmem_perf);
> +		dpa_perf_setup(port, &range, perf[i]);
> +	}
>  
>  	cxl_memdev_update_perf(cxlmd);
>  
> 
> 

