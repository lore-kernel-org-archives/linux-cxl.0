Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB71C43219
	for <linux-cxl@archiver.kernel.org>; Thu, 24 Mar 2022 01:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347073AbiCXBK0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347078AbiCXBKZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Mar 2022 21:10:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E87F53715
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 18:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648084134; x=1679620134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mR9kozMzyNab8fkSgrK8PeuhFBgfds5py8h23HMOil4=;
  b=AwdkJRUEQEyZJzSaI+3zYcsgRDjrNkbcpIZ+QACoFM65cszDBkE8WbAC
   WxvONdqjE9oJrSPdj7S/vatudABzNCel8QtYNFX96qVjepGcIQAjllQyz
   qap3fQl8xh+8rVFi4KAjog2bxeP6T9c775YPbf1bH0mT68eLLqwFFqQVo
   kCZs1uu3n0fQOkCzT7D9YIC2sOTBt7rTQ1eCwmRM79gwSoh3lCYk1udoY
   RN1aoDhDrJsg0lnFlMsH1tX5wydJDw1MxDnX+LpdJhdQv84oRAnuRUh46
   WFo3tF87VtG8xIOcd61t/HOPpeR68wVspMGTHigGveyQTHOLh1JhuPlqH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258215010"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258215010"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="693142837"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:53 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3 8/9] cxl/mbox: Block immediate mode in SET_PARTITION_INFO command
Date:   Wed, 23 Mar 2022 18:11:25 -0700
Message-Id: <20220324011126.1144504-9-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324011126.1144504-1-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
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
 drivers/cxl/core/mbox.c | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    |  7 +++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index c323d6792405..1930e203061d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -218,6 +218,40 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
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
 static int cxl_to_mbox_cmd(struct cxl_dev_state *cxlds,
 			   struct cxl_mbox_cmd *mbox, u16 opcode,
 			   size_t in_size, size_t out_size, u64 in_payload)
@@ -235,6 +269,13 @@ static int cxl_to_mbox_cmd(struct cxl_dev_state *cxlds,
 	if (!mbox->payload_in)
 		return PTR_ERR(mbox->payload_in);
 
+	if (!cxl_payload_from_user_allowed(opcode, mbox->payload_in)) {
+		dev_dbg(cxlds->dev, "%s: input payload not allowed\n",
+			cxl_mem_opcode_to_name(opcode));
+		kvfree(mbox->payload_in);
+		return -EBUSY;
+	}
+
 size_out:
 	/* Prepare to handle a full payload for variable sized output */
 	if (out_size < 0)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index d5c9a273d07d..dee574527e50 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -264,6 +264,13 @@ struct cxl_mbox_set_lsa {
 	u8 data[];
 } __packed;
 
+struct cxl_mbox_set_partition_info {
+	__le64 volatile_capacity;
+	u8 flags;
+} __packed;
+
+#define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
-- 
2.31.1

