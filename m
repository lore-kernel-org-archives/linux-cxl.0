Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF536B056;
	Wed, 18 Mar 2026 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822850; cv=none; b=knYsHoGgzxO182bET27xTF4pXSCGLPFnoBNmUUHp7QBc9Kg8gNj9MeRItJwGc1fZfOEqNV2KvPoXaP2mZPN7orD/A9hc8tUoeohBXTEmNGTgpEKdBVNse8hBAcw4Yan6dqjn1k6+R2h3gsDwxbv3UUM0s84SFFVobhnY/PDkv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822850; c=relaxed/simple;
	bh=ZzFleRXrNFkpynaqPdY/YosKojmZPLThpwZ+pBJV9FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jebOzwlforgZHEqleiuKOXt8gUwyLUSM2dM+OSAohglhGickvsquLNeXZkPLGw7ywPZQSA11S02oy8Qa+sM+/MkuVeBXVeSYESKdTtokqNpPP6hmGpfeN9BYymtZIxBaDtY6Ta9K1KJAhlHIK1Ig1ERoK6Kq2ytcyLgQ6oGcmZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tx6xdKdn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tx6xdKdn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261AFC19421;
	Wed, 18 Mar 2026 08:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773822849;
	bh=ZzFleRXrNFkpynaqPdY/YosKojmZPLThpwZ+pBJV9FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tx6xdKdntAjvd7zE1xx0i/755mKqecG8zfCeb9yA6qg4bILeyQ/h0kUS2/5MwMpbS
	 nF8Bu6Jk1u8LDaZoODu9BxV0GCpYF9N3g5DvU9gZR9NPcOorLdNDqr7kbMqnWiea7w
	 BFzvbSdhNsD/8a51s5GiNRNiUKeI3EUO49KHTptG1brdZ+2wbEOGP24kJegQj9G+ZZ
	 e5FdJsHN/EAubdH3Pd3z5UwnADXx7X4136xXfg+ZnugM9ZaLqwIZzweuMdgoNeKBD2
	 Hs9NqodI6fPKRQp6WVzzrb3dmiS7eoryorSfPN+PO8XpHTySird+IyC/CyTAbXSi3m
	 KT21E8nwgxgBQ==
Date: Wed, 18 Mar 2026 10:34:02 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 09/14] mm/sparse: remove CONFIG_MEMORY_HOTPLUG-specific
 usemap allocation handling
Message-ID: <abpjeswfbBeDi6e6@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-10-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-10-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:47PM +0100, David Hildenbrand (Arm) wrote:
> In 2008, we added through commit 48c906823f39 ("memory hotplug: allocate
> usemap on the section with pgdat") quite some complexity to try
> allocating memory for the "usemap" (storing pageblock information
> per memory section) for a memory section close to the memory of the
> "pgdat" of the node.
> 
> The goal was to make memory hotunplug of boot memory more likely to
> succeed. That commit also added some checks for circular dependencies
> between two memory sections, whereby two memory sections would contain
> each others usemap, turning bot memory sections un-removable.

                            ^ typo: boot
> 
> However, in 2010, commit a4322e1bad91 ("sparsemem: Put usemap for one node
> together") started allocating the usemap for multiple memory
> sections on the same node in one chunk, effectively grouping all usemap
> allocations of the same node in a single memblock allocation.
> 
> We don't really give guarantees about memory hotunplug of boot memory, and
> with the change in 2010, it is pretty much impossible in practice to get
> any circular dependencies.
> 
> commit 48c906823f39 ("memory hotplug: allocate usemap on the section with
> pgdat") also added the comment:
> 
> 	"Similarly, a pgdat can prevent a section being removed. If
> 	 section A contains a pgdat and section B
> 	 contains the usemap, both sections become inter-dependent."
> 
> Given that we don't free the pgdat anymore, that comment (and handling)
> does not apply.
> 
> So let's simply remove this complexity.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/sparse.c | 100 +---------------------------------------------------
>  1 file changed, 1 insertion(+), 99 deletions(-)

-- 
Sincerely yours,
Mike.
