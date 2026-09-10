Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27F3491599;
	Thu, 10 Sep 2026 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048169; cv=none; b=lEJyTZPuAbdSSSqmiT2JEn2pAadLSEKMRisapzNgHE8P9aSsLoT+DfFv/ofktg+aUElRCOplziEYzg1SY35ss9CTPPGVpIsxR5kjY1LKHqazlevVXbtnQfE9A3Y40/oJklvOfUt4t8CCaRzk9vEXB2D/p5I6PBXOKZ8kIHmWVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048169; c=relaxed/simple;
	bh=7jaj462MPzWR+VaWdahbxElg/CrYHIPk6g2ORrdACJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQV8O65+Egiueo5PzYnNlPhGX6UHU5nocdvHjasjqAsz0kd89konE2QgyeOy1yFXwCBDwM6gI9nfDTenIZPiZXAUSjLq5v/er81ZdT8rBaw6Qm7k2N00VWsrEichBVDrUHR68SF6UJ3nIJPNOHYaLsXKoWB7Okex6TqJbfYDBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcbMv5HU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcbMv5HU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641111F000FF;
	Thu, 10 Sep 2026 13:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789048167;
	bh=5eiED4lktihRCka1cpBIZQtpj9dVf8rEIp3TOrCkPJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VcbMv5HULK77wKP10az3KO1TW0kA3G3vAfTUVtHNR03Hdoa7haoUf4pCR3cFXhWrE
	 4j+uXc1G+57DHUNYWzgfdEXQJOpolS7qzy+zwne9JC1Mejgowo2KM9PI37pqNUojCU
	 dwhB8Ini6jeGGeOX1J+8L8X9n05gUoqJuXj+p6vvKuj4Eg3sdXlCoxwSqDwca1/pvO
	 x377dWI82QkTiIUApht+mf1wUio10voVaQ0MyaldZtat05gWSvJ/QkogBrb48c6pL0
	 cTLY/SGEQ03uBmmNz9tZge9yeWyAZYZvXferAgQnnjYrsoPCtMN7pbcq+yWO/p8ajp
	 Kio/7QXCPzuJw==
Date: Thu, 10 Sep 2026 14:49:17 +0100
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
Subject: Re: [PATCH 06/12] mm/sparse: rename __highest_present_section_nr to
 __highest_used_section_nr
Message-ID: <aqK08thev5LJYQnX@gremlin>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-6-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-6-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:32:59PM +0200, David Hildenbrand (Arm) wrote:
> In preparation for getting rid of SECTION_MARKED_PRESENT, rename
> __highest_present_section_nr and clarify the comment.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Seems reasonable so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/mmzone.h |  6 +++---
>  mm/compaction.c        |  2 +-
>  mm/sparse.c            | 12 ++++--------
>  mm/sparse.h            |  4 ++--
>  4 files changed, 10 insertions(+), 14 deletions(-)
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
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
