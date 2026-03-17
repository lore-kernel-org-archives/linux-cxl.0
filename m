Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13121D5B0;
	Tue, 17 Mar 2026 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768150; cv=none; b=HbNtQZaTrJpx6tPTyo97zTkJrMh7y7kzT56LM+kBB8AlUyYkisajINVZck0VXCTSeLZ+N6QUWDbFaTrm8HHWJMq07mJatZPbFoPeOBYYzbmIjPhe9K1Y3w9loXgM+O7w/EDKHLqhAZajZTnAB8Stkn3WbEa20IiruW5gfQv6FY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768150; c=relaxed/simple;
	bh=CXmAL0fZMhCd313IWOg1p205CurpMDcHyDTWRrkP3T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZiNa0ezrZoeWJxlXc4KuugvHQMGD0EzGcE+doZ1N/a0O3OyO7CLReuTJ9xdV2tOKbiwixZQwWLS/BfXKxr4GSoC27sMh0UtOdq8XwA9Vgb77FhFXHp3BU6dqF2BMp1W3+08p5eYsOAYHPvcF6nYUXBoYpsjOLIf5jLWY2mjqhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqqxV3K2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqqxV3K2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0416C4CEF7;
	Tue, 17 Mar 2026 17:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773768150;
	bh=CXmAL0fZMhCd313IWOg1p205CurpMDcHyDTWRrkP3T4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZqqxV3K2taXpMWi9I62jvNQ2Nbso5h2AQWq9+9AMlJt1uQeV4Zp2+ZS8jEuqfRAL+
	 5P2lzLcgxOr49+x7RDobgdg28kMumEGpA3ZyMDGstaZSkrG5JYpbg/McqRZWAZCYei
	 73OfWn9fjHM8Bu95B1KzPK5r7ITT6SpI2BbF10Y3cnkspn7unPF+0+XRRKXtiLkJH3
	 frvYeeYaJ1JFtOWfhoW286UeyI3Mnx76+/Wo2h9CWCwMwUjldhiLVyyNNBT9LgS04E
	 Wz4AhiYhp1vyLWqOGGU3qIqIA+H/gUANoKxn+pQH3CRRy7K2uGi3JVI618ROa9d9Cp
	 BK2WzmJVxPVng==
Date: Tue, 17 Mar 2026 17:22:24 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 03/14] mm/Kconfig: make CONFIG_MEMORY_HOTPLUG depend on
 CONFIG_SPARSEMEM_VMEMMAP
Message-ID: <02b0cc59-bc6e-477e-831a-9f699b7e529a@lucifer.local>
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

Some risc-y business Dave but I believe in you! So:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

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
