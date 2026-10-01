Received: from mta1.migadu.com (out-193.mta1.migadu.com [95.215.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9DE43E4BB
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790836027; cv=none; b=Qfe93meoPSmxPO8MTXJYYbWajp7nfdx1CcZSksMK/zeDm8QSSgx+hglt5oJ6oii5C9qoLCyNJXBb4A8XQwPETI9cSMu8IAxjJKkMNo7lToN1cc054Wum6LSHDNwe3pNgayKNZ8SXsOlu3q/YXZmEDbqpv/dz/lCet2YJxp+iEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790836027; c=relaxed/simple;
	bh=b7R/BWq8BN8iE36KRPryjNAMMMnC47/fFTxU2yAxCr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTnB+FMOTDhEXi78OI1/nuUz4Ddnd9eOqMK83SxLt9GgVFJ15WnlbE+J6MH91/IettoqdxvJ4uVeNySMZJ5hKTJf2FWGHhu1n59KRyyor1lWAnOUMwF9m1TpCySs8ywI2rDV0cFMX6iUDCnz2X+Hv2QJ9nwl056AIE9FrAH5yKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CEemQOQ/; arc=none smtp.client-ip=95.215.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CEemQOQ/"
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=b7R/BWq8BN8iE36KRPryjNAMMMnC47/fFTxU2yAxCr0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790836019; v=1; x=1791440819;
 b=CEemQOQ/u8pxGSLM9tp0H4G/b6FBscwOghCC0pfFlKddEkWcc0Q0Hq1sj5ESayHYXBRkG4vB
 Gc9wylnLSniCyAai4bsk+4Q97LC9XXbZFNSxLE+qlEe7QvFINTmF/UZGNjhtiBPIRw8XShIophC
 AFXvxD2cOPvFHpA00MbSft/Y=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 686293e332799156;
	Thu, 01 Oct 2026 06:26:59 +0000
X-Mizu-Trace-ID: 686293e332799156
X-Migadu-Flow: FLOW_OUT
Message-ID: <004b2299-3d7a-42bf-baf0-942715f5c548@linux.dev>
Date: Thu, 1 Oct 2026 14:26:54 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/memory_hotplug: fix missing rollback in
 __add_pages()
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: david@kernel.org, osalvador@suse.de, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260930160432.5564-1-lance.yang@linux.dev>
 <D52186EB-026B-4C9D-BBCE-875F259634AB@linux.dev>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <D52186EB-026B-4C9D-BBCE-875F259634AB@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/1 10:05, Muchun Song wrote:
> 
> 
>> On Oct 1, 2026, at 00:04, Lance Yang <lance.yang@linux.dev> wrote:
>>
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
> 
> Hi Lance,
> 
> LLMs are quite good at tracing this kind of code history, so I used one
> to go through the relevant commits and identify the correct Fixes tag.
> 
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> 
> Before that commit, __add_pages() ignored -EEXIST and continued with
> the remaining sections. After a partial failure, a retry could therefore
> reuse the vmemmap of sections added by the failed attempt and continue
> with the later sections.
> 
> Commit ba72b4c8cf60 made -EEXIST a hard error because
> sparse_add_section() began using it to report an actual subsection
> collision. That semantic change was correct, but without rolling back
> the sections added earlier in the request, stale subsection bits make the
> retry stop at the first previously added section.
> 
> The vmemmap removal infrastructure had already been added by commit
> 0197518cd367 ("memory-hotplug: remove memmap of sparse-vmemmap").
> Therefore, ba72b4c8cf60 appears to be the commit that made this bug
> observable in the way described by this patch.

Thanks, Muchun!

>>
>> mm/memory_hotplug.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 796af1028ee2..ca4656698148 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -380,6 +380,7 @@ EXPORT_SYMBOL_GPL(pfn_to_online_page);
>> int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>> struct mhp_params *params)
>> {
>> + 	const unsigned long start_pfn = pfn;
>> 	const unsigned long end_pfn = pfn + nr_pages;
>> 	unsigned long cur_nr_pages;
>> int err;
>> @@ -413,8 +414,11 @@ int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>>    SECTION_ALIGN_UP(pfn + 1) - pfn);
>> 		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap,
>> 					params->pgmap);
>> - 		if (err)
>> + 		if (err) {
>> + 			__remove_pages(start_pfn, pfn - start_pfn, altmap,
>> +       				params->pgmap);
>> 			break;
>> + 		}
>> 		cond_resched();
>> 	}
>> 	vmemmap_populate_print_last();
> 
> Acked-by: Muchun Song <muchun.song@linux.dev>

Cheers! Lance
