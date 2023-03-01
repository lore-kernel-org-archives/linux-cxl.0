Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB35C7EE30
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 21:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCAVgo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 16:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCAVgn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 16:36:43 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1CB2D17D
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 13:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677706602; x=1709242602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jy1UQLJ3GWQhq9KyEdeSl/Ei3C69x5gUL0OGBx9pdqg=;
  b=Z6AGm22vbEKOFUw/lrD5t/rFTuHvY7p4ZYHnZFvtVmdvo6QOju8i0TNO
   CkFLpfgNPRM8WzECjsAfYHzvA3OtDPcuYsUHg9oCzNuysmTjVcHG1o5NP
   Vt47kcEu5lVyhddHQ6DZk3wtfj1w72NEjXLHhZ1XcmwTZ+ap3xkh13mIu
   QNQ7H3K3lLss9OVMTdbsr4/nm/zRd9VKsP3k1elX84HTzDBwlnVnkRwL6
   y/Ip2IDe7HcdQia4ijPu/qNlTfsz07qZC4aiuH0ml/A3uBPGBPxHkAJVG
   nada8EdT8OrvZYT+cAZhGkN+0hGbicAgL+UEPf164kxP95KEqXwbWE0Jk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397094686"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="397094686"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 13:36:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="784520802"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="784520802"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.70.38])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 13:36:40 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 4/8] tools/testing/cxl: Mock the Clear Poison mailbox command
Date:   Wed,  1 Mar 2023 13:36:29 -0800
Message-Id: <e8c0c8b95771b9dd3f1be0621ed9fb651c5f6130.1677704994.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1677704994.git.alison.schofield@intel.com>
References: <cover.1677704994.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Mock the clear of poison by deleting the device:address entry from
the mock_poison_list[]. Behave like a real CXL device and do not fail
if the address is not in the poison list, but offer a dev_dbg()
message.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tools/testing/cxl/test/mem.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 4fca886e2a7c..720147c7cb2b 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -52,6 +52,10 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
 		.effect = cpu_to_le16(0),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_CLEAR_POISON),
+		.effect = cpu_to_le16(0),
+	},
 };
 
 /* See CXL 2.0 Table 181 Get Health Info Output Payload */
@@ -997,6 +1001,35 @@ static int mock_inject_poison(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
+static bool mock_poison_del(struct cxl_dev_state *cxlds, u64 dpa)
+{
+	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
+		if (mock_poison_list[i].cxlds == cxlds &&
+		    mock_poison_list[i].dpa == dpa) {
+			mock_poison_list[i].cxlds = NULL;
+			return true;
+		}
+	}
+	return false;
+}
+
+static int mock_clear_poison(struct cxl_dev_state *cxlds,
+			     struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_clear_poison *pi = cmd->payload_in;
+	u64 dpa = le64_to_cpu(pi->address);
+
+	/*
+	 * A real CXL device will write pi->write_data to the address
+	 * being cleared. In this mock, just delete this address from
+	 * the mock poison list.
+	 */
+	if (!mock_poison_del(cxlds, dpa))
+		dev_dbg(cxlds->dev, "DPA: 0x%llx not in poison list\n", dpa);
+
+	return 0;
+}
+
 static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct device *dev = cxlds->dev;
@@ -1057,6 +1090,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_INJECT_POISON:
 		rc = mock_inject_poison(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_CLEAR_POISON:
+		rc = mock_clear_poison(cxlds, cmd);
+		break;
 	default:
 		break;
 	}
-- 
2.37.3

