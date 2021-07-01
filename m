Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7C7C11F6F
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jul 2021 20:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5FB061410
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jul 2021 20:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhGAUMy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jul 2021 16:12:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:63963 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233902AbhGAUMy (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 1 Jul 2021 16:12:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="208653228"
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="208653228"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 13:10:19 -0700
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="409271356"
Received: from anandvig-mobl.amr.corp.intel.com (HELO vverma7-desk.amr.corp.intel.com) ([10.254.38.85])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 13:10:18 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v3 10/21] libcxl: add support for the 'GET_LSA' command
Date:   Thu,  1 Jul 2021 14:09:54 -0600
Message-Id: <20210701201005.3065299-11-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210701201005.3065299-1-vishal.l.verma@intel.com>
References: <20210701201005.3065299-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a command allocator and accessor APIs for the 'GET_LSA' mailbox
command.

Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/lib/private.h  |  5 +++++
 cxl/lib/libcxl.c   | 31 +++++++++++++++++++++++++++++++
 cxl/libcxl.h       |  3 +++
 cxl/lib/libcxl.sym |  2 ++
 4 files changed, 41 insertions(+)

diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 2232f4c..fb1dd8e 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -73,6 +73,11 @@ struct cxl_cmd_identify {
 	u8 qos_telemetry_caps;
 } __attribute__((packed));
 
+struct cxl_cmd_get_lsa_in {
+	le32 offset;
+	le32 length;
+} __attribute__((packed));
+
 struct cxl_cmd_get_health_info {
 	u8 health_status;
 	u8 media_status;
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 2e33c5e..d2c38c9 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -799,6 +799,37 @@ CXL_EXPORT struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev,
 	return cmd;
 }
 
+CXL_EXPORT struct cxl_cmd *cxl_cmd_new_get_lsa(struct cxl_memdev *memdev,
+		unsigned int offset, unsigned int length)
+{
+	struct cxl_cmd_get_lsa_in *get_lsa;
+	struct cxl_cmd *cmd;
+
+	cmd = cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_GET_LSA);
+	if (!cmd)
+		return NULL;
+
+	get_lsa = (void *)cmd->send_cmd->in.payload;
+	get_lsa->offset = cpu_to_le32(offset);
+	get_lsa->length = cpu_to_le32(length);
+	return cmd;
+}
+
+#define cmd_get_void(cmd, N) \
+do { \
+	void *p = (void *)cmd->send_cmd->out.payload; \
+	if (cmd->send_cmd->id != CXL_MEM_COMMAND_ID_##N) \
+		return NULL; \
+	if (cmd->status < 0) \
+		return NULL; \
+	return p; \
+} while(0);
+
+CXL_EXPORT void *cxl_cmd_get_lsa_get_payload(struct cxl_cmd *cmd)
+{
+	cmd_get_void(cmd, GET_LSA);
+}
+
 CXL_EXPORT int cxl_cmd_submit(struct cxl_cmd *cmd)
 {
 	struct cxl_memdev *memdev = cmd->memdev;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 56ae4af..6edbd8d 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -71,6 +71,9 @@ int cxl_cmd_get_health_info_get_temperature(struct cxl_cmd *cmd);
 int cxl_cmd_get_health_info_get_dirty_shutdowns(struct cxl_cmd *cmd);
 int cxl_cmd_get_health_info_get_volatile_errors(struct cxl_cmd *cmd);
 int cxl_cmd_get_health_info_get_pmem_errors(struct cxl_cmd *cmd);
+struct cxl_cmd *cxl_cmd_new_get_lsa(struct cxl_memdev *memdev,
+		unsigned int offset, unsigned int length);
+void *cxl_cmd_get_lsa_get_payload(struct cxl_cmd *cmd);
 
 #ifdef __cplusplus
 } /* extern "C" */
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index e00443d..2c6193b 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -52,4 +52,6 @@ global:
 	cxl_cmd_get_health_info_get_dirty_shutdowns;
 	cxl_cmd_get_health_info_get_volatile_errors;
 	cxl_cmd_get_health_info_get_pmem_errors;
+	cxl_cmd_new_get_lsa;
+	cxl_cmd_get_lsa_get_payload;
 } LIBCXL_2;
-- 
2.31.1

