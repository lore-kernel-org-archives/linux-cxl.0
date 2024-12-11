Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659531FBCA8
	for <linux-cxl@vger.kernel.org>; Wed, 11 Dec 2024 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733883107; cv=none; b=PTvZ78CQin6cXd9gXHEWd7Gc7csD2MMH79Qw99dbl5m94gYdUMRiOSH5QFfkbq2t8ogkK26uGy1Nvw2y395UKNWtM8OYcKG+vcvG1DYeBAV8zrvTArPcqxm7lkHzuFEPF54xda/dcXnmPSORMRd7SCJ4FBYU9v8D5d5OiclocRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733883107; c=relaxed/simple;
	bh=FkeI779gC3Iaoe9ymUCAuzXvDG/5TMoK65NJK99pZLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tNt025ihwdWnYynYnq4w2SSMI7aIUgLpajdeo5A2Yrm9kDGPpvw+slAwyxFEYTGjuag0T4q9CLMgzx+vGXxRxLjNasnerqFut837Ku2egj6NOzNhi/AB1hAa1BMf79Np/on9N/u4WObTnR0n0olQKBjMEfoWiJtHi/ozV1nw/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAnh_DY9FhnSLFoCA--.16039S2;
	Wed, 11 Dec 2024 10:11:36 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwBnv3vO9FhnOi5nAA--.4806S3;
	Wed, 11 Dec 2024 10:11:27 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: rad@semihalf.com,
	peter.maydell@linaro.org,
	quic_llindhol@quicinc.com,
	marcin.juszkiewicz@linaro.org
Cc: Jonathan.Cameron@Huawei.com,
	chenbaozi@phytium.com.cn,
	linux-cxl@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH v4 0/1] Sbsa-ref CXL Enablement
Date: Wed, 11 Dec 2024 10:11:16 +0800
Message-Id: <20241211021117.120630-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBnv3vO9FhnOi5nAA--.4806S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWdYm48ArQABsX
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtw43ZrWDZw4fuFyxZr48Crg_yoWxCFy3pF
	1DK34SkrWvgryayrs3u34UWr15uw1kAa98Grn7G34jkFnFgryvvFyktF1Yva4UWF1UAFyU
	Xr1qqa40g3W2yaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

v3 -> v4:
- based on 'cxl/cxl-host: Support creation of a new CXL Host Bridge'[1]
- Align base addresses of CXL relevant Windows
- Remove redundant header files

v2 -> v3:
- create a new host bridge type: TYPE_SBSA_CXL_HOST
- CXL exclusive ECAM, PIO, MMIO32 & MMIO64 space in sbsa-ref
- combine all cxl infrastructure creating into one function

v1 -> v2:
- provide CXL exclusive MMIO32 & MMIO64 space
- hard coded two cxl root ports

RFC because
- Many contents are ported from Jonathan' patch on qemu virt design

- Less experience and not particularly confident in sbsa-ref address space design
  so this might be stupidly broken in a way I've not considered.

Background
==========
Currently the base CXL support for arm platforms is only on Jonathan's patches[2]
which have not yet merged into upstream. SBSA-REF can be more like a real machine,
thus my initial purpose is to support the simplest cxl VH topology on sbsa-ref to
verify the basic cxl function usage, therefore, some real machine could refer the
cxl running result on sbsa-ref.  

This series leverages Jonathan's patches to design [SBSA_CXL_CHBCR] and
[SBSA_CXL_FIXED_WINDOW] spaces for sbsa-ref layout. 

Regard to the burden of edk2 firmware, I try to build a static CEDT table and add
acpi0016, acpi0017 and other cxl relevant contents into acpi tables[3][4]. Hence it
doesn't need to communicate cxl contents via DT to edk2. 

CXL HOST design
===============
In previous version, the pxb-cxl-host with any cxl root ports and cxl endpoint devices
would occupy the BDF number of the original pcie domain resulting in the max available
pcie devices on sbsa-ref would decrease, which seems to bring a series of trouble. With
this patch[1], sbsa-ref could use the new cxl host bridge type (TYPE_CXL_HOST) to
avoid above problem.

For [SBSA_CXL_CHBCR], this creates a default cxl host bridge (0001:00) with two cxl root
ports on sbsa-ref, and the new memory layout places 64K space for one hard coded cxl host
bridge register regions in the sbsa-ref memmap. It means for now only two cxl type3
devices could be added on the cxl host, but personally it could satisfy my initial purpose
mentioned above. 

And the memory layout provides separate space windows for the cxl host bridge in the
sbsa-ref memmap:
- 64K  CXL Host Bridge Component Registers (CHBCR)
- 64K  CXL_PIO
- 128M CXL_MMIO
- 256M CXL_ECAM
- 4G   CXL_MMIO_HIGH

