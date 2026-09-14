Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C4421255;
	Mon, 14 Sep 2026 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379168; cv=none; b=aYIJDZl2XCgkHs5s8Q0ZlTNVjC60T3KEHVc7vqcv3C7ALj4dO94GH8LCFMg5CQdWzTUD9Uxy67gWR2tKmUjNqQWevQ+GcxEVzvPUZ55/ocWGF7v7LCrLKvSUdp8aFn5VaGCGj7tijIS5iJcQofR4iPlaAFHzqkQLAd71tkyjeSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379168; c=relaxed/simple;
	bh=ZbuZBm82CFlU9iA/tOxeh9ndtaxDoH0iGKc0a8dkFGg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=U392ZUY5nd4031+nDYja3awO7jOavkMjJNGIn4XQfVkLZ7mj0OG4ZcO4WP5VWFXRaTwiCVzfv1UdnrkkOsSL7Qn8bYHcVsz6qz7q+fkScTmvYFBh/RPsYPKdnii2PWn9qb879A3YKLhkQuMY1880On5BveXWP3Ng8sRhYKV1X2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lByBiBS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lByBiBS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562DC1F00893;
	Mon, 14 Sep 2026 09:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789379166;
	bh=NKRrOy7tbwvzlXx8P1r3kZeDknPM56bdaGruTZ5Yf0U=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=lByBiBS5exlTNY8E5U3nWhjR0DH3wzJKzpcDwuNhKi0vt3+3lFsf8aLxuC/4i0e4G
	 d4DQYJzaM0B4ZWSDO3H954E80KqDFcwlSqHU1zrE1rbaIZ0R4PGfNubDSKMbPVWsex
	 2mifhLkrYxt839BjAsk0hPi7h/OYLYxft4ARIIyOSJQY1Hays/3Xu6lJ9eI8CnRTgX
	 J9VjCigVIh2yvvl6P7xJMMddyeLE5/4kUosHkk3UWBUrwzQD60Kk7lrEQdtWy+UK12
	 dEYI4ktxxbsvD5+EaawtC/hQGisx7QjisQ87yxKxu2tvPNfPyLOv6NfAYIN2cfXDoy
	 tRbmsj2lPLUhA==
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 06/12] mm/sparse: rename __highest_present_section_nr
 to __highest_used_section_nr
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
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-6-008fc8d579fe@kernel.org>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-6-008fc8d579fe@kernel.org>
Date: Mon, 14 Sep 2026 12:45:42 +0300
Message-Id: <178937914266.4188640.6188797346240816067.b4-review@b4>
X-Mailer: b4 0.17-dev

> In preparation for getting rid of SECTION_MARKED_PRESENT, rename
> __highest_present_section_nr and clarify the comment.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index c9ae7991a8b20..19296e8ef44f8 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -2170,7 +2170,7 @@ static inline struct mem_section *__pfn_to_section(unsigned long pfn)
>  	return __nr_to_section(pfn_to_section_nr(pfn));
>  }
>  
> -extern unsigned long __highest_present_section_nr;
> +extern unsigned long __highest_used_section_nr;
>  
>  static inline int subsection_map_index(unsigned long pfn)
>  {
> @@ -2269,7 +2269,7 @@ static inline unsigned long first_valid_pfn(unsigned long pfn, unsigned long end
>  
>  	rcu_read_lock_sched();
>  
> -	while (nr <= __highest_present_section_nr && pfn < end_pfn) {
> +	while (nr <= __highest_used_section_nr && pfn < end_pfn) {
>  		struct mem_section *ms = __pfn_to_section(pfn);
>  
>  		if (valid_section(ms) &&
> @@ -2324,7 +2324,7 @@ static inline int pfn_in_present_section(unsigned long pfn)
>  
>  static inline unsigned long next_present_section_nr(unsigned long section_nr)
>  {
> -	while (++section_nr <= __highest_present_section_nr) {
> +	while (++section_nr <= __highest_used_section_nr) {
>  		if (present_section_nr(section_nr))
>  			return section_nr;
>  	}
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 4994e200bbecd..f1b2060eb2016 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -216,7 +216,7 @@ static unsigned long skip_offline_sections(unsigned long start_pfn)
>  	if (online_section_nr(start_nr))
>  		return 0;
>  
> -	while (++start_nr <= __highest_present_section_nr) {
> +	while (++start_nr <= __highest_used_section_nr) {
>  		if (online_section_nr(start_nr))
>  			return section_nr_to_pfn(start_nr);
>  	}
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f84bfceb53060..2b41ae36f20b8 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -164,15 +164,11 @@ static void __init mminit_validate_memmodel_limits(unsigned long *start_pfn,
>  }
>  
>  /*
> - * There are a number of times that we loop over NR_MEM_SECTIONS,
> - * looking for section_present() on each.  But, when we have very
> - * large physical address spaces, NR_MEM_SECTIONS can also be
> - * very large which makes the loops quite long.
> - *
> - * Keeping track of this gives us an easy way to break out of
> - * those loops early.
> + * Looping over all memory sections is expensive, especially if NR_MEM_SECTIONS

... all possible ... maybe?

> + * is large but only a fraction is actually used. Keep track of the highest
> + * section number we ever used.
>   */
> -unsigned long __highest_present_section_nr;
> +unsigned long __highest_used_section_nr;
>  
>  static inline unsigned long first_present_section_nr(void)
>  {
> diff --git a/mm/sparse.h b/mm/sparse.h
> index 744ae29002f5e..7c5d82ceb7142 100644
> --- a/mm/sparse.h
> +++ b/mm/sparse.h
> @@ -114,8 +114,8 @@ static inline void sparse_init_one_section(struct mem_section *ms,
>  static inline void __section_mark_present(struct mem_section *ms,
>  		unsigned long section_nr)
>  {
> -	if (section_nr > __highest_present_section_nr)
> -		__highest_present_section_nr = section_nr;
> +	if (section_nr > __highest_used_section_nr)
> +		__highest_used_section_nr = section_nr;
>  
>  	ms->section_mem_map |= SECTION_MARKED_PRESENT;
>  }

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

