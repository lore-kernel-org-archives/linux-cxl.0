Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2AF156D8
	for <linux-cxl@vger.kernel.org>; Wed, 18 Oct 2023 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRYI654S"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98F0EA;
	Wed, 18 Oct 2023 01:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697617998; x=1729153998;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=28BEhauydut+mQimX7U4YfapCopmebuRODTGRijiKyI=;
  b=mRYI654SVN4+lZRGZREpGHovfc+ZItkRZRHjZd/LgtM0RE1gwGJhFllH
   A/ZqBjSvF9whUtXABYlHmcreOe5iTaaSx25MiNLXtUcEaC2QIVmjKA68y
   DN9a55NVQmlPo2VJJgWfDAxi/H5LFqSOOR+RAFAYbZAmAk7OxXwFeqWDA
   mDIRRx4oPLlmkmImgGQN0ar43yUwgw0RTvDk/Q6iOjGncp3WP4L7BgSYM
   DMm+NR1aosUbFVN4Uxd/CwttgKulQQQ/SoyUK0IJSZV+keuqNE6bYN/st
   ibIgH4tF5Lh7/2bwR69VR589ACrbym3NJ6MM9hRz2lDF2uEbsZjmgFr+0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384848481"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="384848481"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 01:33:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="749994672"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="749994672"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 01:33:13 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <linux-cxl@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <sthanneeru@micron.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC PATCH v2 0/3] mm: mempolicy: Multi-tier weighted interleaving
In-Reply-To: <87pm1cwcz5.fsf@yhuang6-desk2.ccr.corp.intel.com> (Ying Huang's
	message of "Wed, 18 Oct 2023 16:29:02 +0800")
References: <20231009204259.875232-1-gregory.price@memverge.com>
	<87o7gzm22n.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZS3jQRnX4VIdyTL5@memverge.com>
	<87pm1cwcz5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date: Wed, 18 Oct 2023 16:31:11 +0800
Message-ID: <87lec0wcvk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Forget to Cc more people.

"Huang, Ying" <ying.huang@intel.com> writes:

> Gregory Price <gregory.price@memverge.com> writes:
>
>> On Mon, Oct 16, 2023 at 03:57:52PM +0800, Huang, Ying wrote:
>>> Gregory Price <gourry.memverge@gmail.com> writes:
>>> 
>>> > == Mutex to Semaphore change:
>>> >
>>> > Since it is expected that many threads will be accessing this data
>>> > during allocations, a mutex is not appropriate.
>>> 
>>> IIUC, this is a change for performance.  If so, please show some
>>> performance data.
>>>
>>
>> This change will be dropped in v3 in favor of the existing
>> RCU mechanism in memory-tiers.c as pointed out by Matthew.
>>
>>> > == Source-node relative weighting:
>>> >
>>> > 1. Set weights for DDR (tier4) and CXL(teir22) tiers.
>>> >    echo source_node:weight > /path/to/interleave_weight
>>> 
>>> If source_node is considered, why not consider target_node too?  On a
>>> system with only 1 tier (DRAM), do you want weighted interleaving among
>>> NUMA nodes?  If so, why tie weighted interleaving with memory tiers?
>>> Why not just introduce weighted interleaving for NUMA nodes?
>>>
>>
>> The short answer: Practicality and ease-of-use.
>>
>> The long answer: We have been discussing how to make this more flexible..
>>
>> Personally, I agree with you.  If Task A is on Socket 0, the weight on
>> Socket 0 DRAM should not be the same as the weight on Socket 1 DRAM.
>> However, right now, DRAM nodes are lumped into the same tier together,
>> resulting in them having the same weight.
>>
>> If you scrollback through the list, you'll find an RFC I posted for
>> set_mempolicy2 which implements weighted interleave in mm/mempolicy.
>> However, mm/mempolicy is extremely `current-centric` at the moment,
>> so that makes changing weights at runtime (in response to a hotplug
>> event, for example) very difficult.
>>
>> I still think there is room to extend set_mempolicy to allow
>> task-defined weights to take preference over tier defined weights.
>>
>> We have discussed adding the following features to memory-tiers:
>>
>> 1) breaking up tiers to allow 1 tier per node, as opposed to defaulting
>>    to lumping all nodes of a simlar quality into the same tier
>>
>> 2) enabling movemnet of nodes between tiers (for the purpose of
>>    reconfiguring due to hotplug and other situations)
>>
>> For users that require fine-grained control over each individual node,
>> this would allow for weights to be applied per-node, because a
>> node=tier. For the majority of use cases, it would allow clumping of
>> nodes into tiers based on physical topology and performance class, and
>> then allow for the general weighting to apply.  This seems like the most
>> obvious use-case that a majority of users would use, and also the
>> easiest to set-up in the short term.
>>
>> That said, there are probably 3 or 4 different ways/places to implement
>> this feature.  The question is what is the clear and obvious way?
>> I don't have a definitive answer for that, hence the RFC.
>>
>> There are at least 5 proposals that i know of at the moment
>>
>> 1) mempolicy
>> 2) memory-tiers
>> 3) memory-block interleaving? (weighting among blocks inside a node)
>>    Maybe relevant if Dynamic Capacity devices arrive, but it seems
>>    like the wrong place to do this.
>> 4) multi-device nodes (e.g. cxl create-region ... mem0 mem1...)
>> 5) "just do it in hardware"
>
> It may be easier to start with the use case.  What is the practical use
> cases in your mind that can not be satisfied with simple per-memory-tier
> weight?  Can you compare the memory layout with different proposals?
>
>>> > # Set tier4 weight from node 0 to 85
>>> > echo 0:85 > /sys/devices/virtual/memory_tiering/memory_tier4/interleave_weight
>>> > # Set tier4 weight from node 1 to 65
>>> > echo 1:65 > /sys/devices/virtual/memory_tiering/memory_tier4/interleave_weight
>>> > # Set tier22 weight from node 0 to 15
>>> > echo 0:15 > /sys/devices/virtual/memory_tiering/memory_tier22/interleave_weight
>>> > # Set tier22 weight from node 1 to 10
>>> > echo 1:10 > /sys/devices/virtual/memory_tiering/memory_tier22/interleave_weight
>
> --
> Best Regards,
> Huang, Ying
