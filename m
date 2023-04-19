Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7A4C6FD18
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Apr 2023 03:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjDSD1K (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjDSD04 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 23:26:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B6493F6
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 20:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681874814; x=1713410814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BWvik+Pkfnhmj7RrC2Qb+YwHKpEuiVQo/bVZIarL1D4=;
  b=HD+29POKbuk+oeNYX2p5V+9Xe8YJk8UJJeokWcF/5udEztW9+f/kj478
   JrLRm7a0SZEzllP66/UaBKrcq989aAQLN2DS2dtCJh2xl8Q2HbZt40oOA
   lBrBh0DPHFu2KwTNwOM72oxJStKD27+fGDGz4dbp5UVQHgGP/D/kIxHr4
   8GrnmL3xY2TsATJ6EL4d5KhM6NjFDMXtUEUPXlbo09R3cZpJb+iky7pfU
   Y2iabv5PG0SXfIz8Ha8GwDTSBKPAJS0bbAFweM8dv9PyrMM7IVI7e/zIA
   5zfkNZyO9zmoKfUpR7FZTA5ipgOnx3NoqRut51C+rmeTY2UbYsBrIfGAI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431621749"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="431621749"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780711156"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="780711156"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:53 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v6 09/10] tools/testing/cxl: Add a sysfs attr to test poison inject limits
Date:   Tue, 18 Apr 2023 20:26:33 -0700
Message-Id: <0f25b2862b90013545450222d2199e435c6cc11a.1681874357.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1681874357.git.alison.schofield@intel.com>
References: <cover.1681874357.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices may report a maximum number of addresses that a device
allows to be poisoned using poison injection. When cxl_test creates
mock CXL memory devices, it defaults to MOCK_INJECT_DEV_MAX==88 for
all mocked memdevs.

Add a sysfs attribute, poison_inject_max to module cxl_mock_mem so
that users can set a custom device injection limit. Fail, and return
-EBUSY, if the mock poison list is not empty.

/sys/bus/platform/drivers/cxl_mock_mem/poison_inject_max

A simple usage model is to set the attribute before running a test in
order to emulate a device's poison handling.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 52 +++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index cce7ec8f0efb..da27658f7dd6 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -19,6 +19,8 @@
 #define MOCK_INJECT_DEV_MAX 8
 #define MOCK_INJECT_TEST_MAX 128
 
+static unsigned int poison_inject_dev_max = MOCK_INJECT_DEV_MAX;
+
 static struct cxl_cel_entry mock_cel[] = {
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_LOGS),
@@ -485,7 +487,7 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 			cpu_to_le64(SZ_256M / CXL_CAPACITY_MULTIPLIER),
 		.total_capacity =
 			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
-		.inject_poison_limit = cpu_to_le16(MOCK_INJECT_DEV_MAX),
+		.inject_poison_limit = cpu_to_le16(MOCK_INJECT_TEST_MAX),
 	};
 
 	put_unaligned_le24(CXL_POISON_LIST_MAX, id.poison_list_max_mer);
@@ -919,7 +921,7 @@ static struct cxl_mbox_poison_out
 	int nr_records = 0;
 	u64 dpa;
 
-	po = kzalloc(struct_size(po, record, MOCK_INJECT_DEV_MAX), GFP_KERNEL);
+	po = kzalloc(struct_size(po, record, poison_inject_dev_max), GFP_KERNEL);
 	if (!po)
 		return NULL;
 
@@ -934,7 +936,7 @@ static struct cxl_mbox_poison_out
 		po->record[nr_records].address = cpu_to_le64(dpa);
 		po->record[nr_records].length = cpu_to_le32(1);
 		nr_records++;
-		if (nr_records == MOCK_INJECT_DEV_MAX)
+		if (nr_records == poison_inject_dev_max)
 			break;
 	}
 
@@ -969,7 +971,7 @@ static bool mock_poison_dev_max_injected(struct cxl_dev_state *cxlds)
 		if (mock_poison_list[i].cxlds == cxlds)
 			count++;
 	}
-	return (count >= MOCK_INJECT_DEV_MAX);
+	return (count >= poison_inject_dev_max);
 }
 
 static bool mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
@@ -1051,6 +1053,47 @@ static int mock_clear_poison(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
+static bool mock_poison_list_empty(void)
+{
+	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
+		if (mock_poison_list[i].cxlds)
+			return false;
+	}
+	return true;
+}
+
+static ssize_t poison_inject_max_show(struct device_driver *drv, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", poison_inject_dev_max);
+}
+
+static ssize_t poison_inject_max_store(struct device_driver *drv,
+				       const char *buf, size_t len)
+{
+	int val;
+
+	if (kstrtoint(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (!mock_poison_list_empty())
+		return -EBUSY;
+
+	if (val <= MOCK_INJECT_TEST_MAX)
+		poison_inject_dev_max = val;
+	else
+		return -EINVAL;
+
+	return len;
+}
+
+static DRIVER_ATTR_RW(poison_inject_max);
+
+static struct attribute *cxl_mock_mem_core_attrs[] = {
+	&driver_attr_poison_inject_max.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(cxl_mock_mem_core);
+
 static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct device *dev = cxlds->dev;
@@ -1259,6 +1302,7 @@ static struct platform_driver cxl_mock_mem_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.dev_groups = cxl_mock_mem_groups,
+		.groups = cxl_mock_mem_core_groups,
 	},
 };
 
-- 
2.37.3

