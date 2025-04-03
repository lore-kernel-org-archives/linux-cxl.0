Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B2D2E3387;
	Thu,  3 Apr 2025 04:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743654409; cv=none; b=bMHwmf8P4dmPhWHKRq7zHJVcvXl5Se/QvMNvydmXzIEpFaMJWUprX3Zm3D4sFdmf0UQ0kE4mkFfxpQ24IlQbLnDYdCrJGT+saKsib/jXjmvzOt9x0NnvDMiuCFx61Iu+oHYtHXs7KarS9Itjx9K3c53d+HQLzGL/pb625uEBhis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743654409; c=relaxed/simple;
	bh=vlgcvDW4ZxSQUnObRrxIEjPutEKGjnjWmV9viZdwL68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMbxgKYii9YowcbEUP8pArkiKFrqGmMZjvI+fag19npfp87wjSE/35bQpbKzjhXz5dJXMrASznGX5Hw2RX4i+zr+RqNTIgKjxhlJcOIm3NyeEFj3m5Zc9lfDjBi56C9ff/zf3ICvby9bWKqgz81BmZZfyhmnPWe8lNY4esY9CPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-7d-67ee0e028556
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: Rakie Kim <rakie.kim@sk.com>,
	akpm@linux-foundation.org,
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
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v5 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Thu,  3 Apr 2025 13:26:14 +0900
Message-ID: <20250403042638.1127-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z-1niNVSTcb9ogzl@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnkS4T37t0g3MXxS3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2pxZlqRxeo1GQ7cHjtn3WX3
	6G67zO7RcuQtq8fiPS+ZPDZ9msTucWLGbxaPnQ8tPd7vu8rmsfl0tcfnTXIBXFFcNimpOZll
	qUX6dglcGYta2xkLLnJWvLvxir2B8RJ7FyMnh4SAicSpGY9ZYOy16/+xdTFycLAJKEkc2xsD
	YooIqEq0XXHvYuTiYBboYJb4eWgxE0i5sEC4xIX+rcwgNgtQzd8NV8DG8AKN+fm7mQlipKZE
	w6V7YDangJnE4infwNYKCfBIvNqwnxGiXlDi5MwnYL3MAvISzVtnM4MskxB4zyaxY90XqDsl
	JQ6uuMEygZF/FpKeWUh6FjAyrWIUyswry03MzDHRy6jMy6zQS87P3cQIDP9ltX+idzB+uhB8
	iFGAg1GJh7fj2tt0IdbEsuLK3EOMEhzMSiK8hVpAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG
	38pThATSE0tSs1NTC1KLYLJMHJxSDYyMDy5Y/ntvyXaV94fqWs6HTr1al47a1aWnHjY6E8Fi
	+rHEM06nL2/C8ii3J3Zep4X2GvoITt7vJ3JKQbRo3cK3BgpKaerSQX8tbPYLNve0hRiulww2
	CVPYey50g+y1K99YJhWePGpYdDwtPtKPIfsQ64PeOUbTm2WzpzPM+PDwmtv02RlnhZVYijMS
	DbWYi4oTAV9zNXh7AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXCNUNNS5eJ7126Qd8BNos569ewWUyfeoHR
	4uv6X8wWP+8eZ7f4/Ow1s8WqhdfYLI5vncducXjuSVaL87NOsVhc3jWHzeLemv+sFmemFVkc
	uvac1WL1mgyL39tWsDnwe+ycdZfdo7vtMrtHy5G3rB6L97xk8tj0aRK7x4kZv1k8dj609Hi/
	7yqbx7fbHh6LX3xg8th8utrj8ya5AJ4oLpuU1JzMstQifbsEroxFre2MBRc5K97deMXewHiJ
	vYuRk0NCwERi7fp/bF2MHBxsAkoSx/bGgJgiAqoSbVfcuxi5OJgFOpglfh5azARSLiwQLnGh
	fysziM0CVPN3wxUWEJsXaMzP381MECM1JRou3QOzOQXMJBZP+Qa2SkiAR+LVhv2MEPWCEidn
	PgHrZRaQl2jeOpt5AiPPLCSpWUhSCxiZVjGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgSG/LLa
	PxN3MH657H6IUYCDUYmH94LJ23Qh1sSy4srcQ4wSHMxKIryFWkAh3pTEyqrUovz4otKc1OJD
	jNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGRtf1ptxHWX/+281+mUtxtuhnz85LXC8M
	m3pnvpj55zuXm9Kmy388GsT2y3yPsJzJe6P6rtkdg5WLuc0t55j9jhE0L7CUOFD0qDHw30XJ
	zsemImdqzBeX6DKIryq+zmrWO/9V04486zTte2rzPbdst9j9TPvF9uplGve3uUmyVp42frVG
	KU/fWomlOCPRUIu5qDgRAJ5mFhZ1AgAA
X-CFilter-Loop: Reflected

On Wed, 2 Apr 2025 12:36:24 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Wed, Apr 02, 2025 at 05:41:57PM +0200, Oscar Salvador wrote:
> > 
> > Yes, this callback will be called whenever {online,offline}_pages succeeds, but
> > status_change_nid will be != NUMA_NO_NODE IFF the node state changes.
> > And you already have the check
> > 
> >  if (nid < 0)
> >     goto out
> > 
> > at the beginning, which means that all {offline,online}_pages operation that
> > do not carry a numa node state change will be filtered out there.
> > 
> > Makes sense, or am I missing something?
> >
> 
> Ah, you're quite right.  That was difficult to see on the surface, so
> the check in fact superfluous.  No need for an extra version, can just
> add a patch to squash and drop it.
> 
> ~Gregory

To Gregory and Oscar

As Oscar correctly pointed out, the check for
'if (!node_state(nid, N_MEMORY))' is unnecessary and should be removed.

Additionally, there are other suggestions from Dan Williams that should
be applied as well:
Link: https://lore.kernel.org/lkml/67ed66ef7c070_9dac294e0@dwillia2-xfh.jf.intel.com.notmuch/

I will incorporate all of these improvements and submit a new version (v6).

Rakie
