Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38488C432BE
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1476D60F25
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGWU0D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:34284 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhGWU0D (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671186"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671186"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436116"
Received: from rfrederi-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.136.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:35 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 05/23] cxl: Pass fops and shutdown to memdev creation
Date:   Fri, 23 Jul 2021 14:06:05 -0700
Message-Id: <20210723210623.114073-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Drivers that use cxl_core for registering a cxl_memdev will likely
require synchronization with the core for shutdown so as to not race
against the device going away. The main example currently is with the
ioctl interface. Through the duration of the ioctl it's expected that
the underlying memdev will not disappear.

Additionally, it may be desirable to have the fops be passed along as
well for drivers which do not want the standard handler for the
character device's ioctl.

As memdev is being migrated to core, this separation must be made.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.h |  2 ++
 drivers/cxl/pci.c | 23 +++++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 2092f86beeb8..2b7481376621 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -42,12 +42,14 @@ extern int cxl_mem_major;
  * @cdev: char dev core object for ioctl operations
  * @cxlm: pointer to the parent device driver data
  * @id: id number of this memdev instance.
+ * @shutdown: Optional function to call on memory device shutdown.
  */
 struct cxl_memdev {
 	struct device dev;
 	struct cdev cdev;
 	struct cxl_mem *cxlm;
 	int id;
+	void (*shutdown)(struct cxl_memdev *cxlmd);
 };
 
 /**
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0d9091379963..e90b8fb6dc08 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1293,11 +1293,13 @@ static void cxl_memdev_unregister(void *_cxlmd)
 	struct device *dev = &cxlmd->dev;
 
 	cdev_device_del(&cxlmd->cdev, dev);
-	cxl_memdev_shutdown(cxlmd);
+	if (cxlmd->shutdown)
+		cxlmd->shutdown(cxlmd);
 	put_device(dev);
 }
 
-static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
+static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm,
+					   const struct file_operations *fops)
 {
 	struct pci_dev *pdev = cxlm->pdev;
 	struct cxl_memdev *cxlmd;
@@ -1323,7 +1325,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
 	device_set_pm_not_required(dev);
 
 	cdev = &cxlmd->cdev;
-	cdev_init(cdev, &cxl_memdev_fops);
+	cdev_init(cdev, fops);
 	return cxlmd;
 
 err:
@@ -1331,15 +1333,17 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
 	return ERR_PTR(rc);
 }
 
-static struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-					      struct cxl_mem *cxlm)
+static struct cxl_memdev *
+devm_cxl_add_memdev(struct device *host, struct cxl_mem *cxlm,
+		    const struct file_operations *fops,
+		    void (*shutdown)(struct cxl_memdev *cxlmd))
 {
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
 	struct cdev *cdev;
 	int rc;
 
-	cxlmd = cxl_memdev_alloc(cxlm);
+	cxlmd = cxl_memdev_alloc(cxlm, fops);
 	if (IS_ERR(cxlmd))
 		return cxlmd;
 
@@ -1362,6 +1366,7 @@ static struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
 	if (rc)
 		return ERR_PTR(rc);
+	cxlmd->shutdown = shutdown;
 	return cxlmd;
 
 err:
@@ -1369,7 +1374,8 @@ static struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 	 * The cdev was briefly live, shutdown any ioctl operations that
 	 * saw that state.
 	 */
-	cxl_memdev_shutdown(cxlmd);
+	if (shutdown)
+		shutdown(cxlmd);
 	put_device(dev);
 	return ERR_PTR(rc);
 }
@@ -1610,7 +1616,8 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlm);
+	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlm, &cxl_memdev_fops,
+				    cxl_memdev_shutdown);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
-- 
2.32.0

