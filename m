Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8113E02E
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648563; cv=none; b=ovS9nP9cHqv2bATFsLvBMXN+RDE58nzIuv2aDpbNNYfF5d5mCOEAWfREFjcKobtDFRvboVtY6RpW9HiTTbe90R8lxQ5bJc/ZqxHpKGhjxVZwq8wKaBLHvcshc0h0sShYl5xTj4WUFCG/vNLZ8Q3YQnE0Pnmt3nzuQTWr/T+xKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648563; c=relaxed/simple;
	bh=Rbg7FJxIsuISMcyzuM+9XrYip0nbpq5TSPdaMlERdKM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhiiMAHabEVYfnqEaQY9FQoYuLh+ZGd4PDm9CbFuTwvTHXLHkZkkFrFkUAxE6Gkdhss4UUIAgFPfp4pJdQBJjbt3N/aN8g2iRdugIKaHErcUTDlsOY86CBoBBScsnfHbkcNyu2jxDMQLCCG0daIaiV7PV2IMrbpXfBcQi+WtdAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf5S93ZnVz6L5Rs;
	Fri, 24 Jan 2025 00:07:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C1181140155;
	Fri, 24 Jan 2025 00:09:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 17:09:17 +0100
Date: Thu, 23 Jan 2025 16:09:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 3/5] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <20250123160915.00002012@huawei.com>
In-Reply-To: <173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
	<173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 00:59:27 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> The pending efforts to add CXL Accelerator (type-2) device [1], and
> Dynamic Capacity (DCD) support [2], tripped on the
> no-longer-fit-for-purpose design in the CXL subsystem for tracking
> device-physical-address (DPA) metadata. Trip hazards include:
> 
> - CXL Memory Devices need to consider a PMEM partition, but Accelerator
>   devices with CXL.mem likely do not in the common case.
> 
> - CXL Memory Devices enumerate DPA through Memory Device mailbox
>   commands like Partition Info, Accelerators devices do not.
> 
> - CXL Memory Devices that support DCD support more than 2 partitions.
>   Some of the driver algorithms are awkward to expand to > 2 partition
>   cases.
> 
> - DPA performance data is a general capability that can be shared with
>   accelerators, so tracking it in 'struct cxl_memdev_state' is no longer
>   suitable.
> 
> - Hardcoded assumptions around the PMEM partition always being index-1
>   if RAM is zero-sized or PMEM is zero sized.
> 
> - 'enum cxl_decoder_mode' is sometimes a partition id and sometimes a
>   memory property, it should be phased in favor of a partition id and
>   the memory property comes from the partition info.
> 
> Towards cleaning up those issues and allowing a smoother landing for the
> aforementioned pending efforts, introduce a 'struct cxl_dpa_partition'
> array to 'struct cxl_dev_state', and 'struct cxl_range_info' as a shared
> way for Memory Devices and Accelerators to initialize the DPA information
> in 'struct cxl_dev_state'.
> 
> For now, split a new cxl_dpa_setup() from cxl_mem_create_range_info() to
> get the new data structure initialized, and cleanup some qos_class init.
> Follow on patches will go further to use the new data structure to
> cleanup algorithms that are better suited to loop over all possible
> partitions.
> 
> cxl_dpa_setup() follows the locking expectations of mutating the device
> DPA map, and is suitable for Accelerator drivers to use. Accelerators
> likely only have one hardcoded 'ram' partition to convey to the
> cxl_core.
> 
> Link: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com [1]
> Link: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com [2]
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


A few trivial comments inline but looking better to me.

One question about what smells to me like our next MIXED mode.


> ---
>  drivers/cxl/core/cdat.c      |   15 ++-----
>  drivers/cxl/core/hdm.c       |   75 +++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/mbox.c      |   68 ++++++++++--------------------
>  drivers/cxl/core/memdev.c    |    2 -
>  drivers/cxl/cxlmem.h         |   94 +++++++++++++++++++++++++++++-------------
>  drivers/cxl/pci.c            |    7 +++
>  tools/testing/cxl/test/cxl.c |   15 ++-----
>  tools/testing/cxl/test/mem.c |    7 +++
>  8 files changed, 183 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index b177a488e29b..5400a421ad30 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c

> +/* if this fails the caller must destroy @cxlds, there is no recovery */
> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> +{
> +	struct device *dev = cxlds->dev;
> +
> +	guard(rwsem_write)(&cxl_dpa_rwsem);
> +
> +	if (cxlds->nr_partitions)
> +		return -EBUSY;
> +
> +	if (!info->size || !info->nr_partitions) {
> +		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> +		cxlds->nr_partitions = 0;
> +		return 0;
> +	}
> +
> +	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
> +
> +	for (int i = 0; i < info->nr_partitions; i++) {
> +		const struct cxl_dpa_part_info *part = &info->part[i];
> +		const char *desc;
> +		int rc;
> +
> +		if (part->mode == CXL_PARTMODE_RAM)
> +			desc = "ram";
> +		else if (part->mode == CXL_PARTMODE_PMEM)
> +			desc = "pmem";

I'd go switch statement now to save having to fix this up later, or
an array of strings with a bounds check.
(not important though if you want to shunt that into another day)

> +		else
> +			desc = "";
> +		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
> +		cxlds->part[i].mode = part->mode;
> +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->part[i].res,
> +				 part->range.start, range_len(&part->range),
> +				 desc);
> +		if (rc)
> +			return rc;
> +		cxlds->nr_partitions++;
> +	}
> +
> +	return 0;
> +}

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 3502f1633ad2..62bb3653362f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c


> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 78e92e24d7b5..15f549afab7c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -97,6 +97,25 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			 resource_size_t base, resource_size_t len,
>  			 resource_size_t skipped);
>  
> +enum cxl_partition_mode {
> +	CXL_PARTMODE_NONE,

What is NONE for?  Given you are now packing the partitions and
counting them when would we get an 'empty' one?


> +	CXL_PARTMODE_RAM,
> +	CXL_PARTMODE_PMEM,
> +};
> +
> +#define CXL_NR_PARTITIONS_MAX 2
> +
> +struct cxl_dpa_info {
> +	u64 size;
> +	struct cxl_dpa_part_info {
> +		struct range range;
> +		enum cxl_partition_mode mode;
> +	} part[CXL_NR_PARTITIONS_MAX];
> +	int nr_partitions;
> +};
> +
> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);


