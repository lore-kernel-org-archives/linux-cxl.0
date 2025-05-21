Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3271322D4C8
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852487; cv=none; b=Q1XcKNaCfUIMnj1Lnz2WCZUTw96NOPQmV6Xfn3PW/Fm9vBH+ewWlYW9zTgcxKV2e6R0Yith0kcGLtKImbPVzIiEeJlkjXVHC/vpGWZCZYA+tBpsVFV4CgR+uNoLICGkDz/83JvsIjqiQ8M5tV1pfs+fLeEXcZdNN5tcM3EyYf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852487; c=relaxed/simple;
	bh=4wAnggiADRzfm7a4g9QZpLCcspj78k/qepEAYYZwkU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KS72O/7zcu/TGyfdG9wEzvNaACZ5QyRVJitu1UdZfWuNTLAqTMqBG86YqTuDmr6D3OCdN8K0QMmYtf/V31go2fdib4ULSh34Vidgldv/8yn5LDHhYGZb/bz0EzeBHE+NLgigUboXmvgMvoTUNmZM8TiYRU26w8u3MKDQpov5Fro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EDAC4CEE4;
	Wed, 21 May 2025 18:34:46 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Alejandro Lucero <alucerop@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jonathan Cameron <Jonsathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v3 0/9] cxl: Delay HB port and switch dport probing until endpoint dev probe
Date: Wed, 21 May 2025 11:34:34 -0700
Message-ID: <20250521183443.3828320-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
- Main changes revolve around improving naming of hostbridge uport and dport (Gregory)
- See specific patches for detailed change log

This series attempts to delay the setup of dports and Host Bridge (HB) register
until when the endpoint device (memdev) is being probed. At this point,
the CXL link is established and all the devices along the CXL link path up to
the Root Port (RP) should be active.

And hopefully this help a bit with Robert's issue raised in the "Inactive
downstream port handling" series [1]. Testing would be appreicated. Thank you!

[1]: https://lore.kernel.org/linux-cxl/67c8a0cc23ec_24b64294f6@dwillia2-xfh.jf.intel.com.notmuch/

Dave Jiang (9):
  cxl/region: Add decoder check to check_commit_order()
  cxl: Add helper to detect top of CXL device topology
  cxl: Separate out CXL dport->id vs actual dport hardware id
  cxl: Remove adding of port_num via devm_cxl_add_dport()
  cxl: Defer hardware dport->port_id assignment and registers probing
  cxl/test: Add workaround for cxl_test for cxl_core calling mocked
    functions
  cxl: Change sslbis handler to only handle single dport
  cxl: Create an xarray to tie a host bridge to the cxl_root
  cxl: Move enumeration of hostbridge ports to the memdev probe path

 drivers/cxl/acpi.c                   | 143 ++++++-----
 drivers/cxl/core/cdat.c              |  23 +-
 drivers/cxl/core/core.h              |   4 +
 drivers/cxl/core/hdm.c               |  45 ++--
 drivers/cxl/core/pci.c               |  66 +++--
 drivers/cxl/core/port.c              | 344 +++++++++++++++++++++++----
 drivers/cxl/core/region.c            |   7 +-
 drivers/cxl/cxl.h                    |  50 +++-
 drivers/cxl/port.c                   |  26 +-
 tools/testing/cxl/Kbuild             |   4 +-
 tools/testing/cxl/cxl_core_exports.c |  31 +++
 tools/testing/cxl/exports.h          |  17 ++
 tools/testing/cxl/test/cxl.c         |   5 +-
 tools/testing/cxl/test/mock.c        |  40 ++--
 14 files changed, 605 insertions(+), 200 deletions(-)
 create mode 100644 tools/testing/cxl/exports.h


base-commit: efda449f9119a954359a9c2928a61a99c79d7b41
-- 
2.49.0

