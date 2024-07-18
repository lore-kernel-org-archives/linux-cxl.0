Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA675808
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jul 2024 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338505; cv=none; b=LEH+XKWAd4RPoD1LmPr6Sfo8ziA8+JXhXYMK8gVCI5/QYN2zE6a94NwKqkmmhXMuo9DNPwbSVsGus7JWCTEyo97bDbMWBVPoOYMC/lc1ofpUYQ+q/NvuVxYgs1KBBLbuhVvdePZIitz5tq3EBEcE6Ro5XW7d6ZRu9qgdwcxGCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338505; c=relaxed/simple;
	bh=u0U8mQPcRfypHwZqgBxtB234+/zIAFI8yDBHTK+vSN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QblWfZBlMrtZIL4B1cIOslcjSmM7DXawr0d0eKD3Z6p256VHIerLfSDCrfZrC1dZ9DAu8hw8LVVQmqxBeqzR5W+ZwoSlN139omAGgz6Pqe96rbDB6KbU2N3mMa47Zlfed+H3OptVAFFE537+0gKeEr6P7+FHqNkWQOuKzJENZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0055BC116B1;
	Thu, 18 Jul 2024 21:35:04 +0000 (UTC)
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
Subject: [RFC PATCH 10/13] fwctl/cxl: Add support for fwctl RPC command to enable CXL feature commands
Date: Thu, 18 Jul 2024 14:32:28 -0700
Message-ID: <20240718213446.1750135-11-dave.jiang@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718213446.1750135-1-dave.jiang@intel.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
to a device. The cxl fwctl driver will start by supporting the CXL
feature commands: Get Supported Features, Get Feature, and Set Feature.

The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
it indicates the security scope of the call. The Get Supported Features
and Get Feature calls can be executed with the scope of
FWCTL_RPC_DEBUG_READ_ONLY. The Set Feature call is gated by the effects
of the feature reported by Get Supported Features call for the specific
feature.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h     |   5 +-
 drivers/cxl/core/mbox.c     | 232 ++++++++++++++++++++++++++++++++----
 drivers/cxl/core/memdev.c   |   4 +-
 drivers/cxl/cxlmem.h        |  83 +------------
 drivers/fwctl/cxl/cxl.c     | 127 +++++++++++++++++++-
 include/linux/cxl/mailbox.h | 101 ++++++++++++++++
 include/uapi/fwctl/cxl.h    |  64 ++++++++++
 7 files changed, 505 insertions(+), 111 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 7eb33ea07848..f22ee6f84f68 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,8 @@
 
 #include <linux/cxl/mailbox.h>
 
+extern struct rw_semaphore cxl_memdev_rwsem;
+
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
 extern const struct device_type cxl_pmu_type;
@@ -69,7 +71,8 @@ struct cxl_send_command;
 struct cxl_mem_query_commands;
 int cxl_query_cmd(struct cxl_mailbox *cxl_mbox,
 		  struct cxl_mem_query_commands __user *q);
-int cxl_send_cmd(struct cxl_mailbox *cxl_mailbox, struct cxl_send_command __user *s);
+int cxl_send_cmd_from_user(struct cxl_mailbox *cxl_mbox,
+			   struct cxl_send_command __user *s);
 void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 				   resource_size_t length);
 
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 14ebe69c47bf..d77817e347d8 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -4,6 +4,7 @@
 #include <linux/debugfs.h>
 #include <linux/ktime.h>
 #include <linux/mutex.h>
+#include <linux/cxl/mailbox.h>
 #include <asm/unaligned.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
@@ -215,6 +216,15 @@ static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
 	return NULL;
 }
 
+struct cxl_mem_command *cxl_get_mem_command(u32 id)
+{
+	if (id > CXL_MEM_COMMAND_ID_MAX)
+		return NULL;
+
+	return &cxl_mem_commands[id];
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_mem_command, CXL);
+
 static const char *cxl_mem_opcode_to_name(u16 opcode)
 {
 	struct cxl_mem_command *c;
@@ -377,10 +387,13 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
 	}
 
 	/* Prepare to handle a full payload for variable sized output */
