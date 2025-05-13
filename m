Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FAF1A23AD;
	Tue, 13 May 2025 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747159010; cv=none; b=SuUBZIq1m4/WmhMXNzlbGIZaJf7qL7QDXuQUiRkjA4a9GVHBfv5YZKdQAAsDHHux6nx96E2oTYg5FKXwa4gy1JS9ETk4kifW0dLANlHxwbGcCqdj9l+e+mZ6aBtP/J39Wv3WrltBXxMddnnHO7XUFalYXlJfzJbClzA3KKEv3IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747159010; c=relaxed/simple;
	bh=W6+yokoThvaOBBG/FB21beFAxqHZyI9YwRPBjPpV2mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTQjMSTCcr0kO9P2J/2StPiVJn7+xTCXu9iAwsLT/oQODHmB/CNNWYqNWc+a0nR12vhFiSRwXrvLzL9prjmh0GbzQYnHNvi5fUSgVrx2k2M/v1Mx5jx7XQPTPxRVzYxCGsdDxg+wBsHcCp09Qrwp/Q2h4O1MWgLMHGmr5m8Y69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfSPPNJ5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfSPPNJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747159008; x=1778695008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W6+yokoThvaOBBG/FB21beFAxqHZyI9YwRPBjPpV2mQ=;
  b=OfSPPNJ5rQY3xUtmCXdz71fY30FoXpM6c5tgD/PlJ2PMFN7QzXGlz/of
   5rpc8BHCEMaALYIZ2qzxtTYGRg9hPAXPSChKo8wkFbKJHxjaMT9FEaD1X
   ekHUgj7J8JgPoinHZOfNl8l60Zu6uExC0BQEMSsPTgyaJv9YS8xBUa4MM
   puB+q81rXAOxsz3nyt2HYCHOdQPIZhhVns7vESe4gajO6/hIzHrTgh0Tq
   hUYJ2fixpRvzWui3Z1ydmUFd168fFjmtKFU7Vy9pcwYEw2OvmqDjjuCjx
   MMR9iUQk1R3L4MKiQd1XG10ogkEK4vAdfN0mrMl3m4LOc1rEOd2Q7tCuG
   Q==;
X-CSE-ConnectionGUID: PVYQYT1iREKgDHWyGOIXgA==
X-CSE-MsgGUID: W6Lt1jp4TVWz7n+jNJdmIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="48713146"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="48713146"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 10:56:47 -0700
X-CSE-ConnectionGUID: ie/sR7Q9QIuQkNkZA4lbqw==
X-CSE-MsgGUID: K66ercwtRwWcEe8NNUXZnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="142885630"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.109.16]) ([10.125.109.16])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 10:56:47 -0700
Message-ID: <c940d96a-d021-44e1-85e9-362ae4dd8d74@intel.com>
Date: Tue, 13 May 2025 10:56:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/17] cxl: docs/linux - early boot configuration
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net
References: <20250512162134.3596150-1-gourry@gourry.net>
 <20250512162134.3596150-9-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250512162134.3596150-9-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/25 9:21 AM, Gregory Price wrote:
