Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C9E273FD;
	Thu,  3 Apr 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743695762; cv=none; b=hyx+pFfcupP86Ut4OVzAS7DQMpJkbg3T2RgHHwQBOXmQmU6Qsed71zb6uXKszE31cuZDJoTDTfpCyCUEVZb7URkHjwxZRx7SJineOhlvfngqCMqQNvhNiKFPU1AWxRVvN2a/Hi0n+1tSX1+BVgR4hHEG3Yay9qNv8gx1dfcBO4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743695762; c=relaxed/simple;
	bh=Z5J3YKVjNZ8m8baV3U4uqMzpF25PP4oUDCTEATpZ9lw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebfv7ew6GTkwd1YDavdu99d+6gJhkfeTIUbAlhz/MmUsNvptr8OMABUdJGhlG0H5fl4dFKJYPU5xPHnYFcgoA4jvDkNaA4Z+nQQQ2MIQf0/5XheyXgNBNyEIuveRPje6NUFoSFCFjTAU1dnOklD37+waL8lkl15PltsVzniE70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZT5sx1cpKz6L52T;
	Thu,  3 Apr 2025 23:55:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CD7511400D4;
	Thu,  3 Apr 2025 23:55:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Apr
 2025 17:55:56 +0200
Date: Thu, 3 Apr 2025 16:55:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
	<yosry.ahmed@linux.dev>, <chengming.zhou@linux.dev>, <sj@kernel.org>,
	<linux-mm@kvack.org>, <kernel-team@meta.com>, <linux-kernel@vger.kernel.org>,
	<gourry@gourry.net>, <ying.huang@linux.alibaba.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<minchan@kernel.org>, <senozhatsky@chromium.org>
Subject: Re: [PATCH v2] zsmalloc: prefer the the original page's node for
 compressed data
Message-ID: <20250403165554.00004dd3@huawei.com>
In-Reply-To: <20250402204416.3435994-1-nphamcs@gmail.com>
References: <20250402204416.3435994-1-nphamcs@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  2 Apr 2025 13:44:16 -0700
Nhat Pham <nphamcs@gmail.com> wrote:

> Currently, zsmalloc, zswap's and zram's backend memory allocator, does
> not enforce any policy for the allocation of memory for the compressed
> data, instead just adopting the memory policy of the task entering
> reclaim, or the default policy (prefer local node) if no such policy is
> specified. This can lead to several pathological behaviors in
> multi-node NUMA systems:
> 
> 1. Systems with CXL-based memory tiering can encounter the following
>    inversion with zswap/zram: the coldest pages demoted to the CXL tier
>    can return to the high tier when they are reclaimed to compressed
>    swap, creating memory pressure on the high tier.
> 
> 2. Consider a direct reclaimer scanning nodes in order of allocation
>    preference. If it ventures into remote nodes, the memory it
>    compresses there should stay there. Trying to shift those contents
>    over to the reclaiming thread's preferred node further *increases*
>    its local pressure, and provoking more spills. The remote node is
>    also the most likely to refault this data again. This undesirable
>    behavior was pointed out by Johannes Weiner in [1].
> 
> 3. For zswap writeback, the zswap entries are organized in
>    node-specific LRUs, based on the node placement of the original
>    pages, allowing for targeted zswap writeback for specific nodes.
> 
>    However, the compressed data of a zswap entry can be placed on a
>    different node from the LRU it is placed on. This means that reclaim
>    targeted at one node might not free up memory used for zswap entries
>    in that node, but instead reclaiming memory in a different node.
> 
> All of these issues will be resolved if the compressed data go to the
> same node as the original page. This patch encourages this behavior by
> having zswap and zram pass the node of the original page to zsmalloc,
> and have zsmalloc prefer the specified node if we need to allocate new
> (zs)pages for the compressed data.
> 
> Note that we are not strictly binding the allocation to the preferred
> node. We still allow the allocation to fall back to other nodes when
> the preferred node is full, or if we have zspages with slots available
> on a different node. This is OK, and still a strict improvement over
> the status quo:
> 
> 1. On a system with demotion enabled, we will generally prefer
>    demotions over compressed swapping, and only swap when pages have
>    already gone to the lowest tier. This patch should achieve the
>    desired effect for the most part.
> 
> 2. If the preferred node is out of memory, letting the compressed data
>    going to other nodes can be better than the alternative (OOMs,
>    keeping cold memory unreclaimed, disk swapping, etc.).
> 
> 3. If the allocation go to a separate node because we have a zspage
>    with slots available, at least we're not creating extra immediate
>    memory pressure (since the space is already allocated).
> 
> 3. While there can be mixings, we generally reclaim pages in
>    same-node batches, which encourage zspage grouping that is more
>    likely to go to the right node.
> 
> 4. A strict binding would require partitioning zsmalloc by node, which
>    is more complicated, and more prone to regression, since it reduces
>    the storage density of zsmalloc. We need to evaluate the tradeoff
>    and benchmark carefully before adopting such an involved solution.
> 
> [1]: https://lore.kernel.org/linux-mm/20250331165306.GC2110528@cmpxchg.org/
> 
> Suggested-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Makes sense. Formatting suggestions in other review nice to have though.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
