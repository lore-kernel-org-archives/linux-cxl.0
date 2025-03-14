Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D4412B63
	for <linux-cxl@vger.kernel.org>; Fri, 14 Mar 2025 03:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741922477; cv=none; b=h4bo0+nbbCC2p73WH+xrNfyBXLM3lvQxu23v508L83W+PpJ7qSnupD/yEZDO8VEvO189qn6EexXYa9YQUN8OYE6O3ajzGWhbe16h2+Xj/4myGUhQ6tYAQYRdGn9B2WcbIh2+lLUNKwjIj0XOHFEhpfAu/nQrfLCl7q98k9Wke7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741922477; c=relaxed/simple;
	bh=67Uwgi/9ZaKiD9tZ6e7rc7nRTP+h6eU43DGvE0C2P6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLuhR3gqmoWa7zTvzCp40kSCdS9KmnDnezyF4CBT39nPtT69J53IYC5nZxvN2alEUfzCGBd0O9oaLGQe7MzJvSt2g1f2jMJHPdDda4szGOA0e95Euqau6G3Rliwwp+2+lonvB3kFxmMt61mVN3pxccXP/qLbWmsNDTdpdCuicCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nDhmY6je; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nDhmY6je"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c53b9d66fdso210365885a.3
        for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 20:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741922474; x=1742527274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ux6CFNgIf3vTaeLtNojt06t4nFGVzH4j0lyfxDGjHY=;
        b=nDhmY6jeguw3PnbP6XoKDBjyQ6FNOwd0HDsB/3Z5NVM7BkXJioM2s0bVA+zcYDIzX9
         ISleOeU/kBohNSH3VZA7nBa1TRHiv/W2crSdwfdb6khwF7QuYg9UY/jg/XVwE+aGKaxb
         y5K08cw1pa/drCUI/1NYkb9AK3PEBGXuZkWKoo0t7HZGZfTE7N8BKU1dkEWThSn+GLq+
         759evI62N0LEngsU7t17VB3SGzCb5L3sH4fzz8g6thFTXqvY0smzVgoiTJil/YwE35XR
         RsB47G8BXOCtCIVNfNrEybQMuYm468KPAPs9f147ijFyZ8H0M+B94cZClnYEvs+Pgaos
         t4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741922474; x=1742527274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ux6CFNgIf3vTaeLtNojt06t4nFGVzH4j0lyfxDGjHY=;
        b=q5sXgfx03/ZLcoLXHIM+qhxixT0RZ4bFXMnfikI5H+qy2y5cxmGZmcsHybZ2dvHr8C
         X+f2+3O1RLpvVHiby0Z302FB0wztoBGZxbRCuq8Mu58NOG83rqHWklvMxVqRj7cpeOSk
         g+9I7uJBbNYzturyYgkvsVkgczCLiRoSt2oZvy/OZDZPhqWEqgjgpYw2QWhBhAAfiha8
         UoJ60gvHPjPaf83JnwT07EAJ2WFeDqX5yZY8QOw9oiGRpDkzyua4+wLbtTEe7aik8FgN
         EqBPPiEahKG0QlfJ+nVryBGqoLSuufj+y432AJdq89Zxfin/NbXkZoBuH/XDM+K5CXK/
         noUw==
X-Forwarded-Encrypted: i=1; AJvYcCWV3f2Ge2l5lTNWn5NyOAdHYP4fEhxOANPZJn/kQ2mlg0QwFbKqVkXSflfw+wsO1pCWeRL8LjmU9Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhnMzd+NeAMix7hNOYt8WJWFgDYDg/O2L9vF/nZLlHs4TuhLCX
	LJYCAalpUotWlFdl3jS/24UO1Gsu1hxnMS40WXVHlrCA1PiraNfNycqJy5GfwvA=
X-Gm-Gg: ASbGncs6ijy1EvjDiIv6XKDpIxNqOA2gqzBSmklPuniU7VOlh8/IQSSbyLcS15gDC9k
	LZo3LQIv1IXf2DvjRip602Z6zb6dzEaWL1RD2WdNVtSPPkU30zqn7SjhD8CfCEowGzzRulizKuT
	qks6BRwVcwisuiVT62Ou57wQWYeWr8xhsigqoLPibEuoCsCfwyGrZ7y8Bs8/gRKiA15/494Pp2G
	jyfY9vTxMgbmCGtiHuCuwmgjK3UvsUCU/FvUTncrNQe0WNxbGRSCe4x79/Wf2+XAu3jlWmChM6U
	b2HR6ScOYExxyojTpbqq6Nfl63e6dA2ShLJnIZMDTjUkLJZXyiligZcxI/PQsr9de44s9JPaN/a
	aslbccVK8ZpiqwKawq4In7yzwuOE=
