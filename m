Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650F1FB3D9
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706097; cv=none; b=lYUPl87YIteDnrb0Pm7WzJyHOSMPnn8ne6hi2CaOmipkW8tOxBKbT+yUCkn5TXYJrHuUEEi6VnTvl2h+dJ1ZtXQ4XGQhw5XxQFmf84FFfAuAeXRJ5/TTuqElIeGk3rX5PpqVltn3qFdf2CbCeF7IufgWBmK+3eOdXsjp4qtK+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706097; c=relaxed/simple;
	bh=+hwQ0imvuOGkz6mgYY+eQ7cNsyXYRKrIuOaqwQLcN6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6ieCuSox37FMB/UfuUBWGte3SaL253HXewi8TjL2jrURfgrWGbeNf7xgyVPt0QcwbcQU9b5tBb7FidIf6X4GQnVI77onqW3lFcM2j3uL5T/d0iSi3MWf5K3eEd1ldBI97jV7RxPQspqx144XzmzemTv42BinH8TGiYDJOqFcII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D5DC4CECF;
	Fri, 15 Nov 2024 21:28:16 +0000 (UTC)
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
Subject: [RFC PATCH v2 20/20] fwctl/cxl: Add documentation to FWCTL CXL
Date: Fri, 15 Nov 2024 14:25:53 -0700
Message-ID: <20241115212745.869552-21-dave.jiang@intel.com>
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

Add policy and operational documentation for FWCTL CXL.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 .../userspace-api/fwctl/fwctl-cxl.rst         | 91 +++++++++++++++++++
 Documentation/userspace-api/fwctl/index.rst   |  1 +
 2 files changed, 92 insertions(+)
 create mode 100644 Documentation/userspace-api/fwctl/fwctl-cxl.rst

diff --git a/Documentation/userspace-api/fwctl/fwctl-cxl.rst b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
new file mode 100644
index 000000000000..158e9aa45609
--- /dev/null
+++ b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
@@ -0,0 +1,91 @@
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
+the kernel. The "Get Supported Featuers" command falls under the fwctl policy
+of FWCTL_RPC_CONFIGURATION.
+
+The "Get Features" commands falls under the policy FWCTL_RPC_DEBUG_READ_ONLY.
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
+
+1. Driver info query
+--------------------
+
+First step for the app is to issue the ioctl(FWCTL_CMD_INFO) in order to retrieve
+the information from the driver. A ``struct fwctl_info`` needs to be filled out
+with the ``fwctl_info.out_device_type`` set to ``FWCTL_DEVICE_TYPE_CXL``. The
+return data should be ``struct fwctl_info_cxl`` that contains the number of
+commands supported by the driver.
+
+2. Hardware command info query
+------------------------------
+
+Second step is to retrieve the command information from the driver. A ``struct
+fwctl_hw_info`` is sent with the ioctl(FWCTL_CMD_HW_INFO).
+``fwctl_hw_info.nr_cmds`` should be set to the number retrieved from the driver
+info query. A user buffer of ``struct fwctl_hw_info_out`` including an inlined
+array of ``struct fwctl_hw_info_out`` numbered of nr_cmds should be allocated and
+set as ``fwctl_hw_info.out_device_data``. For each command supported, its
+relevant information is returned such as the driver command id, the opcode it
+supports, the effect reported by the device if it's a write command, and its
+expected input and output sizes.
+
+3. Send hardware command
+------------------------
+
+Last step is to send hardware command to the driver from user space via
+ioctl(FWCTL_RPC). A ``struct fwctl_rpc_cxl`` should be pointed to by
+``fwctl_rpc.in``. ``struct fwctl_rpc_cxl.in_payload`` should point to
+the hardware input structure that is defined by the CXL spec. ``fwctl_rpc.out``
+points to the buffer that contains a ``struct fwctl_rpc_cxl_out`` that includes
+the hardware output data inlined as ``fwctl_rpc_cxl_out.payload``.
+
+For a get/set feature command, it is recommended to run the "get supported
+features" command first to retrieve the desired feature information first
+before sending a get or set feature command. For a "set feature" command,
+the retrieved info contains an effects field that details the resulting
+"set feature" command will trigger. That should inform the user whether
+the system is configured to allowed the "set feature" command or not.
+
+
+fwctl cxl Kernel API
+====================
+
+.. kernel-doc:: drivers/fwctl/cxl/cxl.c
+   :export:
+.. kernel-doc:: include/cxl/mailbox.h
diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
index 06959fbf1547..d9d40a468a31 100644
--- a/Documentation/userspace-api/fwctl/index.rst
+++ b/Documentation/userspace-api/fwctl/index.rst
@@ -10,3 +10,4 @@ to securely construct and execute RPCs inside device firmware.
    :maxdepth: 1
 
    fwctl
+   fwctl-cxl
-- 
2.47.0

