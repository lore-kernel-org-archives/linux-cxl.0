Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09CD3242DF
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jun 2026 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775520; cv=none; b=iy5Ik+Wdv33W3uMO2fqZbk4glm03aj00Vc6At5TPGz7Sm9EMpk3zUsiDN20OLhkQtVfGI5lK7hVdaKRb+59KgUKLGnvpV38MZkvA1VWOvmTF4dxHZnD51weMWQ5V8NV9lNx8Ud+hQy2exv4ebsduB1q8gdvEmCI3/d5Y7Lp43Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775520; c=relaxed/simple;
	bh=jAc0Vetj600OPPjguWZBQje/JGOtFw8jWlHY03QZPgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dAKnJlqUc/4TF60I1TmDhfcxnhks+PleP5giPbgAKmJe4Hr0c3KxP/9+O1hGTe0FIMnCbRgeDaOMzBW+wMy4r0Ys+e9ROAJkHBTwZFAOjzV17ME2t/QUHRsqOsFm00eeFixx4oY1v/MO4wEeN0DEuJfrTa0FALD+3Ttg4hCTDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xmcr3Sss; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xmcr3Sss"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781775515; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=97ymu4KBxBp/OQDwgYUMqaKqMzm8RdydWTCp6VQPG4w=;
	b=Xmcr3Sssg7gzeHTCcg9V5i2LmSOraggon0qS86//XUqJ7WnXuKpC+dYb9RqDO1fWNYTwqop39TO9iO/f8vdBGnZVV9MF6vBI4CaF7IxYGc+Di5lVvhS38Z8bs35JOTCUGA04hqH8dhTQZtq9J5Sc7ScOGU/LjFZv+Rt7AxgnAio=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X56RwJP_1781775507;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X56RwJP_1781775507 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 17:38:34 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: jic23@kernel.org,
	pbonzini@redhat.com,
	palmer@dabbelt.com,
	alistair.francis@wdc.com,
	liwei1518@gmail.com,
	daniel.barboza@oss.qualcomm.com,
	zhiwei_liu@linux.alibaba.com,
	chao.liu.zevorn@gmail.com,
	sunilvl@ventanamicro.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	imammedo@redhat.com,
	mst@redhat.com,
	guoren@kernel.org
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/4] hw/riscv/virt: Add CXL support to the RISC-V virt machine
Date: Thu, 18 Jun 2026 17:38:22 +0800
Message-ID: <20260618093827.3507-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds CXL (Compute Express Link) support to the RISC-V virt
machine in QEMU, following the same approach as the ARM virt machine.

Prerequisite
------------
This series depends on Alireza Sanaee's v8 series [1]:

  [1/3] hw/cxl: Use HPA in cxl_cfmws_find_device() rather than offset
        in window
  [2/3] hw/cxl: Allow cxl_cfmws_find_device() to filter on whether
        interleaved paths are accepted
  [3/3] hw/cxl: Add a performant (and correct) path for the non
        interleaved cases

Patch [1/3] is already in the tree. Patches [2/3] and [3/3] have been
tested and verified functional on RISC-V QEMU with CXL enabled.  They
are not included in this posting; please apply them before this series.

Series overview
---------------
  [1/4] (hw/riscv/virt): Wires up the core CXL machine support --
  Kconfig selects, CXLState, PCIBus pointer (pci_bus), cxl_machine_init(),
  CXL host register region, FMW mapping, and machine_done hooks.

  [2/4] (hw/riscv/virt-acpi-build): Adds ACPI0017 (CXLM) to the
  DSDT with a _DEP on every ACPI0016 CXL host bridge device.  The _DEP
  ensures the OS defers ACPI0017 enumeration until acpi_pci_root has
  attached all CXL host bridges, fixing a probe-ordering race that
  leaves the CXL port topology incomplete.  A corresponding kernel
  change to call acpi_dev_clear_dependencies() in acpi_pci_root_add()
  is required on the Linux side. That kernel patch has merged:
  https://lore.kernel.org/linux-pci/20260526025118.38935-1-cp0613@linux.alibaba.com/

  [3/4] (hw/riscv/virt, gpex): Reserves the top 256 MiB of the
  32-bit MMIO window for CXL host bridges.  CXL component-register
  BARs are 64-bit non-prefetchable; per PCI-to-PCI Bridge Architecture
  Specification Rev 1.2 §3.2.5.8-10, only the prefetchable window can
  be 64-bit, so Linux places these BARs in the 32-bit non-prefetchable
  bridge window.  Without this reservation PCI0 consumes the entire
  1 GiB 32-bit range and CXL bridges get an empty _CRS, preventing
  BAR assignment.

  [4/4] (tests/qtest): Adds a RISC-V bios-tables test for the CXL
  variant.  Expected AML golden files (DSDT.cxl, CEDT.cxl) are
  generated and included.

