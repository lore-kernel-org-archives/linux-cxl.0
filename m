Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8C1F470B
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706089; cv=none; b=fuk5//grakZpJxeVTODK4kcrFmSoODZxiwZlqxAr25z5yq0muGzMeEPfDSVAYKLHLz9rzgrC0sTK4b0m3M+gVQ4bJLwhhc6AfFmuuXpd9t150WujVKnqa0MzMQAycU1BILEWDVP1heBw/vkwjp4ojB8Og/0Y8qdsN+nvh+OjKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706089; c=relaxed/simple;
	bh=kuN+DknImRDX6fkJpCDM3zJdDMjxfUrMnNn1RqbQiss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dj59gn6hy/6N/h1u40bgouJxs16nh61Zurrof8jyAvYSvVvu7KuA8LvTuLvaFd4dCPvUWN0SBQYFPWe4lpykHovfz5394k9pYeq2drujPIRuG+Sz/bFofvb7phKa4mw11VHV0JW98LBDomj8q9gcAndyYRwBQmU1jU+Aq+MlUzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8D0C4CECF;
	Fri, 15 Nov 2024 21:28:09 +0000 (UTC)
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
Subject: [RFC PATCH v2 15/20] fwctl/cxl: Add support for fwctl RPC command to enable CXL feature commands
Date: Fri, 15 Nov 2024 14:25:48 -0700
Message-ID: <20241115212745.869552-16-dave.jiang@intel.com>
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
 drivers/cxl/core/core.h      |   5 +-
 drivers/cxl/core/mbox.c      | 260 +++++++++++++++++++++++++++++++----
 drivers/cxl/core/memdev.c    |   4 +-
 drivers/fwctl/cxl/cxl.c      | 101 +++++++++++++-
 include/cxl/mailbox.h        |   6 +
 include/uapi/fwctl/cxl.h     |  29 ++++
 include/uapi/linux/cxl_mem.h |  12 ++
 7 files changed, 387 insertions(+), 30 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index ff30d1c99ca7..2b28fd8845d6 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,8 @@
 
 #include <cxl/mailbox.h>
 
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
index 65fceabb9fe7..e7c5c709ac79 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -5,6 +5,7 @@
 #include <linux/ktime.h>
 #include <linux/mutex.h>
 #include <linux/unaligned.h>
+#include <cxl/mailbox.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -225,6 +226,38 @@ static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
 	return NULL;
 }
 
