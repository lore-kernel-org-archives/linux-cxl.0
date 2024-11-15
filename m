Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458551FB3FE
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706088; cv=none; b=FMfVIRQ+/gLynHDmMF0FCPkUfTQC0I6g/rPF83K5VybIg1qnpxQg+VLC1q7Mn1m7xdrKniwZGiNsPjhcfZ5kWwN9pH4sqxHhvy36hMc88hOHW/oUl5O+cRsykbGJ0BrPZNqt0654msMyLnJrhASBSMVv/w9pSdMk1JfAK4Wqa0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706088; c=relaxed/simple;
	bh=vvlGqONTOfplpuACSyO+2rCQkLOT2wlGxjI1c5lebns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dblj340Zvawqd1t4zNVqTP4wH24Nr3A7zJRPwQoYHEBa8hunD67OA5vgE5YSWxpWvyImGnq95qd8cTPPDct/Gr3dN6KaPvS6A+ctatRou8NYfUchA4hHGGiFQfzftf4+V0Eq5y0WFMT01UXQCT38Eo5ZmUy1FrCMoVVYPst+JNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0183AC4CECF;
	Fri, 15 Nov 2024 21:28:07 +0000 (UTC)
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
Subject: [RFC PATCH v2 14/20] cxl: Move defines and error codes from cxlmem.h to cxl/mailbox.h
Date: Fri, 15 Nov 2024 14:25:47 -0700
Message-ID: <20241115212745.869552-15-dave.jiang@intel.com>
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

Moving some internal definitions to cxl/mailbox.h in order to be accessed
by FWCTL CXL driver.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxlmem.h         |  83 ---------------------------
 include/cxl/mailbox.h        | 106 +++++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/mem.c |   2 +-
 3 files changed, 107 insertions(+), 84 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2c15817c80a5..890ed3199235 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -473,53 +473,6 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
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
@@ -717,30 +670,6 @@ struct cxl_mbox_clear_poison {
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
@@ -783,18 +712,6 @@ struct cxl_mbox_get_sup_feats_in {
 	u8 reserved[2];
 } __packed;
 
-struct cxl_feat_entry {
-	uuid_t uuid;
-	__le16 id;
-	__le16 get_feat_size;
-	__le16 set_feat_size;
-	__le32 flags;
-	u8 get_feat_ver;
-	u8 set_feat_ver;
-	__le16 set_effects;
-	u8 reserved[18];
-} __packed;
-
 struct cxl_mbox_get_sup_feats_out {
 	__le16 num_entries;
 	__le16 supported_feats;
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index f48eebb855f7..e753d5d1d708 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -4,6 +4,7 @@
 #define __CXL_MBOX_H__
 #include <linux/rcuwait.h>
 #include <linux/auxiliary_bus.h>
+#include <uapi/fwctl/cxl.h>
 #include <uapi/linux/cxl_mem.h>
 
 /**
@@ -83,6 +84,111 @@ struct cxl_mailbox {
 	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
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
+/**
+ * struct cxl_feat_entry - CXL Spec r3.1 Table 8-97
+ * @uuid: Feature identifier
+ * @id: Feature Index
+ * @get_feat_size: Get Feature Size
+ * @set_feat_size: Set Feature Size
+ * @flags: Attribute Flags
+ * @get_feat_ver: Get Feature Version
+ * @set_feat_ver: Set Feature Version
+ * @reserved: reserved, must be 0
+ */
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
 int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host);
 int cxl_mailbox_user_commands_supported(struct cxl_mailbox *cxl_mbox);
 int cxl_mailbox_user_commands_info_get(struct cxl_mailbox *cxl_mbox, int nr_cmds,
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index e0c7e49795ed..9103bac054b9 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1354,7 +1354,7 @@ static void fill_feature_vendor_test(struct cxl_feat_entry *feat)
 	feat->flags = cpu_to_le32(BIT(5));
 	feat->get_feat_ver = 1;
 	feat->set_feat_ver = 1;
-	feat->set_effects = cpu_to_le16(BIT(0) | BIT(9));
+	feat->effects = cpu_to_le16(BIT(0) | BIT(9));
 }
 
 static int mock_get_supported_features(struct cxl_mockmem_data *mdata,
-- 
2.47.0

