Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7D2C433F5
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Jan 2022 20:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiACUPp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Jan 2022 15:15:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:35528 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbiACUPo (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 3 Jan 2022 15:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641240944; x=1672776944;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vpSce1lTgKT2pK64ArjUjZeEgDXBemBfJbRJjODYetM=;
  b=Msmh3q0hO7mnUz5ezkl5slU/p7s8OY/mKJnGLk2tIruTjehQ3yDwvdoC
   2pzH8XL7YDzAS6+mWqsb6Om6G2guMrTWZSwqhpncPZh+KOZdWdo1LKdZ9
   nb62E8bI9EC3EXpyaVmVGNLpgKbQroIWWAAhZdKXjvsa6BloCP0VHMrJy
   pTfnKrKvt/ZVd2zGi3UWDiHfX8EB9wPMVVJKvpLgl9DAUAcl8HsXXFd5j
   fiktrnpxo/uREcF0u4QfgY1Vj6L5NtL6qqU5SanF+nIBNcumtTUVain8L
   VErdDKJ+m1+5eTllcNiG6q1LI/Sy7P6kNm9UOpJObfl2arfAfvaM9aYOk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="222106130"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="222106130"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 12:15:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="525711087"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 12:15:43 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/mbox: Do not allow immediate mode in SET_PARTITION_INFO
Date:   Mon,  3 Jan 2022 12:21:00 -0800
Message-Id: <20220103202100.784194-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

User space may send the SET_PARTITION_INFO mailbox command using
the IOCTL interface. Inspect the input payload and fail if the
immediate flag is set.

This is the first instance of the driver inspecting an input payload
from user space. Assume there will be more such cases and implement
with an extensible helper.

Note: At this time immediate partitioning is not allowed because the
kernel will need to react immediately to this configuration change
and that support is not yet implemented.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c | 43 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    |  7 +++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index be61a0d8016b..2cf5ccdea7df 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -352,6 +352,41 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	return 0;
 }
 
+/**
+ * cxl_payload_from_user_allowed() - Check contents of in_payload.
+ * @opcode: The mailbox command opcode.
+ * @payload_in: Pointer to the input payload passed in from user space.
+ *
+ * Return:
+ *  * true	- payload_in passes check for @opcode.
+ *  * false	- payload_in contains invalid or unsupported values.
+ *
+ * The driver may inspect payload contents before sending a mailbox
+ * command from user space to the device. The intent is to reject
+ * commands with input payloads that are known to be unsafe. This
+ * check is not intended to replace the users careful selection of
+ * mailbox command parameters and makes no guarantee that the user
+ * command will succeed, nor that it is appropriate.
+ *
+ * The specific checks are determined by the opcode.
+ */
+static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
+{
+	switch (opcode) {
+	case CXL_MBOX_OP_SET_PARTITION_INFO: {
+		struct cxl_mbox_set_partition_info *pi;
+
+		pi = (struct cxl_mbox_set_partition_info *)payload_in;
+		if (pi->flags && CXL_SET_PARTITION_IMMEDIATE_FLAG)
+			return false;
+		break;
+	}
+	default:
+		break;
+	}
+	return true;
+}
+
 /**
  * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
  * @cxlds: The device data for the operation
@@ -405,6 +440,14 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
 		}
 	}
 
+	if (!cxl_payload_from_user_allowed(mbox_cmd.opcode,
+					   mbox_cmd.payload_in)) {
+		dev_dbg(dev, "%s: input payload not allowed\n",
+			cxl_command_names[cmd->info.id].name);
+		rc = -EINVAL;
+		goto out;
+	}
+
 	dev_dbg(dev,
 		"Submitting %s command for user\n"
 		"\topcode: %x\n"
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8d96d009ad90..e10b86f06c75 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -231,6 +231,13 @@ struct cxl_mbox_set_lsa {
 	u8 data[];
 } __packed;
 
+struct cxl_mbox_set_partition_info {
+	u64 volatile_capacity;
+	u8 flags;
+} __packed;
+
+#define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI

base-commit: 53989fad1286e652ea3655ae3367ba698da8d2ff
-- 
2.31.1

