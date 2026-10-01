Received: from mta1.migadu.com (out-49.mta1.migadu.com [95.215.58.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B83C10B9
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790834285; cv=none; b=OjMe5eWU9oSAFdoPviHQAlD/NrSAh+3qacBZWJvWVNBjGjJkg4cD3hYIlILk/e2B7vM3iEISwtR7J9FkByYjodzF4uwQCSDqQSEl4YvpzMtfE9evhIiWiwb6ZIbKSahK7I8IPFwelDBTcRZaJgxYJiFEJxwdGZY18FGA9C95Jx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790834285; c=relaxed/simple;
	bh=k+5EwW1tfy7CuX+mU/60zb86Q3x+eOGt8f79gc1ysI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1EFbF5F6OHMx1KMV855r/c5hYvFfaaS7D9NmNzWAXbEc/yqMIHHUrnmgxjA7nmwlEsYy769yWJUJNAHpCwPJbueA4rGs7tqcwUS/SaEsXpEUAf+g3Lz5y3I37NLcBUnB0iNMCylbdttFTX9zT3R0zhrlj5Lr2N5w8wStYIZPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hY8nET0W; arc=none smtp.client-ip=95.215.58.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hY8nET0W"
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=k+5EwW1tfy7CuX+mU/60zb86Q3x+eOGt8f79gc1ysI4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790834279; v=1; x=1791439079;
 b=hY8nET0WZa50lHGk55aBYF2RB3IiYqeZPzLLTqGxXNPqz3y+tuaIpplNc2lETAL4P7iBcbaU
 K07bdUdow2NPb3++6Pm4XPCbhqcDWSQG7CXjUVMaxil/hlb3gPUCSwDvNB3qhiRrk7fvKG3Va3R
 DNwhWgVQSImoNoqmDmtIs834=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2c64a44a8353d810;
	Thu, 01 Oct 2026 05:57:58 +0000
X-Mizu-Trace-ID: 2c64a44a8353d810
X-Migadu-Flow: FLOW_OUT
Message-ID: <aee7af40-3da6-479e-8e0b-881497df9c49@linux.dev>
Date: Thu, 1 Oct 2026 13:57:49 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/memory_hotplug: fix missing rollback in
 __add_pages()
To: "David Hildenbrand (Arm)" <david@kernel.org>, muchun.song@linux.dev
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, osalvador@suse.de,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260930160432.5564-1-lance.yang@linux.dev>
 <d4fac8af-fd71-47a2-bfe9-3c6559b92209@kernel.org>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <d4fac8af-fd71-47a2-bfe9-3c6559b92209@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/1 00:46, David Hildenbrand (Arm) wrote:
> On 9/30/26 18:04, Lance Yang wrote:
>> __add_pages() returns on a sparse_add_section() failure without removing
>> the sections already added in the same request.
>>
>> For memremap_pages(), the failed range is not counted in pgmap->nr_range,
>> so memunmap_pages() skips it. The sections already added in that range
>> retain their vmemmap mappings and subsection bits. Retrying a
>> section-aligned range can then fail with -EEXIST.
>>
>> Save the initial PFN and remove [start_pfn, pfn) on failure. For a vmemmap
>> population failure, section_activate() already cleans up the current
>> section, so the rollback excludes it. If the first section fails,
>> __remove_pages() receives an empty range and does nothing.
>>
>> Link: https://lore.kernel.org/all/BAD58999-1EDD-4A37-ABA0-DB1BD8AB3453@linux.dev/
>> Suggested-by: Muchun Song <muchun.song@linux.dev>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>> No Fixes tag, as I couldn't identify the commit that introduced this issue.
>>
>>   mm/memory_hotplug.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 796af1028ee2..ca4656698148 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -380,6 +380,7 @@ EXPORT_SYMBOL_GPL(pfn_to_online_page);
>>   int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>>   		struct mhp_params *params)
>>   {
>> +	const unsigned long start_pfn = pfn;
>>   	const unsigned long end_pfn = pfn + nr_pages;
>>   	unsigned long cur_nr_pages;
>>   	int err;
>> @@ -413,8 +414,11 @@ int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>>   				   SECTION_ALIGN_UP(pfn + 1) - pfn);
>>   		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap,
>>   					 params->pgmap);
>> -		if (err)
>> +		if (err) {
>> +			__remove_pages(start_pfn, pfn - start_pfn, altmap,
>> +				       params->pgmap);
>>   			break;
>> +		}
>>   		cond_resched();
>>   	}
>>   	vmemmap_populate_print_last();
> 
> Makes sense and LGTM.
> 
> Do we have a Fixes: tag? It probably dates back quite a while ... not sure about
> stable, we never saw this in practice. But if it's easy, we should just do it?
> (not sure if we ever had __remove_pages be limited to hotunplug support)

Hmm ... I'd leave stable out for now. David, could you add the Fixes tag 
Muchun
suggested?

Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")

> I'm planning on picking this up and sending it for the next merge window (so not
> as a hotfix).

Thank you ;)

> Looking at this ...
> 
> x86 does not really expect add_pages to fail:
> 
> 	ret = __add_pages(nid, start_pfn, nr_pages, params);
> 	WARN_ON_ONCE(ret);
> 
> That's probably something to clean up as well?

That would be a separate fix, I guess :) I'll have a look at the other
architectures while I'm at it :)

Cheers, Lance

