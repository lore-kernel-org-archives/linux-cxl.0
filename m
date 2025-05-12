Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89835257AFF;
	Mon, 12 May 2025 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038191; cv=none; b=NzAnf5eqaMxl8xgErGRBNSt0j/IdprBLgEBnrSsKghWl1l8WPFEIhMrvZcSN6YCA4A93NqEuFTROQWOVqvChK6evYLiOOAqEyPVGF5WRalB1Fcc7keaRb1btL65rHCU3jNmKaahU4Vq0Y2EnVlWawa7nlcpP+Q3gUarPhdvIoDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038191; c=relaxed/simple;
	bh=pY7jvXYq3d5U5CAMqYYen1ekEQUQSgJvswNHpgHog2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p06Dz/vQNdbsg/CFman/c8uN2yZATreMy1IIaDIc0uZM8byQ+B9x4ZgbQov0fGmP81RB4owrFdIjuERdL91uQhXUmK7laGIh9D53ZNeG3PJFHNSRpx46NDT5mpYX4Vcsif/Bxlksr0qo+TmVzmsZ5eruyweQFrnEhSm5/pn+lmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-1e-6821afe537ee
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: joshua.hahnjy@gmail.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [RFC] Add per-socket weight support for multi-socket systems in weighted interleave
Date: Mon, 12 May 2025 17:22:50 +0900
Message-ID: <20250512082257.263-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <aB2Xh4jEqpSTuvsi@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC9ZZnoe7T9YoZBk9vGVrMWb+GzWL61AuM
	Fj/vHme3OL51HrvF+VmnWCwu75rDZnFvzX9Wi9VrMhw4PHbOusvu0d12md1j8Z6XTB6bPk1i
	9zgx4zeLx86Hlh6fN8kFsEdx2aSk5mSWpRbp2yVwZRxevYKl4IlKxaytk9gaGFvluhg5OSQE
	TCROTn3NBGNf3/iRtYuRg4NNQEni2N4YEFNEQFWi7Yp7FyMXB7PAeiaJAxe3soOUCwskSJya
	d4kZxGYBqvne0QgW5xUwltja8AJqpKZEw6V7TCBzOAXMJP6/jgMJCwnwSLzasJ8RolxQ4uTM
	JywgNrOAvETz1tnMILskBM6wSdw/9JwZYo6kxMEVN1gmMPLPQtIzC0nPAkamVYxCmXlluYmZ
	OSZ6GZV5mRV6yfm5mxiBQbys9k/0DsZPF4IPMQpwMCrx8CasVcgQYk0sK67MPcQowcGsJMI7
	lUE+Q4g3JbGyKrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVAPjEq1k
	35ftAtdWulXdWyE95UHP3nVWe017+/sOxEnXdPQkN+b9nnjhCX/SgWA+vZn5LGz7W275JgdO
	fTH5oc73Tz8Sw19cXzN5S3hNiMRBoxahzvk9jR8/HTYuCL0TMV1krmbPo7zkU//Ss23O/lWQ
	bfpze9rvhOA/CexF6l5cWvv+Cvd8vDhTiaU4I9FQi7moOBEATM4NQF4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsXCNUNNS/fpesUMg3OP1SzmrF/DZjF96gVG
	i593j7NbfH72mtni+NZ57BaH555ktTg/6xSLxeVdc9gs7q35z2px6NpzVovVazIsfm9bwebA
	47Fz1l12j+62y+wei/e8ZPLY9GkSu8eJGb9ZPHY+tPT4dtvDY/GLD0wenzfJBXBGcdmkpOZk
	lqUW6dslcGUcXr2CpeCJSsWsrZPYGhhb5boYOTkkBEwkrm/8yNrFyMHBJqAkcWxvDIgpIqAq
	0XbFvYuRi4NZYD2TxIGLW9lByoUFEiROzbvEDGKzANV872gEi/MKGEtsbXjBBDFSU6Lh0j0m
	kDmcAmYS/1/HgYSFBHgkXm3YzwhRLihxcuYTFhCbWUBeonnrbOYJjDyzkKRmIUktYGRaxSiS
	mVeWm5iZY6pXnJ1RmZdZoZecn7uJERi4y2r/TNzB+OWy+yFGAQ5GJR5eCX/FDCHWxLLiytxD
	jBIczEoivFMZ5DOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4
	OKUaGK9n9bWpXct9O1f2mn1X+iFp+zVHrb1DJnCdeLidf4lpLWvLn56NHHd83+7aHvbUbvO/
	gCD3X13v+RIVv0eksN2eJayv/dZV4JX5ZFmB23dfBZWcvnvc78OucuZ3ynV/m1zXhUy68d3n
	7K7fB/7UBh7NVXsdbrqoS7Fk9h/xogDrhLMqLNeWrFZiKc5INNRiLipOBABf+eqeWAIAAA==
