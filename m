Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E3E27F171
	for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755210138; cv=none; b=ljqL2a5u+r+JWQLEmdZ7yUg5rP4EUQpl6PdU2b9eBbBl6hF7OkthXGKOCUlThwmkaxDTsFPgEpqQmaT8EOhNhSwteeLTEZEjGujym+WcG0eF1Jz58iGf6eVhG2vTHnHk2aUjXt91pTq/uf9Iovr/qQ5a1nBUUpKAUBPi6xqYxeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755210138; c=relaxed/simple;
	bh=77beWLS1uJQY6GyfRGy4YxQCjkidXVOGijyxtuimdUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u0+RYDxArPiAmkhO7yLy9yhAg2rN3uYcCKUkXRfoxGYD/gdoPmnKqnfoRsN+YSE4NB+xbC3GOrN+HF2QjNL6TOxLEo9sEOPGHxo0pBlC6X4HXN3+j689QbPFsA2j2WByoxPD/6ss9Xns7eIKohRLMwvw1g90tgrWmLRQkp75fc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5616C4CEED;
	Thu, 14 Aug 2025 22:22:16 +0000 (UTC)
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
Subject: [PATCH v8 00/11] cxl: Delay HB port and switch dport probing until endpoint dev probe
Date: Thu, 14 Aug 2025 15:21:40 -0700
Message-ID: <20250814222151.3520500-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Dave Jiang (11):
  cxl: Add helper to detect top of CXL device topology
  cxl: Add helper to reap dport
  cxl: Add a cached copy of target_map to cxl_decoder
  cxl: Move port register setup to first dport appear
  cxl: Defer dport allocation for switch ports
  cxl/test: Add cxl_test support for cxl_port_get_possible_dports()
  cxl/test: Add mock version of devm_cxl_add_dport_by_dev()
  cxl/test: Add support to cxl_test for decoder enumeration mock
    functions
  cxl/test: Setup target_map for cxl_test decoder initialization
  cxl: Change sslbis handler to only handle single dport
  tools/testing/cxl: Add decoder save/restore support

 drivers/cxl/acpi.c                   |   7 +-
 drivers/cxl/core/cdat.c              |  25 +-
 drivers/cxl/core/core.h              |   2 +
 drivers/cxl/core/hdm.c               |  51 ++--
 drivers/cxl/core/pci.c               |  82 ++++++
 drivers/cxl/core/port.c              | 358 ++++++++++++++++++------
 drivers/cxl/core/region.c            |   4 +-
 drivers/cxl/cxl.h                    |  44 ++-
 drivers/cxl/port.c                   |  29 +-
 tools/testing/cxl/Kbuild             |   5 +-
 tools/testing/cxl/cxl_core_exports.c |  42 +++
 tools/testing/cxl/exports.h          |  21 ++
 tools/testing/cxl/test/cxl.c         | 399 ++++++++++++++++++++++++++-
 tools/testing/cxl/test/mock.c        |  70 ++++-
 tools/testing/cxl/test/mock.h        |   3 +
 15 files changed, 963 insertions(+), 179 deletions(-)
 create mode 100644 tools/testing/cxl/exports.h


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1