CXL FIXED WINDOW design
=======================
For [SBSA_CXL_FIXED_WINDOW], in order to provide CFMWs on sbsa-ref, this extends 1TB
space from the hole above RAM Memory [SBSA_MEM] for CXL Fixed Memory Window. 
- 1T   CXL_FIXED_WINDOW

0xA0000000000 is chosen as the base address of this space because of 3 reasons:
1) It is more suitable to choose a static address instead of that
implementation in virt, since a dynamic address space layout of
sbsa-ref is not appropriate for its original purpose as a reference
platform.

2) The Hotplug Memory address range should in the range of maximum
addressable range of sbsa-ref platform(0x10000000000-0x80ffffffffff).
It is satisfied the requirements of memory hotplug in linux kernel.

3) The start pfn of CFMW should exceed the reserved_pfn_range for
onlined numa node.

Usage of cxl on sbsa-ref
========================
With the 'create_cxl' and 'create_cxl_fixed_window', users don't need to input
'-device pxb-cxl' , '-device cxl-rp' and '-M cxl-fmw' parameters.

Thus, to run sbsa-ref with a cxl device could use:
qemu-system-aarch64 \
-object memory-backend-file,id=mem2,mem-path=/tmp/mem2,size=256M,share=true \
-device cxl-type3,bus=cxl.0,volatile-memdev=mem2,id=cxl-mem1 \

Incompatibility problem
=======================
Although the new cxl host bridge has been separated from the original pcie host, the
incompatibility problem of "-device qemu-xhci" is not resolved. Because the new device
to plug by qemu command would be enumerated at the largest domain(0001), for example,
if we add "-device qemu-xhci" to boot sbsa-ref with cxl, the lspci would show:

    root@ubuntu-jammy-arm64:~# lspci
    0000:00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
    0000:00:01.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
    0000:00:02.0 Display controller: Device 1234:1111 (rev 02)
    0001:00:00.0 PCI bridge: Intel Corporation Device 7075
    0001:00:01.0 PCI bridge: Intel Corporation Device 7075
    0001:00:02.0 USB controller: Red Hat, Inc. QEMU XHCI Host Controller (rev 01)
    0001:01:00.0 CXL: Intel Corporation Device 0d93 (rev 01)

    root@ubuntu-jammy-arm64:~# lspci -tv
    -+-[0001:00]-+-00.0-[01]----00.0  Intel Corporation Device 0d93
    |           +-01.0-[02]--
    |           \-02.0  Red Hat, Inc. QEMU XHCI Host Controller
    \-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
                +-01.0  Intel Corporation 82574L Gigabit Network Connection
                \-02.0  Device 1234:1111

Hence we should add "bus=pcie.0" when we want to plug some devices on the original
pcie bus, for example:
-device qemu-xhci,bus=pcie.0 \
or
-device nvme,serial=deadbeef,bus=pcie.0,drive=hdd \
-drive file=../disk/hdd.qcow2,format=qcow2,id=hdd,if=none \

So the result is:
    root@ubuntu-jammy-arm64:~# lspci
    0000:00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
    0000:00:01.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
    0000:00:02.0 Display controller: Device 1234:1111 (rev 02)
    0000:00:03.0 USB controller: Red Hat, Inc. QEMU XHCI Host Controller (rev 01)
    0001:00:00.0 PCI bridge: Intel Corporation Device 7075
    0001:00:01.0 PCI bridge: Intel Corporation Device 7075
    0001:01:00.0 CXL: Intel Corporation Device 0d93 (rev 01)

    root@ubuntu-jammy-arm64:~# lspci -tv
    -+-[0001:00]-+-00.0-[01]----00.0  Intel Corporation Device 0d93
    |           \-01.0-[02]--
    \-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
                +-01.0  Intel Corporation 82574L Gigabit Network Connection
                +-02.0  Device 1234:1111
                \-03.0  Red Hat, Inc. QEMU XHCI Host Controller

I am looking for suggestions on if there are better ways to do it.

This series patches are here to hopefully some comments to guide me!

Link:
[1]: https://lists.nongnu.org/archive/html/qemu-arm/2024-12/msg00350.html
[2]: https://lore.kernel.org/linux-cxl/20220616141950.23374-1-Jonathan.Cameron@huawei.com/
[3]: https://edk2.groups.io/g/devel/message/120851
[4]: https://edk2.groups.io/g/devel/topic/rfc_patch_edk2_platforms_v4/110023229

Yuquan Wang (1):
  hw/arm/sbsa-ref: Support CXL Host Bridge & CFMW

 docs/system/arm/sbsa.rst |   4 ++
 hw/arm/sbsa-ref.c        | 135 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 138 insertions(+), 1 deletion(-)

-- 
2.34.1

