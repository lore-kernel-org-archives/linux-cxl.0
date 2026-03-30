Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636D5389E07;
	Mon, 30 Mar 2026 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864064; cv=none; b=Tl7Cmea/tlF4b8Up4xJAJ+GkOB2XnZXVxJ2DzEcmZM3pvrT/+4BbpzhyeHl0npVko9BPCDkUE8e7ZwMKEGN3RFcVZZAiaD82ftEPL0dqIENBIjLc+gvafx7QnvgPT+cJWMBt95thVRINR+gqwzhqmxpZwyuyhsiZCFUTZ4RS6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864064; c=relaxed/simple;
	bh=XV7ZhyWKSkcYUr2FMm+gAq7VOSVORpizBUGLyoOk6QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BG22cchYIip503RKhWPt9zJOiEi5KzOpv1WKIcFzIrgoeXFePyx3e+/yNBtJnX9Fic/KB9CoUFd0TS9z/T0atGB19hoUfxRfovWb+zQbuhJfcAQxeY7b4fFV50uIhfrXGHH4CmgLCd3w3ct7QBD8tKJKnKLxYz1umuVeRaASGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-3c-69ca46b88de5
From: Rakie Kim <rakie.kim@sk.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: akpm@linux-foundation.org,
	gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
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
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [RFC PATCH 2/4] mm/memory-tiers: introduce socket-aware topology management for NUMA nodes
Date: Mon, 30 Mar 2026 18:47:23 +0900
Message-ID: <20260330094733.425-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260318122242.00004e0d@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsXC9ZZnke4Ot1OZBmumG1rMWb+GzeLu4wts
	FrtuhFhMn3qB0eLEzUY2i9U31zBaPN/6i9Hi593j7Bb7nz5nsVi18BqbxfGt89gttjc8YLc4
	P+sUi8XlXXPYLO6t+c9qcXLWShaLb33SFvf7HCyOrN/OZDH50gI2i9mNfYwWtyYcY7JYvSbD
	YvbRe+wOEh47Z91l91iwqdSju+0yu0fLkbesHov3vGTy2LSqk81j06dJ7B4nZvxm8dj50NKj
	t/kdm8fHp7dYPKbOrvdYv+Uqi8eZBUfYPT5vkgvgj+KySUnNySxLLdK3S+DK2LTkFVPBa4WK
	Sy/3sjQwrpLqYuTgkBAwkdjQG9bFyAlm3pk+iRUkzCagJHFsbwxIWETASOJVzwHGLkYuDmaB
	zawSD8/3sYAkhAXSJaZdmwxmswioSmzdcxHM5hUwlviw7zMzxExNiXUbb4HFOQUMJb5PaGUC
	sYUEeCRebdjPCFEvKHFy5hOwGmYBeYnmrbOZQZZJCPxklzh75A0jxCBJiYMrbrBMYOSfhaRn
	FpKeBYxMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECo3VZ7Z/oHYyfLgQfYhTgYFTi4TVgO5kp
	xJpYVlyZe4hRgoNZSYS3e/qxTCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNT
	UwtSi2CyTBycUg2MStJX9pgu6V+aqzP3iHP4sbqX9z8efCO6JF1M+zz3EXkWt/UKJ9tP9dze
	v4t7U/OSM3nmoRvv/Q7Y+8bxxZMvfrtqajtSrpw4PJ3zwf9rXRHL0gW0M9L9FB/vtdh34tu5
	C14zzwn+FGWXM5/DJnuJ12rddi6jGrNtp7/w8zi8VbAzKRXtUZTdpsRSnJFoqMVcVJwIAGld
	VcLSAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsXCNUM9RneH26lMg9d7FC3mrF/DZnH38QU2
	i103QizOTZnNZjF96gVGixM3G9ksVt9cw2jxfOsvRoufd4+zW3x+9prZYv/T5ywWqxZeY7M4
	vnUeu8XhuSdZLbY3PGC3OD/rFIvF5V1z2CzurfnPanFy1koWi2990hb3+xwsDl17zmpxZP12
	JovJlxawWcxu7GO0uDXhGJPF6jUZFr+3rQAKHb3H7iDrsXPWXXaPBZtKPbrbLrN7tBx5y+qx
	eM9LJo9NqzrZPDZ9msTucWLGbxaPnQ8tPXqb37F5fHx6i8Xj220Pj8UvPjB5TJ1d77F+y1UW
	jzMLjrAHCEZx2aSk5mSWpRbp2yVwZWxa8oqp4LVCxaWXe1kaGFdJdTFyckgImEjcmT6JtYuR
	g4NNQEni2N4YkLCIgJHEq54DjF2MXBzMAptZJR6e72MBSQgLpEtMuzYZzGYRUJXYuucimM0r
	YCzxYd9nZoiZmhLrNt4Ci3MKGEp8n9DKBGILCfBIvNqwnxGiXlDi5MwnYDXMAvISzVtnM09g
	5JmFJDULSWoBI9MqRpHMvLLcxMwcU73i7IzKvMwKveT83E2MwChdVvtn4g7GL5fdDzEKcDAq
	8fAasJ3MFGJNLCuuzD3EKMHBrCTC2z39WKYQb0piZVVqUX58UWlOavEhRmkOFiVxXq/w1AQh
	gfTEktTs1NSC1CKYLBMHp1QDY+uube5+X0o21y7n/T7p65Oa1XuuiFu9s18rcrta+TaTvmma
	6kffN193FCTvvWN7kWnupF9Rn8QlHOdf/vFszZVL/P8rnKR+9AotvKZ+atnU5wJed+Nl38nV
	Pv/xIoSx6TET07qTnwKcjml65m/+csaeMe6TfddxvxrVyAMrb8ucvc1+dIXUES8lluKMREMt
	5qLiRAAqZ2b+zgIAAA==
