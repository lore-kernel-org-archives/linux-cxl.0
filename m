Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF5275808
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jul 2024 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338490; cv=none; b=afKvbvzldtY1xBfftaV8bCm7wbKFugUm016La4DeNC7DeQIBIA1isoS0B4lQ1QASZBwjnPZY/CZ9/RJyhEXVG26Vgnf731KungOmy6/oiXsVeOQhzRONmzUwuHeBxOV75ax5OysH+qeHB6DlAktglAt3oY9s2fIpqcbuIAwPe3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338490; c=relaxed/simple;
	bh=1TdGI+b36Wpxd/Scor50kn6XQqBgo4dHyKsLIDAk5aM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQnvMROhu4BGrqTOKQzu2j8u5QtikPcfJfCGA+qu5UaT1OUfiiJ7uGtRPRx9PE1cya7g2OZDiubHGNGkFgFRz5ll8Y2HUyajoHVuqQj43F/kNS5OI4pHe0/HgdVOo02XLYtmv5okkRHD50VJICtF5zqPzK0Hc2WzMWovJzCwOdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13134C4AF0B;
	Thu, 18 Jul 2024 21:34:49 +0000 (UTC)
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
Subject: [RFC PATCH 0/13] fwctl/cxl: Add CXL feature commands support via fwctl
Date: Thu, 18 Jul 2024 14:32:18 -0700
Message-ID: <20240718213446.1750135-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

The code is based off of the latest FWCTL series [1] posted by Jason on top of v6.10.

[1]: https://lore.kernel.org/linux-cxl/20240624161802.1b7c962d@kernel.org/T/#t

---

Dave Jiang (13):
      cxl: Move mailbox related bits to the same context
      cxl: Fix comment regarding cxl_query_cmd() return data
      cxl: Refactor user ioctl command path from mds to mailbox
      cxl: Add Get Supported Features command for kernel usage
      cxl/test: Add Get Supported Features mailbox command support
      cxl: Add Get Feature command support
      cxl: Add Set Feature command support
      fwctl/cxl: Add driver for CXL mailbox for handling CXL features commands
      fwctl/cxl: Add support for get driver information
      fwctl/cxl: Add support for fwctl RPC command to enable CXL feature commands
      fwctl/cxl: Add query commands software command for ->fw_rpc()
      cxl/test: Add Get Feature support to cxl_test
      cxl/test: Add Set Feature support to cxl_test

 MAINTAINERS                  |   8 +
 drivers/cxl/core/core.h      |   9 +-
 drivers/cxl/core/mbox.c      | 607 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 drivers/cxl/core/memdev.c    |  78 +++++---
 drivers/cxl/cxlmem.h         | 141 +++------------
 drivers/cxl/pci.c            |  68 ++++---
 drivers/cxl/pmem.c           |  10 +-
 drivers/cxl/security.c       |  18 +-
 drivers/fwctl/Kconfig        |   9 +
 drivers/fwctl/Makefile       |   1 +
 drivers/fwctl/cxl/Makefile   |   4 +
 drivers/fwctl/cxl/cxl.c      | 274 ++++++++++++++++++++++++++++
 include/linux/cxl/mailbox.h  | 175 ++++++++++++++++++
 include/uapi/fwctl/cxl.h     |  92 ++++++++++
 include/uapi/fwctl/fwctl.h   |   1 +
 include/uapi/linux/cxl_mem.h |   3 +
 tools/testing/cxl/test/mem.c | 292 +++++++++++++++++++++++++++++-
 17 files changed, 1515 insertions(+), 275 deletions(-)
