Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B8123E23D
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381012; cv=none; b=hoOEnpBi7roUy780prMeHMwcnq1t6qQpu5gubfQ/6zrckGDY0kVCopKluuysC8LldbRZBRq+tb19shm1ed2DYEC7XHQMNBBqmcu5cQPK6ceCFvwxjsCe2Zctvp2p8MHFE9esPevtTTaw3cyBsV2JlYRz3QTUwlIiExa96FAV4Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381012; c=relaxed/simple;
	bh=z0uSPBg7WPIY4eoEt1HA55CqXq17eWOA6gxSrlztg2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c1lnWlSmE7/rlu9DgxbYsJ4qvzAoCkp6F31ErARO9Lyfv8wPa13libPpIjYejRUrzsfoqOWoXzgeTelj8LxXU9akyPJg1qtKTXZbP/TEe9QOi9tZInr/ye8wKtXg9MQIns6xbuvvQFK3KAUCL4CZAl9zWKS/Jp97cdBtO6iCWaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C42EC4CED1;
	Fri,  7 Mar 2025 20:56:51 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: jgg@nvidia.com,
	saeedm@nvidia.com,
	jonathan.cameron@huawei.com
Subject: [PATCH v8 0/9] cxl: Add CXL feature commands support via fwctl
Date: Fri,  7 Mar 2025 13:55:30 -0700
Message-ID: <20250307205648.1021626-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jason,
This series is the remaining patches for cxl fwctl from your [1] branch with fixed
up kdoc issues.

[1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=hmm

Dave Jiang (9):
      cxl: Add FWCTL support to CXL
      cxl: Move cxl feature command structs to user header
      cxl: Add support for fwctl RPC command to enable CXL feature commands
      cxl: Add support to handle user feature commands for get feature
      cxl: Add support to handle user feature commands for set feature
      cxl/test: Add Get Feature support to cxl_test
      cxl/test: Add Set Feature support to cxl_test
      fwctl/cxl: Add documentation to FWCTL CXL
      cxl: Fixup kdoc issues for include/cxl/features.h

 Documentation/userspace-api/fwctl/fwctl-cxl.rst | 143 +++++++++++++++++
 Documentation/userspace-api/fwctl/index.rst     |   1 +
 MAINTAINERS                                     |   1 +
 drivers/cxl/Kconfig                             |   1 +
 drivers/cxl/core/features.c                     | 381 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/pci.c                               |   4 +
 include/cxl/features.h                          | 124 ++------------
 include/uapi/cxl/features.h                     | 170 ++++++++++++++++++++
 include/uapi/fwctl/cxl.h                        |  56 +++++++
 include/uapi/fwctl/fwctl.h                      |   1 +
 tools/testing/cxl/test/mem.c                    | 111 +++++++++++++
 11 files changed, 878 insertions(+), 115 deletions(-)
