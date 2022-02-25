Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35F5C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Feb 2022 20:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbiBYU2K (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbiBYU2I (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Feb 2022 15:28:08 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2690F6D873
        for <linux-cxl@vger.kernel.org>; Fri, 25 Feb 2022 12:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645820855; x=1677356855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fyhnqDCUnI/UcszZVraCex4DH46dZXpE5dHPVRO42KM=;
  b=K+yxUEqLobgYoEFWwwNjGuHfg9loT514lVA52KM5UbXox0PL7LJuaqZb
   PimwqkatU9Z27wIS8sFgtNlT4n5vlyma+BQVIq4N0BNd7SqHoctI1NRB4
   7kG9JH/lZ/wgFamPZn7outJ32oBa0rfj1G7LDmylR3DseUt9omzuWf0OO
   HVxkKhkz0k28CjZTwTFwdrJETa61wB30/RGHQcqn5cHHm/BX4Tf1VpurV
   6tVLiVPX4MdnABmbv2Gz9bstgYLFEts5rB+dpz7sU0/G12oxB44GkOE2E
   7ryvsNFIlAhURTQj9LPWdWa3omCjP7h4c3dC8MnrdKE2sYdZW6exp9QzK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="232546069"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="232546069"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 12:27:32 -0800
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="607868808"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 12:27:32 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2 3/4] cxl/mbox: Block immediate mode in SET_PARTITION_INFO command
Date:   Fri, 25 Feb 2022 12:31:00 -0800
Message-Id: <a4daafc4b537a0b1a673c55300da7747784c4573.1645817416.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1645817416.git.alison.schofield@intel.com>
References: <cover.1645817416.git.alison.schofield@intel.com>
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

In order for the kernel to react to an immediate partition change it
needs to assert that the change will not affect any active decode. At
a minimum this requires validating that the device is using HDM
decoders instead of the CXL DVSEC for decode, and that none of the
active HDM decoders are affected by the partition change. For now,
just fail until that support arrives.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c | 42 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    |  7 +++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e0140864a9fd..b49341d7b126 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -207,6 +207,40 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
 	return true;
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
+		struct cxl_mbox_set_partition_info *pi = payload_in;
+
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
 static int cxl_to_mem_cmd_raw(struct cxl_dev_state *cxlds,
 			      const struct cxl_send_command *send_cmd,
 			      struct cxl_mem_command *mem_cmd)
@@ -336,6 +370,14 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
 	if (IS_ERR(mbox_cmd->payload_in))
 		return PTR_ERR(mbox_cmd->payload_in);
 
+	if (!cxl_payload_from_user_allowed(mbox_cmd->opcode,
+					   mbox_cmd->payload_in)) {
+		dev_dbg(cxlds->dev, "%s: input payload not allowed\n",
+			cxl_command_names[mem_cmd.info.id].name);
+		kvfree(mbox_cmd->payload_in);
+		return -EBUSY;
+	}
+
 size_out:
 	/* Prepare to handle a full payload for variable sized output */
 	if (mem_cmd.info.size_out < 0)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index d5c9a273d07d..db3c20e29def 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -264,6 +264,13 @@ struct cxl_mbox_set_lsa {
 	u8 data[];
 } __packed;
 
+struct cxl_mbox_set_partition_info {
+	u64 volatile_capacity;
+	u8 flags;
+} __packed;
+
+#define  CXL_SET_PARTITION_IMMEDIATE_FLAG      BIT(0)
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
-- 
2.31.1

