Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B798C7EE36
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 21:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCAVgp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 16:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCAVgo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 16:36:44 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13463525C
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 13:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677706603; x=1709242603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nDk3pV3liVAh1iI8uSZxNz8iRJV5YRcR+k+NYvbbV/M=;
  b=KdAf64GS5dzAsDPXdc0JgW40CFfQNgOTla94WEvqY3vUectHAybRBdhR
   qhEOfEZ60KOO/UCcf/c+IhGGx33m5ASwuzzdbFbwmTOYCg+46tvIp3mVV
   ukZ20kjLZHCXxPaoTP6FNijRIZckKnBGQGgZZfbd/RWTSAUAVTzRn6pNb
   G3ZnDvia9DTwwLSR8ocsnCuWgFUbFhiiJAAX4vd0fDjSw4+6JEnKvuQVE
   s7Id/opC5HIA45hdUzQgCV8cxbPPySDxkOVCTMNKB/4Xj7wD+5HVc6NOZ
   3s3TyooGbNAZOSbLv4/Cj19mbPkz+nArBLeHixdklZ7EnhsFt9PaVn5co
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397094692"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="397094692"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 13:36:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="784520812"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="784520812"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.70.38])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 13:36:42 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 5/8] tools/testing/cxl: Use injected poison for get poison list
Date:   Wed,  1 Mar 2023 13:36:30 -0800
Message-Id: <cd2cabe74e7084ce5ebd234b9527ff9d1ed4aa2a.1677704994.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1677704994.git.alison.schofield@intel.com>
References: <cover.1677704994.git.alison.schofield@intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tools/testing/cxl/test/mem.c | 59 ++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 720147c7cb2b..9658d95236b7 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -912,31 +912,52 @@ static struct mock_poison {
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
+	int nr_records;
 
-	/* Mock one poison record at pi.offset for 64 bytes */
-	struct {
-		struct cxl_mbox_poison_payload_out po;
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

