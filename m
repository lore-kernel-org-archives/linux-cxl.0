Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7DF1369
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 01:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VM0IIJE8"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EDD99;
	Tue, 24 Oct 2023 18:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698196509; x=1729732509;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hwdrzypiR2fkRDdIHItSVOvz5i+uOdVyUow0cUbAgn8=;
  b=VM0IIJE8GQZ+X7TRwOeiI0ZfUxbPD/oH6vCB1dEE4XCFHyo5+d7W+WKv
   VnulbXeU86sbB7w66HPAEiHBxgUAsb4gTh1Ah0fIPgJPF0pfuysaXj/3Z
   nsh5tzIsI5/QcssIlgRqNBDkHhgJ5ZxtYGndWqCW/B44i/TOeBR4R/EhF
   H2kPwHVhmHK98n5xJZkV8th+twnv7G9eUslTCvanJ7mtKcmuHuLmjaPMw
   JBlTLiTYLxKfOwmy6ceb8N+GpiFz1AUZw/uh4pYdP4Jqhh0bW1GDiY9sv
   xcQmvoUQDZK2nEexPgU16ZdavdlwPCJ5IYP/zhgpRx3lQnGp4R7ZJCcYP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="453683274"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="453683274"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 18:15:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="787965355"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="787965355"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 18:15:03 -0700
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
In-Reply-To: <ZTfjqoEZXQWs/rxV@memverge.com> (Gregory Price's message of "Tue,
	24 Oct 2023 11:32:58 -0400")
References: <20231009204259.875232-1-gregory.price@memverge.com>
	<87o7gzm22n.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZS3jQRnX4VIdyTL5@memverge.com>
	<87pm1cwcz5.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZS33ClT00KsHKsXQ@memverge.com>
	<87edhrunvp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZS9HSIrblel39qrt@memverge.com>
	<87fs25g6w3.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZTEud5K5T+dRQMiM@memverge.com>
	<87ttqidr7v.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZTfjqoEZXQWs/rxV@memverge.com>
Date: Wed, 25 Oct 2023 09:13:01 +0800
Message-ID: <87lebrec82.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Mon, Oct 23, 2023 at 10:09:56AM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> > Depends.  if a user explicitly launches with `numactl --cpunodebind=0`
>> > then yes, you can force a task (and all its children) to run on node0.
>> 
>> IIUC, in your example, the `numactl` command line will be
>> 
>>   numactl --cpunodebind=0 --weighted-interleave=0,1,2,3
>> 
>> That is, the CPU is restricted to node 0, while memory is distributed to
>> all nodes.  This doesn't sound like reasonable for me.
>> 
>
> It being reasonable isn't really relevant. You can do this today with
> normal interleave:
>
> numactl --cpunodebind=0 --interleave=0,1,2,3
>
> The only difference between this method and that is the application of
> weights.  Doesn't seem reasonable to lock users out of doing it.

Do you have some real use case?

--
Best Regards,
Huang, Ying
