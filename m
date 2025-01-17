Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A19C1FE46E
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737112342; cv=none; b=lEVzhZdoBNQONmBGj7q7vQ5/p5t04uU8A7h97czeyxBPXkopfao3mnr4veKdnPClmy68FjJ7OPtmke+DpUIxuCWzfPSOVVhyKTRdhO30gTUA41qwqLOKZNEEpoM3vldHSvoOQj9jEiWwX0FIvUtVZEDgCdEaJUvCqTWlvSIKfZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737112342; c=relaxed/simple;
	bh=7z2jjZCkZC0MnV7CejdONldqkQVANsMYGSsigJ+iEeo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEbX2ksID1zdEgxO86IfoSS/BznjnkVC0QWchLHHgiwH4Pgqa+la/ToJtzgGV7KgH8qT4YQ6bRBlfmayJlFmjrkNmPeVZtzAuQpXqsyDHkHqss7saCneNQObXgBq5XyQ16AgtNk/DN3QvA8Qxjh8nYge23jc53DWyzz+p+mBQGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YZH8N67qMz6M4Pq;
	Fri, 17 Jan 2025 19:10:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CA186140DAF;
	Fri, 17 Jan 2025 19:12:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 Jan
 2025 12:12:16 +0100
Date: Fri, 17 Jan 2025 11:12:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 4/4] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
Message-ID: <20250117111215.000061c7@huawei.com>
In-Reply-To: <173709425022.753996.16667967718406367188.stgit@dwillia2-xfh.jf.intel.com>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
	<173709425022.753996.16667967718406367188.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 16 Jan 2025 22:10:50 -0800
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
> partition metadata.

If we'd move to meta data and these were tightly packed then I'd be fine
with nr_partitions. Until that step, I find it confusing.

A few comments inline. This series does bring some advantages though
at cost of code that needs a bit more documentation at the very least.

> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/hdm.c |  167 +++++++++++++++++++++++++++++++++---------------
>  drivers/cxl/cxlmem.h   |    9 +++
>  2 files changed, 125 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7e1559b3ed88..4a2816102a1e 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -223,6 +223,30 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
>  

Some documentation would be useful. I'm not sure I understand
this algorithm correctly.

I think this complexity is all about ensuring that skip regions have
their resources broken up on partition boundaries?

Can we potentially relax constraints a little more to make this
easier to read by not caring on the ordering?  Find overlap
of skip region with any partition and remove that bit unconditionally.

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
> +
>  /*
>   * Must be called in a context that synchronizes against this decoder's
>   * port ->remove() callback (like an endpoint decoder sysfs attribute)
> @@ -241,7 +265,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  	skip_start = res->start - cxled->skip;
>  	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
>  	if (cxled->skip)
> -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
> +		release_skip(cxlds, skip_start, cxled->skip);
>  	cxled->skip = 0;
>  	cxled->dpa_res = NULL;
>  	put_device(&cxled->cxld.dev);
> @@ -268,6 +292,47 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  	__cxl_dpa_release(cxled);
>  }
>  
> +static int request_skip(struct cxl_dev_state *cxlds,
> +			struct cxl_endpoint_decoder *cxled,
> +			const resource_size_t skip_base,
> +			const resource_size_t skip_len)
> +{
> +	resource_size_t skip_start = skip_base, skip_rem = skip_len;
> +
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {

Likewise, if we relax a constraint on ordering can we make this simpler?
Would just need to keep track on whether we had reserved enough. I'm not
100% sure that is sufficient for the final error check.

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
Ah, this complicates possibility of relaxations as we'd need to pass in what
partion number we'd reached when fail occurred.
Maybe this is the best algorithm, but I'd definitely like docs for this
function to make it clear what it's assumptions are (paritions in order of DPA etc)
> +
> +	return -EBUSY;
> +}
> +


> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2e728d4b7327..43acd48b300f 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -515,6 +515,15 @@ static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
>  	return resource_size(res);
>  }
>  
> +static inline bool cxl_partition_contains(struct cxl_dev_state *cxlds,
> +					  unsigned int part,
> +					  struct resource *res)
> +{
> +	if (part >= cxlds->nr_partitions)
> +		return false;
> +	return resource_contains(&cxlds->part[part].res, res);
As per previous review. zero size resource never contains, so can drop the check
on nr_partitions and instead check against MAX that the core initializes to empty
(and might be overwritten by the drivers).
> +}
> +
>  static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>  {
>  	return dev_get_drvdata(cxl_mbox->host);
> 
> 

