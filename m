Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C125A623
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706675; cv=none; b=osbhISsDPSJhkGLstzIXoX+m0L9JcZAL5EEnTfV84Vz4H885U5jhAIuV+SwOH9WGwot/E9Uo9iNpAXGvDUz6RfjLsH3d4CMwbKszYVOBXnnJJ5CLm+cOyr6oa8Lf8ahWyevON0dfQkpDsYuXpDWwbnBD0h1UTrfcrDEqWxDmfJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706675; c=relaxed/simple;
	bh=xqrpiVqR8dhdzoAXpPt9XrbQqQSas5+ANHtoCex5rjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6rEP7wUH+WAIYHJUoemKmaPFwMJ3Ohr5MuPieCuVkffRlgh/VfE5tEWCymvheraWaZjuArm50SFI0fnVo66dR1iGFn6a+/0r3asSrfkUs5WPfwU53ChBzoFiL0nf2ezn0JTiEzwgaBVYDERJfczUuTNeYUuK3KuOKgN6fGAYJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77536C4CEE2;
	Tue,  4 Feb 2025 22:04:34 +0000 (UTC)
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
Subject: [PATCH v3 00/16] cxl: Add CXL feature commands support via fwctl
Date: Tue,  4 Feb 2025 15:03:01 -0700
Message-ID: <20250204220430.4146187-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
- Rearrange code and shift code forward to reduce diffs. (Jonathan)
- Use struct_size() in appropriate locations. (Jonathan)
- Remove usage of __weak and refactor accordingly. (Jason)
- Return NULL for allocation functions. (Jonathan)
- See individual patches for detailed changes from v2.

v2:
- Drop features device and driver. Move features enabling to cxl_memdev. (Dan)
- Drop sysfs attribute of number of features. (Dan)
- Drop moving of include/uapi/linux/cxl_mem.h. (Dan)
- Set get driver info ioctl to return reserved 32bit. Set behavior of issue
  ioctl successful as indicating Feature commands supported.
- Set 'Set Feature Size' to 0 for kernel exclusive Features.
- See individual patches for detailed changes from v1.
- Hide FWCTL bits behind CONFIG_CXL_FWCTL. (Dan)

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

Patches 1-7 are shared with EDAC series [1] and there will be an immutable branch
once accepted post review.

CXL Features support is added behind the CXL mem driver. The 3 mailbox commands
"Get Supported Features", "Get Feature", and "Set Feature" are implemented. The
"Get" commands are under the FWCTL_RPC_CONFIGURATION policy, the "Set" command
checks the policy depending on the set effects of the feature defined by the
device via the Feature set effects field. All mailbox commands for CXL provides
an effects table that describes the effects of a command when performed on the
device.  For CXL features, there is also an effects field that describes the
effects a feature set operation has on the device per feature. The security
policy is checked against this feature specific effects field. 

The code is based off of v3 of FWCTL series [2] posted by Jason and rebased on top of
v6.13-rc5.

[1]: https://lore.kernel.org/linux-cxl/20250106121017.1620-1-shiju.jose@huawei.com/T/#t
[2]: https://lore.kernel.org/linux-cxl/0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com/#r
---

Dave Jiang (14):
      cxl: Refactor user ioctl command path from mds to mailbox
      cxl: Enumerate feature commands
      cxl: Add Get Supported Features command for kernel usage
      cxl/test: Add Get Supported Features mailbox command support
      cxl: Setup exclusive CXL features that are reserved for the kernel
      cxl: Add FWCTL support to the CXL memdev driver
      cxl: Add support for FWCTL get driver information callback
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

 Documentation/userspace-api/fwctl/fwctl-cxl.rst | 137 +++++++++++++++
 Documentation/userspace-api/fwctl/index.rst     |   1 +
 MAINTAINERS                                     |   1 +
 drivers/cxl/Kconfig                             |  15 ++
 drivers/cxl/Makefile                            |   3 +-
 drivers/cxl/core/Makefile                       |   1 +
 drivers/cxl/core/core.h                         |   6 +-
 drivers/cxl/core/features.c                     | 175 +++++++++++++++++++
 drivers/cxl/core/mbox.c                         | 128 +++++++++-----
 drivers/cxl/core/memdev.c                       |  22 ++-
 drivers/cxl/cxl.h                               |   3 +
 drivers/cxl/cxlmem.h                            |  45 +----
 drivers/cxl/features.c                          | 237 ++++++++++++++++++++++++++
 drivers/cxl/features.h                          |  41 +++++
 drivers/cxl/fwctl.c                             | 398 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/mem.c                               |   5 +
 include/cxl/features.h                          |  79 +++++++++
 include/cxl/mailbox.h                           |  44 ++++-
 include/uapi/cxl/features.h                     | 128 ++++++++++++++
 include/uapi/fwctl/cxl.h                        |  56 +++++++
 include/uapi/fwctl/fwctl.h                      |   1 +
 tools/testing/cxl/Kbuild                        |   4 +-
 tools/testing/cxl/test/mem.c                    | 177 ++++++++++++++++++++
 23 files changed, 1609 insertions(+), 98 deletions(-)
