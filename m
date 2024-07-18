Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ACC7F7C7
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jul 2024 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338507; cv=none; b=q0q6QymwyggRThNRarq9T2Sox9GBXPmyDp7T8ILrURPAJWxboC/aGeLjICYbWI22B0W8i6E/Sb9wk/sD3fIcH6QBgJt2UZSkH8Aq5uvGSbJ879iRIGAgq7MdfCLiuAl/XdTMJpNAIoVNS0R+WrkWZZ4k1hqrO/5uM5rwkCY6UqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338507; c=relaxed/simple;
	bh=ELhO4Ri5eliG5r3Aan/MfIUGo86krJdj2SlayVcRIPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsgZ/4Yv53IB3cWaQQwx7zL+DwS0YcmPjtI4yRs4g4gt2XE0D1A2U+taW82Q/mjaFacMchyA/cOXdaAFKMqdUVr8xjEY2JqJnO9xZ6DvXDtLSVOuw+RhIX8fT+fPg9p5WgEG+BLjA4Fs37KjdthdPswuNDLQpXesuwtO2jtYah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74694C116B1;
	Thu, 18 Jul 2024 21:35:06 +0000 (UTC)
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
Subject: [RFC PATCH 11/13] fwctl/cxl: Add query commands software command for ->fw_rpc()
Date: Thu, 18 Jul 2024 14:32:29 -0700
Message-ID: <20240718213446.1750135-12-dave.jiang@intel.com>
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

Add a software command through the ->fw_rpc() in order for the user to
retrieve information about the commands that are supported. In this
instance only 3 commands are supported: Get Supported Features, Get
Feature, and Set Feature.

The expected flow of operation is to send the call first with 0 set
to the n_commands parameter to indicate query of total commands
available. And then a second call provides the number of commands
to retrieve with the appropriate amount of memory allocated to store
information about the commands.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c     | 80 +++++++++++++++++++++++++++++++++++++
 drivers/fwctl/cxl/cxl.c     | 42 ++++++++++++++++---
 include/linux/cxl/mailbox.h |  3 ++
 include/uapi/fwctl/cxl.h    |  5 ++-
 4 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d77817e347d8..91be8cfbc2bb 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -655,6 +655,86 @@ int cxl_query_cmd(struct cxl_mailbox *cxl_mbox,
 	return 0;
 }
 
