Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A0625A350
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 21:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801160; cv=none; b=B9dzBHZ1lDgeGEblKb9zEUVRvduZq81UHbUJ0l44GVtTwBUF0gieICDvGN31ytqygw+mpGhsdLe1bHffOsvNCUrqvPpUTaNjhguzgN3ml9NoeL/AFd0Kkes0vb+oQZnGEVYEEDEtAcJeUfkW0RdDao9nEjCt+sDzrnkl/3j8yF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801160; c=relaxed/simple;
	bh=tcDkXkWNBBarf1qMEdiSEpkG1+nPhwQ91CNHm9N9ptc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RoGJa+F2Il5xKLhJHsH7MC3s0F+eONvisJ2ok98uytdfQ0KKZ448Z6YXI8GV93ZYMG+4KNZVfD+L/xbFE+PUl1lyZKfMqfrREXlpeZINfp3S8+pbSo8bOCBsxOfK+wqX8pQcKyCKt/awv76h6VEPZobj63cigmHbSUnmqnwFc/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCBDC4CEEF;
	Tue, 24 Jun 2025 21:39:20 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Gregory Price <gourry@gourry.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v4 0/9] cxl: Delay HB port and switch dport probing until endpoint dev probe
Date: Tue, 24 Jun 2025 14:39:07 -0700
Message-ID: <20250624213916.1665889-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4:
- Push dport allocation to when they are discovered. (Robert)
- Drop linux id for dport with above changes.

v3:
- Main changes revolve around improving naming of hostbridge uport and dport (Gregory)
- See specific patches for detailed change log

This series attempts to delay the allocation of dports until when the endpoint device
(memdev) are being probed. At this point, the CXL link is established and all the
devices along the CXL link path up to the Root Port (RP) should be active.

And hopefully this help a bit with Robert's issue raised in the "Inactive
downstream port handling" series [1]. Testing would be appreicated. Thank you!

[1]: https://lore.kernel.org/linux-cxl/67c8a0cc23ec_24b64294f6@dwillia2-xfh.jf.intel.com.notmuch/

Dave Jiang (9):
  cxl/region: Add decoder check to check_commit_order()
  cxl: Add helper to detect top of CXL device topology
  cxl: Add helper to reap dport
  cxl: Defer dport allocation for switch ports
  cxl/test: Add cxl_test support for new dport allocation scheme
  cxl/test: Add mock version of devm_cxl_add_dport_by_dev()
  cxl: Change sslbis handler to only handle single dport
  cxl: Create an xarray to tie a host bridge to the cxl_root
  cxl: Move enumeration of hostbridge ports to the memdev probe path

 drivers/cxl/acpi.c                   | 137 ++++++-----
 drivers/cxl/core/cdat.c              |  23 +-
 drivers/cxl/core/pci.c               |  89 ++++++++
 drivers/cxl/core/port.c              | 329 +++++++++++++++++++++++++--
 drivers/cxl/core/region.c            |   7 +-
 drivers/cxl/cxl.h                    |  32 ++-
 drivers/cxl/port.c                   |   8 +-
 tools/testing/cxl/Kbuild             |   2 +
 tools/testing/cxl/cxl_core_exports.c |  12 +
 tools/testing/cxl/exports.h          |  10 +
 tools/testing/cxl/test/cxl.c         | 119 ++++++++++
 tools/testing/cxl/test/mock.c        |  38 ++++
 tools/testing/cxl/test/mock.h        |   3 +
 13 files changed, 715 insertions(+), 94 deletions(-)
 create mode 100644 tools/testing/cxl/exports.h


base-commit: 86731a2a651e58953fc949573895f2fa6d456841
-- 
2.49.0

