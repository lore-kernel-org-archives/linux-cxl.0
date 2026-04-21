Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB763BC667
	for <linux-cxl@vger.kernel.org>; Tue, 21 Apr 2026 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776162; cv=none; b=X23XAisjhCshxFjVs0tGDKEOxhJ2GWWaljzX/b3K/GEWC76N2YltA+0XbxGVjKU1RpQUImF3C80qN9Hw1CVy9hFemtCnimTHKesLxqZR2BbvVV400w58FUotMRxPQKWBMn/IpFiyhXtS877tpcT9ozMv2Vo3Yy8xSQ8eLnf+1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776162; c=relaxed/simple;
	bh=LQRkOn3vW/nmQK3tXc3BfXa7nqkhb18sICHqPyodtvY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AWjiy2TtYi/pDNXuRjIYuzKSf+QdwLFz5crN3SRgQw9Uo3VThabPKnU0nmQMAcF55fHHX+DAEgAVcVxkuJPCGzFXwypH3eY9S5i3uLysyZLORmHxI8VTdhC4ziTIuVkvMFzyK9JXZHrUHUS/0vnWG/ptHmX8hkL3jTZhTRLmZcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vg7izoD/; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vg7izoD/"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776776157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J/IkkW+JU5n6AeDg2GUMzTphPhICC5j8Thb0S1sUJj8=;
	b=vg7izoD/SHeDiCvwcVpph61OCz4KFop7UFNJhdMRJinWVLPtCa1iaohG8NGMVKJ3GzkuVm
	Y7zWATpixrqwQxOhntqktRfjFxinlyyiqIHTk1XbnRY5OksFTuAKg+FWJrMM10mWNVYRFa
	SUVSbHSu+nvK24ILRfplaDMibP/R7X8=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] mm/sparse: Fix race on mem_section->usage in pfn walkers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <76cec69e-6ee1-4630-847b-80dc1e49d643@kernel.org>
Date: Tue, 21 Apr 2026 20:55:16 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
Message-Id: <FBD66BD2-79E6-4CBB-BBCA-8E8CB7DEB6CF@linux.dev>
References: <20260415022326.53218-1-songmuchun@bytedance.com>
 <09d1ef13-e02b-41e9-b431-4c3254e42011@kernel.org>
 <B139F2C1-77CB-43A5-8377-4F4BD44ADC6C@linux.dev>
 <76cec69e-6ee1-4630-847b-80dc1e49d643@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 21, 2026, at 19:21, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/15/26 11:20, Muchun Song wrote:
>>=20
>>=20
>>> On Apr 15, 2026, at 16:04, David Hildenbrand (Arm) =
<david@kernel.org> wrote:
>>>=20
>>> On 4/15/26 04:23, Muchun Song wrote:
>>>> When memory is hot-removed, section_deactivate() can tear down
>>>> mem_section->usage while concurrent pfn walkers still inspect the
>>>> subsection map via pfn_section_valid() or =
pfn_section_first_valid().
>>>=20
>>> I'll note that it's all racy either way: someone checking =
pfn_valid() /
>>> pfn_to_online_page() can race with concurrent unplug.
>>=20
>> Agree. When I first saw the commit message for 5ec8e8ea8b77, I was =
curious
>> because the goal of this commit was to fix an access issue with =
ms->usage.
>> Looking at the race diagram, I realized that while this only =
addresses the
>> ->usage access, subsequent accesses to struct page will still be =
problematic.
>> It's just that the former issue happened to be triggered first in =
this specific
>> commit.
>>=20
>>>=20
>>> We've known that for years; it's hard to fix; it never ever triggers =
:)
>>=20
>> Glad to know my analysis wasn't off! It seems I've just stumbled upon =
a
>> 'well-known secret' within the community. :)
>=20
> Heh, yes.
>=20
>>=20
>>>=20
>>> So is this really worth it, when we should in fact, work on =
protecting
>>> the users of pfn_valid() / pfn_to_online_page() with rcu or similar?
>>=20
>> I am not sure if it is worth fixing, especially since I just realized =
the
>> community has been aware of this issue for many years. If we do =
decide to
>> fix it, I think the most straightforward approach would be to protect =
it
>> using RCU, something like:
>>=20
>> 	# the user side of pfn_to_online_page():
>> 	rcu_read_lock();=20
>> 	page =3D pfn_to_online_page();
>> 	if (!get_page_unless_zero(page))
>>    		goto out_unlock;
>> 	rcu_read_unlock();
>=20
>=20
> Right, but we'd have to protect against the sections being marked as
> offline as well here, though. So against a pure concurrent =
offline_pages().

Right.

>=20
> If you're looking for a project, this is really one worth doing! :)
>=20

Initially, I wasn't sure if this issue was worth fixing, but it seems
we are moving in the right direction. I'll give it some more thought
in my spare time.

>=20
> pfn_to_online_page() is more in need for protection than pfn_valid() I
> think.

Agree.

Muchun,
Thanks.

>=20
> --=20
> Cheers,
>=20
> David