X-CFilter-Loop: Reflected

On Wed, 18 Mar 2026 12:22:42 +0000 Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> On Mon, 16 Mar 2026 14:12:50 +0900
> Rakie Kim <rakie.kim@sk.com> wrote:
> 
> > The existing NUMA distance model provides only relative latency values
> > between nodes and lacks any notion of structural grouping such as socket
> > or package boundaries. As a result, memory policies based solely on
> > distance cannot differentiate between nodes that are physically local
> > to the same socket and those that belong to different sockets. This
> > often leads to inefficient cross-socket demotion and suboptimal memory
> > placement.
> > 
> > This patch introduces a socket-aware topology management layer that
> > groups NUMA nodes according to their physical package (socket)
> > association. Each group forms a "memory package" that explicitly links
> > CPU and memory-only nodes (such as CXL or HBM) under the same socket.
> > This structure allows the kernel to interpret NUMA topology in a way
> > that reflects real hardware locality rather than relying solely on
> > flat distance values.
> > 
> > By maintaining socket-level grouping, the kernel can:
> >  - Enforce demotion and promotion policies that stay within the same
> >    socket.
> >  - Avoid unintended cross-socket migrations that degrade performance.
> >  - Provide a structural abstraction for future policy and tiering logic.
> > 
> > Unlike ACPI-provided distance tables, which offer static and symmetric
> > relationships, this socket-aware model captures the true hardware
> > hierarchy and provides a flexible foundation for systems where the
> > distance matrix alone cannot accurately express socket boundaries or
> > asymmetric topologies.
> 
> Careful with the generalities in here. There is no way to derive the
> 'true' hierarchy. What this is doing is applying a particular set
> of heuristics to the data that ACPI provided and attempting to use
> that to derive relationships. In simple cases that might work fine.0
> 
> Doing so is OK in an RFC for discussion but this will need testing
> against a wide range of topologies to at least ensure it fails gracefully.
> Note we've had to paper over quite a few topology assumptions in the
> kernel and this feels like another one that will bite us later.
> 
> I'd avoid the socket terminology as multiple NUMA nodes in sockets
> have been a thing for many years. Today there can even be multiple
> IO dies with a complex 'distance' relationship wrt to the CPUs
> in that socket. Topologies of memory controllers in those
> packages are another level of complexity.
> 
> 
> Otherwise a few general things from a quick look. 
> 
> I'd avoid goto out; where out just returns.  That just makes code
> flow more complex and often makes for longer code. When you have
> an error and there is nothing to cleanup just return immediately.
> 
> guard() / scoped_guard() will help simplify some of the locking.
> 
> Thanks,
> 
> Jonathan
>

Hello Jonathan,

First of all, I sincerely apologize for the delayed response. I completely 
missed this email while I was highly focused on debugging the HMAT and 
CDAT latency issues in the other threads.

You are absolutely right about the terminology and the architectural 
assumptions. Given modern complex architectures with multiple NUMA nodes 
and IO dies within a single physical package, relying on the term "socket" 
is outdated and misleading. I completely agree that this is just another 
heuristic, not the "true" hierarchy. 

For the v2 patch, I will reword the commit messages to remove those 
generalities and avoid using the strict "socket" terminology. I will 
also make sure the logic is designed to fail gracefully and fall back 
to the default behavior when it encounters complex topologies that it 
cannot cleanly resolve.

Thank you so much for the detailed code review as well. I will definitely 
remove the unnecessary `goto out;` statements and replace them with 
direct returns. I will also adopt `guard()` and `scoped_guard()` to 
simplify the locking mechanics. 

Thanks again for your time and the valuable feedback.

Rakie Kim
