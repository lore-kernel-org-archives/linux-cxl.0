Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2833139D17
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140178; cv=none; b=VpFo7RwnSQcpHHPBUQ2bAwxILlXvtu4fuzkDcyUwaeVmnT7FOuCnIaQyB03yVnDG6oqr8dclYEvgsix7tAmgPxUFCzjGdn2clxBDzIHEMwDc9gJN+SMl5/Jk1FIJMDRMNU+O9X6SMi42LVjGYbC7hC1Gf3m3rNFhr+0dxPJ/Kvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140178; c=relaxed/simple;
	bh=UbBLbMyGR3Neuw1uiLQIYOpjYmFeu2Yy1sNPIjtvg+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hK9KXQvrPIO9dBfLXZiRfmdOs9cSoQV8yYYNS8alpvGDb9jf1r6/hOmU0zNe+m5Yrh0duUvs2WkFr9aIR1LfNR9VVFWNZhR0PaSBz3xZD2qFVc0vs2vd7airT4A6sgsHn4rcPj60wNra4yLZ3YR0qH+9aC6UGR1bsrM5dFjKESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8gtw5ZxKz6HJMk;
	Wed,  3 Apr 2024 18:28:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C0902140516;
	Wed,  3 Apr 2024 18:29:27 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 11:29:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>,
	<mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>,
	<imammedo@redhat.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
	Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
	Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 0/6 qemu] acpi: NUMA nodes for CXL HB as GP + complex NUMA test.
Date: Wed, 3 Apr 2024 11:29:21 +0100
Message-ID: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
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

Jonathan Cameron (6):
  hw/acpi/GI: Fix trivial parameter alignment issue.
  hw/acpi: Insert an acpi-generic-node base under acpi-generic-initiator
  hw/acpi: Generic Port Affinity Structure support
  bios-tables-test: Allow for new acpihmat-generic-x test data.
  bios-tables-test: Add complex SRAT / HMAT test for GI GP
  bios-tables-test: Add data for complex numa test (GI, GP etc)

 qapi/qom.json                               |  18 ++
 include/hw/acpi/acpi_generic_initiator.h    |  33 +++-
 include/hw/pci/pci_bridge.h                 |   1 +
 hw/acpi/acpi_generic_initiator.c            | 199 ++++++++++++++------
 hw/pci-bridge/pci_expander_bridge.c         |   1 -
 tests/qtest/bios-tables-test.c              |  92 +++++++++
 tests/data/acpi/q35/APIC.acpihmat-generic-x | Bin 0 -> 136 bytes
 tests/data/acpi/q35/CEDT.acpihmat-generic-x | Bin 0 -> 68 bytes
 tests/data/acpi/q35/DSDT.acpihmat-generic-x | Bin 0 -> 10400 bytes
 tests/data/acpi/q35/HMAT.acpihmat-generic-x | Bin 0 -> 360 bytes
 tests/data/acpi/q35/SRAT.acpihmat-generic-x | Bin 0 -> 520 bytes
 11 files changed, 285 insertions(+), 59 deletions(-)
 create mode 100644 tests/data/acpi/q35/APIC.acpihmat-generic-x
 create mode 100644 tests/data/acpi/q35/CEDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/q35/DSDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/q35/HMAT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/q35/SRAT.acpihmat-generic-x

-- 
2.39.2

