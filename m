Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A51DC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 04:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiK3Ee7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Nov 2022 23:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiK3Eeq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Nov 2022 23:34:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA34C59851
        for <linux-cxl@vger.kernel.org>; Tue, 29 Nov 2022 20:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669782885; x=1701318885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5vXuv/Unb1cvTGr4KjdHtgI9+2CY7iEnNOQJ9BHWdSA=;
  b=nLlWSGQauaBx5bWhr7/KP3bRQegjBO3FFZp8G8dOdb77UApMCJTHiICk
   syl1Sv/3w3ukH+4HMTFOzUqUFG0ml4BRmNhPt5HsFSiuL5ZJ0G9sykYmj
   NGk23LJrXTWFsN3b8nchlu4/fzYAF3hGBpRXBzpzchjmAW2LOihY/RlGZ
   uvu/fzbq+faxhY0wUH13bgVoKVg75lGu40DmsBG7633y8L2TpHc46yI82
   amI9EZ9hqyU/6izQxc45wFbXHDW9YkB2AQNZpL2yFZu7QwRKqN6DGxRmR
   xMOOzWST/RviLplIf9AxXl4RJdhKdPLb0fn5t9uj+iMBDyuGK2uTOEuY8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379583245"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="379583245"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 20:34:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="594525710"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="594525710"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.50.166])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 20:34:45 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 5/5] tools/testing/cxl: Use injected poison for Get Poison List
Date:   Tue, 29 Nov 2022 20:34:37 -0800
Message-Id: <2c068669b1b31a94b319f60c413c2169bb854111.1669781852.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1669781852.git.alison.schofield@intel.com>
References: <cover.1669781852.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Prior to poison inject & clear support, the mock of 'Get Poison List'
returned a list containing a single mocked error record.

Now that the mock of Inject and Clear poison maintains a mock_poison[]
list, use that when available for the device. Otherwise, return the
existing default mocked error record.

This enables roundtrip userspace testing of the inject, clear, and
poison list support.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/mem.c | 97 +++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 28 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 9d794fbe5ee1..31c147cf2d5b 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -224,6 +224,75 @@ static struct mock_poison {
 	u64 dpa;
 } mock_poison[MOCK_INJECT_POISON_MAX];
 
+struct mock_poison_po {
+	struct cxl_mbox_poison_payload_out poison_out;
+	struct cxl_poison_record record[MOCK_INJECT_POISON_MAX];
+};
+
+/*
+ * Use the default poison payload when no injected poison is currently
+ * mocked for this device. Mock one poison record with length 64 bytes.
+ */
+static struct mock_poison_po default_poison_po = {
+	.poison_out.count = cpu_to_le16(1),
+	.record[0].length = cpu_to_le32(1),
+};
+
+static struct mock_poison_po *cxl_get_injected_po(struct cxl_dev_state *cxlds,
+						  u64 offset, u64 length)
+{
+	struct mock_poison_po *po;
+	int nr_records = 0;
+	u64 dpa;
+
+	po = kzalloc(sizeof(*po), GFP_KERNEL);
+	if (!po)
+		return NULL;
+
+	for (int i = 0; i < MOCK_INJECT_POISON_MAX; i++) {
+		if (mock_poison[i].cxlds != cxlds)
+			continue;
+		if (mock_poison[i].dpa < offset ||
+		    mock_poison[i].dpa > offset + length - 1)
+			continue;
+		dpa = cpu_to_le64(mock_poison[i].dpa |
+				  CXL_POISON_SOURCE_INJECTED);
+		po->record[nr_records].address = dpa;
+		po->record[nr_records].length = cpu_to_le32(1);
+		nr_records++;
+	}
+	if (!nr_records) {
+		kfree(po);
+		return NULL;
+	}
+	po->poison_out.count = cpu_to_le16(nr_records);
+	return po;
+}
+
+static int mock_get_poison(struct cxl_dev_state *cxlds,
+			   struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_poison_payload_in *pi = cmd->payload_in;
+	struct mock_poison_po *po;
+
+	po = cxl_get_injected_po(cxlds, pi->offset, pi->length);
+	if (!po) {
+		po = &default_poison_po;
+		po->record[0].address = cpu_to_le64(pi->offset |
+						    CXL_POISON_SOURCE_INTERNAL);
+	}
+	if (cmd->size_out < sizeof(po))
+		return -EINVAL;
+
+	memcpy(cmd->payload_out, po, sizeof(*po));
+	cmd->size_out = sizeof(po);
+
+	if (po != &default_poison_po)
+		kfree(po);
+
+	return 0;
+}
+
 static bool mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
 {
 	for (int i = 0; i < MOCK_INJECT_POISON_MAX; i++) {
@@ -293,34 +362,6 @@ static int mock_inject_poison(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
-static int mock_get_poison(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
-{
-	struct cxl_mbox_poison_payload_in *pi = cmd->payload_in;
-
-	struct {
-		struct cxl_mbox_poison_payload_out poison_out;
-		struct cxl_poison_record record;
-	} mock_poison_list = {
-		.poison_out = {
-			.count = cpu_to_le16(1),
-		},
-		/* Mock one poison record at pi.offset for 64 bytes */
-		.record = {
-			/* .address encodes DPA and poison source bits */
-			.address = cpu_to_le64(pi->offset |
-					       CXL_POISON_SOURCE_INTERNAL),
-			.length = cpu_to_le32(1),
-		},
-	};
-
-	if (cmd->size_out < sizeof(mock_poison_list))
-		return -EINVAL;
-
-	memcpy(cmd->payload_out, &mock_poison_list, sizeof(mock_poison_list));
-	cmd->size_out = sizeof(mock_poison_list);
-	return 0;
-}
-
 static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct device *dev = cxlds->dev;
-- 
2.37.3

