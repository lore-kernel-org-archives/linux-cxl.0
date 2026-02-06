Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858BA2580EE;
	Fri,  6 Feb 2026 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395024; cv=none; b=Xj2Jw/oReOuh8CejRGywcxMPdwL24jR1WAMXIdJ1WcawPIbPDU1CKzUkzOh3CKUr3zmzOsXoMBlUuMRF4uNJzwVVAGi0VPCR6W4UpQOg2tjDw7JnpHA1jFt/M5YM1NsUejKIgivUVoL2Bntsk3w+eNqBcxVS0hzzCr+y2aEZ0Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395024; c=relaxed/simple;
	bh=N63/zR5mxv59bgHHd4Tl4ey4cqJfFSjFypbImKjyUhs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmDDgXKHwpPUegYt/wHhQ4I7uOUzrIBrwf1URsGVLcjz/kw7+NejuhYQahjIwVI24Y3Lmd4+1pRZJAoXo7D6sylOv80EEWJwo9alFcG8ITp+pud7Wkctz6QbUNC3m5b7918t53nHcEn/9Nep8HxqDmCpSKEPQhCSAjKVyZ/IXU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6zs36pkgzJ46bs;
	Sat,  7 Feb 2026 00:22:47 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D15F40086;
	Sat,  7 Feb 2026 00:23:40 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 16:23:39 +0000
Date: Fri, 6 Feb 2026 16:23:38 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Gregory Price <gourry@gourry.net>, Cui Chao <cuichao1753@phytium.com.cn>,
	<dan.j.williams@intel.com>, Mike Rapoport <rppt@kernel.org>, Wang Yinfeng
	<wangyinfeng@phytium.com.cn>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<qemu-devel@nongnu.org>, "David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-ID: <20260206162338.000035c8@huawei.com>
In-Reply-To: <20260206075709.0f4b60dd5dd664894cbd15c7@linux-foundation.org>
References: <20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
	<9132054c-3017-4af0-84e0-e4359b0794a6@phytium.com.cn>
	<20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
	<696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
	<2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
	<aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
	<a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn>
	<20260205145842.efb90572a902ae4c481e6ef6@linux-foundation.org>
	<aYUjf0OrD8f_bJCy@gourry-fedora-PF4VCD3F>
	<20260206110305.00001fbb@huawei.com>
	<aYXtHa4Y2y_5xgcS@gourry-fedora-PF4VCD3F>
	<20260206150941.000028ae@huawei.com>
	<20260206075709.0f4b60dd5dd664894cbd15c7@linux-foundation.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 6 Feb 2026 07:57:09 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 6 Feb 2026 15:09:41 +0000 Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> 
> > > Andrew if Jonathan is good with it then with changelog updates this can
> > > go in, otherwise I don't think this warrants a backport or anything.  
> > 
> > Wait and see if anyone hits it on a real machine (or even non creative QEMU
> > setup!)  So for now no need to backport.  
> 
> Thanks, all.
> 
> Below is the current state of this patch.  Is the changelog suitable?
Hi Andrew

Not quite..

> 
> 
> From: Cui Chao <cuichao1753@phytium.com.cn>
> Subject: mm: numa_memblks: identify the accurate NUMA ID of CFMW
> Date: Tue, 6 Jan 2026 11:10:42 +0800
> 
> In some physical memory layout designs, the address space of CFMW (CXL
> Fixed Memory Window) resides between multiple segments of system memory
> belonging to the same NUMA node.  In numa_cleanup_meminfo, these multiple
> segments of system memory are merged into a larger numa_memblk.  When
> identifying which NUMA node the CFMW belongs to, it may be incorrectly
> assigned to the NUMA node of the merged system memory.
> 
> When a CXL RAM region is created in userspace, the memory capacity of
> the newly created region is not added to the CFMW-dedicated NUMA node. 
> Instead, it is accumulated into an existing NUMA node (e.g., NUMA0
> containing RAM).  This makes it impossible to clearly distinguish
> between the two types of memory, which may affect memory-tiering
> applications.
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
> 
> 1. Issue Impact and Backport Recommendation:
> 
> This patch fixes an issue on hardware platforms (not QEMU emulation)

