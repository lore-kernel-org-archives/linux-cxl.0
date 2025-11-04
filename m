Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0F1A9FB6;
	Tue,  4 Nov 2025 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276700; cv=none; b=q8WVLSsAZaPHhb65EfVhuxYPMRAxjZ2pLhhYb/gRrmw8+Td9qGqaBlV/X/slnQUpZzxnhw5FG3X3WRnfgaW0s45W5oIep/JT3V/+j5GnziCB8S84+cFBxtq54SBs5PHeELAud4Jb2lGxjE2kyXQOb9nBEB/mUcfot47q8HrqHws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276700; c=relaxed/simple;
	bh=EoYB0PWVLIGHWL/t+m2DAhQWSJ/AvI+O/9iELKKU8B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUCpmKNMpEqg5m0acKN3CrRcf6HhE1sUn96xXhIkdQQSIxbZvdFvQqiiFN3LsjEOJwDJY57aeFKyxGeye8mjQPNak5D0i5Co78/Nbt2HSnNXEpvcdu0DjqQA3tcWDoHN8mOy/LPQBPRchSCSEeA7IHHrdJauQRAvX5D51uQND2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjnPMOIP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjnPMOIP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7A6C4CEF7;
	Tue,  4 Nov 2025 17:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762276700;
	bh=EoYB0PWVLIGHWL/t+m2DAhQWSJ/AvI+O/9iELKKU8B8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LjnPMOIP5C99X8WAMf59MwKO6YCUExvkThrlOsLYDyQBSyKMQd6tFJV0zwILESpQw
	 BErK7G4mTNIlhxRXMh8vbTiNZW348f2u1L8NrZr5ChgAGhSJKPoUg1bX8PYNVoXiO8
	 BU9pcso8wGIEnUgfxusuTsAtA6jbdzDOoTjU4xORAnAo5W4xHjl6GoqLX1xntagMOR
	 DQZ6FpWCWysWc5yxTjhP/IQHGa5iXdHhnSihzM+UsF+o2hdhQz82vgeiHvfbwiLsTK
	 iAEI/MPclxreW/sCxtpbg11wTkJgs4Ky0+cK57+2jQsAI5ylO0PhbqTIbataBQlldi
	 SoZjoWi/U/KaQ==
Date: Tue, 4 Nov 2025 19:18:14 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, akpm@linux-foundation.org
Subject: Re: [PATCH] memblock: fix memblock_estimated_nr_free_pages() for
 soft-reserved memory
Message-ID: <aQo1VjjQw1OZG8nY@kernel.org>
References: <20251104003921.9707-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104003921.9707-1-akinobu.mita@gmail.com>

(added Dan Williams)

Hi,

On Tue, Nov 04, 2025 at 09:39:21AM +0900, Akinobu Mita wrote:
> memblock_estimated_nr_free_pages() returns the difference between the total
> size of the "memory" memblock type and the "reserved" memblock type.
> 
> The "soft-reserved" memory regions are added to the "reserved" memblock
> type, but not to the "memory" memblock type. Therefore,

@Dan, do we really need to memblock_reserve() the E820_TYPE_SOFT_RESERVED
ranges?
Quick scan didn't show anything that requires this, but I could easily miss
something.

> memblock_estimated_nr_free_pages() may return a smaller value than
> expected, or if it underflows, an extremely large value.
> 
> /proc/sys/kernel/threads-max is determined by the value of
> memblock_estimated_nr_free_pages().  This issue was discovered on machines
> with CXL memory because kernel.threads-max was either smaller than expected
> or extremely large for the installed DRAM size.
> 
> This fixes the issue by improving the accuracy of
> memblock_estimated_nr_free_pages() by subtracting only the overlapping size
> of regions with "memory" and "reserved" memblock types.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  mm/memblock.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e23e16618e9b..af014fa10a44 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c

...

> @@ -1826,7 +1842,22 @@ phys_addr_t __init_memblock memblock_reserved_kern_size(phys_addr_t limit, int n
>   */
>  unsigned long __init memblock_estimated_nr_free_pages(void)
>  {
> -	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());

We have memblock_reserved_kern_size() that tells how much memory was
reserved from the actual RAM. Replacing memblock_reserved_size() with
memblock_reserved_kern_size() will omit "soft-reserved" ranges.

> +	int memory_idx, reserved_idx;
> +	struct memblock_type *memory_type = &memblock.memory;
> +	struct memblock_type *reserved_type = &memblock.reserved;
> +	struct memblock_region *memory_region, *reserved_region;
> +	phys_addr_t phys_mem_size = 0;
> +
> +	for_each_memblock_type(memory_idx, memory_type, memory_region) {
> +		phys_mem_size += memory_region->size;
> +		for_each_memblock_type(reserved_idx, reserved_type, reserved_region) {
> +			phys_mem_size -= memblock_addrs_overlap_size(memory_region->base,
> +					memory_region->size, reserved_region->base,
> +					reserved_region->size);
> +		}
> +	}
> +
> +	return PHYS_PFN(phys_mem_size);
>  }
>  
>  /* lowest address */
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
