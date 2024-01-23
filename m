Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D30B5676E
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jan 2024 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997610; cv=none; b=jIOSMN/cq0soZHxG/T7XUTGXEBXUOneC2eh0u+2+ujo7DlJF7g+jCJZYWvcycOThfYpz8MPWKxxpEedk+Na9G2wyMc8p5Ub5i0LqjjkS5IbaPqOdWaRw8noyHZF644vIl/f43G1OW++9PveXJntPSCQ9gl6Y5nkwJ1tgqoRhTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997610; c=relaxed/simple;
	bh=qKokgaMGTZI9qOVe6zZoOWojCxZ4OryMhrq2LZ+HhN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFdzcEblL5h2CyQu0aSp8nGcUm8L/1ivYCZcTg9PxuINfaSJ7R2TyZ+eyVrj2V9NEX8S43/ZlJKeCGkzVQR1KO1TZybsbfhJDKCu5H7/v97yP6DmoZl0y+WKsoLGIbR/jiNPCE8PqjrF5ykjX8scwtpD/MNI8Kqt51cdTFx8xfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6PdY81+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6PdY81+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C73C433F1;
	Tue, 23 Jan 2024 08:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705997609;
	bh=qKokgaMGTZI9qOVe6zZoOWojCxZ4OryMhrq2LZ+HhN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I6PdY81+HVS6cmBiWZzbzSoQLtqqZta1DmOqA4r6QdJ/E1y1V/47/aBKrBiAdHBmF
	 yq2z7um5EftZaNQQZ1/UWoDAyrUrpdqbuMgGrLhXQKDBAbfXi0GUMqoUKZ8/IwdURW
	 zAecis03W1ibkFAoNB7qwbIk4VmhTr5nkYSsMm5tAhu+1muI5XsCj3FnvMjh5GOSAB
	 hLS8BmiG7CcFVkxoW3aBxuWVRYD2tLid0HjSUBAXw44+Jfkc0D/tj3GQFm3Y/KMWhI
	 GOgo8THdwkHUrmzurbequLW7+P7w455wsCJAggYUKCQpnjTeQ2pcUg/8iK+FwEn7ch
	 i0JXuT9Cum8rQ==
Date: Tue, 23 Jan 2024 10:13:06 +0200
From: Mike Rapoport <rppt@kernel.org>
To: alison.schofield@intel.com
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/numa: Fix the address overlap check in
 numa_fill_memblks()
Message-ID: <Za91Ehzwg9JH3qPt@kernel.org>
References: <cover.1705085543.git.alison.schofield@intel.com>
 <10a3e6109c34c21a8dd4c513cf63df63481a2b07.1705085543.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10a3e6109c34c21a8dd4c513cf63df63481a2b07.1705085543.git.alison.schofield@intel.com>

On Fri, Jan 12, 2024 at 12:09:50PM -0800, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> numa_fill_memblks() fills in the gaps in numa_meminfo memblks over a
> physical address range. To do so, it first creates a list of existing
> memblks that overlap that address range. The issue is that it is off
> by one when comparing to the end of the address range, so memblks
> that do not overlap are selected.
> 
> The impact of selecting a memblk that does not actually overlap is
> that an existing memblk may be filled when the expected action is to
> do nothing and return NUMA_NO_MEMBLK to the caller. The caller can
> then add a new NUMA node and memblk.
> 
> Replace the broken open-coded search for address overlap with the
> memblock helper memblock_addrs_overlap(). Update the kernel doc
> and in code comments.
> 
> Fixes: 8f012db27c95 ("x86/numa: Introduce numa_fill_memblks()")
> Suggested by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Changes since single patch:
> - Use memblock_addrs_overlap() for address comparison (Dan)
> - Update kernel doc and in code comments
> - New commit message
> - Update commit log
> - Link to single patch:
> https://lore.kernel.org/linux-cxl/20240102213206.1493733-1-alison.schofield@intel.com/
> 
>  arch/x86/mm/numa.c       | 19 +++++++------------
>  include/linux/memblock.h |  2 ++
>  mm/memblock.c            |  5 +++--

For memblock changes
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

>  3 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index adc497b93f03..8ada9bbfad58 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -944,14 +944,12 @@ static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
>   * @start: address to begin fill
>   * @end: address to end fill
>   *
> - * Find and extend numa_meminfo memblks to cover the @start-@end
> - * physical address range, such that the first memblk includes
> - * @start, the last memblk includes @end, and any gaps in between
> - * are filled.
> + * Find and extend numa_meminfo memblks to cover the physical
> + * address range @start-@end
>   *
>   * RETURNS:
>   * 0		  : Success
> - * NUMA_NO_MEMBLK : No memblk exists in @start-@end range
> + * NUMA_NO_MEMBLK : No memblks exist in address range @start-@end
>   */
>  
>  int __init numa_fill_memblks(u64 start, u64 end)
> @@ -963,17 +961,14 @@ int __init numa_fill_memblks(u64 start, u64 end)
>  
>  	/*
>  	 * Create a list of pointers to numa_meminfo memblks that
> -	 * overlap start, end. Exclude (start == bi->end) since
> -	 * end addresses in both a CFMWS range and a memblk range
> -	 * are exclusive.
> -	 *
> -	 * This list of pointers is used to make in-place changes
> -	 * that fill out the numa_meminfo memblks.
> +	 * overlap start, end. The list is used to make in-place
> +	 * changes that fill out the numa_meminfo memblks.
>  	 */
>  	for (int i = 0; i < mi->nr_blks; i++) {
>  		struct numa_memblk *bi = &mi->blk[i];
>  
> -		if (start < bi->end && end >= bi->start) {
> +		if (memblock_addrs_overlap(start, end - start, bi->start,
> +					   bi->end - bi->start)) {
>  			blk[count] = &mi->blk[i];
>  			count++;
>  		}
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index b695f9e946da..e2082240586d 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -121,6 +121,8 @@ int memblock_reserve(phys_addr_t base, phys_addr_t size);
>  int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
>  #endif
>  void memblock_trim_memory(phys_addr_t align);
> +unsigned long memblock_addrs_overlap(phys_addr_t base1, phys_addr_t size1,
> +				     phys_addr_t base2, phys_addr_t size2);
>  bool memblock_overlaps_region(struct memblock_type *type,
>  			      phys_addr_t base, phys_addr_t size);
>  bool memblock_validate_numa_coverage(unsigned long threshold_bytes);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 8c194d8afeec..d0cadeeecfe8 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -180,8 +180,9 @@ static inline phys_addr_t memblock_cap_size(phys_addr_t base, phys_addr_t *size)
>  /*
>   * Address comparison utilities
>   */
> -static unsigned long __init_memblock memblock_addrs_overlap(phys_addr_t base1, phys_addr_t size1,
> -				       phys_addr_t base2, phys_addr_t size2)
> +unsigned long __init_memblock
> +memblock_addrs_overlap(phys_addr_t base1, phys_addr_t size1, phys_addr_t base2,
> +		       phys_addr_t size2)
>  {
>  	return ((base1 < (base2 + size2)) && (base2 < (base1 + size1)));
>  }
> -- 
> 2.37.3
> 

-- 
Sincerely yours,
Mike.
