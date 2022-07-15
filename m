Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A58C43334
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Jul 2022 21:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiGOVIt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Jul 2022 17:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGOVIs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Jul 2022 17:08:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE1419C1C
        for <linux-cxl@vger.kernel.org>; Fri, 15 Jul 2022 14:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657919327; x=1689455327;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5RHeJXI/DSKBOwxq0dyffmzXTzBt+vgqLxC2bhkenCQ=;
  b=U/Lyw9roD5j+rn5R+6XOj3yevHlZX+EJe10GEG4RYBErhGjyeiCx869s
   ppcXA8apmIrOBgJfNPPOREkx36rUMCinEvVJ0ewyeS3oxBiLZfI2ofV9J
   LWNo/2uaMkLaWu/IoW93Bxbdf6YoXH+cdnFLtA1a4EINM+E/9Z41flsnE
   eI7j6IcifWgF7AdrPXUOZEqCCWQfw95oQaAIMCc+XntsbmCQYPZGsJySo
   xAxPTKmDS/ZcugHUfN928VX5KLU+OEkBhoIqxA0HdJ3qD9u2Nl3IXUNRe
   kVDPHVUN+2XCbPHiWtpiCMgD26UUnCdaxPY4ujObRxy+0TfdGd9z1+UEs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="268921440"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="268921440"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 14:08:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="923658642"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 14:08:44 -0700
Subject: [PATCH RFC 02/15] tools/testing/cxl: Create context for cxl mock
 device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dave@stgolabs.net
Date:   Fri, 15 Jul 2022 14:08:44 -0700
Message-ID: <165791932409.2491387.9065856569307593223.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
References: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add context struct for mock device and move lsa under the context. This
allows additional information such as security status and other persistent
security data such as passphrase to be added for the emulated test device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 6b9239b2afd4..723378248321 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -9,6 +9,10 @@
 #include <linux/bits.h>
 #include <cxlmem.h>
 
+struct mock_mdev_data {
+	void *lsa;
+};
+
 #define LSA_SIZE SZ_128K
 #define EFFECT(x) (1U << x)
 
@@ -140,7 +144,8 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_get_lsa *get_lsa = cmd->payload_in;
-	void *lsa = dev_get_drvdata(cxlds->dev);
+	struct mock_mdev_data *mdata = dev_get_drvdata(cxlds->dev);
+	void *lsa = mdata->lsa;
 	u32 offset, length;
 
 	if (sizeof(*get_lsa) > cmd->size_in)
@@ -159,7 +164,8 @@ static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 static int mock_set_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_set_lsa *set_lsa = cmd->payload_in;
-	void *lsa = dev_get_drvdata(cxlds->dev);
+	struct mock_mdev_data *mdata = dev_get_drvdata(cxlds->dev);
+	void *lsa = mdata->lsa;
 	u32 offset, length;
 
 	if (sizeof(*set_lsa) > cmd->size_in)
@@ -237,9 +243,12 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	return rc;
 }
 
-static void label_area_release(void *lsa)
+static void cxl_mock_drvdata_release(void *data)
 {
-	vfree(lsa);
+	struct mock_mdev_data *mdata = data;
+
+	vfree(mdata->lsa);
+	vfree(mdata);
 }
 
 static int cxl_mock_mem_probe(struct platform_device *pdev)
@@ -247,13 +256,21 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct cxl_memdev *cxlmd;
 	struct cxl_dev_state *cxlds;
+	struct mock_mdev_data *mdata;
 	void *lsa;
 	int rc;
 
+	mdata = vmalloc(sizeof(*mdata));
+	if (!mdata)
+		return -ENOMEM;
+
 	lsa = vmalloc(LSA_SIZE);
-	if (!lsa)
+	if (!lsa) {
+		vfree(mdata);
 		return -ENOMEM;
-	rc = devm_add_action_or_reset(dev, label_area_release, lsa);
+	}
+
+	rc = devm_add_action_or_reset(dev, cxl_mock_drvdata_release, mdata);
 	if (rc)
 		return rc;
 	dev_set_drvdata(dev, lsa);