X-Google-Smtp-Source: AGHT+IF1asb2m4Q7VP1ePD104ALa7KxEpSasJCIfnfDaTFg+XuwdvZgE3PbHIFrHXhS0rPd+wUtwWg==
X-Received: by 2002:a05:620a:1920:b0:7c5:405e:e88f with SMTP id af79cd13be357-7c57c7d6cf6mr122564685a.21.1741922474195;
        Thu, 13 Mar 2025 20:21:14 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c98225sm186000785a.49.2025.03.13.20.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 20:21:13 -0700 (PDT)
Date: Thu, 13 Mar 2025 23:21:11 -0400
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [LSF/MM] CXL Boot to Bash - Section 6: Page allocation
Message-ID: <Z9Ogp9fCEPoORfnh@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>


Of course, the whole purpose of using CXL memory is to allocate it.

So lets talk about a real use case!

   char* a_page = malloc(4096);
   a_page[0] = '\x42'; /* Page fault and allocation occurs */

Congrats, you may or may not have allocated CXL memory!

Fin.

-----------------------------------------------------------------------

Ok, in all seriousness, the intent is hopefully to make this whole thing
as transparent as possible - but there's quite a bit of complexity in
how this is done while keeping things reasonably performant.


This section won't cover the general intricacies of how page allocation
works in the kernel, for that I would recommend Lorenzo Stoaks' book:

                   The Linux Memory Manager.

Notably, however, much of the content of this book concerned with Nodes
and Zones was written pre-CXL. For the sake of this section we'll focus
on how additional nodes and tiers *affect* allocations - whatever their
mechanism (faults, file access, explicit, etc).

That means I expect you'll at least have a base level understand of
virtual memory and allocation-on-fault behavior.  Most of what we're
talking about here is reclaim and migration - not page faults.

--------------------------------
Nodes, Tiers, and Zones - Oh My!
--------------------------------

==========
NUMA Nodes
==========
A NUMA node can *tacitly* be thought of as a "collection of homogeneous
resources". This is a fancy way of saying "All the memory on a given
node should have the same performance characteristics."

As discussed in Sections 0 and 1, however, we saw how nodes are
consturcted quite arbitrarily. All that truly matters is what your
platform vendor has chosen to associate devices with "Proximity Domains"
in the various ACPI tables.

I'll stick with my moderately sane, and moderately wrong, definition.

Lets consider a system with 2 sockets and 1 CXL device attached to a
host bridge on each socket.

```
              socket-interconnect
                       |
    DRAM -- CPU0--------------CPU1 -- DRAM
              |                 |
            CXL0              CXL1
```

The "Locality" information for these devices is built in the ACPI SLIT
(System Locality Information Table). 

For example (caveat - fake!):
```
  Signature : "SLIT"    [System Locality Information Table]
  ...
    Localities : 0000000000000004
  Locality   0 : 10 20 20 30
  Locality   1 : 20 10 30 20
  Locality   2 : FF FF 0A FF
  Locality   3 : FF FF FF 0A
```

This is what shows up via the `numactl -H` command
```
$ numactl -H
node distances:
node     0    1    2    3
   0:   16   32   32   48
   1:   32   16   48   32
   2:  255  255   16  255
   3:  255  255  255   16

       ^^^ 255 typically means a node can't initiate access... typically
           i.e. "has no processors"
```


These "Locality" values are "Abstract Distances" - i.e. fancy lies from
a black box piece of code that portends to describe something useful.

You may think NUMA nodes have a clean topological relationship like so:
```
     node0--------------node1
       |                  |
     node2              node2
```


In reality, all Linux knows is that these are "relative distances".

```
  Node 0 distance from other nodes:
      0->[1,2]->3
  Node 1 distance from other nodes:
      1->[0,3]->2
```

Why does this matter?

Lets imagine a Node 0 CPU allocates a page, but Node 0 is out of memory.
Which node should Node 0 fall back to allocate from?

In our example above, nodes `[1,2]` seem like equally good options. In
reality, the cross-socket interconnect will usually be classified as
"closer" than a CXL device.