+static struct cxl_mem_command *cxl_mem_find_command_by_id(int id)
+{
+	struct cxl_mem_command *c;
+
+	cxl_for_each_cmd(c)
+		if (c->info.id == id)
+			return c;
+
+	return NULL;
+
+}
+
+struct cxl_mem_command *
+cxl_get_mem_command_for_fwctl(struct cxl_mailbox *cxl_mbox, u32 id)
+{
+	struct cxl_mem_command *cmd;
+
+	if (id > CXL_MEM_COMMAND_ID_MAX)
+		return NULL;
+
+	cmd = &cxl_mem_commands[id];
+
+	if (!test_bit(cmd->info.id, cxl_mbox->enabled_cmds))
+		return NULL;
+
+	if (test_bit(cmd->info.id, cxl_mbox->exclusive_cmds))
+		return NULL;
+
+	return cmd;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_mem_command_for_fwctl, CXL);
+
 static const char *cxl_mem_opcode_to_name(u16 opcode)
 {
 	struct cxl_mem_command *c;
@@ -387,10 +420,13 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
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
@@ -487,6 +523,73 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
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
@@ -511,16 +614,9 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
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
@@ -531,10 +627,26 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
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
 
 static struct cxl_mem_command *
@@ -719,7 +831,112 @@ static int handle_mailbox_cmd_from_user(struct cxl_mailbox *cxl_mbox,
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
+ * @cxl_mbox: The mailbox context for the operation.
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
+int cxl_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
+		      struct fwctl_rpc_cxl *rpc_in,
+		      struct cxl_mbox_cmd *mbox_cmd, size_t *out_len)
+{
+	struct cxl_send_command send_cmd = {
+		.id = rpc_in->id,
+		.flags = rpc_in->flags,
+		.in.size = rpc_in->op_size,
+		.in.payload = rpc_in->in_payload,
+		.out.size = *out_len,
+	};
+	struct cxl_mem_command *cmd;
+	int rc;
+
+	cmd = cxl_mem_find_command_by_id(rpc_in->id);
+	if (!cmd)
+		return -EINVAL;
+	send_cmd.raw.opcode = cmd->opcode;
+
+	rc = cxl_validate_cmd_from_fwctl(mbox_cmd, cxl_mbox, &send_cmd);
+	if (rc)
+		return rc;
+
+	rc = handle_mailbox_cmd_from_fwctl(cxl_mbox, mbox_cmd);
+	if (rc)
+		return rc;
+
+	guard(rwsem_read)(&cxl_memdev_rwsem);
+	rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
+	if (rc)
+		return rc;
+
+	*out_len = mbox_cmd->size_out;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mbox_send_cmd, CXL);
+
+int cxl_send_cmd_from_user(struct cxl_mailbox *cxl_mbox,
+			   struct cxl_send_command __user *s)
 {
 	struct device *dev = cxl_mbox->host;
 	struct cxl_send_command send;
@@ -731,12 +948,7 @@ int cxl_send_cmd(struct cxl_mailbox *cxl_mbox, struct cxl_send_command __user *s
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
index 4d544a55ac3e..7fa16930cd85 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -11,7 +11,7 @@
 #include "trace.h"
 #include "core.h"
 
-static DECLARE_RWSEM(cxl_memdev_rwsem);
+DECLARE_RWSEM(cxl_memdev_rwsem);
 
 /*
  * An entire PCI topology full of devices should be enough for any
@@ -667,7 +667,7 @@ static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 	case CXL_MEM_QUERY_COMMANDS:
 		return cxl_query_cmd(cxl_mbox, (void __user *)arg);
 	case CXL_MEM_SEND_COMMAND:
-		return cxl_send_cmd(cxl_mbox, (void __user *)arg);
+		return cxl_send_cmd_from_user(cxl_mbox, (void __user *)arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
index ce8960a9beaa..164f6774a2c1 100644
--- a/drivers/fwctl/cxl/cxl.c
+++ b/drivers/fwctl/cxl/cxl.c
@@ -77,11 +77,106 @@ static void *cxlctl_hw_info(struct fwctl_uctx *uctx, int commands, size_t *out_l
 	return_ptr(out);
 }
 
+static bool cxlctl_validate_set_features(struct cxl_mailbox *cxl_mbox,
+					 const struct fwctl_rpc_cxl *rpc_in,
+					 enum fwctl_rpc_scope scope)
+{
+	struct cxl_feat_entry *feat;
+	bool found = false;
+	uuid_t uuid;
+	u16 effects, mask;
+
+	if (rpc_in->op_size < sizeof(struct cxl_set_feature_input))
+		return false;
+
+	if (copy_from_user(&uuid, u64_to_user_ptr(rpc_in->in_payload),
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
+	effects = le16_to_cpu(feat->effects);
+	/* Currently no user background command support */
+	if (effects & CXL_CMD_BACKGROUND)
+		return false;
+
+	mask = CXL_CMD_CONFIG_CHANGE_IMMEDIATE |
+	       CXL_CMD_DATA_CHANGE_IMMEDIATE |
+	       CXL_CMD_POLICY_CHANGE_IMMEDIATE |
+	       CXL_CMD_LOG_CHANGE_IMMEDIATE;
+	if (effects & mask && scope >= FWCTL_RPC_DEBUG_WRITE_FULL)
+		return true;
+
+	/* These effects supported for all scope */
+	if ((effects & CXL_CMD_CONFIG_CHANGE_COLD_RESET ||
+	     effects & CXL_CMD_CONFIG_CHANGE_CONV_RESET) &&
+	    scope >= FWCTL_RPC_DEBUG_WRITE)
+		return true;
+
+	return false;
+}
+
+static bool cxlctl_validate_hw_cmds(struct cxl_mailbox *cxl_mbox,
+				    const struct fwctl_rpc_cxl *rpc_in,
+				    enum fwctl_rpc_scope scope)
+{
+	struct cxl_mem_command *cmd;
+
+	/*
+	 * Only supporting feature commands for now.
+	 */
+	if (!cxl_mbox->num_features)
+		return false;
+
+	cmd = cxl_get_mem_command_for_fwctl(cxl_mbox, rpc_in->id);
+	if (!cmd)
+		return false;
+
+	switch (cmd->opcode) {
+	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
+		if (scope >= FWCTL_RPC_CONFIGURATION)
+			return true;
+		return false;
+	case CXL_MBOX_OP_GET_FEATURE:
+		if (scope >= FWCTL_RPC_DEBUG_READ_ONLY)
+			return true;
+		return false;
+	case CXL_MBOX_OP_SET_FEATURE:
+		return cxlctl_validate_set_features(cxl_mbox, rpc_in, scope);
+	default:
+		return false;
+	}
+}
+
 static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
-			   void *rpc_in, size_t in_len, size_t *out_len)
+			   void *in, size_t in_len, size_t *out_len)
 {
-	/* Place holder */
-	return ERR_PTR(-EOPNOTSUPP);
+	struct cxlctl_dev *cxlctl =
+		container_of(uctx->fwctl, struct cxlctl_dev, fwctl);
+	struct cxl_mailbox *cxl_mbox = cxlctl->mbox;
+	struct fwctl_rpc_cxl *rpc_in = in;
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	if (!cxlctl_validate_hw_cmds(cxlctl->mbox, rpc_in, scope))
+		return ERR_PTR(-EPERM);
+
+	rc = cxl_mbox_send_cmd(cxl_mbox, rpc_in, &mbox_cmd, out_len);
+	if (rc)
+		return ERR_PTR(rc);
+
+	*out_len = mbox_cmd.size_out;
+
+	return mbox_cmd.payload_out;
 }
 
 static const struct fwctl_ops cxlctl_ops = {
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index e753d5d1d708..3e5e9c9362f5 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -193,5 +193,11 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host);
 int cxl_mailbox_user_commands_supported(struct cxl_mailbox *cxl_mbox);
 int cxl_mailbox_user_commands_info_get(struct cxl_mailbox *cxl_mbox, int nr_cmds,
 				       void *outbuf, size_t *out_len);
