Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F3144AB88
	for <linux-cxl@vger.kernel.org>; Mon,  7 Sep 2026 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774189; cv=none; b=IwWagR8lvSStSFQHxR8pTmiSyHZYWcS79kLfo//rd84Per8kt+U4q50c3a7gHNatkHOx9dUGIfWM9Y5KSq8j+vp4uQTv6K/3oq0Akow/40l7J/Ttmpq/4fJtffXP1ys0DkQF43GVbIMH/XNXBKsf5YnOj057MsLf7tA0YEhywtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774189; c=relaxed/simple;
	bh=3wwl/2cWQtwqqlvN7n0BzMbIZQ3zk810lwwXOIstGKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cl/oWCSYUVPC0tnBlTCMlkUML3KaZrKmOa/Y9qOKpguMXaaqFBlHAQ4mX7OhAIXrO1XX62eq/wZbHnEU4+BD7K0dlgo/BluhXN0bCRhXCWCtgSbJGdTjT9L82nkcl3Vu1n1OXcENc0RT2x1dq+Rtvk+wRfRGEP8nkuAgKWhgr0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L48ueAYU; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L48ueAYU"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788774182; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=xadJ0cdK2fBm/Zb1Cl+U5v3WRMT5l97oOmqKiq9rwI4=;
	b=L48ueAYUuX9urSLV2LPKWdPEijN0D/tCCEl9ejOcg44yP1prcQksLtWqCSBY+FRjg8e2/7m799kmK/aJrKFoXyncDyb5kwB5sujR9zg1md9bPoRWV5Y2efYtJi9e4ZvqwUvMvOInakEYnujF0t1e8ZLD+Exci6kVFinPGm2XBzc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0XATXGuq_1788773855;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XATXGuq_1788773855 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 07 Sep 2026 17:37:44 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: palmer@dabbelt.com,
	alistair.francis@wdc.com,
	mst@redhat.com,
	imammedo@redhat.com,
	sunilvl@ventanamicro.com,
	jic23@kernel.org
Cc: pbonzini@redhat.com,
	liwei1518@gmail.com,
	daniel.barboza@oss.qualcomm.com,
	zhiwei_liu@linux.alibaba.com,
	chao.liu@processmission.com,
	anisinha@redhat.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	junjie.cao@intel.com,
	guoren@kernel.org,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH v6 0/6] hw/riscv/virt: Add CXL support to the RISC-V virt machine
Date: Mon,  7 Sep 2026 17:37:27 +0800
Message-ID: <20260907093735.2753-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds CXL support to the RISC-V virt machine, following the
approach used by the ARM virt machine: CXL host bridges (pxb-cxl) are
described as ACPI0016 devices, an ACPI0017 (CXLM) device is added to the
DSDT with a _DEP on the CXL host bridges, and a CEDT table is built. A
bios-tables test is added to pin down the generated ACPI tables.

