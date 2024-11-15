Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6065E1FB3F5
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706084; cv=none; b=gP9rgDL7+exPqWaOhDTxdJ+6wD0v9oB4Am52sp5mI7HeiKqfGLhynb8nZAPBwrbKQ6hI2tJZ/A8oFZLs1WMp0OaJ3r0xpYeaJoSkURGmfG6O/bUaBuatk0wx3vO5gNygvnwcA/Pga5K1fV7dUeMpmnBj9kstB3ht5y72GLUDB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706084; c=relaxed/simple;
	bh=dVEThEJbJl4cF7dZgmCIVrswqNbztqZ3ouzQeLytH7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTkEkETpDaSecmduGBPiC/R6xVFkyphfRKYwLqcrNdcRxIN82mfSrkalyx4dpP+Oku5Mq1xfjDXO2erAiRD3VVLQDO4AWiKqYmy7RS3qs0Tu3nWAHOv7Exla44sJs53UEByavdCecPzz+stuqq0IEJZqP6SF9W/+cZskgTwb4mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AD6C4CECF;
	Fri, 15 Nov 2024 21:28:03 +0000 (UTC)
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
Subject: [RFC PATCH v2 11/20] fwctl: FWCTL_HW_INFO to return hardware information
Date: Fri, 15 Nov 2024 14:25:44 -0700
Message-ID: <20241115212745.869552-12-dave.jiang@intel.com>
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

Add an optional ioctl FWCTL_HW_INFO to pass command specific information
to user space. An array of 'struct fwctl_command_info' will be returned
from the ioctl. These commands are send to the driver via FWCTL_RPC call.
The command info struct contains the command id, the related hardware
opcode, input and output size for the command, and the effects the command
has if it's a write command.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/fwctl/main.c       | 33 ++++++++++++++++++++++
 include/linux/fwctl.h      |  6 ++++
 include/uapi/fwctl/fwctl.h | 58 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index 54a7356e586c..073e3d20558b 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -77,6 +77,38 @@ static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
 	return ucmd_respond(ucmd, sizeof(*cmd));
 }
 
+static int fwctl_hw_cmd_info(struct fwctl_ucmd *ucmd)
+{
+	struct fwctl_device *fwctl = ucmd->uctx->fwctl;
+	struct fwctl_hw_info *cmd = ucmd->cmd;
+	size_t out_len;
+	int nr_cmds;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	nr_cmds = cmd->nr_cmds;
+	if (!nr_cmds)
+		return -EINVAL;
+
+	out_len = sizeof(struct fwctl_hw_info_out);
+	out_len += sizeof(struct fwctl_command_info) * nr_cmds;
+
+	if (cmd->device_data_len < out_len)
+		return -EINVAL;
+
+	void *outbuf __free(kvfree) = fwctl->ops->hw_info(ucmd->uctx, nr_cmds,
+							  &out_len);
+	if (IS_ERR(outbuf))
+		return PTR_ERR(outbuf);
+
+	if (copy_to_user(u64_to_user_ptr(cmd->out_device_data), outbuf, out_len))
+		return -EFAULT;
+
+	cmd->device_data_len = out_len;
+	return ucmd_respond(ucmd, sizeof(*cmd));
+}
+
 static int fwctl_cmd_rpc(struct fwctl_ucmd *ucmd)
 {
 	struct fwctl_device *fwctl = ucmd->uctx->fwctl;
@@ -156,6 +188,7 @@ struct fwctl_ioctl_op {
 	}
 static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
 	IOCTL_OP(FWCTL_INFO, fwctl_cmd_info, struct fwctl_info, out_device_data),
+	IOCTL_OP(FWCTL_HW_INFO, fwctl_hw_cmd_info, struct fwctl_info, out_device_data),
 	IOCTL_OP(FWCTL_RPC, fwctl_cmd_rpc, struct fwctl_rpc, out),
 };
 
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index 6eac9497ff1a..ccef64da710c 100644
--- a/include/linux/fwctl.h
+++ b/include/linux/fwctl.h
@@ -47,6 +47,12 @@ struct fwctl_ops {
 	 * ignore length on input, the core code will handle everything.
 	 */
 	void *(*info)(struct fwctl_uctx *uctx, size_t *length);
+	/**
+	 * @hw_info: Implement FWCTL_HW_INFO. Return a kmalloc() memory that is
+	 * copied to out_device_dataa. On input commands indicates the number
+	 * of command info structs requested.
+	 */
+	void *(*hw_info)(struct fwctl_uctx *uctx, int commands, size_t *out_len);
 	/**
 	 * @fw_rpc: Implement FWCTL_RPC. Deliver rpc_in/in_len to the FW and
 	 * return the response and set out_len. rpc_in can be returned as the
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 4e4d30104667..7334907e27c1 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -37,7 +37,8 @@
 enum {
 	FWCTL_CMD_BASE = 0,
 	FWCTL_CMD_INFO = 0,
-	FWCTL_CMD_RPC = 1,
+	FWCTL_CMD_HW_INFO = 1,
+	FWCTL_CMD_RPC = 2,
 };
 
 enum fwctl_device_type {
@@ -69,6 +70,61 @@ struct fwctl_info {
 };
 #define FWCTL_INFO _IO(FWCTL_TYPE, FWCTL_CMD_INFO)
 
+/**
+ * struct fwctl_command_info - Hardware command information returned from a query.
+ * @id: Driver ID number for the command
+ * @opcode: Hardware command opcode
+ * @set_effects: Effects to the OS and hardware when command is executed.
+ *               Provided by the device.
+ * @size_in: Expected input size, or ~0U if variable length.
+ * @size_out: Expected output size, or ~0U if variable length.
+ *
+ * Represents a single command that is supported by both the driver and the
+ * hardware. This is returned as part of an array from the FWCTL_HW_INFO ioctl.
+ */
+struct fwctl_command_info {
+	__u32 id;
+	__u16 opcode;
+	__u16 effects;
+	__u32 size_in;
+	__u32 size_out;
+};
+
+/**
+ * struct fwctl_hw_info_out - output struct for FWCTL_HW_INFO
+ * @nr_cmds: Number of commands for output
+ * @reserved: Reserved u32 for alignment.
+ * @commands: Array of 'struct fwctl_command_info'
+ */
+struct fwctl_hw_info_out {
+	__u32 nr_cmds;
+	__u32 reserved;
+
+	struct fwctl_command_info commands[] __counted_by(nr_cmds);
+};
+
+/**
+ * struct fwctl_hw_info - ioctl(FWCTL_HW_INFO)
+ * @size: sizeof(struct fwctl_hw_info)
+ * @flags: Must be 0
+ * @device_data_len: On input the length of the out_device_data memory. On
+ *	output the size of the kernel's device_data which may be larger or
+ *	smaller than the input. Maybe 0 on input.
+ * @nr_cmds: Number of commands requested. 0 returns only nr_cmds in output.
+ * @out_device_data: Pointer to a memory of device_data_len bytes. Kernel will
+ *	fill the entire memory, zeroing as required.
+ *
+ * Returns hardware commands information about this fwctl instance.
+ */
+struct fwctl_hw_info {
+	__u32 size;
+	__u32 flags;
+	__u32 device_data_len;
+	__u32 nr_cmds;
+	__aligned_u64 out_device_data;
+};
+#define FWCTL_HW_INFO _IO(FWCTL_TYPE, FWCTL_CMD_HW_INFO)
+
 /**
  * enum fwctl_rpc_scope - Scope of access for the RPC
  *
-- 
2.47.0

