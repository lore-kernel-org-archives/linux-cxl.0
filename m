Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC3279908
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969920; cv=none; b=oEARSNJu8KLLnnl0dybUPmph1TxTK8eTALVf7NmETF4+bEkzM2+gVOjW03x29s6W5lsNtKWOHuVSaqA3Y67Jr+QsHVp13DQcPtHWTgY3INVKNd2bdfoCqGSdWrH2TWg9/bsCxSKdZdMWKzlpHCNPYX0I/ka1I2IBg4mZ5nfUDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969920; c=relaxed/simple;
	bh=6BFowv9Sbc+Vk+p/VrzyBlWKyQeZRX143UEgZ7qP7Ck=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aHvs4kVSZzuOi6ZvuEfGbCAEy/GLIUR17MyxvmkVrQxUdwoYNoSI9dkMEOey7M9VpWvtLzo/Q/HUHxYUpqbbAL7JZl2yjY9E3S4iuo0QFf779G+LNLNKnSLc7kRmHLAOUGtTg5MdKQ6pkNpRqWkSvCyNl6An/WQGY1Xmoh6U2Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dnl1B3tC8zHnH4v;
	Fri,  9 Jan 2026 22:45:02 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C659740086;
	Fri,  9 Jan 2026 22:45:12 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 9 Jan 2026 14:45:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Davidlohr Bueso
	<dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH qemu v5 0/7] hw/cxl: Support Back-Invalidate (+ PCIe Flit mode)
Date: Fri, 9 Jan 2026 14:45:04 +0000
Message-ID: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

Lightly reworked version of Davidlohr's v4.
https://lore.kernel.org/qemu-devel/20251103195209.1319917-1-dave@stgolabs.net/

Whilst I have several other series posted for merge this applies fine
to upstream, so no dependencies.

Davidlohr, please check I didn't mess anthing up and perhaps give tags
for the 3 new patches.

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
 hw/cxl/cxl-component-utils.c              | 211 ++++++++++++++++------
 hw/mem/cxl_type3.c                        |  15 +-
 hw/pci-bridge/cxl_downstream.c            |  10 +-
 hw/pci-bridge/cxl_root_port.c             |  11 +-
 hw/pci-bridge/cxl_upstream.c              |  18 +-
 hw/pci-bridge/pci_expander_bridge.c       |   2 +-
 hw/pci/pcie.c                             |  23 ++-
 tests/data/acpi/x86/q35/CEDT.cxl          | Bin 184 -> 184 bytes
 15 files changed, 313 insertions(+), 97 deletions(-)

-- 
2.48.1

