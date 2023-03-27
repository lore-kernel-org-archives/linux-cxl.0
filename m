Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE40C7619A
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 05:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjC0FDa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjC0FD1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 01:03:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BBDAA
        for <linux-cxl@vger.kernel.org>; Sun, 26 Mar 2023 22:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679893406; x=1711429406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jy1UQLJ3GWQhq9KyEdeSl/Ei3C69x5gUL0OGBx9pdqg=;
  b=gbAHmP2NABZE4hLAZXWW1kThLVMo8tSZBX/qW32ubSKTv2UTsj++lbIo
   AMomO2eeHNXbNKkQrsnYyEpyFyIdi9iFUWJkEvBHSRxVetiQVUKz/9JKu
   9yj1l3NeeRPa0+RzJB+7UVOxRjFJQe2CpqnQWdtCw5oFxamnVRVctXX09
   dtyA2p5KTCZCkdol1Hdg8VVLw44tyPUgJR1WBWqndn1WuUu26Z+cl1143
   t6kUaRXQLQ6/wXvEFwa0v/PwdJRTYho2iU5qN+y1Utn1wwqdEX7BHQnvz
   ncWsEYiaWKdf98wx6oklHxNur4HGsKnivPE2O/kEufCWtbC0lC0hFdODC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367920207"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="367920207"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="633492283"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="633492283"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.227.2])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:26 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 09/12] tools/testing/cxl: Mock the Clear Poison mailbox command
Date:   Sun, 26 Mar 2023 22:03:15 -0700
Message-Id: <e2145b982de1d862188c725e7320f3a27d807db7.1679892337.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679892337.git.alison.schofield@intel.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
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

