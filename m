Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531605234
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370725; cv=none; b=p0igYKCTQDaIBCJ7FVkQqzP9N24aPkY4VNZrqLCOnqQaHwiaWc965nyWBUX/8xRtt8UEAf9dBlmF2Tk7eGbkj6HxMlAg+ybzfisNXCkI2npn5rQdePpOMniJfAUDPi8kwSu+ZMtHcn65/x/XCKAkicIlqo+drQV15xQ1Z90msCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370725; c=relaxed/simple;
	bh=qB5icfwsDCPLP8mEvWglOot7Dw5SFtXUhAy0/C4ITrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDMfVmH0K/4KoLBdrSSlzlrTe8NgFPpSNJ1c6lvCvnTwlAWiCElrAs4HvI+AGbKvu+n8G/m/ToZK1Dio/dV6QIzV1HkL5UYTlpz0bh7gstLcuQ62XoZYOBdI+LLGNxuXroSb4sJkR9vGCm2wrg7GtcsMOP91MNHt9w+1DS2M5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CCDC4CED1;
	Sat,  1 Feb 2025 00:45:24 +0000 (UTC)
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
Subject: [PATCH v2 16/16] fwctl/cxl: Add documentation to FWCTL CXL
Date: Fri, 31 Jan 2025 17:42:09 -0700
Message-ID: <20250201004459.466499-17-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250201004459.466499-1-dave.jiang@intel.com>
References: <20250201004459.466499-1-dave.jiang@intel.com>
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
v2:
- Various corrections. (Dan)
- Add sample code for ioctl. (Dan)
- Update to reflect changes from driver code review.
---
 .../userspace-api/fwctl/fwctl-cxl.rst         | 135 ++++++++++++++++++
 Documentation/userspace-api/fwctl/index.rst   |   1 +
 MAINTAINERS                                   |   1 +
 3 files changed, 137 insertions(+)
 create mode 100644 Documentation/userspace-api/fwctl/fwctl-cxl.rst

diff --git a/Documentation/userspace-api/fwctl/fwctl-cxl.rst b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
new file mode 100644
index 000000000000..8d9aeb77bc6d
--- /dev/null
+++ b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
@@ -0,0 +1,135 @@
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
+The following 3 commands will be used to support CXL Features:
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
+categories depending on the Set Feature effects reported by the device. If the
+Set Feature will cause immediate change to the device, the fwctl access policy
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
+First step for the app is to issue the ioctl(FWCTL_CMD_INFO). Successful
+invocation of the ioctl implies the Features capability is operational and
+returns an all zeros 32bit payload. A ``struct fwctl_info`` needs to be filled
+out with the ``fwctl_info.out_device_type`` set to ``FWCTL_DEVICE_TYPE_CXL``.
+The return data should be ``struct fwctl_info_cxl`` that contains a reserved
+32bit field that should be all zeros.
+
+2. Send hardware commands
+-------------------------
+
+Next step is to send the 'Get Supported Features' command to the driver from
+user space via ioctl(FWCTL_RPC). A ``struct fwctl_rpc_cxl`` is pointed to
+by ``fwctl_rpc.in``. ``struct fwctl_rpc_cxl.in_payload`` points to
+the hardware input structure that is defined by the CXL spec. ``fwctl_rpc.out``
+points to the buffer that contains a ``struct fwctl_rpc_cxl_out`` that includes
+the hardware output data inlined as ``fwctl_rpc_cxl_out.payload``. This command
+is called twice. First time to retrieve the number of features supported.
+A second time to retrieve the specific feature details as the output data.
+
+After getting the specific feature details, a Get/Set Feature command can be
+appropriately programmed and sent. For a "Set Feature" command, the retrieved
+feature info contains an effects field that details the resulting
+"Set Feature" command will trigger. That will inform the user whether
+the system is configured to allowed the "Set Feature" command or not.
+
+Code example of a Get Feature
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+        static int cxl_fwctl_rpc_get_test_feature(int fd, struct test_feature *feat_ctx,
+                                                  const uint32_t expected_data)
+        {
+                struct cxl_mbox_get_feat_in feat_in __attribute__((aligned(16))) = {0};
+                struct fwctl_rpc_cxl in __attribute__((aligned(16))) = {0};
+                struct fwctl_rpc_cxl_out *out;
+                struct fwctl_rpc rpc = {0};
+                size_t out_size;
+                uint32_t val;
+                void *data;
+                int rc;
+
+                uuid_copy(feat_in.uuid, feat_ctx->uuid);
+                feat_in.count = feat_ctx->get_size;
+
+                out_size = sizeof(*out) + feat_in.count;
+                out = aligned_alloc(16, out_size);
+                if (!out)
+                        return -ENOMEM;
+
+                memset(out, 0, out_size);
+                data = out->payload;
+
+                in.command_id = CXL_FEATURE_ID_GET_FEATURE;
+                in.op_size = sizeof(feat_in);
+                in.in_payload = (uint64_t)(uint64_t *)&feat_in;
+
+                rpc.size = sizeof(rpc);
+                rpc.scope = FWCTL_RPC_CONFIGURATION;
+                rpc.in_len = sizeof(in);
+                rpc.out_len = out_size;
+                rpc.in = (uint64_t)(uint64_t *)&in;
+                rpc.out = (uint64_t)(uint64_t *)out;
+
+                rc = send_command(fd, &rpc, out);
+                if (rc)
+                        goto out;
+
+                val = le32toh(*(__le32 *)data);
+                if (memcmp(&val, &expected_data, sizeof(val)) != 0) {
+                        rc = -ENXIO;
+                        goto out;
+                }
+
+        out:
+                free(out);
+                return rc;
+        }
+
+It is recommended to take a look at CXL CLI test directory
+<https://github.com/pmem/ndctl/tree/main/test/fwctl.c> for a detailed user code
+example on how to exercise this path.
+
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 877eb301b1e5..5d67225a22bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5773,6 +5773,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	Documentation/driver-api/cxl
+F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
 F:	drivers/cxl/
 F:	include/cxl/
 F:	include/uapi/linux/cxl_mem.h
-- 
2.48.1

