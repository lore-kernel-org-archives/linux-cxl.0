Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2244C433B4
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Apr 2021 17:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8C961055
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Apr 2021 17:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbhDAR7C (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:59:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:19607 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236661AbhDAR4w (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 1 Apr 2021 13:56:52 -0400
IronPort-SDR: AX5nJ24uY16xoJuteTFFi7z1uh/uI9DH3VbPAWsIoCtxSZvtTd6nXNOWVAzFXRX5KsjdNQ5ElK
 6xm8f3HQ7i0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="171672288"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="171672288"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:33:26 -0700
IronPort-SDR: TPKZmusLrat2Xkrpao5AswEy2nNIJ6IsGuVSucqQthUBhMq8Vg+pDKH4qFxe+p2bq5aYnDMdJl
 nBuXGowKyGuA==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="596360460"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:33:25 -0700
Subject: [PATCH v4 3/4] cxl/mem: Do not rely on device_add() side effects
 for dev_set_name() failures
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Thu, 01 Apr 2021 07:33:25 -0700
Message-ID: <161728760514.2474381.1163928273337158134.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161728758895.2474381.12683589190335430004.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161728758895.2474381.12683589190335430004.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |   39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index c77d375fad95..e59b373694d3 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1180,7 +1180,7 @@ static void cxl_memdev_unregister(void *_cxlmd)
 	put_device(dev);
 }
 
-static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
+static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
 {
 	struct pci_dev *pdev = cxlm->pdev;
 	struct cxl_memdev *cxlmd;
@@ -1190,11 +1190,11 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 
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
@@ -1203,10 +1203,31 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
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
 
 	/*
 	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
@@ -1214,23 +1235,21 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	 */
 	cxlmd->cxlm = cxlm;
 
+	cdev = &cxlmd->cdev;
 	rc = cdev_device_add(cdev, dev);
 	if (rc)
-		goto err_add;
+		goto err;
 
 	return devm_add_action_or_reset(dev->parent, cxl_memdev_unregister,
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
 

