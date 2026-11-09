Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216887;
	b=WrAKZ9z/s0wPD0G7L4i1ABRDHGWC8xsaQQMXG+9qwulF4AM32PfwcBEbtmZsDgVlQfIz
	 WDKKkt+YIgvvFz5PhFtoUp+TECpGqTzzlQ1BXD3qAwyXi7ZDJCsgIIHqnVWipiFLuL/oJ
	 3nD3clX/yeiWyvSQ97uF3fGYVdxuV7lW+/CgSHwW3eRmbIT6VkPKFBrgTpUqWJU+Td0u+
	 m3QwLoGI8hTvFy3WREpYVFcYQLrt+sz55ao+vPstG6SSz+fKJAMO7BbvoZX5CYks0B4BH
	 yscHKekeyGnsLWGYfN1zsOC2w3/QZxZjFgu4Bkz2pLLh1siX2u1KDZD9rjAMIi8k+MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216887;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=55l1Yi3/+9u2aa4ZkVBG+syyKZx18Z3AHTa0nn0P3GY=;
	b=ej7e3yDkzHODzM+pUhtHekvkin/rJH3WmDwVCrWI/OK3TUZ31umWQqyFXuWfgAfZI2NZ
	 KDK8r7tjl5IODBxaP+u9aioE+UFa5vDdTc+BgkY9OZNDjrUE1NB2Jej0OwF0u2T2uQCuQ
	 VxC+hckJF85ZmCnMqIN01gptuEw6fAcNg3n3KUuQNLPxhsO1aNa2gMO2tzjL6+jxhOhlV
	 gGMg5Hq2UoH2F0pxWqpLcjZZgXyfaZUUTkhVuOBnG6E45cY3sKMyP/Q8fBnIjehzMPJln
	 gsqosbmqeu0nrD/1V6sxdIRDwzLk/V+yMjbApxjR79pBBRUS25jcQv0/KnYmyyOiWew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PAKPj+SG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229F6606A322;
	Mon,  9 Nov 2026 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PAKPj+SG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DFC1F0089F;
	Mon,  9 Nov 2026 09:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216886;
	bh=55l1Yi3/+9u2aa4ZkVBG+syyKZx18Z3AHTa0nn0P3GY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PAKPj+SGQl3aG/CeH9fXlfLUbnAxIPlZc1msI20KN+wlX+JG0RGt69iXH19/tCsAX
	 O3XaCZg4CnSY/fLoVXR3BifCv9lGApl89zUuYDhhvWJaHi2dKWwToksvlJiHXpV2fj
	 jH3NliNw4GZzA2wNg9xPX7CARO1sotYR2SZZTP8kC3mmKABRqNsQ1P0w7bccgQxS/E
	 7Pdls3zIivgKtwteEHDVxXEMehWINLsIxWmKwdFZ3lSJ3NiX1inXZKNCfGJ4h8/wjr
	 7EOJ0qumw+xhBazQoJcIVQs2gd3fSoEFj1EQRVTjJcZXrN36BGncltuuVQ2US0VpFN
	 3IU6u6ddqdWWA==
Message-ID: <4bfb6533-1e77-4150-9626-437678b1785d@kernel.org>
Date: Mon, 9 Nov 2026 10:34:39 +0100
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: Tear down the direct map when memory hot add
 fails
To: Chris Down <chris@chrisdown.name>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Lance Yang
 <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <au_l5MRyDbYfsUVe@chrisdown.name>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <au_l5MRyDbYfsUVe@chrisdown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/26 04:00, Chris Down wrote:
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

I thought we fixed that already, but I remembered

https://lore.kernel.org/all/20260930160432.5564-1-lance.yang@linux.dev/

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
