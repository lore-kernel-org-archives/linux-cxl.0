Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A29C42586A
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182638; cv=none; b=Gb7HDNW7lUjJ88+XmDt/WY47zP9OzJwDrPB4ofnldTXKahiXW+1U7mLweRdNlllLNcc2TNJEhfejv7ptmdHLoE7HZONhP+r5r6q2QEnSPKH7I2hc51CwGXNni2QCzusi5IAohIywlpQ++3EbI55jmm2Sanz0bIUsQiXgkdbrOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182638; c=relaxed/simple;
	bh=6wPc1/DJJ9GF4O5V7pqDrye6P2cgqhDQz1D8yRUsR90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cmRYPjNfPRxcsOzDjvs0mmRZR29CX4DqEZ73940cxjlZsO9+7N1hW862Oe/Ejgxz8O3XPHpdIyafC/F3goqCsL/m6q8qEWKE4LTKu7mcTbULIaw3KVGV2pFsKnTwfZDBaIP4QxpbNyXitKm1pcG3fKXGsNbQoQVirO8u2+6CM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YsQpTXER; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YsQpTXER"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788182633; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=ebfB50GorQaqwPKuqdT6MLNBmfvdBPgdAQHiPcFhTZc=;
	b=YsQpTXERmk7V9AAlN8WyQEOxcqx72Xi03yXdNdvnpCdrXWNy7ZmG30yK1CcTKiyoTUbIIBG7qj71nUqN2sC+yRI4gr4g5F/GhuL9TrngwzTe6Rdy2zJKGLk27NwCjKUbl3cLIfoIqfqwa0V4W1SESNNxoLN5cuMHbcBQutct+yA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X9znfmV_1788182621;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9znfmV_1788182621 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 21:23:52 +0800
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
Subject: [PATCH v5 0/6] hw/riscv/virt: Add CXL support to the RISC-V virt machine
Date: Mon, 31 Aug 2026 21:23:31 +0800
Message-ID: <20260831132340.5345-1-cp0613@linux.alibaba.com>
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
 hw/riscv/virt.c                       |  46 ++++++++++++++++++++++
 include/hw/riscv/virt.h               |   3 ++
 tests/data/acpi/riscv64/virt/CEDT.cxl | Bin 0 -> 108 bytes
 tests/data/acpi/riscv64/virt/DSDT.cxl | Bin 0 -> 6331 bytes
 tests/qtest/bios-tables-test.c        |  54 ++++++++++++++++++++++++++
 7 files changed, 157 insertions(+)
 create mode 100644 tests/data/acpi/riscv64/virt/CEDT.cxl
 create mode 100644 tests/data/acpi/riscv64/virt/DSDT.cxl

-- 
2.50.1

