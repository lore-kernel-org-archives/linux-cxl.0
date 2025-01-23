Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B362139DA
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737650481; cv=none; b=SRtXromCypWEvea6scsUxZzkzwyfzqsKR/TrBfgjqYHPG2iI8YhrgRZWvOKujS2kM9LrhRc0v+O+yBkGYey48JqY/czyrmpkjuKbdJuCIrcKt+Yl0X1Dd1wiNh4A2wqBYZmYkPxYqpW1hLSuSLRMs+DX3OMDZCh30fbAlMxNRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737650481; c=relaxed/simple;
	bh=+Z5WjmM/6H68SbWTBiEkBc4wIglRW/PP+FYIiBG90Aw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHIWi54Jp6nMVKvLX0Y5gZdL0AV8cgTscKWa/MYy3epwRY9R3uzg0jM2xZZMS9Dljldv6XqoHVycKe9hMMQ0QyDizajovzYdpP/1F5MlQwHj/QgaDF7IgwlR5U+IwVeSJdsvF5QZDbn5voei2Y9Byzz4RsMK5HXgHBb2croPBvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf6913jR7z6L5g2;
	Fri, 24 Jan 2025 00:39:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D57F5140B3C;
	Fri, 24 Jan 2025 00:41:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 17:41:13 +0100
Date: Thu, 23 Jan 2025 16:41:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 4/5] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
Message-ID: <20250123164112.000028e3@huawei.com>
In-Reply-To: <173753637297.3849855.5217976225600372473.stgit@dwillia2-xfh.jf.intel.com>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
	<173753637297.3849855.5217976225600372473.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 00:59:33 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> cxl_dpa_alloc() is a hard coded nest of assumptions around PMEM
> allocations being distinct from RAM allocations in specific ways when in
> practice the allocation rules are only relative to DPA partition index.
> 
> The rules for cxl_dpa_alloc() are:
> 
> - allocations can only come from 1 partition
> 
> - if allocating at partition-index-N, all free space in partitions less
>   than partition-index-N must be skipped over
> 
> Use the new 'struct cxl_dpa_partition' array to support allocation with
> an arbitrary number of DPA partitions on the device.
> 
> A follow-on patch can go further to cleanup 'enum cxl_decoder_mode'
> concept and supersede it with looking up the memory properties from
> partition metadata. Until then cxl_part_mode() temporarily bridges code
> that looks up partitions by @cxled->mode.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

A few possible simplifications below + a trivial debug message printing
a useful value comment.

Jonathan

> ---
>  drivers/cxl/core/hdm.c |  215 +++++++++++++++++++++++++++++++++++-------------
>  drivers/cxl/cxlmem.h   |   14 +++
>  2 files changed, 172 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 3f8a54ca4624..591aeb26c9e1 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -223,6 +223,31 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
>  
> +/* See request_skip() kernel-doc */
> +static void release_skip(struct cxl_dev_state *cxlds,
> +			 const resource_size_t skip_base,
> +			 const resource_size_t skip_len)
> +{
> +	resource_size_t skip_start = skip_base, skip_rem = skip_len;
> +
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> +		const struct resource *part_res = &cxlds->part[i].res;
> +		resource_size_t skip_end, skip_size;
> +
> +		if (skip_start < part_res->start || skip_start > part_res->end)
> +			continue;
> +
> +		skip_end = min(part_res->end, skip_start + skip_rem - 1);
> +		skip_size = skip_end - skip_start + 1;
> +		__release_region(&cxlds->dpa_res, skip_start, skip_size);
> +		skip_start += skip_size;
> +		skip_rem -= skip_size;
> +
> +		if (!skip_rem)
> +			break;
> +	}
> +}

Could ignore all explicit ordering constraints and have perhaps simpler
(Even simpler if there is an overlap helper we can use)
Assumption is we want to blow away anything in the skip range, whatever
partition it is in.

	for (int i = 0; i < cxlds->nr_paritions; i++) {
		const struct resource *part_res = &cxlds->part[i].res;
		resource_size_t toremove_start, toremove_end;

		toremove_start = max(skip_start, part_res->start);
		toremove_end = min(skip_end, part_res->end);
		if (toremove_end > toremove_start) {
			resource_size_t rem_size = toremove_end - toremove_start + 1;
			__release_region(&cxlds->dpa_res, toremove_start, rem_size);
		}

	}	
Can track skip_rem or not bother with that optimization.

Mind you your code is fine so I don't really mind.
I think we can build similar for request_skip based on ordering assumption, though
there we do need to keep track of how far we got so as to unwind only
that bit.




> +

> +static int request_skip(struct cxl_dev_state *cxlds,
> +			struct cxl_endpoint_decoder *cxled,
> +			const resource_size_t skip_base,
> +			const resource_size_t skip_len)
> +{
> +	resource_size_t skip_start = skip_base, skip_rem = skip_len;
> +
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> +		const struct resource *part_res = &cxlds->part[i].res;
> +		struct cxl_port *port = cxled_to_port(cxled);
> +		resource_size_t skip_end, skip_size;
> +		struct resource *res;
> +
> +		if (skip_start < part_res->start || skip_start > part_res->end)
> +			continue;
> +
> +		skip_end = min(part_res->end, skip_start + skip_rem - 1);
> +		skip_size = skip_end - skip_start + 1;
> +
> +		res = __request_region(&cxlds->dpa_res, skip_start, skip_size,
> +				       dev_name(&cxled->cxld.dev), 0);
> +		if (!res) {
> +			dev_dbg(cxlds->dev,
> +				"decoder%d.%d: failed to reserve skipped space\n",
> +				port->id, cxled->cxld.id);
> +			break;
> +		}
> +		skip_start += skip_size;
> +		skip_rem -= skip_size;
> +		if (!skip_rem)
> +			break;
> +	}
> +
> +	if (skip_rem == 0)
> +		return 0;
> +
> +	release_skip(cxlds, skip_base, skip_len - skip_rem);
> +
> +	return -EBUSY;
> +}


> @@ -529,15 +625,13 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	resource_size_t free_ram_start, free_pmem_start;
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &cxled->cxld.dev;
> -	resource_size_t start, avail, skip;
> +	struct resource *res, *prev = NULL;
> +	resource_size_t start, avail, skip, skip_start;
>  	struct resource *p, *last;
> -	const struct resource *ram_res = to_ram_res(cxlds);
> -	const struct resource *pmem_res = to_pmem_res(cxlds);
> -	int rc;
> +	int part, rc;
>  
>  	down_write(&cxl_dpa_rwsem);
>  	if (cxled->cxld.region) {
> @@ -553,47 +647,54 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  		goto out;
>  	}
>  
> -	for (p = ram_res->child, last = NULL; p; p = p->sibling)
> -		last = p;
> -	if (last)
> -		free_ram_start = last->end + 1;
> -	else
> -		free_ram_start = ram_res->start;
> +	part = -1;
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> +		if (cxled->mode == cxl_part_mode(cxlds->part[i].mode)) {
> +			part = i;
> +			break;
> +		}
> +	}
>  
> -	for (p = pmem_res->child, last = NULL; p; p = p->sibling)
> +	if (part < 0) {
> +		dev_dbg(dev, "partition %d not found\n", part);

how is part useful to print here? it's -1

> +		rc = -EBUSY;
> +		goto out;
> +	}

Maybe tidier as a check on loop exiting early.

	for (part = 0; i < cxlds->nr_partitions; part++) {
		if (cxled->mode == cxl_part_mode(cxlds->part[part].mode)
			break;
	}
	if (part == cxlds->nr_partitions) {
		dev_dbg(dev, "parition mode %d not found\n", cxled->mode);
		rc = -EBUSY;
		goto out;
	}





