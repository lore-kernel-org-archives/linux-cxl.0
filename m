Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E1E28CF45
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134908; cv=none; b=p3A9X5yUYSyeNGZmf+969EcB1WPCozF0i6WKKp2WdRnqJ9Gzp6YVkWG1+Q8Lcpz/tAkLds/831e358N6adkXiY572ZlbvIG3Cv+TDW1YebiFF603O6nJBV+Glt3+L7GbYnhaQeLSIAeFwXGg4Xj/hzwvHQ2d5FF/ZxoD10iZ79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134908; c=relaxed/simple;
	bh=yj81+g7gZs/qt7NZCioRwUmEYe9ae/R8jgcLvp80ztQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V1zwdbY619q3BRaV4tJIzE1IHXbPHocVptsALTHbzZ2I7jKJ8OSD6pQQHBats8I9Tv8pbmOglvXQxXC1znq6+csRAqSILg39wejb8T2vg5geewlGso+j8KldaM4fAL2I0CyVUbXIPIbL99V1gqTBLC92HvVySq0UqhhpVjRMRAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZxYfc4GSHz6M4Wr;
	Tue, 13 May 2025 19:10:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D54D61402F4;
	Tue, 13 May 2025 19:14:56 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 13:14:56 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, <mst@redhat.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <qemu-arm@nongnu.org>,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>, Itaru Kitayama
	<itaru.kitayama@linux.dev>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
	<philmd@linaro.org>
Subject: [PATCH v13 0/5] arm/virt: CXL support via pxb_cxl
Date: Tue, 13 May 2025 12:14:50 +0100
Message-ID: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

V13:
- Make CXL fixed memory windows sysbus devices.
  IIRC this was requested by Peter in one of the reviews a long time back
  but at the time the motivation was less strong than it becomes with some
  WiP patches for hotness monitoring and high performance direct connect
  where we need a machine type independent way to iterate all the CXL
  fixed memory windows. This is a convenient place to do it so drag that
  work forward into this series.

  This allows us to drop separate list and necessary machine specific
  access code in favour of
  object_child_foreach_recursive(object_get_root(),...)
  One snag is that the ordering of multiple fixed memory windows in that
  walk depends on the underlying g_hash_table iterations rather than the
  order of creation. In the memory map layout and ACPI table creation we
  need both stable and predictable ordering. Resolve this in a similar
  fashion to object_class_get_list_sorted() be throwing them in a GSList
  and sorting that. Only use this when a sorted list is needed.

  Dropped RFC as now I'm happy with this code and would like to get it
  upstream!  Particularly as it broken even today due to enscripten
  related changes that stop us using g_slist_sort(). Easy fix though.

Note that we have an issue for CXL emulation in general and TCG which
is being discussed in:
https://lore.kernel.org/all/20250425183524.00000b28@huawei.com/
(also affects some other platforms)

Until that is resolved, either rebase this back on 10.0 or just
don't let code run out of it (don't use KMEM to expose it as normal
memory, use DAX instead).

Previous cover letter.

Back in 2022, this series stalled on the absence of a solution to device
tree support for PCI Expander Bridges (PXB) and we ended up only having
x86 support upstream. I've been carrying the arm64 support out of tree
since then, with occasional nasty surprises (e.g. UNIMP + DT issue seen
a few weeks ago) and a fair number of fiddly rebases.
gitlab.com/jic23/qemu cxl-<latest date>

A recent discussion with Peter Maydell indicated that there are various
other ACPI only features now, so in general he might be more relaxed
about DT support being necessary. The upcoming vSMMUv3 support would
run into this problem as well.

I presented the background to the PXB issue at Linaro connect 2022. In
short the issue is that PXBs steal MMIO space from the main PCI root
bridge. The challenge is knowing how much to steal.

