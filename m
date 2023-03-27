Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB7BC7619A
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 05:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjC0FDd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjC0FD3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 01:03:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76F74ECE
        for <linux-cxl@vger.kernel.org>; Sun, 26 Mar 2023 22:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679893408; x=1711429408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WAv51r/GHPCocb0ndW4vWbeVQ+VrUTXGjc45AFEw9zg=;
  b=MNCZRCcC2eM7EI5HZGDTOMmvuAoqXubwjFual1ghITGAHAStyc0oOsID
   KUhfNWvMmeNlob3Av9SropNq/++Dnbm/sjj2QElUWRzh66c5gTX+YMQ7B
   bV3n0BtgcFANl4hUvjKeTLp/nsxifoTdzOMpDQS4iMhCKYiTyWJf6M8Ln
   AihCTNEvZQKvf6YFQ9/Cjk35FjOJkPGC5AGBOqEEbDA321LBFJfPW+YKA
   84LREOqfQYHmxAeW/8/T9nBTKLNmvP5ARrYySdHCKgTyEZ4LfnML5wV8I
   yWxlprWY5EKnSx9Sn+09pKP3nLTJiUpQ8hzbeO3mJo3+v9iIRgrvMB2Qy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367920214"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="367920214"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="633492291"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="633492291"
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
Subject: [PATCH v5 11/12] tools/testing/cxl: Add a sysfs attr to test poison inject limits
Date:   Sun, 26 Mar 2023 22:03:17 -0700
Message-Id: <8c6a37f71095be970eb04cc1e2ab2cdb08062020.1679892337.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679892337.git.alison.schofield@intel.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
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

