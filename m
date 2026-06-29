Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9039D175A73;
	Mon, 29 Jun 2026 02:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782699690; cv=none; b=UIhQdsXI8mNxeKQNYimM+J2WClwpRoaT/Q8J9nF9fvs97s5+J1uO8+byyF+UAr4+8gMhfQDzE5/qZVIw8JRlVBJQf2eENU6oa4LRKPRdFhL0SVarWD0foQow27ThI4hwbiulAlTWAa6TKC6dStPSwyDFP6imDTpYN0VB25XbhJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782699690; c=relaxed/simple;
	bh=RFG3rzu5a6Ap7m/l0KIWt23agkjRtO1qq92PQWzi49w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKih/Lo6qFpAFlGtKMlACPy/NDGPo4KWIXXZfAPAzrl3jMo7BX5rXNE4LT37XBcIH/5OJWJF7q3icdINkGTDOs6bG1VSdJnP1xq9vgT6kkxeuROjuTrIxJ4wMnlM2ZH5MKCvQkntEv+IjHLJqM1HP+Ixl1jxEyy5/cyixZvUjns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org; spf=pass smtp.mailfrom=firstfloor.org; dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b=dJjN3COW; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="dJjN3COW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
	s=mail; t=1782699118;
	bh=RFG3rzu5a6Ap7m/l0KIWt23agkjRtO1qq92PQWzi49w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJjN3COWIwqRMqxwVgtQuQdggZDssaR78n9SWsZ7HMfD4HwLIMI0jbAltBaMq55sA
	 j0R3zPaOyQSOczagvtS+qsgwqDIuziba9Ons2RHL1M5XFhmzqWN8A/HZF6C/BrLncX
	 q6QXw5w2oCh7Wv9PvURMJr1nELOmwNuWVx5vE0mo=
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 70B0C5EAB0; Mon, 29 Jun 2026 04:11:58 +0200 (CEST)
Date: Sun, 28 Jun 2026 19:11:58 -0700
From: Andi Kleen <andi@firstfloor.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>, Byungchul Park <byungchul@sk.com>,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 0/2] mm: memory-failure: fix HWPoison flag race with
 non-atomic page flag ops
Message-ID: <akHUboUaYi-OJHFu@firstfloor.org>
References: <cover.1782676497.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1782676497.git.mst@redhat.com>

On Sun, Jun 28, 2026 at 05:45:22PM -0400, Michael S. Tsirkin wrote:
> This series fixes the race by:
> 
> 1. Having memory_failure() call synchronize_rcu() + retry after
>    setting HWPoison, so that any in-flight non-atomic RMW that
>    read the old flags value completes before we proceed.
>
> 2. Wrapping all non-atomic page flag operations in
>    rcu_read_lock/rcu_read_unlock (CONFIG_MEMORY_FAILURE only),
>    so that synchronize_rcu() actually drains them.

It wouldn't surprise me if your underlying performance assumptions 
-- an non contended atomic is cheaper than a rcu_read_lock/unlock --
are not true in various CPU/kernel configuration combinations.

Modern CPUs have fast atomics when uncontended in normal circumstances.

But it probably doesn't matter much either way because the difference
shouldn't be very much.  It seems very complicated for something that
could be much simpler.

But I guess it's fine.

-Andi

> 
> Performance impact (page alloc+free microbenchmark, 200K iterations,
> 20 runs, KVM guest, error bars are 3-sigma):
> 
>   !PREEMPT_RCU (x86):
>                          insns/iter      cycles/iter
>     base:                12237 +/- 1     17954 +/- 136
>     patched:             +22 +/- 1       -124 +/- 122
>                          (+0.18%)        (within noise)
> 
>   PREEMPT_RCU:
>                          insns/iter      cycles/iter
>     base:                12512 +/- 3     18541 +/- 214
>     patched:             +95 +/- 3       -12 +/- 161
>                          (+0.76%)        (within noise)
> 
> When !CONFIG_MEMORY_FAILURE, all wrappers compile away completely.
