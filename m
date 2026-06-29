Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B841407583;
	Mon, 29 Jun 2026 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738329; cv=none; b=PrDGRNKwGV980c9caKd2Tjk5lLqAq0mKrBoX8YGg0r8QzNHa6DNdNV7/UaiCoRGzUxSI61jxhMBafFADE98Im7jEUW4fwNmlq4gLl73qF3uIJRBreniF0SjH7MGtkhMjky2yT2fszR3cMwPXOCOK6HFo4WjhIMaPZPyfQvP4VV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738329; c=relaxed/simple;
	bh=YKHuCUKYK4knjUHKZAMQJPJt5qHTng1+YmhLkIvHzv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVbzxShCcXXkIXfaWrIsVQ2RHRVFOuqU55uO7SW4zGaq5VOQjDofBGK6xH5cB0bRql5sZyIS2YUDAykrVbb6sriqmjJUqKkwKnWLocqt9xC6UTMhFxNjhYWl8xUMHJTg9tBWLpy25kqLbYgZQgYEqafQyBKxd6NOipkunpofCmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzdiCuRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzdiCuRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74811F000E9;
	Mon, 29 Jun 2026 13:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782738327;
	bh=E0pTUxBevAAspoZyX6GTvYiy1fBE6MhwHahBRwP6f2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XzdiCuRHyahjePaQr9MJfRElVmEehhKYCYspSV2sAx8tS6EDgv4H5vP4AWnBmLY+o
	 zEl7qBheoyaAheX8zxLP+YjXoKFL0AS61LRPy5WentvrRTAMUUEO/s3nq+UZFsEBri
	 NuzG4ITo6mOlLgVw+SN3fScThQjMYH308DzaxZiUAcw/Vf1c0IfZHTByd+YoSCYHGi
	 dnbFbe0f3+iggkyZPn/fZZlEUZoOXvQpZLeWKkn1IFL+xAQu3DejB50Ky57MDAYZ7N
	 HEnQxrbgJFg1eIFhYvWoazRb8F6PgXlPyWjF4Jsb+lp0o+4TpqzXisJFqSYbBy7VKI
	 dzOtr6UCPRKSA==
Message-ID: <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
Date: Mon, 29 Jun 2026 15:05:18 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: memory-failure: fix HWPoison flag race with
 non-atomic page flag ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Andi Kleen <andi@firstfloor.org>,
 Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
 Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry@kernel.org>,
 Hao Li <hao.li@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org
References: <cover.1782676497.git.mst@redhat.com>
 <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
 <20260629030657-mutt-send-email-mst@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260629030657-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 09:34, Michael S. Tsirkin wrote:
> On Mon, Jun 29, 2026 at 08:49:37AM +0200, David Hildenbrand (Arm) wrote:
>> On 6/28/26 23:45, Michael S. Tsirkin wrote:
>>> I don't like it that we are adding overhead to the good path for
>>> the benefit of memory failure, which never triggers on many systems,
>>> but I don't have a better idea. Pls take a look.
>>
>> As I said on Friday.
>>
>> "It's also doesn't address the mf_mutex implications and the x86 thingies I
>> mentioned.
> 
> Well I did attempt addressing this.  These would be these two:
> 
> 	(a) We don't hold the mf_mutex on all call paths, but we really need it so a
> 	page_test_set_hwpoison() cannot race in weird ways with the other primitives I think.
> 
> page_test_set_hwpoison was this code you wrote:
> 
> +static void page_set_hwpoison(struct page *page)
> +{
> +       lockdep_assert_held(&mf_mutex);
> +
> +       while (!PageHWPoison(page)) {
> +               SetPageHWPoison(page);
> +
> +               /* Make sure concurrent non-atomic writers completed. */
> +               synchronize_rcu();
> +       }
> +}
> 
> and indeed the test+set combination seems racy.  But consider the version I posted, for example:
> 
> +/*
> + * Drain any in-flight non-atomic page flag operations that could
> + * clobber a concurrently set HWPoison bit.  Retries until the bit sticks.
> + */
> +static void set_hwpoison_drain_rcu(struct page *p)
> +{
> +       do {
> +               synchronize_rcu();
> +       } while (!TestSetPageHWPoison(p));
> +}
> +
> 
> ...
> 
> +static bool test_and_set_hwpoison_drain_rcu(struct page *p)
> +{
> +       bool was_set = TestSetPageHWPoison(p);
> +
> +       set_hwpoison_drain_rcu(p);
> +       return was_set;
> +}
> 
> 
> 
> does not seem racy without a lock. But maybe I don't get it.


