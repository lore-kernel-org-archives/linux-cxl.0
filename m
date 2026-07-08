Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6930143B6EB;
	Wed,  8 Jul 2026 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512817; cv=none; b=RnSmcZmIXuYDePuDrqFjqcs3x17vVvNTULd5JPaAKnkQ84oFBXRM8xYM/kRsBAV29UyXTfy5D31BkV7sKskD6cnps8l8Go8jb17YCe//NWLvybJEGsUFN1sltBfBiQk2wTZY+x5N5zQXKzxgMOpzfrMzjcNdhQT7jhTYJJ56l6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512817; c=relaxed/simple;
	bh=JBGZvxdNN5I/OPb03V+92qipdEoPfkNG9k1ITTFOtvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjoSAnoY4EX8U2pX89LR756b46whJ3/vIcK5kQ5wWmvC+6FLfI7zeVPvVaBj9fAhHFn8pnI74wpBETBgdTFRupcZyQyfeTUYQA4NUrXJL0aGsG6uckWrunxWxmUVW25ox9WV8BXFGOsxG/MZdnqIYhL8jf45e89T1eWyk0u3p/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTVhDkpT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTVhDkpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976191F00A3A;
	Wed,  8 Jul 2026 12:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783512816;
	bh=JQpKWWvuWuPfGzxltPYT53d7+FjLJPnkaqZXT0J5hAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZTVhDkpTnIf60dgkJswjIMSbeq69aTwlQdu/R7r5b9JqZejLPsmeDkYi9JmTWv18H
	 WnImi0NrW7+TVLPnmsPK/YGH0bY5wrqlCEfxwElYyOqTwAIEjKxY41AG+OITnXanux
	 p7HAQF731Zki6UFygGaBRRZeHDlMNN3iLta5vrBhGXiaaSfCz7Rwsj0UJs8ztGiqfP
	 2i5IzzGXxMKSlSK8lGCNOPL7FMmh3EjEpRQ0av6PxkmR9oCgSvdey63xvEjlywwhhi
	 RqJtOjLz/y2dwdmKYgNPXb0Vd9VDZ2wQdA+7pBi7IAD0pK1EtoWvXn4GSO/y9nxmw5
	 M6UhlvMNcyoqA==
Message-ID: <6b0f028c-574b-4b80-b803-2bff15a5a148@kernel.org>
Date: Wed, 8 Jul 2026 14:13:27 +0200
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
References: <cbab829a-3e65-4b4f-a2e2-704e88a611a0@kernel.org>
 <f6d8354c-2f79-4a48-934c-cbeb335765e2@kernel.org>
 <20260630174852-mutt-send-email-mst@kernel.org>
 <2f884bfa-3cd5-4fba-8aa4-c2e68890ab64@kernel.org>
 <20260701041112-mutt-send-email-mst@kernel.org>
 <d2ce93d9-c3d8-4915-a511-d08eb2c1b374@kernel.org>
 <20260701043024-mutt-send-email-mst@kernel.org>
 <c03ec696-d635-4c7f-8c77-89a439d9135b@kernel.org>
 <20260701112946-mutt-send-email-mst@kernel.org>
 <a353c28c-a864-456d-9b00-7f6a932cda73@kernel.org>
 <20260701180511-mutt-send-email-mst@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260701180511-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 00:18, Michael S. Tsirkin wrote:
> On Wed, Jul 01, 2026 at 06:17:23PM +0200, David Hildenbrand (Arm) wrote:
>> On 7/1/26 17:54, Michael S. Tsirkin wrote:
>>>
>>> Not "generated" surely. But assisted, yes.
>>
>> What I thought.
>>
>>> Still hacking on it, but the difficulty
>>> with memory-failure is that fundamentally, it's not 100% robust.
>>
>> It's all a bit slapped on top of everything, yes.
>>
>> What I was wondering is, assuming the call_task_rcu() and it takes forever,
>> there might be quite a while where a hwpoisoned page that lost its bit is not
>> marked as hwpoisoned.
>>
>> So you'd actually want the one doing the test_and_set_bit() caller to wait until
>> the bit is stable.
> 
> not sure I get it.

Essentially, I think that after you set the bit you'd want everybody else in the
system to see that state before you continue.

Such that other code that tests for poisoned pages would just immediately act on
it. Like the buddy not handing out such a page anymore, immediately.

At least that way it's easier to reason about. Losing these bits is really just
nasty :(

> 
>> But that should be rather hairy as well. :(
>>
>>>
>>> For example, we have a fifo fed by hardware and consumed by a workqueue:
>>>
>>>         struct memory_failure_cpu *mf_cpu;
>>>         unsigned long proc_flags;
>>>         bool buffer_overflow;
>>>         struct memory_failure_entry entry = {
>>>                 .pfn =          pfn,
>>>                 .flags =        flags,
>>>         };
>>>
>>>         mf_cpu = &get_cpu_var(memory_failure_cpu);
>>>         raw_spin_lock_irqsave(&mf_cpu->lock, proc_flags);
>>>         buffer_overflow = !kfifo_put(&mf_cpu->fifo, entry);
>>>         if (!buffer_overflow)
>>>                 schedule_work_on(smp_processor_id(), &mf_cpu->work);
>>>         raw_spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
>>>         put_cpu_var(memory_failure_cpu);
>>>         if (buffer_overflow)
>>>                 pr_err("buffer overflow when queuing memory failure at %#lx\n",
>>>                        pfn);
>>>
>>>
>>> if there are lots of these and the scheduler is slow and it overflows,
>>> it's sayonara you have lost the flag, right?
>>
>> I guess so. I assume on relevant hw you wouldn't expect a storm. But who knows :)
>>
>>>
>>>
>>> Oh and by the way, I just noticed that when buddy merges pages it does
>>> not check the poison bit. So it looks like there's a simple way to lose
>>> the poison bit - have it merge with a non poisoned page.
>>
>> When we poison, we try to take the free page off the buddy. At least that's what
>> I remember.
> 
> 
> Yes but not immediately - we set hwpoison then we try to take it off.
> 
> 
>> So I think we would just then go ahead and split the free higher-order buddy
>> page to remove the single page.
> 
> Later we split, yes. But I don't see where it sets HWPoison after
> split - it calls
> SetPageHWPoisonTakenOff but it seems to assume HWPoison is already set.
> 
> Am I missing something? It's late here...
So, we set hwpoison on a page and that is sticky, even when the buddy merges
them, right?

When handing out pages, the buddy will check all pages through
check_new_pages(). If the poisoned page is part of a higher-order page, that
would still find it.

So I would assume that the hwpoison page->flags stays there, and
PageHWPoisonTakenOff() only tells us if we succeeded in removing the page from
the buddy ourselves.

-- 
Cheers,

David
