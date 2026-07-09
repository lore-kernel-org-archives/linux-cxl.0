Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5863CA4B8
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583364; cv=none; b=BaQrK6HAWJ9z1m75W9IpU/vAqh0tsuxFXAgjMwxk49KOUjwpbjbiuFPayuBQPoA+Pj/QC2s6ZyQexH93iggr7ZiNPI8Jq0Kw50ETMuUFVeX31VSWxSG1sf9UTThMQOLqFV215VLfksV301Q811SvWAhBCJ5qYS6InD4rE3kNwkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583364; c=relaxed/simple;
	bh=sjygaRxymsC0+lG2utyVu2zfqjQYhN7OPx54YbviX+Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=O5QbQT+QMJnzfXUhddt1a/5pZLxAT2kKelVt61DprpoubAMNwxLFpjmiyMAxEx+jlg1AaS+6uTaofWbUPABtc1vrM37Rs9r29pCODtEQ0Bfj5djW64QSbxTZeS+jiElMHdxs4hd69E/Syuy6oKhQulrJ1T+GaOKr0nfMWg+cArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QxdDwnTR; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QxdDwnTR"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783583347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bz0ZIC6honVFONNe2kkGW+tQ+zqDAmMEe2v+OkKeqyU=;
	b=QxdDwnTRWm20VGliIkKhSn+dBliUnrpDgqk1fVsnpLGkywZOxT18NohgKhFG+VAe81Oqpb
	vZaKdUdBDjHYwNPbzP5z3Pr0BIIxbex1rg7tb6d3ea96i0kT0gM7H/us5Hnt3JI8etR/pk
	s6kFktWl8bcGGK9Saz4/zUix/SFzyk0=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 0/3] mm: split a couple of headers from internal.h
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ak9MO-FWjkgr22KL@kernel.org>
Date: Thu, 9 Jul 2026 15:48:19 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Alexander Graf <graf@amazon.com>,
 Alexander Potapenko <glider@google.com>,
 Brendan Jackman <jackmanb@google.com>,
 Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>,
 Dmitry Vyukov <dvyukov@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Marco Elver <elver@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Oscar Salvador <osalvador@suse.de>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Tejun Heo <tj@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Zi Yan <ziy@nvidia.com>,
 kasan-dev@googlegroups.com,
 kexec@lists.infradead.org,
 linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B53B1031-B655-4526-B1AC-952BE39D96D3@linux.dev>
References: <20260709-internal-h-v1-0-956d5092782d@kernel.org>
 <ak9MO-FWjkgr22KL@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Jul 9, 2026, at 15:22, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Thu, Jul 09, 2026 at 09:41:46AM +0300, Mike Rapoport (Microsoft) =
wrote:
>> mm/internal.h becomes more and more bloated.
>>=20
>> Split declarations related to mm_init, memblock, vmalloc and sparse =
into
>> new headers.
>=20
> Sashiko rightfully pointed to some issues, will send v2 later.

Hi Mike,

I recall that this work was mentioned during the last review in my =
series.
However, I didn't have time to address it then because I was still =
working
on the HVO refactoring. I really appreciate you taking this on. Thanks =
for
your work.

I've reviewed Sashiko's comments as well, and it doesn't look like there =
are
any major issues. Therefore, feel free to add my ack for this whole =
series
in your v2 version with the proper fix.

Acked-by: Muchun Song <muchun.song@linux.dev>

Muchun,
Thanks

>=20
>> ---
>> Mike Rapoport (Microsoft) (3):
>>      mm: split out mm_init and memblock declarations from internal.h
>>      mm: split out sparse declarations from internal.h
>>      mm: split out vmalloc declarations from internal.h
>>=20
>> MAINTAINERS                        |   3 +
>> kernel/liveupdate/kexec_handover.c |   3 +-
>> mm/cma.c                           |   1 +
>> mm/execmem.c                       |   1 +
>> mm/hugetlb.c                       |   1 +
>> mm/internal.h                      | 183 =
-------------------------------------
>> mm/kmsan/hooks.c                   |   1 +
>> mm/kmsan/shadow.c                  |   1 +
>> mm/memblock.c                      |   1 +
>> mm/memory_hotplug.c                |   1 +
>> mm/mm_init.c                       |   3 +
>> mm/mm_init.h                       | 120 ++++++++++++++++++++++++
>> mm/page_alloc.c                    |   1 +
>> mm/percpu-vm.c                     |   1 +
>> mm/sparse-vmemmap.c                |   2 +
>> mm/sparse.c                        |   2 +
>> mm/sparse.h                        |  63 +++++++++++++
>> mm/vmalloc.c                       |   1 +
>> mm/vmalloc.h                       |  46 ++++++++++
>> 19 files changed, 251 insertions(+), 184 deletions(-)
>> ---
>> base-commit: 820d5dfede0cd55dcbc89ce96fcfbb11b7c457ba
>> change-id: 20260707-internal-h-2efef660381d
>>=20
>> --
>> Sincerely yours,
>> Mike.
>>=20
>=20
> --=20
> Sincerely yours,
> Mike.


