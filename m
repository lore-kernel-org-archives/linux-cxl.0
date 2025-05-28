Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3318DB03
	for <linux-cxl@vger.kernel.org>; Wed, 28 May 2025 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430454; cv=none; b=SqrDfgxUbEdqvypXoB3jaPKV3kZ4cDjX56eJIGXLtUEeSHWSucx84boDdwRIM+PnCUDkvB5/EJkFidMc1tWqMFbaBVa6T0mqrdJej8Cuo0XwL/yziILrEH0c1F61xn7ova57wxMIDqzdOV4ZUerG/OAN+pFveVzWlweH/xG3OgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430454; c=relaxed/simple;
	bh=ijt4wnVpcxF7HnNcAOSZ5eVDAe7bNTrlhJkL2aqvvf0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pPGWsu2344i2if/Yc32X2FbsWTX/oUy2JOWZWvkuqdBpBiPxYx8OJBoovfQRQxOaDyPHv0Sg0Xm3792v1bCWR5d2Mnch5ejZjg3n5S3jZ+y/JTEedBH1A76Q2Rf1BmOOOig8R2Mzw7dapJcMRoeTZxEcCUNO9lW3DHZuAB7r1cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b6ms32hZ1z6L4xp;
	Wed, 28 May 2025 19:06:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D7DAD1402F5;
	Wed, 28 May 2025 19:07:27 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 May 2025 13:07:27 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>, Itaru Kitayama
	<itaru.kitayama@linux.dev>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
	<philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>
Subject: [PATCH v14 0/5] arm/virt: CXL support via pxb_cxl
Date: Wed, 28 May 2025 12:07:21 +0100
Message-ID: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

v14: Simplifications suggeseted by Itaru (and some extra simplifications
     that became apparent) and gather tags.
     See individual patches for more information.

Updated cover letter

Richard Henderson has posted a pull request with a fix for the TCG TLB
issue which will hopefully merge shortly (Thanks Richard!).

Back in 2022, this series stalled on the absence of a solution to device
tree support for PCI Expander Bridges (PXB) and we ended up only having
x86 support upstream. I've been carrying the arm64 support out of tree
since then, with occasional nasty surprises (e.g. UNIMP + DT issue seen
a few weeks ago) and a fair number of fiddly rebases.
gitlab.com/jic23/qemu cxl-<latest date>.  Will update shortly with this
series.

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

Also, we are kicking off some work on DCD virtualization, particularly to
support inter-host shared memory being presented up into a VM. That
will need upstream support on arm64 as it is built on top of the existing
CXL emulation to avoid the need for a separate guest software stack.

Note this is TCG only - it is possible to support limited use with KVM but
that needs additional patches not yet ready for upstream.  The challenge
is interleave - and the solution is don't interleave if you want to run
with KVM.

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
 hw/acpi/cxl.c             |  76 +++++++--------
 hw/arm/virt-acpi-build.c  |  34 +++++++
 hw/arm/virt.c             |  29 ++++++
 hw/cxl/cxl-host-stubs.c   |   8 +-
 hw/cxl/cxl-host.c         | 190 ++++++++++++++++++++++++++++++++------
 hw/i386/pc.c              |  51 +++++-----
 tests/qtest/cxl-test.c    |  59 +++++++++---
 tests/qtest/meson.build   |   1 +
 11 files changed, 353 insertions(+), 109 deletions(-)

-- 
2.48.1

