Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51310483BD9;
	Thu, 10 Sep 2026 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051322; cv=none; b=gXMpKpVoesGOH/+xOd5OqOQCq6XsIH5teqNje9XsYVza5Iw/wJFF5Gz0K+RPgFBIxcqWTTcF4VxF+dmZUpSRV9F7XcbbuwGY1Z+w4MsCWLAePGtV9o9UjgtGKY/yKqb7yCZ5YM+kGh8S22NZEmFOc24FGPa87IF9pmik7EVmnPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051322; c=relaxed/simple;
	bh=bXnkLTnssSsY9ddGTL62eQdAZhx+1qqBasXCrl5e9Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2q3L7QOcYGQ4wENn3T5l+eLaRBJacRxBGpY203dt1JBJARBkOpbNV3yfoVhstqFd7dAGl2FOeceQwBPYyL4aTjYyiX5PdcuFD1Kz/spW7NFawSjaQxX9jymKWrFfqRO83uOmknVdCbUEFFynfAdRhbB2j32Ag4qrDQnB5iuMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nckwhsbx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nckwhsbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7721F00899;
	Thu, 10 Sep 2026 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051320;
	bh=AC2aVlJGfM8BolgFPYicq3jFdCi6ZcStjOJlfIZLYLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nckwhsbxifazypO4vMSW527cot3mVYyWVuVZnS2y9QbRQSzX58sMrbJUtkltcSehy
	 54OcQSYm0JA9oGJgLHLeKRygrkgimIc6WV6T66RYGyAEAcMTlHocy2tTmElNoS7jFl
	 bGSKek6YA30XoMC+vBx+2s6glRBX7BaqZ9OWguQqtOQ3HyLp6OjlWZSNeqpPpflYJz
	 1TmPI8aA3QdMbUjfoLoQyh6bHd1VDJsWvjQFvhE3JdimnnvZALWl4zyKJZgpt339C5
	 fSNBG9AQujVw7zaJk1hSUo0AUypE2bFCTyY7NIZ1qg/elrO5df8RFpMzNlQ3JdUWmu
	 z9ghuwZPMAuIA==
Date: Thu, 10 Sep 2026 15:41:51 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Oscar Salvador <osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/12] fs/proc/page: clarify comment in get_max_dump_pfn()
Message-ID: <aqLBc20gZyDfkhdH@gremlin>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-11-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-11-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:33:04PM +0200, David Hildenbrand (Arm) wrote:
> pfn_to_online_page() will only succeed on some PFNs within the same
> section, not necessarily all. Let's make that clearer.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Nit on comment below, but LGTM so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  fs/proc/page.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 260772b20bd99..6856ff3e3cf28 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -31,10 +31,9 @@ static inline unsigned long get_max_dump_pfn(void)
>  {
>  #ifdef CONFIG_SPARSEMEM
>  	/*
> -	 * The memmap of early sections is completely populated and marked
> -	 * online even if max_pfn does not fall on a section boundary -
> -	 * pfn_to_online_page() will succeed on all pages. Allow inspecting
> -	 * these memmaps.
> +	 * If max_pfn does not fall on a section boundary, pfn_to_online_page()
> +	 * can succeed on PFNs beyond max_pfn within the same section. Allow
> +	 * inspecting these memmaps.

'Allow inspection of' these memmaps is clearer I think. But this odd turn of
phrase existed before this change also :)

>  	 */
>  	return round_up(max_pfn, PAGES_PER_SECTION);
>  #else
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
