Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66A37DA66;
	Thu,  8 Jan 2026 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889186; cv=none; b=e4NkAxUaywwDrNMjHBpqZit+yzKd9BZ70fyGl8EFb9mjRs7vlx4m9ifWRRneDC43EA5Ec9M7hPDfXCMsv2QEgaSLreK9h30QeDRmluEn3pl0gTSZQ/EdgABev7v4D1uV0lesQ3Is1t7Rekzzx7lXgruDtL55nwiAeCZXf91EHiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889186; c=relaxed/simple;
	bh=pDSC2r2XqguV19KjDzCAWbvL/m3z6iTuZ1/DPDFzZGA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXl2vFPRzgMCUkKoe4iAgQ3XTquRgKKcvfcOHpSMijCcV7vDtaDGfZSafwKS9GFfJ5cDcDfLpougOpYFWuuGvJmexs7NABQ6UBL3P0NgogAvyAjvIJ1d6LPftNTGjGZqMdOzwASyGLF/rLo/uzjd18pQPwlbXYw4sb85g6RdDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn98m6RNlzJ46CS;
	Fri,  9 Jan 2026 00:19:36 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id F3E9540584;
	Fri,  9 Jan 2026 00:19:41 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 16:19:41 +0000
Date: Thu, 8 Jan 2026 16:19:39 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Cui Chao <cuichao1753@phytium.com.cn>
CC: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport
	<rppt@kernel.org>, Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-ID: <20260108161939.000026ec@huawei.com>
In-Reply-To: <20260106031042.1606729-2-cuichao1753@phytium.com.cn>
References: <20260106031042.1606729-1-cuichao1753@phytium.com.cn>
	<20260106031042.1606729-2-cuichao1753@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 6 Jan 2026 11:10:42 +0800
Cui Chao <cuichao1753@phytium.com.cn> wrote:

> In some physical memory layout designs, the address space of CFMW
> resides between multiple segments of system memory belonging to
> the same NUMA node. In numa_cleanup_meminfo, these multiple segments
> of system memory are merged into a larger numa_memblk. When
> identifying which NUMA node the CFMW belongs to, it may be incorrectly
> assigned to the NUMA node of the merged system memory.
> 
> Example memory layout:
> 
> Physical address space:
>     0x00000000 - 0x1FFFFFFF  System RAM (node0)
>     0x20000000 - 0x2FFFFFFF  CXL CFMW (node2)
>     0x40000000 - 0x5FFFFFFF  System RAM (node0)
>     0x60000000 - 0x7FFFFFFF  System RAM (node1)
> 
> After numa_cleanup_meminfo, the two node0 segments are merged into one:
>     0x00000000 - 0x5FFFFFFF  System RAM (node0) // CFMW is inside the range
>     0x60000000 - 0x7FFFFFFF  System RAM (node1)
> 
> So the CFMW (0x20000000-0x2FFFFFFF) will be incorrectly assigned to node0.
> 
> To address this scenario, accurately identifying the correct NUMA node
> can be achieved by checking whether the region belongs to both
> numa_meminfo and numa_reserved_meminfo.
> 
> Signed-off-by: Cui Chao <cuichao1753@phytium.com.cn>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  mm/numa_memblks.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> index 5b009a9cd8b4..e91908ed8661 100644
> --- a/mm/numa_memblks.c
> +++ b/mm/numa_memblks.c
> @@ -568,15 +568,16 @@ static int meminfo_to_nid(struct numa_meminfo *mi, u64 start)
>  int phys_to_target_node(u64 start)
>  {
>  	int nid = meminfo_to_nid(&numa_meminfo, start);
> +	int reserved_nid = meminfo_to_nid(&numa_reserved_meminfo, start);
>  
>  	/*
>  	 * Prefer online nodes, but if reserved memory might be
>  	 * hot-added continue the search with reserved ranges.
>  	 */
> -	if (nid != NUMA_NO_NODE)
> +	if (nid != NUMA_NO_NODE && reserved_nid == NUMA_NO_NODE)
>  		return nid;
>  
> -	return meminfo_to_nid(&numa_reserved_meminfo, start);
> +	return reserved_nid;
>  }
>  EXPORT_SYMBOL_GPL(phys_to_target_node);
>  

