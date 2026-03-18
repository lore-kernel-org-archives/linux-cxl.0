Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7985366DCD;
	Wed, 18 Mar 2026 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820592; cv=none; b=tvN4fTQ5ieFaQrQVPpdiNPl2d6Bwa4a9ylVDqpvrWwkc5hklBHKIbSefJl/QPvcXQzTF5TWYZNhOXYREne3QbDwbuKOmdyTTjK9ELrTzLxmppirdyMwPBH0l4fBHYluXruh8RhK4dtwyDB7wsccABdY6uBl+aLWvNSOspO5p92c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820592; c=relaxed/simple;
	bh=9jejaz+AfFnqq6JpVMn1TYNKOJRTQE4855NDxxP8lrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiqVzmKTDyWbsN6AMctfOglYZOqMFBt1ODIw8xzlCxpHQLnyhbVS+CBfNWntDTTmea6s0gBOcL5xlL+9nk9L9BJvKK7qZ1X/JLiD71iLdVw1H+Uca1vuqIoZi7eBEvHc58CLmub6enYgfHMCNUGodROC7+hyOyqa78oqhaQcH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMGLEx+p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMGLEx+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66C1C19421;
	Wed, 18 Mar 2026 07:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773820592;
	bh=9jejaz+AfFnqq6JpVMn1TYNKOJRTQE4855NDxxP8lrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMGLEx+pXhoSwtF/2neEVc/1IRuLQwGViRE8LWPQ7WHfJwf2r+WRvNK8lXRPaYLGa
	 c+11alu1GD28Ktc5XEGPAvKDn7Yhea5jKTEsRmPES+QgPzhBxTBjSpPC4Jk89+fxoH
	 z2XsncGWZCILxRpUi5aNBYAUkwbRJs9+hR6x71XsLXODmYJblugtlhECQt9rwBayRX
	 tu6+cw2GQabrXON/sNcq1ydFRKiZg11GlyVfSE+TXxipx92j1Bi6ac82zQ0c4EtUFE
	 eunNwJogJK9jyJyJcALqh1MokMAnAClYG4HFB9PuAhJgAk5M4Ell/1Xd0tlk0E1qkR
	 BEmo3L5SUKHTw==
Date: Wed, 18 Mar 2026 09:56:24 +0200
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
Subject: Re: [PATCH 04/14] mm/memory_hotplug: simplify check_pfn_span()
Message-ID: <abpaqInBszasyflO@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-5-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-5-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:42PM +0100, David Hildenbrand (Arm) wrote:
> We now always have CONFIG_SPARSEMEM_VMEMMAP, so remove the dead code.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/memory_hotplug.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 3495d94587e7..70e620496cec 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -320,21 +320,13 @@ static void release_memory_resource(struct resource *res)
>  static int check_pfn_span(unsigned long pfn, unsigned long nr_pages)
>  {
>  	/*
> -	 * Disallow all operations smaller than a sub-section and only
> -	 * allow operations smaller than a section for
> -	 * SPARSEMEM_VMEMMAP. Note that check_hotplug_memory_range()
> -	 * enforces a larger memory_block_size_bytes() granularity for
> -	 * memory that will be marked online, so this check should only
> -	 * fire for direct arch_{add,remove}_memory() users outside of
> -	 * add_memory_resource().
> +	 * Disallow all operations smaller than a sub-section.
> +	 * Note that check_hotplug_memory_range() enforces a larger
> +	 * memory_block_size_bytes() granularity for memory that will be marked
> +	 * online, so this check should only fire for direct
> +	 * arch_{add,remove}_memory() users outside of add_memory_resource().
>  	 */
> -	unsigned long min_align;
> -
> -	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
> -		min_align = PAGES_PER_SUBSECTION;
> -	else
> -		min_align = PAGES_PER_SECTION;
> -	if (!IS_ALIGNED(pfn | nr_pages, min_align))
> +	if (!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION))
>  		return -EINVAL;
>  	return 0;
>  }
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
