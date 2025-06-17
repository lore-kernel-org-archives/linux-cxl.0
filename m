Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333BA186E2E
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 04:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750133249; cv=none; b=ueNZ7iY0o+isukdAWkdmG7N5ZeTiQvEHlxtiOh/oEnEzm0F/F0cnHoF/1Zzu81bJaVoLIO83E6Wpu5+6ANvViRAzQT8eu0B/zkSxO71By2Y7FcQv9LiIq1FQbdfqtuiLo/jr+/l6wQrny3SGF5Mz4pM+V5egeYDeBdm9kZNlNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750133249; c=relaxed/simple;
	bh=TuPZN3mRxTbxbh2HZuW17SDVZPU4qvOmrJG76WTD6+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T037qeWD3h9ll8+bngAWmjeQe0QewjoVomC4dhGYWVlbb2f4XN+jecx5AuNcLgwoQYRrH6+KA4nHbSuAUn+sL0muUdMzxca0MgyjmnmtvJWBr0Jnqh9EpzbFeo4Lb6nlMHHQ5eVka4qNJZlklZCahnaDdeiMsCIkrXjZZvfQ6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXnLjy6VBo1+brAg--.11501S2;
	Tue, 17 Jun 2025 12:07:14 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwAHmiPr6VBo5wZWAA--.5570S3;
	Tue, 17 Jun 2025 12:07:07 +0800 (CST)
From: wangyuquan <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	wangyuquan <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH v3 0/2] cxl: Support creation of a new CXL Host Bridge
Date: Tue, 17 Jun 2025 12:06:47 +0800
Message-Id: <20250617040649.81303-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAHmiPr6VBo5wZWAA--.5570S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQADAWhPIu4E8QAXsK
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zw1Uuw18XFW7GFy5Cry7GFg_yoW8uw4Upa
	n8KrWfCr4DKry3tw4fA3y7WF1rJrZ5Way5uF4xWw10yry2vF4DZrs7CayYvFyUCFWUAw1r
	J3WxAw1kW3WUXa7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

v2 -> v3:
- Update the commit message
- Fix some alignment and space problems
- Add a SPDX header for the new file
- Remove unnecessary comments
- Add CXL_HOST_BRIDGE config
v1 -> v2:
- Move the code of new bridge to hw/pci-host/cxl.c
- Fix and simplify some logic on handling the different bridge types

Background
==========
Currently the base CXL support for arm platforms is only on Jonathan's
patches[1]. Some platform like SBSA-REF can be more like a real machine,
thus the support of CXL could be meaningful. However, the pxb-cxl-host
realization on this platform seems not satisfying their requirements[2].

New CXL HOST design
===================
Defines a new CXL host bridge type (TYPE_CXL_HOST). This is an
independent CXL host bridge which combined GPEX features (ECAM, MMIO
windows and irq) and CXL Host Bridge Component Registers (CHBCR).

The root bus path of CXL_HOST is "0001:00", that would not affect the
original pcie host topology. In the previous, the pxb-cxl-host with
any CXL root ports and CXL endpoint devices would occupy the BDF
number of the original pcie domain. This new type provide a solution
to resolve the problem.

Remaining problems
==================
I tried to use 'object_resolve_path' but it could not work in
'cxl_fmws_link_targets', so I used 'TYPE_DEVICE' to match that.

Link:
[1]: https://lore.kernel.org/linux-cxl/20220616141950.23374-1-Jonathan.Cameron@huawei.com/
[2]: https://lists.nongnu.org/archive/html/qemu-arm/2024-11/msg00522.html

Yuquan Wang (2):
  pci-host/cxl: Support creation of a new CXL Host Bridge
  hw/pxb-cxl: Rename the pxb cxl host bridge

 hw/cxl/cxl-host-stubs.c               |   3 +
 hw/cxl/cxl-host.c                     |  64 ++++++++---
 hw/pci-bridge/pci_expander_bridge.c   |   8 +-
 hw/pci-host/Kconfig                   |   4 +
 hw/pci-host/cxl.c                     | 152 ++++++++++++++++++++++++++
 hw/pci-host/meson.build               |   1 +
 include/hw/cxl/cxl.h                  |   7 +-
 include/hw/cxl/cxl_host.h             |   3 +
 include/hw/pci-host/cxl_host_bridge.h |  23 ++++
 9 files changed, 244 insertions(+), 21 deletions(-)
 create mode 100644 hw/pci-host/cxl.c
 create mode 100644 include/hw/pci-host/cxl_host_bridge.h

-- 
2.34.1

