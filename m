Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315B8149C64;
	Wed,  7 May 2025 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746610536; cv=none; b=SFpsPEIVpjyA1+n6qP5Ysfqu69RwJdtkKzogMb0T56576y9eZnHCCoLsVBkA2YhQfaniQdbWM8XGhwkIOf5jVJTmtMgRUnHF3fm97cPlUa14RvrJrasaOj1WDlw98YK0CaVh0vovyXv6cVkCOBOiVYlJyu/1GO26QHTmBM4A1rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746610536; c=relaxed/simple;
	bh=kF6e6uMGMhaHt+9/3fdbFljNlGQnIYNDGjEJ8e4vQOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAvMXak8gBFityayJvO4gPs0xbVTgA4KgeiIGMFkdRVxeP5j09R3H8EaNnFSkLRk7gelTbyuKs6PyzSNeGmWPPBzuZhAfOit8QGLmpPBTgaTPpuQqyMbpuhWTPVm6y8+3/Or4wAya6acIHsrauEXdpDjebkJ/1/g0UFj0QsEypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-b6-681b29594506
From: rakie.kim@sk.com
To: gourry@gourry.net,
	joshua.hahnjy@gmail.com
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rakie.kim@sk.com
Subject: [RFC] Add per-socket weight support for multi-socket systems in weighted interleave
Date: Wed,  7 May 2025 18:35:16 +0900
Message-ID: <20250507093517.184-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsXC9ZZnoW6UpnSGwbNnrBZz1q9hs5g+9QKj
	xc+7x9ktjm+dx25xftYpFovLu+awWdxb85/VYvWaDAcOj52z7rJ7dLddZvdYvOclk8emT5PY
	PU7M+M3isfOhpcfnTXIB7FFcNimpOZllqUX6dglcGdvX9jIXfNap+LVtI2MD4xGFLkZODgkB
	E4l9M/cxwtgftq5mB7HZBMQkdk1/BGaLCBhIbG78DGRzcTALdDBJNC1bwwySEBaIkWhevIYV
	xGYRUJW4u2snWJxXwFjibftSVoihmhINl+4xQcQFJU7OfMICYjMLyEs0b53NDFGzhk3i37Jk
	CFtS4uCKGywTGHlnIWmZhaRlASPTKkahzLyy3MTMHBO9jMq8zAq95PzcTYzAwFxW+yd6B+On
	C8GHGAU4GJV4eA/8lMwQYk0sK67MPcQowcGsJMJ7/z5QiDclsbIqtSg/vqg0J7X4EKM0B4uS
	OK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA6P+NJ7NNQJ/+0pM5lQ3TTH5ul8kJ+XKhhfP7008
	WLaNafGOX1PZs/4ZL4pbXcvBrLq6ehfPZ5mqG0orPqUx1M8xufHyY1DPp3W1nRt/zL5j0TD3
	p9WyRI+ZlRvv/zW5YByfvNz6a9TuhE+/Sk4xJjL07rQ2ao/T+TDNO6RswqsZ3jlTt9hXnk5X
	YinOSDTUYi4qTgQACDdNbUgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsXCNUNNSzdSUzrDoLnLwmLO+jVsFtOnXmC0
	+Hn3OLvF52evmS2Ob53HbnF47klWi/OzTrFYXN41h83i3pr/rBaHrj1ntVi9JsPi97YVbA48
	Hjtn3WX36G67zO6xeM9LJo9Nnyaxe5yY8ZvFY+dDS49vtz08Fr/4wOTxeZNcAGcUl01Kak5m
	WWqRvl0CV8b2tb3MBZ91Kn5t28jYwHhEoYuRk0NCwETiw9bV7CA2m4CYxK7pj8BsEQEDic2N
	n4FsLg5mgQ4miaZla5hBEsICMRLNi9ewgtgsAqoSd3ftBIvzChhLvG1fygoxVFOi4dI9Joi4
	oMTJmU9YQGxmAXmJ5q2zmScwcs1CkpqFJLWAkWkVo0hmXlluYmaOqV5xdkZlXmaFXnJ+7iZG
	YDguq/0zcQfjl8vuhxgFOBiVeHgP/JTMEGJNLCuuzD3EKMHBrCTCe/8+UIg3JbGyKrUoP76o
	NCe1+BCjNAeLkjivV3hqgpBAemJJanZqakFqEUyWiYNTqoGROfDsvcq3CRbrg3/vKV4j8fHK
	JQO1+i187aeCPW3keFkF1vz7tD347SmDJPMZM5PNV52MbJglNOd8/cNXvyWecxqsTrqtVn3n
	/YHfImG6Ta26HPfjjNVEo45WTtW8+5F32oPe5f+snjF/dJap1IvWZhJMPb6f28Ci13L7759n
	YmNEckwe7ryvxFKckWioxVxUnAgAwXL1R0MCAAA=
X-CFilter-Loop: Reflected

Hi Gregory, Joshua,

