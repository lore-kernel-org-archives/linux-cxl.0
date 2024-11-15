Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D651FB73C
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706095; cv=none; b=Aa0zNcLi6KDaCalP/S9YwqtCBwCdL01wAcWcOJQykbtGXYbi8kDZRHfzyecGaR6PX0/ws+Debjwd3q/T7LqkKrcCUAhvv7qj8cncJW/E+kW1p/PPgq6UeMMbiW/w0nus/XKHNzivZ84aeruKRZr64K7oIAev+SEVhEYGBMp/F2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706095; c=relaxed/simple;
	bh=7rrcwKrmyJTcwl3Z2QKDfPYNuyaoAU6cIiB5EiGEgFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCkQMfP4ZpsbwKsTqPyTTbz3J/wtkyMOyoKpDzIHvSAvUMPFcX+vgZ3cOGgH73vsEFl33JQ5vbVhqn5QBIQ+R6ssJ73GQeZFTl1HKWrwcLBD6GhGJiZ5w5MnPlG8ecUQFV6JgYTvDoraGh5si6DA1ph9rxjvzkd8/OzFTZyPAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F89C4CECF;
	Fri, 15 Nov 2024 21:28:14 +0000 (UTC)
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
Subject: [RFC PATCH v2 19/20] fwctl: Move fwctl documentation to its own directory
Date: Fri, 15 Nov 2024 14:25:52 -0700
Message-ID: <20241115212745.869552-20-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115212745.869552-1-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move fwctl.rst to its own directory in prepraration for adding more
documentation.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/userspace-api/{ => fwctl}/fwctl.rst |  0
 Documentation/userspace-api/fwctl/index.rst       | 12 ++++++++++++
 Documentation/userspace-api/index.rst             |  2 +-
 MAINTAINERS                                       |  2 +-
 4 files changed, 14 insertions(+), 2 deletions(-)
 rename Documentation/userspace-api/{ => fwctl}/fwctl.rst (100%)
 create mode 100644 Documentation/userspace-api/fwctl/index.rst

diff --git a/Documentation/userspace-api/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
similarity index 100%
rename from Documentation/userspace-api/fwctl.rst
rename to Documentation/userspace-api/fwctl/fwctl.rst
diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
new file mode 100644
index 000000000000..06959fbf1547
--- /dev/null
+++ b/Documentation/userspace-api/fwctl/index.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Firmware Control (FWCTL) Userspace API
+======================================
+
+A framework that define a common set of limited rules that allows user space
+to securely construct and execute RPCs inside device firmware.
+
+.. toctree::
+   :maxdepth: 1
+
+   fwctl
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 2bc43a658074..c2f067b3de01 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -44,7 +44,7 @@ Devices and I/O
 
    accelerators/ocxl
    dma-buf-alloc-exchange
-   fwctl
+   fwctl/index
    gpio/index
    iommufd
    media/index
diff --git a/MAINTAINERS b/MAINTAINERS
index 6b52c4168b94..1699316f86ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9377,7 +9377,7 @@ FWCTL SUBSYSTEM
 M:	Jason Gunthorpe <jgg@nvidia.com>
 M:	Saeed Mahameed <saeedm@nvidia.com>
 S:	Maintained
-F:	Documentation/userspace-api/fwctl.rst
+F:	Documentation/userspace-api/fwctl/
 F:	drivers/fwctl/
 F:	include/linux/fwctl.h
 F:	include/uapi/fwctl/
-- 
2.47.0

