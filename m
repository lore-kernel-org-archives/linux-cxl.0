Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DB7C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 11 Oct 2021 22:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961B060F43
	for <linux-cxl@archiver.kernel.org>; Mon, 11 Oct 2021 22:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbhJKWaj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:30:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:19219 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235492AbhJKWaj (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 11 Oct 2021 18:30:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="225755976"
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="225755976"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 15:28:38 -0700
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="523986041"
Received: from ylj0508-mobl.ccr.corp.intel.com (HELO vverma7-desk.amr.corp.intel.com) ([10.254.42.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 15:28:37 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2] tools/testing/cxl: add mock output for the GET_HEALTH_INFO command
Date:   Mon, 11 Oct 2021 16:28:26 -0600
Message-Id: <20211011222826.184775-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2894; h=from:subject; bh=cYpNt/fdLNe9Q5fgViKhMT3KXl4tpXjvfWbC3r5zKZY=; b=owGbwMvMwCHGf25diOft7jLG02pJDIkpu2pcPouo5PEkRHuci7poE8Y1ecVzzxnTBRbtV7gv8lfC bJ9xRykLgxgHg6yYIsvfPR8Zj8ltz+cJTHCEmcPKBDKEgYtTACbyYDojQ4OVUXtKZv/mXzZzJa4H+y v1b7yYMZdLWKd8k8Z5lQOZKgz/FCOnK6WyL5qpsszG+vDee2UzjaIYxfb9qs2c/uqppp8hLwA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add mocked health information for cxl_test memdevs. This allows
cxl-cli's 'list' command to display the canned health_info fields.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 tools/testing/cxl/test/mem.c | 48 ++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

v2:
- Move the health_info struct definition into tools/testing since the
  mock driver is currently the only user (Dan)
- Add comments for the various status fields describing the flags being
  set (Dan)
- Add a size check before copying the cmd buffer (Dan)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 12a8437a9ca0..60264a18d3ca 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -28,8 +28,24 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_SET_LSA),
 		.effect = cpu_to_le16(EFFECT(1) | EFFECT(2)),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
+		.effect = cpu_to_le16(0),
+	},
 };
 
+/* See CXL 2.0 Table 181 Get Health Info Output Payload */
+struct cxl_mbox_health_info {
+	u8 health_status;
+	u8 media_status;
+	u8 ext_status;
+	u8 life_used;
+	__le16 temperature;
+	__le32 dirty_shutdowns;
+	__le32 volatile_errors;
+	__le32 pmem_errors;
+} __packed;
+
 static struct {
 	struct cxl_mbox_get_supported_logs gsl;
 	struct cxl_gsl_entry entry;
@@ -156,6 +172,35 @@ static int mock_set_lsa(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
 	return 0;
 }
 
+static int mock_health_info(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_health_info health_info = {
+		/* set flags for maint needed, perf degraded, hw replacement */
+		.health_status = 0x7,
+		/* set media status to "All Data Lost" */
+		.media_status = 0x3,
+		/*
+		 * set ext_status flags for:
+		 *  ext_life_used: normal,
+		 *  ext_temperature: critical,
+		 *  ext_corrected_volatile: warning,
+		 *  ext_corrected_persistent: normal,
+		 */
+		.ext_status = 0x18,
+		.life_used = 15,
+		.temperature = cpu_to_le16(25),
+		.dirty_shutdowns = cpu_to_le16(10),
+		.volatile_errors = cpu_to_le16(20),
+		.pmem_errors = cpu_to_le16(30),
+	};
+
+	if (cmd->size_out < sizeof(health_info))
+		return -EINVAL;
+
+	memcpy(cmd->payload_out, &health_info, sizeof(health_info));
+	return 0;
+}
+
 static int cxl_mock_mbox_send(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
 {
 	struct device *dev = cxlm->dev;
@@ -177,6 +222,9 @@ static int cxl_mock_mbox_send(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
 	case CXL_MBOX_OP_SET_LSA:
 		rc = mock_set_lsa(cxlm, cmd);
 		break;
+	case CXL_MBOX_OP_GET_HEALTH_INFO:
+		rc = mock_health_info(cxlm, cmd);
+		break;
 	default:
 		break;
 	}

base-commit: ed97afb53365cd03dde266c9644334a558fe5a16
-- 
2.31.1

