Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17833F378
	for <linux-cxl@vger.kernel.org>; Wed, 15 Apr 2026 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246389; cv=none; b=lNWuZwERFZ1mqlW1oT+cQIt/y6MHTtph4CngLZLXHIVIQ12MgS2fvDfAsFXOR45soeOhk64ul6aHBlPnGgixseg3ZgCpMzMkXxXWGzKIwTP7gZOM/FDdF9QZzZjRbu1xv0yxT9GFFR0ao1HCxheyteXHlfcITlCq1ISTipFqaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246389; c=relaxed/simple;
	bh=SVBE9xTjODuzuq1SZu4SGvyAci4xv6RKQ9n6RGT3hIg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LvrAmGoMw6/kXnwZpT9iYvEGTybWUVWFf7+azCbfG3LjiHzTjj7QKH9q1GTEtBSZ7vAKUrNJRxaRHk2dZTwvNAMb91Ga7aepyKPe+A873p3HwLAvtB8lmzkhE4jXVuj18yjrD439Sy7P5WS8UFa5L8tX8JbxGE8RnbsWcAzxW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QBjm0Q98; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QBjm0Q98"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776246371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xd8e3J+b1LcawueW4g5SlvWwVt0JRcLEm6Lowqe8HOs=;
	b=QBjm0Q98krTet/JEVaYxsXi3oRR/HslqU6S8M/huMahtsUrSqju2CsMK51OOb10zGFFiht
	b2u0G+nNTz3ItgjIOnwsT41ZtHsmuZwONXdX1Fr79WE63a+3itGIICjNzcoPxz4dZ0SVsV
	qMEIFNVptxhj8mN9y+7WGVtkDGVJfNs=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] mm/sparse: Fix race on mem_section->usage in pfn walkers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ad9OZAVnYvhxfh-Z@localhost.localdomain>
Date: Wed, 15 Apr 2026 17:45:30 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Charan Teja Kalla <quic_charante@quicinc.com>,
 Kairui Song <kasong@tencent.com>,
 Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E4115F4-5787-495F-BCEE-1E9B1113E9E5@linux.dev>
References: <20260415022326.53218-1-songmuchun@bytedance.com>
 <ad9OZAVnYvhxfh-Z@localhost.localdomain>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT



> On Apr 15, 2026, at 16:37, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> On Wed, Apr 15, 2026 at 10:23:26AM +0800, Muchun Song wrote:
>> When memory is hot-removed, section_deactivate() can tear down
>> mem_section->usage while concurrent pfn walkers still inspect the
>> subsection map via pfn_section_valid() or pfn_section_first_valid().
>>=20
>> After commit 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing
>> memory_section->usage") converted the teardown to an RCU-based
>> scheme, the code still relies on SECTION_HAS_MEM_MAP becoming visible
>> to readers before ms->usage is cleared and queued for freeing.
>>=20
>> That ordering is not guaranteed. section_deactivate() can clear
>> ms->usage and queue kfree_rcu() before another CPU observes the
>> SECTION_HAS_MEM_MAP clear. A concurrent pfn walker can therefore see
>> valid_section() return true, enter its sched-RCU read-side critical
>> section after kfree_rcu() has already been queued, and then =
dereference
>> a stale ms->usage pointer.
>>=20
>> And pfn_to_online_page() can call pfn_section_valid() without its
>> own sched-RCU read-side critical section, which has similar problem.
>>=20
>> The race looks like this:
>>=20
>>  compact_zone()                    memunmap_pages
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                    =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>                                    __remove_pages()->
>>                                      sparse_remove_section()->
>>                                        section_deactivate():
>>                                          a) [ Clear =
SECTION_HAS_MEM_MAP
>>                                               is reordered to b) ]
>>                                          kfree_rcu(ms->usage)
>>      __pageblock_pfn_to_page
>>         ......
>>          pfn_valid():
>>            rcu_read_lock_sched()
>>            valid_section() // return true
>>            pfn_section_valid()
>>              [Access ms->usage which is UAF]
>>                                          WRITE_ONCE(ms->usage, NULL)
>>            rcu_read_unlock_sched()       b) Clear SECTION_HAS_MEM_MAP
>>=20
>> Fix this by using rcu_replace_pointer() when clearing ms->usage in
>> section_deactivate(), then it does not rely on the order of clearing
>> of SECTION_HAS_MEM_MAP.
>=20
> The fix itself does not look too intrusive and I guess it kind of =
makes
> sense when you think about the ordering issue, so if we want to be
> rock solid, why not.

You are right. Generally speaking, where RCU is used, the pointer should
be cleared first, and then the memory corresponding to the pointer =
should
be released via kfree_rcu(). Therefore, the correct sequence of use here
should be:

	WRITE_ONCE(ms->usage, NULL);
	kfree_rcu(ms->usage);

The actual code has the order reversed. To prevent such errors, the RCU
mechanism provides the rcu_replace_pointer() interface. If you look at =
its
implementation, this interface is essentially equivalent to the code =
sequence
mentioned above.

> Does it slow down operations a lot?

Regarding section_deactivate, I believe there is no functional =
difference.

>=20
> I would also point out that you rcu-protect pfn_section_valid().

rcu_dereference_sched() is equivalent to the previous READ_ONCE(), but =
for
RCU-protected resources, it is recommended to use the RCU-specific =
interfaces
to avoid having to manually account for memory ordering issues.

>=20
> Regarding the pfn_to_online_page() race, that is something that every =
now
> and then pops up, but as David said, we never seen that happening in =
the
> wild so I guess no one really made the time to look into that.

After taking a closer look at commit 5ec8e8ea8b77, it=E2=80=99s clear =
that it was
intended to resolve a race between __pageblock_pfn_to_page and =
section_deactivate.
While the issue surfaced this time due to ms->usage, I=E2=80=99m =
concerned that even
with ms->usage fixed, the underlying race condition in the execution =
path
still exists. This suggests that subsequent accesses to struct page =
might
run into similar trouble down the road.

That said, I=E2=80=99d love to hear what everyone thinks about whether =
this warrants a
full fix.

Thanks,
Muchun.

>=20
>=20
>=20
> --=20
> Oscar Salvador
> SUSE Labs

