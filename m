Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3CE3FC5AE;
	Thu,  9 Jul 2026 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592481; cv=none; b=eWVRK8SAl8AOkIQbmgO0+KMGmng/wEhlbqbVtCu0gL65IBq2388h+sa5Wf91Wu7uDbVQ0zVax/gTooJSUXDWMrYm5y6CXaM2Gktu1HqorZ3dRoSfatGFpWPwjvDf8Z4CFf6F9ZHaZpIgIjSjAsZWKkYDB51t59BishwWdarJ+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592481; c=relaxed/simple;
	bh=nhQj+fF2fDHLdsvAF7OaIL10PTGa5wId+gGMEA/4sIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVCyj+xU9FCaiivGExVU1F/OGdCaox4eu3nNGW0YwNOan77ezsfbrkAswpG+87SSY46AmxGVrlla0CQ3IED3uerdA4/LxkzI8Yr0OcM3Kg8UrIicvJpl95j+kNQ+2Gh/FDxnVhJ6eiugXI2SSmxuhfEAqfDqAcncQSS0LrJgwio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4ZgFZUy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4ZgFZUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D411F000E9;
	Thu,  9 Jul 2026 10:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783592480;
	bh=WdBwou6UoGXgB1ir3Lcp2nsy3ZSLNklF3fHXUXVCCQ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K4ZgFZUyiFpb4XeaDDvdVo/FZUL7Aa1kY1P27AoweaquTl0F7WsR1Ox6pOhMbAi39
	 1zirrV2zmwwY4nyhmX7eq4QwcPawoSPfiKSiPHWIKGih2IatZ6QwGKS2P9vQvQScH/
	 Zcel/Mjsnhx6CNRAo97h8GT6sZLKtTSV7OATYhdSKWjtplrpI/ULy9ogNjodp1rXFr
	 LX/xJKZyMUxWN9BzcGuHS6GcYbfLjFm+Ad4h13zfSI4Jopy+i+jEF8/W3lx6v/qRVh
	 EgDC7La1B9C761sME3x57+uIsVeNeK98og68SDGwfbPFq1ki21HsSB1Hj537eSYcuB
	 1YMLNz1/n83QQ==
Message-ID: <67bbfc47-a8f1-4557-9a24-298bad4f3591@kernel.org>
Date: Thu, 9 Jul 2026 12:21:12 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] mm: split a couple of headers from internal.h
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>, Alexander Potapenko
 <glider@google.com>, Brendan Jackman <jackmanb@google.com>,
 Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
 Dmitry Vyukov <dvyukov@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
 kasan-dev@googlegroups.com, kexec@lists.infradead.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260709-internal-h-v2-0-695631425968@kernel.org>
 <0970fec0-5c18-41e1-b63d-029c7a8354ee@kernel.org>
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
In-Reply-To: <0970fec0-5c18-41e1-b63d-029c7a8354ee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 12:09, Vlastimil Babka (SUSE) wrote:
> On 7/9/26 12:00, Mike Rapoport (Microsoft) wrote:
>> mm/internal.h becomes more and more bloated.
>>
>> Split declarations related to mm_init, memblock, vmalloc and sparse into
>> new headers.
>>
>> ---
>> v2 changes:
>> * fix fallouts of rebase fixups of checkpatch warnings
>>
>> v1: https://patch.msgid.link/20260709-internal-h-v1-0-956d5092782d@kernel.org
>>
>> ---
>> Mike Rapoport (Microsoft) (3):
>>       mm: split out mm_init and memblock declarations from internal.h
>>       mm: split out sparse declarations from internal.h
>>       mm: split out vmalloc declarations from internal.h
>>
>>  MAINTAINERS                        |   3 +
>>  kernel/liveupdate/kexec_handover.c |   3 +-
>>  mm/cma.c                           |   1 +
>>  mm/execmem.c                       |   1 +
>>  mm/hugetlb.c                       |   1 +
>>  mm/internal.h                      | 183 -------------------------------------
>>  mm/kmsan/hooks.c                   |   1 +
>>  mm/kmsan/shadow.c                  |   1 +
>>  mm/memblock.c                      |   1 +
>>  mm/memory_hotplug.c                |   1 +
>>  mm/mm_init.c                       |   3 +
>>  mm/mm_init.h                       | 120 ++++++++++++++++++++++++
>>  mm/page_alloc.c                    |   1 +
>>  mm/percpu-vm.c                     |   1 +
>>  mm/sparse-vmemmap.c                |   2 +
>>  mm/sparse.c                        |   2 +
>>  mm/sparse.h                        |  63 +++++++++++++
>>  mm/vmalloc.c                       |   1 +
>>  mm/vmalloc.h                       |  46 ++++++++++
>>  19 files changed, 251 insertions(+), 184 deletions(-)
> 
> Sounds good
> 
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Agreed

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
