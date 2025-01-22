Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955EC1CDA3F
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589926; cv=none; b=kNoS7DDF3F2v906/sSUDywOrNuk1sL47SjMKA1oKZEC3dEpTiyAwOje5+ig1us1IoLjrllPaL7tKQXseck+yg1frR4owCNIe1Z1W5+feUTHL7yuQOmrQItBonzPrh+PnBrLcAOcQ3dEPRd71PdJ0r3bY5CDDtTtUWgT2L2ef+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589926; c=relaxed/simple;
	bh=Pm2JxZLpVDeZ1ooGqG9Ivm6dKr1gi6blJJW4Z7deD1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYvj+PxAsEyl1Ks58jN8TIbM9w8dFPv/tI2fyzG5wOZ+HfOVcpgyXmD6Tcl9q+LvwMo+mEQrsAQnSenFB0k3FTDwr5a0zihEwh0FKzinMc+uDH5ya+7xESCeSKSK2BkBc97Wt9lKTiovqx97CBUAFNucQJEy3g302hD4dwpNaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5043FC4CED2;
	Wed, 22 Jan 2025 23:52:06 +0000 (UTC)
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
Subject: [PATCH v1 03/19] cxl: Enumerate feature commands
Date: Wed, 22 Jan 2025 16:50:34 -0700
Message-ID: <20250122235159.2716036-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122235159.2716036-1-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add feature commands enumeration code in order to detect and enumerate
the 3 feature related commands "get supported features", "get feature",
and "set feature". The enumeration will help determine whether the driver
can issue any of the 3 commands to the device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    |  3 +++
 include/cxl/features.h  |  7 +++++++
 include/cxl/mailbox.h   |  1 +
 4 files changed, 52 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index bdb8f060f2c1..5e21ff99d70f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -38,6 +38,21 @@ static bool cxl_raw_allow_all;
 	.flags = _flags,                                                       \
 	}
 
+#define cxl_for_each_feature_cmd(cmd)                                          \
+	for ((cmd) = &cxl_feature_commands[0];                                 \
+	     ((cmd) - cxl_feature_commands) < ARRAY_SIZE(cxl_feature_commands); (cmd)++)
+
+#define CXL_FEATURE_CMD(_id, sin, sout, _flags)                                \
+	[CXL_FEATURE_ID_##_id] = {                                             \
+	.info =	{                                                              \
+			.id = CXL_FEATURE_ID_##_id,                            \
+			.size_in = sin,                                        \
+			.size_out = sout,                                      \
+		},                                                             \
+	.opcode = CXL_MBOX_OP_##_id,                                           \
+	.flags = _flags,                                                       \
+	}
+
 #define CXL_VARIABLE_PAYLOAD	~0U
 /*
  * This table defines the supported mailbox commands for the driver. This table
@@ -69,6 +84,13 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
 };
 
+#define CXL_FEATURE_COMMAND_ID_MAX 3
+static struct cxl_mem_command cxl_feature_commands[CXL_FEATURE_COMMAND_ID_MAX] = {
+	CXL_FEATURE_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
+	CXL_FEATURE_CMD(GET_FEATURE, 0xf, CXL_VARIABLE_PAYLOAD, 0),
+	CXL_FEATURE_CMD(SET_FEATURE, CXL_VARIABLE_PAYLOAD, 0, 0),
+};
+
 /*
  * Commands that RAW doesn't permit. The rationale for each:
  *
@@ -212,6 +234,17 @@ static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
 	return NULL;
 }
 
+static struct cxl_mem_command *cxl_find_feature_command(u16 opcode)
+{
+	struct cxl_mem_command *c;
+
+	cxl_for_each_feature_cmd(c)
+		if (c->opcode == opcode)
+			return c;
+
+	return NULL;
+}
+
 static const char *cxl_mem_opcode_to_name(u16 opcode)
 {
 	struct cxl_mem_command *c;
@@ -734,6 +767,14 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		if (cmd) {
 			set_bit(cmd->info.id, cxl_mbox->enabled_cmds);
 			enabled++;
+		} else {
+			struct cxl_mem_command *fcmd =
+				cxl_find_feature_command(opcode);
+
+			if (fcmd) {
+				set_bit(fcmd->info.id, cxl_mbox->feature_cmds);
+				enabled++;
+			}
 		}
 
 		if (cxl_is_poison_command(opcode)) {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a0a49809cd76..55c55685cb39 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -490,6 +490,9 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
 	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
+	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
+	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
diff --git a/include/cxl/features.h b/include/cxl/features.h
index b92da1e92780..7a8be3c621a1 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -5,6 +5,13 @@
 
 struct cxl_mailbox;
 
+enum feature_cmds {
+	CXL_FEATURE_ID_GET_SUPPORTED_FEATURES = 0,
+	CXL_FEATURE_ID_GET_FEATURE,
+	CXL_FEATURE_ID_SET_FEATURE,
+	CXL_FEATURE_ID_MAX,
+};
+
 struct cxl_features {
 	int id;
 	struct device dev;
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index 6caab0d406ba..263fc346aeb1 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -58,6 +58,7 @@ struct cxl_mailbox {
 	struct device *host;
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
 	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
+	DECLARE_BITMAP(feature_cmds, CXL_FEATURE_ID_MAX);
 	size_t payload_size;
 	struct mutex mbox_mutex; /* lock to protect mailbox context */
 	struct rcuwait mbox_wait;
-- 
2.47.1