+struct cxl_mem_command *cxl_get_mem_command(u32 id);
+struct cxl_mem_command *
+cxl_get_mem_command_for_fwctl(struct cxl_mailbox *cxl_mbox, u32 id);
+int cxl_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
+		      struct fwctl_rpc_cxl *rpc_in,
+		      struct cxl_mbox_cmd *mbox_cmd, size_t *out_len);
 
 #endif
diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
index a32c4c752db6..99804fc72f28 100644
--- a/include/uapi/fwctl/cxl.h
+++ b/include/uapi/fwctl/cxl.h
@@ -19,4 +19,33 @@ struct fwctl_info_cxl {
 	__u32 nr_commands;
 };
 
+/**
+ * struct fwctl_rpc_cxl - ioctl(FWCTL_RPC) input for CXL
+ * @id: The command id to send to the memory device. This must be one of the
+ *	commands returned by the query command.
+ * @flags: Flags for the command (input).
+ * @op_size: Size of hw operation
+ * @reserved: Reserved. Must be 0s.
+ * @in_payload: User address of the hardware op input
+ */
+struct fwctl_rpc_cxl {
+	__u32 id;
+	__u32 flags;
+	__u32 op_size;
+	__u32 reserved;
+	__aligned_u64 in_payload;
+};
+
+/**
+ * struct fwctl_rpc_cxl_out - ioctl9FWCTL_RPC) output for CXL
+ * @size: Size of the output payload
+ * @retval: Return value from device
+ * @payload: Return data from device
+ */
+struct fwctl_rpc_cxl_out {
+	__u32 size;
+	__u32 retval;
+	__u8 payload[];
+};
+
 #endif
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 9dd37849c450..4e7c8c03cfe8 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -234,4 +234,16 @@ struct cxl_send_command {
 	} out;
 };
 
+/*
+ * CXL spec r3.1 Table 8-101 Set Feature Input Payload
+ */
+struct cxl_set_feature_input {
+	__u8 uuid[16];
+	__u32 flags;
+	__u16 offset;
+	__u8 version;
+	__u8 reserved[9];
+	__u8 data[];
+} __packed;
+
 #endif
-- 
2.47.0

