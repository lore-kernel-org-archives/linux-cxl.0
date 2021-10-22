Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2F6C18E57
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29D560F22
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhJVSjh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:5583 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233955AbhJVSjf (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528944"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528944"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:17 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854648"
Received: from aagregor-mobl3.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.134.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:17 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH v2 12/28] cxl/core: Store component register base for memdevs
Date:   Fri, 22 Oct 2021 11:36:53 -0700
Message-Id: <20211022183709.1199701-13-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Bake component registers into the memdev creation API in order to be
able to use them as part of driver probing.

Component register base addresses are obtained through PCI mechanisms.
As such it makes most sense for the cxl_pci driver to obtain that
address. In order to reuse the port driver for enumerating decoder
resources for an endpoint, it is desirable to be able to add the
endpoint as a port.  Unfortunately, by the time an endpoint driver would
run, it no longer has any concept of the underlying PCI device (this is
done intentionally to provide separation between drivers).

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/memdev.c    |  5 +++--
 drivers/cxl/cxlmem.h         |  5 ++++-
 drivers/cxl/pci.c            | 17 ++++++++++++++++-
 tools/testing/cxl/test/mem.c |  3 ++-
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index bf1b04d00ff4..15762c16d83f 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -276,8 +276,8 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
-struct cxl_memdev *
-devm_cxl_add_memdev(struct cxl_mem *cxlm)
+struct cxl_memdev *devm_cxl_add_memdev(struct cxl_mem *cxlm,
+				       resource_size_t component_reg_phys)
 {
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
@@ -298,6 +298,7 @@ devm_cxl_add_memdev(struct cxl_mem *cxlm)
 	 * needed as this is ordered with cdev_add() publishing the device.
 	 */
 	cxlmd->cxlm = cxlm;
+	cxlmd->creg_base = component_reg_phys;
 
 	cdev = &cxlmd->cdev;
 	rc = cdev_device_add(cdev, dev);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c4f450ad434d..62fe8e2c59e4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -35,12 +35,14 @@
  * @cdev: char dev core object for ioctl operations
  * @cxlm: pointer to the parent device driver data
  * @id: id number of this memdev instance.
+ * @creg_base: register base of component registers
  */
 struct cxl_memdev {
 	struct device dev;
 	struct cdev cdev;
 	struct cxl_mem *cxlm;
 	int id;
+	resource_size_t creg_base;
 };
 
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
@@ -48,7 +50,8 @@ static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
 	return container_of(dev, struct cxl_memdev, dev);
 }
 
-struct cxl_memdev *devm_cxl_add_memdev(struct cxl_mem *cxlm);
+struct cxl_memdev *devm_cxl_add_memdev(struct cxl_mem *cxlm,
+				       resource_size_t component_reg_phys);
 
 /**
  * struct cxl_mbox_cmd - A command to be submitted to hardware.
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index d1adc759d051..96a312ed8269 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -421,6 +421,7 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	resource_size_t creg = CXL_RESOURCE_NONE;
 	struct cxl_register_map map;
 	struct cxl_memdev *cxlmd;
 	struct cxl_mem *cxlm;
@@ -465,7 +466,21 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	cxlmd = devm_cxl_add_memdev(cxlm);
+	/*
+	 * If the component registers can't be found, the cxl_pci driver may
+	 * still be useful for management functions so don't return an error.
+	 *
+	 * XXX: Creating the device is going to kick of the cxl_mem probing.
+	 * That probe requires the component registers. Therefore, the register
+	 * block must always be found first.
+	 */
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		dev_warn(&cxlmd->dev, "No component registers (%d)\n", rc);
+	else
+		creg = cxl_reg_block(pdev, &map);
+
+	cxlmd = devm_cxl_add_memdev(cxlm, creg);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 12a8437a9ca0..471fc7fb5418 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -227,7 +227,8 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	cxlmd = devm_cxl_add_memdev(cxlm);
+	/* TODO: mock component registers, or... */
+	cxlmd = devm_cxl_add_memdev(cxlm, CXL_RESOURCE_NONE);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
-- 
2.33.1

