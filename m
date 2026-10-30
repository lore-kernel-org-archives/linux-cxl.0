Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380517;
	b=c1Bx2w9wtP7PT9ZDdcoKPQ1R+kt+4s7ZpEjk39Ya+aBMR7S7lOhmHqgahNGITlx86jL/
	 xIZrXvI4QzFyJxRn/4vbtcTG5XmUo6BvHf4Ao/Jtt1jklqJ9J2CFECG/pZ7qKUflu1PNp
	 UJjUQDwkzzVD9eHQcu569LBFqDpZlUa6zgbBePSCWJ+qYYgCBRIlR85dma/NE+mZw83b3
	 GlsK+0mUmJYNpkZO6sxWdSjQQ4TjYqLdCh6UpzpoQ39U6sJHBvuhSbI1kiLflZcDvM6sa
	 MH9OeYaFQzgoTLEO3pOeXJJW3gWr9jgWZ2H9CHzPysIbymVQUjYd6hZ9CdsoAXzYEpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380517;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=s4lfKj1K0mW/s2L7Sgy/qf7fmtgSr6raq1ricsBA8ac=;
	b=F4bD3On8wlpbs5WL6K/cijbc6mk7wV1c3XdAEt+AKuiVTen10izzZxoVuE92nzM4VNAw
	 Bg/aEFsL0dpfO6dGohhiy1QnBu2JFmei93a2f4jX72HiICtDrR+0WuYCBx2MNaEOuQNAe
	 i50nQdFn/Fqca8t0BZW9eqNmJ0LqZZAZwStFkEsuwJN6TjNcxb5brka5rYxTJAS3NoE+W
	 D0jDlmPcamp9LBA6dGdeT/DS2afbo79bBCnAzRVTHIzVcXFWGSvIQbVVJ1MuGJ/XXLIRs
	 XeuL2kWuF7PiAGHtQVvX3TLQzIkvsgq1HOKBnZeApzrV1ogADEdhCup6djxyV9n3upQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUzBhmPJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC33606A329;
	Fri, 30 Oct 2026 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUzBhmPJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006CE1F00A02;
	Fri, 30 Oct 2026 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793380517;
	bh=s4lfKj1K0mW/s2L7Sgy/qf7fmtgSr6raq1ricsBA8ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CUzBhmPJr9eAYRositKVhICwE3c28ZkAAjS0KumWeYbRW0XPkQdPfFpUmhNzkduGf
	 eNK8cJBXkm1LcRxdgz8pbim++vUwl3Qo2Wi2u67IFCwGpc0KJW1hJgM4PL9wsWPFQ8
	 n2vgJajN9/JgJBDSNkCRUr3Ps+lLziGRn4KfYlKDlQ+Q2dM0AgRuVN0AeKmwNjLoou
	 DBKAoVd3hAzzeWjNRcM9745yIRlDvqdgJ1NKYsy5PmzcCycLrZcqyW3ha8Da9RfdED
	 qQmoCBUP0/65hIin82cHE3MyoSUOhm5iJV/Lgwvzixtexx6EGf7oiA8FZISupkzNi3
	 4d5D02eDjfIYA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 40599198003A;
	Fri, 30 Oct 2026 13:15:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 30 Oct 2026 13:15:11 -0400
X-ME-Sender: <xms:lNDkamuImIsjl-Hb9Y5yPVbFGJUSJ2YkTbfduoFzzyBJU9zxFetHMw>
    <xme:lNDkavExiGJ-vgkdZfzFxhLNhTdhym7QicbGj1KOQOxfDjsmOaza50LntODZuYjuW
    oTCuZvAWjDptGh2dRPl_hiHmmfAylPPS6hxAHR1NhFysI-fJLS0NG4>
X-ME-Received: <xmr:lNDkapA423pMVrTnw-aFqjww79eVY1slYYooZoVKAUZ_5j2dE890Pbgd3c8>
X-ME-Proxy-Cause: dmFkZTGMRFW6wwkHRR3YT/ZEaqGEmM3s/XdACkapu3EoKr46FLACqjR7K3Thpw4JePzMmg
    efUKMlli7l4jKADcUqysPC7rXWTo3hsYHN95q7KQKBB0hS2BIQ4ReFIX5pJg46qGnZeHIj
    bAM5c7zHLm1wlrOFZO/hvF/gM1Hi3h2fg4ArYsNqb9BHlobWTRKUbrfNiAlALH4kz/HLFT
    22veRLEf/VUYXdArHteMiDkSfTJI5lxN84Jbw5/XkTUVbHRwfdNMh6O9KPIRhA16SYy/2h
    VplmIiPi0J6XsEMZXbvYp0xNB16fhKfQeo5VIG13ZPS1nPnH3WXL1vFmZPgI5a43gwebLd
    1QCkS61BanvTvpCFk5Uba1eb3YhkPf89SQKfmvmtUPhoWRI0oksjeXpevdv7fyK7pYk6z3
    sPwgoOguaX7V4NETkGOzkJxhRVtfa1iYoBV17bKhJ3JKBGkENt7Bb9rtwzX9X48TpJ3FMg
    RiTgTIyy6IUPbP+cOSc8nQLp6znFG9wAxt3tjXwoNsVUC2MaYAd9ZvSb0k2qO8ooUcjvko
    wP+8NiCmzXNvb1kihY7Cb6icraE0ycDmt27hE6CQuqXQZU1PY9+6OTefhgwvPq9ACoV2Ct
    c26sah+C6kmiElOI+lSyNoY0Ql0YWwX+drZljpEOs/SRovpQukfpjYQvAMZg
X-ME-Proxy: <xmx:lNDkamK_3xdLFI2j9ne9t6fJjXYd1OjImERMgH0j8v-jsitvEKrnMg>
    <xmx:lNDkar5co8fUMQE80BkdKKzbpQ1N_HMq8FlD5AjWBbVyDf9BktqaSA>
    <xmx:lNDkam3Y50Gp444UM859DwrQVODdGKeCxEz7XRaENTsldtzUtBTtWQ>
    <xmx:lNDkahjMWZx2j4GxFA2FoF0_jnQTMClJIpXa8dWSQs69ovj50BHgTQ>
    <xmx:lNDkajPJKjKzhIorpxlSxBCSjnEddyKszhFHgdWuKDKxBwVhcGC3Hw_s>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 13:14:58 -0400 (EDT)
Date: Fri, 30 Oct 2026 17:14:57 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 43/47] mm/huge_memory: split huge PUDs when adjusting
 VMA boundaries
Message-ID: <auTQhAuyokuSPX-D@thinkstation>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-43-a64ce7f83abb@kernel.org>
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
In-Reply-To: <20261029-fixes_core-v2-43-a64ce7f83abb@kernel.org>

On Thu, Oct 29, 2026 at 09:33:38PM +0100, David Hildenbrand (Arm) wrote:
> PFN mappings such as VFIO PCI BAR mappings can use PUD leaves while
> allowing VMA splits at page granularity. However, vma_adjust_trans_huge()
> only handles PMDs.
> 
> After faulting a writable PUD-sized VFIO BAR mapping, changing its first
> page to read-only with mprotect() makes the PMD walk treat the PUD leaf
> as a PMD table. Applying MADV_DONTFORK to the first PMD-sized chunk leaves
> the PUD spanning two VMAs: the PMD-aligned boundary skips splitting.
> 
> Walk the page tables once at each adjusted boundary and split a huge
> PUD or PMD leaf as needed. Handle PUD leaves even when the boundary is
> PMD-aligned.
> 
> Fixes: f9e54c3a2f5b7 ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
