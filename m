Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707AB20D507
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738671216; cv=none; b=R1jq59PpRexfc33mrqDEGOKksPkw40f08aVonaTdamqZdf7+Ec3Mo1QGn83R2hYHHTcXDMRJcNWS61jAhdVk4yzxLdhVqJ2bX4qRAEQoEfpD+6RYTiTYUZiBRLXT71fCcpTnmA0oA2Bh244ahmstYAEQiJQv0O5kD7qbURy/YD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738671216; c=relaxed/simple;
	bh=V4fLld8HFA57hHHG9lU5n4UUr3FPvChnuwUYnKHm9dM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O13rwguv7k0sgdghFlXR72AiCgsK43jGA+PDdAAR4Wkj5+hhEdRZs3s3pfm5i20qdmDGJtnSYQK1ImRXWURIOBAH5LQYJ5yB44x251E2y/GY8WG4J3fn0Nyo6Zf333kS7JcsdjgfGsZjZk7JM+MuNQt8KZjzkROp54RCbn/M8Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnMdq4dtTz6F97c;
	Tue,  4 Feb 2025 20:10:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B39D4140B67;
	Tue,  4 Feb 2025 20:13:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 13:13:30 +0100
Date: Tue, 4 Feb 2025 12:13:28 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 4/6] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
Message-ID: <20250204121328.00006a0e@huawei.com>
In-Reply-To: <173864306400.668823.12143134425285426523.stgit@dwillia2-xfh.jf.intel.com>
References: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
	<173864306400.668823.12143134425285426523.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 03 Feb 2025 20:24:24 -0800
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
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Nice. More comments than questions in line....

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> @@ -542,15 +623,13 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
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
> @@ -566,47 +645,53 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
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

This code could be made simpler but you delete it in patch 5 anyway
so I'll drop my comments on it to avoid confusion.
I wrote a nice essay that will never see the light of day. Ah well.


> +			break;
> +		}
> +	}
> +
> +	if (part < 0) {

> +		rc = -EBUSY;
> +		goto out;
> +	}
>  
> -	for (p = pmem_res->child, last = NULL; p; p = p->sibling)
> +	res = &cxlds->part[part].res;
> +	for (p = res->child, last = NULL; p; p = p->sibling)
>  		last = p;
>  	if (last)
> -		free_pmem_start = last->end + 1;
> +		start = last->end + 1;
>  	else
> -		free_pmem_start = pmem_res->start;
> +		start = res->start;
>  
> -	if (cxled->mode == CXL_DECODER_RAM) {
> -		start = free_ram_start;
> -		avail = ram_res->end - start + 1;
> -		skip = 0;
> -	} else if (cxled->mode == CXL_DECODER_PMEM) {
> -		resource_size_t skip_start, skip_end;
> -
> -		start = free_pmem_start;
> -		avail = pmem_res->end - start + 1;
> -		skip_start = free_ram_start;
> -
> -		/*
> -		 * If some pmem is already allocated, then that allocation
> -		 * already handled the skip.
> -		 */
> -		if (pmem_res->child &&
> -		    skip_start == pmem_res->child->start)
> -			skip_end = skip_start - 1;
> -		else
> -			skip_end = start - 1;
> -		skip = skip_end - skip_start + 1;
> -	} else {
> -		dev_dbg(dev, "mode not set\n");
> -		rc = -EINVAL;
> -		goto out;
> +	/*
> +	 * To allocate at partition N, a skip needs to be calculated for all
> +	 * unallocated space at lower partitions indices.
> +	 *
> +	 * If a partition has any allocations, the search can end because a
> +	 * previous cxl_dpa_alloc() invocation is assumed to have accounted for
> +	 * all previous partitions.
> +	 */
> +	skip_start = CXL_RESOURCE_NONE;
> +	for (int i = part; i; i--) {
> +		prev = &cxlds->part[i - 1].res;
> +		for (p = prev->child, last = NULL; p; p = p->sibling)
> +			last = p;

This pattern keeps turning up.  Maybe a helper is appropriate?
		last = resource_last_child()

Perhaps a job for another day.

> +		if (last) {
> +			skip_start = last->end + 1;
> +			break;
> +		}
> +		skip_start = prev->start;
>  	}
>  
> +	avail = res->end - start + 1;
> +	if (skip_start == CXL_RESOURCE_NONE)
> +		skip = 0;
> +	else
> +		skip = res->start - skip_start;
> +
>  	if (size > avail) {
>  		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
>  			cxl_decoder_mode_name(cxled->mode), &avail);


