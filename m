Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA50C433E0
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 23:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA036619D1
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 23:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhC3XhK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:37:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:9315 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232589AbhC3Xgs (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 30 Mar 2021 19:36:48 -0400
IronPort-SDR: PWTBxwIQaWKg0RqqwlYvhDgs/o6A3LtP/aSz4+qX1cCCeDN9hqIR5V3ozrfWHpy/e+wkgKyixo
 sdpoSg1Y5YaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="191906900"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="191906900"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 16:36:46 -0700
IronPort-SDR: zZgA7hv86s7QqvAuypkzGl78KFxI2RxRzPA1x0y5WVsNSEYDJzT0o/QSu8JMEOtufiqnDWHZNX
 ER2OdyVAyg2g==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="445394300"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 16:36:43 -0700
Subject: [PATCH v3 3/4] cxl/mem: Do not rely on device_add() side effects
 for dev_set_name() failures
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com
Date:   Tue, 30 Mar 2021 16:36:42 -0700
Message-ID: <161714740233.2168142.11116065966198937093.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

While device_add() will happen to catch dev_set_name() failures it is a
broken pattern to follow given that the core may try to fall back to a
different name.

Add explicit checking for dev_set_name() failures to be cleaned up by
put_device(). Skip cdev_device_add() and proceed directly to
put_device() if the name set fails.

This type of bug is easier to see if 'alloc' is split from 'add'
operations that require put_device() on failure. So cxl_memdev_alloc()
is split out as a result.

Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |   41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 2cf620d201a6..759713b619ab 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1187,7 +1187,7 @@ static void cxl_memdev_unregister(void *_cxlmd)
 	put_device(dev);
 }
 
-static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
+static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
 {
 	struct pci_dev *pdev = cxlm->pdev;
 	struct cxl_memdev *cxlmd;
@@ -1197,11 +1197,11 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 
 	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
 	if (!cxlmd)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	rc = ida_alloc_range(&cxl_memdev_ida, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
 	if (rc < 0)
-		goto err_id;
+		goto err;
 	cxlmd->id = rc;
 
 	dev = &cxlmd->dev;
@@ -1210,29 +1210,48 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
 	dev->type = &cxl_memdev_type;
-	dev_set_name(dev, "mem%d", cxlmd->id);
 
 	cdev = &cxlmd->cdev;
 	cdev_init(cdev, &cxl_memdev_fops);
+	return cxlmd;
+
+err:
+	kfree(cxlmd);
+	return ERR_PTR(rc);
+}
+
+static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
+{
+	struct cxl_memdev *cxlmd;
+	struct device *dev;
+	struct cdev *cdev;
+	int rc;
+
+	cxlmd = cxl_memdev_alloc(cxlm);
+	if (IS_ERR(cxlmd))
+		return PTR_ERR(cxlmd);
+
+	dev = &cxlmd->dev;
+	rc = dev_set_name(dev, "mem%d", cxlmd->id);
+	if (rc)
+		goto err;
 
+	cdev = &cxlmd->cdev;
 	cxl_memdev_activate(cxlmd, cxlm);
 	rc = cdev_device_add(cdev, dev);
 	if (rc)
-		goto err_add;
+		goto err;
 
-	return devm_add_action_or_reset(&pdev->dev, cxl_memdev_unregister,
+	return devm_add_action_or_reset(dev->parent, cxl_memdev_unregister,
 					cxlmd);
 
-err_add:
+err:
 	/*
 	 * The cdev was briefly live, shutdown any ioctl operations that
 	 * saw that state.
 	 */
 	cxl_memdev_shutdown(cxlmd);
-	ida_free(&cxl_memdev_ida, cxlmd->id);
-err_id:
-	kfree(cxlmd);
-
+	put_device(dev);
 	return rc;
 }
 

