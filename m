Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E762C433DB
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Jan 2021 00:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF7D022D58
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Jan 2021 00:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbhALAgR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 11 Jan 2021 19:36:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:52241 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbhALAgO (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 11 Jan 2021 19:36:14 -0500
IronPort-SDR: fjDneUHoWEchY93OxCwWoKoD53DQq+KcMwVggTVTarEqT1Wh8vktf7f49/GKr/znSod8YwYsPx
 6VtpaTh5fqPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157736800"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="157736800"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 16:34:25 -0800
IronPort-SDR: DTgH3onCWBNNmuL4P0Y2H4ylW2IO4OBSEpoBsvh7papa74rKxEAXoxP0f/S09DQlX7l2jkAHKS
 uNAR5tkbZEyA==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="381212102"
Received: from ecbackus-mobl1.amr.corp.intel.com (HELO omniknight.intel.com) ([10.212.212.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 16:34:24 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <linux-nvdimm@lists.01.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl RFC PATCH 4/5] libcxl: add accessors for retrieving 'Identify' information
Date:   Mon, 11 Jan 2021 17:34:02 -0700
Message-Id: <20210112003403.2944568-5-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112003403.2944568-1-vishal.l.verma@intel.com>
References: <20210112003403.2944568-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add APIs to access an incomplete list of fields from the 'Identify'
mailbox command. The fields added are fw_revision, partition_align, and
lsa_size.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/lib/private.h  | 19 +++++++++++++++++++
 cxl/lib/libcxl.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
 cxl/libcxl.h       |  3 +++
 cxl/lib/libcxl.sym |  3 +++
 4 files changed, 69 insertions(+)

diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index c7ebfcb..19f3a37 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -60,6 +60,25 @@ struct cxl_cmd {
 	int status;
 };
 
+#define CXL_CMD_IDENTIFY_FW_REV_LENGTH 0x10
+
+struct cxl_cmd_identify {
+	char fw_revision[CXL_CMD_IDENTIFY_FW_REV_LENGTH];
+	le64 total_capacity;
+	le64 volatile_capacity;
+	le64 persistent_capacity;
+	le64 partition_align;
+	le16 info_event_log_size;
+	le16 warning_event_log_size;
+	le16 failure_event_log_size;
+	le16 fatal_event_log_size;
+	le32 lsa_size;
+	u8 poison_list_max_mer[3];
+	le16 inject_poison_limit;
+	u8 poison_caps;
+	u8 qos_telemetry_caps;
+} __packed;
+
 static inline int check_kmod(struct kmod_ctx *kmod_ctx)
 {
 	return kmod_ctx ? 0 : -ENXIO;
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 02bc316..d54da95 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -13,7 +13,10 @@
 #include <sys/sysmacros.h>
 #include <uuid/uuid.h>
 #include <ccan/list/list.h>
+#include <ccan/endian/endian.h>
+#include <ccan/minmax/minmax.h>
 #include <ccan/array_size/array_size.h>
+#include <ccan/short_types/short_types.h>
 
 #include <cxl_mem.h>
 #include <util/log.h>
@@ -624,6 +627,47 @@ CXL_EXPORT struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev)
 	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_IDENTIFY);
 }
 
+CXL_EXPORT int cxl_cmd_identify_get_fw_rev(struct cxl_cmd *cmd, char *fw_rev,
+		int fw_len)
+{
+	struct cxl_cmd_identify *id = (void *)cmd->send_cmd->out_payload;
+
+	if (cmd->send_cmd->id != CXL_MEM_COMMAND_ID_IDENTIFY)
+		return -EINVAL;
+	if (cmd->status < 0)
+		return cmd->status;
+
+	if (fw_len > 0)
+		memcpy(fw_rev, id->fw_revision,
+			min(fw_len, CXL_CMD_IDENTIFY_FW_REV_LENGTH));
+	return 0;
+}
+
+CXL_EXPORT unsigned long long cxl_cmd_identify_get_partition_align(
+		struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_identify *id = (void *)cmd->send_cmd->out_payload;
+
+	if (cmd->send_cmd->id != CXL_MEM_COMMAND_ID_IDENTIFY)
+		return -EINVAL;
+	if (cmd->status < 0)
+		return cmd->status;
+
+	return le64_to_cpu(id->partition_align);
+}
+
+CXL_EXPORT unsigned int cxl_cmd_identify_get_lsa_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_identify *id = (void *)cmd->send_cmd->out_payload;
+
+	if (cmd->send_cmd->id != CXL_MEM_COMMAND_ID_IDENTIFY)
+		return -EINVAL;
+	if (cmd->status < 0)
+		return cmd->status;
+
+	return le32_to_cpu(id->lsa_size);
+}
+
 CXL_EXPORT struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev)
 {
 	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_RAW);
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 83888bc..caa2e76 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -55,6 +55,9 @@ int cxl_cmd_attach_payloads(struct cxl_cmd *cmd,
 void cxl_cmd_ref(struct cxl_cmd *cmd);
 void cxl_cmd_unref(struct cxl_cmd *cmd);
 int cxl_cmd_submit(struct cxl_cmd *cmd);
+int cxl_cmd_identify_get_fw_rev(struct cxl_cmd *cmd, char *fw_rev, int fw_len);
+unsigned long long cxl_cmd_identify_get_partition_align(struct cxl_cmd *cmd);
+unsigned int cxl_cmd_identify_get_lsa_size(struct cxl_cmd *cmd);
 
 #ifdef __cplusplus
 } /* extern "C" */
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 3583bab..41311d9 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -35,4 +35,7 @@ global:
 	cxl_cmd_ref;
 	cxl_cmd_unref;
 	cxl_cmd_submit;
+	cxl_cmd_identify_get_fw_rev;
+	cxl_cmd_identify_get_partition_align;
+	cxl_cmd_identify_get_lsa_size;
 } LIBCXL_2;
-- 
2.29.2

