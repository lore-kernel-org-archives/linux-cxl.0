Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1E019AA56;
	Thu,  3 Apr 2025 04:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743654372; cv=none; b=nk6pSPfk0Ej8K8HEcjf0mLDSkivkgOb4+IqPHNcZ9oefq9XLWsttHtKcC1pPMF4n9vE7PaollqZ2B9ISbK/KuLK/uKHxFhRW4RdIS5TcHiREnNmodVpwjtvdV6vho3ssy5gPp4pClI2e5/98uEjnVpy1g8xUHSNsS5Mb9/GEoMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743654372; c=relaxed/simple;
	bh=aPizDx7w9H/yYrcDA9OrBEWDz87opw/7Tq92eqSr2Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ew54uIpWA4ykPECjrVXQmYVBun8hNmWXdDMa/J6aIe3iYE4BBzGm31eYyodrTPV+Pl7/fFzv//jOgbvIwjPIyHXYoVxRKCoKryAvUIzRXJko3hPt/zbzlGv2aWu8QWH24vjRuebkx6Vqj6AB03KJlqz7SBGJK67Dt7B6KcxOWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-c2-67ee0dd482b0
From: Rakie Kim <rakie.kim@sk.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rakie.kim@sk.com,
	gourry@gourry.net
Subject: Re: [PATCH v3 2/3] mm/mempolicy: Support dynamic sysfs updates for weighted interleave
Date: Thu,  3 Apr 2025 13:25:42 +0900
Message-ID: <20250403042552.1116-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <67ed66ef7c070_9dac294e0@dwillia2-xfh.jf.intel.com.notmuch>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsXC9ZZnoe5V3nfpBvtaGC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2qxek2GA5fHzll32T262y6z
	e7QcecvqsXjPSyaPTZ8msXucmPGbxWPnQ0uP9/uusnl83iQXwBnFZZOSmpNZllqkb5fAlXGl
	czVbQT9/Ref/P0wNjGt4uhg5OSQETCT6ftxihbG7761n7mLk4GATUJI4tjcGJCwioC0xcc5B
	oDAXB7PAeSaJF91z2EESwgLxEm+uXGcEsVkEVCV+z+kDi/MCzdl2ooMZYqamRMOle0wgNqeA
	h8SlB89YQGwhAR6JVxv2M0LUC0qcnPkELM4sIC/RvHU22DIJgddsEktuL2GCGCQpcXDFDZYJ
	jPyzkPTMQtKzgJFpFaNQZl5ZbmJmjoleRmVeZoVecn7uJkZgwC+r/RO9g/HTheBDjAIcjEo8
	vB3X3qYLsSaWFVfmHmKU4GBWEuEt1AIK8aYkVlalFuXHF5XmpBYfYpTmYFES5zX6Vp4iJJCe
	WJKanZpakFoEk2Xi4JRqYPSsMu2PkV7SPJNptbBNR+ETpcq07QdDNlU6vX0yvSlP6P7UxbOS
	+SZ579jJLvhz4Z15XccWvXutInH35E790p3aX3ym+PLUsUwon6BUGT3NS223pMF7VhnNVU92
	JVQ8/ZTzbXnt6xM+i5xnnH6S11X3zPay5+u2io5Ct06p+px5l6/wR+p/01ZiKc5INNRiLipO
	BAB4KEFKdAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXCNUNNS/cK77t0gwcTzSzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWhy69pzV
	YvWaDIvf21awOfB57Jx1l92ju+0yu0fLkbesHov3vGTy2PRpErvHiRm/WTx2PrT0eL/vKpvH
	t9seHotffGDy+LxJLoA7issmJTUnsyy1SN8ugSvjSudqtoJ+/orO/3+YGhjX8HQxcnJICJhI
	dN9bz9zFyMHBJqAkcWxvDEhYREBbYuKcg0BhLg5mgfNMEi+657CDJIQF4iXeXLnOCGKzCKhK
	/J7TBxbnBZqz7UQHM8RMTYmGS/eYQGxOAQ+JSw+esYDYQgI8Eq827GeEqBeUODnzCVicWUBe
	onnrbOYJjDyzkKRmIUktYGRaxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJERjky2r/TNzB+OWy
	+yFGAQ5GJR7eCyZv04VYE8uKK3MPMUpwMCuJ8BZqAYV4UxIrq1KL8uOLSnNSiw8xSnOwKInz
	eoWnJggJpCeWpGanphakFsFkmTg4pRoYtf7P3yHsbG+2eaL5uyfFBvdeHZ4RFMst1Xn2w9LO
	HpO9Avs5Vx48sqEg9LX2KrmTE3f5bfkv+O1FmGVQBpNt4SaHbTv+fak3O74u+vtn+Q9iKb8/
	vn9e8myF1++TB40llm5tSV579wB7Xr9ui+rPbV5m92ZKmcrISlx9mdm0VneRTO7bo8cdfiux
	FGckGmoxFxUnAgCVq797bgIAAA==
X-CFilter-Loop: Reflected

On Wed, 2 Apr 2025 09:33:51 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> Rakie Kim wrote:
> > Previously, the weighted interleave sysfs structure was statically
> > managed, preventing dynamic updates when nodes were added or removed.
> > 
> > This patch restructures the weighted interleave sysfs to support
> > dynamic insertion and deletion. The sysfs that was part of
> > the 'weighted_interleave_group' is now globally accessible,
> > allowing external access to that sysfs.
> > 
> > With this change, sysfs management for weighted interleave is
> > more flexible, supporting hotplug events and runtime updates
> > more effectively.
> 
> I understand the urge to try to make a general case for a patch, but it
> is better to state the explicit reason especially when someone is later
> reading the history and may not realize that this is part of a series.
> 
> So instead of making claims like "this is more flexible / more effective
> for runtime updates", state that motivation explicitly.  Something like:
> 
> "In preparation for enabling weighted-interleave sysfs attributes to
> react to node-online/offline events, introduce sysfs_wi_node_add() and
> sysfs_wi_node_delete() helpers to dynamically manage the
> weighted-interleave attributes.
> 
> A follow-on patch registers a memory-hotplug notifier to use these
> helpers, for now just refactor the current "publish all possible node"
> approach to use sysfs_wi_node_{add,delete}()."
> 

Hi Dan Williams,

Thank you for your response regarding this patch.

First, I would like to mention that this version is v3, and the latest
version is v5:
https://lore.kernel.org/lkml/20250402014906.1086-1-rakie.kim@sk.com/

However, I believe that all of your suggestions should also apply to v5,
and I completely agree with your feedback.

I will incorporate the improvements you proposed and prepare v6
accordingly.

Rakie
