Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B2A3C0613;
	Tue, 22 Sep 2026 04:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051071; cv=none; b=jWMHjI9dTUilUibroOpRbknHv4gDhPQ7/YWPX7uOoyLTpM6RH0H/hVLNAbPsz7GQg6urZVn98EPGP6BjZ7mcLhO5D/nMzSJrPxiwQpn51DbtwaQn2LcMEcIvPGkRNuDpFicVj0+k6m36q9ZMOh35xt1Ub6i7BDwxMt6YvWqyWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051071; c=relaxed/simple;
	bh=nwLT3Ldo1wB5gu/m/ecllRVClTEwW/Zux21DrKNdeSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvrorVMTV1hrXlYOpv+ZZAETG30OvPhjuw1J1sJCiizoAvemz85ievVY14xwzIpm+5KIpt+UzYFZ4PQvC5pNfJwPj8uu1HhtbLORZ0x/AEpXFs+lDKN0geyCgYA1YvRwnHIrUd7Sc71tsAwtQ91jsYKqozPGi4WyFbz8aLUntso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeBKWAdu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeBKWAdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01161F000FF;
	Tue, 22 Sep 2026 04:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790051065;
	bh=kUmTSY/Kcrd/EARta1ekGXPCkorBIVhm7Emk4UPB6UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GeBKWAduepmASI5QfstEaM87hWv2Bg3RjQMNLN3TIUIIV/q65OVgGpQHjZPX/L3F3
	 +vioQtuyHw8JiHbKfrWsFOBmPNCicGhpVx5Ec+wUqO0PAl1i5TNMaro6JG8/ZbUbxo
	 gZ4N1SdmdKSJntNnSzg+XsZqDCA+lQFOQO074S/kC0rKgLH5bleljcrSb8W3Q13R40
	 ryIKaqaB3mjJDSUVZJPHMXBXINtlYxYJBxMqrDUSwueueXzBP+GDpYJIwxzR9rJhF3
	 wsPmwnAacZU0ks5wnRxr3dFGwiboPxZ6lHxjlwkkSxEwQM4QoV9rOo1Q/AnIPnRZ+j
	 eqkxXYbnm054g==
Date: Tue, 22 Sep 2026 06:24:12 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 08/13] mm/sparse: move __highest_used_section_nr
 handling
Message-ID: <arIC7BheTHzBnLoq@localhost.localdomain>
References: <20260921-b4-sparsemem_cleanups-v2-0-54d81d65e125@kernel.org>
 <20260921-b4-sparsemem_cleanups-v2-8-54d81d65e125@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-b4-sparsemem_cleanups-v2-8-54d81d65e125@kernel.org>

On Mon, Sep 21, 2026 at 09:59:00PM +0200, David Hildenbrand (Arm) wrote:
> In preparation for removing __section_mark_present(), let's move
> __highest_used_section_nr handling into its callers. Verify in
> sparse_init_one_section() that it was properly updated.
> 
> In sparse_sections_init() we can just set it to the last processed
> section_nr.
> 
> No functional change intended.
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>

> ---
...
> --- a/mm/sparse.h
> +++ b/mm/sparse.h
> @@ -26,6 +26,7 @@ static inline void sparse_init_one_section(struct mem_section *ms,
>  	unsigned long coded_mem_map;
>  
>  	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
> +	VM_WARN_ON_ONCE(section_nr > __highest_used_section_nr);

I wonder, have we seen this in the wild?



-- 
Oscar Salvador
SUSE Labs
