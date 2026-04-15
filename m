Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4331715C;
	Wed, 15 Apr 2026 05:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776231870; cv=none; b=HdJsdOxDhvkWho6AQoqHfQuShaRj/xIpqWYkkKUAvWmtY4VVv8Ah4LTQHKzKeq9VAdAiXhxNInfPVf3DVzSSVSbJFQVx2BQFZcauBw/JVoVw8+oO7UjS4Aop5SvTVyK6wJ2h/dx3XTkpR74rzcfckcAaNBI8mVP3XeB0VAMqf10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776231870; c=relaxed/simple;
	bh=ULEdZKOlyHUFAHTvKEpw6ZXT98VHr7FG4P/ABfzjD5U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JfxxgdGNlGmVcMFB0LXydMNdAX0w6hl7TfVsNdwZ4eDWMBfSYynbA73UmLBGsjEWRPi+Rcv2HfdMdMkOQCxiswXHolr4BCxAvWXyImXm9wSqBTCko+eC0HJadU9Q2iCsY2sGznp5k0BT0akIiS+gCr4K5Wrb0HbiZsmQD8J/7zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OK21Xv7f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OK21Xv7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D201AC2BCB0;
	Wed, 15 Apr 2026 05:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776231870;
	bh=ULEdZKOlyHUFAHTvKEpw6ZXT98VHr7FG4P/ABfzjD5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OK21Xv7fgD18lW8YMItHZM5UiVgKPJ8r66Ohfg321bvYzgZHvjqvQSxNpDtzUwTkX
	 jo1owznB7qT7j668xhhQ6UBAdR2PcKQ0sfqmvB1s0Ik4998BzvI3yJ9MLMFPXzCld1
	 PrWud/iFUoL+ds6JxwJXiX02KVDDhQ96eZ+Nd0js=
Date: Tue, 14 Apr 2026 22:44:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>, Oscar Salvador
 <osalvador@suse.de>, Charan Teja Kalla <quic_charante@quicinc.com>, Muchun
 Song <muchun.song@linux.dev>, Kairui Song <kasong@tencent.com>, Qi Zheng
 <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Barry Song
 <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
 <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Lorenzo Stoakes
 <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil
 Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] mm/sparse: Fix race on mem_section->usage in pfn
 walkers
Message-Id: <20260414224421.c030868f5960ad0115ac1668@linux-foundation.org>
In-Reply-To: <20260415022326.53218-1-songmuchun@bytedance.com>
References: <20260415022326.53218-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Apr 2026 10:23:26 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> When memory is hot-removed, section_deactivate() can tear down
> mem_section->usage while concurrent pfn walkers still inspect the
> subsection map via pfn_section_valid() or pfn_section_first_valid().
> 
> After commit 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing
> memory_section->usage") converted the teardown to an RCU-based
> scheme, the code still relies on SECTION_HAS_MEM_MAP becoming visible
> to readers before ms->usage is cleared and queued for freeing.
> 
> That ordering is not guaranteed. section_deactivate() can clear
> ms->usage and queue kfree_rcu() before another CPU observes the
> SECTION_HAS_MEM_MAP clear. A concurrent pfn walker can therefore see
> valid_section() return true, enter its sched-RCU read-side critical
> section after kfree_rcu() has already been queued, and then dereference
> a stale ms->usage pointer.

Then what happens?  Can it oops?

> And pfn_to_online_page() can call pfn_section_valid() without its
> own sched-RCU read-side critical section, which has similar problem.
> 
> The race looks like this:
> 
>   compact_zone()                    memunmap_pages
>   ==============                    ==============
>                                     __remove_pages()->
>                                       sparse_remove_section()->
>                                         section_deactivate():
>                                           a) [ Clear SECTION_HAS_MEM_MAP
>                                                is reordered to b) ]
>                                           kfree_rcu(ms->usage)
>       __pageblock_pfn_to_page
>          ......
>           pfn_valid():
>             rcu_read_lock_sched()
>             valid_section() // return true
>             pfn_section_valid()
>               [Access ms->usage which is UAF]
>                                           WRITE_ONCE(ms->usage, NULL)
>             rcu_read_unlock_sched()       b) Clear SECTION_HAS_MEM_MAP
> 
> Fix this by using rcu_replace_pointer() when clearing ms->usage in
> section_deactivate(), then it does not rely on the order of clearing
> of SECTION_HAS_MEM_MAP.
> 
> Fixes: 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing memory_section->usage")

December 2023.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> This patch is focused on the ms->usage lifetime race only.
> 
> ...
>
> I am not fully sure whether that reasoning is correct, or whether current
> callers are expected to rely on additional hotplug serialization instead.
> Comments on whether this is a real issue, and how the vmemmap lifetime is
> expected to be handled here, would be very helpful.

Thanks.  Quite a bit for consideration.

> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -601,8 +601,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  		 * was allocated during boot.
>  		 */
>  		if (!PageReserved(virt_to_page(ms->usage))) {
> -			kfree_rcu(ms->usage, rcu);
> -			WRITE_ONCE(ms->usage, NULL);
> +			struct mem_section_usage *usage;
> +
> +			usage = rcu_replace_pointer(ms->usage, NULL, true);
> +			kfree_rcu(usage, rcu);
>  		}
>  		memmap = pfn_to_page(SECTION_ALIGN_DOWN(pfn));
>  	}

This part isn't applicable to 7.0 - it depends on material I've sent to
Linus for 7.1-rc1.

So for now I'll drop this into mm-unstable to get it some runtime
testing.  If people like this patch and we decide to proceed with it
then I can make it a hotfix for 7.1-rcX.  But the -stable people will
be wanting a backportable version of it, if we decide to backport,

