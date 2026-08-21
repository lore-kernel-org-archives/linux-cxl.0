Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07EF42F707
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787300408; cv=none; b=JFn0MwUlwzdyvq9BO3UVmi71aG72RWKb0JWXEMksaC77mgDlFgw5oms+TtCvIeBGcOGB6uMW1Y6cMXWnuU8X4QaMWLRhNMgcFc9cXkm8/BZu3gShLH/g1adALU6QUHJ2E11o5lh+jn5p0H2MvQIJZnrBfp/saJ9RmZqfWZr5Y4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787300408; c=relaxed/simple;
	bh=rgqYeKG6qDFzJysHF3LvHx7T5Dw2zrb0q7x/+9Vt53c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E/A621XcQisrHgfFQOnQgP7wFVar1SQq06QgedoHcU8XWgHY9lfriIbbt+cs9t6SjfsWWk8C39kkjIHdpei4N/I/SBkwGUvMQ1BH7kGl0vFcNLXatfWRGAKSkDWnIJCyffQ1zNvZHR5YwEsV3YK55w+if0cQ7SxV2BAiJi42nso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HbDFBAJs; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HbDFBAJs"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787300403; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=JOHSi15pOqvQZ9pIgZNI4quDEW61C01YE1WLujwvVNE=;
	b=HbDFBAJsdvjQgab2EcUd0g1a3HOaYgfqSwFPDUeGZTA2aCA9iECV8eNXyiQJPOzgu0A+9mryv1KpfI8afAgpXHpSQ3ruE6U0ylNUQvS4HwJwTdQpeEwwf98jnYsyCGKWanDXMJMdpczdrQGX/o2chzb7r0bTcwGW8Vu8Njg2S8M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X9LmLrc_1787300396;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9LmLrc_1787300396 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Aug 2026 16:20:01 +0800
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
Subject: [PATCH 0/4] hw/riscv/virt: Add CXL support to the RISC-V virt machine
Date: Fri, 21 Aug 2026 16:19:50 +0800
Message-ID: <20260821081954.1171-1-cp0613@linux.alibaba.com>
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
DSDT, and a CEDT table is built.  A bios-tables test is added to pin down
the generated ACPI tables.

Prerequisite
------------
The v2 posting depended on Alireza Sanaee's v8 series [1] (the
performant non-interleaved CFMW lookup path).  That series has since
been merged upstream, so this version has no outstanding prerequisite
and applies directly on current upstream master.

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
    which is now merged upstream and thus no longer a prerequisite.
  - New patch 4: RISC-V ACPI bios-tables test for CXL, with golden AML
    files generated and included.

[1] https://lore.kernel.org/qemu-devel/20260318171918.146-1-alireza.sanaee@huawei.com/

Test
----
Built riscv64-softmmu and ran the new bios-tables test together with the
existing riscv64 ACPI tests; all pass.  Also booted an RVA22 kernel with
pxb-cxl + cxl-rp + cxl-type3 + a CFMW: the root port and Type3 device
enumerate (0000:0c:00.0 / 0000:0d:00.0) and 'cxl list' reports the
memdev (4 GiB) and the CFMWS root decoder.

QEMU invocation (CXL-relevant options shown):

    qemu-system-riscv64 \
        -M virt,aia=aplic-imsic,acpi=on,cxl=on \
        -cpu rv64 -smp 2 -m 4G,maxmem=8G,slots=8 \
        -object memory-backend-ram,id=vmem0,share=on,size=4G \
        -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
        -device cxl-rp,port=0,bus=cxl.1,id=rp0,chassis=0,slot=2 \
        -device cxl-type3,bus=rp0,volatile-memdev=vmem0,id=cxl-vmem0 \
        -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
        ...

Verification (total system memory grows by 4 GiB after onlining):

    # cxl list
    # cxl enable-memdev mem0
    # cxl create-region -m -t ram -d decoder0.0 -w 1 mem0 -s 4G
    # daxctl online-memory dax0.0
    # free -h

Chen Pei (4):
  hw/riscv/virt: Add CXL support to the RISC-V virt machine
  hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for CXL host bridge
    dependency
  hw/riscv/virt: Provide a 32-bit MMIO window for CXL host bridges
  tests/qtest: Add RISC-V ACPI bios tables test for CXL

 hw/riscv/Kconfig                      |   2 +
 hw/riscv/virt-acpi-build.c            |  52 +++++++
 hw/riscv/virt.c                       | 191 +++++++++++++++++++++++++-
 include/hw/riscv/virt.h               |   3 +
 tests/data/acpi/riscv64/virt/CEDT.cxl | Bin 0 -> 108 bytes
 tests/data/acpi/riscv64/virt/DSDT.cxl | Bin 0 -> 6212 bytes
 tests/qtest/bios-tables-test.c        |  54 ++++++++
 7 files changed, 301 insertions(+), 1 deletion(-)
 create mode 100644 tests/data/acpi/riscv64/virt/CEDT.cxl
 create mode 100644 tests/data/acpi/riscv64/virt/DSDT.cxl

-- 
2.50.1

