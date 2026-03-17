Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D3B3B27E6;
	Tue, 17 Mar 2026 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748265; cv=none; b=cg3PWRILvHlL7wdHMnDssk/BTKjR2HG5QGzbgYzAMuQIgTBR1Roh3SITOmSJzk74qG6pL/desNYYl9KLkZk6JHsLBG0rcQNfmAsdVrXflN0Z6Z0GVmSsKs5z+RBHUgmz/w9K6CJnmBG4mF9LuuYNgvmSLnoBo9DU/ecfokLUO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748265; c=relaxed/simple;
	bh=DUj+idD95mjB0VwfZmTz3wtXfnzzG2t4C0/UkNQo8Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjSY6jKtx+mYK8/vDSkaEoh1MaxfKhXQfhekj1nj+35DF/dzTUZHok5Zq/vRj8BsV7oJHZs1U6vxdUwouvdh+Z5KPlSsoSFWwCVe2LvKnKDH/wMQuWGuGaHnFTMbX3fYgHtXo04Adz/8LM2c2SBv6p3dEBTWZxEvZBbGhPEk4/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-67-69b9401fe92c
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: Rakie Kim <rakie.kim@sk.com>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	harry.yoo@oracle.com,
	lsf-pc@lists.linux-foundation.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] [RFC PATCH 0/4] mm/mempolicy: introduce socket-aware weighted interleave
Date: Tue, 17 Mar 2026 20:50:47 +0900
Message-ID: <20260317115052.294-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <abhd1BXSST0BTDaN@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsXC9ZZnka68w85MgwuXJC3mrF/DZnH38QU2
	i103QiymT73AaHHiZiObxeqbaxgtnm/9xWjx8+5xdov7y56xWOx/+pzFYtXCa2wWx7fOY7fY
	3vCA3eL8rFMsFpd3zWGzuLfmP6vFyVkrWSz2vd7LbPGtT9rifp+DxZH125ksJl9awGYxu7GP
	0eLWhGNMFqvXZFjMPnqP3UHKY+esu+weCzaVenS3XWb3aDnyltVj8Z6XTB6bVnWyeWz6NInd
	48SM3yweOx9aeky+sZzRo7f5HZvHx6e3WDymzq73WL/lKovHmQVH2D0+b5ILEIjisklJzcks
	Sy3St0vgynj97ShbwSPBinuzj7M2MH7m7WLk5JAQMJHo27OWDcbet3I+SxcjBwebgJLEsb0x
	IKaIgKpE2xV3kApmgQ42iWmnZUBsYYEMiQnL/zOD2CxAJScad7OA2LwCxhJt3Q9ZICZqSqzb
	eAvM5hQwk7j/sxVsk5AAj8SrDfsZIeoFJU7OfMICMV9eonnrbKCZXEC9P9klnl5bDnWapMTB
	FTdYJjDyz0LSMwtJzwJGplWMQpl5ZbmJmTkmehmVeZkVesn5uZsYgZG8rPZP9A7GTxeCDzEK
	cDAq8fDeYN2RKcSaWFZcmXuIUYKDWUmEd9mRbZlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY2+
	lacICaQnlqRmp6YWpBbBZJk4OKUaGF3CNRVaD1fd0ki4xGIQbGfZ4iJUOMtxNQebnMu7LI7S
	0z1LT3n+mM59LCF31ozejg3Llkz+kqZz/eMHpkXX5lxe/3KCrnuUIPPJWZ7S17UF925uXMKc
	VPPhB9f34/rvbQ5wzl63u9SH90En5wvbmC/vLr9lWm+lf0EhZ4v+ZvXJfNnMk01331FiKc5I
	NNRiLipOBAA/p30y4AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRyHe3fec3YUF8cledJAWFRT8kZlr1Cmn3wJQokgCkmHHtzJK5uK
	E6KJKalommm6WRmSl7m8jLytVPI+u0mmuXnLzDt2MyQvYC4J/Pbwfx5+X/40Ie6CTjQfm8Ap
	YmXREsoW2hYfD3F38W/lveY1NCqt01NoYmaQQsbRy+jdfS2FHhQOAtRvTqVQjVkP0HzjBkDr
	E31CNFUxB9Hq3DKBOmbnIdI9GaFQX+MjIep6aCJRs/qzEL3XDEA0ZCyl0KR+m0QmTTVE7ctt
	BFrLdUZTuf6oc2SeRN11zQJU8KGMQtrUXIAseb0CVKOXo82mqp1Tz6TQ3wW3aiaEuMyQiLMz
	hoT4dvcKictfLgqwQZdJYcOve0LcX7wJceu0Ly4YrQQ4J+0bhX/OWiBeG8O4fOGHABdqb+G6
	58MwWHzN9mwEF80ncQpPvzBb+fJaDxX/xT55UttHqsGqKAvY0Cxzim2vfgyzAE1TjITtbQux
	ogNzlM34GGgtCOYOxRa9PmzlA4yczavcJqwMd5L+1BfQyiLmJJuRPQ13F13Z2gbLP7ZhfNip
	9XTKymLGjl2q7wC7vT1rKvkKd/dd2LRGLZEH7DR7lGaPKgMCHXDgY5NiZHz0aQ9llFwVyyd7
	hMfFGMDOaytubuW3gN9DgZ2AoYHETjRKtvBiUpakVMV0ApYmJA6iiu4mXiyKkKlSOEVcqCIx
	mlN2AmcaShxFF65wYWImUpbARXFcPKf4bwW0jZMalKCtJoHrK/MZ92U+DfrW7p9rTvmUsmBU
	x9O68YPSnEubM25sbtu5jWCfsXFp0TF5VOJbL5Pl+g3VoqOncCNc375dFXC113vhTZDfeZeB
	gtCiYYKoP0SK/yyZT5QG5auznu27KA2UjqVnPo2YarsbKfEyxjV8LzO5rQQFHFG1S6BSLvN2
	IxRK2V8pEuWd1gIAAA==
