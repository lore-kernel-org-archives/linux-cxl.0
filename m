Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EB33F825B;
	Mon, 14 Sep 2026 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379175; cv=none; b=fgZKESLUffj8YArByJsbB3Nc4dFztdIyIJp/M8fYEUbGvgqXoeSMcsJ2o16E06Ym5XhxsTUhzLcOZKSFHIfAUjH8xACWVpm8MEl5WR6VO+BuplIvDTWHgkdWc06IyMKlBwwWqjbgM66ZktTCCuzjt/XRyjOiPUGfaUNebAB6p7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379175; c=relaxed/simple;
	bh=doZxfhpF6hvf0gcxK7uRWwyRWA+MJzUVsTcoo96jtag=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=h1U+UtFVXj+s6M/F1WFn8eWXDz0UxGldhZYHbRq6ZmgBEE2KLfPvfdJS5nOUn52oRWrzzeY861gJ3kjJMncrsaKfjGXbYFHsIPOYe7mjWdWD0CsaiDmkTg43LRmaNbZzZDHgOqe9AYDNs3boWQCMw4W+GGYeRQJWnyhVYaqGI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoSdDPpd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoSdDPpd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEDD1F000FF;
	Mon, 14 Sep 2026 09:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789379173;
	bh=/w/yGurtybehOwgo3KZ5MtwGNopaX2l3ZWxQhrI/85Y=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=PoSdDPpdW32kxBczwsKCrd5toPOsoIyhPcPK9FiUfGkj3x5y0v+SAosM+sn1cnDum
	 o25n96uPkUuGm029v1FSIAaIFNGwsKSE8Vb6kK4Y9yyJZh7yChPVBiR2j44yBszqy6
	 JP0a6pKr6Z1buyENK3qx0dh9Qki64F5P3Tyl3hply3f01IVFpKWer+YCMfg4w6zJGN
	 Fmoe15bYffq8L4eom5ZuV/gKwhuM0MsDYBfgReyUMKCHel9Dj7DgtQN006rLmQRQQ1
	 Y7oafEqq5E/ldoHhGaj4k0iKCxD62L+jMME8zge0K3eerMm0gKFowRRpt1FAJwlFYJ
	 yP44ZVUvsctfw==
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 08/12] mm/sparse: move __highest_used_section_nr
 handling
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Oscar Salvador <osalvador@suse.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-8-008fc8d579fe@kernel.org>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-8-008fc8d579fe@kernel.org>
Date: Mon, 14 Sep 2026 12:45:42 +0300
Message-Id: <178937914266.4188640.2229667310976793135.b4-review@b4>
X-Mailer: b4 0.17-dev

> Let's move it to sparse_init_one_section(). However, to keep early
> boot processing working, we also have to initialize it in
> sparse_sections_init().
> 
> Should we use READ_ONCE/WRITE_ONCE with __highest_used_section_nr?
> Probably, something for another day.

Surely not in sparse_sections_init() ;-)

> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 2b41ae36f20b8..2d0f2db34f4cf 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -177,7 +177,7 @@ static inline unsigned long first_present_section_nr(void)
>  
>  void __init sparse_sections_init(void)
>  {
> -	unsigned long pfn, start_pfn, end_pfn;
> +	unsigned long pfn, start_pfn, end_pfn, section_nr;
>  	int i, nid;
>  
>  	sparse_extreme_init();
> @@ -187,9 +187,9 @@ void __init sparse_sections_init(void)
>  		mminit_validate_memmodel_limits(&start_pfn, &end_pfn);
>  
>  		for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> -			unsigned long section_nr = pfn_to_section_nr(pfn);
>  			struct mem_section *ms;
>  
> +			section_nr = pfn_to_section_nr(pfn);
>  			sparse_index_init(section_nr, nid);
>  			ms = __nr_to_section(section_nr);
>  			if (ms->section_mem_map)
> @@ -201,6 +201,7 @@ void __init sparse_sections_init(void)
>  			__section_mark_present(ms, section_nr);
>  		}
>  	}
> +	__highest_used_section_nr = section_nr;
>  }
>  
>  #ifndef CONFIG_SPARSEMEM_VMEMMAP
> diff --git a/mm/sparse.h b/mm/sparse.h
> index 7c5d82ceb7142..a3af4967fd5c5 100644
> --- a/mm/sparse.h
> +++ b/mm/sparse.h
> @@ -97,6 +97,9 @@ static inline void sparse_init_one_section(struct mem_section *ms,
>  
>  	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
>  
> +	if (section_nr > __highest_used_section_nr)
> +		__highest_used_section_nr = section_nr;
> +
>  	/*
>  	 * We encode the start PFN of the section into the mem_map such that
>  	 * page_to_pfn() on !CONFIG_SPARSEMEM_VMEMMAP can simply subtract it
> @@ -114,9 +117,6 @@ static inline void sparse_init_one_section(struct mem_section *ms,
>  static inline void __section_mark_present(struct mem_section *ms,
>  		unsigned long section_nr)
>  {
> -	if (section_nr > __highest_used_section_nr)
> -		__highest_used_section_nr = section_nr;
> -
>  	ms->section_mem_map |= SECTION_MARKED_PRESENT;
>  }
>  

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

