Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B397C678D4
	for <linux-cxl@archiver.kernel.org>; Thu, 19 Jan 2023 05:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjASFIx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 19 Jan 2023 00:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjASFH4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 19 Jan 2023 00:07:56 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B107570C
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 21:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674104580; x=1705640580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OJXKWSCnBLYahKTP5lxrXz3pGXA/kVeh7OpFP4xV1rQ=;
  b=ZqvWm1FiHEvx5qFmC+LjtLjWnkZAkxcaXaLykaKArvviT/rXwIKjslEn
   YATZkoOCZW07xHoYa8mWNeGtvehEpot+cbNjPRjXwvW/yUsOWo0tdzxl0
   KHsydfP0kYVeiclhs+lkLGyvHqjpeAJZXurLLDezk615WyBsQBPW3ADLa
   v9wfLphOVnxbuuLRuiVD/5KeHzSmEUbe6G8zNCAerxrnn4FhcZVFpssyc
   jH7BFA+Re06xxLf1XHCl+6g6s/UsurR8imHvb9aEX9sGDDrlrC4vjfJUc
   gZVjeUhf8pg7qgMythl+IE20Bj+cyrKcyjDTqaX4s6J6DR+8j8JJYVwfd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="304881198"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="304881198"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 21:00:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="783932572"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="783932572"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.119.104])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 21:00:26 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2 3/6] tools/testing/cxl: Mock the Inject Poison mailbox command
Date:   Wed, 18 Jan 2023 21:00:18 -0800
Message-Id: <e7ee818cd52b702e69bca6cd2f07aa786245b88c.1674101475.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1674101475.git.alison.schofield@intel.com>
References: <cover.1674101475.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Mock the injection of poison by storing the device:address entries in
mock_poison_list[]. Enforce a limit of 8 poison injections per memdev
device and 128 total entries for the cxl_test mock driver.

Introducing the mock_poison[] list here, makes it available for use in
the mock of Clear Poison, and the mock of Get Poison List.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/mem.c | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 09dc358bb33b..b0ecdc4e7c87 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -14,6 +14,9 @@
 #define DEV_SIZE SZ_2G
 #define EFFECT(x) (1U << x)
 
+#define MOCK_INJECT_DEV_MAX 8
+#define MOCK_INJECT_TEST_MAX 128
+
 static struct cxl_cel_entry mock_cel[] = {
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_LOGS),
@@ -43,6 +46,10 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
 		.effect = cpu_to_le16(0),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
+		.effect = cpu_to_le16(0),
+	},
 };
 
 /* See CXL 2.0 Table 181 Get Health Info Output Payload */
@@ -144,6 +151,7 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 			cpu_to_le64(SZ_256M / CXL_CAPACITY_MULTIPLIER),
 		.total_capacity =
 			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
+		.inject_poison_limit = cpu_to_le16(MOCK_INJECT_DEV_MAX),
 	};
 
 	put_unaligned_le24(CXL_POISON_LIST_MAX, id.poison_list_max_mer);
@@ -565,6 +573,11 @@ static int mock_health_info(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
+static struct mock_poison {
+	struct cxl_dev_state *cxlds;
+	u64 dpa;
+} mock_poison_list[MOCK_INJECT_TEST_MAX];
+
 static int mock_get_poison(struct cxl_dev_state *cxlds,
 			   struct cxl_mbox_cmd *cmd)
 {
@@ -593,6 +606,67 @@ static int mock_get_poison(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
+static bool mock_poison_dev_max_injected(struct cxl_dev_state *cxlds)
+{
+	int count = 0;
+
+	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
+		if (mock_poison_list[i].cxlds == cxlds)
+			count++;
+	}
+	return (count >= MOCK_INJECT_DEV_MAX);
+}
+
+static bool mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
+{
+	if (mock_poison_dev_max_injected(cxlds)) {
+		dev_dbg(cxlds->dev,
+			"Device poison injection limit has been reached: %d\n",
+			MOCK_INJECT_DEV_MAX);
+		return false;
+	}
+
+	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
+		if (!mock_poison_list[i].cxlds) {
+			mock_poison_list[i].cxlds = cxlds;
+			mock_poison_list[i].dpa = dpa;
+			return true;
+		}
+	}
+	dev_dbg(cxlds->dev,
+		"Mock test poison injection limit has been reached: %d\n",
+		MOCK_INJECT_TEST_MAX);
+
+	return false;
+}
+
+static bool mock_poison_found(struct cxl_dev_state *cxlds, u64 dpa)
+{
+	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
+		if (mock_poison_list[i].cxlds == cxlds &&
+		    mock_poison_list[i].dpa == dpa)
+			return true;
+	}
+	return false;
+}
+
+static int mock_inject_poison(struct cxl_dev_state *cxlds,
+			      struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_inject_poison *pi = cmd->payload_in;
+	u64 dpa = le64_to_cpu(pi->address);
+
+	if (mock_poison_found(cxlds, dpa)) {
+		/* Not an error to inject poison if already poisoned */
+		dev_dbg(cxlds->dev, "DPA: 0x%llx already poisoned\n", dpa);
+		return 0;
+	}
+	if (!mock_poison_add(cxlds, dpa))
+		return -ENXIO;
+
+	return 0;
+}
+
 static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct device *dev = cxlds->dev;
@@ -644,6 +718,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_GET_POISON:
 		rc = mock_get_poison(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_INJECT_POISON:
+		rc = mock_inject_poison(cxlds, cmd);
+		break;
 	default:
 		break;
 	}
-- 
2.37.3