X-CFilter-Loop: Reflected

On Fri, 9 May 2025 01:49:59 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Fri, May 09, 2025 at 11:30:26AM +0900, Rakie Kim wrote:
> > 
> > Scenario 1: Adapt weighting based on the task's execution node
> > A task prefers only the DRAM and locally attached CXL memory of the
> > socket on which it is running, in order to avoid cross-socket access and
> > optimize bandwidth.
> > - A task running on CPU0 (node0) would prefer DRAM0 (w=3) and CXL0 (w=1)
> > - A task running on CPU1 (node1) would prefer DRAM1 (w=3) and CXL1 (w=1)
> ... snip ...
> > 
> > However, Scenario 1 does not depend on such information. Rather, it is
> > a locality-preserving optimization where we isolate memory access to
> > each socket's DRAM and CXL nodes. I believe this use case is implementable
> > today and worth considering independently from interconnect performance
> > awareness.
> > 
> 
> There's nothing to implement - all the controls exist:
> 
> 1) --cpunodebind=0
> 2) --weighted-interleave=0,2
> 3) cpuset.mems
> 4) cpuset.cpus

Thank you again for your thoughtful response and the detailed suggestions.

As you pointed out, it is indeed possible to construct node-local memory
allocation behaviors using the existing interfaces such as --cpunodebind,
--weighted-interleave, cpuset.mems, and cpuset.cpus. I appreciate you
highlighting that path.

However, what I am proposing in Scenario 1 (Adapt weighting based on the
task's execution node) is slightly different in intent.

The idea is to allow tasks to dynamically prefer the DRAM and CXL nodes
attached to the socket on which they are executing without requiring a
fixed execution node or manual nodemask configuration. For instance, if
a task is running on node0, it would prefer node0 and node2; if running
on node1, it would prefer node1 and node3.

This differs from the current model, which relies on statically binding
both the CPU and memory nodes. My proposal aims to express this behavior
as a policy-level abstraction that dynamically adapts based on execution
locality.

So rather than being a combination of manual configuration and execution
constraints, the intent is to incorporate locality-awareness into the
memory policy itself.

> 
> You might consider maybe something like "--local-tier" (akin to
> --localalloc) that sets an explicitly fallback set based on the local
> node.  You'd end up doing something like
> 
> current_nid = memtier_next_local_node(socket_nid, current_nid)
> 
> Where this interface returns the preferred fallback ordering but doesn't
> allow cross-socket fallback.
> 
> That might be useful, i suppose, in letting a user do:
> 
> --cpunodebind=0 --weighted-interleave --local-tier
> 
> without having to know anything about the local memory tier structure.

That said, I believe your suggestion for a "--local-tier" option is a
very good one. It could provide a concise, user-friendly way to activate
such locality-aware fallback behavior, even if the underlying mechanism
requires some policy extension.

In this regard, I fully agree that such an interface could greatly help
users express their intent without requiring them to understand the
details of the memory tier topology.

> 
> > > At the same time we were discussing this, we were also discussing how to
> > > do external task-mempolicy modifications - which seemed significantly
> > > more useful, but ultimately more complex and without sufficient
> > > interested parties / users.
> > 
> > I'd like to learn more about that thread. If you happen to have a pointer
> > to that discussion, it would be really helpful.
> > 
> 
> https://lore.kernel.org/all/20231122211200.31620-1-gregory.price@memverge.com/
> https://lore.kernel.org/all/ZV5zGROLefrsEcHJ@r13-u19.micron.com/
> https://lore.kernel.org/linux-mm/ZWYsth2CtC4Ilvoz@memverge.com/
> https://lore.kernel.org/linux-mm/20221010094842.4123037-1-hezhongkun.hzk@bytedance.com/
> There are locking issues with these that aren't easy to fix.
> 
> I think the bytedance method uses a task_work queueing to defer a
> mempolicy update to the task itself the next time it makes a kernel/user
> transition.  That's probably the best overall approach i've seen.
> 
> https://lore.kernel.org/linux-mm/ZWezcQk+BYEq%2FWiI@memverge.com/
> More notes gathered prior to implementing weighted interleave.

Thank you for sharing the earlier links to related discussions and
patches. They were very helpful, and I will review them carefully to
gather more ideas and refine my thoughts further.

I look forward to any further feedback you may have on this topic.

Best regards,
Rakie

> 
> ~Gregory
> 
