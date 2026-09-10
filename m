Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A554A2063;
	Thu, 10 Sep 2026 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053116; cv=none; b=ADVP9xvJeOLPAqpc8bpeI16pdLtxGBy0OtHl75zzF25t+E5RTuYgkocLOKb4+WY7wn9kclp9atlzR72URrtpc6lCcUaqY5RC7K931ig1DRwFUxpDVFvRVb+JpEFgM5XOdi6kJRoxHi/jsvqnQbRmJcVKzayBpGH+uBdR//O0kN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053116; c=relaxed/simple;
	bh=9Yc48dfVmE/Rzkfkuz3UPe+YqnEyjcO1mePRgHC5Uss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PX9Fo3RIzrCIAQozxwyyREdr6NdPaLk1zVVmitiQpWMBlAyQlr96PPBdIkBBcShLvKfgZ5g5NmCD5iH4jB4GoF5R/d9UaBLjJkP8usFqe0GhYSPaT23+Di/G9PdCR6/vG+bWP3Z3XuPeWxNBEd3UsKecLSblZ6kaAI5OMXiIM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO7pExAE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO7pExAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080341F000FF;
	Thu, 10 Sep 2026 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053109;
	bh=m8oPxLNbD63jwykdDjogfzHJQI7uOPBa9BxKyoPjd+4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VO7pExAE9tLKDaKHb8xxcgxhPCuKZtJ6zqhDrvjdmuD5ErR0dFWQ+W4yXO85uiR/G
	 VLfy0Ms/MhbB4PHPzIjKj2tKCdJUX6RZH/qbmjZ0B91Cfmt+JfqDDXa/L1WnPOVqei
	 fV9VKnEzVUX8aeK75ayqlZuQesHZecS7vI38Dj+y9hTwqI1bAFZyxeLDSjUm4h5pen
	 YEIZHAS2N3LiejXO8NXe1I4V5AI7I+lTbFRaWxg4MsaN/aGjuOhMu2T7i6T8pFD/8I
	 GbYXY08QYFSc1G6dx1AmcjR+4rPenkEG973Xr8FBUtvk3WCo/B9Now/Ghs6ZlWDuoU
	 AnTw3vabHbp1Q==
Message-ID: <eb5b465b-c256-4454-84de-517aefcd6d59@kernel.org>
Date: Thu, 10 Sep 2026 17:11:36 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] mm/sparse: remove SECTION_MARKED_PRESENT
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Seongjun Hong <hsj0512@snu.ac.kr>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-9-008fc8d579fe@kernel.org>
 <aqK9S1hBpPnujgz9@gremlin>
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
In-Reply-To: <aqK9S1hBpPnujgz9@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/26 16:32, Lorenzo Stoakes (ARM) wrote:
> On Wed, Sep 09, 2026 at 03:33:02PM +0200, David Hildenbrand (Arm) wrote:
>> All present section iterators run before memory hotplug added any
>> further memory sections, Therefore, we can simply use the SECTION_IS_EARLY
>> flag by setting that flag earlier in sparse_prepare_early_sections().
> 
> Hmm? sparse_prepare_early_sections() doesn't seem to be a function that exists?
> 
> Do you mean sparse_sections_init()?

Rebase artifact, thanks! :)

> 
>>
>> Get rid of SECTION_MARKED_PRESENT entirely and rename
>> for_each_present_section_nr() to for_each_early_section_nr().
>>
>> Also update the gdb script to use the updated value for
>> SECTION_IS_EARLY.
> 
> The change seems fine.
> 
>>
>> No functional change intended.
>>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> With commit msg updated:
> 
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
> One small question type comment below.

Thanks!

[...]

>> +++ b/scripts/gdb/linux/mm.py
>> @@ -76,7 +76,7 @@ class x86_page_ops():
>>              self.SECTION_IS_EARLY = 1 << int(gdb.parse_and_eval('SECTION_IS_EARLY_BIT'))
>>          except:
>>              self.SECTION_HAS_MEM_MAP = 1 << 0
>> -            self.SECTION_IS_EARLY = 1 << 3
>> +            self.SECTION_IS_EARLY = 1 << 2
> 
> Seems a bit strage given the code is:
> 
>         try:
>             self.SECTION_HAS_MEM_MAP = 1 << int(gdb.parse_and_eval('SECTION_HAS_MEM_MAP_BIT'))
>             self.SECTION_IS_EARLY = 1 << int(gdb.parse_and_eval('SECTION_IS_EARLY_BIT'))
>         except:
>             self.SECTION_HAS_MEM_MAP = 1 << 0
>             self.SECTION_IS_EARLY = 1 << 2
> 
> Whereas other variables must be available with no try, e.g.:
> 
>         self.PAGE_OFFSET = int(gdb.parse_and_eval("page_offset_base"))
>         self.VMEMMAP_START = int(gdb.parse_and_eval("vmemmap_base"))
>         self.PHYS_BASE = int(gdb.parse_and_eval("(unsigned long) phys_base"))
> 
> etc.
> 
> Is there some weirdness with gdb? Or is it maybe because there are some configs
> without these symbols maybe?

TBH, I have absolutely no idea and I was asking myself the same thing (but
decided that I couldn't care less about a python gdb script).

This code was added in February:

commit 55f8b4518d14b7436f70defe27faba4eca0cd4e1
Author: Seongjun Hong <hsj0512@snu.ac.kr>
Date:   Mon Feb 2 12:42:41 2026 +0900

    scripts/gdb: implement x86_page_ops in mm.py

    Implement all member functions of x86_page_ops strictly following the
    logic of aarch64_page_ops.

    This includes full support for SPARSEMEM and standard page translation
    functions.

    This fixes compatibility with 'lx-' commands on x86_64, preventing
    AttributeErrors when using lx-pfn_to_page and others.

@Seongjun, why are these conditional and the others not? Trying to support older
kernels?


-- 
Cheers,

David
