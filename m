Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58B5C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Apr 2022 05:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiDNFNT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Apr 2022 01:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiDNFNT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Apr 2022 01:13:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297AABBD
        for <linux-cxl@vger.kernel.org>; Wed, 13 Apr 2022 22:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649913055; x=1681449055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yT7f996vvQDmcdCjPGP37/oscx9L0iGJllr3lu6v67k=;
  b=lw8BG2xOJcvpFg4D9uWtTJMuP8al15r55eFToNv/uMeGfKbAHEDHfE/l
   8X0of/3QvzbH9BhifWyqdxolfit0/SAZ6EiI5B2fddur0+dU33ig74jor
   hZ9P2HC8/xIdtjOXAYmVJYqqqZcbpHnRZnFQietQIFx9WcojQCPQO/bzz
   W8jvK+4VXkbdTryRJqvotK3ueHoEZmBV/AljMMe16j/Ui0uJM7emlvmO9
   /pWgbQHaolth4kpm/1x4nwf+g9O8VwXGYx9MEAg5IX94VvtsTdzqT7rqJ
   3bHhkdPVZCfjR6fXRyor94kvOFB/Kayag38bDiyQQlQhtOhaXfdOyUsLq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262601153"
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="262601153"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 22:10:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="573604413"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 22:10:54 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3] cxl/mbox: Use type __u32 for mailbox payload sizes
Date:   Wed, 13 Apr 2022 22:12:46 -0700
Message-Id: <20220414051246.1244575-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Payload sizes for mailbox commands are expected to be positive values
coming from userspace. The documentation correctly describes these as
always unsigned values. The mailbox and send structures that support
the mailbox commands however, use __s32 types for the payloads.

Replace  __s32 with __u32 in the mailbox and send command structures
and update usages.

Kernel users of the interface already block all negative values and
there is no known ability for userspace to have grown a dependency on
submitting negative values to the kernel. The known user of the IOCTL,
the CXL command line interface (cxl-cli) already enforces positive
size values.

A Smatch warning of a signedness uncovered this issue.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v3:
- Toss v2 changes addressing signedness
- Replace __s32 with __u32 in mbox and send command structures (Ben)
- Update commit message and log
  Was 'Restore signedness to a mailbox payload variable'

Changes in v2:
- Pass the payload sizes as signed rather than move the check (Dan)
- Signedness is now discarded on ssize_t to size_t assignment.
- Update commit msg. Was 'Handle variable size output while still
  signed'
- Update commit log.

 drivers/cxl/core/mbox.c      | 28 +++++++++++++++-------------
 include/uapi/linux/cxl_mem.h | 14 +++++++-------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 8a8388599a85..d54a6d175fff 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -35,6 +35,7 @@ static bool cxl_raw_allow_all;
 	.flags = _flags,                                                       \
 	}
 
+#define CXL_VARIABLE_PAYLOAD	~0U
 /*
  * This table defines the supported mailbox commands for the driver. This table
  * is made up of a UAPI structure. Non-negative values as parameters in the
@@ -44,26 +45,26 @@ static bool cxl_raw_allow_all;
 static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(IDENTIFY, 0, 0x43, CXL_CMD_FLAG_FORCE_ENABLE),
 #ifdef CONFIG_CXL_MEM_RAW_COMMANDS
-	CXL_CMD(RAW, ~0, ~0, 0),
+	CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
 #endif
-	CXL_CMD(GET_SUPPORTED_LOGS, 0, ~0, CXL_CMD_FLAG_FORCE_ENABLE),
+	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
 	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
 	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
-	CXL_CMD(GET_LSA, 0x8, ~0, 0),
+	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
 	CXL_CMD(GET_HEALTH_INFO, 0, 0x12, 0),
-	CXL_CMD(GET_LOG, 0x18, ~0, CXL_CMD_FLAG_FORCE_ENABLE),
+	CXL_CMD(GET_LOG, 0x18, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
 	CXL_CMD(SET_PARTITION_INFO, 0x0a, 0, 0),
-	CXL_CMD(SET_LSA, ~0, 0, 0),
+	CXL_CMD(SET_LSA, CXL_VARIABLE_PAYLOAD, 0, 0),
 	CXL_CMD(GET_ALERT_CONFIG, 0, 0x10, 0),
 	CXL_CMD(SET_ALERT_CONFIG, 0xc, 0, 0),
 	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
 	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
-	CXL_CMD(GET_POISON, 0x10, ~0, 0),
+	CXL_CMD(GET_POISON, 0x10, CXL_VARIABLE_PAYLOAD, 0),
 	CXL_CMD(INJECT_POISON, 0x8, 0, 0),
 	CXL_CMD(CLEAR_POISON, 0x48, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
 	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
-	CXL_CMD(GET_SCAN_MEDIA, 0, ~0, 0),
+	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
 };
 
 /*
@@ -187,9 +188,10 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
 	 * Variable sized commands can't be validated and so it's up to the
 	 * caller to do that if they wish.
 	 */
