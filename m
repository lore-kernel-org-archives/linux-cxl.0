Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24C41AE877;
	Fri, 20 Mar 2026 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774032593; cv=none; b=dizVVQqEpA7xL5xSWSrS7JN8q9/XMOUgWIIeifYLbyafJsJ9TZQ9gETuUZQ72VxfNaDUvtJQHwGuelSsWgvGL3iI0gzQ1/t2LJY5mqbFiwYEIlcpascnaq48XbNa2eojrkcMzWkuD0DCkMyCTifDNT0VsmFpNO/YBug7/XEob8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774032593; c=relaxed/simple;
	bh=CZPats9e/xIykQ0p6beR56p5pT3SBFNJcBRMlbIFXJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8xURTFaBe+SVg1dmpb3oD1jLe+6tAM6smE4P1t45/055N3cuq2pS4joORjLlkpZtbhZjAlJ5c/qgd/IkKIgJb7nC1drBrGCO+pJ7B38ZqU01s2VwdjcLy1kOYm+IwYTfU5orPCSUzuH88mW2MbaNDISG0dgI+TGwWN0dpQao7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgPgwcmz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgPgwcmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1EBC4CEF7;
	Fri, 20 Mar 2026 18:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774032592;
	bh=CZPats9e/xIykQ0p6beR56p5pT3SBFNJcBRMlbIFXJ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HgPgwcmzuu4IHGVR8cx6TSvo6cBfxT/Zora5SGzhglKRzYmLMnRkAp41Lu3rXXGDe
	 CQvykMQFTA/jVXGx50Krg5uoA42bhJCh4B8fAs84jFW7Qa233Fl2U4Fpj5cMp1rPtW
	 ix2NSc1xwV7NR3Ed3qcs5FwIgNYlNc59eiirnv1REb9SWMbAMEeozSLs/6tTbBoQfa
	 AsjqG2STRS1m24JkkjnL+3q2UBEIghZOY6qkRpZ/2LVckJDPQ+BYXfbAh/ZHxfFvJm
	 H0iSTwulSmW0juJMkizsWIkqiKoI22h1WLsAi9aZzdMWnNmE/adMLK3CU0n6mc3vov
	 wYcYxyl/xzwiw==
Message-ID: <306f0fd2-cba1-4f48-af05-248be2bc9506@kernel.org>
Date: Fri, 20 Mar 2026 19:49:46 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] mm/sparse: remove CONFIG_MEMORY_HOTPLUG-specific
 usemap allocation handling
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Axel Rasmussen
 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-10-david@kernel.org>
 <f23aa64a-d78f-4c57-a08b-5c589889b7fc@lucifer.local>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <f23aa64a-d78f-4c57-a08b-5c589889b7fc@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 20:48, Lorenzo Stoakes (Oracle) wrote:
> On Tue, Mar 17, 2026 at 05:56:47PM +0100, David Hildenbrand (Arm) wrote:
>> In 2008, we added through commit 48c906823f39 ("memory hotplug: allocate
>> usemap on the section with pgdat") quite some complexity to try
>> allocating memory for the "usemap" (storing pageblock information
>> per memory section) for a memory section close to the memory of the
>> "pgdat" of the node.
>>
>> The goal was to make memory hotunplug of boot memory more likely to
>> succeed. That commit also added some checks for circular dependencies
>> between two memory sections, whereby two memory sections would contain
>> each others usemap, turning bot memory sections un-removable.
> 
> Typo: bot -> both. Presumably you are not talking about memory a bot of some
> kind allocated :P
> 
>>
>> However, in 2010, commit a4322e1bad91 ("sparsemem: Put usemap for one node
>> together") started allocating the usemap for multiple memory
>> sections on the same node in one chunk, effectively grouping all usemap
>> allocations of the same node in a single memblock allocation.
>>
>> We don't really give guarantees about memory hotunplug of boot memory, and
>> with the change in 2010, it is pretty much impossible in practice to get
>> any circular dependencies.
> 
> Pretty much impossible? :) We can probably go so far as to so impossible no?

Yes.

> 
>>
>> commit 48c906823f39 ("memory hotplug: allocate usemap on the section with
>> pgdat") also added the comment:
>>
>> 	"Similarly, a pgdat can prevent a section being removed. If
>> 	 section A contains a pgdat and section B
>> 	 contains the usemap, both sections become inter-dependent."
>>
>> Given that we don't free the pgdat anymore, that comment (and handling)
>> does not apply.
> 
> Isn't pgdat synonymous with a node and that's the data structure that describes
> a node right? Confusingly typedef'd from pglist_data to pg_data_t but then
> referred to as pgdat because all that makes so much sense :)

Yeah, in general we refer to the NODE_DATA as pgdat (grep for it and
you'll be surprised).

> 
> But I'm confused, does a section containing a pgdat mean a section having the
> pgdat data structure literally allocated in it?

Yes. "struct pgdat" placed in some memory section.

> 
> A usemap is... something that tracks pageblock metadata I think right?

Yes. Essentially a large array of bytes, whereby each byte describes a
pageblock data (migratetype etc)

> 
> Anyway I'm also confused by 'given we don't free the pgdat any more', but the
> comment says a 'pgdat can prevent a section being removed' rather than anything
> about it being removed?

Well, if a pgdat resides in some memory section, given that it is
unmovable turns the whole memory section unremovable -> hotunplug fails.

Assuming you could free the pgdat when the node goes offlining, you
would turn that memory section removable.

And I think that commit somehow assumed that the last memory section
could be removed if all it contains is the corresponding pgdat (which
was never the case).

> 
> I guess it means the OTHER section could be prevented from being removed even
> after it's gone.. somehow?
> 
> Anyway! I think maybe this could be clearer, somehow :)

I'm afraid the whole purpose of the original patch was sketchy, which is
also while I fail to even explain the original motivation clearly.

Now it's fortunately no longer required. :)

> 
>>
>> So let's simply remove this complexity.
>>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> I think what you've done in the patch is right though, we're not doing any of
> these dances after a4322e1bad91 and pgdats sitting around mean we don't really
> care about where the usemap goes anyway I don't think so...
> 
> I usemap and I find myself in a place where I give you a:
> 
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> 

Thanks ;)

[...]

>> -
>>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
>>  unsigned long __init section_map_size(void)
>>  {
>> @@ -486,7 +390,6 @@ void __init sparse_init_early_section(int nid, struct page *map,
>>  				      unsigned long pnum, unsigned long flags)
>>  {
>>  	BUG_ON(!sparse_usagebuf || sparse_usagebuf >= sparse_usagebuf_end);
>> -	check_usemap_section_nr(nid, sparse_usagebuf);
>>  	sparse_init_one_section(__nr_to_section(pnum), pnum, map,
>>  			sparse_usagebuf, SECTION_IS_EARLY | flags);
>>  	sparse_usagebuf = (void *)sparse_usagebuf + mem_section_usage_size();
>> @@ -497,8 +400,7 @@ static int __init sparse_usage_init(int nid, unsigned long map_count)
>>  	unsigned long size;
>>
>>  	size = mem_section_usage_size() * map_count;
>> -	sparse_usagebuf = sparse_early_usemaps_alloc_pgdat_section(
>> -				NODE_DATA(nid), size);
>> +	sparse_usagebuf = memblock_alloc_node(size, SMP_CACHE_BYTES, nid);
> 
> I guess nid here is the same node as the pgdat?

Yes! before we used NODE_DATA(nid)->node_id, which is really just ... nid :)

-- 
Cheers,

David
