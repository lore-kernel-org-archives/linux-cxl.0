Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460AF15CD7A
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jul 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926074; cv=none; b=svewVExZS+got0S2j475aRgVyvY7RW+1JiXECndhchdKe/0mi+jc0jPmxXnjjJD0WV27l/86iSmiOjoVoA+4LhWbp8Q+HFdx54HGw+8jOGAsbaxHIgb4eZ4uEqONX+1JtWReXGUAnVW/EpqsUf6UK4p4IModACCBJh45MVo/d6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926074; c=relaxed/simple;
	bh=0hDSlS3wtSkFbUxYBsiJg8g+dmvhGi0GWYmjia6gHV0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e4Q7/H7nBj1Kijsgyn1JxynZg2pGApRJhxHPd9G5VVysoYMUvmwkAj3zN7UkxxlWf0PS3ZtcuNtkHziPB0IsMav7P6N1SaaW3rvNGeDSQ69ThV0XiD8S477+unvJERGJ352bQEzRXn+C/1S0EcdqjXlBZhanzV1PuDvcTVRsKuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD3HB1SJqz6K9WM;
	Tue,  2 Jul 2024 21:12:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 72A20140AB8;
	Tue,  2 Jul 2024 21:14:29 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 14:14:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 00/13] acpi: NUMA nodes for CXL HB as GP + complex NUMA test
Date: Tue, 2 Jul 2024 14:14:05 +0100
Message-ID: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Title becoming a little misleading as now this does a bunch of other
stuff as precursors, but I've kept it to maintain association with v3 and
before. A more accurate series title is probably
acpi: Rework GI affinity structure generation, add GPs + complex NUMA test.

Based-on: [PATCH v4 00/16] Add support for RISC-V ACPI tests 
patches 2-16 (1 is upstream)  Note there is a test data error in there
for riscv but that shouldn't affect this series.

Chances since v3: Thanks to Igor for reviewing.
- Rename to busnr the property for getting the bus number.
- Make more use of acpi_uid property to reduce need for ACPI code
  to see PCI internals.  Note there is much more to do here for other
  properties but I'd rather do that as a follow up set to avoid even
  more creep in what this set is covering.
- Moves of test data due to basing on the above series.
- Drop accidentally included unused files.
- Misc minor fixes called out in individual patches.

ACPI 6.5 introduced Generic Port Affinity Structures to close a system
description gap that was a problem for CXL memory systems.
It defines an new SRAT Affinity structure (and hence allows creation of an
ACPI Proximity Node which can only be defined via an SRAT structure)
for the boundary between a discoverable fabric and a non discoverable
system interconnects etc.

The HMAT data on latency and bandwidth is combined with discoverable
information from the CXL bus (link speeds, lane counts) and CXL devices
(switch port to port characteristics and USP to memory, via CDAT tables
read from the device).  QEMU has supported the rest of the elements
of this chain for a while but now the kernel has caught up and we need
the missing element of Generic Ports (this code has been used extensively
in testing and debugging that kernel support, some resulting fixes
currently under review).

Generic Port Affinity Structures are very similar to the recently
added Generic Initiator Affinity Structures (GI) so this series
factors out and reuses much of that infrastructure for reuse
There are subtle differences (beyond the obvious structure ID change).

- The ACPI spec example (and linux kernel support) has a Generic
  Port not as associated with the CXL root port, but rather with
  the CXL Host bridge. As a result, an ACPI handle is used (rather
  than the PCI SBDF option for GIs). In QEMU the easiest way
  to get to this is to target the root bridge PCI Bus, and
  conveniently the root bridge bus number is used for the UID allowing
  us to construct an appropriate entry.

A key addition of this series is a complex NUMA topology example that
stretches the QEMU emulation code for GI, GP and nodes with just
CPUS, just memory, just hot pluggable memory, mixture of memory and CPUs.

A similar test showed up a few NUMA related bugs with fixes applied for
9.0 (note that one of these needs linux booted to identify that it
rejects the HMAT table and this test is a regression test for the
table generation only).

https://lore.kernel.org/qemu-devel/2eb6672cfdaea7dacd8e9bb0523887f13b9f85ce.1710282274.git.mst@redhat.com/
https://lore.kernel.org/qemu-devel/74e2845c5f95b0c139c79233ddb65bb17f2dd679.1710282274.git.mst@redhat.com/

Jonathan Cameron (13):
  hw/acpi: Fix ordering of BDF in Generic Initiator PCI Device Handle.
  hw/acpi/GI: Fix trivial parameter alignment issue.
  hw/acpi: Move AML building code for Generic Initiators to aml_build.c
  hw/acpi: Rename build_all_acpi_generic_initiators() to
    build_acpi_generic_initiator()
  hw/pci: Add a busnr property to pci_props and use for acpi/gi
  acpi/pci: Move Generic Initiator object handling into acpi/pci.*
  hw/pci-bridge: Add acpi_uid property to TYPE_PXB_BUS
  hw/i386/acpi: Use TYPE_PXB_BUS property acpi_uid for DSDT
  hw/pci-host/gpex-acpi: Use acpi_uid property.
  hw/acpi: Generic Port Affinity Structure support
  bios-tables-test: Allow for new acpihmat-generic-x test data.
  bios-tables-test: Add complex SRAT / HMAT test for GI GP
  bios-tables-test: Add data for complex numa test (GI, GP etc)

 qapi/qom.json                                 |  34 +++
 include/hw/acpi/acpi_generic_initiator.h      |  47 ----
 include/hw/acpi/aml-build.h                   |   8 +
 include/hw/acpi/pci.h                         |   7 +
 include/hw/pci/pci_bridge.h                   |   1 +
 hw/acpi/acpi_generic_initiator.c              | 148 ------------
 hw/acpi/aml-build.c                           |  84 +++++++
 hw/acpi/pci.c                                 | 226 ++++++++++++++++++
 hw/arm/virt-acpi-build.c                      |   3 +-
 hw/i386/acpi-build.c                          |  12 +-
 hw/pci-bridge/pci_expander_bridge.c           |  12 +-
 hw/pci-host/gpex-acpi.c                       |   7 +-
 hw/pci/pci.c                                  |  14 ++
 tests/qtest/bios-tables-test.c                |  97 ++++++++
 hw/acpi/meson.build                           |   1 -
 .../data/acpi/x86/q35/APIC.acpihmat-generic-x | Bin 0 -> 136 bytes
 .../data/acpi/x86/q35/CEDT.acpihmat-generic-x | Bin 0 -> 68 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 0 -> 10849 bytes
 .../data/acpi/x86/q35/HMAT.acpihmat-generic-x | Bin 0 -> 360 bytes
 .../data/acpi/x86/q35/SRAT.acpihmat-generic-x | Bin 0 -> 520 bytes
 20 files changed, 495 insertions(+), 206 deletions(-)
 delete mode 100644 include/hw/acpi/acpi_generic_initiator.h
 delete mode 100644 hw/acpi/acpi_generic_initiator.c
 create mode 100644 tests/data/acpi/x86/q35/APIC.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x

-- 
2.43.0