-	if (cmd->info.size_out >= 0 && mbox_cmd.size_out != out_size)
-		return -EIO;
-
+	if (cmd->info.size_out != CXL_VARIABLE_PAYLOAD) {
+		if (mbox_cmd.size_out != out_size)
+			return -EIO;
+	}
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mbox_send_cmd, CXL);
@@ -275,7 +277,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
 	}
 
 	/* Prepare to handle a full payload for variable sized output */
-	if (out_size < 0)
+	if (out_size == CXL_VARIABLE_PAYLOAD)
 		mbox->size_out = cxlds->payload_size;
 	else
 		mbox->size_out = out_size;
@@ -353,11 +355,11 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
 		return -EBUSY;
 
 	/* Check the input buffer is the expected size */
-	if (info->size_in >= 0 && info->size_in != send_cmd->in.size)
+	if (info->size_in != send_cmd->in.size)
 		return -ENOMEM;
 
 	/* Check the output buffer is at least large enough */
-	if (info->size_out >= 0 && send_cmd->out.size < info->size_out)
+	if (send_cmd->out.size < info->size_out)
 		return -ENOMEM;
 
 	*mem_cmd = (struct cxl_mem_command) {
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 8d206f27bb6d..c71021a2a9ed 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -68,8 +68,8 @@ static const struct {
  * struct cxl_command_info - Command information returned from a query.
  * @id: ID number for the command.
  * @flags: Flags that specify command behavior.
- * @size_in: Expected input size, or -1 if variable length.
- * @size_out: Expected output size, or -1 if variable length.
+ * @size_in: Expected input size, or ~0 if variable length.
+ * @size_out: Expected output size, or ~0 if variable length.
  *
  * Represents a single command that is supported by both the driver and the
  * hardware. This is returned as part of an array from the query ioctl. The
@@ -78,7 +78,7 @@ static const struct {
  *
  *  - @id = 10
  *  - @flags = 0
- *  - @size_in = -1
+ *  - @size_in = ~0
  *  - @size_out = 0
  *
  * See struct cxl_mem_query_commands.
@@ -89,8 +89,8 @@ struct cxl_command_info {
 	__u32 flags;
 #define CXL_MEM_COMMAND_FLAG_MASK GENMASK(0, 0)
 
-	__s32 size_in;
-	__s32 size_out;
+	__u32 size_in;
+	__u32 size_out;
 };
 
 /**
@@ -169,13 +169,13 @@ struct cxl_send_command {
 	__u32 retval;
 
 	struct {
-		__s32 size;
+		__u32 size;
 		__u32 rsvd;
 		__u64 payload;
 	} in;
 
 	struct {
-		__s32 size;
+		__u32 size;
 		__u32 rsvd;
 		__u64 payload;
 	} out;

base-commit: 7dc1d11d7abae52aada5340fb98885f0ddbb7c37
-- 
2.31.1

