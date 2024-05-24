Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2DB85631
	for <linux-cxl@vger.kernel.org>; Fri, 24 May 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545115; cv=none; b=sQRmfTVAPgXGe5gAO5vP+J8Mmpks3K0AXGEbueEe+HhDmsA9p9+N/I4yI/Qa1BEZ3kQLohjT9r3ggHJDmaz0ubKpaWwI58btMTqMb7Rm4r9qa7V+6+MjUbC4fE9Dpm6jxNhFNthD/fNA2FkaySyzHg01NUzplwJal7H1na8yRxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545115; c=relaxed/simple;
	bh=l3HxCmjUTCVgjWGmkd1wWCMrQZ5mSYF1OszHNvGSflA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IoTVJ/z6PJsot22QBmLXImsWXW7EY1SHDEsOWkhjQqnVrKs1ztPOnZdjKYRqosxxKZgW5DlceREXuq80ZHb2VKHwjs7Gcagd/NoKlmsWjvt0XLBaCqRi9cnfS8kaEqEPHeUJZ0sZn8wdAPC51njE372ljUuszC21/b74VtMnP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vm0tW5h79z6JBVy;
	Fri, 24 May 2024 18:01:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A274140B54;
	Fri, 24 May 2024 18:05:08 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 11:05:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
	<philmd@linaro.org>
CC: Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>,
	<imammedo@redhat.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
	Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 qemu 0/6] acpi: NUMA nodes for CXL HB as GP + complex NUMA test.
Date: Fri, 24 May 2024 11:05:01 +0100
Message-ID: <20240524100507.32106-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

v2: Improve (mostly add detail) the qmp documentatation (thanks Markus!)

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

 qapi/qom.json                               |  35 ++++
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
 11 files changed, 302 insertions(+), 59 deletions(-)
 create mode 100644 tests/data/acpi/q35/APIC.acpihmat-generic-x
 create mode 100644 tests/data/acpi/q35/CEDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/q35/DSDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/q35/HMAT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/q35/SRAT.acpihmat-generic-x

-- 
2.39.2

