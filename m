Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D2CC7EE33
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 21:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCAVgn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 16:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCAVgm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 16:36:42 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8852C66F
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 13:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677706601; x=1709242601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l5qydJc2qTxClYAA3khPwiAT8pVGyO4LrUT5kTe7wxc=;
  b=efnW8WGXNf8aVaBpxAdRsjqRxwbfWWR+pJD8jT+p211uSpdPTc7lGCXP
   pvjCm40Vnhsq8lnJNbtX0J6moWRaPe1d9MIaKgCf1jfTOzw4FA4HrIq1W
   NOSrHJS7FveVp3fqX2xBsMJz21xnN4gjg9omz6ZeRoSQfbN9sH0XEdpQu
   XKwurNlakmum0txeTJpNsdxIEJV8Z6dQVxQZ1FnjjWoOfahRGu7OD/FQF
   BZXF9ILIx7Ie7IGb3p6J8b6HPd+XOWhgJ5l2pxDaU7ubRq+Vyc0eN0SXG
   gApQDU41Dl2aBX0N2kO43w0IUAMLe3VjrZ9/Ozog6DdPorpMhI62URNtv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397094679"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="397094679"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 13:36:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="784520785"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="784520785"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.70.38])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 13:36:39 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 3/8] tools/testing/cxl: Mock the Inject Poison mailbox command
Date:   Wed,  1 Mar 2023 13:36:28 -0800
Message-Id: <00226853c8ca297af8dc0a259e11219e7d122a86.1677704994.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1677704994.git.alison.schofield@intel.com>
References: <cover.1677704994.git.alison.schofield@intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tools/testing/cxl/test/mem.c | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 2fa9c18d4c2c..4fca886e2a7c 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -16,6 +16,9 @@
 #define DEV_SIZE SZ_2G
 #define EFFECT(x) (1U << x)
 
+#define MOCK_INJECT_DEV_MAX 8
+#define MOCK_INJECT_TEST_MAX 128
+
 static struct cxl_cel_entry mock_cel[] = {
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_LOGS),
@@ -45,6 +48,10 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
 		.effect = cpu_to_le16(0),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
+		.effect = cpu_to_le16(0),
+	},
 };
 
 /* See CXL 2.0 Table 181 Get Health Info Output Payload */
@@ -474,6 +481,7 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 			cpu_to_le64(SZ_256M / CXL_CAPACITY_MULTIPLIER),
 		.total_capacity =
 			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
+		.inject_poison_limit = cpu_to_le16(MOCK_INJECT_DEV_MAX),
 	};
 
 	put_unaligned_le24(CXL_POISON_LIST_MAX, id.poison_list_max_mer);
@@ -895,6 +903,11 @@ static int mock_health_info(struct cxl_dev_state *cxlds,
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
@@ -923,6 +936,67 @@ static int mock_get_poison(struct cxl_dev_state *cxlds,
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
@@ -980,6 +1054,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
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

