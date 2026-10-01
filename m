Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B74837B02D;
	Thu,  1 Oct 2026 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838061; cv=none; b=tHpBxJgDDamKj4qGRG4cQukA0REyamC/Rj29X5Z6csZRPL5rIis4w2S/d5aPv0C5A+n+MP9oDbfWNySClJlniDdJgIBe/dqqIETe+mRKRKKivy6VdfUmlV9Z3hY+4bEajRXDUR5pXctEguOLf/suynMI9Kmk8IUpK9y016Teou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838061; c=relaxed/simple;
	bh=LYuwTyhDYEXAQwJP3/saK5KTDbbRgSa2pwT+MFLbnSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZM9cl68Pw7zYs98+bcc7OxCUZTrwHM4dDrE1kLaMycoclwjNREb4l/3Zt5AGT1pV5IDk/3IRQv2jf2bqOaPBQPnMAT2VvOUnjo/y6lt+fSCKdjEeF1GMSpcLfnCZq5VeqOaeKMqbjz06ROA8CMBtwi8OKkqqqrddspREyp+KgMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZLLXGgI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZLLXGgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AD21F000FF;
	Thu,  1 Oct 2026 07:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790838060;
	bh=B/xIh6O/I0mNSdyjCfn1fJtCctSaY1kOaJ3RjSONH5k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fZLLXGgImx9TODyKrsAZATl2CLQRWhm4jFBxozmhe8EFqK/rDLFcc+rfSfHj2MD0M
	 BWsDFoWK4TOmELcImdTcActnUZM4VT6UAFN76l76QFNpncSYha9PTldrxQw2YjAc75
	 BHhY4gvN+krCpXwJoKxVeuZZodZo9sMBImDdGrnUHfbjuYFR8lPLilAAVACr9Var21
	 UdOU7fIU4Zahk1J2RXAPRtprWmx4mDgbxZHF124azE39oJaPo9AbYIg9kn7stS2Od6
	 Hmk2agEza9eZuqnHN9zDYWQU3WQYlvywYC4rJjPux76oOjW3m+lDXAfhGLGB0pkpxJ
	 f4zwPl4C2b2Yg==
Message-ID: <4aad3847-4240-40aa-af24-df34da4d68ad@kernel.org>
Date: Thu, 1 Oct 2026 09:00:55 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/memory_hotplug: fix missing rollback in
 __add_pages()
To: Muchun Song <muchun.song@linux.dev>
Cc: Lance Yang <lance.yang@linux.dev>, osalvador@suse.de,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260930160432.5564-1-lance.yang@linux.dev>
 <d4fac8af-fd71-47a2-bfe9-3c6559b92209@kernel.org>
 <203892F4-B04A-4F69-A1B3-DC1619176C67@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <203892F4-B04A-4F69-A1B3-DC1619176C67@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/26 04:33, Muchun Song wrote:
> 
> 
>> On Oct 1, 2026, at 00:46, David Hildenbrand (Arm) <david@kernel.org> wrote:
>>
>> On 9/30/26 18:04, Lance Yang wrote:
>>> __add_pages() returns on a sparse_add_section() failure without removing
>>> the sections already added in the same request.
>>>
>>> For memremap_pages(), the failed range is not counted in pgmap->nr_range,
>>> so memunmap_pages() skips it. The sections already added in that range
>>> retain their vmemmap mappings and subsection bits. Retrying a
>>> section-aligned range can then fail with -EEXIST.
>>>
>>> Save the initial PFN and remove [start_pfn, pfn) on failure. For a vmemmap
>>> population failure, section_activate() already cleans up the current
>>> section, so the rollback excludes it. If the first section fails,
>>> __remove_pages() receives an empty range and does nothing.
>>>
>>> Link: https://lore.kernel.org/all/BAD58999-1EDD-4A37-ABA0-DB1BD8AB3453@linux.dev/
>>> Suggested-by: Muchun Song <muchun.song@linux.dev>
>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>> ---
>>> No Fixes tag, as I couldn't identify the commit that introduced this issue.
>>>
>>> mm/memory_hotplug.c | 6 +++++-
>>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 796af1028ee2..ca4656698148 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -380,6 +380,7 @@ EXPORT_SYMBOL_GPL(pfn_to_online_page);
>>> int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>>> struct mhp_params *params)
>>> {
>>> + 	const unsigned long start_pfn = pfn;
>>> 	const unsigned long end_pfn = pfn + nr_pages;
>>> 	unsigned long cur_nr_pages;
>>> 	int err;
>>> @@ -413,8 +414,11 @@ int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>>>    SECTION_ALIGN_UP(pfn + 1) - pfn);
>>> 		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap,
>>>  					params->pgmap);
>>> - 		if (err)
>>> + 		if (err) {
>>> + 			__remove_pages(start_pfn, pfn - start_pfn, altmap,
>>> + 				       params->pgmap);
>>> 			break;
>>> + 		}
>>> 		cond_resched();
>>> 	}
>>> 	vmemmap_populate_print_last();
>>
>> Makes sense and LGTM.
>>
>> Do we have a Fixes: tag? It probably dates back quite a while ... not sure about
>> stable, we never saw this in practice. But if it's easy, we should just do it?
>> (not sure if we ever had __remove_pages be limited to hotunplug support)
>>
>> I'm planning on picking this up and sending it for the next merge window (so not
>> as a hotfix).
>>
>> Looking at this ...
>>
>> x86 does not really expect add_pages to fail:
>>
>> ret = __add_pages(nid, start_pfn, nr_pages, params);
>> WARN_ON_ONCE(ret);
>>
>> That's probably something to clean up as well?
> 
> The warning is a historical leftover. The original code
> printed an error when __add_pages() failed. Commit
> 10f22dde556d accidentally turned that conditional printk
> into an unconditional WARN_ON(1), and commit fe8b868eccb9
> subsequently changed it to WARN_ON_ONCE(ret) to avoid
> warning on successful memory hot-add.
> 
> There is no no-failure contract here: __add_pages() can
> legitimately return errors such as -ENOMEM, and those
> errors are already propagated to the caller. Since
> WARN_ON_ONCE(ret) has no effect on control flow or error
> handling, it can be safely removed without changing the
> failure semantics.

We do not want to WARN_ON in any situation that can legitimately happen. So this
should be sorted out (and Lance is on it IIUC :) )

> 
> This also reveals a potential bug introduced by commit
> ea0854170c952: when update_end_of_memory_vars() was
> added, it was called without checking that ret == 0, so the
> end-of-memory variables may be updated even when
> __add_pages() fails. Returning immediately on error fixes
> that as well.

I'd assume the end-of-memory variables are not a problem, as we usually do not
adjust them during memory unplug either. But yeah, ideally we wouldn't update
them (like other architectures do IIRC).

-- 
Cheers,

David
