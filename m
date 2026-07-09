Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B823394C;
	Thu,  9 Jul 2026 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601990; cv=none; b=NCzhohmvBjfsGibfawLYg7aBOCv4qsilk8oZwxS2OZpCY0ipywHWl6ci8H8cUNsg7lZRP/3DaUyCTWLxj3JkeLJ6G94pcXgl5soLUGbBYJuPiIy7B+LrRISaMkd7dwPnaSFc2PaQHBaD7T0cFB3RDUgYiHTbyFG/pab20ZANzQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601990; c=relaxed/simple;
	bh=bEp/SwDJR7CpPvHZVDm4lsIX/Xkc8TkoSOT/Ey1REm4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uVh6LJlsSsE7EC0cUknbLZlDCMtzcyMfq/jMjuH8g7Zs+w7oPNKV/SviwcXA4+LjGVuZJhoby7EhIME6NbK22ouirNykfRfH+r6NpxC0AoljCM7egTUbJdAsMLxsRSOImjmijy7EwkgcikgllAFmMHQUoM7ALbQpCXi+rPmA5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3lGK4Te; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3lGK4Te"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B3F1F000E9;
	Thu,  9 Jul 2026 12:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601988;
	bh=dfPuN5XK89i90iKP7N1UEg6cXPRSfGHauPrCcp91Soo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=J3lGK4Te1f4zzXGsuskTvVM2iBsyuSztXeOmCggDo36HjJ3cFV8/MZPAkLsLFQuzS
	 lNVmeEbnta9/P5w6O6w9uM+11NdtyZUs9hA3OafhOr/Q4UHG5Xyq70hDx3FmpkjRla
	 UHBbV04VVT4urrcAR4hxuiIPkP/cdxeSW3G65y+mOSwDdd9ogtDLl6pcH5//9D/KrN
	 zlupO5ofc9MYYuFPrlnmkEaVq8YXf+uicS8JLzLuThh9pdRXv4cN+Hddu9XJIwCiF5
	 4nMf33vBikptKw71xYxPVonYLUz/vsdC46ymFQu11EvLzSAapT1ixwKexH6HjjBnD6
	 1DSahxeZccbnA==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@kernel.org>,  Alexander Graf <graf@amazon.com>,  Alexander
 Potapenko <glider@google.com>,  Brendan Jackman <jackmanb@google.com>,
  Christoph Lameter <cl@gentwo.org>,  Dennis Zhou <dennis@kernel.org>,
  Dmitry Vyukov <dvyukov@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  "Liam R. Howlett" <liam@infradead.org>,  Lorenzo
 Stoakes <ljs@kernel.org>,  Marco Elver <elver@google.com>,  Michal Hocko
 <mhocko@suse.com>,  Muchun Song <muchun.song@linux.dev>,  Oscar Salvador
 <osalvador@suse.de>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Suren Baghdasaryan
 <surenb@google.com>,  Tejun Heo <tj@kernel.org>,  Uladzislau Rezki
 <urezki@gmail.com>,  Vlastimil Babka <vbabka@kernel.org>,  Zi Yan
 <ziy@nvidia.com>,  kasan-dev@googlegroups.com,  kexec@lists.infradead.org,
  linux-cxl@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH v2 0/3] mm: split a couple of headers from internal.h
In-Reply-To: <20260709-internal-h-v2-0-695631425968@kernel.org> (Mike
	Rapoport's message of "Thu, 09 Jul 2026 13:00:02 +0300")
References: <20260709-internal-h-v2-0-695631425968@kernel.org>
Date: Thu, 09 Jul 2026 14:59:43 +0200
Message-ID: <2vxzh5m8l3nk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 09 2026, Mike Rapoport (Microsoft) wrote:

> mm/internal.h becomes more and more bloated.
>
> Split declarations related to mm_init, memblock, vmalloc and sparse into
> new headers.

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav
