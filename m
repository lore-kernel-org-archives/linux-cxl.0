Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CE61CAA86
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589948; cv=none; b=A81l8InAlbHXPNmqyJEnoEMUD36IVs87WP+Mu3P6bJGdwey7hl8pf8Y7EEL9RQmXc5OqGzAlt++E7yf9suC5GirKJ3ksGbBH2gc8RtCLnvayi3xid13rqqs5TilebEjjMb1VqYDPDmlZ2uljEMxQThGHa148aMzCQqQ8cw6khaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589948; c=relaxed/simple;
	bh=WYqzviXH/PktliwlNsAe+Brprt2iNB8TNcM+lDyC5gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPVjGfQl0PslXK38/7fTCn832cWzS0k05krRYGOe6UZQh0FdWomSPTRPLyq5T4m/26HY/NAtntdPBJ0N8uXyxwHOPnj6g+oADyFHsGSUsfqVl2GmhgK+3l4OAE2Ws5zoemOO64mv34aXT6tyvuJZ5O637nZY7TtOeCT2jZIdjms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566F4C4CED2;
	Wed, 22 Jan 2025 23:52:28 +0000 (UTC)
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
Subject: [PATCH v1 19/19] fwctl/cxl: Add documentation to FWCTL CXL
Date: Wed, 22 Jan 2025 16:50:50 -0700
Message-ID: <20250122235159.2716036-20-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122235159.2716036-1-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add policy and operational documentation for FWCTL CXL.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 .../userspace-api/fwctl/fwctl-cxl.rst         | 81 +++++++++++++++++++
 Documentation/userspace-api/fwctl/index.rst   |  1 +
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/userspace-api/fwctl/fwctl-cxl.rst

diff --git a/Documentation/userspace-api/fwctl/fwctl-cxl.rst b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
new file mode 100644
index 000000000000..f774bf2ecb5f
--- /dev/null
+++ b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
@@ -0,0 +1,81 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+fwctl cxl driver
+================
+
+:Author: Dave Jiang
+
+Overview
+========
+
+The CXL spec defines a set of commands that can be issued to the mailbox of a
+CXL device or switch. It also left room for vendor specific commands to be
+issued to the mailbox as well. fwctl provides a path to issue a set of allowed
+mailbox commands from user space to the device moderated by the kernel driver.
+
+While there are a large set of mailbox commands, only the feature related
+commands will be allowed to be issued through fwctl initially. No background
+commands will be supported at this time.
+
+CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
+CXL spec r3.1 8.2.9.6.2 Get Feature (Opcode 0501h)
+CXL spec r3.1 8.2.9.6.3 Set Feature (Opcode 0502h)
+
+The "Get Supported Features" return data may be filtered by the kernel driver to
+drop any features that are forbidden by the kernel or being exclusively used by
+the kernel. The "Get Supported Features" command and the "Get Features" falls
+under the fwctl policy of FWCTL_RPC_CONFIGURATION.
+
+For "Set Feature" command, the access policy currently is broken down into two
+categories depending on the set feature effects reported by the device. If the
+set feature will cause immediate change to the device, the fwctl access policy
+must be FWCTL_RPC_DEBUG_WRITE_FULL. The effects for this level are
+"immediate config change", "immediate data change", "immediate policy change",
+or "immediate log change" for the set effects mask. If the effects are "config
+change with cold reset" or "config change with conventional reset", then the
+fwctl access policy must be FWCTL_RPC_DEBUG_WRITE or higher.
+
+fwctl cxl User API
+==================
+
+.. kernel-doc:: include/uapi/fwctl/cxl.h
+.. kernel-doc:: include/uapi/cxl/features.h
+
+1. Driver info query
+--------------------
+
+First step for the app is to issue the ioctl(FWCTL_CMD_INFO) in order to retrieve
+the information from the driver. A ``struct fwctl_info`` needs to be filled out
+with the ``fwctl_info.out_device_type`` set to ``FWCTL_DEVICE_TYPE_CXL``. The
+return data should be ``struct fwctl_info_cxl`` that contains a command mask
+that indicates which of the commands are supported by the driver.
+
+2. Send hardware command
+------------------------
+
+Next step is to send the 'Get Supported Features' command to the driver from
+user space via ioctl(FWCTL_RPC). A ``struct fwctl_rpc_cxl`` should be pointed to
+by ``fwctl_rpc.in``. ``struct fwctl_rpc_cxl.in_payload`` should point to
+the hardware input structure that is defined by the CXL spec. ``fwctl_rpc.out``
+points to the buffer that contains a ``struct fwctl_rpc_cxl_out`` that includes
+the hardware output data inlined as ``fwctl_rpc_cxl_out.payload``. This command
+can be called twice. First time to retrieve the number of features supported.
+A second time to retrieve the specific feature details.
+
+After getting the specific feature details, a get/set feature command can be
+appropriately programmed and sent. For a "set feature" command, the retrieved
+feature info contains an effects field that details the resulting
+"set feature" command will trigger. That should inform the user whether
+the system is configured to allowed the "set feature" command or not.
+
+It is recommended to take a look at CXL CLI test directory for a detailed
+user code example on how to exercise this path.
+
+fwctl cxl Kernel API
+====================
+
+.. kernel-doc:: drivers/cxl/core/features.c
+.. kernel-doc:: drivers/cxl/features.c
+   :export:
+.. kernel-doc:: include/cxl/features.h
diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
index 06959fbf1547..d9d40a468a31 100644
--- a/Documentation/userspace-api/fwctl/index.rst
+++ b/Documentation/userspace-api/fwctl/index.rst
@@ -10,3 +10,4 @@ to securely construct and execute RPCs inside device firmware.
    :maxdepth: 1
 
    fwctl
+   fwctl-cxl
-- 
2.47.1

