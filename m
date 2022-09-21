Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD1BC6FA91
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Sep 2022 15:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIUPir (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Sep 2022 11:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIUPia (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Sep 2022 11:38:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBD39C2F9
        for <linux-cxl@vger.kernel.org>; Wed, 21 Sep 2022 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663774448; x=1695310448;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kldGzN2oeJ5eOYTeA77bCFuL1F9ndfSRRHY47jbc2gE=;
  b=Yl1GMOLDInYDaDvYGiP0K6kVQyPz0ZR7iyufvmCjOc+NCo//QHiA3Ngl
   /o4RI4p1MM/jUnWRX+P9/QYQQ4NZKmd1PcyCJqeC82F/hLVvR3Oizfvo4
   isw8uvDlyMOQMuJunUR6xBtP69kLjlDsShtx9FzkKbqU9UlE1YOZT1L72
   Mfok/lSR5LBiM45rr4BqPEgnxpFmd1/OZDRFBCBBantppYCO2TX3ySrRx
   3IM8zsFQCqUXOmXZHVcWeEkwK4iP6/WrCURPu/Cp+sVpP0CXpZ5ofFlyz
   ydt3OpUaQIfBsA3prrenL4xTqo3E7+s2erwe6BYZbC+PH8M9Oa1MLrYny
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="326349557"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="326349557"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:31:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="652579011"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:31:45 -0700
Subject: [PATCH v2 03/19] tools/testing/cxl: Add "Get Security State" opcode
 support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, dan.j.williams@intel.com,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dave@stgolabs.net,
        Jonathan.Cameron@huawei.com
Date:   Wed, 21 Sep 2022 08:31:45 -0700
Message-ID: <166377430503.430546.4463791056925632016.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add the emulation support for handling "Get Security State" opcode for a
CXL memory device for the cxl_test. The function will copy back device
security state bitmask to the output payload.

The security state data is added as platform_data for the mock mem device.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c       |   18 ++++++++++++++++++
 tools/testing/cxl/test/mem.c       |   20 ++++++++++++++++++++
 tools/testing/cxl/test/mem_pdata.h |   10 ++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 tools/testing/cxl/test/mem_pdata.h

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index a072b2d3e726..6dd286a52839 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <cxlmem.h>
 #include "mock.h"
+#include "mem_pdata.h"
 
 #define NR_CXL_HOST_BRIDGES 2
 #define NR_CXL_ROOT_PORTS 2
@@ -629,8 +630,18 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
 
 static __init int cxl_test_init(void)
 {
+	struct cxl_mock_mem_pdata *mem_pdata;
 	int rc, i;
 
+	/*
+	 * Only a zeroed copy of this data structure is needed since no
+	 * additional initialization is needed for initial state.
+	 * platform_device_add_data() will make a copy of this data.
+	 */
+	mem_pdata = kzalloc(sizeof(*mem_pdata), GFP_KERNEL);
+	if (!mem_pdata)
+		return -ENOMEM;
+
 	register_cxl_mock_ops(&cxl_mock_ops);
 
 	cxl_mock_pool = gen_pool_create(ilog2(SZ_2M), NUMA_NO_NODE);
@@ -735,6 +746,12 @@ static __init int cxl_test_init(void)
 		pdev->dev.parent = &dport->dev;
 		set_dev_node(&pdev->dev, i % 2);
 
+		rc = platform_device_add_data(pdev, mem_pdata, sizeof(*mem_pdata));
+		if (rc) {
+			platform_device_put(pdev);
+			goto err_mem;
+		}
+
 		rc = platform_device_add(pdev);
 		if (rc) {
 			platform_device_put(pdev);
@@ -785,6 +802,7 @@ static __init int cxl_test_init(void)
 	gen_pool_destroy(cxl_mock_pool);
 err_gen_pool_create:
 	unregister_cxl_mock_ops(&cxl_mock_ops);
+	kfree(mem_pdata);
 	return rc;
 }
 
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index aa2df3a15051..9002a3ae3ea5 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -8,6 +8,7 @@
 #include <linux/sizes.h>
 #include <linux/bits.h>
 #include <cxlmem.h>
+#include "mem_pdata.h"
 
 #define LSA_SIZE SZ_128K
 #define DEV_SIZE SZ_2G
@@ -137,6 +138,22 @@ static int mock_partition_info(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
+static int mock_get_security_state(struct cxl_dev_state *cxlds,
+				   struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mock_mem_pdata *mdata = dev_get_platdata(cxlds->dev);
+
+	if (cmd->size_in)
+		return -EINVAL;
+
+	if (cmd->size_out != sizeof(u32))
+		return -EINVAL;
+
+	memcpy(cmd->payload_out, &mdata->security_state, sizeof(u32));
+
+	return 0;
+}
+
 static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_get_lsa *get_lsa = cmd->payload_in;
@@ -230,6 +247,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_GET_HEALTH_INFO:
 		rc = mock_health_info(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_GET_SECURITY_STATE:
+		rc = mock_get_security_state(cxlds, cmd);
+		break;
 	default:
 		break;
 	}
diff --git a/tools/testing/cxl/test/mem_pdata.h b/tools/testing/cxl/test/mem_pdata.h
new file mode 100644
index 000000000000..6a7b111147eb
--- /dev/null
+++ b/tools/testing/cxl/test/mem_pdata.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _MEM_PDATA_H_
+#define _MEM_PDATA_H_
+
+struct cxl_mock_mem_pdata {
+	u32 security_state;
+};
+
+#endif


