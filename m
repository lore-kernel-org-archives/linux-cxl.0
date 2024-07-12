Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C5433C7
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jul 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782530; cv=none; b=a4zh6JOX4gzJ9lgklxQ/uGeyoIe9pj3vyK95ghcMbz45qKeSr7DLwyrDalRANxyNmxxmES5rsw/IJP7E0gxdWZgXCOrJ6lvyAM6egu5GG0OqhAigIgpvLFrn0/4pIUH2xbozmBQDCZnMGlvW9zqasVtL0qs3wEzc+wYOY2hEj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782530; c=relaxed/simple;
	bh=EDI6c/o1fna0BUqHUgCtX2uMNuZYSl17OdRttDkaicw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y1xgGJeT6NvB89fetCs/XzMlkDQLPO5yM03n9ycBFMQsvBfQjVWVu5T5iy4pXPbggMXobEdg087jhsHc8JxkKNqTUTYHznu97mY6Sro3Cs4vXBmt4S3jbvWJWV3+Xfy55+xcMUptoxXzldmkCUxQKdmsSK85xn/804M4tVTWIGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL82G0nWdz6JB3x;
	Fri, 12 Jul 2024 19:07:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 129981400D9;
	Fri, 12 Jul 2024 19:08:38 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 12:08:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: [PATCH v5 00/13] acpi: NUMA nodes for CXL HB as GP + complex NUMA test
Date: Fri, 12 Jul 2024 12:08:04 +0100
Message-ID: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

v5: Thanks to Igor for review.
 Patch 5:
 - Add an assert to catch out of range PCI devfn retrieved from addr property
   which is oddly an int32_t
 Patch 6:
 - Push TYPE_ACPI_GENERIC_INTIATOR define down into c file along with
   qom_interfaces.h include as they are only needed there.
 Patch 7:
 - Add missing object class property description.
 Patch 8/9:
 - Use busnr for naming of of ACPI nodes so as to avoid having to
   check if the uid is small enough (it is as they have the same value
   but nice not to have to check!)
 Patch 10:
 - Push TYPE_ACPI_GENERIC_PORT definition down into c file (similar
   to patch 6 change.
   
Title becoming a little misleading as now this does a bunch of other
stuff as precursors, but I've kept it to maintain association with v3 and
before. A more accurate series title is probably
acpi: Rework GI affinity structure generation, add GPs + complex NUMA test.

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
 include/hw/acpi/pci.h                         |   3 +
 include/hw/pci/pci_bridge.h                   |   1 +
 hw/acpi/acpi_generic_initiator.c              | 148 -----------
 hw/acpi/aml-build.c                           |  84 +++++++
 hw/acpi/pci.c                                 | 234 ++++++++++++++++++
 hw/arm/virt-acpi-build.c                      |   3 +-
 hw/i386/acpi-build.c                          |   8 +-
 hw/pci-bridge/pci_expander_bridge.c           |  14 +-
 hw/pci-host/gpex-acpi.c                       |   5 +-
 hw/pci/pci.c                                  |  14 ++
 tests/qtest/bios-tables-test.c                |  97 ++++++++
 hw/acpi/meson.build                           |   1 -
 .../data/acpi/x86/q35/APIC.acpihmat-generic-x | Bin 0 -> 136 bytes
 .../data/acpi/x86/q35/CEDT.acpihmat-generic-x | Bin 0 -> 68 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 0 -> 10849 bytes
 .../data/acpi/x86/q35/HMAT.acpihmat-generic-x | Bin 0 -> 360 bytes
 .../data/acpi/x86/q35/SRAT.acpihmat-generic-x | Bin 0 -> 520 bytes
 20 files changed, 498 insertions(+), 203 deletions(-)
 delete mode 100644 include/hw/acpi/acpi_generic_initiator.h
 delete mode 100644 hw/acpi/acpi_generic_initiator.c
 create mode 100644 tests/data/acpi/x86/q35/APIC.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x

-- 
2.43.0

