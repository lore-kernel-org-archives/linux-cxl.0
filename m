Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6916FC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 04:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiK3Ee5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Nov 2022 23:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiK3Eep (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Nov 2022 23:34:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD95A1A8
        for <linux-cxl@vger.kernel.org>; Tue, 29 Nov 2022 20:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669782884; x=1701318884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZiP41g0dCCWw70B/J6GeqQsICRfRnswtZYGMtJ42xCQ=;
  b=mQssjcPEO6RHUsYTjHtikNjWSmtJEV+gZVR1LofeGM5w8waPOV0gQ+Qi
   dtxRiN0naOBaRZ2Z6Toc8sSQMN/iVYQK9794FQWNNOmYWFkvfEciD58bG
   nLKSVJ1bIDeuSymJOVKjBKS8b487/H/lrKH0VRxweWRw3w5yY0PyPcqqT
   LvWM7xG6lMvo1I5u6t3Q9xVU6tY2Qpqe7H4EdmiJ5IXOR7ZSjvSkEf2Fp
   Ye+pAxpOG8TNn/RYflr3o/Z2xMoKeF5b81o0vamOIvOKxO7k60i02tPQe
   ZGjn5UPZZvR0rL+ZKu34pxui46ab0ByURjyy75PU+MPrOiWlON8sXuao9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379583235"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="379583235"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 20:34:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="594525700"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="594525700"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.50.166])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 20:34:43 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 3/5] tools/testing/cxl: Mock the Inject Poison mailbox command
Date:   Tue, 29 Nov 2022 20:34:35 -0800
Message-Id: <08eddfad079afbab1f80f17d9670b40b2a7bdea8.1669781852.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1669781852.git.alison.schofield@intel.com>
References: <cover.1669781852.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Mock the injection of poison by storing the device:address entry in a
cxl_test array: mock_poison[]. Limit the array to 64 entries and fail
new inject requests when full.

Introducing the mock_poison[] list here, makes it available for use in
the mock of Clear Poison, and the mock of Get Poison List.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/mem.c | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index a4f81915ec03..98acb9a644df 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -13,6 +13,7 @@
 #define LSA_SIZE SZ_128K
 #define DEV_SIZE SZ_2G
 #define EFFECT(x) (1U << x)
+#define MOCK_INJECT_POISON_MAX 64
 
 static struct cxl_cel_entry mock_cel[] = {
 	{
@@ -43,6 +44,10 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
 		.effect = cpu_to_le16(0),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
+		.effect = cpu_to_le16(0),
+	},
 };
 
 /* See CXL 2.0 Table 181 Get Health Info Output Payload */
@@ -210,6 +215,51 @@ static int mock_health_info(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
+static struct mock_poison {
+	struct cxl_dev_state *cxlds;
+	u64 dpa;
+} mock_poison[MOCK_INJECT_POISON_MAX];
+
+static bool mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
+{
+	for (int i = 0; i < MOCK_INJECT_POISON_MAX; i++) {
+		if (!mock_poison[i].cxlds) {
+			mock_poison[i].cxlds = cxlds;
+			mock_poison[i].dpa = dpa;
+			return true;
+		}
+	}
+	dev_dbg(cxlds->dev, "Mock poison list full: %d\n",
+		MOCK_INJECT_POISON_MAX);
+	return false;
+}
+
+static bool mock_poison_found(struct cxl_dev_state *cxlds, u64 dpa)
+{
+	for (int i = 0; i < MOCK_INJECT_POISON_MAX; i++) {
+		if (mock_poison[i].cxlds == cxlds &&
+		    mock_poison[i].dpa == dpa)
+			return true;
+	}
+	return false;
+}
+
+static int mock_inject_poison(struct cxl_dev_state *cxlds,
+			      struct cxl_mbox_cmd *cmd)
+{
+	u64 dpa = le64_to_cpu(*((u64 *)cmd->payload_in));
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
 static int mock_get_poison(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_poison_payload_in *pi = cmd->payload_in;
@@ -268,6 +318,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
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