On ACPI platforms, we can rely on EDK2 to perform an enumeration and
configuration of the PCI topology and QEMU can update the ACPI tables
after EDK2 has done this when it can simply read the space used by the
root ports. On device tree, there is no entity to figure out that
enumeration so we don't know how to size the stolen region.

Three approaches were discussed:
1) Enumerating in QEMU. Horribly complex and the last thing we want is a
   3rd enumeration implementation that ends up out of sync with EDK2 and
   the kernel (there are frequent issues because of how those existing
   implementations differ.
2) Figure out how to enumerate in kernel. I never put a huge amount of work
   into this, but it seemed likely to involve a nasty dance with similar
   very specific code to that EDK2 is carrying and would very challenging
   to upstream (given the lack of clarity on real use cases for PXBs and
   DT).
3) Hack it based on the control we have which is bus numbers.
   No one liked this but it worked :)

The other little wrinkle would be the need to define full bindings for CXL
on DT + implement a fairly complex kernel stack as equivalent in ACPI
involves a static table, CEDT, new runtime queries via _DSM and a description
of various components. Doable, but so far there is no interest on physical
platforms. Worth noting that for now, the QEMU CXL emulation is all about
testing and developing the OS stack, not about virtualization (performance
is terrible except in some very contrived situations!)

Back to posting as an RFC because there was some discussion of approach to
modelling the devices that may need a bit of redesign.
The discussion kind of died out on the back of DT issue and I doubt anyone
can remember the details.

https://lore.kernel.org/qemu-devel/20220616141950.23374-1-Jonathan.Cameron@huawei.com/

There is only a very simple test in here, because my intent is not to
duplicate what we have on x86, but just to do a smoke test that everything
is hooked up.  In general we need much more comprehensive end to end CXL
tests but that requires a reaonsably stable guest software stack. A few
people have expressed interest in working on that, but we aren't there yet.

Note that this series has a very different use case to that in the proposed
SBSA-ref support:
https://lore.kernel.org/qemu-devel/20250117034343.26356-1-wangyuquan1236@phytium.com.cn/

SBSA-ref is a good choice if you want a relatively simple mostly fixed
configuration.  That works well with the limited host system
discoverability etc as EDK2 can be build against a known configuration.

My interest with this support in arm/virt is support host software stack
development (we have a wide range of contributors, most of whom are working
on emulation + the kernel support). I care about the weird corners. As such
I need to be able to bring up variable numbers of host bridges, multiple CXL
Fixed Memory Windows with varying characteristics (interleave etc), complex
NUMA topologies with wierd performance characteristics etc. We can do that
on x86 upstream today, or my gitlab tree. Note that we need arm support
for some arch specific features in the near future (cache flushing).
Doing kernel development with this need for flexibility on SBSA-ref is not
currently practical. SBSA-ref CXL support is an excellent thing, just
not much use to me for this work.

Jonathan Cameron (5):
  hw/cxl-host: Add an index field to CXLFixedMemoryWindow
  hw/cxl: Make the CXL fixed memory windows devices.
  hw/cxl-host: Allow split of establishing memory address and mmio
    setup.
  hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances
    pxb-cxl
  qtest/cxl: Add aarch64 virt test for CXL

 include/hw/arm/virt.h     |   4 +
 include/hw/cxl/cxl.h      |   4 +
 include/hw/cxl/cxl_host.h |   6 +-
 hw/acpi/cxl.c             |  83 +++++++++------
 hw/arm/virt-acpi-build.c  |  34 ++++++
 hw/arm/virt.c             |  29 +++++
 hw/cxl/cxl-host-stubs.c   |   8 +-
 hw/cxl/cxl-host.c         | 218 ++++++++++++++++++++++++++++++++------
 hw/i386/pc.c              |  51 ++++-----
 tests/qtest/cxl-test.c    |  59 ++++++++---
 tests/qtest/meson.build   |   1 +
 11 files changed, 389 insertions(+), 108 deletions(-)

-- 
2.43.0