-	if (out_size == CXL_VARIABLE_PAYLOAD)
-		mbox_cmd->size_out = cxl_mbox->payload_size;
-	else
+	if (out_size == CXL_VARIABLE_PAYLOAD) {
+		/* Adding extra 8 bytes for FWCTL, should not impact operation */
+		mbox_cmd->size_out = cxl_mbox->payload_size +
+			sizeof(struct fwctl_rpc_cxl_out);
+	} else {
 		mbox_cmd->size_out = out_size;
+	}
 
 	if (mbox_cmd->size_out) {
 		mbox_cmd->payload_out = kvzalloc(mbox_cmd->size_out, GFP_KERNEL);
@@ -477,6 +490,73 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
 	return 0;
 }
 
+static int cxl_fwctl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
+				const struct cxl_send_command *send_cmd,
+				struct cxl_mailbox *cxl_mbox)
+{
+	struct cxl_mem_command *c = &cxl_mem_commands[send_cmd->id];
+	const struct cxl_command_info *info = &c->info;
+
+	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
+		return -EINVAL;
+
+	if (send_cmd->rsvd)
+		return -EINVAL;
+
+	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
+		return -EINVAL;
+
+	/* Check the input buffer is the expected size */
+	if (info->size_in != CXL_VARIABLE_PAYLOAD &&
+	    info->size_in != send_cmd->in.size)
+		return -ENOMEM;
+
+	/* Check the output buffer is at least large enough */
+	if (info->size_out != CXL_VARIABLE_PAYLOAD &&
+	    send_cmd->out.size < info->size_out)
+		return -ENOMEM;
+
+	*mem_cmd = (struct cxl_mem_command) {
+		.info = {
+			.id = info->id,
+			.flags = info->flags,
+			.size_in = send_cmd->in.size,
+			.size_out = send_cmd->out.size,
+		},
+		.opcode = c->opcode
+	};
+
+	return 0;
+}
+
+static int verify_send_command(const struct cxl_send_command *send_cmd,
+			       struct cxl_mailbox *cxl_mbox)
+{
+	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
+		return -ENOTTY;
+
+	/*
+	 * The user can never specify an input payload larger than what hardware
+	 * supports, but output can be arbitrarily large (simply write out as
+	 * much data as the hardware provides).
+	 */
+	if (send_cmd->in.size > cxl_mbox->payload_size)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Sanitize and construct a cxl_mbox_cmd */
+static int construct_mbox_cmd(struct cxl_mbox_cmd *mbox_cmd,
+			      struct cxl_mem_command *mem_cmd,
+			      struct cxl_mailbox *cxl_mbox,
+			      const struct cxl_send_command *send_cmd)
+{
+	return cxl_mbox_cmd_ctor(mbox_cmd, cxl_mbox, mem_cmd->opcode,
+				 mem_cmd->info.size_in, mem_cmd->info.size_out,
+				 send_cmd->in.payload);
+}
+
 /**
  * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
  * @mbox_cmd: Sanitized and populated &struct cxl_mbox_cmd.
@@ -501,16 +581,9 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
 	struct cxl_mem_command mem_cmd;
 	int rc;
 
-	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
-		return -ENOTTY;
-
-	/*
-	 * The user can never specify an input payload larger than what hardware
-	 * supports, but output can be arbitrarily large (simply write out as
-	 * much data as the hardware provides).
-	 */
-	if (send_cmd->in.size > cxl_mbox->payload_size)
-		return -EINVAL;
+	rc = verify_send_command(send_cmd, cxl_mbox);
+	if (rc)
+		return rc;
 
 	/* Sanitize and construct a cxl_mem_command */
 	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW)
@@ -521,10 +594,26 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
 	if (rc)
 		return rc;
 