Changes from v1
---------------
  - hw/riscv/virt: PCIBus *bus renamed to PCIBus *pci_bus (Jonathan).
  - hw/riscv/virt: Dropped outer if (s->pci_bus) guard around
    cxl_hook_up_pxb_registers(); the function already handles a NULL
    bus internally (Jonathan).
  - hw/riscv/virt-acpi-build: All s->bus references updated to
    s->pci_bus; iasl -d decompiled DSDT fragment added to commit
    message.
  - hw/riscv/virt,gpex: Commit message expanded with PCI-to-PCI Bridge
    Spec §3.2.5.8/9/10 citations (Jonathan).
  - Original patch 4 ("Map committed HDM decoder ranges as RAM for
    direct DMA") dropped; superseded by Alireza Sanaee's v8 series [1],
    which correctly handles the interleaved/non-interleaved split and
    supports KVM.
  - New patch 4: RISC-V ACPI bios-tables test for CXL, with golden AML
    files generated and included.

[1] https://lore.kernel.org/qemu-devel/20260318171918.146-1-alireza.sanaee@huawei.com/

Test
---------------
Tested on the RISC-V virt machine with EDK2 firmware and a buildroot
guest carrying the kernel patches above.

QEMU invocation (CXL-relevant options shown; EDK2 pflash, -bios,
-kernel, -append and the virtio-blk rootfs are as usual):

    qemu-system-riscv64 \
        -M virt,aia=aplic-imsic,acpi=on,cxl=on \
        -cpu rv64 -smp 2 -m 4G,maxmem=8G,slots=8 \
        -object memory-backend-ram,id=vmem0,share=on,size=4G \
        -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
        -device cxl-rp,port=0,bus=cxl.1,id=rp0,chassis=0,slot=2 \
        -device cxl-type3,bus=rp0,volatile-memdev=vmem0,id=cxl-vmem0 \
        -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
        ...   # EDK2 pflash + -bios fw_dynamic.bin + -kernel Image
              # + virtio-blk rootfs + -append "root=/dev/vda ..."

Verification (compare the two `free -h` outputs: total system memory
grows by 4 GiB after onlining):

    # free -h
    # cxl list
    # cxl enable-memdev mem0
    # cxl create-region -m -t ram -d decoder0.0 -w 1 mem0 -s 4G
    # daxctl online-memory dax0.0
    # free -h

Chen Pei (4):
  hw/riscv/virt: Add CXL support to the RISC-V virt machine
  hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for CXL host bridge
    dependency
  hw/riscv/virt,gpex: Provide 32-bit MMIO window for CXL host bridges
  tests/qtest: Add RISC-V ACPI bios tables test for CXL

 hw/pci-host/gpex-acpi.c               |  36 +++++++++-
 hw/riscv/Kconfig                      |   2 +
 hw/riscv/virt-acpi-build.c            |  52 ++++++++++++++
 hw/riscv/virt.c                       |  98 +++++++++++++++++++++++---
 include/hw/pci-host/gpex.h            |   1 +
 include/hw/riscv/virt.h               |   3 +
 tests/data/acpi/riscv64/virt/CEDT.cxl | Bin 0 -> 108 bytes
 tests/data/acpi/riscv64/virt/DSDT.cxl | Bin 0 -> 6212 bytes
 tests/qtest/bios-tables-test.c        |  54 ++++++++++++++
 9 files changed, 234 insertions(+), 12 deletions(-)
 create mode 100644 tests/data/acpi/riscv64/virt/CEDT.cxl
 create mode 100644 tests/data/acpi/riscv64/virt/DSDT.cxl

-- 
2.50.1

