Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABBE3CA49D;
	Mon, 30 Mar 2026 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872457; cv=none; b=JlUCwstl/PZgB3K+nCYbiEvfgBw9YzxjqU5LlG1Y+G4XdzyD8Z9yfSmFvGWqfHFHXB/ySad8mi5o62Y0W2enonQ3dE4FtkB0WUb5/ZwLoUAeY8P3o4h1zDlKJWaj/IdocEr9RcT7OPiyTRQtjUwFgeg0eVsosI/uVaWR/DxV49s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872457; c=relaxed/simple;
	bh=707pXg4kFYwnKMDw1UsxIG7pl099kIwm4pedIii4hAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTR5shDiQ+oXXOUdC6OOzB3YN0hVM6Hor/dnUVbcUe1xn5YguGMIUbT3gC2kKbX4rX+sWjdganxO1Pwce7XOSC1w3ReH8Y9JhxjtDwEscvQags4lepUKJ/xR+5i3i/kBqKEKj23CW/mLl8+f86CH87ol/1OZ2l9n66RLZgxch+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hjv8PEX9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hjv8PEX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CC2C4CEF7;
	Mon, 30 Mar 2026 12:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774872456;
	bh=707pXg4kFYwnKMDw1UsxIG7pl099kIwm4pedIii4hAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hjv8PEX9pAaBGbwydHervhfg035qz+u6hQdSLmYCqE9K2f8pjFBJ0zMFPyvUv9QSH
	 ph2dmLzBDDoDkTPh2/jGvX0FG7VgMzBFrtsB5scJa9bYhkmOux/IWwm9f9tyHv+BHl
	 vw4OJrTAImUx0pOlQ8Zu6sqt9VadIu02c0YjQjDsBjt0c2+3W4hnPTrfcn1SR31N9d
	 fJGBHvu1WtpaPnUl2AoLbIGeet3rZnVcTi89Ax4UghTV9zvfTI2STvR0OdaNymchVH
	 Skjz8VOsqPGWpD9BKHdbpzZlnuksjI0lX+UJcOF+gimQB/8p1d0UiLGuG6nO0ILkaJ
	 fQX3AzZehe2kg==
Message-ID: <8b6d4c2b-91fd-4e2a-9f4b-e90cb134219e@kernel.org>
Date: Mon, 30 Mar 2026 14:07:32 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory_hotplug: maintain N_NORMAL_MEMORY during
 hotplug
Content-Language: en-US
To: Hao Li <hao.li@linux.dev>, david@kernel.org, osalvador@suse.de,
 akpm@linux-foundation.org
Cc: vbabka@suse.cz, harry.yoo@oracle.com, joshua.hahnjy@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20260330035941.518186-1-hao.li@linux.dev>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260330035941.518186-1-hao.li@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/30/26 05:57, Hao Li wrote:
> N_NORMAL_MEMORY is initialized from zone population at boot, but memory
> hotplug currently only updates N_MEMORY. As a result, a node that gains
> normal memory via hotplug can remain invisible to users iterating over
> N_NORMAL_MEMORY, while a node that loses its last normal memory can stay
> incorrectly marked as such.
> 
> Restore N_NORMAL_MEMORY maintenance directly in online_pages() and
> offline_pages(). Set the bit when a node that currently lacks normal
> memory onlines pages into a zone <= ZONE_NORMAL, and clear it when
> offlining removes the last present pages from zones <= ZONE_NORMAL.
> 
> This restores the intended semantics without bringing back the old
> status_change_nid_normal notifier plumbing which was removed in
> 8d2882a8edb8.
> 
> Current users that benefit include list_lru, zswap, nfsd filecache,
> hugetlb_cgroup, and has_normal_memory sysfs reporting.
> 
> Fixes: 8d2882a8edb8 ("mm,memory_hotplug: remove status_change_nid_normal and update documentation")
> Signed-off-by: Hao Li <hao.li@linux.dev>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks!

> ---
> Changes: simplify the code. (Thanks Joshua and David)
> ---
>  mm/memory_hotplug.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index bc805029da51..05a47953ef21 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1209,6 +1209,13 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
>  
>  	if (node_arg.nid >= 0)
>  		node_set_state(nid, N_MEMORY);
> +	/*
> +	 * Check whether we are adding normal memory to the node for the first
> +	 * time.
> +	 */
> +	if (!node_state(nid, N_NORMAL_MEMORY) && zone_idx(zone) <= ZONE_NORMAL)
> +		node_set_state(nid, N_NORMAL_MEMORY);
> +
>  	if (need_zonelists_rebuild)
>  		build_all_zonelists(NULL);
>  
> @@ -1908,6 +1915,8 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  	unsigned long flags;
>  	char *reason;
>  	int ret;
> +	unsigned long normal_pages = 0;
> +	enum zone_type zt;
>  
>  	/*
>  	 * {on,off}lining is constrained to full memory sections (or more
> @@ -2055,6 +2064,17 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  	/* reinitialise watermarks and update pcp limits */
>  	init_per_zone_wmark_min();
>  
> +	/*
> +	 * Check whether this operation removes the last normal memory from
> +	 * the node. We do this before clearing N_MEMORY to avoid the possible
> +	 * transient "!N_MEMORY && N_NORMAL_MEMORY" state.
> +	 */
> +	if (zone_idx(zone) <= ZONE_NORMAL) {
> +		for (zt = 0; zt <= ZONE_NORMAL; zt++)
> +			normal_pages += pgdat->node_zones[zt].present_pages;
> +		if (!normal_pages)
> +			node_clear_state(node, N_NORMAL_MEMORY);
> +	}
>  	/*
>  	 * Make sure to mark the node as memory-less before rebuilding the zone
>  	 * list. Otherwise this node would still appear in the fallback lists.

