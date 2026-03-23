Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA52344D9A;
	Mon, 23 Mar 2026 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273222; cv=none; b=sgx/JQ/kdSOAg4TQaNkS6KTMEZdCqIJfaU/pUl6T7Iu5ptcFUM08iZ1mPDWGYZdWjYCK69xAfbzsH5HtJjWw92aHb8iVqkVHTF8ZP/d3oSNz7kJZKPzpuzYWwZdjJMB+HBjCyP8zAKW/dYt5vILF1SUS+4scaFVoUtoTthXIGLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273222; c=relaxed/simple;
	bh=+vl328zCZ3IIWDg4kXdCU0JqpKru3mTI0xRcjoscBVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/E/iPlalxK6vp8uFeIovuAvKPFvPj08pnKExLXDJGROX38d1KVjBGoDqF9qyceCR8AKzNgCQZsFPq1F2mAoP8GRma9Q6M2k91dEzpMY55D9RbFMI4gRJXbQ2OdYBfJ09l/MNar3M8COZLSR7QVegXvTvxPbHJrSmtsaubxU/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezodwAAY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezodwAAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE1DC2BC9E;
	Mon, 23 Mar 2026 13:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774273221;
	bh=+vl328zCZ3IIWDg4kXdCU0JqpKru3mTI0xRcjoscBVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ezodwAAYaGvaJuUgQ96ue3bXKBLH00W4fabxcJbDe23Ewjtn0k0Eg7+pc9MgnAQkx
	 b8o1laBdA+mpl8l/nBYulFIsOA2qDeQYWjuqlvKv7N4oPYdLc7T0QOtjSPzdL/yt3C
	 444zlf3hSnWneG7NX3X1bvmFgBuVh1GslF0GhWAo2MHllphy1APi6H5j1Ydhu4ETXw
	 3+0+7VO/M0dKJx4YPEQ6MgDYXnvaoDSX2efODknd5T4qpzgE5jwe+4csr6ba6QBW1g
	 HrlbHYre4V3N42RmIusaCwaB3cnQ4HyUBr3THAEbkihqON6pgNSwMACFqdIKSO7vf7
	 uhqCaRakmgQ7A==
Message-ID: <4caebf3b-8924-406f-9b92-909cf86ef669@kernel.org>
Date: Mon, 23 Mar 2026 14:40:16 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] mm/memory_hotplug: fix possible race in
 scan_movable_pages()
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Axel Rasmussen
 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
 <20260320-sparsemem_cleanups-v2-1-096addc8800d@kernel.org>
 <5b489c40-bd89-4dff-9669-560b1b28ec69@lucifer.local>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <5b489c40-bd89-4dff-9669-560b1b28ec69@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/23/26 14:26, Lorenzo Stoakes (Oracle) wrote:
> On Fri, Mar 20, 2026 at 11:13:33PM +0100, David Hildenbrand (Arm) wrote:
>> If a hugetlb folio gets freed while we are in scan_movable_pages(),
>> folio_nr_pages() could return 0, resulting in or'ing "0 - 1 = -1"
>> to the PFN, resulting in PFN = -1. We're not holding any locks or
>> references that would prevent that.
>>
>> for_each_valid_pfn() would then search for the next valid PFN, and could
>> return a PFN that is outside of the range of the original requested
>> range. do_migrate_page() would then try to migrate quite a big range,
>> which is certainly undesirable.
>>
>> To fix it, simply test for valid folio_nr_pages() values. While at it,
>> as PageHuge() really just does a page_folio() internally, we can just
>> use folio_test_hugetlb() on the folio directly.
>>
>> scan_movable_pages() is expected to be fast, and we try to avoid taking
>> locks or grabbing references. We cannot use folio_try_get() as that does
>> not work for free hugetlb folios. We could grab the hugetlb_lock, but
>> that just adds complexity.
>>
>> The race is unlikely to trigger in practice, so we won't be CCing
>> stable.
>>
>> Fixes: 16540dae959d ("mm/hugetlb: mm/memory_hotplug: use a folio in scan_movable_pages()")
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> Logic looks right to me, though some nits below. With those accounted for:
> 
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> 
>> ---
>>  mm/memory_hotplug.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 86d3faf50453..969cd7ddf68f 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1747,6 +1747,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>>  	unsigned long pfn;
>>
>>  	for_each_valid_pfn(pfn, start, end) {
>> +		unsigned long nr_pages;
>>  		struct page *page;
>>  		struct folio *folio;
>>
>> @@ -1763,9 +1764,9 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>>  		if (PageOffline(page) && page_count(page))
>>  			return -EBUSY;
>>
>> -		if (!PageHuge(page))
> 
> Yeah interesting to see this is folio_test_hugetlb(page_folio(page)) :))
> 
> So this is a nice change for sure.
> 
>> -			continue;
>>  		folio = page_folio(page);
>> +		if (!folio_test_hugetlb(folio))
>> +			continue;
>>  		/*
>>  		 * This test is racy as we hold no reference or lock.  The
>>  		 * hugetlb page could have been free'ed and head is no longer
>> @@ -1775,7 +1776,11 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>>  		 */
>>  		if (folio_test_hugetlb_migratable(folio))
>>  			goto found;
>> -		pfn |= folio_nr_pages(folio) - 1;
>> +		nr_pages = folio_nr_pages(folio);
>> +		if (unlikely(nr_pages < 1 || nr_pages > MAX_FOLIO_NR_PAGES ||
> 
> NIT: since nr_pages is an unsigned long, would this be better as !nr_pages || ...?

It's easier on the brain when spotting that only a given range is
allowed, without having to remember the exact type of the variable :)

So I guess it doesn't really make a difference in the end.

> 
>> +			     !is_power_of_2(nr_pages)))
> 
> Could the latter two conditions ever really happen? I guess some weird tearing
> or something maybe?

Yes, or when the fields gets reused for something else.

> 
> It would also be nice to maybe separate this out as is_valid_nr_pages() or
> something, but then again, I suppose given this is a rare case of us
> checking this under circumstances where the value might not be valid, maybe
> not worth it.

I had the same thought. But this code is way too special regarding
raciness that I hope nobody else will really require this ... and if
they do, they might be doing something wrong :)

-- 
Cheers,

David