> Document __init time configurations that affect CXL driver probe
> process and memory region configuration.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/driver-api/cxl/index.rst        |   1 +
>  .../driver-api/cxl/linux/early-boot.rst       | 131 ++++++++++++++++++
>  2 files changed, 132 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/linux/early-boot.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index bc2228c77c32..d2eefe575604 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -34,6 +34,7 @@ that have impacts on each other.  The docs here break up configurations steps.
>     :caption: Linux Kernel Configuration
>  
>     linux/overview
> +   linux/early-boot
>     linux/access-coordinates
>  
>  
> diff --git a/Documentation/driver-api/cxl/linux/early-boot.rst b/Documentation/driver-api/cxl/linux/early-boot.rst
> new file mode 100644
> index 000000000000..8c1c497bc772
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/linux/early-boot.rst
> @@ -0,0 +1,131 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================
> +Linux Init (Early Boot)
> +=======================
> +
> +Linux configuration is split into two major steps: Early-Boot and everything else.
> +
> +During early boot, Linux sets up immutable resources (such as numa nodes), while
> +later operations include things like driver probe and memory hotplug.  Linux may
> +read EFI and ACPI information throughout this process to configure logical
> +representations of the devices.
> +
> +During Linux Early Boot stage (functions in the kernel that have the __init
> +decorator), the system takes the resources created by EFI/BIOS (ACPI tables)
> +and turns them into resources that the kernel can consume.
> +
> +
> +BIOS, Build and Boot Options
> +============================
> +
> +There are 4 pre-boot options that need to be considered during kernel build
> +which dictate how memory will be managed by Linux during early boot.
> +
> +* EFI_MEMORY_SP
> +
> +  * BIOS/EFI Option that dictates whether memory is SystemRAM or
> +    Specific Purpose.  Specific Purpose memory will be deferred to
> +    drivers to manage - and not immediately exposed as system RAM.
> +
> +* CONFIG_EFI_SOFT_RESERVE
> +
> +  * Linux Build config option that dictates whether the kernel supports
> +    Specific Purpose memory.
> +
> +* CONFIG_MHP_DEFAULT_ONLINE_TYPE
> +
> +  * Linux Build config that dictates whether and how Specific Purpose memory
> +    converted to a dax device should be managed (left as DAX or onlined as
> +    SystemRAM in ZONE_NORMAL or ZONE_MOVABLE).
> +
> +* nosoftreserve
> +
> +  * Linux kernel boot option that dictates whether Soft Reserve should be
> +    supported.  Similar to CONFIG_EFI_SOFT_RESERVE.
> +
> +Memory Map Creation
> +===================
> +
> +While the kernel parses the EFI memory map, if :code:`Specific Purpose` memory
> +is supported and detected, it will set this region aside as
> +:code:`SOFT_RESERVED`.
> +
> +If :code:`EFI_MEMORY_SP=0`, :code:`CONFIG_EFI_SOFT_RESERVE=n`, or
> +:code:`nosoftreserve=y` - Linux will default a CXL device memory region to
> +SystemRAM.  This will expose the memory to the kernel page allocator in
> +:code:`ZONE_NORMAL`, making it available for use for most allocations (including
> +:code:`struct page` and page tables).
> +
> +If `Specific Purpose` is set and supported, :code:`CONFIG_MHP_DEFAULT_ONLINE_TYPE_*`
> +dictates whether the memory is onlined by default (:code:`_OFFLINE` or
> +:code:`_ONLINE_*`), and if online which zone to online this memory to by default
> +(:code:`_NORMAL` or :code:`_MOVABLE`).
> +
> +If placed in :code:`ZONE_MOVABLE`, the memory will not be available for most
> +kernel allocations (such as :code:`struct page` or page tables).  This may
> +significant impact performance depending on the memory capacity of the system.
> +
> +
> +NUMA Node Reservation
> +=====================
> +
> +Linux refers to the proximity domains (:code:`PXM`) defined in the SRAT to
> +create NUMA nodes in :code:`acpi_numa_init`. Typically, there is a 1:1 relation
> +between :code:`PXM` and NUMA node IDs.
> +
> +SRAT is the only ACPI defined way of defining Proximity Domains. Linux chooses
> +to, at most, map those 1:1 with NUMA nodes. CEDT adds a description of SPA
> +ranges which Linux may wish to map to one or more NUMA nodes.
> +
> +If there are CXL ranges in the CFMWS but not in SRAT, then a fake :code:`PXM`
> +is created (as of v6.15). In the future, Linux may reject CFMWS not described
> +by SRAT due to the ambiguity of proximity domain association.
> +
> +It is important to note that NUMA node creation cannot be done at runtime. All
> +possible NUMA nodes are identified at :code:`__init` time, more specifically
> +during :code:`mm_init`. The CEDT and SRAT must contain sufficient :code:`PXM`
> +data for Linux to identify NUMA nodes their associated memory regions.
> +
> +The relevant code exists in: :code:`linux/drivers/acpi/numa/srat.c`.
> +
> +See the Example Platform Configurations section for more information.
> +
> +Memory Tiers Creation
> +=====================
> +Memory tiers are a collection of NUMA nodes grouped by performance characteristics.
> +During :code:`__init`, Linux initializes the system with a default memory tier that
> +contains all nodes marked :code:`N_MEMORY`.
> +
> +:code:`memory_tier_init` is called at boot for all nodes with memory online by
> +default. :code:`memory_tier_late_init` is called during late-init for nodes setup
> +during driver configuration.
> +
> +Nodes are only marked :code:`N_MEMORY` if they have *online* memory.
> +
> +Tier membership can be inspected in ::
> +
> +  /sys/devices/virtual/memory_tiering/memory_tierN/nodelist
> +  0-1
> +
> +If nodes are grouped which have clear difference in performance, check the HMAT
> +and CDAT information for the CXL nodes.  All nodes default to the DRAM tier,
> +unless HMAT/CDAT information is reported to the memory_tier component via
> +`access_coordinates`.
> +
> +Contiguous Memory Allocation
> +============================
> +The contiguous memory allocator (CMA) enables reservation of contiguous memory
> +regions on NUMA nodes during early boot.  However, CMA cannot reserve memory
> +on NUMA nodes that are not online during early boot. ::
> +
> +  void __init hugetlb_cma_reserve(int order) {
> +    if (!node_online(nid))
> +      /* do not allow reservations */
> +  }
> +
> +This means if users intend to defer management of CXL memory to the driver, CMA
> +cannot be used to guarantee huge page allocations.  If enabling CXL memory as
> +SystemRAM in `ZONE_NORMAL` during early boot, CMA reservations per-node can be
> +made with the :code:`cma_pernuma` or :code:`numa_cma` kernel command line
> +parameters.

