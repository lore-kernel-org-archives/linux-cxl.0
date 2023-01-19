Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE5BC678D4
	for <linux-cxl@archiver.kernel.org>; Thu, 19 Jan 2023 05:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjASFI4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 19 Jan 2023 00:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjASFIE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 19 Jan 2023 00:08:04 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC2E71F3A
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 21:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674104587; x=1705640587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IlTO4QKkr2b1+9AAhAksTVruPSLg1q6OVMNMLc8JJXw=;
  b=iHZa1mAt9+jHwvdj6CeDIMIut9xvl8j1BJoJMiGnRPXLiF/WaLOT0GTJ
   EUHXJoQS7tFYwtgPACMotyRCbiQG9WasLJrBJKLjVSKPeXwv8rWhiS5Rz
   v0/FYewiX0pYm5XoqHLc/HTyYq3X4L+poq9k5qFN6TgJxi8lff34kd8so
   3vzhJ7porgLNfYYSGTkVieDMLqEKM9Qz1ZqdQLsOHRhx9AW3ni+e2a2t/
   JGFb48rSzxqfxJtmfqC35RRDqb+7WJXBJ+DsYL6gFDtrtLx7yCeHTrYkL
   cKXFZF2jp+WkY8pBEp/uHGcxsRGrw+sGd0HLm2PumUEZl4sc8DS+Tfsrd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="304881258"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="304881258"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 21:00:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="783932583"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="783932583"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.119.104])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 21:00:28 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2 5/6] tools/testing/cxl: Use injected poison for get poison list
Date:   Wed, 18 Jan 2023 21:00:20 -0800
Message-Id: <e4c530ac9c073eb753a98a052216d58a571799e4.1674101475.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1674101475.git.alison.schofield@intel.com>
References: <cover.1674101475.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Prior to poison inject support, the mock of 'Get Poison List'
returned a poison list containing a single mocked error record.

Now, following the addition of poison inject and clear support,
use the mock_poison_list[] as the source of records for 'Get
Poison List' requests.

This supports confirmation of inject and clear poison commands.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/mem.c | 56 ++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index bb0be9fe3fe9..14d74bfb3124 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -582,31 +582,51 @@ static struct mock_poison {
 	u64 dpa;
 } mock_poison_list[MOCK_INJECT_TEST_MAX];
 
+static struct cxl_mbox_poison_payload_out
+*cxl_get_injected_po(struct cxl_dev_state *cxlds, u64 offset, u64 length)
+{
+	struct cxl_mbox_poison_payload_out *po;
+	int nr_records = 0;
+	u64 dpa;
+
+	po = kzalloc(struct_size(po, record, MOCK_INJECT_DEV_MAX), GFP_KERNEL);
+	if (!po)
+		return NULL;
+
+	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
+		if (mock_poison_list[i].cxlds != cxlds)
+			continue;
+		if (mock_poison_list[i].dpa < offset ||
+		    mock_poison_list[i].dpa > offset + length - 1)
+			continue;
+
+		dpa = mock_poison_list[i].dpa + CXL_POISON_SOURCE_INJECTED;
+		po->record[nr_records].address = cpu_to_le64(dpa);
+		po->record[nr_records].length = cpu_to_le32(1);
+		nr_records++;
+		if (nr_records == MOCK_INJECT_DEV_MAX)
+			break;
+	}
+
+	/* Always return count, even when zero */
+	po->count = cpu_to_le16(nr_records);
+
+	return po;
+}
+
 static int mock_get_poison(struct cxl_dev_state *cxlds,
 			   struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_poison_payload_in *pi = cmd->payload_in;
+	struct cxl_mbox_poison_payload_out *po;
+	u64 offset = le64_to_cpu(pi->offset);
+	u64 length = le64_to_cpu(pi->length);
 
-	/* Mock one poison record at pi.offset for 64 bytes */
-	struct {
-		struct cxl_mbox_poison_payload_out po;
-		struct cxl_poison_record record;
-	} mock_plist = {
-		.po = {
-			.count = cpu_to_le16(1),
-		},
-		.record = {
-			.length = cpu_to_le32(1),
-			.address = cpu_to_le64(pi->offset +
-					       CXL_POISON_SOURCE_INJECTED),
-		},
-	};
+	po = cxl_get_injected_po(cxlds, offset, length);
 
-	if (cmd->size_out < sizeof(mock_plist))
-		return -EINVAL;
+	memcpy(cmd->payload_out, po, struct_size(po, record, po->count));
+	cmd->size_out = struct_size(po, record, po->count);
 
-	memcpy(cmd->payload_out, &mock_plist, sizeof(mock_plist));
-	cmd->size_out = sizeof(mock_plist);
 	return 0;
 }
 
-- 
2.37.3

