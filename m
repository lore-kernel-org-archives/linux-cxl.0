Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0771A158529
	for <linux-cxl@vger.kernel.org>; Thu,  1 Aug 2024 07:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498893; cv=none; b=NZ/3F3VQRyC6oCLwz235zQpfyHaKb/GtILTJBdka/PYnCVmW5LOh6kbEd40v7/oiqtOMVec6IVw4Nz84Q/2gpGo2i0/7UCcg5OdFru/BGIEoPC6q8oUTGaZLHK0s5Hha/p/3+t+YAoMc2RLU5dgwuq5nKuGRBCjynjA73D54dYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498893; c=relaxed/simple;
	bh=jpi/KTWbWnMSzzzWhhAFT9tuVSEqwoG09oCmY84OzPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyvLiO9w4ppfu3x6rbm83cGu22OpJu3xDJqo+LFDc1doqg6yxJ97tOr7habOMGRXdA4KVFCaiAWUrLE1qneqNt5PdzGCG9ZGnWas7WkJVkJe7DUqKSNwigOjqEzeYzdDHGbNEJTOFk2Cx+3rDB0Nykitfur1Q2KcWNWNCByIk7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwB37yJFP6tmJYgRBA--.25558S2;
	Thu, 01 Aug 2024 15:54:45 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwAXQ7NEP6tmRy8KAA--.8566S2;
	Thu, 01 Aug 2024 15:54:44 +0800 (CST)
Date: Thu, 1 Aug 2024 15:54:44 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, chenbaozi@phytium.com.cn
Subject: Re: [RFC PATCH 6/8] arm64: mm: numa_fill_memblks() to add a
 memblock.reserved region if match.
Message-ID: <Zqs/ROgvi7YI6WLE@phytium.com.cn>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-7-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529171236.32002-7-Jonathan.Cameron@huawei.com>
X-CM-TRANSID:AQAAfwAXQ7NEP6tmRy8KAA--.8566S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAEAWaqm98E1AALsX
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Ww4DKF18JFWDZFWxXrWUurg_yoW8CF1rpw
	10kwnxCr4UWr1xu393Xw4Yqrn5uws5KF13W3y7Crn8uF1Sqr17Wa1Fgw4qvFWDtrW7GF4Y
	vF1jyFy5W3Wq9a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Wed, May 29, 2024 at 06:12:34PM +0100, Jonathan Cameron wrote:
> CXL memory hotplug relies on additional NUMA nodes being created
> for any CXL Fixed Memory Window if there is no suitable one created
> by system firmware. To detect if system firmware has created one look
> for any normal memblock that overlaps with the Fixed Memory Window that
> has a NUMA node (nid) set.
> 
> If one is found, add a region with the same nid to memblock.reserved
> so we can match it later when CXL memory is hotplugged.
> If not, add a region anyway because a suitable NUMA node will be
> set later. So for now use NUMA_NO_NODE.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  arch/arm64/mm/init.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 6a2f21b1bb58..27941f22db1c 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -50,6 +50,32 @@
>  
>  #ifdef CONFIG_NUMA
>  
> +/*
> + * Scan existing memblocks and if this region overlaps with a region with
> + * a nid set, add a reserved memblock.
> + */
> +int __init numa_fill_memblks(u64 start, u64 end)
> +{
> +	struct memblock_region *region;
> +
> +	for_each_mem_region(region) {
> +		int nid = memblock_get_region_node(region);
> +
> +		if (nid == NUMA_NO_NODE)
> +			continue;
> +		if (!(end < region->base || start >= region->base + region->size)) {
> +			memblock_add_reserved_node(start, end - start, nid,
> +						   MEMBLOCK_RSRV_NOINIT);
> +			return 0;
> +		}
> +	}
> +
> +	memblock_add_reserved_node(start, end - start, NUMA_NO_NODE,
> +				   MEMBLOCK_RSRV_NOINIT);
> +
> +	return NUMA_NO_MEMBLK;
> +}
> +
>  static int __memory_add_physaddr_to_nid(u64 addr)
>  {
>  	unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
> -- 
> 2.39.2
>

Tested-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