I think this bit turned out to not be a bit misleading.  Cui Chao
clarified in: 
https://lore.kernel.org/all/a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn/


"This issue was discovered on the QEMU platform. I need to apologize for 
my earlier imprecise statement (claiming it was hardware instead of 
QEMU). My core point at the time was to emphasize that this is a problem 
in the general code path when facing this scenario, not a QEMU-specific 
emulation issue, and therefore it could theoretically affect real 
hardware as well. I apologize for any confusion this may have caused."

So, whilst this could happen on a real hardware platform, for now we aren't
aware of a suitable configuration actually happening. I'm not sure we can
even create it in in QEMU without some tweaks.

Other than relaxing this to perhaps say that a hardware platform 'might'
have a configuration like the description here looks good to me.

Thanks!

Jonathan


> where, during the dynamic creation of a CXL RAM region, the memory
> capacity is not assigned to the correct CFMW-dedicated NUMA node.  This
> issue leads to:
> 
>     Failure of the memory tiering mechanism: The system is designed to
>     treat System RAM as fast memory and CXL memory as slow memory. For
>     performance optimization, hot pages may be migrated to fast memory
>     while cold pages are migrated to slow memory. The system uses NUMA
>     IDs as an index to identify different tiers of memory. If the NUMA
>     ID for CXL memory is calculated incorrectly and its capacity is
>     aggregated into the NUMA node containing System RAM (i.e., the node
>     for fast memory), the CXL memory cannot be correctly identified. It
>     may be misjudged as fast memory, thereby affecting performance
>     optimization strategies.
> 
>     Inability to distinguish between System RAM and CXL memory even for
>     simple manual binding: Tools like |numactl|and other NUMA policy
>     utilities cannot differentiate between System RAM and CXL memory,
>     making it impossible to perform reasonable memory binding.
> 
>     Inaccurate system reporting: Tools like |numactl -H|would display
>     memory capacities that do not match the actual physical hardware
>     layout, impacting operations and monitoring.
> 
> This issue affects all users utilizing the CXL RAM functionality who
> rely on memory tiering or NUMA-aware scheduling.  Such configurations
> are becoming increasingly common in data centers, cloud computing, and
> high-performance computing scenarios.
> 
> Therefore, I recommend backporting this patch to all stable kernel 
> series that support dynamic CXL region creation.
> 
> 2. Why a Kernel Update is Recommended Over a Firmware Update:
> 
> In the scenario of dynamic CXL region creation, the association between
> the memory's HPA range and its corresponding NUMA node is established
> when the kernel driver performs the commit operation.  This is a
> runtime, OS-managed operation where the platform firmware cannot
> intervene to provide a fix.
> 
> Considering factors like hardware platform architecture, memory
> resources, and others, such a physical address layout can indeed occur.
> This patch does not introduce risk; it simply correctly handles the
> NUMA node assignment for CXL RAM regions within such a physical address
> layout.
> 
> Thus, I believe a kernel fix is necessary.
> 
> Link: https://lkml.kernel.org/r/20260106031042.1606729-2-cuichao1753@phytium.com.cn
> Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
> Signed-off-by: Cui Chao <cuichao1753@phytium.com.cn>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Wang Yinfeng <wangyinfeng@phytium.com.cn>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Joanthan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Wang Yinfeng <wangyinfeng@phytium.com.cn>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/numa_memblks.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/mm/numa_memblks.c~mm-numa_memblks-identify-the-accurate-numa-id-of-cfmw
> +++ a/mm/numa_memblks.c
> @@ -570,15 +570,16 @@ static int meminfo_to_nid(struct numa_me
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
> _
> 
> 