You can expect the following to be more realistic.
```
  $ numactl -H
  node distances:
  node     0    1    2    3
     0:   16   32   48   64
     1:   32   16   64   48
     2:  255  255   16  255
     3:  255  255  255   16

  Node 0 distance perspective:
      0->1->2->3
  Node 1 distance perspective
      1->0->3->2
```

Which makes sense, because typically the cross-socket interconnect will
be faster than a CXL link, and for Node0 to access Node3, it must cross
both interconnects.

`Memory Tiers`, however, are quite a bit different.


=============
Memory Tiers.
=============
Memory tiers collect all similar-performance devices into a single "Tier".

These tiers can be inspected via sysfs:

    [/sys/devices/virtual/memory_tiering/]# ls
        memory_tier4  memory_tier961

    [/sys/devices/virtual/memory_tiering/]# cat memory_tier4/nodelist
        0-1

    [/sys/devices/virtual/memory_tiering/]# cat memory_tier4/nodelist
        2-3

On our example 2-socket system, both sockets hosting local DRAM Would
get lumped into the same tier, while both CXL devices would get lumped
into the same tier (lets assume they have the same latency/bandwidth).

```
            memory_tier4--------------------
           /            \                  |
      node0              node1             |
                                     memory_tier961
                                    /            \
                               node2              node3
```

This relationship, ostensibly, provides a quick and easy way to
determine a rough performance-based relationship between nodes.
This is, ostensibly, useful if you want to do memory tiering (demotion
and/or promotion).  More on this in a bit.

Tiers are created based on performance data - typically provided by the
HMAT or CXL CDAT data.  The memory-tiers component treats
socket-attached DRAM as the baseline, and generates its own abstract
distance (different that the SLIT abstract distance!).

```
int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
{
... snip ...
    /*
     * The abstract distance of a memory node is in direct proportion to
     * its memory latency (read + write) and inversely proportional to its
     * memory bandwidth (read + write).  The abstract distance, memory
     * latency, and memory bandwidth of the default DRAM nodes are used as
     * the base.
     */
    *adist = MEMTIER_ADISTANCE_DRAM *
            (perf->read_latency + perf->write_latency) /
            (default_dram_perf.read_latency + default_dram_perf.write_latency) *
            (default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
            (perf->read_bandwidth + perf->write_bandwidth);
}
```

The memory-tier component also provides a demotion-target mechanism,
which creates a recommended demotion-target based on a given node.

```
/**
 * next_demotion_node() - Get the next node in the demotion path
 * @node: The starting node to lookup the next node
 *
 * Return: node id for next memory node in the demotion path hierarchy
 * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
 * @node online or guarantee that it *continues* to be the next demotion
 * target.
 */
int next_demotion_node(int node);
```


The node_demotion map uses... SLIT provided node abstract distances to
determine the target!
```
/*
 * node_demotion[] examples:
 *
 * Example 1:
 *
 * Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM nodes.
 *
 * node distances:
 * node   0    1    2    3
 *    0  10   20   30   40
 *    1  20   10   40   30
 *    2  30   40   10   40
 *    3  40   30   40   10
 *
 * memory_tiers0 = 0-1
 * memory_tiers1 = 2-3
 *
 * node_demotion[0].preferred = 2
 * node_demotion[1].preferred = 3
 * node_demotion[2].preferred = <empty>
 * node_demotion[3].preferred = <empty>
 * ...
 * /
```

As of 03/13/2025, there is no `next_promotion_node()` counterpart to
this function.  As we'll probably learn in a later section:

    Promotion Is Hard. (TM)

There is at least an interface to tell you whether a node is toptier:

    bool node_is_toptier(int node);


The grand total of interfaces you need to know for the remainder of
this section are exactly:

    next_demotion_node(int node)

I may consider another section on Memory Tiering in the future, but
this is sufficient for now.



                     < unwarrated snark >
"But Greg", you say, "it seems to me that memory-tiers as designed are
of dubious value considering hardware interleave as described in
Section 4 already combines multiple devices into a single node - and
lumping remote nodes regardless of socket-relationship is at best
misleading and at worst may actively cause performance regressions!"

Very astute observation. Maybe we should rethink this component a bit.
                    < / unwarranted snark >


=============
Memory Zones.
=============
In Section 3 (Memory Hotplug) we briefly discussed memory zones.  For
the purpose of this section, all we need to know is how these zones
impact allocation.  I will largely quote the Linux kernel docs here.

