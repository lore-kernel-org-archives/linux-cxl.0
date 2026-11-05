Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864313;
	b=O+CdD/e9mnvuVYs7f9ad1XopD3yIqUL5llNB8Onh8SNxtfitTUZx81vijoJx5Spjrhr2
	 vxbOMrBXYkcxRf8UPrjPMa5mzQF0+z1VOggc0PqXYjnhGRhEnuXFXIP2dwWxxM4jRcqBv
	 KwfrSu0qO93Q8zcySZ/yqD8n1lIuHsyobUfQzs8AC4tUl+zx4pp63Ap3VQXZX02o1D0Nu
	 6w7J3owzFqG9q7haEd+d+hZ0KgTZuhFW37152IGrX6JFAivVIv0s3s0jTffHqPt9tTvAf
	 Xl5cBP88uRgTYvD5US88zPIM7tQdzdw4uT1W31bS7vETvsvQ7jAsqJnHtoExM2n9ETw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864313;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WtxZIHT7OSRlVekSLEKMKnbDe94Yb+d+zJ7oVfsal88=;
	b=pixJ7/G5TrSu1IemALZHNMwTtI7G8Yy+gTx4AA5wmhr947AX+PR0d6HM/rhtyRhcQsXI
	 N8lkTklvCF3sjVn+KgTgB/pL/ts1/ytBY/9Pvsht4rBpTTqtDJJd5Li1Bh/qJBIJ1/vHc
	 HM5/rJ3nty/PAullbRWRT0uRLIWRmP+majy9E7rbM6tAtrOm1ibrreUgGOTFBGMiBc8RP
	 LWS2MwUHb8WFus4yPHRl1z5nL6tC7oasyP3bm/XuRZIDx4tlt/IOYf9X/OIcLua2IoYyA
	 rc6j22BlB85q4514OTVwmOC1hyUA8z4sPqeUwbOEpNm4oZh0ToJ7Hxh7rlrWKcs5yxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STk28X0f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A2606A31B;
	Thu,  5 Nov 2026 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STk28X0f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9173B1F000C1;
	Thu,  5 Nov 2026 07:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793864312;
	bh=WtxZIHT7OSRlVekSLEKMKnbDe94Yb+d+zJ7oVfsal88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=STk28X0fF6Y909TJuiOHUWcubijSHv9nAkp7aeBbfatLxW3q3DdEJaPDaTpMInw4h
	 e1snbhiu48GpKc00lTPFIrmHdv8Bw6prdaZHWXbjYw2qUTAQ+Bf8rJCxuVyol7DAnU
	 pij1fHUfR5rzYK2AKZZiP79iXkCz8iNyjbC2rCrpPCy+PrrfiKdWlJJrHl99RBG5dc
	 uTFcrvw93TpcQEFs1pEg04FlYOSngrezMHDSlvY1c1vdM67z4BfSOA4Ir6DD1LGM0v
	 uZO5MWs11lVV6DMHl8g/0fOApbMcLt7wvE4Il7iKqSrOEih5hDnYiYvhXI1XrIwrOv
	 nPHmRmaMwxNpA==
Date: Thu, 5 Nov 2026 09:38:19 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: split out memory-failure declarations from internal.h
Message-ID: <auwya6Y_jAkTmt79@kernel.org>
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

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

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

-- 
Sincerely yours,
Mike.
