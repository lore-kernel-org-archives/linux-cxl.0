Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506E419ABDE;
	Thu,  3 Apr 2025 05:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743659151; cv=none; b=a03+hGbhPtgUPrVg2MwzlUo4E9R3H+aC+Czr3KOU6LUtf3k4aXRIckuGapWypWfuCfypcnXLyHufyBHyNHnnNb9d69d2jFBzD+xi2ZMRRM0XLqbWZsoFpgyGDniHxVczQnOgjn4LFwipkJrC2np4KTGcaaNoYtjKdFhzQ44uLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743659151; c=relaxed/simple;
	bh=DBLwzQ0WTX7g3J2sanPJikAqBbPlWzONtELGQA6jwgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUvC3TYmQ1VZU+tImulRSnIr+mfQZAqkxi/C7BqojTo8HiCu9qPC4Ow4lVcr+BC7KnXY9NAT9/1y8oVGmWbG+Xl57nRiOH4jHVAtnjp86gmWLmojGm3TCu5e2ZuElnJckKxtETyrthSnsWK5MLSFQUcX0soLBhsMzlOmaFXRZYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-b0-67ee20867fcf
From: Rakie Kim <rakie.kim@sk.com>
To: akpm@linux-foundation.org
Cc: Rakie Kim <rakie.kim@sk.com>,
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
	Oscar Salvador <osalvador@suse.de>,
	Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v5 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Thu,  3 Apr 2025 14:45:28 +0900
Message-ID: <20250403054536.1138-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250403042638.1127-1-rakie.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnoW6bwrt0g1cnpCzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2pxZlqRxeo1GQ7cHjtn3WX3
	6G67zO7RcuQtq8fiPS+ZPDZ9msTucWLGbxaPnQ8tPd7vu8rmsfl0tcfnTXIBXFFcNimpOZll
	qUX6dglcGZNX3mIp2CRW8fLzVtYGxs1CXYycHBICJhKHH/9hh7FnvD3I0sXIwcEmoCRxbG8M
	SFhEQFZi6t/zQGEuDmaBCcwSZ9YeZQJJCAuES1zo38oMYrMIqEpMvvGPFcTmBZrz+MZtNoiZ
	mhINl+6B1XMKmErcaVoFVi8kwCPxasN+Roh6QYmTM5+wgNjMAvISzVtnM4MskxD4zCYx9cJ6
	qEGSEgdX3GCZwMg/C0nPLCQ9CxiZVjEKZeaV5SZm5pjoZVTmZVboJefnbmIERsCy2j/ROxg/
	XQg+xCjAwajEw9tx7W26EGtiWXFl7iFGCQ5mJRHeQi2gEG9KYmVValF+fFFpTmrxIUZpDhYl
	cV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBkblSd0TeKz5DfbWCk48/azT6It0tR/rUoVliceK
	Tpvp8b/WOiR6x+LJ/7ol4Qbbt7C6+8TH3ZfieMs9+5zBorK0o/er+lbMb+Fcc2DVV9OvU/80
	X2OZcmsfs3HGauHN7w1MmPxvuj4Q1r4RnPhWZ8tDdh+Zhucf/XdWLFkfw3Xg+vuAPk9nSVcl
	luKMREMt5qLiRADw65lDfAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCNUNNS7dN4V26wdkzPBZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLc5MK7I4
	dO05q8XqNRkWv7etYHPg99g56y67R3fbZXaPliNvWT0W73nJ5LHp0yR2jxMzfrN47Hxo6fF+
	31U2j2+3PTwWv/jA5LH5dLXH501yATxRXDYpqTmZZalF+nYJXBmTV95iKdgkVvHy81bWBsbN
	Ql2MnBwSAiYSM94eZOli5OBgE1CSOLY3BiQsIiArMfXveaAwFwezwARmiTNrjzKBJIQFwiUu
	9G9lBrFZBFQlJt/4xwpi8wLNeXzjNhvETE2Jhkv3wOo5BUwl7jStAqsXEuCReLVhPyNEvaDE
	yZlPWEBsZgF5ieats5knMPLMQpKahSS1gJFpFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmDQ
	L6v9M3EH45fL7ocYBTgYlXh4L5i8TRdiTSwrrsw9xCjBwawkwluoBRTiTUmsrEotyo8vKs1J
	LT7EKM3BoiTO6xWemiAkkJ5YkpqdmlqQWgSTZeLglGpglBaYPOnu4xn2Vz2zjGxPWG3tzGWS
	+LF5NYfy68A0C/uj0xRiDDRXMt3Xe9DjJRP4a0JQ8aJ1b6YEJnc9dP3JLM6+lvNv0zJtt8of
	VqHLy259Ddv/rzqatWsrw/UgnqbHE7aprODpETzf8+YIa6LzxftNDDNmC6jw8rZdfdUze+qF
	FwvXSob2KrEUZyQaajEXFScCAORpqBh2AgAA
X-CFilter-Loop: Reflected

On Thu,  3 Apr 2025 13:26:14 +0900 Rakie Kim <rakie.kim@sk.com> wrote:
> On Wed, 2 Apr 2025 12:36:24 -0400 Gregory Price <gourry@gourry.net> wrote:
> > On Wed, Apr 02, 2025 at 05:41:57PM +0200, Oscar Salvador wrote:
> > > 
> > > Yes, this callback will be called whenever {online,offline}_pages succeeds, but
> > > status_change_nid will be != NUMA_NO_NODE IFF the node state changes.
> > > And you already have the check
> > > 
> > >  if (nid < 0)
> > >     goto out
> > > 
> > > at the beginning, which means that all {offline,online}_pages operation that
> > > do not carry a numa node state change will be filtered out there.
> > > 
> > > Makes sense, or am I missing something?
> > >
> > 
> > Ah, you're quite right.  That was difficult to see on the surface, so
> > the check in fact superfluous.  No need for an extra version, can just
> > add a patch to squash and drop it.
> > 
> > ~Gregory
> 
> To Gregory and Oscar
> 
> As Oscar correctly pointed out, the check for
> 'if (!node_state(nid, N_MEMORY))' is unnecessary and should be removed.
> 
> Additionally, there are other suggestions from Dan Williams that should
> be applied as well:
> Link: https://lore.kernel.org/lkml/67ed66ef7c070_9dac294e0@dwillia2-xfh.jf.intel.com.notmuch/
> 
> I will incorporate all of these improvements and submit a new version (v6).
> 
> Rakie

To Andrew

I sincerely apologize for the inconvenience. It appears that this commit
still requires additional corrections. I would appreciate it if you could
drop the changes you merged into -mm, mm-new branch yesterday.

<1>
The patch titled
     Subject: mm/mempolicy: fix memory leaks in weighted interleave sysfs has been added to the -mm mm-new branch.  Its filename is
     mm-mempolicy-fix-memory-leaks-in-weighted-interleave-sysfs.patch
This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-mempolicy-fix-memory-leaks-in-weighted-interleave-sysfs.patch
<2>
The patch titled
     Subject: mm/mempolicy: support dynamic sysfs updates for weighted interleave has been added to the -mm mm-new branch.  Its filename is
     mm-mempolicy-support-dynamic-sysfs-updates-for-weighted-interleave.patch
This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-mempolicy-support-dynamic-sysfs-updates-for-weighted-interleave.patch
<3>
The patch titled
     Subject: mm/mempolicy: support memory hotplug in weighted interleave has been added to the -mm mm-new branch.  Its filename is
     mm-mempolicy-support-memory-hotplug-in-weighted-interleave.patch
This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-mempolicy-support-memory-hotplug-in-weighted-interleave.patch

Rakie
