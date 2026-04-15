Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6483C225397
	for <linux-cxl@vger.kernel.org>; Wed, 15 Apr 2026 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244864; cv=none; b=LLaLwCKSjeaY3LoywR+IpWSInXwQI+Hl/uTCzEC1eu6jMrY+avLMREajQ2sHO1OIu2Vi2A+ppuxTVaUA68jvk7Wc8nsoiK3p1xFvFNJDbhV0RzpAPylNu9Vqxk5H2rojK0xU+ifw3YEi2Hh0Ls8zFWxs+I2gnMgCO0ANiIVJU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244864; c=relaxed/simple;
	bh=vtWWxOD7ZBgJfjim7JudPIC7ZLZ4tf5a4fI0Fc4eolA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JKc9bZmvp29DvtQLhB4LS2PG6NrbdvBP0fd5FM3k/iWf2f1LCDHO1XiBriUu62Jt4Dtq8/eBQ8D1Pjmo3+gCPrTDCnnJpo3aYZUB469OE+SK/sYMrQVrWmg5v/tWn9bBBjCGQaH2Bw9syiC/YWzew47KCuPtNS8LakrCFy3QF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NS6QT61T; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NS6QT61T"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776244861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/TEMft9/PMqUHmiKPhVIMzXi/K65izkkDIFtpJ0pcw=;
	b=NS6QT61Tr4egecjIz/IWqLyXbWLG72UKaw4+7vh3Y2pE7zgmwIcgHD099KszHagiV7aTvL
	hNUNbtjlKiun0T1bGqc4DVrGC83iCLlOErmRbX/ZPxM13HCsh9aNQ8mIoaGbLiP0cSKicu
	0O/db+gqzQiQgUIe7F/w/PNEaW7kxFU=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] mm/sparse: Fix race on mem_section->usage in pfn walkers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <09d1ef13-e02b-41e9-b431-4c3254e42011@kernel.org>
Date: Wed, 15 Apr 2026 17:20:13 +0800
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
Message-Id: <B139F2C1-77CB-43A5-8377-4F4BD44ADC6C@linux.dev>
References: <20260415022326.53218-1-songmuchun@bytedance.com>
 <09d1ef13-e02b-41e9-b431-4c3254e42011@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 15, 2026, at 16:04, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/15/26 04:23, Muchun Song wrote:
>> When memory is hot-removed, section_deactivate() can tear down
>> mem_section->usage while concurrent pfn walkers still inspect the
>> subsection map via pfn_section_valid() or pfn_section_first_valid().
>=20
> I'll note that it's all racy either way: someone checking pfn_valid() =
/
> pfn_to_online_page() can race with concurrent unplug.

Agree. When I first saw the commit message for 5ec8e8ea8b77, I was =
curious
because the goal of this commit was to fix an access issue with =
ms->usage.
Looking at the race diagram, I realized that while this only addresses =
the
->usage access, subsequent accesses to struct page will still be =
problematic.
It's just that the former issue happened to be triggered first in this =
specific
commit.

>=20
> We've known that for years; it's hard to fix; it never ever triggers =
:)

Glad to know my analysis wasn't off! It seems I've just stumbled upon a
'well-known secret' within the community. :)

>=20
> So is this really worth it, when we should in fact, work on protecting
> the users of pfn_valid() / pfn_to_online_page() with rcu or similar?

I am not sure if it is worth fixing, especially since I just realized =
the
community has been aware of this issue for many years. If we do decide =
to
fix it, I think the most straightforward approach would be to protect it
using RCU, something like:

# the user side of pfn_to_online_page():
	rcu_read_lock();=20
	page =3D pfn_to_online_page();
	if (!get_page_unless_zero(page))
	    goto out_unlock;
	rcu_read_unlock();


# the vmemmap freeing side should free the vmemmap pages via RCU.


Thanks,
Muchun

>=20
> --=20
> Cheers,
>=20
> David

