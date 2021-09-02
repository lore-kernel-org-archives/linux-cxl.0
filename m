Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0DFC4321E
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 539C560FDC
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347360AbhIBTvb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 15:51:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:41967 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347371AbhIBTv2 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 2 Sep 2021 15:51:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="198778202"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="198778202"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="533451622"
Received: from kappusam-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:25 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 05/13] cxl/pci: Disambiguate cxl_pci further from cxl_mem
Date:   Thu,  2 Sep 2021 12:50:09 -0700
Message-Id: <20210902195017.2516472-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902195017.2516472-1-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Commit 21e9f76733a8 ("cxl: Rename mem to pci") introduced the cxl_pci
driver which had formerly been named cxl_mem. At the time, the goal was
to be as light touch as possible because there were other patches in
flight. Since things have settled now, and a new cxl_mem driver will be
introduced shortly, spend the LOC now to clean up the existing names.

While here, fix the kernel docs to explain the situation better after
the core rework that has already landed.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/pci.c | 70 +++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b13884275d96..6931885c83ce 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -16,14 +16,14 @@
  *
  * This implements the PCI exclusive functionality for a CXL device as it is
  * defined by the Compute Express Link specification. CXL devices may surface
- * certain functionality even if it isn't CXL enabled.
+ * certain functionality even if it isn't CXL enabled. While this driver is
+ * focused around the PCI specific aspects of a CXL device, it binds to the
+ * specific CXL memory device class code, and therefore the implementation of
+ * cxl_pci is focused around CXL memory devices.
  *
- * The driver has several responsibilities, mainly:
+ * The driver has two responsibilities:
  *  - Create the memX device and register on the CXL bus.
  *  - Enumerate device's register interface and map them.
- *  - Probe the device attributes to establish sysfs interface.
- *  - Provide an IOCTL interface to userspace to communicate with the device for
- *    things like firmware update.
  */
 
 #define cxl_doorbell_busy(cxlm)                                                \
@@ -33,7 +33,7 @@
 /* CXL 2.0 - 8.2.8.4 */
 #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
 
-static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
+static int cxl_pci_wait_for_doorbell(struct cxl_mem *cxlm)
 {
 	const unsigned long start = jiffies;
 	unsigned long end = start;
@@ -55,7 +55,7 @@ static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
 	return 0;
 }
 
-static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
+static void cxl_pci_mbox_timeout(struct cxl_mem *cxlm,
 				 struct cxl_mbox_cmd *mbox_cmd)
 {
 	struct device *dev = cxlm->dev;
@@ -65,7 +65,7 @@ static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
 }
 
 /**
- * __cxl_mem_mbox_send_cmd() - Execute a mailbox command
+ * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
  * @cxlm: The CXL memory device to communicate with.
  * @mbox_cmd: Command to send to the memory device.
  *
@@ -86,7 +86,7 @@ static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
  * not need to coordinate with each other. The driver only uses the primary
  * mailbox.
  */
-static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
+static int __cxl_pci_mbox_send_cmd(struct cxl_mem *cxlm,
 				   struct cxl_mbox_cmd *mbox_cmd)
 {
 	void __iomem *payload = cxlm->regs.mbox + CXLDEV_MBOX_PAYLOAD_OFFSET;
@@ -140,9 +140,9 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 	       cxlm->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
 
 	/* #5 */
-	rc = cxl_mem_wait_for_doorbell(cxlm);
+	rc = cxl_pci_wait_for_doorbell(cxlm);
 	if (rc == -ETIMEDOUT) {
-		cxl_mem_mbox_timeout(cxlm, mbox_cmd);
+		cxl_pci_mbox_timeout(cxlm, mbox_cmd);
 		return rc;
 	}
 
@@ -181,13 +181,13 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 }
 
 /**
- * cxl_mem_mbox_get() - Acquire exclusive access to the mailbox.
+ * cxl_pci_mbox_get() - Acquire exclusive access to the mailbox.
  * @cxlm: The memory device to gain access to.
  *
  * Context: Any context. Takes the mbox_mutex.
  * Return: 0 if exclusive access was acquired.
  */
