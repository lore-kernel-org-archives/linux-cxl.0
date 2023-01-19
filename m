Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF57C38142
	for <linux-cxl@archiver.kernel.org>; Thu, 19 Jan 2023 05:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjASFI5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 19 Jan 2023 00:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjASFIF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 19 Jan 2023 00:08:05 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FDE7571F
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 21:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674104589; x=1705640589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lt8UNnjN9GtqzNvv9IUgmlMwC3LdSxDlhaDPgJFZncs=;
  b=k95xtjno5qekiZgJhQTz5fAaEqBwf898yUbubcsYVbPD8oC54dK9Djkz
   uEuw9a58bkThqXPq+iOSj3SVZQMYQS2niqE8XMt4RBMD6fXPMmGHIceKc
   MtehDHU/aAuHnsi1WMSZZZYtZ+r2YRBmxFckfu27IcSxsuuDGYKkZ6xt/
   pF04om7PQco4ShfCtsfa6hKIYNMdWqYJ6yLQeDjBCKMPllNt9qJsdgusO
   hPrbySXtr73aKHT81Jye5xAmVxMJg0NNbNW1nD+FSfQp9jKmGAkyVRv0U
   JJbHOJMoCOVGBwLgjd/KyIlF+l1YJE2nr5tbLEHkDg8QdGxIcdJ3Owbv1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="304881278"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="304881278"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 21:00:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="783932587"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="783932587"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.119.104])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 21:00:29 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2 6/6] tools/testing/cxl: Add a param to test poison injection limits
Date:   Wed, 18 Jan 2023 21:00:21 -0800
Message-Id: <25a3d2a144a9dcc8ce1da241a72917eb7d6ad3f2.1674101475.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1674101475.git.alison.schofield@intel.com>
References: <cover.1674101475.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices may report a maximum number of addresses that a device
allows to be poisoned using poison injection. When cxl_test creates
mock CXL memory devices, it uses MOCK_INJECT_DEV_MAX (8) for all
mocked memdevs.

Add a module parameter, param_inject_dev_max to module cxl_mock_mem
so that testers can set custom injection limits.

Example: Set MOCK_INJECT_DEV_MAX to 7
$ echo 7 > /sys/module/cxl_mock_mem/parameters/param_inject_dev_max

A simple usage model is to set it before running a test in order to
emulate a device's poison handling. Changing the max value in the
midst of inject, clear, and get poison flows, needs to be carefully
managed by the user.

For example, if the max is reduced after more than max errors are
injected, those errors will remain in the poison list and may need
to be cleared out even though a request to read the poison list will
not show more than max. The driver does not clear out the errors that
are over max when this parameter changes.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/mem.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 14d74bfb3124..5b938283c1d7 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -17,6 +17,8 @@
 #define MOCK_INJECT_DEV_MAX 8
 #define MOCK_INJECT_TEST_MAX 128
 
+int param_inject_dev_max = MOCK_INJECT_DEV_MAX;
+
 static struct cxl_cel_entry mock_cel[] = {
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_LOGS),
@@ -155,7 +157,7 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 			cpu_to_le64(SZ_256M / CXL_CAPACITY_MULTIPLIER),
 		.total_capacity =
 			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
-		.inject_poison_limit = cpu_to_le16(MOCK_INJECT_DEV_MAX),
+		.inject_poison_limit = cpu_to_le16(param_inject_dev_max),
 	};
 
 	put_unaligned_le24(CXL_POISON_LIST_MAX, id.poison_list_max_mer);
@@ -589,7 +591,7 @@ static struct cxl_mbox_poison_payload_out
 	int nr_records = 0;
 	u64 dpa;
 
-	po = kzalloc(struct_size(po, record, MOCK_INJECT_DEV_MAX), GFP_KERNEL);
+	po = kzalloc(struct_size(po, record, param_inject_dev_max), GFP_KERNEL);
 	if (!po)
 		return NULL;
 
@@ -604,7 +606,7 @@ static struct cxl_mbox_poison_payload_out
 		po->record[nr_records].address = cpu_to_le64(dpa);
 		po->record[nr_records].length = cpu_to_le32(1);
 		nr_records++;
-		if (nr_records == MOCK_INJECT_DEV_MAX)
+		if (nr_records == param_inject_dev_max)
 			break;
 	}
 
@@ -638,7 +640,7 @@ static bool mock_poison_dev_max_injected(struct cxl_dev_state *cxlds)
 		if (mock_poison_list[i].cxlds == cxlds)
 			count++;
 	}
-	return (count >= MOCK_INJECT_DEV_MAX);
+	return (count >= param_inject_dev_max);
 }
 
 static bool mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
@@ -909,6 +911,9 @@ static struct platform_driver cxl_mock_mem_driver = {
 	},
 };
 
+module_param(param_inject_dev_max, int, 0644);
+MODULE_PARM_DESC(param_inject_dev_max, "Maximum number of physical addresses that can be poisoned in the mock device. The default is 8. The cxl_test driver limit is 128 across all mock devices.");
+
 module_platform_driver(cxl_mock_mem_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
-- 
2.37.3

