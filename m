Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42052D5C9B;
	Thu, 15 Jan 2026 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496912; cv=none; b=mQnqChpIKlc6UJ6yxwZ//pXKRqx+ATWZuS0966tnc7em4XHvhS292EAqUl1tn9SYBGHsc/TNzJzD7KFWCJwcOwJvEmLj8iEO8veDcXAiVVfqPC7JOkyVJHtB+To6UtFUYv9Zjv968L4KwNfi8kexmSmFUORg9U3lwwTaAwMLIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496912; c=relaxed/simple;
	bh=kvpBW7s0Yb0ZTvEDTbYEW7WxU/aDUyVVdbOh0HJvglc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwmxcKhM8GeZ+Lt8LD2Kfk3sJ66nF+rKD6Os9axrs6k0R4zZq9JI9tM9IWO8JZPDhhe7TVlTKOyQa3PGAwjcFZKz9E89s6z5ZeSvvJRnqR3ncN1Vd0qoBLUPWW1O1SkxYa/ubuCpbD+YD9Q1IUGBh7aan1AKK2gyn8sbW2gqN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDbjxPX0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDbjxPX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD29C116D0;
	Thu, 15 Jan 2026 17:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768496912;
	bh=kvpBW7s0Yb0ZTvEDTbYEW7WxU/aDUyVVdbOh0HJvglc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cDbjxPX0VtD0nup8atPzlwsQUwUnkJfkve2dnlCuTBVOPVOkLFgzKxAf/yXeo+tqN
	 /2zR6/pOMiMkPk5wfdmpnLZylfriuOS0J1MWyiToIlWQxBzDS5HstJHk6tTaxx01gp
	 fudAmlCqeYkJgKf4thwN5kokcbYKGC0sMarjwgg4f6yPFZ4QFq/+NPd0YR48lX9nSo
	 edA19w75C/pUjkvmF0SETET2Ri3BdmEeFPyf87OgaBOUa90TT0oQtNNu6gm8seQds2
	 THTVNxg0Bg3sdACwwf9WY+JHJWrefCGAtlHmbrDvYUrlFODNOZuDkOR8Pi4rup6OfA
	 mqCgKP0i26s9g==
Message-ID: <23513e86-0769-4f3f-b90b-22273343a03c@kernel.org>
Date: Thu, 15 Jan 2026 18:08:25 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Introduce a huge-page pre-zeroing mechanism
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Li Zhe <lizhe.67@bytedance.com>, akpm@linux-foundation.org,
 ankur.a.arora@oracle.com, fvdl@google.com, joao.m.martins@oracle.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 mjguzik@gmail.com, muchun.song@linux.dev, osalvador@suse.de,
 raghavendra.kt@amd.com, linux-cxl@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, Gregory Price <gourry@gourry.net>,
 Dan Williams <dan.j.williams@intel.com>, zhanjie9@hisilicon.com,
 wangzhou1@hisilicon.com
References: <9daa39e6-9653-45cc-8c00-abf5f3bae974@kernel.org>
 <20260115093641.44404-1-lizhe.67@bytedance.com>
 <83798495-915b-4a5d-9638-f5b3de913b71@kernel.org>
 <20260115115739.00007cf6@huawei.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
