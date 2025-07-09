Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71265202F8F
	for <linux-cxl@vger.kernel.org>; Wed,  9 Jul 2025 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093382; cv=none; b=AN1ac9bDBE5qrHeKz8gHu9yGSumRzdNRDNcBWUtPl4Nz3HVcNeBN8Er/uWEA07hZdVxGF9niM9UM3ZduJwYGbSfFpMaMkB1QMoBxg7y+Y0J5ytnjMHInQ/I2gGWVaye+CjGu9dq7hC6OQTvsx55JZ31Ezik/8x+e5DrbXmb8uGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093382; c=relaxed/simple;
	bh=/x0nXmbGEsk7DvTCIEA9P+QhrqbyCaPR3uJeQ+LLkVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/ngEwiyZOzS9v3Of9VDkB4NTCut2RHNwqISisM8b3ww3hAh6ZeN69AFeCHBjgiOzYnAy389hM1rUwK771Yz3if8R0Ox7hKoG/PFn1YqOWs9o51HWPIxrQkjbilPAwwjdQvVhxZcZCzuZRXX73O5awyFXHicKZ32Vt9SLq+XnMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4094C4CEEF;
	Wed,  9 Jul 2025 20:36:21 +0000 (UTC)
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
Subject: [PATCH v6 00/10] cxl: Delay HB port and switch dport probing until endpoint dev probe
Date: Wed,  9 Jul 2025 13:36:09 -0700
Message-ID: <20250709203619.2607133-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 drivers/cxl/acpi.c                   | 137 ++++++----
 drivers/cxl/core/cdat.c              |  23 +-
 drivers/cxl/core/pci.c               | 146 ++++++-----
 drivers/cxl/core/port.c              | 359 +++++++++++++++++++++++++--
 drivers/cxl/core/region.c            |   7 +-
 drivers/cxl/cxl.h                    |  32 ++-
 drivers/cxl/cxlpci.h                 |   1 -
 drivers/cxl/port.c                   |   8 +-
 tools/testing/cxl/Kbuild             |   3 +-
 tools/testing/cxl/cxl_core_exports.c |  12 +
 tools/testing/cxl/exports.h          |  10 +
 tools/testing/cxl/test/cxl.c         |  67 ++++-
 tools/testing/cxl/test/mock.c        |  31 ++-
 tools/testing/cxl/test/mock.h        |   4 +-
 14 files changed, 659 insertions(+), 181 deletions(-)
 create mode 100644 tools/testing/cxl/exports.h


base-commit: 9c5718dca6390711ddebce75ab298f81e3d0e058
-- 
2.50.0

