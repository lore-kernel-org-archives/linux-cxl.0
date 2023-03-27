Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E42C77B61
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 05:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjC0FDa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjC0FD1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 01:03:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450DA4230
        for <linux-cxl@vger.kernel.org>; Sun, 26 Mar 2023 22:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679893406; x=1711429406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l5qydJc2qTxClYAA3khPwiAT8pVGyO4LrUT5kTe7wxc=;
  b=mZ8L1qsLPBPMsTso1/Nn7PeHOr6jsD1K91UbohtBG6igvUIJLSasa+fT
   RqoOKU0jl+qXADwYhwoT394OFGmskdyafh+vtQxt1xL6WdPDCLyZzDRjZ
   EKy6VgqA7k35qt+mp4OzWTaBcMIYK9vAR927ewuBxCNAVENoCYmVpo0sN
   /4usslYAD60Fcc1oInJJHvdIgy7i1xNkr+sArKrxmdAYhF0s50wFbzQmu
   IJf0axu4n1Lp4WKV+fiagjp3jBHnNEybgYkunbPlCL3VXTfMvMsJ8Jc6y
   7xVQCwJQTLRP6C1L9A9tPPDResP5hR48deeus4g0K/TBTmCuDqAMJuf2V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367920204"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="367920204"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="633492278"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="633492278"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.227.2])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:25 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 08/12] tools/testing/cxl: Mock the Inject Poison mailbox command
Date:   Sun, 26 Mar 2023 22:03:14 -0700
Message-Id: <fc4ee78a1574ba5a0a7a7c2918af2c0d57012fd5.1679892337.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679892337.git.alison.schofield@intel.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
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

