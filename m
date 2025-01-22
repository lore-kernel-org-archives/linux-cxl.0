Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F01C5D54
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589922; cv=none; b=RwGUkR1M4GDiuFV4gmjdHBvWQsUi1jhVh0yr1u6QMF+UYmxO8iB7ja6bTjpCRBig7HDeq0WrLqjA5fXqp3J6x8CCN2qieb/WvVTd2GkHjTMtgVqeMtSt8IzWCyi6ZgwE8E0+qSNSh5x9D/bDehAoDIZwhD3pYGBQxp6+9bmkEOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589922; c=relaxed/simple;
	bh=VHQ7b81DSYJ9RGjhO0Qw/zIN5i2liXU3oJbtmsvWw+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lg3B52o29I7NAvSj2BJpcfk7G5CxYcHwzM7ugfCC6dsbNPvWrIQ11mUiIWdZdEWfFz3hWVEG1q/D6b6NSD9/FOmK3xYCvdxIF9eX5lExq3+Ak/lEMJSlyE1XmawN07L1qIn4IdlkrMe+Jlccv1nh1abc/i0eEQeGUf80pKLmDIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B3DC4CED2;
	Wed, 22 Jan 2025 23:52:02 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	jgg@nvidia.com,
	shiju.jose@huawei.com
Subject: [PATCH v1 0/19] cxl: Add CXL feature commands support via fwctl
Date: Wed, 22 Jan 2025 16:50:31 -0700
Message-ID: <20250122235159.2716036-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1:
- Create a CXL features driver to handle all feature command related bits
  including FWCTL support. (Dan)
- Tested against CXL CLI unit tests for FWCTL.
- See individual patches for detailed changes from RFC v2.

RFC v2:
- Dropped 1/13 and 2/13 from previous version. Merged upstream already.
- Combined changes from Shiju for "get supported features"
- Addressed comments from Jonathan and Jason
- See specific changes in individual patch revision history
- Added hardware command info to FWCTL
- Added filtering to set feature command
- Added documentation

This series add support for CXL feature commands using the FWCTL framework [1].
The code has been tested with CXL CLI unit tests for FWCTL.

Patches 1-7 are shared with EDAC series [1] and there will be an immuable branch
once accepted post review.

A CXL features driver is created to handle all CXL mailbox feature commands related
functionalities as suggested by Dan. The 3 mailbox commands "Get Supported Features",
"Get Feature", and "Set Feature" are implemented. The "get" commands under the
FWCTL_RPC_CONFIGURATION policy, the "set" command checks the policy depending
on the effect of the feature. All mailbox commands for CXL provides an effects
table that describes the effects of a command when performed on the device.
For CXL features, there is also an effects field that describes the effects
a feature write operation has on the device per feature. The security policy
is checked against this feature specific effects field. Looking for discussion
on matching the CXL spec defined effects with the FWCTL security policy.

The code is based off of v3 of FWCTL series [2] posted by Jason and rebased on top of
v6.13-rc5.

[1]: https://lore.kernel.org/linux-cxl/20250106121017.1620-1-shiju.jose@huawei.com/T/#t
[2]: https://lore.kernel.org/linux-cxl/0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com/#r
---

Dave Jiang (17):
      cxl: Refactor user ioctl command path from mds to mailbox
      cxl: Add skeletal features driver
      cxl: Enumerate feature commands
      cxl: Add Get Supported Features command for kernel usage
      cxl: Add features driver attribute to emit number of features supported
      cxl/test: Add Get Supported Features mailbox command support
      cxl: Setup exclusive CXL features that are reserved for the kernel
      cxl: Add FWCTL support to the CXL features driver
      cxl: Add support for get driver information
      cxl: Move cxl_mem.h under uapi to cxl exclusive directory
      cxl: Move cxl feature command structs to user header
      cxl: Add support for fwctl RPC command to enable CXL feature commands
      cxl: Add support to handle user feature commands for get feature
      cxl: Add support to handle user feature commands for set feature
      cxl/test: Add Get Feature support to cxl_test
      cxl/test: Add Set Feature support to cxl_test
      fwctl/cxl: Add documentation to FWCTL CXL

Shiju Jose (2):
      cxl/mbox: Add GET_FEATURE mailbox command
      cxl/mbox: Add SET_FEATURE mailbox command

 Documentation/userspace-api/fwctl/fwctl-cxl.rst |  81 +++++++
 Documentation/userspace-api/fwctl/index.rst     |   1 +
 drivers/cxl/Kconfig                             |   9 +
 drivers/cxl/Makefile                            |   3 +
 drivers/cxl/core/Makefile                       |   1 +
 drivers/cxl/core/core.h                         |   7 +-
 drivers/cxl/core/features.c                     | 287 +++++++++++++++++++++++
 drivers/cxl/core/mbox.c                         | 143 ++++++++----
 drivers/cxl/core/memdev.c                       |  22 +-
 drivers/cxl/core/port.c                         |   3 +
 drivers/cxl/cxl.h                               |   3 +
 drivers/cxl/cxlmem.h                            |  45 +---
 drivers/cxl/features.c                          | 558 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c                               |  19 ++
 include/cxl/features.h                          |  75 ++++++
 include/cxl/mailbox.h                           |  46 +++-
 include/uapi/cxl/features.h                     | 135 +++++++++++
 include/uapi/{linux/cxl_mem.h => cxl/mem.h}     |   0
 include/uapi/fwctl/cxl.h                        |  60 +++++
 include/uapi/fwctl/fwctl.h                      |   1 +
 tools/testing/cxl/Kbuild                        |   1 +
 tools/testing/cxl/test/mem.c                    | 194 +++++++++++++++
 22 files changed, 1597 insertions(+), 97 deletions(-)
