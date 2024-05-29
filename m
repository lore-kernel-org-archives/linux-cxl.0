Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A2E1B810
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002762; cv=none; b=uHEWTDSVAqjzpW6ahg0DdedbcI4KqTlo8h1K+VnxbAvm1UlrmYpdwtBMNDlSP44HPFEO1lRpegfXkbeLZRibAgJ74lNjnIaJhfMUbWemnl+1jQ6RzZYX3bvyYc30kfAapBA6xCpZrifsh/+nWJSZBEFLPf38+2BvVIFQfle2EzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002762; c=relaxed/simple;
	bh=Q6ghfMY4CGIU0is0H8wMmKUr0niHy8Afn6NUTZAvY0I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=seuPp1wL+pSo1HPnPE0cgdL3oQV15ap+14+yb17Rsi7dknRrjbSHr8OAkAsQaYGqrGFu8t9Sj/6V/YovTghm8oA3bKRI3SY89uHwcz6OwAaZa2n9X4uECMrmAno1ZEju1JdJyYM+uiis7pVWHc27yqAS4W9bP7Yzc0cnU2dSkrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqG79107cz6JBJC;
	Thu, 30 May 2024 01:08:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B8E21400CA;
	Thu, 30 May 2024 01:12:36 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 18:12:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, Will Deacon <will@kernel.org>, Jia He
	<justin.he@arm.com>, Mike Rapoport <rppt@linux.ibm.com>,
	<linuxarm@huawei.com>, <catalin.marinas@arm.com>,
	<Anshuman.Khandual@arm.com>, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Oscar Salvador <osalvador@suse.de>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, James Morse <james.morse@arm.com>
Subject: [RFC PATCH 0/8] arm64/memblock: Handling of CXL Fixed Memory Windows.
Date: Wed, 29 May 2024 18:12:28 +0100
Message-ID: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

RFC because
- I'm relying heavily on comments people made back when Dan proposed
  generic memblock based tracking of Numa nodes that his
  approach was fine for arm64 (but not for other architectures).
- Final patch.  I'm hoping someone will explain why the hot remove path
  removes reserved memblocks. That currently breaks this approach as we
  can't re-add memory at an address where previously removed some.
- I'm not particularly confident in this area so this might be
  stupidly broken in a way I've not considered.
  
On x86 CXL Fixed Memory Windows, as described in the ACPI CEDT table CFMW
Structures either result in a new NUMA node being assigned, or extend an
existing NUMA node. Unlike ACPI memory hotplug (where the PXM is included
in the signalling and whatever SRAT told us is largely ignored) CXL NUMA
node assignment is based on static data available early in boot.  Note
that whilst they define a range of physical memory, until we program various
address decoders + hotplug relevant devices there is no memory there.
The wrinkle is that the firmware may well have configured some CXL
memory and be presenting it as normal system memory (in appropriate
firmware tables etc).

Unfortunately despite using some nice general sounding functions, the
solution is somewhat x86 specific. This series is a first attempt to
support NUMA nodes for CXL memory on on arm64.  Note I tried or
considered few different approaches:
- A new MEMBLOCK flag to indicate that the memblock was just for
  NUMA mappings. That turned out to be fiddly as a lot of places
  needed modifying.
- Adding completely separate handling of CFMWS entries.
  That means handling them completely differently to SRAT entrees.
- Reparse the CEDT table at time of hotplug and figure out which
  node to use based on something like normal NUMA nodes, + number
  of CEDT CFMWS entry.  This solution looked likely to be messy
  and may be fragile.
So not seeing a way forwards I asked on the montly CXL open
source sync call...

Dan William's pointed out a similar discussion was had a few years
ago but a memblock approach was rejected because only arm64 uses
memblocks as the single source of information of NUMA nodes for
memory. Given I'm looking at ARM64 that sounded perfect.

[PATCH v2 00/22] device-dax: Support sub-dividing soft-reserved ranges
https://lore.kernel.org/linux-mm/159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com/

This series leverages two of Dan's patches with minor tweaks.
Very kind of Dan to write nice patches for arm64 support so
I've kept the original authorship as my changes were mainly code
movement.

The remainder of the series deals with the differences between CFMWS
address ranges and soft reserved ones - primarily that there is not necessarily
anything in the EFI memory map or similar so we need to add an entry.

The solution is a little ugly and this isn't an area of the kernel I know
at all well, so I'd love to hear suggestions of a better way to do this!

As I don't have an arm64 system that does the mixture of firmware setup
CXL memory and additional hotplugged memory dealt with by the OS those
code paths were tested by a dirty hack to create overlapping memblocks.

Dan Williams (2):
  arm64: numa: Introduce a memory_add_physaddr_to_nid()
  arm64: memblock: Introduce a generic phys_addr_to_target_node()

Jonathan Cameron (6):
  mm: memblock: Add a means to add to memblock.reserved
  arch_numa: Avoid onlining empty NUMA nodes
  arch_numa: Make numa_add_memblk() set nid for memblock.reserved
    regions
  arm64: mm: numa_fill_memblks() to add a memblock.reserved region if
    match.
  acpi: srat: cxl: Skip zero length CXL fixed memory windows.
  HACK: mm: memory_hotplug: Drop memblock_phys_free() call in
    try_remove_memory()

 arch/arm64/include/asm/sparsemem.h |  8 ++++
 arch/arm64/mm/init.c               | 77 ++++++++++++++++++++++++++++++
 drivers/acpi/numa/srat.c           |  5 ++
 drivers/base/arch_numa.c           | 12 +++++
 include/linux/memblock.h           | 10 ++++
 include/linux/mm.h                 | 14 ++++++
 mm/memblock.c                      | 33 +++++++++++--
 mm/memory_hotplug.c                |  2 +-
 mm/mm_init.c                       | 29 ++++++++++-
 9 files changed, 185 insertions(+), 5 deletions(-)

-- 
2.39.2