-static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
+static int cxl_pci_mbox_get(struct cxl_mem *cxlm)
 {
 	struct device *dev = cxlm->dev;
 	u64 md_status;
@@ -212,7 +212,7 @@ static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
 	 *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
 	 *    to be ready is sufficient.
 	 */
-	rc = cxl_mem_wait_for_doorbell(cxlm);
+	rc = cxl_pci_wait_for_doorbell(cxlm);
 	if (rc) {
 		dev_warn(dev, "Mailbox interface not ready\n");
 		goto out;
@@ -252,12 +252,12 @@ static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
 }
 
 /**
- * cxl_mem_mbox_put() - Release exclusive access to the mailbox.
+ * cxl_pci_mbox_put() - Release exclusive access to the mailbox.
  * @cxlm: The CXL memory device to communicate with.
  *
  * Context: Any context. Expects mbox_mutex to be held.
  */
-static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
+static void cxl_pci_mbox_put(struct cxl_mem *cxlm)
 {
 	mutex_unlock(&cxlm->mbox_mutex);
 }
@@ -266,17 +266,17 @@ static int cxl_pci_mbox_send(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
 {
 	int rc;
 
-	rc = cxl_mem_mbox_get(cxlm);
+	rc = cxl_pci_mbox_get(cxlm);
 	if (rc)
 		return rc;
 
-	rc = __cxl_mem_mbox_send_cmd(cxlm, cmd);
-	cxl_mem_mbox_put(cxlm);
+	rc = __cxl_pci_mbox_send_cmd(cxlm, cmd);
+	cxl_pci_mbox_put(cxlm);
 
 	return rc;
 }
 
-static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
+static int cxl_pci_setup_mailbox(struct cxl_mem *cxlm)
 {
 	const int cap = readl(cxlm->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
 
@@ -304,7 +304,7 @@ static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
 	return 0;
 }
 
-static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm,
+static void __iomem *cxl_pci_map_regblock(struct cxl_mem *cxlm,
 					  u8 bar, u64 offset)
 {
 	void __iomem *addr;
@@ -330,12 +330,12 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm,
 	return addr;
 }
 
-static void cxl_mem_unmap_regblock(struct cxl_mem *cxlm, void __iomem *base)
+static void cxl_pci_unmap_regblock(struct cxl_mem *cxlm, void __iomem *base)
 {
 	pci_iounmap(to_pci_dev(cxlm->dev), base);
 }
 
-static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
+static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
 {
 	int pos;
 
@@ -428,7 +428,7 @@ static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
 }
 
 /**
- * cxl_mem_setup_regs() - Setup necessary MMIO.
+ * cxl_pci_setup_regs() - Setup necessary MMIO.
  * @cxlm: The CXL memory device to communicate with.
  *
  * Return: 0 if all necessary registers mapped.
@@ -437,7 +437,7 @@ static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
  * regions. The purpose of this function is to enumerate and map those
  * registers.
  */
-static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
+static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlm->dev);
 	struct device *dev = cxlm->dev;
@@ -447,7 +447,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 	struct cxl_register_map *map, maps[CXL_REGLOC_RBI_TYPES];
 	int ret = 0;
 
-	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
+	regloc = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
 	if (!regloc) {
 		dev_err(dev, "register location dvsec not found\n");
 		return -ENXIO;
@@ -482,7 +482,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		if (reg_type > CXL_REGLOC_RBI_MEMDEV)
 			continue;
 
-		base = cxl_mem_map_regblock(cxlm, bar, offset);
+		base = cxl_pci_map_regblock(cxlm, bar, offset);
 		if (!base)
 			return -ENOMEM;
 
@@ -494,7 +494,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		ret = cxl_probe_regs(cxlm, base + offset, map);
 
 		/* Always unmap the regblock regardless of probe success */
-		cxl_mem_unmap_regblock(cxlm, base);
+		cxl_pci_unmap_regblock(cxlm, base);
 
 		if (ret)
 			return ret;
@@ -513,7 +513,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 	return ret;
 }
 
-static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_memdev *cxlmd;
 	struct cxl_mem *cxlm;
@@ -534,11 +534,11 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlm))
 		return PTR_ERR(cxlm);
 
-	rc = cxl_mem_setup_regs(cxlm);
+	rc = cxl_pci_setup_regs(cxlm);
 	if (rc)
 		return rc;
 
-	rc = cxl_mem_setup_mailbox(cxlm);
+	rc = cxl_pci_setup_mailbox(cxlm);
 	if (rc)
 		return rc;
 
@@ -569,17 +569,17 @@ static const struct pci_device_id cxl_mem_pci_tbl[] = {
 	{ PCI_DEVICE_CLASS((PCI_CLASS_MEMORY_CXL << 8 | CXL_MEMORY_PROGIF), ~0)},
 	{ /* terminate list */ },
 };
-MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
+MODULE_DEVICE_TABLE(pci, cxl_pci_tbl);
 
-static struct pci_driver cxl_mem_driver = {
+static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
-	.probe			= cxl_mem_probe,
+	.probe			= cxl_pci_probe,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
 MODULE_LICENSE("GPL v2");
-module_pci_driver(cxl_mem_driver);
+module_pci_driver(cxl_pci_driver);
 MODULE_IMPORT_NS(CXL);
-- 
2.33.0

