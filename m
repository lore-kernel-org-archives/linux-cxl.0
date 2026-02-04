Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC8017C69
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224981; cv=none; b=rZj1TGGqT2umKCK6Zmshygx1hiruDBVmUrceeDjBfHcRXqlpvPlBkaDUSlDsZR3mYE0mOY6xs6am4GAMG3hQTllnfnBxk1UwVdQzo7OaU62Vo9YKM9eg5kM3YgHM7MqSwgGbzsyollX225/f/c2QuCMbq4kEwrgnPkJfGkuKi6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224981; c=relaxed/simple;
	bh=10wALbWvGe7u37Wcx8KIjS9KjFRwAxQQS153wO2LbDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tpxka3epUeqq0L8JUnmjZqutzOil1+61T39FA0DhiK7el0KxcWrmc5W3yh1vbwes3mIIxrJb5fvT93EwqIfwmJgVz9GMGjFyK5cV7/tiChZJm3ASco8L7gTP9eqdSiglTlx8Bjrw6gA6FxMpR0e9P/qddnaEdm/aQ4fmxXgC12I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5mz417blzJ46F6;
	Thu,  5 Feb 2026 01:08:48 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 789DB40569;
	Thu,  5 Feb 2026 01:09:37 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 17:09:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Davidlohr Bueso
	<dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH qemu v7 0/7] hw/cxl: Support Back-Invalidate (+ PCIe Flit mode)
Date: Wed, 4 Feb 2026 17:09:28 +0000
Message-ID: <20260204170936.43959-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

Based on - due to fuzz + context changes.

1. [PATCH qemu v4 0/5] cxl: r3.2 specification event updates.
https://lore.kernel.org/qemu-devel/20260119111542.788389-1-Jonathan.Cameron@huawei.com/

2. [PATCH qemu for 10.2 0/3] cxl: Additional RAS features support.
https://lore.kernel.org/qemu-devel/20250917143330.294698-1-Jonathan.Cameron@huawei.com/

3. [PATCH qemu 0/2] hw/cxl: Two media operations related fixes.
https://lore.kernel.org/qemu-devel/20260102154731.474859-1-Jonathan.Cameron@huawei.com/
(most likely will apply fine with out this one)

v7:
- Add scope via {} for switch statement in patch 7. That avoids build problems with
  clang (pre c23) where a _Static_assert() may not immediately follow a label.
  (Michael, gitlab build issues)

v6:
- Initialize a variable that causing a false warning with some versions of gcc.
- Rebase.
- Tag from Davidlohr for the ACPI change.

v5 changes:
- Rebase much earlier in the CXL queue as Davidlohr had it beind some stuff
  I was carrying that is not ready for upstream just yet.
- Update the CFMWS flags directly as the patch doing restriction control needs
  some more thought.
- Bios tables test data updates.
- Don't provide flit mode control for gen_pcie_root_port as we don't need it
  for the rest of the series which is all about CXL.

The following allows support for component basic back invalidation discovery
and config, by exposing the BI routing table and decoder registers. Instead
of going the type2[0] route, this series proposes adding support for type3
hdm-db, which allows a more direct way of supporting BI in qemu.

As BI is a dependent on the larger flits introduced in PCIe (and CXL 3.0)
add support for enabling that for CXL components. Negotiation is handled
via an equivalent of what we do for link speed.

Davidlohr Bueso (3):
  hw/pcie: Support enabling flit mode
  hw/cxl: Support type3 HDM-DB
  hw/cxl: Remove register special_ops->read()

Ira Weiny (1):
  hw/cxl: Refactor component register initialization

Jonathan Cameron (3):
  tests/bios-tables-test: Excluded CEDT.cxl for BI restriction
    relaxation.
  hw/cxl: Update CXL Fixed Memory Window ACPI description to include
    Back Invalidate support.
  tests/acpi/cxl: Update CEDT.cxl to allow BI in CFWMS

 docs/system/devices/cxl.rst               |  23 +++
 include/hw/cxl/cxl_component.h            |  87 +++++++--
 include/hw/cxl/cxl_device.h               |   4 +
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 include/hw/pci/pcie.h                     |   2 +-
 include/hw/pci/pcie_port.h                |   1 +
 hw/acpi/cxl.c                             |   2 +-
 hw/cxl/cxl-component-utils.c              | 214 ++++++++++++++++------
 hw/mem/cxl_type3.c                        |  15 +-
 hw/pci-bridge/cxl_downstream.c            |  10 +-
 hw/pci-bridge/cxl_root_port.c             |  11 +-
 hw/pci-bridge/cxl_upstream.c              |  18 +-
 hw/pci-bridge/pci_expander_bridge.c       |   2 +-
 hw/pci/pcie.c                             |  23 ++-
 tests/data/acpi/x86/q35/CEDT.cxl          | Bin 184 -> 184 bytes
 15 files changed, 315 insertions(+), 98 deletions(-)

-- 
2.51.0

