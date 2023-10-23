Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304DD1374
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 02:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZH8O7aJA"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D7419E;
	Sun, 22 Oct 2023 19:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698027123; x=1729563123;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=X8PfC4/5+STlDD/lTLvT01RQNBVJUC5WbeS43Ah2Um8=;
  b=ZH8O7aJAMAI1o4RFp3kQV1uzjybwg8uGBhEh3OsKK4HZ3Ol97GSW0C5k
   Cbn0ep4/i7D/lHt7Gc5KLBCvO5Tngsl2M69Y0xxF5UoVtsrE6zkUei9g5
   dVVsH+TlSTATNWPGvU8PKvRQo+S8rvjRe3c4o5VQQett3mSphBHf1XAPf
   EiH6QmAcSE5CpW9DTmCoXMJkOQ7t8rStJ3OSIPV8Q8zXgsyMovoDpJIW/
   QLF7JXloS0gqI8UNe+0XemUl/qNFXGlkIyCsrtR+aNfy4Inz4oXrOyrTb
   JDjdpDOHiTrQ1OyZSGsm87aHlEZxdzl9lqnUmn+DfeMmGrW8DmIhHbCa5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="453221744"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="453221744"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 19:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="734510129"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734510129"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 19:11:58 -0700
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
In-Reply-To: <ZTEud5K5T+dRQMiM@memverge.com> (Gregory Price's message of "Thu,
	19 Oct 2023 09:26:15 -0400")
References: <20231009204259.875232-1-gregory.price@memverge.com>
	<87o7gzm22n.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZS3jQRnX4VIdyTL5@memverge.com>
	<87pm1cwcz5.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZS33ClT00KsHKsXQ@memverge.com>
	<87edhrunvp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZS9HSIrblel39qrt@memverge.com>
	<87fs25g6w3.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZTEud5K5T+dRQMiM@memverge.com>
Date: Mon, 23 Oct 2023 10:09:56 +0800
Message-ID: <87ttqidr7v.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Fri, Oct 20, 2023 at 02:11:40PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> >
> [...snip...]
>> > Example 2: A dual-socket system with 1 CXL device per socket
>> > ===
>> > CPU Nodes: node0, node1
>> > CXL Nodes: node2, node3 (on sockets 0 and 1 respective)
>> >
> [...snip...]
>> > This is similar to example #1, but with one difference:  A task running
>> > on node 0 should not treat nodes 0 and 1 the same, nor nodes 2 and 3.
> [...snip...]
>> > This leaves us with weights of:
>> >
>> > node0 - 57%
>> > node1 - 26%
>> > node2 - 12%
>> > node3 - 5%
>> >
>> 
>> Does the workload run on CPU of node 0 only?  This appears unreasonable.
>
> Depends.  if a user explicitly launches with `numactl --cpunodebind=0`
> then yes, you can force a task (and all its children) to run on node0.

IIUC, in your example, the `numactl` command line will be

  numactl --cpunodebind=0 --weighted-interleave=0,1,2,3

That is, the CPU is restricted to node 0, while memory is distributed to
all nodes.  This doesn't sound like reasonable for me.

> If a workload multi-threaded enough to run on both sockets, then you are
> right that you'd want to basically limit cross-socket traffic by binding
> individual threads to nodes that don't cross sockets - if at all
> feasible this may not be feasible).
>
> But at that point, we're getting into the area of numa-aware software.
> That's a bit beyond the scope of this - which is to enable a coarse
> grained interleaving solution that can easily be accessed with something
> like `numactl --interleave` or `numactl --weighted-interleave`.
>
>> If the memory bandwidth requirement of the workload is so large that CXL
>> is used to expand bandwidth, why not run workload on CPU of node 1 and
>> use the full memory bandwidth of node 1?
>
> Settings are NOT one size fits all.  You can certainly come up with another
> scenario in which these weights are not optimal.
>
> If we're running enough threads that we need multiple sockets to run
> them concurrently, then the memory distribution weights become much more
> complex.  Without more precise control over task placement and
> preventing task migration, you can't really get an "optimal" placement.
>
> What I'm really saying is "Task placement is a more powerful function
> for predicting performance than memory placement".  However, user
> software would need to implement a pseudo-scheduler and explicit data
> placement to be the most optimized.  Beyond this, there is only so much
> we can do from a `numactl` perspective.
>
> tl;dr: We can't get a perfect system here, because getting a best-case
> for all possible scenarios is an probably undecidable problem. You will
> always be able to generate an example wherein the system is not optimal.
>
>> 
>> If the workload run on CPU of node 0 and node 1, then the cross-socket
>> traffic should be minimized if possible.  That is, threads/processes on
>> node 0 should interleave memory of node 0 and node 2, while that on node
>> 1 should interleave memory of node 1 and node 3.
>
> This can be done with set_mempolicy() with MPOL_INTERLEAVE and set the
> nodemask to the what you describe.  Those tasks need to also prevent
> themselves from being migrated as well.  But this can absolutely be
> done.
>
> In this scenario, the weights need to be re-calculated to be based on
> the bandwidth of the nodes in the mempolicy nodemask, which is what i
> described in the last email.

IMHO, we should keep thing as simple as possible, only add complexity if
necessary.

--
Best Regards,
Huang, Ying
