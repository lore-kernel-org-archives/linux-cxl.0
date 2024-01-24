Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3BF77642
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100065; cv=none; b=jqK3oycn0F4Dj0aqZMvAP3klFY1GzoNYY4bN1zF6WVTcD10OzAAHsjgz3CkKpduyguiijHDoP0pcQlhWcruiO1Di6HvM3QMFWCLVo2m5XXEYSJ44OiFXiGriDiL6SsY//0rK0BwHMxRcncOtOaVeURSTu4xsWoqmI2tLQDb9MoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100065; c=relaxed/simple;
	bh=H5oErUHZ5SiP1l9E9+V+eP8jREYKlvUkXKfv9gojRaY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MQ4m/2SHIBNi1erlpiZ+E1srS5YgeGaD0tAKWnizaRewHu5zSGGCaJsq6RQkIrS3v5FKmDv/g0e32SZHolumvOhekQk+pc2Olr5w8icXxcxQu7VrgBPL755ns4nIiasSRRDzYrB9bPfI5Hs+Tzp7J35qYHUDPwWWnrzf7VA9JDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKk5Y2j2cz6K6F8;
	Wed, 24 Jan 2024 20:38:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BCED140390;
	Wed, 24 Jan 2024 20:40:59 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 12:40:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Ira Weiny <ira.weiny@intel.com>, Huai-Cheng Kuo
	<hchkuo@avery-design.com.tw>, Dave Jiang <dave.jiang@intel.com>, Peter
 Maydell <peter.maydell@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>,
	Stefan Hajnoczi <stefanha@gmail.com>, <linuxarm@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/12 qemu] CXL emulation fixes and minor cleanup.
Date: Wed, 24 Jan 2024 12:40:48 +0000
Message-ID: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

This set includes the majority of fixes I currently have queued
up for the CXL emulation. Most have been posted and reviewed
before so this is just rebases of those.

I've included the _STA fix as that's fairly trivial
and didn't seem worth a separate posting. Also included
dropping some pointless g_malloc0() failure handling that
came up in review of Ira's "cxl/cdat: Handle cdat table build errors".

Note the [... qemu] marking above is because we currently use the
linux-cxl@vger.kernel.org list to ensure CXL people notice the
patches and difficulty of distinguishing QEMU vs Kernel patches
was causing some grief for tracking in patchwork.
Hopefully this is unobtrusive enough to not annoy QEMU reviewers!

Davidlohr Bueso (1):
  hw/cxl/mbox: Remove dead code

Hyeonggon Yoo (1):
  hw/cxl/device: read from register values in mdev_reg_read()

Ira Weiny (2):
  cxl/cdat: Handle cdat table build errors
  cxl/cdat: Fix header sum value in CDAT checksum

Jonathan Cameron (6):
  hw/mem/cxl_type3: Drop handling of failure of g_malloc0()
  hw/pci-bridge/cxl_upstream: Drop g_malloc0() failure handling
  hw/mem/cxl_type3: Fix potential divide by zero reported by coverity
  tests/acpi: Allow update of DSDT.cxl
  hw/i386: Fix _STA return value for ACPI0017
  tests/acpi: Update DSDT.cxl to reflect change _STA return value.

Li Zhijian (2):
  hw/cxl: Pass CXLComponentState to cache_mem_ops
  hw/cxl: Pass NULL for a NULL MemoryRegionOps

 include/hw/cxl/cxl_device.h  |   9 ++++--
 hw/cxl/cxl-cdat.c            |  11 +++++--
 hw/cxl/cxl-component-utils.c |   4 +--
 hw/cxl/cxl-device-utils.c    |  17 ++++++----
 hw/cxl/cxl-mailbox-utils.c   |  43 +++++++++----------------
 hw/i386/acpi-build.c         |   2 +-
 hw/mem/cxl_type3.c           |  60 ++++++++---------------------------
 hw/pci-bridge/cxl_upstream.c |   6 ----
 tests/data/acpi/q35/DSDT.cxl | Bin 9713 -> 9714 bytes
 9 files changed, 57 insertions(+), 95 deletions(-)

-- 
2.39.2

