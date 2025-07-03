Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6702BEC27
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 23:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751585239; cv=none; b=jhleJcBuzJCFRRGMMplTELDjB6o74zwSQZmAKIUp4Spr40450P0rcxfbAqsLHTEdnx3EP5KQ8I3FoaGIZ/m9qveMgpsOMgLsxZ7BrIxfhVgM6x/g+7SYe34BaE7240HCQhmt8tvuE+QZQ03hIvYZIayqvumGe0ywZOMkQ+q49U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751585239; c=relaxed/simple;
	bh=+sKapPRbJZEY2fF1jJLd4xtm3KKKeSM6XoOMXnV8OgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tI5srGQ6pfiS5xBEPUr/UWi056ch9K8V4Ismj91SX3K84uw5qxzDoxBbTHSZDnvZQk2dP7s+rkzY8dn8tTlE/jOmp8nSGVZpp5kdejR+tIHUh5tEVpVXrTC1lTfXTvG7EzH6K0oDF3OmlBaVQ/Q4dKC3Jkr/1Xoc50mtSR1d0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0F3C4CEE3;
	Thu,  3 Jul 2025 23:27:16 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Gregory Price <gourry@gourry.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v5 00/10] cxl: Delay HB port and switch dport probing until endpoint dev probe
Date: Thu,  3 Jul 2025 16:27:00 -0700
Message-ID: <20250703232710.3141436-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5:
- Return dport instead of errno with dport pointer as output param. (Jonathan)
- Consolidate common code in cxl_test. (Jonathan)
- Rename cxl_port_get_total_dports() to cxl_port_update_total_dports(). (Jonathan)

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

Dave Jiang (10):
  cxl/region: Add decoder check to check_commit_order()
  cxl: Add helper to detect top of CXL device topology
  cxl: Add helper to reap dport
  cxl: Defer dport allocation for switch ports
  cxl/test: Add cxl_test support for cxl_port_update_total_ports()
  cxl/test: Add mock version of devm_cxl_add_dport_by_dev()
  cxl: Change sslbis handler to only handle single dport
  cxl: Create an xarray to tie a host bridge to the cxl_root
  cxl: Move enumeration of hostbridge ports to the memdev probe path
  cxl: Remove devm_cxl_port_enumerate_dports() that is no longer used

 drivers/cxl/acpi.c                   | 137 ++++++-----
 drivers/cxl/core/cdat.c              |  23 +-
 drivers/cxl/core/pci.c               | 146 +++++++-----
 drivers/cxl/core/port.c              | 344 +++++++++++++++++++++++++--
 drivers/cxl/core/region.c            |   7 +-
 drivers/cxl/cxl.h                    |  32 ++-
 drivers/cxl/cxlpci.h                 |   1 -
 drivers/cxl/port.c                   |   8 +-
 tools/testing/cxl/Kbuild             |   3 +-
 tools/testing/cxl/cxl_core_exports.c |  12 +
 tools/testing/cxl/exports.h          |  10 +
 tools/testing/cxl/test/cxl.c         |  67 +++++-
 tools/testing/cxl/test/mock.c        |  31 ++-
 tools/testing/cxl/test/mock.h        |   4 +-
 14 files changed, 651 insertions(+), 174 deletions(-)
 create mode 100644 tools/testing/cxl/exports.h


base-commit: 9c5718dca6390711ddebce75ab298f81e3d0e058
-- 
2.50.0

