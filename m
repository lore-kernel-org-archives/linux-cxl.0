Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BED7E
	for <linux-cxl@vger.kernel.org>; Fri,  3 Nov 2023 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7B1SOx5"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668F4DC;
	Fri,  3 Nov 2023 00:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698994944; x=1730530944;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=NlUvUl/u77O6i94HU6sLKj/Hm6CHxxLM9bHKMdKaE20=;
  b=m7B1SOx5mD4CS/80KEpVZBIVld0VAy5K3IEYh+17Ik3B5hAwB2f/HEP1
   H6vrNIRECcek9LbhO2vCzJ48bAufU7srr7kp1EVp6US4q8NVH8FcwK8YU
   OF6HQ2YKTxn1PLMMN7ZoKF7AaNM36Xjzq2GeKRAKNJxuPmWjUpICduQBE
   Ny9KfuyS3XdK9edHLWCTfXyfP+QowMzLmx+fnR/dGoawqggN0gdImsNPi
   JDmwzBwZilOe2JEDwamxneRjWUamUozkKUeOzVJ0ixeWTKsr21Vft9+GN
   1vTtl/2fkj4UkwOaGyuPYtrSR8ZRcv00saHlI8BlQcU5GQwrcb/Am4FOG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="386062794"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="386062794"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 00:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="878548746"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="878548746"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 00:02:20 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ravi Jonnalagadda <ravis.opensrc@micron.com>
Cc: <akpm@linux-foundation.org>,  <aneesh.kumar@linux.ibm.com>,
  <apopple@nvidia.com>,  <dave.hansen@intel.com>,
  <gourry.memverge@gmail.com>,  <gregkh@linuxfoundation.org>,
  <gregory.price@memverge.com>,  <hannes@cmpxchg.org>,
  <linux-cxl@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <mhocko@suse.com>,  <rafael@kernel.org>,
  <shy828301@gmail.com>,  <tim.c.chen@intel.com>,  <weixugc@google.com>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
In-Reply-To: <20231102093542.70-1-ravis.opensrc@micron.com> (Ravi
	Jonnalagadda's message of "Thu, 2 Nov 2023 15:05:42 +0530")
References: <87a5rw1wu8.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20231102093542.70-1-ravis.opensrc@micron.com>
Date: Fri, 03 Nov 2023 15:00:18 +0800
Message-ID: <87o7gbz5h9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ravi Jonnalagadda <ravis.opensrc@micron.com> writes:

> Should Node based interleave solution be considered complex or not would probably
> depend on number of numa nodes that would be present in the system and whether
> we are able to setup the default weights correctly to obtain optimum bandwidth
> expansion.

Node based interleave is more complex than tier based interleave.
Because you have less tiers than nodes in general.

>>
>>> Pros and Cons of Memory Tier based interleave:
>>> Pros:
>>> 1. Programming weight per initiator would apply for all the nodes in the tier.
>>> 2. Weights can be calculated considering the cumulative bandwidth of all
>>> the nodes in the tier and need to be programmed once for all the nodes in a
>>> given tier.
>>> 3. It may be useful in cases where numa nodes with similar latency and bandwidth
>>> characteristics increase, possibly with pooling use cases.
>>
>>4. simpler.
>>
>>> Cons:
>>> 1. If nodes with different bandwidth and latency characteristics are placed
>>> in same tier as seen in the current mainline kernel, it will be difficult to
>>> apply a correct interleave weight policy.
>>> 2. There will be a need for functionality to move nodes between different tiers
>>> or create new tiers to place such nodes for programming correct interleave weights.
>>> We are working on a patch to support it currently.
>>
>>Thanks!  If we have such system, we will need this.
>>
>>> 3. For systems where each numa node is having different characteristics,
>>> a single node might end up existing in different memory tier, which would be
>>> equivalent to node based interleaving.
>>
>>No.  A node can only exist in one memory tier.
>
> Sorry for the confusion what i meant was, if each node is having different 
> characteristics, to program the memory tier weights correctly we need to place
> each node in a separate tier of it's own. So each memory tier will contain
> only a single node and the solution would resemble node based interleaving.
>
>>
>>> On newer systems where all CXL memory from different devices under a
>>> port are combined to form single numa node, this scenario might be
>>> applicable.
>>
>>You mean the different memory ranges of a NUMA node may have different
>>performance?  I don't think that we can deal with this.
>
> Example Configuration: On a server that we are using now, four different
> CXL cards are combined to form a single NUMA node and two other cards are
> exposed as two individual numa nodes.
> So if we have the ability to combine multiple CXL memory ranges to a
> single NUMA node the number of NUMA nodes in the system would potentially
> decrease even if we can't combine the entire range to form a single node.

Sorry, I misunderstand your words.  Yes, it's possible that there one
tier for each node in some systems.  But I guess we will have less
tiers than nodes in general.

--
Best Regards,
Huang, Ying

>>
>>> 4. Users may need to keep track of different memory tiers and what nodes are present
>>> in each tier for invoking interleave policy.
>>
>>I don't think this is a con.  With node based solution, you need to know
>>your system too.
>>
>>>>
>>>>> Could you elaborate on the 'get what you pay for' usecase you
>>>>> mentioned?
>>>>
>>
>>--
>>Best Regards,
>>Huang, Ying
> --
> Best Regards,
> Ravi Jonnalagadda
