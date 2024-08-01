Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045A11EB4A6
	for <linux-cxl@vger.kernel.org>; Thu,  1 Aug 2024 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498663; cv=none; b=OPDcNdH+Bd8unFdtPH8av24KahqJ2XqmXNccH5pfvT5/RescVp78hm3nMd3gXYCk+TzzodLyn26AFGSuaPaGX1voDcNYbg3JClY+fWbCDIpKPDYCObG42zpRGfv+oO9ZsDXhYCPF7IHk0/JqVczy3GHeFguWpngpXR8ydUUuXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498663; c=relaxed/simple;
	bh=svhTqK4DRi1oaUzlcpoAjATc0qe8ekfMr90q1SLkLEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4FJbaobZq+giigLbR9QGvwfP/OMpLQYdWrkGDKBGJB372zJbgXcUx6zcKhSiiW6ixgOY5axS7D2gIZW4sqDt9M2bWGCiXAy9iWpvgouJosFFYxapfCXp4dfWD0R4x6PAFulY44eRsTEN3f0TW0Mrk1J8GUNkcIuGUea8BHoY24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCXnVlPPqtmAz+lAw--.52877S2;
	Thu, 01 Aug 2024 15:50:39 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBnlbVAPqtm9y4KAA--.17938S2;
	Thu, 01 Aug 2024 15:50:35 +0800 (CST)
Date: Thu, 1 Aug 2024 15:50:23 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, chenbaozi@phytium.com.cn
Subject: Re: [RFC PATCH 1/8] arm64: numa: Introduce a
 memory_add_physaddr_to_nid()
Message-ID: <Zqs+P/TO01Y3TKcd@phytium.com.cn>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-2-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529171236.32002-2-Jonathan.Cameron@huawei.com>
X-CM-TRANSID:AQAAfwBnlbVAPqtm9y4KAA--.17938S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAEAWaqm98E1AABsd
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWF47KF1UCrWfZryUur4xCrg_yoW5XFyfpF
	n7uwnxGFy7WFWxAay3JwnxAas8Za1rGF1agrW7Cryq9F1aqryxGr1Fvw4qvrWxWrZFgF4F
	9a10qF18Wa1DXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Wed, May 29, 2024 at 06:12:29PM +0100, Jonathan Cameron wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Based heavily on Dan William's earlier attempt to introduce this
> infrastruture for all architectures so I've kept his authorship. [1]
> 
> arm64 stores it's numa data in memblock. Add a memblock generic
> way to interrogate that data for memory_Add_physaddr_to_nid.
> 
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Jia He <justin.he@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Link: https://lore.kernel.org/r/159457120334.754248.12908401960465408733.stgit@dwillia2-desk3.amr.corp.intel.com [1]
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  arch/arm64/include/asm/sparsemem.h |  4 ++++
>  arch/arm64/mm/init.c               | 29 +++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> index 8a8acc220371..8dd1b6a718fa 100644
> --- a/arch/arm64/include/asm/sparsemem.h
> +++ b/arch/arm64/include/asm/sparsemem.h
> @@ -26,4 +26,8 @@
>  #define SECTION_SIZE_BITS 27
>  #endif /* CONFIG_ARM64_64K_PAGES */
>  
> +#ifndef __ASSEMBLY__
> +extern int memory_add_physaddr_to_nid(u64 addr);
> +#define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> +#endif /* __ASSEMBLY__ */
>  #endif
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9b5ab6818f7f..f310cbd349ba 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -48,6 +48,35 @@
>  #include <asm/alternative.h>
>  #include <asm/xen/swiotlb-xen.h>
>  
> +#ifdef CONFIG_NUMA
> +
> +static int __memory_add_physaddr_to_nid(u64 addr)
> +{
> +	unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
> +	int nid;
> +
> +	for_each_online_node(nid) {
> +		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> +		if (pfn >= start_pfn && pfn <= end_pfn)
> +			return nid;
> +	}
> +	return NUMA_NO_NODE;
> +}
> +
> +int memory_add_physaddr_to_nid(u64 start)
> +{
> +	int nid = __memory_add_physaddr_to_nid(start);
> +
> +	/* Default to node0 as not all callers are prepared for this to fail */
> +	if (nid == NUMA_NO_NODE)
> +		return 0;
> +
> +	return nid;
> +}
> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> +
> +#endif /* CONFIG_NUMA */
> +
>  /*
>   * We need to be able to catch inadvertent references to memstart_addr
>   * that occur (potentially in generic code) before arm64_memblock_init()
> -- 
> 2.39.2
>

Tested-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

