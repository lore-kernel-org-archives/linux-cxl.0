Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5D021019E
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756490984; cv=none; b=igs8bUvQlE0VOjXpg5SB8b8vehzQXhptazh1pP/CnU1+4zBq4ALzYCnLDW19h+y+Y8uvbXfw/paEFucVUoiXemvGT8iTZ9mcB6bK2Ez3wOr7vbyJr9aTu5p54L8F3jF0GsNt4N249XvbOzMQMY8vaFAnItH5LYxkwptzo6cvFos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756490984; c=relaxed/simple;
	bh=QVRcLTmcvWpU5FCBx7SiNb6furL8HxK9nhVGJm/Dd6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWtROlig4mOTLDJJNf0YZzyN5zMrJGMnPm8cEk5Fr5DBZQa6pgWFoHe9dA/TCbQItBlYzSsprMsItKqZvAOPi7MWVf5NuU9GiZgRFq/uXgwTtROIMIeGcuVKHxOWd+tu4Mk+ROL4kzp+TYZWvgkh4n/mUg2aoBilxMMCNvXMsBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24558C4CEF0;
	Fri, 29 Aug 2025 18:09:42 +0000 (UTC)
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
Subject: [PATCH v9 00/10] cxl: Delay HB port and switch dport probing until endpoint dev probe
Date: Fri, 29 Aug 2025 11:09:18 -0700
Message-ID: <20250829180928.842707-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v9:
- Reworked the port enumeration iteration loop. (Robert)
  All please re-review "cxl: Defer dport allocation for switch ports"
- Created helper functions for dealing with switch and endpoint decoder enumeration.
  Main goal is to reduce cxl_test interface burden. (Robert)
  - Dropped cxl_test changes for decoder functions
- Dropped the cxl_test for region replay. It's not 100% ready and can be submitted later. (Alison)
- See specific commits for more detailed changes.

v8:
- A bit of changes from Dan and Robert's comments. Main change is moving the port MMIO
  register probing to after the first dport shows up. This resulted with decoder allocation
  happens after the register probe.
- See specific commits for more detailed changes.

v7:
- Remove -EEXIST to simplify error flow. (Ming)
- Set dport to NULL during declare. (Jonathan)

v6:
- Return -EEXIST when a dport already exists. (Jonathan)
- Fix checking wrong port for NULL. (Ming)
- Check host_bridge and call devm_cxl_add_dport_by_uport() directly vs add_port_attach_ep(). (Ming)
- Set dport to NULL during declaration. (Jonathan)

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
  cxl: Add helper to detect top of CXL device topology
  cxl: Add helper to reap dport
  cxl: Add a cached copy of target_map to cxl_decoder
  cxl: Move port register setup to first dport appear
  cxl/test: Refactor decoder setup to reduce cxl_test burden
  cxl: Defer dport allocation for switch ports
  cxl/test: Add mock version of devm_cxl_add_dport_by_dev()
  cxl/test: Adjust the mock version of
    devm_cxl_switch_port_decoders_setup()
  cxl/test: Setup target_map for cxl_test decoder initialization
  cxl: Change sslbis handler to only handle single dport

 drivers/cxl/acpi.c                   |   7 +-
 drivers/cxl/core/cdat.c              |  25 +--
 drivers/cxl/core/core.h              |   5 +
 drivers/cxl/core/hdm.c               | 105 ++++++---
 drivers/cxl/core/pci.c               |  89 ++++++++
 drivers/cxl/core/port.c              | 317 ++++++++++++++++++++-------
 drivers/cxl/core/region.c            |   4 +-
 drivers/cxl/cxl.h                    |  44 +++-
 drivers/cxl/cxlpci.h                 |   2 -
 drivers/cxl/port.c                   |  47 +---
 tools/testing/cxl/Kbuild             |   7 +-
 tools/testing/cxl/cxl_core_exports.c |  22 ++
 tools/testing/cxl/exports.h          |  13 ++
 tools/testing/cxl/test/cxl.c         | 115 ++++++++--
 tools/testing/cxl/test/mock.c        |  96 +++-----
 tools/testing/cxl/test/mock.h        |   9 +-
 16 files changed, 642 insertions(+), 265 deletions(-)
 create mode 100644 tools/testing/cxl/exports.h


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1