+static bool fwctl_supported_commands(u16 opcode)
+{
+	switch (opcode) {
+	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
+	case CXL_MBOX_OP_GET_FEATURE:
+	case CXL_MBOX_OP_SET_FEATURE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int get_fwctl_supported_commands(void)
+{
+	struct cxl_mem_command *cmd;
+	int cmds = 0;
+
+	cxl_for_each_cmd(cmd) {
+		if (fwctl_supported_commands(cmd->opcode))
+			cmds++;
+	}
+
+	return cmds;
+}
+
+void *cxl_query_cmd_from_fwctl(struct cxl_mailbox *cxl_mbox,
+			       struct cxl_mem_query_commands *q,
+			       size_t *out_len)
+{
+	u32 n_commands = q->n_commands;
+	struct cxl_mem_command *cmd;
+	size_t output_size;
+	int commands;
+	int j = 0;
+
+	commands = get_fwctl_supported_commands();
+	if (n_commands > commands)
+		return ERR_PTR(-EINVAL);
+
+	output_size = sizeof(struct cxl_mem_query_commands) +
+		      n_commands * sizeof(struct cxl_command_info);
+
+	struct cxl_mem_query_commands *qout __free(kvfree) =
+		kvzalloc(output_size, GFP_KERNEL);
+
+	if (!qout)
+		return ERR_PTR(-ENOMEM);
+
+	*out_len = output_size;
+	if (n_commands == 0) {
+		qout->n_commands = commands;
+		return no_free_ptr(qout);
+	}
+
+	qout->n_commands = n_commands;
+
+	/*
+	 * otherwise, return min(n_commands, total commands) cxl_command_info
+	 * structures.
+	 */
+	cxl_for_each_cmd(cmd) {
+		struct cxl_command_info info = cmd->info;
+
+		if (fwctl_supported_commands(cmd->opcode)) {
+			if (test_bit(info.id, cxl_mbox->enabled_cmds))
+				info.flags |= CXL_MEM_COMMAND_FLAG_ENABLED;
+			if (test_bit(info.id, cxl_mbox->exclusive_cmds))
+				info.flags |= CXL_MEM_COMMAND_FLAG_EXCLUSIVE;
+
+			memcpy(&qout->commands[j++], &info, sizeof(info));
+		}
+
+		if (j == n_commands)
+			break;
+	}
+
+	return no_free_ptr(qout);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_query_cmd_from_fwctl, CXL);
+
 /**
  * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
  * @mailbox: The mailbox context for the operation.
diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
index 01f0771148e1..8836a806763f 100644
--- a/drivers/fwctl/cxl/cxl.c
+++ b/drivers/fwctl/cxl/cxl.c
@@ -135,6 +135,24 @@ static bool cxlctl_validate_hw_cmds(struct cxl_mailbox *cxl_mbox,
 	return false;
 }
 
+static bool cxlctl_validate_query_commands(struct fwctl_rpc_cxl *rpc_in)
+{
+	int cmds;
+
+	if (rpc_in->payload_size < sizeof(rpc_in->query))
+		return false;
+
+	cmds = rpc_in->query.n_commands;
+	if (cmds) {
+		int cmds_size = rpc_in->payload_size - sizeof(rpc_in->query);
+
+		if (cmds != cmds_size / sizeof(struct cxl_command_info))
+			return false;
+	}
+
+	return true;
+}
+
 static bool cxlctl_validate_rpc(struct fwctl_uctx *uctx,
 				struct fwctl_rpc_cxl *rpc_in,
 				enum fwctl_rpc_scope scope)
@@ -142,10 +160,17 @@ static bool cxlctl_validate_rpc(struct fwctl_uctx *uctx,
 	struct cxlctl_dev *cxlctl =
 		container_of(uctx->fwctl, struct cxlctl_dev, fwctl);
 
-	if (rpc_in->rpc_cmd != FWCTL_CXL_SEND_COMMAND)
+	switch (rpc_in->rpc_cmd) {
+	case FWCTL_CXL_QUERY_COMMANDS:
+		return cxlctl_validate_query_commands(rpc_in);
+
+	case FWCTL_CXL_SEND_COMMAND:
+		return cxlctl_validate_hw_cmds(cxlctl->mbox,
+					       &rpc_in->send_cmd, scope);
+
+	default:
 		return false;
-
-	return cxlctl_validate_hw_cmds(cxlctl->mbox, &rpc_in->send_cmd, scope);
+	}
 }
 
 static void *send_cxl_command(struct cxl_mailbox *cxl_mbox,
@@ -175,10 +200,17 @@ static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
 	if (!cxlctl_validate_rpc(uctx, rpc_in, scope))
 		return ERR_PTR(-EPERM);
 
-	if (rpc_in->rpc_cmd == FWCTL_CXL_SEND_COMMAND)
+	switch (rpc_in->rpc_cmd) {
+	case FWCTL_CXL_QUERY_COMMANDS:
+		return cxl_query_cmd_from_fwctl(cxl_mbox, &rpc_in->query,
+						out_len);
+
+	case FWCTL_CXL_SEND_COMMAND:
 		return send_cxl_command(cxl_mbox, &rpc_in->send_cmd, out_len);
 
-	return ERR_PTR(-EOPNOTSUPP);
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
 }
 
 static const struct fwctl_ops cxlctl_ops = {
diff --git a/include/linux/cxl/mailbox.h b/include/linux/cxl/mailbox.h
index b3c74f3da9a5..13b5bb6e5bc3 100644
--- a/include/linux/cxl/mailbox.h
+++ b/include/linux/cxl/mailbox.h
@@ -168,5 +168,8 @@ int cxl_fwctl_send_cmd(struct cxl_mailbox *cxl_mbox,
 		       struct fwctl_cxl_command *fwctl_cmd,
 		       struct cxl_mbox_cmd *mbox_cmd,
 		       size_t *out_len);
+void *cxl_query_cmd_from_fwctl(struct cxl_mailbox *cxl_mbox,
+			       struct cxl_mem_query_commands *q,
+			       size_t *out_len);
 
 #endif
diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
index de8949a28473..a439f497b889 100644
--- a/include/uapi/fwctl/cxl.h
+++ b/include/uapi/fwctl/cxl.h
@@ -77,7 +77,10 @@ struct fwctl_rpc_cxl {
 	__u32 payload_size;
 	__u32 version;
 	__u32 rsvd;
-	struct fwctl_cxl_command send_cmd;
+	union {
+		struct cxl_mem_query_commands query;
+		struct fwctl_cxl_command send_cmd;
+	};
 };
 
 struct fwctl_rpc_cxl_out {
-- 
2.45.2

