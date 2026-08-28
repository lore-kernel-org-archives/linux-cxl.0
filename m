Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B106146A603
	for <linux-cxl@vger.kernel.org>; Fri, 28 Aug 2026 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930017; cv=none; b=MZNM66aYj5LORIjHGP5R4UwaHERbPVsihg46UC61EUmgTQNV4VjImmGplGlK1j1aDKMwUJbcQo+47pQbDogub7BIkmboinu6zKqB8rkVr5UVRs3h7aOTFhY3eILera9mFw52C1/ur/Z1gjymaTTeubO0ZPT/JqSTNgZMW10Q30U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930017; c=relaxed/simple;
	bh=b/JzxGHOaDm0eXD4kl/mslZxgtjYsFN2Eh8SK8OM27I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gD4/P1sJ7B9wYC4omHbFFH7fCnKLESnBLcdUHLNkCg/W051sJYLTiSwVK0VnWfjRdYp4J2JcOYPu+ohyXUjN5DOZiGGTay3xTi4Eg2ZFsdPMBOhB2OSlE9kQl5hmIBOC0w0GCGr7t8r5bA68w2yBsIeaonbql64eiXaBtalcbbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=va2L7i/i; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="va2L7i/i"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787930010; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=VczuAjAG7lF2KeyCwVeFZP+t9HaL5xy/FEvZ6Ejt61g=;
	b=va2L7i/iuud0I0InTaFbPVDLv6lfTk4jq0HrRhKLbM4tiIyZpj1IqrhKN57kM2EQIPox4sZ5iSdicLcEw2TP3JKmPXnQPURHLW3VHOTJMTVHaMhD/YRfphBQ+l3fkMbga9C8pqcW9apy5Ed2CRlBufnzLiNiW58BeFGq1ka7/yc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X9md4vf_1787929998;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9md4vf_1787929998 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Aug 2026 23:13:28 +0800
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
Subject: [PATCH v4 0/6] hw/riscv/virt: Add CXL support to the RISC-V virt machine
Date: Fri, 28 Aug 2026 23:12:59 +0800
Message-ID: <20260828151317.815-1-cp0613@linux.alibaba.com>
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
 hw/riscv/virt.c                       |  45 +++++++++++++++++++++
 include/hw/riscv/virt.h               |   3 ++
 tests/data/acpi/riscv64/virt/CEDT.cxl | Bin 0 -> 108 bytes
 tests/data/acpi/riscv64/virt/DSDT.cxl | Bin 0 -> 6331 bytes
 tests/qtest/bios-tables-test.c        |  54 ++++++++++++++++++++++++++
 7 files changed, 156 insertions(+)
 create mode 100644 tests/data/acpi/riscv64/virt/CEDT.cxl
 create mode 100644 tests/data/acpi/riscv64/virt/DSDT.cxl

-- 
2.50.1

