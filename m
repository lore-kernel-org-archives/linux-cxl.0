Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638A4C6FD19
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Mar 2023 18:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjCJStd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Mar 2023 13:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCJStc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Mar 2023 13:49:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95131E190D
        for <linux-cxl@vger.kernel.org>; Fri, 10 Mar 2023 10:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678474171; x=1710010171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nUrQkHorGsPws7mIhp79mmrsAsjr4Bw+nOJj+7/gM90=;
  b=X38RvQufithso0mEZAJJOcBn2GS4BbrpMESh2WBu/pnciqNE4fJcwGmh
   X81DQF+vfscIfOwJtNl3oFJtx86EhhejHu35zEbyRhT2kJlyC62WcYVpS
   CZyZJSTyeZc/epygqEWWQPH6IXIvBBW5uoZlKDvoUBP43+FTMpJczt1jJ
   RwpG822gZsy5SSAYvhwsBewSADskGWQ2GLtkQBKHC60+eNnsLXwRrTPew
   Vq9rHFeDeZe0oS2ZsKeF95qDkajkImCafl3popEuGVTOP7EY7ni49FbkH
   R1Pbq2+pU1TYxbJM8eLbEf+ze2uburLZmJYXsTrw1JS66ZwsUXkgBVFeA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="336824163"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="336824163"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 10:49:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="627906750"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="627906750"
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
Subject: [PATCH v4 6/8] tools/testing/cxl: Add a sysfs attr to test poison injection limits
Date:   Fri, 10 Mar 2023 10:49:07 -0800
Message-Id: <4ffd7453d7e9cb2575363f0ce442eb92f3c8d915.1678471465.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1678471465.git.alison.schofield@intel.com>
References: <cover.1678471465.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices may report a maximum number of addresses that a device
allows to be poisoned using poison injection. When cxl_test creates
mock CXL memory devices, it defaults to MOCK_INJECT_DEV_MAX==8 for
all mocked memdevs.

Add a sysfs attribute, poison_inject_max to module cxl_mock_mem so
that users can set a custom device injection limit. Fail, and return
-EBUSY, if the mock poison list is not empty.

/sys/bus/platform/drivers/cxl_mock_mem/poison_inject_max

A simple usage model is to set the attribute before running a test in
order to emulate a device's poison handling.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tools/testing/cxl/test/mem.c | 52 +++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 9658d95236b7..5c3b3e5a3b4b 100644
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
@@ -919,7 +921,7 @@ static struct cxl_mbox_poison_payload_out
 	int nr_records = 0;
 	u64 dpa;
 
-	po = kzalloc(struct_size(po, record, MOCK_INJECT_DEV_MAX), GFP_KERNEL);
+	po = kzalloc(struct_size(po, record, poison_inject_dev_max), GFP_KERNEL);
 	if (!po)
 		return NULL;
 
@@ -934,7 +936,7 @@ static struct cxl_mbox_poison_payload_out
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