Staring at your implementation, just think about two concurrent invocations of
test_and_set_hwpoison_drain() in your code:

Assume HWPoison flag is not set.

Thread 1: test_and_set_hwpoison_drain_rcu() -> TestSetPageHWPoison()
	-> was_set = false

Thread 2: update that overwrites page->flags. HWPoison accidentally cleared.

Thread 3: test_and_set_hwpoison_drain_rcu() -> TestSetPageHWPoison()
	-> was_set = false

Thread 1: does RCU sync and returns "!was_set"
thread 2: does RCU sync and returns "!was_set"

So you could end up with two thread believing that they atomically cleared the
flag, and you really need to lock.

We really have to document and enforce that the mutex is involved.


And I fear there are more nasty details to be uncovered while we rework some of
this properly, mandating a detailed look.

For example, TestClearPageHWPoison() in put_page_back_buddy() likely needs a
proper treatment as well. Likely that code should be reworked entirely to not
have arbitrary hwpoison page flag modifications throughout the codebase.

> 
> 
> 
> 	(b) There are some leftover SetPageHWPoison etc. instances. The ones in
> 	arch/x86/kernel/cpu/mce/core.c likely cannot grab the mutex, but maybe they are
> 	corner cases either way and we can document the situation.
> 
> Well, I did try to document the situation - it's in the commit log for
> patch 1:
> 
>     Note: the MCE handler in arch/x86/kernel/cpu/mce/core.c also calls
>     SetPageHWPoison() and is subject to the same race.  It cannot use
>     the drain helpers (MCE context cannot call synchronize_rcu()).
>     For recoverable MCE errors, memory_failure() is queued via work
>     items (kill_me_maybe/kill_me_never) and will re-set the bit via
>     test_and_set_hwpoison_drain_rcu() if it was clobbered.  The
>     mce_panic() path sets HWPoison for kdump right before panic() so
>     the race is irrelevant there.  The MCG_STATUS_SEAM_NR path does
>     not queue memory_failure(), but the affected page belongs to a
>     TDX guest whose CPU core has already been marked dead - the page
>     is not subject to concurrent non-atomic flag operations in the
>     buddy allocator, so the race does not apply.
> 

We should have a central mechanism in place to document this and avoid future
mistakes.

I am not even sure if we should clearly document for SetPageHWPoison() when and
how they can be used, or if we need a completely new set of helpers.

And that's something to figure out (e.g., interaction with the mutex) by looking
into all of the details, so I expect this to take a lot more time.

[...]

>> This is nothing to vibe-code. This needs a real expert.
> 
> Well I had this sitting on the disk anyway, so I thought I'd post.

It would be good to coordinate here.

Like a reply to my mail, asking whether you should post a new version that you
have already in place.

> 
> I wouldn't call this vibe-code - a bunch of manual work went into this,
> llms mostly as a grep/sed replacement.  

The version you posted earlier had real AI vibes to it, so I can only speculate.
I know that you did some manual work on this, but the details are really ugly in
this code.

> But hey.  I don't object to
> someone taking over, for sure. Was fun, and maybe these patches will be
> helpful as a starting point.
> 
> In particular, maybe I should have been more explicit about how your
> points from Friday are addressed.

Yes.

> 
> If you want to add a bit more to explain the exact concerns here, for
> whoever works on this next, feel free to do so.

I raised some above. I'll try to find someone to take a closer look and see to
which degree we could optimize this.

Or if there are actually more performant alternatives that we could use. (I
still doubt that using atomics is ok in general)

-- 
Cheers,

David