```
* ZONE_NORMAL is for normal memory that can be accessed by the kernel
  all the time. DMA operations can be performed on pages in this zone
  if the DMA devices support transfers to all addressable memory.

  ZONE_NORMAL is always enabled.


* ZONE_MOVABLE is for normal accessible memory, just like ZONE_NORMAL.

  The difference is that the contents of most pages in ZONE_MOVABLE are
  movable. That means that while virtual addresses of these pages do
  not change, their content may move between different physical pages.


```
  
  note: ZONE_NORMAL allocations MAY be movable.  ZONE_MOVABLE must be.
        (for some definition of `must`, suspend disbelief for now)


We generally don't want kernel resources incidentally finding themselves
on CXL memory (a highly contended lock landing on far-memory by complete
happenstance would by absolutely tragic).  However, there aren't many
mechanism to prevent this from occurring.

While the kernel may *explicitly* allocate ZONE_MOVABLE memory via
special interfaces, a typical `kmalloc()` call will utilize ZONE_NORMAL
memory, as most kernel allocations are not guaranteed to be movable.

That means most kernel allocations, should they happen to land on a
remote node, are *stuck there*. For most use cases, then, we will want
CXL memory onlined into ZONE_MOVABLE, because we'd like the option to
migrate memory off of these devices for a variety of reasons.

The most obvious mechanism to prevent the kernel from using CXL memory
is to online CXL memory in ZONE_MOVABLE.


However, ZONE_MOVABLE isn't without drawbacks. For example...

Gigantic (1GB) pages are not allocable from ZONE_MOVABLE.  Many
hypervisors utilize Gigantic pages to limit TLB pressure.  That means,
for now, VM use cases must pick between incidental kernel use, and
Gigantic page use.

This is all to say: Memory zone configuration affects your performance.




----------------
Page Allocation.
----------------

There are a variety of ways pages can be allocated, for this section
we'll just focus on a plain old allocate-on-fault interaction.

    char* page = malloc(4096);
    page[0] = '\x42'; /* Page fault, kernel allocates a page */

Assuming no special conditions (memory pressure, mempolicies, special
prefetchers - whatever), the default allocation policy in linux is to
allocate a page from the same node as the accessing CPU.

So if, in our example, we are running on a node1 CPU and hit the above
page fault, we'll allocate from the node1 DRAM.

```
  Default allocation policy:

                           access
                          /      \- allocation
      DRAM -- CPU0------CPU1 -- DRAM
                |         |
                |         |
              CXL0      CXL1
```

Simple and, dare I say, elegant - really.

This is, of course, assuming, we have no special conditions - of which
there are, of course, many.

================
Memory Pressure.
================
Lets assume DRAM on node1 is pressured, and there is insufficient
headroom to allocate a page on node1.  What should we do?

We have a few options.
    1) Fall back to another node
    2) Attempt to steal a physical page from someone else. ("reclaim")

Lets assume reclaim doesn't exist for a moment.

What node should fall back to?  One might assume we would consider
attempting to allocate based on the NUMA node topology. 

For example:
```
 * node distances:
 * node   0    1    2    3
 *    0  10   20   30   40
 *    1  20   10   40   30
 *    2  30   40   10   40
 *    3  40   30   40   10
```

In this topology, Node1 would prefer allocating from Node0 as a
secondary source, and subsequently fall back to Node3 and Node2 as
those nodes become pressured.

This is basically what happens.  But is that what we want?

If a page is being allocated, it is almost by definition "hot", and
so this has lead the kernel to conclude that - generally speaking - new
allocations should be local unless explicitly requested otherwise.

So instead, by default, we will start engaging the reclaim system.



================================
Reclaim - LRU, Zones, and Nodes.
================================
In the scenario where memory is pressured and reclaim is in use, Linux
will go through a variety of phases to based on watermarks (Min, Low,
High memory availability).   These watermarks are used to determine
when reclaim should run and when the system should block further
allocations to ensure the kernel has sufficient headroom to make
forward progress.

An allocation may cause a kernel daemon to start moving pages through
the LRU (least-recently-used) mechanism, or it may cause the task
itself to engage in the process.

The reclaim system may choose to swap pages to disk or to demote pages
from the local node to a remote node.

The key piece here is understanding the main LRU types and their
relationship to zones and nodes.