Changes since v5
----------------
  - Rebased onto current master, over the gpex_pcie_init() move to
    device-common.c: s->pci_bus is now assigned at the
    riscv_gpex_pcie_init() call site in virt_machine_init().
  - tests/qtest: switched to the renamed in-tree firmware blobs
    pc-bios/edk2-riscv64-{code,vars}.fd (Junjie).  The goldens are
    unchanged and still match with the updated edk2-stable202608 blob;
    all riscv64 ACPI cases pass.
  - hw/riscv/virt-acpi-build: the _DEP commit message now cites the
    companion kernel commit bf5418a5fe63 ("ACPI: scan: Honor _DEP for
    ACPI0016 PCI/CXL host bridge") alongside 3a59c3b772e5, both in
    v7.2 (Junjie).
  - Collected review tags: Junjie Cao's Reviewed-by/Tested-by on
    patches 1, 2 and 6.  Michael S. Tsirkin acked the ACPI parts on
    the v5 cover letter thread.

Changes since v4
----------------
  - tests/qtest: DSDT.cxl regenerated against the in-tree
    edk2-riscv-code.fd blob that the test boots (Junjie): the v4 golden
    carried the window allocation of my local edk2-stable202602 build.
    The 64-bit window is now 0x400100000..0x40010FFFF with the matching
    PCI0 range shift; the AML fragment in the commit message is updated
    accordingly.  CEDT.cxl is unchanged.
  - hw/riscv/virt: pci_bus_add_fw_cfg_extra_pci_roots() moved out of
    the cxl block (Junjie), so plain pxb-pcie expander bridges are also
    advertised to firmware with cxl=off, in line with arm/virt, pc and
    hppa.
  - Collected review tags.

Changes since v3
----------------
  - The CXL host bridge resource handling is reworked, following Junjie
    Cao's suggestion (and Igor Mammedov's earlier "fix UEFI" direction):
    instead of reserving a fixed 256 MiB carve-out and simulating the
    firmware PCI initialization in QEMU, the machine now advertises the
    pxb-cxl expander root buses to firmware via the etc/extra-pci-roots
    fw_cfg file (pci_bus_add_fw_cfg_extra_pci_roots(), as arm/virt and
    x86 do).  EDK2's PciBusDxe then enumerates behind the CXL host
    bridge and assigns the root-port window and bus numbers, and
    build_crs() emits a correct _CRS for the ACPI0016 host bridge.
    This keeps the machine code minimal (a single call, no carve-out),
    scales to multiple pxb-cxl host bridges, and lets firmware size the
    window to what is actually behind the bridge.
  - The bios-tables test is split into the staged flow documented in
    bios-tables-test.c, and ordered the same way the riscv64 goldens were
    originally added upstream (Sunil V L's commit cc3ba2422554 et al.):
    the feature code comes first, then three consecutive commits -- empty
    golden files + allowed-diff.h, the test code, and the populated golden
    master binaries with an emptied allowed-diff.h.

Changes since v2
----------------
  - hw/riscv/virt: The MMIO-window patch no longer touches the common
    gpex code (Igor).  The gpex_cfg.cxl_mmio32 field and the is_cxl
    static _CRS branch are dropped; the ACPI0016 _CRS now comes from the
    generic build_crs() path.  Since EDK2 does not enumerate the pxb-cxl
    expander bridge, riscv simulates the firmware PCI initialization
    (reserved window + depth-first bridge bus numbers) and re-applies it
    via a reset handler.
  - hw/riscv/virt: Drops the machine-global window/bus-range synthesis
    that did not scale past one pxb-cxl (Junjie).  The series targets a
    single CXL host bridge for now, documented in the commit message and
    a TODO.
  - hw/riscv/virt: CXL host register region and FMW setup folded into a
    single cxl_host_state_init() helper; redundant braces removed in
    create_fdt_pcie() (Daniel).
  - hw/riscv/virt-acpi-build: the _DEP commit message documents the
    kernel-compatibility behaviour (Alistair).
  - Carried review tags: Sunil V L's Reviewed-by on the _DEP patch and
    Alistair Francis's Acked-by on the test.

Changes since v1
----------------
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
    which is now merged upstream and thus no longer a prerequisite.
  - New patch 4: RISC-V ACPI bios-tables test for CXL, with golden AML
    files generated and included.

[1] https://lore.kernel.org/qemu-devel/20260318171918.146-1-alireza.sanaee@huawei.com/

Test
----
Built riscv64-softmmu and ran the new bios-tables test together with the
existing riscv64 ACPI tests; all pass.

Also booted an RVA22 guest with EDK2 firmware, using pxb-cxl + cxl-rp +
cxl-type3 + a CFMW: EDK2's PciBusDxe enumerates behind the CXL host
bridge (advertised via etc/extra-pci-roots), the root port and Type3
device show up (0000:0c:00.0 / 0000:0d:00.0), and 'cxl list' reports
the memdev (4 GiB) and the CFMWS root decoder.

QEMU invocation (CXL-relevant options shown):

    qemu-system-riscv64 \
        -M virt,aia=aplic-imsic,acpi=on,cxl=on \
        -cpu rva22s64 -smp 2 -m 4G \
        -object memory-backend-ram,id=vmem0,share=on,size=4G \
        -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
        -device cxl-rp,port=0,bus=cxl.1,id=rp0,chassis=0,slot=2 \
        -device cxl-type3,bus=rp0,volatile-memdev=vmem0 \
        -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
        ...

Verification (total system memory grows by 4 GiB after onlining):

    # cxl list
    # cxl enable-memdev mem0
    # cxl create-region -m -t ram -d decoder0.0 -w 1 mem0 -s 4G
    # daxctl online-memory dax0.0
    # free -h

Chen Pei (6):
  hw/riscv/virt: Add CXL support to the RISC-V virt machine
  hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for CXL host bridge
    dependency
  hw/riscv/virt: Advertise the CXL host bridge to firmware via
    extra-pci-roots
  tests/qtest: Prepare golden files for the RISC-V CXL ACPI test
  tests/qtest: Add RISC-V ACPI bios tables test for CXL
  tests/qtest: Update RISC-V CXL ACPI golden master binaries

 hw/riscv/Kconfig                      |   2 +
 hw/riscv/virt-acpi-build.c            |  52 +++++++++++++++++++++++++
 hw/riscv/virt.c                       |  56 +++++++++++++++++++++++++++++++---
 include/hw/riscv/virt.h               |   3 ++
 tests/data/acpi/riscv64/virt/CEDT.cxl | Bin 0 -> 108 bytes
 tests/data/acpi/riscv64/virt/DSDT.cxl | Bin 0 -> 6331 bytes
 tests/qtest/bios-tables-test.c        |  54 ++++++++++++++++++++++++++
 7 files changed, 163 insertions(+), 4 deletions(-)
 create mode 100644 tests/data/acpi/riscv64/virt/CEDT.cxl
 create mode 100644 tests/data/acpi/riscv64/virt/DSDT.cxl

-- 
2.50.1

