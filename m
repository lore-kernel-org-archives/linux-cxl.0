Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5846DC433FE
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Oct 2021 20:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F0960FDC
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Oct 2021 20:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhJGUtx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:49:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:2500 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232629AbhJGUtx (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 7 Oct 2021 16:49:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="289857797"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="289857797"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 13:47:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="489169449"
Received: from huaxue-mobl3.amr.corp.intel.com (HELO vverma7-desk.amr.corp.intel.com) ([10.255.77.214])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 13:47:58 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] tools/testing/cxl: add mock output for the GET_HEALTH_INFO command
Date:   Thu,  7 Oct 2021 14:47:53 -0600
Message-Id: <20211007204753.3321681-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2589; h=from:subject; bh=UZArohly70dADxupdQaXpbzRHJyBubSzmQQjvdKIWMM=; b=owGbwMvMwCHGf25diOft7jLG02pJDInxMS9P1yTc64lhuRRetoj96wzhF9fWPdk4y/G61omPexV3 Hdmr0VHKwiDGwSArpsjyd89HxmNy2/N5AhMcYeawMoEMYeDiFICJHG1jZLgc0xbK/Udyzvf8i/YVK7 96TE6cdVJlww8/9hLW6nC3LS2MDB/3+19ontsiG/3smx3/xe276yNOenwummCu5/zh38FvK9kA
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
 drivers/cxl/cxlmem.h         | 12 ++++++++++++
 tools/testing/cxl/test/mem.c | 24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c4f450ad434d..c7957cce8e8b 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -228,6 +228,18 @@ struct cxl_mbox_set_lsa {
 	u8 data[];
 } __packed;
 
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
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 12a8437a9ca0..bd707e83a3e9 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -28,6 +28,10 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_SET_LSA),
 		.effect = cpu_to_le16(EFFECT(1) | EFFECT(2)),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
+		.effect = cpu_to_le16(0),
+	},
 };
 
 static struct {
@@ -156,6 +160,23 @@ static int mock_set_lsa(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
 	return 0;
 }
 
+static int mock_health_info(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_health_info health_info = {
+		.health_status = 0x7,
+		.media_status = 0x3,
+		.ext_status = 0x18,
+		.life_used = 15,
+		.temperature = cpu_to_le16(25),
+		.dirty_shutdowns = cpu_to_le16(10),
+		.volatile_errors = cpu_to_le16(20),
+		.pmem_errors = cpu_to_le16(30),
+	};
+
+	memcpy(cmd->payload_out, &health_info, sizeof(health_info));
+	return 0;
+}
+
 static int cxl_mock_mbox_send(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
 {
 	struct device *dev = cxlm->dev;
@@ -177,6 +198,9 @@ static int cxl_mock_mbox_send(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
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