```
                     ______node______
                    /                \
         ZONE_NORMAL                  ZONE_MOVABLE
        /           \                /            \
   active LRU   inactive LRU     active LRU   inactive LRU
```

Typically reclaim is engaged when attempting an allocation and the
requested zone hits a low or min watermark.  On our imaginary system,
lets assume we've set up the following structure.

```
          node0 - DRAM                 node2 - CXL
            |                            |
        ZONE_NORMAL                 ZONE_MOVABLE
       /          \                /            \
  active_lru   inactive_lru   active_lru   inactive_lru
```

node0 (local) has no ZONE_MOVABLE, and node2 has no ZONE_NORMAL.  Since
we always prefer allocations from the local node, we'll evicting pages
from ZONE_NORMAL on node0 - that's the only zone we can allocate from.

Specifically, reclaim will prefer to evict pages from the inactive lru
and "age off" pages from the active_lru to the inactive_lru.  If 
reclaim fails, it may then fail to allocate from the requested node and
fallback to another node to continue forward progress.

(or maybe OOM, or some other nebulous conditions - it's all really quite
complex and well documented in Lorenzo's book, highly recommended!)


==================
Swap vs. Demotion.
===================
By default, the reclaim system will only age pages from active to
inactive LRUs, and then move to evict pages from the inactive LRU
(possibly engaging swap or just nixing read-only page mappings).

However, reclaim can be configured to *demote* pages as well via
the sysfs option:

    $ echo 1 > /sys/kernel/mm/numa/demotion_enabled


In this scenario, rather than evict from inactive LRU to swap, we
can demote a page from its current node to its closest demotion target.

```
mm/vmscan.c:

static bool can_demote(int nid, struct scan_control *sc)
{
        if (!numa_demotion_enabled)
                return false;
        if (sc && sc->no_demotion)
                return false;
        if (next_demotion_node(nid) == NUMA_NO_NODE)
                return false;

        return true;
}

/*
 * Take folios on @demote_folios and attempt to demote them to another node.
 * Folios which are not demoted are left on @demote_folios.
 */
static unsigned int demote_folio_list(struct list_head *demote_folios,
                                     struct pglist_data *pgdat)
{
...
        /* Demotion ignores all cpuset and mempolicy settings */
        migrate_pages(demote_folios, alloc_migrate_folio, NULL,
                      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
                      &nr_succeeded);
}
```

Notice that the comment here says "Demotion ignores cpuset". That means
if you turn this setting on, and you require strong cpuset.mems
isolation, you're in for a surprise!  Another fun nuance to trip over.


======================================
Kernel Memory Tiering - A Short Story.
======================================

The story so far:
    In the beginning [Memory Tiering] was created.
    This has made a lot of people very angry and
    been widely regarded as a bad move.
     ~ Douglas Adams, The Restaurant at the End of the [CXL Fabric]

There isn't a solid consensus on how memory tiering should be
implemented in the kernel, so I will refrain from commenting on
the various proposals for now.

This obviously ikely deserves its own section which tumbles over
6 or 7 different RFCs in varying states - and ever so slightly
misrepresents the work enough confuse everyone.

Lets not, for now.

So I will leave it here:

Most of these systems aim at 3 goals:
  1) create space on the local nodes for new allocations
  2) demote cold memory from local nodes to make room for hot memory
  3) promote hot memory from remote nodes to reduce average latencies.

No one (largely) agrees what the best approach for this is, yet.

If I were to make one request before anyone proposes yet *another*
tiering mechanism, I would ask that you take a crack at implementing
`next_promotion_node()` first.

```
    /**
     * next_promotion_node() - Get the next node in the promotion path
     * @node: The starting node to lookup the next node
     *
     * Return: node id for next memory node in the promotion path hierarchy
     * from @node; NUMA_NO_NODE if @node is top tier.  This does not keep
     * @node online or guarantee that it *continues* to be the next promotion
     * target.
     */
    int next_promotion_node(int node);
```

That's the whole ballgame.

Fin.


-----------------------------------------------------------------------


Yes, that's basically it.  The kernel prefers to allocate new pages from
the local node, and it tries to demote memory to make sure this can
happen.  Otherwise - incidental direct allocation can occur on fallback.

But how you configure your CXL memory dictates all this behavior.  So
it's extremely important that we get the configuration part right.


This will be the end of the Boot to Bash series for the purpose of
LSFMM 2025 background. We will likely continue in a github repo or
something from here on.

See you all in Montreal.

~Gregory
