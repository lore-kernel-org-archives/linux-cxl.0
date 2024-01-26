Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E388217BCC
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270495; cv=none; b=OUFBwPDKm38Dcm+/4yC2nao7vU9bLxJrbYfINGwOWYJrrphi04g1rJ3a4nr4Z6HCz6juQqP9+vGXfJ/sxN3M49CAV7oQJM6yrsPGA0BHmW1BMI7iMXZn9nC1JJbzCyv5j+d6CaOV7h/vdiQRoUq4u5wk6rigHysYxecDfWgxR28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270495; c=relaxed/simple;
	bh=5Jh5PkCYcrDeHCfwtbAWOnbgk+UfeODy+PGX0MfykE8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q2l2Q0aUzoSBET5muHqzXnVvXBQYb4Kzc7IyUrYayqPu42T4S4syMFQVpyliGifJzP1s02A6WMjpMRIlmIxQbvNOxjDbSpkmEgpphL2gRGK54kHp084XhdkqQhD4UwmsNEZ+xBQKwfuKFNmH3vetEqmR4bA4NtkC7d56wI4nyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TLx6b0fW6z6K9M9;
	Fri, 26 Jan 2024 19:58:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E4B8140CF4;
	Fri, 26 Jan 2024 20:01:30 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 12:01:30 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<peter.maydell@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon
 Yoo <42.hyeyoo@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, Stefan
 Hajnoczi <stefanha@gmail.com>, <linuxarm@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/12 qemu] CXL emulation fixes and minor cleanup.
Date: Fri, 26 Jan 2024 12:01:20 +0000
Message-ID: <20240126120132.24248-1-Jonathan.Cameron@huawei.com>
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

v2:
 - Patch description fixes to correctly refer to g_malloc() either
   with or instead of g_malloc0() depending on the patch.
 - Add missing brackets for QEMU style as reported by checkpatch.
 - Gathered some tags from Fan (thanks!)

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
  hw/mem/cxl_type3: Drop handling of failure of g_malloc0() and
    g_malloc()
  hw/pci-bridge/cxl_upstream: Drop g_malloc() failure handling
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
 hw/cxl/cxl-mailbox-utils.c   |  43 +++++++++---------------
 hw/i386/acpi-build.c         |   2 +-
 hw/mem/cxl_type3.c           |  61 ++++++++---------------------------
 hw/pci-bridge/cxl_upstream.c |   6 ----
 tests/data/acpi/q35/DSDT.cxl | Bin 9713 -> 9714 bytes
 9 files changed, 58 insertions(+), 95 deletions(-)

-- 
2.39.2

