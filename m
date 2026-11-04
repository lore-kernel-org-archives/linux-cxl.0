Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813016;
	b=34bWYWHXyJLIkZrLQ7+o2dWeNf1XjwZMV0F/XgZ2fNDgryfvCksiIDktlewJsYOPJnpK
	 Q3aSNYr6Z1q+Sbv3TuaExL2hRbX7iJ2WUS3EqAcNkvPysCUDVNX5X82fB98yu9EkbFMv7
	 dv0bzIl7J4U+A21wzZcnoStse26iVgDyM+O7X5ZvyV1nmhukxmLx9cG31u8q3rPdtV96E
	 bRGV0lYCquCyRJg2WcTFW9nqqlyK6eGYHFA175RkBJ65Qq9vadp2Npm5XOefjdL1g5diE
	 v6dPSz1siAJuvQtiM4WhWIZjWJb/sFuVvDIZRN6lK7M+5eSI7jf/M6EC00SWoTlufIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813016;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Jf+fsnmGIryZf3OQ6Nnm/qTexCHP5OkJmTCMajaRAPc=;
	b=DL+M5KhddnDTjNR8U08D9ifFaRSAZXpyHVIlaLTjGxAw+qAJM3ngOmtpuvNJW/tgDlR+
	 MnkXY8mX4w+I2x+7DrSPW9r0uiXHNIP8s4lLcZLuMefW41J6uz4pqJudSZctVZlC0/SYd
	 cr+vvFUVjXAFmefwEUNVpHzpjK4R+n/038vhvL7CNI4jxAl6PdQUj787S5uaWa9NcVZDH
	 VxBDqiIjM4LlLkZuYMmYswA3S2o5K9Uo1WmlTKmnrBXwaBHfBplXeM7Q/M23lTnTCXPnF
	 RmyIXsXPxt8X0LdakKnW5L0CGbZyJ5WYFm0Z+VOaZX7EtxBmkag+JQusnZtE2EFOheA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ApjvTxv+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580A606A326;
	Wed,  4 Nov 2026 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ApjvTxv+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C761F000C1;
	Wed,  4 Nov 2026 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813015;
	bh=Jf+fsnmGIryZf3OQ6Nnm/qTexCHP5OkJmTCMajaRAPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ApjvTxv+ADLbOjqM3lRPCeOqwPSRSuzNxz+D5QFXxKZEpVzQ/EFeKhrIDwv8VEdM8
	 i9RvCnt/KyKcFM8ISXIjcUxUxOfvAJL5tJLn8T3QSTU3A1m6zCq8HrIiugsso4IK8x
	 SBGDr1kxsyYCidMpPztvPalv93jum4bx40RUEvbeoD3Tj4FPlBsNeZmz/YZBU+Y7wv
	 QHNVgyMX2F+C/k+J4JEQyhmDcIwhurdn+mLvbljUR4WuBLEp8JvXhxiuoBk8utBvkD
	 6gFRFRk2JACDzEb6seZjcCs81SF8R3xvTCzbx3drnNuheB2smeO32cq+evv3RiXX42
	 MATu3FSRICB/w==
Date: Wed, 4 Nov 2026 17:23:24 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Zi Yan <ziy@nvidia.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH] mm: split out memory-failure declarations from internal.h
Message-ID: <autp6fWoGnnsPkbL@gremlin>
References: <20261104-memory-failure-split-v1-1-3b0a85f0b7e7@debian.org>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-memory-failure-split-v1-1-3b0a85f0b7e7@debian.org>

