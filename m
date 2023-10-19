Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F8F8F54
	for <linux-cxl@vger.kernel.org>; Thu, 19 Oct 2023 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBTFL6pp"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62094FE;
	Wed, 18 Oct 2023 23:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697697049; x=1729233049;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=CXr5jF2igpwFL4qpy1yXG/Sjr63AfMYi+PszPqadSzU=;
  b=jBTFL6ppvsjw+LNEIWHmouMxA9dbeKhfJTmLsnQ4LgUFxwjBZxib3mqy
   j1pl6oNy/CzZsbjcyy8jA83YqYmyKXM3WkZM0QH4EszoGAEcppjKTYdQs
   iazGOcXiRCG+M2LtXsn9Hf/utDPkE7i7OXd2Uy0shb9EEOqQAn6H/oLNx
   qnBrAZ1p6rKpObqBrMmr7odNhu18rU0+m/sePQZmbmIBsxRH55B53nIBG
   cTfTRjvGOMcZfOfy/flAy3U6X/HGiomM+0MwZ40kc+dQJURGPHGMvs2rx
   xH2w6+Kx+XbqyFXrR3m9xTOF/Pppc1cxgpuY0Wu+71/Iew1u32UpSTtNk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="450404711"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="450404711"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 23:30:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="930489532"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="930489532"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 23:30:43 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <linux-cxl@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <sthanneeru@micron.com>, Aneesh Kumar K.V
 <aneesh.kumar@linux.ibm.com>, Wei Xu <weixugc@google.com>, Alistair Popple
 <apopple@nvidia.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen
 <dave.hansen@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Michal Hocko <mhocko@kernel.org>,
 Tim Chen <tim.c.chen@intel.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC PATCH v2 0/3] mm: mempolicy: Multi-tier weighted interleaving
In-Reply-To: <ZS33ClT00KsHKsXQ@memverge.com> (Gregory Price's message of "Mon,
	16 Oct 2023 22:52:58 -0400")
References: <20231009204259.875232-1-gregory.price@memverge.com>
	<87o7gzm22n.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZS3jQRnX4VIdyTL5@memverge.com>
	<87pm1cwcz5.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZS33ClT00KsHKsXQ@memverge.com>
Date: Thu, 19 Oct 2023 14:28:42 +0800
Message-ID: <87edhrunvp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Wed, Oct 18, 2023 at 04:29:02PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> > There are at least 5 proposals that i know of at the moment
>> >
>> > 1) mempolicy
>> > 2) memory-tiers
>> > 3) memory-block interleaving? (weighting among blocks inside a node)
>> >    Maybe relevant if Dynamic Capacity devices arrive, but it seems
>> >    like the wrong place to do this.
>> > 4) multi-device nodes (e.g. cxl create-region ... mem0 mem1...)
>> > 5) "just do it in hardware"
>> 
>> It may be easier to start with the use case.  What is the practical use
>> cases in your mind that can not be satisfied with simple per-memory-tier
>> weight?  Can you compare the memory layout with different proposals?
>>
>
> Before I delve in, one clarifying question:  When you asked whether
> weights should be part of node or memory-tiers, i took that to mean
> whether it should be part of mempolicy or memory-tiers.
>
> Were you suggesting that weights should actually be part of
> drivers/base/node.c?

Yes.  drivers/base/node.c vs. memory tiers.

> Because I had not considered that, and this seems reasonable, easy to
> implement, and would not require tying mempolicy.c to memory-tiers.c
>
>
>
> Beyond this, i think there's been 3 imagined use cases (now, including
> this).
>
> a)
> numactl --weighted-interleave=Node:weight,0:16,1:4,...
>
> b)
> echo weight > /sys/.../memory-tiers/memtier/access0/interleave_weight
> numactl --interleave=0,1
>
> c)
> echo weight > /sys/bus/node/node0/access0/interleave_weight
> numactl --interleave=0,1
>
> d)
> options b or c, but with --weighted-interleave=0,1 instead
> this requires libnuma changes to pick up, but it retains --interleave
> as-is to avoid user confusion.
>
> The downside of an approach like A (which was my original approach), was
> that the weights cannot really change should a node be hotplugged. Tasks
> would need to detect this and change the policy themselves.  That's not
> a good solution.
>
> However in both B and C's design, weights can be rebalanced in response
> to any number of events.  Ultimately B and C are equivalent, but
> the placement in nodes is cleaner and more intuitive.  If memory-tiers
> wants to use/change this information, there's nothing that prevents it.
>
> Assuming this is your meaning, I agree and I will pivot to this.

Can you give a not-so-abstract example?  For example, on a system with
node 0, 1, 2, 3, memory tiers 4 (0, 1), 22 (2, 3), ....  A workload runs
on CPU of node 0, ...., interleaves memory on node 0, 1, ...  Then
compare the different behavior (including memory bandwidth) with node
and memory-tier based solution.

--
Best Regards,
Huang, Ying
