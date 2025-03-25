Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B687254AED;
	Tue, 25 Mar 2025 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898494; cv=none; b=AWa6ntXW/fYV/To6rtQIQ5K0jaDsTEXHQZTghmB8WXDAMsbB3GfSn3PZikK1wpGXxKhxGO0zxafsr7qyb+z/gWzIs0AP02I/XOr2hfEmBFuDUNJLiLaOfv8JiIw+wZh0oKGGvE6FUwMSn5mNWydST1iozhjwKCq2NzvXUbIJJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898494; c=relaxed/simple;
	bh=VoMONhNNoSLZOMZUowEmZUtizC7WgFG9m+4dKgH/5w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWOLrH/8W8IU4f2Z3RUxulSOUlVIR7Xu/llj3ZYFus9IITFVjXb1y0U1dNLO+MNjqgWbOpCveNYIyDqf9gv6K1IMih1AqpU07mnbtKrfbHdj3SCgXXz8Gs42O6rytcoJ3U5xM9mR4HSBhTIAuq54iqMg7Tr9om23S+tsT862U5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-1d-67e28538ffd3
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v3 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Tue, 25 Mar 2025 19:27:39 +0900
Message-ID: <20250325102804.1020-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z-FfAUiGePF9mnPS@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsXC9ZZnoa5F66N0g/PfVSzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2qxek2GA5fHzll32T262y6z
	e7QcecvqsXjPSyaPTZ8msXucmPGbxWPnQ0uP9/uusnl83iQXwBnFZZOSmpNZllqkb5fAlXGt
	Yx17wVv2ituntBoYO9m6GDk5JARMJCZ+WsYIY29dvpGpi5GDg01ASeLY3hgQU0RAVaLtinsX
	IxcHs8AjJonT7UtZQcqFBcIlug8+ZAGxWYBqTjz5DjaGF2jMvdVtTBAjNSUaLt0DszkFzCTe
	TrwHtlZIgEfi1Yb9UPWCEidnPgGbwywgL9G8dTYzyDIJgftsEifurmGBGCQpcXDFDZYJjPyz
	kPTMQtKzgJFpFaNQZl5ZbmJmjoleRmVeZoVecn7uJkZgsC+r/RO9g/HTheBDjAIcjEo8vAHh
	D9OFWBPLiitzDzFKcDArifAeYwUK8aYkVlalFuXHF5XmpBYfYpTmYFES5zX6Vp4iJJCeWJKa
	nZpakFoEk2Xi4JRqYFzInOrxnnmXytuIUI5Om/Mf6wMtt/PV/UhW5foZH5WoWsGx49vPFz5G
	x+OVP1nvdHrPn/fcm/F9z4qnfiI7jm49cUz/ilO7uJOiqeLMvwv5vdXvGm1ed5VPeafBnAD/
	9T+qtQ4eX6lzbZYUw7Wt1+ousXucjv/7/ebxlf+SlGKOa7if7/m6iVGJpTgj0VCLuag4EQDV
	R8qBcgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsXCNUNNS9ei9VG6wY0ZYhZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLQ5de85q
	sXpNhsXvbSvYHPg8ds66y+7R3XaZ3aPlyFtWj8V7XjJ5bPo0id3jxIzfLB47H1p6vN93lc3j
	220Pj8UvPjB5fN4kF8AdxWWTkpqTWZZapG+XwJVxrWMde8Fb9orbp7QaGDvZuhg5OSQETCS2
	Lt/I1MXIwcEmoCRxbG8MiCkioCrRdsW9i5GLg1ngEZPE6falrCDlwgLhEt0HH7KA2CxANSee
	fGcEsXmBxtxb3cYEMVJTouHSPTCbU8BM4u3Ee2CrhAR4JF5t2A9VLyhxcuYTsDnMAvISzVtn
	M09g5JmFJDULSWoBI9MqRpHMvLLcxMwcU73i7IzKvMwKveT83E2MwABfVvtn4g7GL5fdDzEK
	cDAq8fBGxD1MF2JNLCuuzD3EKMHBrCTCe4wVKMSbklhZlVqUH19UmpNafIhRmoNFSZzXKzw1
	QUggPbEkNTs1tSC1CCbLxMEp1cAYtyO5Ye2lp9KRzepNEp+0jvPHnWWtNE5y+qwXnBz64MYf
	2R+eW88c5LFc9cagr4EtT/7U0u6atnDpvSpnZp638ouf7FXFKC9iYCsnsLNH/tXFlrT919ob
	Ltcb7Ym48Z49tiEuMG52RfJy9lsG/I7CN/00wqVeHLxpWSHTaTzlvlvZCRbuw0osxRmJhlrM
	RcWJAMl8FbNsAgAA
X-CFilter-Loop: Reflected

On Mon, 24 Mar 2025 09:32:49 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Mon, Mar 24, 2025 at 05:54:27PM +0900, Rakie Kim wrote:
> > 
> > I'm sorry, the code is missing.
> > I may not fully understand the scenario you described, but I think your concern
> > can be addressed by adding a simple check like the following:
> > 
> >     case MEM_OFFLINE:
> >         if (!node_state(nid, N_MEMORY)) --> this point
> >             sysfs_wi_node_release(nid);
> >
> 
> This should work.  I have some questions about whether there might be
> some subtle race conditions with this implementation, but I can take a
> look after LSFMM.  (Example: Two blocks being offlined/onlined at the
> same time, is state(nid, N_MEMORY) a raced value?)
> 
> ~Gregory

I will also further review the code for any race condition
issues. I intend to update v4 to incorporate the discussions
from this patch series. Your feedback and review of v4 after
LSFMM would be greatly appreciated.

Rakie