I hope this message finds you well. I'm writing to discuss a feature I
believe would enhance the flexibility of the weighted interleave policy:
support for per-socket weighting in multi-socket systems.

---

<Background and prior design context>

While reviewing the early versions of the weighted interleave patches,
I noticed that a source-aware weighting structure was included in v1:

  https://lore.kernel.org/all/20231207002759.51418-1-gregory.price@memverge.com/

However, this structure was removed in a later version:

  https://lore.kernel.org/all/20231209065931.3458-1-gregory.price@memverge.com/

Unfortunately, I was unable to participate in the discussion at that
time, and I sincerely apologize for missing it.

From what I understand, there may have been valid reasons for removing
the source-relative design, including:

1. Increased complexity in mempolicy internals. Adding source awareness
   introduces challenges around dynamic nodemask changes, task policy
   sharing during fork(), mbind(), rebind(), etc.

2. A lack of concrete, motivating use cases. At that stage, it might
   have been more pragmatic to focus on a 1D flat weight array.

If there were additional reasons, I would be grateful to learn them.

That said, I would like to revisit this idea now, as I believe some
real-world NUMA configurations would benefit significantly from
reintroducing this capability.

---

<Motivation: realistic multi-socket memory topologies>

The system I am testing includes multiple CPU sockets, each with local
DRAM and directly attached CXL memory. Here's a simplified diagram:

          node0             node1
        +-------+   UPI   +-------+
        | CPU 0 |-+-----+-| CPU 1 |
        +-------+         +-------+
        | DRAM0 |         | DRAM1 |
        +---+---+         +---+---+
            |                 |
        +---+---+         +---+---+
        | CXL 0 |         | CXL 1 |
        +-------+         +-------+
          node2             node3

This type of system is becoming more common, and in my tests, I
encountered two scenarios where per-socket weighting would be highly
beneficial.

Let's assume the following NUMA bandwidth matrix (GB/s):

         0     1     2     3
     0  300   150   100    50
     1  150   300    50   100

And flat weights:

     node0 = 3
     node1 = 3
     node2 = 1
     node3 = 1

---

Scenario 1: Adapt weighting based on the task's execution node

Many applications can achieve reasonable performance just by using the
CXL memory on their local socket. However, most workloads do not pin
tasks to a specific CPU node, and the current implementation does not
adjust weights based on where the task is running.

If per-source-node weighting were available, the following matrix could
be used:

         0     1     2     3
     0   3     0     1     0
     1   0     3     0     1

Which means:

1. A task running on CPU0 (node0) would prefer DRAM0 (w=3) and CXL0 (w=1)
2. A task running on CPU1 (node1) would prefer DRAM1 (w=3) and CXL1 (w=1)
3. A large, multithreaded task using both sockets should get both sets

This flexibility is currently not possible with a single flat weight
array.

---

Scenario 2: Reflect relative memory access performance

Remote memory access (e.g., from node0 to node3) incurs a real bandwidth
penalty. Ideally, weights should reflect this. For example:

Bandwidth-based matrix:

         0     1     2     3
     0   6     3     2     1
     1   3     6     1     2

Or DRAM + local CXL only:

         0     1     2     3
     0   6     0     2     1
     1   0     6     1     2

While scenario 1 is probably more common in practice, both can be
expressed within the same design if per-socket weights are supported.

---

<Proposed approach>

Instead of removing the current sysfs interface or flat weight logic, I
propose introducing an optional "multi" mode for per-socket weights.
This would allow users to opt into source-aware behavior.
(The name 'multi' is just an example and should be changed to a more
appropriate name in the future.)

Draft sysfs layout:

  /sys/kernel/mm/mempolicy/weighted_interleave/
    +-- multi         (bool: enable per-socket mode)
    +-- node0         (flat weight for legacy/default mode)
    +-- node_groups/
        +-- node0_group/
        |   +-- node0  (weight of node0 when running on node0)
        |   +-- node1
        +-- node1_group/
            +-- node0
            +-- node1

- When `multi` is false (default), existing behavior applies
- When `multi` is true, the system will use per-task `task_numa_node()`
  to select a row in a 2D weight table

---

<Additional implementation considerations>

1. Compatibility: The proposal avoids breaking the current interface or
   behavior and remains backward-compatible.

2. Auto-tuning: Scenario 1 (local CXL + DRAM) likely works with minimal
   change. Scenario 2 (bandwidth-aware tuning) would require more
   development, and I would welcome Joshua's input on this.

3. Zero weights: Currently the minimum weight is 1. We may want to allow
   zero to fully support asymmetric exclusion.

---

<Next steps>

Before beginning an implementation, I would like to validate this
direction with both of you:

- Does this approach fit with your current design intentions?
- Do you foresee problems with complexity, policy sharing, or interface?
- Is there a better alternative to express this idea?

If there's interest, I would be happy to send an RFC patch or prototype.

Thank you for your time and consideration.

Sincerely,
Rakie

