Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EDC2589
	for <linux-cxl@vger.kernel.org>; Mon,  6 Nov 2023 05:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpdxSGdB"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B333AF2;
	Sun,  5 Nov 2023 21:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699247465; x=1730783465;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=wA9ps40setaaiWpMyonu1OKxCsVCbeCJDFHvPxuQ5v4=;
  b=dpdxSGdBU4puXQyiPbdt9yzULSzPaKLgbsaB3/e1jrJne5pCekHLEPX1
   b6eKjHYKS59Aun2PSqJqZdLknZ17JTeJTPQzcB6eIsH4rm4gxEvTPCiWL
   6uLnhNW496ANpYVzvSDTM6RoB63zP+JSj/bk+K/wZa8uDMldInHU0p4HX
   9SiwpLEiSBgLN9Uy30iIudgFawlPzYq/FSBxRrVxI92D7yxmGZ3H2iGja
   5AXis4Fmaa3Fih6MDMECwRF4fjj2Eg2ka/pRIjG5DMQk8l8mSv+TDxtsd
   ST0EjuY2XleHl35Gi8HwYQGazCtfbus6a6/wCSapKetBNH8iwzTZG5sff
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="369414757"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="369414757"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 21:11:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="738693253"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="738693253"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 21:11:01 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,  Gregory Price
 <gourry.memverge@gmail.com>,  linux-kernel@vger.kernel.org,
  linux-cxl@vger.kernel.org,  linux-mm@kvack.org,
  akpm@linux-foundation.org,  aneesh.kumar@linux.ibm.com,
  weixugc@google.com,  apopple@nvidia.com,  tim.c.chen@intel.com,
  dave.hansen@intel.com,  shy828301@gmail.com,  gregkh@linuxfoundation.org,
  rafael@kernel.org,  Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
In-Reply-To: <2i3awgkx2i4a5op7rtcqzv4yub376l66tevfvlyccf6wrjia4v@5x4ar4f6i5eh>
	(Michal Hocko's message of "Fri, 3 Nov 2023 10:39:00 +0100")
References: <20231031003810.4532-1-gregory.price@memverge.com>
	<rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
	<20231031152142.GA3029315@cmpxchg.org>
	<jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
	<87msvy6wn8.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ivhxexthtfums73nkko6yoy635h3cpetv4sqaemrmqd5pbhpq6@6zrizaoxgdwi>
	<87il6k1y82.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<fe7ns7dvrhwp6o7fnn53wt7tuidsncjctgav4bdirwfmjxarne@3oyfe22mxc35>
	<87jzqzz502.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<2i3awgkx2i4a5op7rtcqzv4yub376l66tevfvlyccf6wrjia4v@5x4ar4f6i5eh>
Date: Mon, 06 Nov 2023 13:08:59 +0800
Message-ID: <87y1fbv578.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Michal Hocko <mhocko@suse.com> writes:

> On Fri 03-11-23 15:10:37, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Thu 02-11-23 14:11:09, Huang, Ying wrote:
>> >> Michal Hocko <mhocko@suse.com> writes:
>> >> 
>> >> > On Wed 01-11-23 10:21:47, Huang, Ying wrote:
>> >> >> Michal Hocko <mhocko@suse.com> writes:
>> >> > [...]
>> >> >> > Well, I am not convinced about that TBH. Sure it is probably a good fit
>> >> >> > for this specific CXL usecase but it just doesn't fit into many others I
>> >> >> > can think of - e.g. proportional use of those tiers based on the
>> >> >> > workload - you get what you pay for.
>> >> >> 
>> >> >> For "pay", per my understanding, we need some cgroup based
>> >> >> per-memory-tier (or per-node) usage limit.  The following patchset is
>> >> >> the first step for that.
>> >> >> 
>> >> >> https://lore.kernel.org/linux-mm/cover.1655242024.git.tim.c.chen@linux.intel.com/
>> >> >
>> >> > Why do we need a sysfs interface if there are plans for cgroup API?
>> >> 
>> >> They are for different target.  The cgroup API proposed here is to
>> >> constrain the DRAM usage in a system with DRAM and CXL memory.  The less
>> >> you pay, the less DRAM and more CXL memory you use.
>> >
>> > Right, but why the usage distribution requires its own interface and
>> > cannot be combined with the access control part of it?
>> 
>> Per my understanding, they are orthogonal.
>> 
>> Weighted-interleave is a memory allocation policy, other memory
>> allocation policies include local first, etc.
>> 
>> Usage limit is to constrain the usage of specific memory types
>> (e.g. DRAM) for a cgroup.  It can be used together with local first
>> policy and some other memory allocation policy.
>
> Bad wording from me. Sorry for the confusion.

Never mind.

> Sure those are two orthogonal things and I didn't mean to suggest a
> single API to cover both. But if cgroup semantic can be reasonably
> defined for the usage enforcement can we put the interleaving behavior
> API under the same cgroup controller as well?

I haven't thought about it thoroughly.  But I think it should be the
direction.

--
Best Regards,
Huang, Ying
