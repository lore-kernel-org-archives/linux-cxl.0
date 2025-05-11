Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF2DDDAD;
	Sun, 11 May 2025 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746930527; cv=none; b=svs/ZHkfOt5/hnUC6ojfYJ2KxMOV/FAULpMJF31FaB62OlyyzTq/TKvYDl3YHNoJ99P/w7ivmD466mH0pVe9v90Em5Y4oC95AVoJJIEEnUXa1KV7CBsvJufWLkfnO/7JmMDJ5CgIJBkKpH+hl+EnxZjWUaiq0niNhDKicvvlEyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746930527; c=relaxed/simple;
	bh=sD6J6tDTnlzdSn9rVyRoDmneE5zoNOD0uE4jeEiTX9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIs/lSHGnfq7ayYEuvq5NnhxoMcphypWrC2QVnyTe98OxQoxPvaYQ1U0NWGuiBsNyAGT5pZvemQSLoxm6+uWlJS3j8aih12KWK19J5Gp3ROKq9vCNlICCN9rJAaFULL+cO3sh/xzBhY+JeVU7EE5vLGj7AMNUPo0CY3mzBSeEBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ba1YKiOp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ba1YKiOp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ORSEdKtDgbhEkPglP72LO1MQmiaCw72R+qZZ+msDGjg=; b=Ba1YKiOpb/8pIY09AjOCJ529/f
	8NZ/K0k859+9TlKn8aqpXwo15bceH88Psx9v6KiyJx2uP4JvjYrGlGVEZQ1u6DsC0KdUBFm+hab0Y
	+2IgKlV/PAmFlJuWEHEbFEWR5fhb7ab4djqaaX/UrAoFBKqY33G3hRsh48d0mvF9zj+Dk5FAbqA77
	VTBqlaJIfg9UR5v8q69mCqkcnuiyAQ5y1poniZgmMeSg2h9oq4X3il8EXjYxXobPIUAUwaTvQgPAH
	dxq7UMl0bzOtcgXwkUPZf9O7bLYI+AiXXeaxAyKMn2/VM+ZLWH1yeFyPWmJgBogW3FFgqR8EK1tdU
	R0GBlYtQ==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uDwQj-0000000GXR0-3ggI;
	Sun, 11 May 2025 02:28:42 +0000
Message-ID: <5f958920-4cc3-42aa-9553-74b3b0a96751@infradead.org>
Date: Sat, 10 May 2025 19:28:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 13/18] cxl: docs/allocation/page-allocator
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net
References: <20250430181048.1197475-1-gourry@gourry.net>
 <20250430181048.1197475-14-gourry@gourry.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250430181048.1197475-14-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/25 11:10 AM, Gregory Price wrote:
> Document some interesting interactions that occur when exposing CXL
> memory capacity to page allocator.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  .../cxl/allocation/page-allocator.rst         | 86 +++++++++++++++++++
>  Documentation/driver-api/cxl/index.rst        |  1 +
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/allocation/page-allocator.rst
> 
> diff --git a/Documentation/driver-api/cxl/allocation/page-allocator.rst b/Documentation/driver-api/cxl/allocation/page-allocator.rst
> new file mode 100644
> index 000000000000..f5b21d3eb63f
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/allocation/page-allocator.rst
> @@ -0,0 +1,86 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================
> +The Page Allocator
> +==================
> +
> +The kernel page allocator services all general page allocation requests, such
> +as :code:`kmalloc`.  CXL configuration steps affect the behavior of the page
> +allocator based on the selected `Memory Zone` and `NUMA node` the capacity is
> +placed in.
> +
> +This section mostly focuses on how these configurations affect the page
> +allocator (as of Linux v6.15) rather than the overall page allocator behavior.
> +
> +NUMA nodes and mempolicy
> +========================
> +Unless a task explicitly registers a mempolicy, the default memory policy
> +of the linux kernel is to allocate memory from the `local NUMA node` first,
> +and fall back to other nodes only if the local node is pressured.
> +
> +Generally, we expect to see local DRAM and CXL memory on separate NUMA nodes,
> +with the CXL memory being non-local.  Technically, however, it is possible
> +for a compute node to have no local DRAM, and for CXL memory to be the
> +`local` capacity for that compute node.
> +
> +
> +Memory Zones
> +============
> +CXL capacity may be onlined in :code:`ZONE_NORMAL` or :code:`ZONE_MOVABLE`.
> +
> +As of v6.15, the page allocator attempts to allocate from the highest
> +available and compatible ZONE for an allocation from the local node first.
> +
> +An example of a `zone incompatibility` is attempting to service an allocation
> +marked :code:`GFP_KERNEL` from :code:`ZONE_MOVABLE`.  Kernel allocations are
> +typically not migratable, and as a result can only be serviced from
> +:code:`ZONE_NORMAL` or lower.
> +
> +To simplify this, the page allocator will prefer :code:`ZONE_MOVABLE` over
> +:code:`ZONE_NORMAL` by default, but if :code:`ZONE_MOVABLE` is depleted, it
> +will fallback to allocate from :code:`ZONE_NORMAL`.
> +
> +
> +Zone and Node Quirks
> +====================
> +Lets consider a configuration where the local DRAM capacity is largely onlined

   Let's

> +into :code:`ZONE_NORMAL`, with no :code:`ZONE_MOVABLE` capacity present. The
> +CXL capacity has the opposite configuration - all onlined in
> +:code:`ZONE_MOVABLE`.
> +
> +Under the default allocation policy, the page allocator will completely skip
> +:code:`ZONE_MOVABLE` has a valid allocation target.  This is because, as of

                        as

> +Linux v6.15, the page allocator does approximately the following: ::
> +
> +  for (each zone in local_node):
> +
> +    for (each node in fallback_order):
> +
> +      attempt_allocation(gfp_flags);
> +
> +Because the local node does not have :code:`ZONE_MOVABLE`, the CXL node is
> +functionally unreachable for direct allocation.  As a result, the only way
> +for CXL capacity to be used is via `demotion` in the reclaim path.
> +
> +This configuration also means that if the DRAM ndoe has :code:`ZONE_MOVABLE`
> +capacity - when that capacity is depleted, the page allocator will actually
> +prefer CXL :code:`ZONE_MOVABLE` pages over DRAM :code:`ZONE_NORMAL` pages.
> +
> +We may wish to invert these configurations in future Linux versions.
> +
> +If `demotion` and `swap` are disabled, Linux will begin to cause OOM crashes
> +when the DRAM nodes are depleted. This will be covered amore in depth in the

                                                          more

> +reclaim section.
> +
> +
> +CGroups and CPUSets
> +===================
> +Finally, assuming CXL memory is reachable via the page allocation (i.e. onlined
> +in :code:`ZONE_NORMAL`), the :code:`cpusets.mems_allowed` may be used by
> +containers to limit the accessibility of certain NUMA nodes for tasks in that
> +container.  Users may wish to utilize this in multi-tenant systems where some
> +tasks prefer not to use slower memory.
> +
> +In the reclaim section we'll discuss some limitations of this interface to
> +prevent demotions of shared data to CXL memory (if demotions are enabled).
> +

>  .. only::  subproject and html

-- 
~Randy

