Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C298C6FD18
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Apr 2023 03:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjDSD04 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjDSD0w (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 23:26:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C852D71
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 20:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681874810; x=1713410810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3e2/l4QBkvAZ8wc0c8F95mr4n38uklUJS5igjgj7alE=;
  b=fkBZUu8bo30DOpiQN6IdR4nsOdysSgzdKC5ajqHh9Tr/KY16M9o4WVe2
   yDbtmQcCeu/Ouo7HQ2b/oHtlKrqYORKLdM530gJrkQ7CZllMD/GWbeloA
   HWud5V6FozNTQQFZYRbMsKcZnDALqUcYg/CqXI4fs4/mPz7zceCiAU1AT
   ym8C+F+YrF0rTeOXfZGwrRE+urhlI78SFtvvIbZx2QG8kYWu45tMatR0h
   UU/duYUzhZslHxl+zL4NNna8pzAdVIJ2HTnBTdJdANVad4ziiRM+TvtDS
   VGBs09E6PtvqaaTGqLgOrsvlRYPtidA68sz+slA1E0HmByLtyb1HNYwyR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431621733"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="431621733"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780711131"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="780711131"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:50 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 07/10] tools/testing/cxl: Mock the Clear Poison mailbox command
Date:   Tue, 18 Apr 2023 20:26:31 -0700
Message-Id: <ecf19743c6572e60971bbd078f67d520cf5bca5d.1681874357.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1681874357.git.alison.schofield@intel.com>
References: <cover.1681874357.git.alison.schofield@intel.com>
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 2731ebbd175b..3c3909d30d03 100644
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

