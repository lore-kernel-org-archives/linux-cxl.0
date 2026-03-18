Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49BC36CDE9;
	Wed, 18 Mar 2026 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820515; cv=none; b=DAjYzVHHKTvZ7JsVwg1FlRxuFJ0eO0ROWDmzhcYZ4oVBszVJTWbsxgs+p8waLgCvxJbaL2BeQKKtN2E1Ly/py5Dwb1ZhNQBKNhVn54eVBkI8L4zvEXobEiWOpvHm1676WxvvWPBBLO1NSHqtZwN+1RqSyNoaeEUA9sopuowM5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820515; c=relaxed/simple;
	bh=393sZvR/gqTP0vkDNjf01M+bgmlTncpIIPSe+0jujU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuQMaSYdbo5X+q3vGGajYc7wIL/uMxoS5xSVfwhSOKFTdlfz7EENnEIdGuhi2PDg7gF1krpO7aZ/QuKW8pcQh5ZL+FmaKcUNqGHIPPYZav/x+l5KM0mg+DHWz5NnP8eJQqW4AupjvAL8q2XPjimSnVfLmyg6//ZMvC5/NSpMrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qa87uBHG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa87uBHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369B2C19421;
	Wed, 18 Mar 2026 07:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773820515;
	bh=393sZvR/gqTP0vkDNjf01M+bgmlTncpIIPSe+0jujU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qa87uBHGvCKrjka/oAwuJqQUG3jiZBm346/TSkvdTVAmDymvQKrv58X67MzKzTCLI
	 GOjv+L8f3tgf06T335Ln0r20UuvjG4fTwAfaQbMTAFp76VpkhkSsAz4v7YXaQLcW78
	 KkfRAacm47ueuWtSSvZrkjLqoKrh/cFZVA/6J0VZ/PeI+S38NdPODimoTOxeFM7GZS
	 GVo/KZ8U4ZA9yEZn5L/GzlPCOwViswc4NDtBQQZm8/69vvKmR5+XOV9tif3R0JM7Kl
	 Sv7Y4WtnDsIU0lfx6eMJfmo/X906W74olhjxCYHorRM+Ep8Yx4xnHi2tgx8BLBt/y0
	 Akxv9+WGEBu9Q==
Date: Wed, 18 Mar 2026 09:55:07 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 03/14] mm/Kconfig: make CONFIG_MEMORY_HOTPLUG depend on
 CONFIG_SPARSEMEM_VMEMMAP
Message-ID: <abpaW74xEcNMJJXU@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-4-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-4-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:41PM +0100, David Hildenbrand (Arm) wrote:
> Ever since commit f8f03eb5f0f9 ("mm: stop making SPARSEMEM_VMEMMAP
> user-selectable"), an architecture that supports CONFIG_SPARSEMEM_VMEMMAP
> (by selecting SPARSEMEM_VMEMMAP_ENABLE) can no longer enable
> CONFIG_SPARSEMEM without CONFIG_SPARSEMEM_VMEMMAP.
> 
> Right now, CONFIG_MEMORY_HOTPLUG is guarded by CONFIG_SPARSEMEM.
> 
> However, CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG is only enabled by
> * arm64: which selects SPARSEMEM_VMEMMAP_ENABLE
> * loongarch: which selects SPARSEMEM_VMEMMAP_ENABLE
> * powerpc (64bit): which selects SPARSEMEM_VMEMMAP_ENABLE
> * riscv (64bit): which selects SPARSEMEM_VMEMMAP_ENABLE
> * s390 with SPARSEMEM: which selects SPARSEMEM_VMEMMAP_ENABLE
> * x86 (64bit): which selects SPARSEMEM_VMEMMAP_ENABLE
> 
> So, we can make CONFIG_MEMORY_HOTPLUG depend on CONFIG_SPARSEMEM_VMEMMAP
> without affecting any setups.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ebd8ea353687..c012944938a7 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -472,7 +472,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
>  menuconfig MEMORY_HOTPLUG
>  	bool "Memory hotplug"
>  	select MEMORY_ISOLATION
> -	depends on SPARSEMEM
> +	depends on SPARSEMEM_VMEMMAP
>  	depends on ARCH_ENABLE_MEMORY_HOTPLUG
>  	depends on 64BIT
>  	select NUMA_KEEP_MEMINFO if NUMA
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
