Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3133D4E9;
	Wed, 30 Sep 2026 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786788; cv=none; b=BAIUgkxnK5jTGDrPGwJnpgEoVwmHLvWYFavZnb0lPJDE2fYJWLoAzhbnwLHHQdDZ2lJ2DJuNa28dSNWqMovDxYCHXaKBPHL0gtSwesBvw6/J3OAoYAgA9o3OcVE1D+hJ4QzH+rJkbmK24rZvmVgxMeW7sl2EErF3igZaxOSqEAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786788; c=relaxed/simple;
	bh=9Ye/2uPBM5l23jTZ7szq8OrrIihr83041xy3JF7nfx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itVc1a8VjNNGm5SpP06ax6omNR5vVAC1zaALvcU1YT9BJ5sIPaSnwVlH5uuKc8A6m8BmExzYls0LLMMFGiJYByze/4fTyduaZKAg+A4WQVcOdz4+hC0B1t81zTv9TBldRuOI3Z9c5WVBV1v5nbuJz5LVO31qF4pro9hn9sTPCZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbpZZvN1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbpZZvN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC1D1F00893;
	Wed, 30 Sep 2026 16:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790786786;
	bh=xMQrpTVfG24oup9/xVlbB5NV7FVEZ7+5pDyeSSmpyfs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cbpZZvN1V4yJhr0654j0pNRf6FbcuIx6mTMvt1ROw6G9X1SImEmMDOJ8lH1jBsd7o
	 PCYd8QZSQxPI3rWir6g0spJlEVytWn5Aj0Z9YDz+Zs0RjPHXjxWwZPO+Gh+7AoQRT2
	 2Pazx6lAvyFTAezAxSfnddj4eTjun3C5nXk3/h/unfXMMJA1HapLsKbUObn0MyoMX+
	 ZyyEwpScnoo3K1x1ZcyOlP+WsdL9Bmall51adOCKtDYfcGY+wrBESCcFjoj3xY1Gok
	 CCMlpYOTN8a6Iy3/fVzKtd3gBDKV426pk/v88DTkF1VbsHtNukMjCw3fGlvxjCtPbz
	 vKUfzJ2aNbdOg==
Message-ID: <d4fac8af-fd71-47a2-bfe9-3c6559b92209@kernel.org>
Date: Wed, 30 Sep 2026 18:46:21 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/memory_hotplug: fix missing rollback in
 __add_pages()
To: Lance Yang <lance.yang@linux.dev>, osalvador@suse.de
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260930160432.5564-1-lance.yang@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260930160432.5564-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/26 18:04, Lance Yang wrote:
> __add_pages() returns on a sparse_add_section() failure without removing
> the sections already added in the same request.
> 
> For memremap_pages(), the failed range is not counted in pgmap->nr_range,
> so memunmap_pages() skips it. The sections already added in that range
> retain their vmemmap mappings and subsection bits. Retrying a
> section-aligned range can then fail with -EEXIST.
> 
> Save the initial PFN and remove [start_pfn, pfn) on failure. For a vmemmap
> population failure, section_activate() already cleans up the current
> section, so the rollback excludes it. If the first section fails,
> __remove_pages() receives an empty range and does nothing.
> 
> Link: https://lore.kernel.org/all/BAD58999-1EDD-4A37-ABA0-DB1BD8AB3453@linux.dev/
> Suggested-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
> No Fixes tag, as I couldn't identify the commit that introduced this issue.
> 
>  mm/memory_hotplug.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 796af1028ee2..ca4656698148 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -380,6 +380,7 @@ EXPORT_SYMBOL_GPL(pfn_to_online_page);
>  int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  		struct mhp_params *params)
>  {
> +	const unsigned long start_pfn = pfn;
>  	const unsigned long end_pfn = pfn + nr_pages;
>  	unsigned long cur_nr_pages;
>  	int err;
> @@ -413,8 +414,11 @@ int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  				   SECTION_ALIGN_UP(pfn + 1) - pfn);
>  		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap,
>  					 params->pgmap);
> -		if (err)
> +		if (err) {
> +			__remove_pages(start_pfn, pfn - start_pfn, altmap,
> +				       params->pgmap);
>  			break;
> +		}
>  		cond_resched();
>  	}
>  	vmemmap_populate_print_last();

Makes sense and LGTM.

Do we have a Fixes: tag? It probably dates back quite a while ... not sure about
stable, we never saw this in practice. But if it's easy, we should just do it?
(not sure if we ever had __remove_pages be limited to hotunplug support)

I'm planning on picking this up and sending it for the next merge window (so not
as a hotfix).

Looking at this ...

x86 does not really expect add_pages to fail:

	ret = __add_pages(nid, start_pfn, nr_pages, params);
	WARN_ON_ONCE(ret);

That's probably something to clean up as well?

-- 
Cheers,

David