-	/* Sanitize and construct a cxl_mbox_cmd */
-	return cxl_mbox_cmd_ctor(mbox_cmd, cxl_mbox, mem_cmd.opcode,
-				 mem_cmd.info.size_in, mem_cmd.info.size_out,
-				 send_cmd->in.payload);
+	return construct_mbox_cmd(mbox_cmd, &mem_cmd, cxl_mbox, send_cmd);
+}
+
+static int cxl_validate_cmd_from_fwctl(struct cxl_mbox_cmd *mbox_cmd,
+				       struct cxl_mailbox *cxl_mbox,
+				       const struct cxl_send_command *send_cmd)
+{
+	struct cxl_mem_command mem_cmd;
+	int rc;
+
+	rc = verify_send_command(send_cmd, cxl_mbox);
+	if (rc)
+		return rc;
+
+	/* Sanitize and construct a cxl_mem_command */
+	rc = cxl_fwctl_to_mem_cmd(&mem_cmd, send_cmd, cxl_mbox);
+	if (rc)
+		return rc;
+
+	return construct_mbox_cmd(mbox_cmd, &mem_cmd, cxl_mbox, send_cmd);
 }
 
 int cxl_query_cmd(struct cxl_mailbox *cxl_mbox,
@@ -631,7 +720,107 @@ static int handle_mailbox_cmd_from_user(struct cxl_mailbox *cxl_mbox,
 	return rc;
 }
 
-int cxl_send_cmd(struct cxl_mailbox *cxl_mbox, struct cxl_send_command __user *s)
+static int cxl_send_cmd(struct cxl_mailbox *cxl_mbox, struct cxl_send_command *send,
+			struct cxl_mbox_cmd *mbox_cmd)
+{
+	int rc;
+
+	rc = cxl_validate_cmd_from_user(mbox_cmd, cxl_mbox, send);
+	if (rc)
+		return rc;
+
+	rc = handle_mailbox_cmd_from_user(cxl_mbox, mbox_cmd, send->out.payload,
+					  &send->out.size, &send->retval);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+/**
+ * handle_mailbox_cmd_from_fwctl() - Dispatch a mailbox command for userspace.
+ * @mailbox: The mailbox context for the operation.
+ * @mbox_cmd: The validated mailbox command.
+ *
+ * Return:
+ *  * %0	- Mailbox transaction succeeded. This implies the mailbox
+ *		  protocol completed successfully not that the operation itself
+ *		  was successful.
+ *  * %-ENOMEM  - Couldn't allocate a bounce buffer.
+ *  * %-EINTR	- Mailbox acquisition interrupted.
+ *  * %-EXXX	- Transaction level failures.
+ *
+ * Dispatches a mailbox command on behalf of a userspace request.
+ * The output payload is copied to userspace by fwctl.
+ *
+ * See cxl_send_cmd().
+ */
+static int handle_mailbox_cmd_from_fwctl(struct cxl_mailbox *cxl_mbox,
+					 struct cxl_mbox_cmd *mbox_cmd)
+{
+	struct device *dev = cxl_mbox->host;
+	struct fwctl_rpc_cxl_out *orig_out;
+	int rc;
+
+	/*
+	 * Save the payload_out pointer and move it to where hardware output
+	 * can be copied to.
+	 */
+	orig_out = mbox_cmd->payload_out;
+	mbox_cmd->payload_out = (void *)orig_out + sizeof(*orig_out);
+
+	dev_dbg(dev,
+		"Submitting %s command for user\n"
+		"\topcode: %x\n"
+		"\tsize: %zx\n",
+		cxl_mem_opcode_to_name(mbox_cmd->opcode),
+		mbox_cmd->opcode, mbox_cmd->size_in);
+
+	rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
+	if (rc)
+		return rc;
+
+	orig_out->retval = mbox_cmd->return_code;
+	mbox_cmd->payload_out = (void *)orig_out;
+
+	return 0;
+}
+
+int cxl_fwctl_send_cmd(struct cxl_mailbox *cxl_mbox,
+		       struct fwctl_cxl_command *fwctl_cmd,
+		       struct cxl_mbox_cmd *mbox_cmd, size_t *out_len)
+{
+	struct cxl_send_command send_cmd = {
+		.id = fwctl_cmd->id,
+		.flags = fwctl_cmd->flags,
+		.raw.opcode = fwctl_cmd->raw.opcode,
+		.in.size = fwctl_cmd->in.size,
+		.in.payload = fwctl_cmd->in.payload,
+		.out.size = *out_len,
+	};
+	int rc;
+
+	guard(rwsem_read)(&cxl_memdev_rwsem);
+	rc = cxl_validate_cmd_from_fwctl(mbox_cmd, cxl_mbox, &send_cmd);
+	if (rc)
+		return rc;
+
+	rc = handle_mailbox_cmd_from_fwctl(cxl_mbox, mbox_cmd);
+	if (rc)
+		return rc;
+
+	rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
+	if (rc)
+		return rc;
+
+	*out_len = mbox_cmd->size_out;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_fwctl_send_cmd, CXL);
+
+int cxl_send_cmd_from_user(struct cxl_mailbox *cxl_mbox,
+			   struct cxl_send_command __user *s)
 {
 	struct device *dev = cxl_mbox->host;
 	struct cxl_send_command send;
@@ -643,12 +832,7 @@ int cxl_send_cmd(struct cxl_mailbox *cxl_mbox, struct cxl_send_command __user *s
 	if (copy_from_user(&send, s, sizeof(send)))
 		return -EFAULT;
 
-	rc = cxl_validate_cmd_from_user(&mbox_cmd, cxl_mbox, &send);
-	if (rc)
-		return rc;
-
-	rc = handle_mailbox_cmd_from_user(cxl_mbox, &mbox_cmd, send.out.payload,
-					  &send.out.size, &send.retval);
+	rc = cxl_send_cmd(cxl_mbox, &send, &mbox_cmd);
 	if (rc)
 		return rc;
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 0f6ec85ef9c4..f6f33f0f7337 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -11,7 +11,7 @@
 #include "trace.h"
 #include "core.h"
 
-static DECLARE_RWSEM(cxl_memdev_rwsem);
+DECLARE_RWSEM(cxl_memdev_rwsem);
 
 #define CXL_ADEV_NAME "fwctl-cxl"
 
@@ -671,7 +671,7 @@ static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 	case CXL_MEM_QUERY_COMMANDS:
 		return cxl_query_cmd(cxl_mbox, (void __user *)arg);
 	case CXL_MEM_SEND_COMMAND:
-		return cxl_send_cmd(cxl_mbox, (void __user *)arg);
+		return cxl_send_cmd_from_user(cxl_mbox, (void __user *)arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5e190f941e58..736111f5bc31 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -465,53 +465,6 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
 	return container_of(cxlds, struct cxl_memdev_state, cxlds);
 }
 
-enum cxl_opcode {
-	CXL_MBOX_OP_INVALID		= 0x0000,
-	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
-	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
-	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
-	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
-	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
-	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
-	CXL_MBOX_OP_TRANSFER_FW		= 0x0201,
-	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
-	CXL_MBOX_OP_GET_TIMESTAMP	= 0x0300,
-	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
-	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
-	CXL_MBOX_OP_GET_LOG		= 0x0401,
-	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
-	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
-	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
-	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
-	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
-	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
-	CXL_MBOX_OP_IDENTIFY		= 0x4000,
-	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
-	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
-	CXL_MBOX_OP_GET_LSA		= 0x4102,
-	CXL_MBOX_OP_SET_LSA		= 0x4103,
-	CXL_MBOX_OP_GET_HEALTH_INFO	= 0x4200,
-	CXL_MBOX_OP_GET_ALERT_CONFIG	= 0x4201,
-	CXL_MBOX_OP_SET_ALERT_CONFIG	= 0x4202,
-	CXL_MBOX_OP_GET_SHUTDOWN_STATE	= 0x4203,
-	CXL_MBOX_OP_SET_SHUTDOWN_STATE	= 0x4204,
-	CXL_MBOX_OP_GET_POISON		= 0x4300,
-	CXL_MBOX_OP_INJECT_POISON	= 0x4301,
-	CXL_MBOX_OP_CLEAR_POISON	= 0x4302,
-	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
-	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
-	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
-	CXL_MBOX_OP_SANITIZE		= 0x4400,
-	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
-	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
-	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
-	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
-	CXL_MBOX_OP_UNLOCK		= 0x4503,
-	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
-	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
-	CXL_MBOX_OP_MAX			= 0x10000
-};
-
 #define DEFINE_CXL_CEL_UUID                                                    \
 	UUID_INIT(0xda9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, 0x96, 0xb1, 0x62,     \
 		  0x3b, 0x3f, 0x17)
@@ -709,30 +662,6 @@ struct cxl_mbox_clear_poison {
 	u8 write_data[CXL_POISON_LEN_MULT];
 } __packed;
 
-/**
- * struct cxl_mem_command - Driver representation of a memory device command
- * @info: Command information as it exists for the UAPI
- * @opcode: The actual bits used for the mailbox protocol
- * @flags: Set of flags effecting driver behavior.
- *
- *  * %CXL_CMD_FLAG_FORCE_ENABLE: In cases of error, commands with this flag
- *    will be enabled by the driver regardless of what hardware may have
- *    advertised.
- *
- * The cxl_mem_command is the driver's internal representation of commands that
- * are supported by the driver. Some of these commands may not be supported by
- * the hardware. The driver will use @info to validate the fields passed in by
- * the user then submit the @opcode to the hardware.
- *
- * See struct cxl_command_info.
- */
-struct cxl_mem_command {
-	struct cxl_command_info info;
-	enum cxl_opcode opcode;
-	u32 flags;
-#define CXL_CMD_FLAG_FORCE_ENABLE BIT(0)
-};
-
 #define CXL_PMEM_SEC_STATE_USER_PASS_SET	0x01
 #define CXL_PMEM_SEC_STATE_MASTER_PASS_SET	0x02
 #define CXL_PMEM_SEC_STATE_LOCKED		0x04
@@ -775,17 +704,7 @@ struct cxl_mbox_get_sup_feats_in {
 	__le16 reserved;
 } __packed;
 
-struct cxl_feat_entry {
-	uuid_t uuid;
-	__le16 id;
-	__le16 get_feat_size;
-	__le16 set_feat_size;
-	__le32 flags;
-	u8 get_feat_ver;
-	u8 set_feat_ver;
-	__le16 effects;
-	u8 reserved[18];
-} __packed;
+struct cxl_feat_entry;
 
 struct cxl_mbox_get_sup_feats_out {
 	__le16 num_entries;
diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
index 22f62034c021..01f0771148e1 100644
--- a/drivers/fwctl/cxl/cxl.c
+++ b/drivers/fwctl/cxl/cxl.c
@@ -51,10 +51,133 @@ static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
 	return info;
 }
 
+static bool cxlctl_validate_set_features(struct cxl_mailbox *cxl_mbox,
+					 const struct fwctl_cxl_command *send_cmd,
+					 enum fwctl_rpc_scope scope)
+{
+	struct cxl_feat_entry *feat;
+	bool found = false;
+	uuid_t uuid;
+	u16 mask;
+
+	if (send_cmd->in.size < sizeof(struct set_feature_input))
+		return false;
+
+	if (copy_from_user(&uuid, u64_to_user_ptr(send_cmd->in.payload),
+			   sizeof(uuid)))
+		return false;
+
+	for (int i = 0; i < cxl_mbox->num_features; i++) {
+		feat = &cxl_mbox->entries[i];
+		if (uuid_equal(&uuid, &feat->uuid)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return false;
+
+	/* Currently no user background command support */
+	if (feat->effects & CXL_CMD_BACKGROUND)
+		return false;
+
+	mask = CXL_CMD_CONFIG_CHANGE_IMMEDIATE |
+	       CXL_CMD_DATA_CHANGE_IMMEDIATE |
+	       CXL_CMD_POLICY_CHANGE_IMMEDIATE |
+	       CXL_CMD_LOG_CHANGE_IMMEDIATE;
+	if (feat->effects & mask && scope >= FWCTL_RPC_DEBUG_WRITE)
+		return true;
+
+	/* These effects supported for all scope */
+	if ((feat->effects & CXL_CMD_CONFIG_CHANGE_COLD_RESET ||
+	     feat->effects & CXL_CMD_CONFIG_CHANGE_CONV_RESET) &&
+	    scope >= FWCTL_RPC_DEBUG_READ_ONLY)
+		return true;
+
+	return false;
+}
+
+static bool cxlctl_validate_hw_cmds(struct cxl_mailbox *cxl_mbox,
+				    const struct fwctl_cxl_command *send_cmd,
+				    enum fwctl_rpc_scope scope)
+{
+	struct cxl_mem_command *cmd;
+
+	/*
+	 * Only supporting feature commands.
+	 */
+	if (!cxl_mbox->num_features)
+		return false;
+
+	cmd = cxl_get_mem_command(send_cmd->id);
+	if (!cmd)
+		return false;
+
+	if (test_bit(cmd->info.id, cxl_mbox->enabled_cmds))
+		return false;
+
+	if (test_bit(cmd->info.id, cxl_mbox->exclusive_cmds))
+		return false;
+
+	switch (cmd->opcode) {
+	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
+	case CXL_MBOX_OP_GET_FEATURE:
+		if (scope >= FWCTL_RPC_DEBUG_READ_ONLY)
+			return true;
+		break;
+	case CXL_MBOX_OP_SET_FEATURE:
+		return cxlctl_validate_set_features(cxl_mbox, send_cmd, scope);
+	default:
+		return false;
+	};
+
+	return false;
+}
+
+static bool cxlctl_validate_rpc(struct fwctl_uctx *uctx,
+				struct fwctl_rpc_cxl *rpc_in,
+				enum fwctl_rpc_scope scope)
+{
+	struct cxlctl_dev *cxlctl =
+		container_of(uctx->fwctl, struct cxlctl_dev, fwctl);
+
+	if (rpc_in->rpc_cmd != FWCTL_CXL_SEND_COMMAND)
+		return false;
+
+	return cxlctl_validate_hw_cmds(cxlctl->mbox, &rpc_in->send_cmd, scope);
+}
+
+static void *send_cxl_command(struct cxl_mailbox *cxl_mbox,
+			      struct fwctl_cxl_command *send_cmd,
+			      size_t *out_len)
+{
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	rc = cxl_fwctl_send_cmd(cxl_mbox, send_cmd, &mbox_cmd, out_len);
+	if (rc)
+		return ERR_PTR(rc);
+
+	*out_len = mbox_cmd.size_out;
+
+	return mbox_cmd.payload_out;
+}
+
 static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
-			   void *rpc_in, size_t in_len, size_t *out_len)
+			   void *in, size_t in_len, size_t *out_len)
 {
-	/* Place holder */
+	struct cxlctl_dev *cxlctl =
+		container_of(uctx->fwctl, struct cxlctl_dev, fwctl);
+	struct cxl_mailbox *cxl_mbox = cxlctl->mbox;
+	struct fwctl_rpc_cxl *rpc_in = in;
+
+	if (!cxlctl_validate_rpc(uctx, rpc_in, scope))
+		return ERR_PTR(-EPERM);
+
+	if (rpc_in->rpc_cmd == FWCTL_CXL_SEND_COMMAND)
+		return send_cxl_command(cxl_mbox, &rpc_in->send_cmd, out_len);
+
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
diff --git a/include/linux/cxl/mailbox.h b/include/linux/cxl/mailbox.h
index 570864239b8f..b3c74f3da9a5 100644
--- a/include/linux/cxl/mailbox.h
+++ b/include/linux/cxl/mailbox.h
@@ -4,6 +4,7 @@
 #define __CXL_MBOX_H__
 
 #include <uapi/linux/cxl_mem.h>
+#include <uapi/fwctl/cxl.h>
 #include <linux/auxiliary_bus.h>
 
 /**
@@ -68,4 +69,104 @@ struct cxl_mailbox {
 	struct cxl_feat_entry *entries;
 };
 
+enum cxl_opcode {
+	CXL_MBOX_OP_INVALID		= 0x0000,
+	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
+	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
+	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
+	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
+	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
+	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
+	CXL_MBOX_OP_TRANSFER_FW		= 0x0201,
+	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
+	CXL_MBOX_OP_GET_TIMESTAMP	= 0x0300,
+	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
+	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
+	CXL_MBOX_OP_GET_LOG		= 0x0401,
+	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
+	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
+	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
+	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
+	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
+	CXL_MBOX_OP_IDENTIFY		= 0x4000,
+	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
+	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
+	CXL_MBOX_OP_GET_LSA		= 0x4102,
+	CXL_MBOX_OP_SET_LSA		= 0x4103,
+	CXL_MBOX_OP_GET_HEALTH_INFO	= 0x4200,
+	CXL_MBOX_OP_GET_ALERT_CONFIG	= 0x4201,
+	CXL_MBOX_OP_SET_ALERT_CONFIG	= 0x4202,
+	CXL_MBOX_OP_GET_SHUTDOWN_STATE	= 0x4203,
+	CXL_MBOX_OP_SET_SHUTDOWN_STATE	= 0x4204,
+	CXL_MBOX_OP_GET_POISON		= 0x4300,
+	CXL_MBOX_OP_INJECT_POISON	= 0x4301,
+	CXL_MBOX_OP_CLEAR_POISON	= 0x4302,
+	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
+	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
+	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
+	CXL_MBOX_OP_SANITIZE		= 0x4400,
+	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
+	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
+	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
+	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
+	CXL_MBOX_OP_UNLOCK		= 0x4503,
+	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
+	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
+	CXL_MBOX_OP_MAX			= 0x10000
+};
+
+#define CXL_CMD_CONFIG_CHANGE_COLD_RESET	BIT(0)
+#define CXL_CMD_CONFIG_CHANGE_IMMEDIATE		BIT(1)
+#define CXL_CMD_DATA_CHANGE_IMMEDIATE		BIT(2)
+#define CXL_CMD_POLICY_CHANGE_IMMEDIATE		BIT(3)
+#define CXL_CMD_LOG_CHANGE_IMMEDIATE		BIT(4)
+#define CXL_CMD_SECURITY_STATE_CHANGE		BIT(5)
+#define CXL_CMD_BACKGROUND			BIT(6)
+#define CXL_CMD_BGCMD_ABORT_SUPPORTED		BIT(7)
+#define CXL_CMD_CONFIG_CHANGE_CONV_RESET	(BIT(9) | BIT(10))
+#define CXL_CMD_CONFIG_CHANGE_CXL_RESET		(BIT(9) | BIT(11))
+
+struct cxl_feat_entry {
+	uuid_t uuid;
+	__le16 id;
+	__le16 get_feat_size;
+	__le16 set_feat_size;
+	__le32 flags;
+	u8 get_feat_ver;
+	u8 set_feat_ver;
+	__le16 effects;
+	u8 reserved[18];
+} __packed;
+
+/**
+ * struct cxl_mem_command - Driver representation of a memory device command
+ * @info: Command information as it exists for the UAPI
+ * @opcode: The actual bits used for the mailbox protocol
+ * @flags: Set of flags effecting driver behavior.
+ *
+ *  * %CXL_CMD_FLAG_FORCE_ENABLE: In cases of error, commands with this flag
+ *    will be enabled by the driver regardless of what hardware may have
+ *    advertised.
+ *
+ * The cxl_mem_command is the driver's internal representation of commands that
+ * are supported by the driver. Some of these commands may not be supported by
+ * the hardware. The driver will use @info to validate the fields passed in by
+ * the user then submit the @opcode to the hardware.
+ *
+ * See struct cxl_command_info.
+ */
+struct cxl_mem_command {
+	struct cxl_command_info info;
+	enum cxl_opcode opcode;
+	u32 flags;
+#define CXL_CMD_FLAG_FORCE_ENABLE BIT(0)
+};
+
+struct cxl_mem_command *cxl_get_mem_command(u32 id);
+int cxl_fwctl_send_cmd(struct cxl_mailbox *cxl_mbox,
+		       struct fwctl_cxl_command *fwctl_cmd,
+		       struct cxl_mbox_cmd *mbox_cmd,
+		       size_t *out_len);
+
 #endif
diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
index d3a735f1fe4e..de8949a28473 100644
--- a/include/uapi/fwctl/cxl.h
+++ b/include/uapi/fwctl/cxl.h
@@ -22,4 +22,68 @@ struct fwctl_info_cxl {
 	__u32 uctx_caps;
 };
 
+/*
+ * CXL spec r3.1 Table 8-101 Set Feature Input Payload
+ */
+struct set_feature_input {
+	uuid_t uuid;
+	__u32 flags;
+	__u16 offset;
+	__u8 version;
+	__u8 reserved[9];
+	__u8 data[];
+} __packed;
+
+/**
+ * struct cxl_send_command - Send a command to a memory device.
+ * @id: The command to send to the memory device. This must be one of the
+ *	commands returned by the query command.
+ * @flags: Flags for the command (input).
+ * @raw: Special fields for raw commands
+ * @raw.opcode: Opcode passed to hardware when using the RAW command.
+ * @raw.rsvd: Must be zero.
+ * @rsvd: Must be zero.
+ * @retval: Return value from the memory device (output).
+ * @in: Parameters associated with input payload.
+ * @in.size: Size of the payload to provide to the device (input).
+ * @in.rsvd: Must be zero.
+ * @in.payload: Pointer to memory for payload input, payload is little endian.
+ *
+ * Output payload is defined with 'struct fwctl_rpc' and is the hardware output
+ */
+struct fwctl_cxl_command {
+	__u32 id;
+	__u32 flags;
+	union {
+		struct {
+			__u16 opcode;
+			__u16 rsvd;
+		} raw;
+		__u32 rsvd;
+	};
+
+	struct {
+		__u32 size;
+		__u32 rsvd;
+		__u64 payload;
+	} in;
+};
+
+/**
+ * struct fwctl_rpc_cxl - ioctl(FWCTL_RPC) input
+ */
+struct fwctl_rpc_cxl {
+	__u32 rpc_cmd;
+	__u32 payload_size;
+	__u32 version;
+	__u32 rsvd;
+	struct fwctl_cxl_command send_cmd;
+};
+
+struct fwctl_rpc_cxl_out {
+	__u32 retval;
+	__u32 rsvd;
+	__u8 payload[];
+};
+
 #endif
-- 
2.45.2

