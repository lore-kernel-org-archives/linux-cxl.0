Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6A1E283E
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706068; cv=none; b=h08rCRNK08hyXqg5QK76BaRj+RuUYQEk6L6U2tJ2ts5Y9oeGkbdWgE+ZxmBoq9lmTGIwDqzwoN3NPXQ99dXit7kWsPp0IbcltvrwIS+6PQofO6n/YaIY5UvdrqyC7plzM0B6mRO+qUuzGt96ANHW1/UN+5oxaf1IchxMLX1ySA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706068; c=relaxed/simple;
	bh=3hdFQ4Dieb8pEL8MsTcL365NrsfrB+TCZaGpZVyGY6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fu25Xj/Gh2XbgAARrLGJAPNvRoWd5nkhDxfuTqPNGA4grBQtnaKF+GLrmjC2LI0MaFEk36vcS0fJQ1PwpwnUis9rUci/hDku5MNRD7vC1KikuiQ0QDfL2EhyL8OkIgCk1LoTckzBICseCYWqbN7+DGRmFfpYV6gViIb0FJ9SctA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51ADCC4CECF;
	Fri, 15 Nov 2024 21:27:48 +0000 (UTC)
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
Subject: [RFC PATCH v2 0/20] fwctl/cxl: Add CXL feature commands support via fwctl
Date: Fri, 15 Nov 2024 14:25:33 -0700
Message-ID: <20241115212745.869552-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Dropped 1/13 and 2/13 from previous version. Merged upstream already.
- Combined changes from Shiju for "get supported features"
- Addressed comments from Jonathan and Jason
- See specific changes in individual patch revision history
- Added hardware command info to FWCTL
- Added filtering to set feature command
- Added documentation

This series add support for CXL feature commands using the FWCTL framework [1].
The code is untested and I'm looking for architectural and implementation feedback.
While CXL currently has a chardev for user ioctls to send some mailbox
commands to a memory device, the fwctl framework provides more security policies
that can be a potential vehicle to move CXL ioctl path to that.

For this RFC, the mailbox commands "Get Supported Features", "Get Feature", and
"Set Feature" commands are implemented. The "get" commands under the
FWCTL_RPC_DEBUG_READ_ONLY policy, the "set" command checks the policy depending
on the effect of the feature. All mailbox commands for CXL provides an effects
table that describes the effects of a command when performed on the device.
For CXL features, there is also an effects field that describes the effects
a feature write operation has on the device per feature. The security policy
is checked against this feature specific effects field. Looking for discussion
on matching the CXL spec defined effects with the FWCTL security policy.

The code is based off of v3 of FWCTL series [1] posted by Jason and rebased on top of
v6.12-rc6.

Jason,
Please see 11/20 and 13/20 in the series WRT the new hw info ioctl I introduced.
Let me know if that looks reasonable or if I should do that in a different way to
achieve what I want.

Jonathan and Shiju,
16/20 adds filtering of set feature command. Please check and see if that looks
reasonable for how we want to apply restrictions to the set feature command.

Shiju,
Please pick up 2/20 for your EDAC series. I made some corrections, including a pointer
math issue in cxl_get_supported_features() while looping through the feature
entries after saving them.

Jonathan,
I added documentation in 20/20. Maybe we can flesh out the usage policy there.

[1]: https://lore.kernel.org/linux-cxl/0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com/#r

---

Dave Jiang (18):
      cxl: Refactor user ioctl command path from mds to mailbox
      cxl: Add Get Supported Features command for kernel usage
      cxl/test: Add Get Supported Features mailbox command support
      cxl: Add Get Feature command support for user submission
      cxl: Add Set Feature command support for user submission
      cxl: Move cxl_driver related bits to be usable by external drivers
      fwctl/cxl: Add driver for CXL mailbox for handling CXL features commands
      fwctl/cxl: Add support for get driver information
      fwctl: FWCTL_HW_INFO to return hardware information
      cxl: Save Command Effects Log (CEL) effects for enabled commands
      fwctl/cxl: Add hw_info callback
      cxl: Move defines and error codes from cxlmem.h to cxl/mailbox.h
      fwctl/cxl: Add support for fwctl RPC command to enable CXL feature commands
      fwctl/cxl: Add support to filter exclusive features
      cxl/test: Add Get Feature support to cxl_test
      cxl/test: Add Set Feature support to cxl_test
      fwctl: Move fwctl documentation to its own directory
      fwctl/cxl: Add documentation to FWCTL CXL

Shiju Jose (2):
      cxl/mbox: Add GET_FEATURE mailbox command
      cxl/mbox: Add SET_FEATURE mailbox command

 Documentation/userspace-api/fwctl/fwctl-cxl.rst   |  91 +++++
 Documentation/userspace-api/{ => fwctl}/fwctl.rst |   0
 Documentation/userspace-api/fwctl/index.rst       |  13 +
 Documentation/userspace-api/index.rst             |   2 +-
 MAINTAINERS                                       |  10 +-
 drivers/cxl/core/core.h                           |   9 +-
 drivers/cxl/core/mbox.c                           | 859 ++++++++++++++++++++++++++++++++++++++----
 drivers/cxl/core/memdev.c                         |  24 +-
 drivers/cxl/cxl.h                                 |  32 +-
 drivers/cxl/cxlmem.h                              | 184 ++++-----
 drivers/cxl/pci.c                                 |   4 +
 drivers/fwctl/Kconfig                             |   9 +
 drivers/fwctl/Makefile                            |   1 +
 drivers/fwctl/cxl/Makefile                        |   4 +
 drivers/fwctl/cxl/cxl.c                           | 237 ++++++++++++
 drivers/fwctl/main.c                              |  33 ++
 include/cxl/cxl.h                                 |  40 ++
 include/cxl/features.h                            |  52 +++
 include/cxl/mailbox.h                             | 183 ++++++++-
 include/linux/fwctl.h                             |   6 +
 include/uapi/fwctl/cxl.h                          |  51 +++
 include/uapi/fwctl/fwctl.h                        |  59 ++-
 include/uapi/linux/cxl_mem.h                      |  20 +-
 tools/testing/cxl/test/mem.c                      | 201 ++++++++++
 24 files changed, 1903 insertions(+), 221 deletions(-)      
