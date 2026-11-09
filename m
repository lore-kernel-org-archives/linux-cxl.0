Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225182;
	b=FG8trCpfgp40cntqLakz/ugifOseQf0k8SORQ0r2Fzj/japzJssM41MjH5tnuz1fhOvO
	 sCOm5AsTixcqg0ZuqXN6WeV/7I4fUss4Z7OBR9YzbGkX6ez1nUdUJ7VwLjfAnDrmK4Gqm
	 DOIM0PtR7upgUGJPY5veyYFZNDwXho8KA8tyIbqZWWyHntM+S8/ouKcMSHFErMpjJ3WRE
	 RuGZ/L3aKnnjT8JrhboQwrathEMpya2NpLxGZ6sOPNnRgzITbBfKdaAqQR1a75HotNX8/
	 BCC7j0HMwqkKNtPFQZJeowSNwyg3+dujysg2sdvgcQsmsP6EN9ygtt5k9EGhqXM71bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225182;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=+NUMBjE4wBB/Q8mO02dBvrjk9d7DRztoNKoxB4KrfGU=;
	b=omtEB2LKDG05uOLkqpVykWa5o4f+c6ARDZooWgdIXvElI7QeeuBufS56wmJkxCLaaIhu
	 3gcrMT3tuPz3mf5r6Y5IeoKKpv5cxQ1sgKAqJFnxlH570AYIrdk+RzSlJZHJen5NzdW+I
	 /dWpTh3QkqrooYlbpMbhgxXuh4Y366x0iAk5vzGIniGy6dAxI7DTYFvxqLXH+uluSczK1
	 K0tjl5QSmXvUlLi25IY7p/67c+nxBRvxveiydtpsgsO8WJspG+iwtgej30xIkmFaQykqc
	 agnSy55VQGtPKXmHSFzCupzw2cLbdp6fv6zhy0bAdsc28pNDZqMck5sphNtfVKfT7WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fjZWf2HJ;
	arc=none smtp.remote-ip=95.215.58.231
Received: from mta1.migadu.com (out-231.mta1.migadu.com [95.215.58.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8319606A323
	for <linux-cxl@vger.kernel.org>; Mon,  9 Nov 2026 11:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8319606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fjZWf2HJ
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NR/9+ds+0qbFQbbZWnYyK+Ful0AYe2acx+nJjLHN/lE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794225178; v=1; x=1794829978;
 b=fjZWf2HJD7A86dlOOGKc7YTE2TJXjn7KAT4Dlcw0GrCnYfmegMGlBh2rFWmbVlYwGROKfxG3
 c5oE6/S8UqkfbMR+L+hmdv8asxYwD/6KcJiuY2sKb4pm3TnONt6L/IIiXZfl0FPLqeGpbJJBRjY
 aFHHOznKvzoEosZpqn3Rg94g=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 47f3f8f417342a33;
	Mon, 09 Nov 2026 11:52:58 +0000
X-Mizu-Trace-ID: 47f3f8f417342a33
X-Migadu-Flow: FLOW_OUT
Message-ID: <7975c299-dcd3-4aee-8bcb-f3c0e8b8ce7a@linux.dev>
Date: Mon, 9 Nov 2026 19:52:42 +0800
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
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Chris Down <chris@chrisdown.name>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <au_l5MRyDbYfsUVe@chrisdown.name>
 <4bfb6533-1e77-4150-9626-437678b1785d@kernel.org>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <4bfb6533-1e77-4150-9626-437678b1785d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/11/9 17:34, David Hildenbrand (Arm) wrote:
> On 11/8/26 04:00, Chris Down wrote:
>> arch_add_memory() sets up the direct map before calling add_pages().
>> If add_pages() fails, the range stays mapped and any page tables
>> allocated for it are leaked. A later hot add can reuse the stale
>> mapping.
>>
>> Remove the direct mapping on failure.
>>
>> Fixes: 45e0b78b0532 ("[PATCH] hot-add-mem x86_64: use CONFIG_MEMORY_HOTPLUG_RESERVE")
>> Signed-off-by: Chris Down <chris@chrisdown.name>
>> ---
>>   arch/x86/mm/init_64.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index 8b6d86fb5a42..846cb34b38dd 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -989,15 +989,23 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
>>   	return ret;
>>   }
>>   
>> +static void __meminit kernel_physical_mapping_remove(unsigned long start,
>> +						     unsigned long end);
>> +
>>   int arch_add_memory(int nid, u64 start, u64 size,
>>   		    struct mhp_params *params)
>>   {
>>   	unsigned long start_pfn = start >> PAGE_SHIFT;
>>   	unsigned long nr_pages = size >> PAGE_SHIFT;
>> +	int ret;
>>   
>>   	init_memory_mapping(start, start + size, params->pgprot);
>>   
>> -	return add_pages(nid, start_pfn, nr_pages, params);
>> +	ret = add_pages(nid, start_pfn, nr_pages, params);
>> +	if (ret)
>> +		kernel_physical_mapping_remove(start, start + size);
>> +
>> +	return ret;
>>   }
>>   
>>   static void __meminit free_pagetable(struct page *page)
>>
>> base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
> 
> I thought we fixed that already, but I remembered
> 
> https://lore.kernel.org/all/20260930160432.5564-1-lance.yang@linux.dev/

Ouch ... I missed the direct map cleanup in that fix ...

Reviewed-by: Lance Yang <lance.yang@linux.dev>
