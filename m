Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8811C493D4F;
	Thu, 10 Sep 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048043; cv=none; b=LsQjpCnxls7QICZbCpX0+Q1ZzqvKqv5AeWIH9UMeAqbjcj/fRPuDj+86OUgrrEFGPzO1bbioOb8xmgjJeaVlfLx4xaPHMpL6pMEpA1F+4L6o6djzqSXCVB+2RNINIGht3OR2fQIOItawRGt1ohdgeMI0XZhpa+xncBMVRk15Ct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048043; c=relaxed/simple;
	bh=eBYSTgTBbHKz5rjcxXY+DBFdE8Y9u5uXwLuNhVY9U0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSZj07jajgLmRJdndxx93ypqlxzrk/E+Xh19dPoxEpsQAV1kM0ATyQIGEFXuEJtDmflJu/EOL3FJ54fh58y5VOvuBejBUF71sPNJMONmGy8jSO66SE6O6tCo8W4iSLp6n5w52OjBJt15lDMZY5bzxzfvBrR3S+PnkZuDsxEpQcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpDpTI0n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpDpTI0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AE81F000FF;
	Thu, 10 Sep 2026 13:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789048042;
	bh=yGj0BrYPE8EmTQ0FkWSh78rcazbQbcVMpoC/ICtX5as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TpDpTI0nquWOR1pQ4gD5SUd//vGPzMhuMt85T/pc33ZJY3LT6b1oqCZBm7Zp+dedL
	 CBD18gZruLBEQuJpOyyHmsD+9NNHiQOqcLruyK+jI522j65AYD3xHsZ2gK3J+uaYmr
	 vH0kdPjMpH3GT+kEqH+zJzF3tRvh3gCyyUToXwvhtNDRUXFa7tg8+4hiRSOqJW80nq
	 RwxasCIfodl/E8Kh7bk33kpJC9hxtP92wYGdehbIzBJN6K2BOh/CVP8NyVOiNsJ+mz
	 PuvFZFbby3DD7Km1MIye4pec7V49Z3Yik7EnB6xJ8yZ+Zgzw6jhLmdrw7cZWVKScgC
	 9YvoJz0ryaW5w==
Date: Thu, 10 Sep 2026 14:47:12 +0100
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
Subject: Re: [PATCH 05/12] mm/sparse: cleanup sparse_init_one_section()
Message-ID: <aqK00SOP_XfGR9PR@gremlin>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-5-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-5-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:32:58PM +0200, David Hildenbrand (Arm) wrote:
> Let's avoid the "pnum" terminology.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Yup it's gross! LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/sparse.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/sparse.h b/mm/sparse.h
> index 049272aba84e5..744ae29002f5e 100644
> --- a/mm/sparse.h
> +++ b/mm/sparse.h
> @@ -90,7 +90,7 @@ void sparse_sections_init(void);
>  int sparse_index_init(unsigned long section_nr, int nid);
>
>  static inline void sparse_init_one_section(struct mem_section *ms,
> -		unsigned long pnum, struct page *mem_map,
> +		unsigned long section_nr, struct page *mem_map,
>  		struct mem_section_usage *usage, unsigned long flags)
>  {
>  	unsigned long coded_mem_map;
> @@ -102,7 +102,7 @@ static inline void sparse_init_one_section(struct mem_section *ms,
>  	 * page_to_pfn() on !CONFIG_SPARSEMEM_VMEMMAP can simply subtract it
>  	 * from the page pointer to obtain the PFN.
>  	 */
> -	coded_mem_map = (unsigned long)(mem_map - section_nr_to_pfn(pnum));
> +	coded_mem_map = (unsigned long)(mem_map - section_nr_to_pfn(section_nr));
>  	VM_WARN_ON_ONCE(coded_mem_map & ~SECTION_MAP_MASK);
>
>  	ms->section_mem_map &= ~SECTION_MAP_MASK;
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
