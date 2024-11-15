Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D871A1FB3F5
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706086; cv=none; b=UHQcUJ7Y39Uu3wh/a4dNyB5sy4UnH3W73hifTzTQj1eS4KUIj1PzDvLuve3SwVgOQm4xmOW+I1lSVKR1JX0bOJROnPR2pv0vkXoShIfxji3C1LOWNrISHe9KowReq8jNjmpOvo+1QIoDDrDW19d9fHnT6sjC8z6rRr4IL5AhpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706086; c=relaxed/simple;
	bh=8DrqE4E084lX6hxn4sbU1M2i5AiIWgGsLS8TQJS2ewY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRTRtgaXfJ9OIbKTQDTRhyhOydPE0zaj1RQJnKHX0v1WQMQkcqtslI80OvRJl7oxrs53goHMMq4IdLVDww6qIjdD6v5SqJMlj3TM59BtOiqqe88V75GUtu1CAx6IONN0TZkgLzVUWC1N1NNkcS7FHLbVcn0OqQGTdfPJ2C6JtFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F5BC4CED4;
	Fri, 15 Nov 2024 21:28:06 +0000 (UTC)
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
Subject: [RFC PATCH v2 13/20] fwctl/cxl: Add hw_info callback
Date: Fri, 15 Nov 2024 14:25:46 -0700
Message-ID: <20241115212745.869552-14-dave.jiang@intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c | 42 +++++++++++++++++++++++++++++++++++++++++
 drivers/fwctl/cxl/cxl.c | 25 ++++++++++++++++++++++++
 include/cxl/mailbox.h   |  2 ++
 3 files changed, 69 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index fba6bdd30a82..65fceabb9fe7 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -9,6 +9,8 @@
 #include <cxlmem.h>
 #include <cxl.h>
 
+#include <uapi/fwctl/fwctl.h>
+
 #include "core.h"
 #include "trace.h"
 
@@ -573,6 +575,46 @@ int cxl_mailbox_user_commands_supported(struct cxl_mailbox *cxl_mbox)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mailbox_user_commands_supported, CXL);
 
+/**
+ * cxl_mailbox_user_commands_info_get() - Retrieve array of command info
+ * @cxl_mbox: cxl mailbox context
+ * @nr_cmds: number of commands to retrieve
+ * @outbuf: Output buffer to store array 'struct fwctl_command_info'
+ * @out_len: size of final output buffer
+ *
+ * Return: 0 for success, or -errno for failure.
+ */
+int cxl_mailbox_user_commands_info_get(struct cxl_mailbox *cxl_mbox, int nr_cmds,
+				       void *outbuf, size_t *out_len)
+{
+	struct fwctl_command_info *entry;
+	struct cxl_command_info *info;
+	struct cxl_mem_command *cmd;
+
+	if (nr_cmds > FWCTL_CXL_MAX_COMMANDS)
+		return -EINVAL;
+
+	entry = outbuf;
+	for (int i = 0; i < nr_cmds; i++) {
+		cmd = fwctl_cxl_find_command(cxl_mbox, fwctl_command_sets[i]);
+		if (!cmd)
+			continue;
+		info = &cmd->info;
+		memset(entry, 0, sizeof(*entry));
+		entry->id = info->id;
+		entry->opcode = fwctl_command_sets[i];
+		entry->effects = info->effects;
+		entry->size_in = info->size_in;
+		entry->size_out = info->size_out;
+		entry++;
+	}
+
+	*out_len = sizeof(*entry) * nr_cmds;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mailbox_user_commands_info_get, CXL);
+
 int cxl_query_cmd(struct cxl_mailbox *cxl_mbox,
 		  struct cxl_mem_query_commands __user *q)
 {
diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
index 5eb5eabf2bff..ce8960a9beaa 100644
--- a/drivers/fwctl/cxl/cxl.c
+++ b/drivers/fwctl/cxl/cxl.c
@@ -53,6 +53,30 @@ static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
 	return info;
 }
 
+static void *cxlctl_hw_info(struct fwctl_uctx *uctx, int commands, size_t *out_len)
+{
+	struct cxlctl_uctx *cxlctl_uctx =
+		container_of(uctx, struct cxlctl_uctx, uctx);
+	struct fwctl_device *fwctl = uctx->fwctl;
+	struct cxlctl_dev *cxlctl =
+		container_of(fwctl, struct cxlctl_dev, fwctl);
+	int rc;
+
+	if (commands > cxlctl_uctx->nr_commands)
+		return ERR_PTR(-EINVAL);
+
+	void *out __free(kvfree) = kvzalloc(*out_len, GFP_KERNEL);
+	if (!out)
+		return ERR_PTR(-ENOMEM);
+
+	rc = cxl_mailbox_user_commands_info_get(cxlctl->mbox,
+						commands, out, out_len);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return_ptr(out);
+}
+
 static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
 			   void *rpc_in, size_t in_len, size_t *out_len)
 {
@@ -66,6 +90,7 @@ static const struct fwctl_ops cxlctl_ops = {
 	.open_uctx = cxlctl_open_uctx,
 	.close_uctx = cxlctl_close_uctx,
 	.info = cxlctl_info,
+	.hw_info = cxlctl_hw_info,
 	.fw_rpc = cxlctl_fw_rpc,
 };
 
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index af01fb78ae10..f48eebb855f7 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -85,5 +85,7 @@ struct cxl_mailbox {
 
 int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host);
 int cxl_mailbox_user_commands_supported(struct cxl_mailbox *cxl_mbox);
+int cxl_mailbox_user_commands_info_get(struct cxl_mailbox *cxl_mbox, int nr_cmds,
+				       void *outbuf, size_t *out_len);
 
 #endif
-- 
2.47.0