X-CFilter-Loop: Reflected

On Mon, 16 Mar 2026 15:45:24 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Mon, Mar 16, 2026 at 08:19:32AM -0700, Joshua Hahn wrote:
> > 
> > In that sense I thought the word "prefer" was a bit confusing, since I
> > thought it would mean that it would try to fulfill the alloactions
> > from within a packet first, then fall back to remote packets if that
> > failed. (Or maybe I am just misunderstanding your explanation. Please
> > do let me know if that is the case : -) )
> > 
> > If what I understand is the case , I think this is the same thing as
> > just restricting allocations to be socket-local. I also wonder if
> > this idea applies to other mempolicies as well (i.e. unweighted interleave)
> > 
> 
> I was thinking about this as well, and in my head i think you have to
> consider a 2x2 situation
> 
> cpuset             |   multi-socket-cpu      single-socket-cpu
> ==================================================================
> single-socket-mem  |     mem-package            mem-package
> ------------------------------------------------------------------
> multi-socket-mem   |       global                 global
> ------------------------------------------------------------------
> 
> But I think this reduces to cpuset nodes dictates the weights used -
> which should already be the case with the existing code.

Hello Gregory,

Thanks for your additional feedback.

I agree with your analysis. The final behavior should follow the nodes
dictated by the cpuset or mempolicy configurations.

> 
> I think you are right that we need to be very explicit about the
> fallback semantics here - but that may just be a matter of dictating
> whether the allocation falls back or prefers direct reclaim to push
> pages out of their requested nodes.
> 
> ~Gregory

As you and Joshua pointed out, making the fallback semantics explicit
is the most critical issue for this patch series. We need a clear policy
to decide whether the allocation should fall back to a remote node or
force direct reclaim to keep the allocation local.

I will explicitly define these fallback semantics and address this
trade-off in the design for the next version.

Thanks again for your time and review.

Rakie Kim

