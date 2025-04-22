Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CD627BF69
	for <linux-cxl@vger.kernel.org>; Tue, 22 Apr 2025 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322499; cv=none; b=MME0+iVvnCR+37bERQnU+AJ2fcGn3N2tsQiWxSfOOr/k9xbIL567MCHYaBvT5sA4PC2uR0rq7f/JjYotUYJNHaMejAk87zLn4DR6jZLTPo22HsE+2WVONauaOylX6U/oJQHh97/Gr/ZYYW3GVx0+JvrB77gpMl6/PNqNPoTn1KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322499; c=relaxed/simple;
	bh=vvbSXOpv2PWldlCkgMw68EbwtInhF3Q/a+9cSwsTqWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyu/t4Ioji868jO783ojhwFn64Nl4WX4ZnwZiDDi0QsEtvvrqlO+sY3ixnUWbTf2znsemk1CrkATwE7hm0RD+wuCe4VUidKC3834DBForAkY0jkbbJ+mTR9HOq55AXJ1nArERSlt6b5OWC3PQjw3Cn19raGe9T5QkCtCsi1jSJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F95sxA5l; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F95sxA5l"
Date: Tue, 22 Apr 2025 04:47:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745322485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DlOy5pgOMDLNOF17VOxP0jw2ph04ic2bIH7kzzlbOHI=;
	b=F95sxA5lw7P8QmrrzD85lNvmnPmm9bJbaQFbZRyO8zsokGbePISBD4Zp2xa9m5HmyD4pZi
	9InQKq9XKutv7roD05XGKcJvwpyyuBneY5YHZEVxT6DRVOviq6Q3intImd7OuS9jgn5B4l
	YARCPhgTzAhhOduK1xEbRW0uCv5FvYk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev,
	sj@kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, gourry@gourry.net,
	ying.huang@linux.alibaba.com, jonathan.cameron@huawei.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	minchan@kernel.org, senozhatsky@chromium.org
Subject: Re: [PATCH v2] zsmalloc: prefer the the original page's node for
 compressed data
Message-ID: <aAeBx9fJliZldLQO@Asmaa.>
References: <20250402204416.3435994-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402204416.3435994-1-nphamcs@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 02, 2025 at 01:44:16PM -0700, Nhat Pham wrote:
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

For the zswap/zsamlloc bits:
Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>
