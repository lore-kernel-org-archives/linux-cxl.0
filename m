Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB922D9484;
	Wed,  1 Jul 2026 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887946; cv=none; b=fwf/ddy5KxBUxlOUU6/c+EMVVPuQ/kXWcYk8F6b+LwqIi94NUjgJ4Xsp0RcBf3yUj1kUnEzx36pczS33ZRxDn4PwUikggGr0kdx0dA+wE5Slc6XkLcIviN96uh353yOse8Kd5I4U7qR6mINyK0q3Hgzs1Wb1q40sLt076/wVeRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887946; c=relaxed/simple;
	bh=bYnbcpZoiE0CNARdzMCA3Q9VkOjJutkcNEhuQX3colI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kk2eyVhZb9yTlQetxnvTkKcE2jSVG9O3y6Wmljpep7ogruo8wix+8AmZcWuZ3SGCdXhKr0nZ1YApMpqGgya1e0rPJ7qqRl/Go5dcJARNgh5a8pB1/zD+phEp0QQ6iCLESXGn5wDELLeH/56aPBKP45KHct/sRAww2zDOV0D4BiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDgHPV32; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDgHPV32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4333C1F000E9;
	Wed,  1 Jul 2026 06:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782887945;
	bh=BvTLplorYjpSosfCkdCvJzwq/acoHPalJN2rlKGRoVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bDgHPV32AfnOA8tw27tWvIXqOB1SK0Mw1obz6QAL91FB2/8WIiMsDeDPTFHflGYUO
	 Xxl+HpJeRej3CgZYBbGb16a82nK3zijlC81Owhxp5XPLUfPbPqQv+TXDnMpGPN7Rdg
	 acW+rs3XGOZ9cUEr//0lg7VzCTCiAE9zWoBZeBwHyl8LhZ7hFkC3CjGDKyMnzP0T6m
	 Nd8I44uarM0v19lVNo9c+B1+rDl4uJGAJnTA3P+soFHqiQig6NsUavR7C+sFNCadZ6
	 vdL01HrPpO7S7FdmiNm153lHhg1cITFA2OT7wtFGnbfd5pDQsu7mtowRMdCFXQgV39
	 pURQxKVwWgMpg==
Date: Wed, 1 Jul 2026 09:38:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, kernel-team@meta.com, david@kernel.org,
	osalvador@suse.de, akpm@linux-foundation.org,
	mgorman@techsingularity.net, hannes@cmpxchg.org, vbabka@kernel.org
Subject: Re: [PATCH] mm/mm_init: handle alloc_percpu failure in
 free_area_init_core_hotplug
Message-ID: <akS2AYLzOzlJ8tIO@kernel.org>
References: <20260630214039.2263562-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630214039.2263562-1-gourry@gourry.net>

On Tue, Jun 30, 2026 at 05:40:39PM -0400, Gregory Price wrote:
> We miss a failed allocation check for pgdat->per_cpu_nodestats, which
> results in a NULL deref when we offset into the per-cpu area.
> 
> Propagate -ENOMEM up the stack and leave per_cpu_nodestats pointing
> at boot_nodestats so a later online can retry the allocation.
> 
> hotadd_init_pgdat() returns NULL on failure, which __try_online_node()
> already maps to -ENOMEM.
> 
> Assisted-by: Sashiko:unknown-model

I suppose it's rather 

Reported-by: Sashiko <sashiko-bot@kernel.org>

> Fixes: 75ef71840539 ("mm, vmstat: add infrastructure for per-node vmstats")
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  include/linux/memory_hotplug.h |  2 +-
>  mm/memory_hotplug.c            |  3 ++-
>  mm/mm_init.c                   | 14 +++++++++++---
>  3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 7c9d66729c60..f04b915678db 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -289,7 +289,7 @@ static inline void __remove_memory(u64 start, u64 size) {}
>  /* Default online_type (MMOP_*) when new memory blocks are added. */
>  extern enum mmop mhp_get_default_online_type(void);
>  extern void mhp_set_default_online_type(enum mmop online_type);
> -extern void __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
> +extern int __ref free_area_init_core_hotplug(struct pglist_data *pgdat);

Nit: we are trying to get rid of 'extern's in the headers, even though it
makes the declarations inconsistent.
Can you please drop the extern since you anyway changing this?

>  extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
>  extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
>  extern int add_memory_resource(int nid, struct resource *resource,
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 7ac19fab2263..8b137328dcf0 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1263,7 +1263,8 @@ static pg_data_t *hotadd_init_pgdat(int nid)
>  	pgdat = NODE_DATA(nid);
>  
>  	/* init node's zones as empty zones, we don't have any present pages.*/
> -	free_area_init_core_hotplug(pgdat);
> +	if (free_area_init_core_hotplug(pgdat))
> +		return NULL;
>  
>  	/*
>  	 * The node we allocated has no zone fallback lists. For avoiding
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 306ea5c13f54..37fd64ce144d 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1536,7 +1536,7 @@ void __init set_pageblock_order(void)
>   * NOTE: this function is only called during memory hotplug
>   */
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
> +int __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
>  {
>  	int nid = pgdat->node_id;
>  	enum zone_type z;
> @@ -1544,8 +1544,14 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
>  
>  	pgdat_init_internals(pgdat);
>  
> -	if (pgdat->per_cpu_nodestats == &boot_nodestats)
> -		pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
> +	if (pgdat->per_cpu_nodestats == &boot_nodestats) {
> +		struct per_cpu_nodestat __percpu *p;
> +
> +		p = alloc_percpu(struct per_cpu_nodestat);
> +		if (!p)
> +			return -ENOMEM;
> +		pgdat->per_cpu_nodestats = p;
> +	}
>  
>  	/*
>  	 * Reset the nr_zones, order and highest_zoneidx before reuse.
> @@ -1583,6 +1589,8 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
>  		zone->present_pages = 0;
>  		zone_init_internals(zone, z, nid, 0);
>  	}
> +
> +	return 0;
>  }
>  #endif
>  
> -- 
> 2.53.0-Meta
> 

-- 
Sincerely yours,
Mike.
