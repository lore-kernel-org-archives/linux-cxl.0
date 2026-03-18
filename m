Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEA43B4E99;
	Wed, 18 Mar 2026 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836572; cv=none; b=DOQ0MsqVQ3cU5DVs7neQz0n9AQe2AebZnfiGU+4iEfvSDYCFYFghi1vHTYWVrAbrjdYD1RkGdDgOs60gYW1L/qdl3Ux2CTOEYkgAPmCOEtTdWztbdw3lJfQqm04ZX62HWrZ7GElsTza/3X/bYkrUvIn27tEY2n3QdqE3umWWhw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836572; c=relaxed/simple;
	bh=8SCgM2orMuSK0CRmE/gDjRZNlVs/GpLiHuC9Rhczq7g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0jopDZZe2dPBW8Px3AfCmrK0Tt3f4AL5a0EzkLRdgrLEkYt7HBVZJ3hkKBrLgbZlxSlVYyHTWeZccjmuG2JcoBPR2xKq7R80+1po6L+OfXD3HNyAlTNv8tHrG7sOdMloktuSEgXO78K7YobRgw7sYySp5GUJi2ehIfbnZFa9sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fbScW3QDJzJ46cQ;
	Wed, 18 Mar 2026 20:21:47 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DA0B40584;
	Wed, 18 Mar 2026 20:22:45 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 18 Mar
 2026 12:22:43 +0000
Date: Wed, 18 Mar 2026 12:22:42 +0000
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
	<yunjeong.mun@sk.com>
Subject: Re: [RFC PATCH 2/4] mm/memory-tiers: introduce socket-aware
 topology management for NUMA nodes
Message-ID: <20260318122242.00004e0d@huawei.com>
In-Reply-To: <20260316051258.246-3-rakie.kim@sk.com>
References: <20260316051258.246-1-rakie.kim@sk.com>
	<20260316051258.246-3-rakie.kim@sk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 16 Mar 2026 14:12:50 +0900
Rakie Kim <rakie.kim@sk.com> wrote:

> The existing NUMA distance model provides only relative latency values
> between nodes and lacks any notion of structural grouping such as socket
> or package boundaries. As a result, memory policies based solely on
> distance cannot differentiate between nodes that are physically local
> to the same socket and those that belong to different sockets. This
> often leads to inefficient cross-socket demotion and suboptimal memory
> placement.
> 
> This patch introduces a socket-aware topology management layer that
> groups NUMA nodes according to their physical package (socket)
> association. Each group forms a "memory package" that explicitly links
> CPU and memory-only nodes (such as CXL or HBM) under the same socket.
> This structure allows the kernel to interpret NUMA topology in a way
> that reflects real hardware locality rather than relying solely on
> flat distance values.
> 
> By maintaining socket-level grouping, the kernel can:
>  - Enforce demotion and promotion policies that stay within the same
>    socket.
>  - Avoid unintended cross-socket migrations that degrade performance.
>  - Provide a structural abstraction for future policy and tiering logic.
> 
> Unlike ACPI-provided distance tables, which offer static and symmetric
> relationships, this socket-aware model captures the true hardware
> hierarchy and provides a flexible foundation for systems where the
> distance matrix alone cannot accurately express socket boundaries or
> asymmetric topologies.

Careful with the generalities in here. There is no way to derive the
'true' hierarchy. What this is doing is applying a particular set
of heuristics to the data that ACPI provided and attempting to use
that to derive relationships. In simple cases that might work fine.0

Doing so is OK in an RFC for discussion but this will need testing
against a wide range of topologies to at least ensure it fails gracefully.
Note we've had to paper over quite a few topology assumptions in the
kernel and this feels like another one that will bite us later.

I'd avoid the socket terminology as multiple NUMA nodes in sockets
have been a thing for many years. Today there can even be multiple
IO dies with a complex 'distance' relationship wrt to the CPUs
in that socket. Topologies of memory controllers in those
packages are another level of complexity.


Otherwise a few general things from a quick look. 

I'd avoid goto out; where out just returns.  That just makes code
flow more complex and often makes for longer code. When you have
an error and there is nothing to cleanup just return immediately.

guard() / scoped_guard() will help simplify some of the locking.

Thanks,

Jonathan

