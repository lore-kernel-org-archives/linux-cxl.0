Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C080AC47089
	for <linux-cxl@archiver.kernel.org>; Fri, 28 May 2021 01:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F457613B4
	for <linux-cxl@archiver.kernel.org>; Fri, 28 May 2021 01:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhE1Bkq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 May 2021 21:40:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:41738 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhE1Bkq (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 27 May 2021 21:40:46 -0400
IronPort-SDR: o/Km8hUnISeQjQNdTzNbFZ/OoHMWrjaZvGyc5SWUaiCnIIRcvKwwRvQ2bZjI63/uY7iOdY5G8d
 lxZgN0VsFMrQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="202908862"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="202908862"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 18:39:11 -0700
IronPort-SDR: 4W+yTVvdZnJZltO+9QOPGxiwCyQTO2NpRB9nbksGOkntHV4EGKjiTbhKls4ndUMHsKiCET5wXe
 QiezlZ8A8sbQ==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="415125130"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 18:39:11 -0700
Subject: [PATCH] cxl/pci: Fixup devm_cxl_iomap_block() to take a 'struct
 device *'
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 27 May 2021 18:39:11 -0700
Message-ID: <162216592374.3833641.13281743585064451514.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The expectation is that devm functions take 'struct device *' and pci
functions take 'struct pci_dev *'. Swap out the @pdev argument for @dev
and fixup related helpers.

Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

base-commit: 6630d31c912ed2dfbc035caf0f54709b50ce779e

 drivers/cxl/core.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index f41a38e87606..80e6d65f8652 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -154,15 +154,14 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 }
 EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
 
-static void __iomem *devm_cxl_iomap_block(struct pci_dev *pdev,
+static void __iomem *devm_cxl_iomap_block(struct device *dev,
 					  resource_size_t addr,
 					  resource_size_t length)
 {
-	struct device *dev = &pdev->dev;
 	void __iomem *ret_val;
 	struct resource *res;
 
-	res = devm_request_mem_region(dev, addr, length, pci_name(pdev));
+	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
 	if (!res) {
 		dev_err(dev, "Failed to request region %#llx-%#llx\n",
 			addr, addr+length);
@@ -181,6 +180,7 @@ int cxl_map_component_regs(struct pci_dev *pdev,
 			   struct cxl_component_regs *regs,
 			   struct cxl_register_map *map)
 {
+	struct device *dev = &pdev->dev;
 	resource_size_t phys_addr;
 	resource_size_t length;
 
@@ -189,7 +189,7 @@ int cxl_map_component_regs(struct pci_dev *pdev,
 
 	phys_addr += map->component_map.hdm_decoder.offset;
 	length = map->component_map.hdm_decoder.size;
-	regs->hdm_decoder = devm_cxl_iomap_block(pdev, phys_addr, length);
+	regs->hdm_decoder = devm_cxl_iomap_block(dev, phys_addr, length);
 	if (!regs->hdm_decoder)
 		return -ENOMEM;
 
@@ -201,6 +201,7 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 			struct cxl_device_regs *regs,
 			struct cxl_register_map *map)
 {
+	struct device *dev = &pdev->dev;
 	resource_size_t phys_addr;
 
 	phys_addr = pci_resource_start(pdev, map->barno);
@@ -212,7 +213,7 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 
 		addr = phys_addr + map->device_map.status.offset;
 		length = map->device_map.status.size;
-		regs->status = devm_cxl_iomap_block(pdev, addr, length);
+		regs->status = devm_cxl_iomap_block(dev, addr, length);
 		if (!regs->status)
 			return -ENOMEM;
 	}
@@ -223,7 +224,7 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 
 		addr = phys_addr + map->device_map.mbox.offset;
 		length = map->device_map.mbox.size;
-		regs->mbox = devm_cxl_iomap_block(pdev, addr, length);
+		regs->mbox = devm_cxl_iomap_block(dev, addr, length);
 		if (!regs->mbox)
 			return -ENOMEM;
 	}
@@ -234,7 +235,7 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 
 		addr = phys_addr + map->device_map.memdev.offset;
 		length = map->device_map.memdev.size;
-		regs->memdev = devm_cxl_iomap_block(pdev, addr, length);
+		regs->memdev = devm_cxl_iomap_block(dev, addr, length);
 		if (!regs->memdev)
 			return -ENOMEM;
 	}