On Wed, Nov 04, 2026 at 08:45:34AM -0800, Breno Leitao wrote:
> mm/internal.h carries the memory failure declarations, but only seven
> of the 81 .c files that include it use them.
>
> Move memory failure declarations to a new mm/memory-failure.h and
> include that from those seven files that need them.
>
> Move the block as is, including take_page_off_buddy(),
> put_page_back_buddy() and page_mapped_in_vma(): they live in
> page_alloc.c and page_vma_mapped.c, but are built only for
> CONFIG_MEMORY_FAILURE and called only from memory-failure.c.
>
> Keep the declarations private to mm/.
>
> No functional change.
>
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Link: https://lore.kernel.org/all/aumt-4kfGGtoXuh-@kernel.org/
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thanks, nice to break this up a bit!

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  MAINTAINERS          |  1 +
>  mm/hwpoison-inject.c |  1 +
>  mm/internal.h        | 29 -----------------------------
>  mm/ksm.c             |  1 +
>  mm/memory-failure.c  |  1 +
>  mm/memory-failure.h  | 36 ++++++++++++++++++++++++++++++++++++
>  mm/memory_hotplug.c  |  1 +
>  mm/page_alloc.c      |  1 +
>  mm/page_vma_mapped.c |  1 +
>  mm/vmscan.c          |  1 +
>  10 files changed, 44 insertions(+), 29 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 27d5b599558ae7..cc973903fda09d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12441,6 +12441,7 @@ F:	include/linux/memory-failure.h
>  F:	include/trace/events/memory-failure.h
>  F:	mm/hwpoison-inject.c
>  F:	mm/memory-failure.c
> +F:	mm/memory-failure.h
>  F:	tools/testing/selftests/mm/memory-failure.c
>
>  HYCON HY46XX TOUCHSCREEN SUPPORT
> diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
> index a11222572f9789..07032ec63080e8 100644
> --- a/mm/hwpoison-inject.c
> +++ b/mm/hwpoison-inject.c
> @@ -10,6 +10,7 @@
>  #include <linux/page-flags.h>
>  #include <linux/memcontrol.h>
>  #include "internal.h"
> +#include "memory-failure.h"
>
>  static u32 hwpoison_filter_enable;
>  static u32 hwpoison_filter_dev_major = ~0U;
> diff --git a/mm/internal.h b/mm/internal.h
> index 3e15dcdd8af768..b9278329f9a239 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1196,35 +1196,6 @@ static inline bool node_reclaim_enabled(void)
>  	return node_reclaim_mode & (RECLAIM_ZONE|RECLAIM_WRITE|RECLAIM_UNMAP);
>  }
>
> -/*
> - * mm/memory-failure.c
> - */
> -#ifdef CONFIG_MEMORY_FAILURE
> -int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill);
> -void shake_folio(struct folio *folio);
> -typedef int hwpoison_filter_func_t(struct page *p);
> -void hwpoison_filter_register(hwpoison_filter_func_t *filter);
> -void hwpoison_filter_unregister(void);
> -
> -#define MAGIC_HWPOISON	0x48575053U	/* HWPS */
> -void SetPageHWPoisonTakenOff(struct page *page);
> -void ClearPageHWPoisonTakenOff(struct page *page);
> -bool take_page_off_buddy(struct page *page);
> -bool put_page_back_buddy(struct page *page);
> -struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
> -void add_to_kill_ksm(struct task_struct *tsk, const struct page *p,
> -		     struct vm_area_struct *vma, struct list_head *to_kill,
> -		     unsigned long ksm_addr);
> -unsigned long page_mapped_in_vma(const struct page *page,
> -		struct vm_area_struct *vma);
> -
> -#else
> -static inline int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill)
> -{
> -	return -EBUSY;
> -}
> -#endif
> -
>  extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
>          unsigned long, unsigned long,
>          unsigned long, unsigned long);
> diff --git a/mm/ksm.c b/mm/ksm.c
> index d24b129932bf79..623a2cdb392428 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -44,6 +44,7 @@
>
>  #include <asm/tlbflush.h>
>  #include "internal.h"
> +#include "memory-failure.h"
>  #include "mm_slot.h"
>
>  #define CREATE_TRACE_POINTS
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b215312f261b83..78f0a13349cb3e 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -68,6 +68,7 @@
>  #include "swap.h"
>  #include "page_alloc.h"
>  #include "internal.h"
> +#include "memory-failure.h"
>
>  static int sysctl_memory_failure_early_kill __read_mostly;
>
> diff --git a/mm/memory-failure.h b/mm/memory-failure.h
> new file mode 100644
> index 00000000000000..153aea6c610c03
> --- /dev/null
> +++ b/mm/memory-failure.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * mm/ internal memory failure declarations
> + */
> +#ifndef __MM_MEMORY_FAILURE_H
> +#define __MM_MEMORY_FAILURE_H
> +
> +#include <linux/mm.h>
> +
> +#ifdef CONFIG_MEMORY_FAILURE
> +int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill);
> +void shake_folio(struct folio *folio);
> +typedef int hwpoison_filter_func_t(struct page *p);
> +void hwpoison_filter_register(hwpoison_filter_func_t *filter);
> +void hwpoison_filter_unregister(void);
> +
> +#define MAGIC_HWPOISON	0x48575053U	/* HWPS */
> +void SetPageHWPoisonTakenOff(struct page *page);
> +void ClearPageHWPoisonTakenOff(struct page *page);
> +bool take_page_off_buddy(struct page *page);
> +bool put_page_back_buddy(struct page *page);
> +struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
> +void add_to_kill_ksm(struct task_struct *tsk, const struct page *p,
> +		     struct vm_area_struct *vma, struct list_head *to_kill,
> +		     unsigned long ksm_addr);
> +unsigned long page_mapped_in_vma(const struct page *page,
> +		struct vm_area_struct *vma);
> +
> +#else
> +static inline int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill)
> +{
> +	return -EBUSY;
> +}
> +#endif
> +
> +#endif /* __MM_MEMORY_FAILURE_H */
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 41fcdc04e54042..b0971404f0ac0a 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -40,6 +40,7 @@
>  #include <asm/tlbflush.h>
>
>  #include "internal.h"
> +#include "memory-failure.h"
>  #include "mm_init.h"
>  #include "page_alloc.h"
>  #include "shuffle.h"
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index abebfb1f202e9b..b6d9f2c9cdef53 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -57,6 +57,7 @@
>  #include <linux/pgalloc_tag.h>
>  #include <asm/div64.h>
>  #include "internal.h"
> +#include "memory-failure.h"
>  #include "mm_init.h"
>  #include "page_alloc.h"
>  #include "shuffle.h"
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index e6b6170c2f4f72..d45d52436f99a0 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -6,6 +6,7 @@
>  #include <linux/leafops.h>
>
>  #include "internal.h"
> +#include "memory-failure.h"
>
>  static inline bool not_found(struct page_vma_mapped_walk *pvmw)
>  {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 50c352e9ffefc4..3db2db65319c00 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -67,6 +67,7 @@
>  #include <linux/sched/sysctl.h>
>
>  #include "internal.h"
> +#include "memory-failure.h"
>  #include "page_alloc.h"
>  #include "swap.h"
>
>
> ---
> base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
> base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> change-id: 20261104-memory-failure-split-4c7abedbe0dc
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>

--
Cheers, Lorenzo
