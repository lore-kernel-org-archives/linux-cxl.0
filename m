Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B3F1D6195
	for <linux-cxl@vger.kernel.org>; Wed, 15 Apr 2026 06:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233300; cv=none; b=HfEoTKdjNf5cBTwca074/LZIt/DtMpVVU7qp4+EX7MoSdtg3NWVbkwhXaJa07KEcIg3ztJEHItfH7g2fEwfBzBnfsrMEIlBtgPWXBxaapAmG208PDjL9GQyqznk204J3cf4v3fJqHn8P2V7+UFhACcze3xdJoDbQH+RCoTkkbKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233300; c=relaxed/simple;
	bh=q02c33VRVZzaZs6GgbRdCM8UV4LVdW1WsSAMjLCM/v4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Kd8Y7uSTbdos2DCwNUWXh1X5G7XctxQ+uiSax+MJ/FrQgFhGKCgQWuWx+ZWKcoXl/fy25wguFwGAOLfArJU6Zyb83TsAtPWKUn82UgOfOX2S/2p4CCvq10bhVoaYwkxDMHI5I+ux9bH6aUbHem1iw8YjueSVsSejZfLUbrlq8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MPiJ17Ru; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MPiJ17Ru"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776233286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qkmui+O/6xlsFUmo6WfB3AyT/WYrnFjXuhphrajGuAw=;
	b=MPiJ17RuAuIGNOtXqwFkwLymQFIjSiqTT+2M57piZ3VK2T6EVdjuBmPk+tjInuUT8aTLNL
	gB0AX2DCS/xnlUzlxdonGB1lpdTP6oX8dR4q06Ra1rbprJ4pigmBdl+xKVY+/miLI0xZsZ
	Ck19wI4MYK3l4eB7Ij4q2DJPdA4RQGg=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] mm/sparse: Fix race on mem_section->usage in pfn walkers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260414224421.c030868f5960ad0115ac1668@linux-foundation.org>
Date: Wed, 15 Apr 2026 14:06:57 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
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
Message-Id: <2EDA3598-6D6E-479A-973C-92037C7EFF1F@linux.dev>
References: <20260415022326.53218-1-songmuchun@bytedance.com>
 <20260414224421.c030868f5960ad0115ac1668@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 15, 2026, at 13:44, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Wed, 15 Apr 2026 10:23:26 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>=20
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
>=20
> Then what happens?  Can it oops?

Probably not, because struct mem_section_usage has no pointer members,
so there will be no dereference of a pointer. The UAF here may lead to
incorrect logic judgments later on.

>=20
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
>>=20
>> Fixes: 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing =
memory_section->usage")
>=20
> December 2023.

The probability of reordering is relatively low, and as mentioned above,
serious issues are unlikely to occur, so it will be hard to be =
discovered.

Thanks,
Muchun.

>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> This patch is focused on the ms->usage lifetime race only.
>>=20
>> ...
>>=20
>> I am not fully sure whether that reasoning is correct, or whether =
current
>> callers are expected to rely on additional hotplug serialization =
instead.
>> Comments on whether this is a real issue, and how the vmemmap =
lifetime is
>> expected to be handled here, would be very helpful.
>=20
> Thanks.  Quite a bit for consideration.
>=20
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -601,8 +601,10 @@ static void section_deactivate(unsigned long =
pfn, unsigned long nr_pages,
>>  * was allocated during boot.
>>  */
>> 	if (!PageReserved(virt_to_page(ms->usage))) {
>> - 		kfree_rcu(ms->usage, rcu);
>> - 		WRITE_ONCE(ms->usage, NULL);
>> + 		struct mem_section_usage *usage;
>> +
>> + 		usage =3D rcu_replace_pointer(ms->usage, NULL, true);
>> + 		kfree_rcu(usage, rcu);
>> 	}
>> 	memmap =3D pfn_to_page(SECTION_ALIGN_DOWN(pfn));
>> }
>=20
> This part isn't applicable to 7.0 - it depends on material I've sent =
to
> Linus for 7.1-rc1.
>=20
> So for now I'll drop this into mm-unstable to get it some runtime
> testing.  If people like this patch and we decide to proceed with it
> then I can make it a hotfix for 7.1-rcX.  But the -stable people will
> be wanting a backportable version of it, if we decide to backport,


