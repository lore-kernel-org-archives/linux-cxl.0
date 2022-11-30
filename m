Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF82FC352A1
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 04:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiK3Ee6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Nov 2022 23:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiK3Eeq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Nov 2022 23:34:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B322C55C84
        for <linux-cxl@vger.kernel.org>; Tue, 29 Nov 2022 20:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669782885; x=1701318885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m9sxd4/9lr3pk29+PfPF2PfG2nkRO2UYx9gMEYwpIdc=;
  b=PkBRLdm+DF6v1MTccOPwd1P7eDZVaRIr+s3iDckysIGu0JlFAhaBuHde
   T2aao+lIzXpAZ9am18Cg4gEVqHDXzhEVVJknGgZAeE4H7yR1I8BgjnjBR
   9WPOB/kang+TL8sKxxlwsBF2EnzUp6VI3FaAAUTz4jv+K/CCK81snF15A
   9OW/thUtbXNqpx2aIZIDpZr6RYfLfLhRlOsM3wIfHWKDpLMpclCasE/Q4
   6BW4NBxgT250cHMjzTncNRfrx/+d1mdXvMACMkHsEPxWxv28+JEjcg2W2
   j9N6+4jzOVDOks576VjlcumLp6cTuXVLnazbOpC2ltb1uatmFUCMcxwVY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379583240"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="379583240"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 20:34:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="594525703"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="594525703"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.50.166])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 20:34:44 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 4/5] tools/testing/cxl: Mock the Clear Poison mailbox command
Date:   Tue, 29 Nov 2022 20:34:36 -0800
Message-Id: <be25fbaea1dd583b22bb71748331a2b76d0dd62e.1669781852.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1669781852.git.alison.schofield@intel.com>
References: <cover.1669781852.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Mock the clear of poison by deleting the device:address entry from
the cxl_test array: mock_poison[]. Behave like a real CXL device and do
not fail if the address is not in the poison list, but offer a dev_dbg()
message.

Unlike a real CXL device, no data is written to the address being cleared.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/mem.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 98acb9a644df..9d794fbe5ee1 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -48,6 +48,10 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
 		.effect = cpu_to_le16(0),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_CLEAR_POISON),
+		.effect = cpu_to_le16(0),
+	},
 };
 
 /* See CXL 2.0 Table 181 Get Health Info Output Payload */
@@ -244,6 +248,35 @@ static bool mock_poison_found(struct cxl_dev_state *cxlds, u64 dpa)
 	return false;
 }
 
+static bool mock_poison_del(struct cxl_dev_state *cxlds, u64 dpa)
+{
+	for (int i = 0; i < MOCK_INJECT_POISON_MAX; i++) {
+		if (mock_poison[i].cxlds == cxlds &&
+		    mock_poison[i].dpa == dpa) {
+			mock_poison[i].cxlds = NULL;
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
+
+	u64 dpa = le64_to_cpu(pi->address);
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
 static int mock_inject_poison(struct cxl_dev_state *cxlds,
 			      struct cxl_mbox_cmd *cmd)
 {
@@ -321,6 +354,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
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

