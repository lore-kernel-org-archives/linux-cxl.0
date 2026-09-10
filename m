Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2F328610;
	Thu, 10 Sep 2026 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047844; cv=none; b=qlcotDtEMX8f08Fp2hrkxCqMOO69fF/oP5xQV4oKnK9Uwh7xoIPNL2AKum/iJa5FG4UtBH5iZVyRCWl+6mvdzoDI3xD5J6NOZx6f6/CGV1ZWBbt4Df8+bGjk7PGnCXRY8GVyNYGnc1D2d0gEI6R7KUoRNb/58HwAucrRr0C+v9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047844; c=relaxed/simple;
	bh=XnVqWCdpz/jLWaZXkxaUGPhBA5tNcEitcQucAS4b4WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJzB6oVu7TN7qfc8WtemFCmytGcd30MoLL+uOnbgXmoegbmBJxOGVpJEJkt1pvqTCXOR84GGG8ERfc4SEjS8bc330pPL2ym6N1mDhE848K42haD8HHe4uxRscVcyiaeEPidJJE8fsgrdX9U2Y3bpyg7dlI3rnuQEWNVAa98OLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvz9goRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvz9goRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD331F000FF;
	Thu, 10 Sep 2026 13:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789047843;
	bh=IF7M+11q+QECLEteqxbNDabGoO0k0KfVFRmy1+hacIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tvz9goRETXsoBH88n/XwxRH7uEZwVgWZml8GL3eYS51YzdH9NIzgyZztJZIXqjTMa
	 ncz6dlvqeXkE5IZweicBq0YTMz0+VVpbN6R++P/ntujkGJHqeXmJg1s5n7HkXeYTu0
	 HGqwjwPVGk+MwNUyqShd7SzXBlY1da//0T1KyO+FgbmbL8BiTsN5XWOeruvei/PTLf
	 pO5ajcD07dyduWDapbbuBL0Y9/PMoKRYlejIf9zEG5Y2ZwQr9OPL6ab6ryoC4okAIa
	 9+Ra2A+1xP2kwFFofz43vWoooWziI0Kwe28C8wIuf6pM++hyKnCPp3OBSiDkkudQkA
	 IR86yvw89VACg==
Date: Thu, 10 Sep 2026 14:43:53 +0100
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
Subject: Re: [PATCH 03/12] mm/sparse: move initialization of section metadata
 to sparse_metadata_init()
Message-ID: <aqKzPw763WQR9eCf@gremlin>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-3-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-3-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:32:56PM +0200, David Hildenbrand (Arm) wrote:
> Let's move the code responsible for initializing sparse metadata (usemap,
> memmap) into a helper. Cleanup the variable while at it (e.g.,
> "map_count").
>
> Drop the rather obvious code comments.
>
> No functional change intended.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Similar comment to last, the move screws up the diff a bit, but staring at
git-delta it looks ok and the renames are good so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/sparse.c | 43 ++++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 36e3d854febc5..a85a9c3840f6c 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -257,38 +257,39 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
>  	}
>  }
>
> +static void __init sparse_metadata_init(void)
> +{
> +	unsigned long start_section_nr = first_present_section_nr();
> +	int nid_begin = sparse_early_nid(__nr_to_section(start_section_nr));
> +	unsigned long section_nr, nr_sections = 1;
> +
> +	for_each_present_section_nr(start_section_nr + 1, section_nr) {
> +		const int nid = sparse_early_nid(__nr_to_section(section_nr));
> +
> +		if (nid == nid_begin) {
> +			nr_sections++;
> +			continue;
> +		}
> +		sparse_init_nid(nid_begin, start_section_nr, section_nr, nr_sections);
> +		nid_begin = nid;
> +		start_section_nr = section_nr;
> +		nr_sections = 1;
> +	}
> +	sparse_init_nid(nid_begin, start_section_nr, section_nr, nr_sections);
> +}
> +
>  /*
>   * Allocate the accumulated non-linear sections, allocate a mem_map
>   * for each and record the physical to section mapping.
>   */
>  void __init sparse_init(void)
>  {
> -	unsigned long pnum_end, pnum_begin, map_count = 1;
> -	int nid_begin;
> -
>  	if (compound_info_has_mask()) {
>  		VM_WARN_ON_ONCE(!IS_ALIGNED((unsigned long) pfn_to_page(0),
>  				    MAX_FOLIO_VMEMMAP_ALIGN));
>  	}
>
> -	pnum_begin = first_present_section_nr();
> -	nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
> -
> -	for_each_present_section_nr(pnum_begin + 1, pnum_end) {
> -		int nid = sparse_early_nid(__nr_to_section(pnum_end));
> -
> -		if (nid == nid_begin) {
> -			map_count++;
> -			continue;
> -		}
> -		/* Init node with sections in range [pnum_begin, pnum_end) */
> -		sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
> -		nid_begin = nid;
> -		pnum_begin = pnum_end;
> -		map_count = 1;
> -	}
> -	/* cover the last node */
> -	sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
> +	sparse_metadata_init();
>  	sparse_init_subsection_map();
>  	vmemmap_populate_print_last();
>  }
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
