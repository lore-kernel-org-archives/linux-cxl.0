Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3166DC77B76
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Apr 2023 03:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjDSD1G (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjDSD0y (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 23:26:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06515BB1
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 20:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681874811; x=1713410811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cmjqzPrCpLeCr8OiMGyOU7VwPW9nbhRNgYucwD/dOkA=;
  b=Uunm+kc9qab0Bbt21xZbC4KDKEM4vYU46ed7Tfb9VjOOPxjiyYcKJi3g
   znfAR9yNkscsLZ6JxcMg45y/lPwg+1WdWHXZ1NbG5RqE2ZVNu1Cz1zR9W
   zvZNMY5LcYpIkiKlKDaBIxO6o4QAgI/jBDrvIh4pV+uzoRGYFgeMS68Nz
   d7biSy9tl2YLM+W4nJxhyEUzLaghM21vy7BWbh+G0bMZsnkOs0mDHbsAW
   33uF2xEbbL86tL65gk4d3UO2JLYUA4o7FJLUZ52XdwYC0bxesTNGPX8x7
   XcHL6vDVFocN7q+XEem7BE2zgq88iQNiJH8Qc/2KoTJCcUEAcE3oMStBB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431621737"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="431621737"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780711139"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="780711139"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:51 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v6 08/10] tools/testing/cxl: Use injected poison for get poison list
Date:   Tue, 18 Apr 2023 20:26:32 -0700
Message-Id: <0f4242c81821f4982b02cb1009c22783ef66b2f1.1681874357.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1681874357.git.alison.schofield@intel.com>
References: <cover.1681874357.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Prior to poison inject support, the mock of 'Get Poison List'
returned a poison list containing a single mocked error record.

Following the addition of poison inject and clear support to the
mock driver, use the mock_poison_list[], rather than faking an
error record. Mock_poison_list[] list tracks the actual poison
inject and clear requests issued by userspace.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 59 ++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 3c3909d30d03..cce7ec8f0efb 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -912,31 +912,52 @@ static struct mock_poison {
 	u64 dpa;
 } mock_poison_list[MOCK_INJECT_TEST_MAX];
 
+static struct cxl_mbox_poison_out
+*cxl_get_injected_po(struct cxl_dev_state *cxlds, u64 offset, u64 length)
+{
+	struct cxl_mbox_poison_out *po;
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
 	struct cxl_mbox_poison_in *pi = cmd->payload_in;
+	struct cxl_mbox_poison_out *po;
+	u64 offset = le64_to_cpu(pi->offset);
+	u64 length = le64_to_cpu(pi->length);
+	int nr_records;
 
-	/* Mock one poison record at pi.offset for 64 bytes */
-	struct {
-		struct cxl_mbox_poison_out po;
-		struct cxl_poison_record record;
-	} __packed mock_plist = {
-		.po = {
-			.count = cpu_to_le16(1),
-		},
-		.record = {
-			.length = cpu_to_le32(1),
-			.address = cpu_to_le64(le64_to_cpu(pi->offset) +
-					       CXL_POISON_SOURCE_INJECTED),
-		},
-	};
+	po = cxl_get_injected_po(cxlds, offset, length);
+	nr_records = le16_to_cpu(po->count);
+	memcpy(cmd->payload_out, po, struct_size(po, record, nr_records));
+	cmd->size_out = struct_size(po, record, nr_records);
 
-	if (cmd->size_out < sizeof(mock_plist))
-		return -EINVAL;
-
-	memcpy(cmd->payload_out, &mock_plist, sizeof(mock_plist));
-	cmd->size_out = sizeof(mock_plist);
 	return 0;
 }
 
-- 
2.37.3

