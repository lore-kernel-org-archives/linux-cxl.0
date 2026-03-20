Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DF2512FF;
	Fri, 20 Mar 2026 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025774; cv=none; b=Wf456Pi9GkSyx0GJ23wqDVNHSSQryQ1FDTcI1cfWdGUsiz9kXMkNESH35B3/29lQDYV7ag5XDLK6KB6fsva9sAFdg0yEwZUqlnEd65zk92/5Z03aPnXRLVRfKEDUOVePz4Tug1gjiM4wTnzJbb/tyyBYdpn779XxOVceL5Ss2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025774; c=relaxed/simple;
	bh=yeN4pUwVpWGUipRcjmFTLToyAkfnT5WI64sOgJBGEiw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEh8mEmIoT58laLTHaUx7yPv5INWQ5n7DGPIrFfWM53wT5xIqv8Ygo66liQZbW+hStFOXEzV5SKYzP7BT4dfnUhX3IUdDP/ZOg8IPGg6RYpj37tUe3uR+pctAuFOA1Ga6ATKXKZSaT+lz/IB50AGFR/lpZVo89aR4EzjOIwHQjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fcpZy61S8zJ467Q;
	Sat, 21 Mar 2026 00:55:06 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 2434E40086;
	Sat, 21 Mar 2026 00:56:08 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 16:56:06 +0000
Date: Fri, 20 Mar 2026 16:56:05 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Rakie Kim <rakie.kim@sk.com>
CC: <akpm@linux-foundation.org>, <gourry@gourry.net>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<ziy@nvidia.com>, <matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>,
	<byungchul@sk.com>, <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<david@kernel.org>, <lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>,
	<vbabka@suse.cz>, <rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <kernel_team@skhynix.com>, <honggyu.kim@sk.com>,
	<yunjeong.mun@sk.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] [RFC PATCH 0/4] mm/mempolicy: introduce
 socket-aware weighted interleave
Message-ID: <20260320165605.000024c0@huawei.com>
In-Reply-To: <20260319075512.309-1-rakie.kim@sk.com>
References: <20260318120245.0000448e@huawei.com>
	<20260319075512.309-1-rakie.kim@sk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)


> > > 
> > > To make this possible, the system requires a mechanism to understand
> > > the physical topology. The existing NUMA distance model provides only
> > > relative latency values between nodes and lacks any notion of
> > > structural grouping such as socket boundaries. This is especially
> > > problematic for CXL memory nodes, which appear without an explicit
> > > socket association.  
> > 
> > So in a general sense, the missing info here is effectively the same
> > stuff we are missing from the HMAT presentation (it's there in the
> > table and it's there to compute in CXL cases) just because we decided
> > not to surface anything other than distances to memory from nearest
> > initiator.  I chatted to Joshua and Kieth about filling in that stuff
> > at last LSFMM. To me that's just a bit of engineering work that needs
> > doing now we have proven use cases for the data. Mostly it's figuring out
> > the presentation to userspace and kernel data structures as it's a
> > lot of data in a big system (typically at least 32 NUMA nodes).
> >   
> 
> Hearing about the discussion on exposing HMAT data is very welcome news.
> Because this detailed topology information is not yet fully exposed to
> the kernel and userspace, I used a temporary package-based restriction.
> Figuring out how to expose and integrate this data into the kernel data
> structures is indeed a crucial engineering task we need to solve.
> 
> Actually, when I first started this work, I considered fetching the
> topology information from HMAT before adopting the current approach.
> However, I encountered a firmware issue on my test systems
> (Granite Rapids and Sierra Forest).
> 
> Although each socket has its own locally attached CXL device, the HMAT
> only registers node1 (Socket 1) as the initiator for both CXL memory
> nodes (node2 and node3). As a result, the sysfs HMAT initiators for
> both node2 and node3 only expose node1.

Do you mean the Memory Proximity Domain Attributes Structure has
the "Proximity Domain for the Attached Initiator" set wrong?
Was this for it's presentation of the full path to CXL mem nodes, or
to a PXM with a generic port?  Sounds like you have SRAT covering
the CXL mem so ideal would be to have the HMAT data to GP and to
the CXL PXMs that BIOS has set up.

Either way having that set at all for CXL memory is fishy as it's about
where the 'memory controller' is and on CXL mem that should be at the
device end of the link.  My understanding of that is was only meant
to be set when you have separate memory only Nodes where the physical
controller is in a particular other node (e.g. what you do
if you have a CPU with DRAM and HBM).  Maybe we need to make the
kernel warn + ignore that if it is set to something odd like yours.

> 
> Even though the distance map shows node2 is physically closer to
> Socket 0 and node3 to Socket 1, the HMAT incorrectly defines the
> routing path strictly through Socket 1. Because the HMAT alone made it
> difficult to determine the exact physical socket connections on these
> systems, I ended up using the current CXL driver-based approach.

Are the HMAT latencies and bandwidths all there?  Or are some missing
and you have to use SLIT (which generally is garbage for historical
reasons of tuning SLIT to particular OS behaviour).

> 
> I wonder if others have experienced similar broken HMAT cases with CXL.
> If HMAT information becomes more reliable in the future, we could
> build a much more efficient structure.

Given it's being lightly used I suspect there will be many bugs :(
I hope we can assume they will get fixed however!

...

> 
> The complex topology cases you presented, such as multi-NUMA per socket,
> shared CXL switches, and IO expanders, are very important points.
> I clearly understand that the simple package-level grouping does not fully
> reflect the 1:1 relationship in these future hardware architectures.
> 
> I have also thought about the shared CXL switch scenario you mentioned,
> and I know the current design falls short in addressing it properly.
> While the current implementation starts with a simple socket-local
> restriction, I plan to evolve it into a more flexible node aggregation
> model to properly reflect all the diverse topologies you suggested.

If we can ensure it fails cleanly when it finds a topology that it can't
cope with (and I guess falls back to current) then I'm fine with a partial
solution that evolves.


> 
> Thanks again for your time and review.

You are welcome.

Thanks

Jonathan

> 
> Rakie Kim
> 
