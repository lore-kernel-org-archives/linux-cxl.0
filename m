Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D96C7EE23
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjFDXd0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjFDXdZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:33:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD55FAB
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921604; x=1717457604;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ly1dwLT8xwGyRLNX4vHtq07lTD/sXeyOGRcIYXgsl8w=;
  b=Gc34fs/8BuLKOct6gD2Jz/CF64ouIvt9GnOrNsQsKeRFCkqCBPXryJfK
   5Uz3CJIyv+2SyOV2xN95xXu08ujwl654iKILFb7lgAmJn6bBK6n2m8G0g
   p9p57gGrhtRhD8BVXcX9dYW6jvkyK8vNL/xPtH8Op81cxurrzLnl3AOG8
   KXKNfOz9Qe8WeDHIYs9MEMAsRZIElf6MJ2PGoMU5X/fzm/KFos9/qSqv5
   tkcucrpQT+BmfVnL21DwIDVkr/ceirZkNtsseo/nn2ikd/7jvdh9w7q+5
   j2MvccMiqgbes9jfb60IoB1nG3UfYDzl8BPcCSXTQOUsS8MgQl1H5dgmG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="353734245"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="353734245"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:33:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="658874838"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="658874838"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:33:24 -0700
Subject: [PATCH 19/19] tools/testing/cxl: Emulate a CXL accelerator with
 local memory
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:33:23 -0700
Message-ID: <168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Mock-up a device that does not have a standard mailbox, i.e. a device
that does not implement the CXL memory-device class code, but wants to
map "device" memory (aka Type-2, aka HDM-D[B], aka accelerator memory).

For extra code coverage make this device an RCD to test region creation
flows in the presence of an RCH topology (memory device modeled as a
root-complex-integrated-endpoint RCIEP).

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c    |   15 +++++++
 drivers/cxl/cxlmem.h         |    1 
 tools/testing/cxl/test/cxl.c |   16 +++++++-
 tools/testing/cxl/test/mem.c |   85 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 112 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 859c43c340bb..5d1ba7a72567 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -467,6 +467,21 @@ static void detach_memdev(struct work_struct *work)
 	put_device(&cxlmd->dev);
 }
 
+struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
+{
+	struct cxl_dev_state *cxlds;
+
+	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
+	if (!cxlds)
+		return ERR_PTR(-ENOMEM);
+
+	cxlds->dev = dev;
+	cxlds->type = CXL_DEVTYPE_DEVMEM;
+
+	return cxlds;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
+
 static struct lock_class_key cxl_memdev_key;
 
 static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ad7f806549d3..89e560ea14c0 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -746,6 +746,7 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
 int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
+struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index e3f1b2e88e3e..385cdeeab22c 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -278,7 +278,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE2 |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = 5,
 			.window_size = SZ_256M,
@@ -713,7 +713,19 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
 
 	cxld->interleave_ways = 1;
 	cxld->interleave_granularity = 256;
-	cxld->target_type = CXL_DECODER_HOSTMEM;
+	if (is_endpoint_decoder(&cxld->dev)) {
+		struct cxl_endpoint_decoder *cxled;
+		struct cxl_dev_state *cxlds;
+		struct cxl_memdev *cxlmd;
+
+		cxled = to_cxl_endpoint_decoder(&cxld->dev);
+		cxlmd = cxled_to_memdev(cxled);
+		cxlds = cxlmd->cxlds;
+		if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
+			cxld->target_type = CXL_DECODER_HOSTMEM;
+		else
+			cxld->target_type = CXL_DECODER_DEVMEM;
+	}
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
 }
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 6fb5718588f3..620bfcf5e5a5 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1189,11 +1189,21 @@ static void label_area_release(void *lsa)
 	vfree(lsa);
 }
 
+#define CXL_MOCKMEM_RCD BIT(0)
+#define CXL_MOCKMEM_TYPE2 BIT(1)
+
 static bool is_rcd(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 
-	return !!id->driver_data;
+	return !!(id->driver_data & CXL_MOCKMEM_RCD);
+}
+
+static bool is_type2(struct platform_device *pdev)
+{
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+
+	return !!(id->driver_data & CXL_MOCKMEM_TYPE2);
 }
 
 static ssize_t event_trigger_store(struct device *dev,
@@ -1205,7 +1215,7 @@ static ssize_t event_trigger_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(event_trigger);
 
-static int cxl_mock_mem_probe(struct platform_device *pdev)
+static int __cxl_mock_mem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct cxl_memdev *cxlmd;
@@ -1274,6 +1284,75 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int cxl_mock_type2_probe(struct platform_device *pdev)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct device *dev = &pdev->dev;
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_dev_state *cxlds;
+	struct cxl_port *endpoint;
+	struct cxl_memdev *cxlmd;
+	resource_size_t max = 0;
+	int rc;
+
+	cxlds = cxl_accel_state_create(dev);
+	if (IS_ERR(cxlds))
+		return PTR_ERR(cxlds);
+
+	cxlds->serial = pdev->id;
+	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
+	cxlds->dpa_res = DEFINE_RES_MEM(0, DEV_SIZE);
+	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, DEV_SIZE, "ram");
+	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(DEV_SIZE, 0, "pmem");
+	if (is_rcd(pdev))
+		cxlds->rcd = true;
+
+	rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
+	if (rc)
+		return rc;
+
+	cxlmd = devm_cxl_add_memdev(cxlds);
+	if (IS_ERR(cxlmd))
+		return PTR_ERR(cxlmd);
+
+	endpoint = cxl_acquire_endpoint(cxlmd);
+	if (IS_ERR(endpoint))
+		return PTR_ERR(endpoint);
+
+	cxlrd = cxl_hpa_freespace(endpoint, &endpoint->host_bridge, 1,
+				  CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+				  &max);
+
+	if (IS_ERR(cxlrd)) {
+		rc = PTR_ERR(cxlrd);
+		goto out;
+	}
+
+	cxled = cxl_request_dpa(endpoint, CXL_DECODER_RAM, 0, max);
+	if (IS_ERR(cxled)) {
+		rc = PTR_ERR(cxled);
+		goto out_cxlrd;
+	}
+
+	/* A real driver would do something with the returned region */
+	rc = PTR_ERR_OR_ZERO(cxl_create_region(cxlrd, &cxled, 1));
+
+	put_device(cxled_dev(cxled));
+out_cxlrd:
+	put_device(cxlrd_dev(cxlrd));
+out:
+	cxl_release_endpoint(cxlmd, endpoint);
+
+	return rc;
+}
+
+static int cxl_mock_mem_probe(struct platform_device *pdev)
+{
+	if (is_type2(pdev))
+		return cxl_mock_type2_probe(pdev);
+	return __cxl_mock_mem_probe(pdev);
+}
+
 static ssize_t security_lock_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -1316,7 +1395,7 @@ ATTRIBUTE_GROUPS(cxl_mock_mem);
 
 static const struct platform_device_id cxl_mock_mem_ids[] = {
 	{ .name = "cxl_mem", 0 },
-	{ .name = "cxl_rcd", 1 },
+	{ .name = "cxl_rcd", CXL_MOCKMEM_RCD | CXL_MOCKMEM_TYPE2 },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, cxl_mock_mem_ids);

