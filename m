Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A09468
	for <linux-cxl@vger.kernel.org>; Fri, 20 Oct 2023 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7KG96SR"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9C3D45;
	Thu, 19 Oct 2023 23:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697782429; x=1729318429;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=emDe/46ozX0hx7U6yivMfWjRH+gZmCG3CieXsBPTIhI=;
  b=g7KG96SR4ZMLtUeSUIkTFCoH7EuN7w6DYnicH0MhR2ZlgYP8kFtYk92x
   /NmSI6R3yWIMoWoHeLm2kHKSHQMQ0L0YiLxElpB2h9Of7mwKgaoqFFa0X
   0aBy+t0zH71kj/SPKHcIhk0hTHfXaUOBLH6EFVVcFFBYAlj2CC3/yKRdr
   Ryq9VomvTXOimFbSvzE0nRuM64ZTN4ezNwwVfvANqSwIMmQAsZ0jIj3MG
   BgLb7wK4y0gwChBzFOtcYF9kCm2uUq/GgSdhTkKepUgR5ZIUSa+lyEnRo
   gvss6aC+KGMlMfqUCnjC2sD2u/fwq5YEfscbXLZ2b8INi/FQbF+8W9IG7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450662736"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450662736"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 23:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="827623898"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="827623898"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 23:13:43 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <linux-cxl@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <sthanneeru@micron.com>,  Aneesh Kumar K.V
 <aneesh.kumar@linux.ibm.com>,  Wei Xu <weixugc@google.com>,  Alistair
 Popple <apopple@nvidia.com>,  Dan Williams <dan.j.williams@intel.com>,
  Dave Hansen <dave.hansen@intel.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
  Michal Hocko <mhocko@kernel.org>,  "Tim Chen" <tim.c.chen@intel.com>,
  Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC PATCH v2 0/3] mm: mempolicy: Multi-tier weighted interleaving
In-Reply-To: <ZS9HSIrblel39qrt@memverge.com> (Gregory Price's message of "Tue,
	17 Oct 2023 22:47:36 -0400")
References: <20231009204259.875232-1-gregory.price@memverge.com>
	<87o7gzm22n.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZS3jQRnX4VIdyTL5@memverge.com>
	<87pm1cwcz5.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZS33ClT00KsHKsXQ@memverge.com>
	<87edhrunvp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZS9HSIrblel39qrt@memverge.com>
Date: Fri, 20 Oct 2023 14:11:40 +0800
Message-ID: <87fs25g6w3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

[snip]

> Example 1: A single-socket system with multiple CXL memory devices
> ===
> CPU Node: node0
> CXL Nodes: node1, node2
>
> Bandwidth attributes (in theory):
> node0 - 8 channels - ~307GB/s
> node1 - x16 link - 64GB/s
> node2 - x8 link - 32GB/s
>
> In a system like this, the optimal distribution of memory on an
> interleave for maximizing bandwidth is about 76%/16%/8%.
>
> for the sake of simplicity:  --weighted-interleave=0:76,1:16,0:8
> but realistically we could make the weights sysfs values in the node
>
> Regardless of the mechanism to engage this, the most effective way to
> capture this in the system is by applying weights to nodes, not tiers.
> If done in tiers, each node would be assigned to its own tier, making
> the mechanism equivalent. So you might as well simplify the whole thing
> and chop the memtier component out.
>
> Is this configuration realistic? *shrug* - technically possible. And in
> fact most hardware or driver based interleaving mechanisms would not
> really be able to manage an interleave region across these nodes, at
> least not without placing the x16 driver in x8 mode, or just having the
> wrong distribution %'s.
>
>
>
> Example 2: A dual-socket system with 1 CXL device per socket
> ===
> CPU Nodes: node0, node1
> CXL Nodes: node2, node3 (on sockets 0 and 1 respective)
>
> Bandwidth Attributes (in theory):
> nodes 0 & 1 - 8 channels - ~307GB/s ea.
> nodes 2 & 3 - x16 link - 64GB/s ea.
>
> This is similar to example #1, but with one difference:  A task running
> on node 0 should not treat nodes 0 and 1 the same, nor nodes 2 and 3.
> This is because on access to nodes 1 and 3, the cross-socket link (UPI,
> or whatever AMD calls it) becomes a bandwidth chokepoint.
>
> So from the perspective of node 0, the "real total" available bandwidth
> is about 307GB+64GB+(41.6GB * UPI Links) in the case of intel.  so the
> best result you could get is around 307+64+164=535GB/s if you have the
> full 4 links.
>
> You'd want to distribute the cross-socket traffic proportional to UPI,
> not the total.
>
> This leaves us with weights of:
>
> node0 - 57%
> node1 - 26%
> node2 - 12%
> node3 - 5%
>
> Again, naturally nodes are the place to carry the weights here. In this
> scenario, placing it in memory-tiers would require that 1 tier per node
> existed.

Does the workload run on CPU of node 0 only?  This appears unreasonable.
If the memory bandwidth requirement of the workload is so large that CXL
is used to expand bandwidth, why not run workload on CPU of node 1 and
use the full memory bandwidth of node 1?

If the workload run on CPU of node 0 and node 1, then the cross-socket
traffic should be minimized if possible.  That is, threads/processes on
node 0 should interleave memory of node 0 and node 2, while that on node
1 should interleave memory of node 1 and node 3.

But TBH, I lacks knowledge about the real life workloads.  So, my
understanding may be wrong.  Please correct me for any mistake.

--
Best Regards,
Huang, Ying

[snip]
