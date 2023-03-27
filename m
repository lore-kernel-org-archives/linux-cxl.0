Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB25C761AF
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 05:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjC0FDc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjC0FD2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 01:03:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72784C3B
        for <linux-cxl@vger.kernel.org>; Sun, 26 Mar 2023 22:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679893407; x=1711429407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nDk3pV3liVAh1iI8uSZxNz8iRJV5YRcR+k+NYvbbV/M=;
  b=IG8qkKLTvHfIoA8vnPBjEXIbG/YJNruCUvvQe7p7Whw5kKhl6s+p97//
   4iyL+kyY+Ah0UDPWRNh6+OEESOBK0duKfFaAU9q+ACJRh65H/J0IygA+5
   46W6svfoSn1iDH/wQLGJbSnPGAH60FQ7yzuTLiA/eSjE4iLJclNsTfyXs
   EVgijSUs5GQ+WDzFATW5UbKJqHRBw9SvlFaAy88EghYuxh315GFhSxW5l
   wl5VMHJXJIn0pabwcTu3H/DgCC7r0HeyHboWO69eMxHaMZE445k07lFoC
   D6ti3xDzhoykZVV0pAoKckBaWcodpRjP5hblo/Xr4gTJ8G5I2HDOIiVKM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367920210"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="367920210"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="633492288"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="633492288"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.227.2])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:27 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 10/12] tools/testing/cxl: Use injected poison for get poison list
Date:   Sun, 26 Mar 2023 22:03:16 -0700
Message-Id: <ff7b560914fbb6e1a28705ad249cd40145832e3b.1679892337.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679892337.git.alison.schofield@intel.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
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