In-Reply-To: <20260115115739.00007cf6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 12:57, Jonathan Cameron wrote:
> On Thu, 15 Jan 2026 12:08:03 +0100
> "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:
> 
>> On 1/15/26 10:36, Li Zhe wrote:
>>> On Wed, 14 Jan 2026 18:21:08 +0100, david@kernel.org wrote:
>>>       
>>>>>> But again, I think the main motivation here is "increase application
>>>>>> startup", not optimize that the zeroing happens at specific points in
>>>>>> time during system operation (e.g., when idle etc).
>>>>>>   
>>>>>
>>>>> Framing this as "increase application startup" and merely shifting the
>>>>> overhead to shutdown seems like gaming the problem statement to me.
>>>>> The real problem is total real time spent on it while pages are
>>>>> needed.
>>>>>
>>>>> Support for background zeroing can give you more usable pages provided
>>>>> it has the cpu + ram to do it. If it does not, you are in the worst
>>>>> case in the same spot as with zeroing on free.
>>>>>
>>>>> Let's take a look at some examples.
>>>>>
>>>>> Say there are no free huge pages and you kill a vm + start a new one.
>>>>> On top of that all CPUs are pegged as is. In this case total time is
>>>>> the same for "zero on free" as it is for background zeroing.
>>>>
>>>> Right. If the pages get freed to immediately get allocated again, it
>>>> doesn't really matter who does the freeing. There might be some details,
>>>> of course.
>>>>   
>>>>>
>>>>> Say the system is freshly booted and you start up a vm. There are no
>>>>> pre-zeroed pages available so it suffers at start time no matter what.
>>>>> However, with some support for background zeroing, the machinery could
>>>>> respond to demand and do it in parallel in some capacity, shortening
>>>>> the real time needed.
>>>>
>>>> Just like for init_on_free, I would start with zeroing these pages
>>>> during boot.
>>>>
>>>> init_on_free assures that all pages in the buddy were zeroed out. Which
>>>> greatly simplifies the implementation, because there is no need to track
>>>> what was initialized and what was not.
>>>>
>>>> It's a good question if initialization during that should be done in
>>>> parallel, possibly asynchronously during boot. Reminds me a bit of
>>>> deferred page initialization during boot. But that is rather an
>>>> extension that could be added somewhat transparently on top later.
>>>>
>>>> If ever required we could dynamically enable this setting for a running
>>>> system. Whoever would enable it (flips the magic toggle) would zero out
>>>> all hugetlb pages that are already in the hugetlb allocator as free, but
>>>> not initialized yet.
>>>>
>>>> But again, these are extensions on top of the basic design of having all
>>>> free hugetlb folios be zeroed.
>>>>   
>>>>>
>>>>> Say a little bit of real time passes and you start another vm. With
>>>>> merely zeroing on free there are still no pre-zeroed pages available
>>>>> so it again suffers the overhead. With background zeroing some of the
>>>>> that memory would be already sorted out, speeding up said startup.
>>>>
>>>> The moment they end up in the hugetlb allocator as free folios they
>>>> would have to get initialized.
>>>>
>>>> Now, I am sure there are downsides to this approach (how to speedup
>>>> process exit by parallelizing zeroing, if ever required)? But it sounds
>>>> like being a bit ... simpler without user space changes required. In
>>>> theory :)
>>>
>>> I strongly agree that init_on_free strategy effectively eliminates the
>>> latency incurred during VM creation. However, it appears to introduce
>>> two new issues.
>>>
>>> First, the process that later allocates a page may not be the one that
>>> freed it, raising the question of which process should bear the cost
>>> of zeroing.
>>
>> Right now the cost is payed by the process that allocates a page. If you
>> shift that to the freeing path, it's still the same process, just at a
>> different point in time.
>>
>> Of course, there are exceptions to that: if you have a hugetlb file that
>> is shared by multiple processes (-> process that essentially truncates
>> the file). Or if someone (GUP-pin) holds a reference to a file even after
>> it was truncated (not common but possible).
>>
>> With CoW it would be the process that last unmaps the folio. CoW with
>> hugetlb is fortunately something that is rare (and rather shaky :) ).
>>
>>>
>>> Second, put_page() is executed atomically, making it inappropriate to
>>> invoke clear_page() within that context; off-loading the zeroing to a
>>> workqueue merely reopens the same accounting problem.
>>
>> I thought about this as well. For init_on_free we always invoke it for
>> up to 4MiB folios during put_page() on x86-64.
>>
>> See __folio_put()->__free_frozen_pages()->free_pages_prepare()
>>
>> Where we call kernel_init_pages(page, 1 << order);
>>
>> So surely, for 2 MiB folios (hugetlb) this is not a problem.
>>
>> ... but then, on arm64 with 64k base pages we have 512 MiB folios
>> (managed by the buddy!) where this is apparently not a problem? Or is
>> it and should be fixed?
>>
>> So I would expect once we go up to 1 GiB, we might only reveal more
>> areas where we should have optimized in the first case by dropping
>> the reference outside the spin lock ... and these optimizations would
>> obviously (unless in hugetlb specific code ...) benefit init_on_free
>> setups as well (and page poisoning).
> 
> FWIW I'd be interesting in seeing if we can do the zeroing async and allow
> for hardware offloading. If it happens to be in CXL (and someone
> built the fancy bits) we can ask the device to zero ranges of memory
> for us.  If they built the HDM-DB stuff it's coherent too (came up
> in the Davidlohr's LPC Device-mem talk on HDM-DB + back invalidate
> support)
> +CC linux-cxl and Davidlohr + a few others.
> 
> More locally this sounds like fun for DMA engines, though they are going
> to rapidly eat bandwidth up and so we'll need QoS stuff in place
> to stop them perturbing other workloads.
> 
> Give me a list of 1Gig pages and this stuff becomes much more efficient
> than anything the CPU can do.

Right, and ideally we'd implement any such mechanisms in a way that more 
parts of the kernel can benefit, and not just an unloved in-memory 
file-system that most people just want to get rid of as soon as we can :)

-- 
Cheers

David
