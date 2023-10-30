Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4201362
	for <linux-cxl@vger.kernel.org>; Mon, 30 Oct 2023 05:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="df4M7Imh"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E36190;
	Sun, 29 Oct 2023 22:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698643519; x=1730179519;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=q8KoSMB/hpLdN583LzLTy2WR4ufc7oF95Z3VOZQo2IE=;
  b=df4M7Imh1CMFSW5NAtFQ0mJrRvLKCyw2wfxT7KryU/FXC6quyfMp7W8Q
   C/Kj/25ByZALZfDQPCxzEVAMkvvnwO5FFMblb3wVuAEqoa6j8B49k3gU8
   /zHDibo/7mJ+QlYKerHVhQ4W/uhZ7/9Xmn1deyNy4ZgiRFj6uDUGLrIEE
   FbGhS2f+vchj4L45LH4bi8YFEClnPEYoWNBZVd6d3YYUz8RSFI/SSS8XQ
   W8Ko84JqIAE+j8JciFhUIbM0mcXg8WRdAxAFH7o4HP0bqYHfTsr2Ab12d
   CVaZEqTJ65lmSyBztlI5pYKwP5fbpM+6Ji8FdHCqD795eG29qhJLBaJuL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="373065028"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="373065028"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 22:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="736638803"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="736638803"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 22:25:14 -0700
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
In-Reply-To: <ZT8u2246+vkA/4F+@memverge.com> (Gregory Price's message of "Mon,
	30 Oct 2023 00:19:39 -0400")
References: <ZS33ClT00KsHKsXQ@memverge.com>
	<87edhrunvp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZS9HSIrblel39qrt@memverge.com>
	<87fs25g6w3.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZTEud5K5T+dRQMiM@memverge.com>
	<87ttqidr7v.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZTfjqoEZXQWs/rxV@memverge.com>
	<87lebrec82.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZTlxxR0ntEzBPwre@memverge.com>
	<87a5s0df6p.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZT8u2246+vkA/4F+@memverge.com>
Date: Mon, 30 Oct 2023 13:23:11 +0800
Message-ID: <87sf5sbs5c.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Mon, Oct 30, 2023 at 10:20:14AM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> The extending adds complexity to the kernel code and changes the kernel
>> ABI.  So, IMHO, we need some real life use case to prove the added
>> complexity is necessary.
>> 
>> For example, in [1], Johannes showed the use case to support to add
>> per-memory-tier interleave weight.
>> 
>> [1] https://lore.kernel.org/all/20220607171949.85796-1-hannes@cmpxchg.org/
>> 
>> --
>> Best Regards,
>> Huang, Ying
>
> Sorry, I misunderstood your question.
>
> The use case is the same as the N:M interleave strategy between tiers,
> and in fact the proposal for weights was directly inspired by the patch
> you posted. We're searching for the best way to implement weights.
>
> We've discussed placing these weights in:
>
> 1) mempolicy :
>    https://lore.kernel.org/linux-cxl/20230914235457.482710-1-gregory.price@memverge.com/
>
> 2) tiers
>    https://lore.kernel.org/linux-cxl/20231009204259.875232-1-gregory.price@memverge.com/
>
> and now
> 3) the nodes themselves
>    RFC not posted yet
>
> The use case is the exact same as the patch you posted, which is to enable
> optimal distribution of memory to maximize memory bandwidth usage.
>
> The use case is straight forward - Consider a machine with the following
> numa nodes:
>
> 1) Socket 0 - DRAM - ~400GB/s bandwidth local, less cross-socket
> 2) Socket 1 - DRAM - ~400GB/s bandwidth local, less cross socket
> 3) CXL Memory Attached to Socket 0 with ~64GB/s per link.
> 4) CXL Memory Attached to Socket 1 with ~64GB/s per link.
>
> The goal is to enable mempolicy to implement weighted interleave such
> that a thread running on socket 0 can effectively spread its memory
> across each numa node (or some subset there-of) such that it maximizes
> its bandwidth usage across the various devices.
>
> For example, lets consider a system with only 1 & 2 (2 sockets w/ DRAM).
>
> On an Intel System with UPI, the "effective" bandwidth available for a
> task on Socket 0 is not 800GB/s, it's about 450-500GB/s split about
> 300/200 between the sockets (you never get the full amount, and UPI limits
> cross-socket bandwidth).
>
> Today `numactl --interleave` will split your memory 50:50 between
> sockets, which is just blatantly suboptimal.  In this case you would
> prefer a 3:2 distribution (literally weights of 3 and 2 respectively).
>
> The extension to CXL becomes obvious then, as each individual node,
> respective to its CPU placement, has a different optimal weight.
>
>
> Of course the question becomes "what if a task uses more threads than a
> single socket has to offer", and the answer there is essentially the
> same as the answer today:  Then that process must become "numa-aware" to
> make the best use of the available resources.
>
> However, for software capable of exhausting bandwidth with from a single
> socket (which on intel takes about 16-20 threads with certain access
> patterns), then a weighted-interleave system provided via some interface
> like `numactl --weighted-interleave` with weights either set in numa
> nodes or mempolicy is sufficient.

I think that these are all possible in theory.  Thanks for detailed
explanation!

Now the question is whether these issues are relevant in practice.
Whether are all workloads with the extreme high memory bandwidth
requirement NUMA-aware?  Or multi-process instead of multi-thread?
Whether is the cross-socket traffic avoided as much as possible in
practice?  I have no answer to these questions.  Do you have?  Or
someone else can answer them?

--
Best Regards,
Huang, Ying
