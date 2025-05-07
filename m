Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D7015E8B
	for <linux-cxl@vger.kernel.org>; Wed,  7 May 2025 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746578592; cv=none; b=nbtw29au/fpyKfytyfZ8hNs4tccWsWk21d9490QGsp8KPxZTrES180GnLVJ0q/X7Yoq9gVk8ZkgTrJe3vLZHUZ2TaXb9qyu7xB9K3XF5+Sjm+SFWakdRU80zsGFIDX31TAOuGiaVaYC64F7ZylFrFFoa5NRgWJLo4GwqreSesCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746578592; c=relaxed/simple;
	bh=HBe8TrwN6j22HYRHwiEHkwVfmkXEXVEAvWYj4y0aw20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHPMCh+X8TPf7BX5j4LIV+/qCUYBgMcDA/VSe/+If15rKg3zXFMVxzm2kaH+0gEAgo3ZLKCKOtUWjeJpTpOuForKIafKcLr8g40p15nshSxGxNUXt8XQ4dinZBxhC/acm7/HgByhYfQsGKZ+PVgKIc0foyuop5xaSNqvg53oiMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEB7C4CEE4;
	Wed,  7 May 2025 00:43:11 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com
Subject: [PATCH v2 00/10] cxl: Delay HB port and switch dport probing until endpoint dev probe
Date: Tue,  6 May 2025 17:43:00 -0700
Message-ID: <20250507004310.3536991-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series attempts to delay the setup of dports and Host Bridge (HB) register
until when the endpoint device (memdev) is being probed. At this point,
the CXL link is established and all the devices along the CXL link path up to
the Root Port (RP) should be active.

And hopefully this help a bit with Robert's issue raised in the "Inactive
downstream port handling" series [1]. Testing would be appreicated. Thank you!

[1]: https://lore.kernel.org/linux-cxl/67c8a0cc23ec_24b64294f6@dwillia2-xfh.jf.intel.com.notmuch/

Dave Jiang (10):
  cxl/region: Add decoder check to check_commit_order()
  cxl: Saperate out CXL dport->id vs actual dport hardware id
  cxl: Rename find_dport() to provide better function intent
  cxl: Remove adding of port_num via devm_cxl_add_dport()
  cxl: Defer hardware dport->port_id assignment and registers probing
  cxl/test: Add workaround for cxl_test for cxl_core calling mocked functions
  cxl: Change sslbis handler to only handle single dport
  cxl: Add helper to detect top of CXL device topology
  cxl: Create an xarray to tie a host bridge to the cxl_root
  cxl: Move enumeration of hostbridge ports to the memdev probe path

 drivers/cxl/acpi.c                   | 143 ++++++-----
 drivers/cxl/core/cdat.c              |  23 +-
 drivers/cxl/core/core.h              |   4 +
 drivers/cxl/core/hdm.c               |  45 ++--
 drivers/cxl/core/pci.c               |  60 ++++-
 drivers/cxl/core/port.c              | 353 +++++++++++++++++++++++----
 drivers/cxl/core/region.c            |   7 +-
 drivers/cxl/cxl.h                    |  50 +++-
 drivers/cxl/port.c                   |  20 +-
 tools/testing/cxl/Kbuild             |   4 +-
 tools/testing/cxl/cxl_core_exports.c |  31 +++
 tools/testing/cxl/exports.h          |  17 ++
 tools/testing/cxl/test/cxl.c         |   5 +-
 tools/testing/cxl/test/mock.c        |  40 +--
 14 files changed, 611 insertions(+), 191 deletions(-)
 create mode 100644 tools/testing/cxl/exports.h


base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
-- 
2.49.0

