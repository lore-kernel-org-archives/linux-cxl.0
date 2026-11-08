Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794156371;
	b=TsoYcMqquvfgtbRNtcSyVqSHOgLr+fIwFQKVpVPYm3bxWZ7q3kyrA1A5nsPnSwikGw4e
	 kRTPXy1jEqkVZ1Ksg8JZhQYoEqd4U4Y2mMV04ssF51/JurdUEnnE98A4PyQX3kzgEknxj
	 lOlKE5BLK2s49Bz+xEMKgW3Cv7LRXRCXfalixvk7qkrYYd1OdFd9hjDg2ckIL+OVSoQkA
	 cUVfgHYG1TBxZ7B2pVcO/2vS7DhVi9hqKUs6rIuNYVL74RtweoTYJ8CkaC3EPskVSgTS3
	 I4usy8AxkpBMHWp1sd3rYHhBmYqJLCx6YBIpNHT+qWxXxSGnKwj30PSLj0WMBK1D9Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794156371;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KTpoKtd3vzCAsB1dOMCmLm3Zvf15E1/w6LHbWorVquo=;
	b=Cwox7FAi52O0SJliMVXCGZx9TIfrq3y9kko3YfUL6U8maCqqsWxXwlPMwYaxZ9Blxt/S
	 SsP9mOG+P+7czQKGZ7N1o6eqeEZBPYtVh7o1UWgQvGhq+Cwmz+zaoULO6zGps67F5pi5L
	 sDV2IstavJlkcjkYgCJGroJSrVEsJxsatBlnX6bNQhEsr6Mi36VWXUqTAYbSs6hr61gcz
	 RvEfVlAfBLo3m37DpbG54vJy0GH0i00/QaQLvigoIpwpSoDvQxgJKSUPkbIPp6DV+VAyb
	 rDde19KVp2efMax2L7YqKKvjir3IoEEA5sT3vMutHNndhwapfQmIh/kyL8KTZyzWsxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWhYI2ps;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCF3606A320;
	Sun,  8 Nov 2026 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWhYI2ps
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93871F0089F;
	Sun,  8 Nov 2026 16:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794156371;
	bh=KTpoKtd3vzCAsB1dOMCmLm3Zvf15E1/w6LHbWorVquo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NWhYI2psVTCKqIZTsbwQtjzBFvbmwGZuvVNRCMiWmXne3KAdYAP6TMQ8kVVCDDw0z
	 1BFzQamYFbWzlaysWhiE0ke7fEJHwlGU4cLDrxRLS2uI1cwmzFKHFclV7SN2tDte9v
	 4V681jLFcelMdVrdEQdNM3qTOlAbiQo3Bh3xEp6jJhmwQ1PofLERefIkIHBBxkeH6S
	 XWbVnImzTDxTQhPLYaTjvh8D6LyMRlf52GUaA0swMFUPU9VNb45DrePqNaIz7Aw07S
	 uu/7N+XzRel7BwdEmU9Dl2vQBVN7yoQXd1VdzTtM58ojog/chB7vEi4X0th8O13kqf
	 NAJAHZCPx1TZw==
Date: Sun, 8 Nov 2026 16:46:09 +0000
From: Harry Yoo <harry@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Lance Yang <lance.yang@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] x86/mm: Tear down the direct map when memory hot add
 fails
Message-ID: <avCnM5AwhuvToFwP@minisforum>
References: <au_l5MRyDbYfsUVe@chrisdown.name>
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
In-Reply-To: <au_l5MRyDbYfsUVe@chrisdown.name>

On Sat, Nov 07, 2026 at 07:00:52PM -0800, Chris Down wrote:
> arch_add_memory() sets up the direct map before calling add_pages().
> If add_pages() fails, the range stays mapped and any page tables
> allocated for it are leaked. A later hot add can reuse the stale
> mapping.
> 
> Remove the direct mapping on failure.
> 
> Fixes: 45e0b78b0532 ("[PATCH] hot-add-mem x86_64: use CONFIG_MEMORY_HOTPLUG_RESERVE")
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---

Looks good to me,
Acked-by: Harry Yoo (Meta) <harry@kernel.org>

>  arch/x86/mm/init_64.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 8b6d86fb5a42..846cb34b38dd 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -989,15 +989,23 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
>  	return ret;
>  }
>  
> +static void __meminit kernel_physical_mapping_remove(unsigned long start,
> +						     unsigned long end);
> +
>  int arch_add_memory(int nid, u64 start, u64 size,
>  		    struct mhp_params *params)
>  {
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
> +	int ret;
>  
>  	init_memory_mapping(start, start + size, params->pgprot);
>  
> -	return add_pages(nid, start_pfn, nr_pages, params);
> +	ret = add_pages(nid, start_pfn, nr_pages, params);
> +	if (ret)
> +		kernel_physical_mapping_remove(start, start + size);
> +
> +	return ret;
>  }
>  
>  static void __meminit free_pagetable(struct page *page)
> 
> base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd

-- 
Cheers,
Harry / Hyeonggon
