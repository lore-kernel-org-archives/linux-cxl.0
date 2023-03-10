Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC16BC6FA99
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Mar 2023 18:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjCJStc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Mar 2023 13:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCJStb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Mar 2023 13:49:31 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DE180E26
        for <linux-cxl@vger.kernel.org>; Fri, 10 Mar 2023 10:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678474170; x=1710010170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nDk3pV3liVAh1iI8uSZxNz8iRJV5YRcR+k+NYvbbV/M=;
  b=QKgHzWFJtxiA02Cx4PfmoWFS8vi4lMZ6z2WzDZ+xt1n4iPVZ/bvQYThT
   Rk0q6Kzo4pd07pLR7YK3MogPCyWY0zbu30Fn+PjU5r77LGVzGIUxPzqkZ
   eH7by6Pkedu+uaMaHNtrTDeWvLLkhnJu7TvynUSwGCmJBTSRnwCjRtIWH
   5LDLOtxlz8/Ex7e1sGrB/x9VFAHh1QLIw9CJVPTzQbYEoaUFNVXdo4rcV
   sylce9zDCoFrbduQhpGLvZ1IA6d928mr8e7Yud0ISMdz5UPNlixYJrN9D
   TG4mjBpla8qo04EmB5q+gebI0eLFlMT/fGa0Y5eZvp8+al5t4zVoNgPfl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="336824153"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="336824153"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 10:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="627906736"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="627906736"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.255.228.62])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 10:49:29 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 5/8] tools/testing/cxl: Use injected poison for get poison list
Date:   Fri, 10 Mar 2023 10:49:06 -0800
Message-Id: <af4aca72c45d33b5941de2c0b85b0c0c99ab5f34.1678471465.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1678471465.git.alison.schofield@intel.com>
References: <cover.1678471465.git.alison.schofield@intel.com>
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

