Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20CFC47081
	for <linux-cxl@archiver.kernel.org>; Sat, 22 May 2021 00:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DAB613D1
	for <linux-cxl@archiver.kernel.org>; Sat, 22 May 2021 00:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhEVAN1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 May 2021 20:13:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:2007 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230282AbhEVANX (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 21 May 2021 20:13:23 -0400
IronPort-SDR: F68P3ED4OZ53EapvLIEYAAxDJJpxjWNsMnhD9KNqnnWf0v5xkkrm0vTdW1DHeO+xCGbNzFnNDw
 XE6ySMkL+D2Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="188727601"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="188727601"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 17:11:59 -0700
IronPort-SDR: d6zqu38nnhhROtLcVzgyr6y4m5mEE0XYvV6BPHaukEwdJoyCoBvY2gK+DySD/6IU0hBZ+kGOCs
 PXh0EQzKzlMQ==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="631990659"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 17:11:59 -0700
From:   ira.weiny@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] cxl/mem: Reserve individual register block regions
Date:   Fri, 21 May 2021 17:11:53 -0700
Message-Id: <20210522001154.2680157-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210522001154.2680157-1-ira.weiny@intel.com>
References: <20210522001154.2680157-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Now that individual register blocks are mapped; those blocks regions
should be reserved individually.

Remove general pci device management and create managed region
reservations based on the individual register blocks.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V2:
	New patch
---
 drivers/cxl/core.c | 36 ++++++++++++++++++++++++++++++++----
 drivers/cxl/pci.c  |  6 ++----
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index add66a6ec875..ae38f17be1e7 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -74,11 +74,33 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 }
 EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
 
+static void __iomem *cxl_ioremap_block(struct pci_dev *pdev,
+				       resource_size_t addr,
+				       resource_size_t length)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *ret_val;
+	struct resource *res;
+
+	res = devm_request_mem_region(dev, addr, length, pci_name(pdev));
+	if (!res) {
+		dev_err(dev, "Failed to request region %#llx-%#llx\n",
+			addr, addr+length);
+		return NULL;
+	}
+
+	ret_val = devm_ioremap(dev, addr, length);
+	if (!ret_val)
+		dev_err(dev, "Failed to map region %#llx-%#llx\n",
+			addr, addr+length);
+
+	return ret_val;
+}
+
 int cxl_map_device_regs(struct pci_dev *pdev,
 			struct cxl_device_regs *regs,
 			struct cxl_register_map *map)
 {
-	struct device *dev = &pdev->dev;
 	resource_size_t phys_addr;
 
 	phys_addr = pci_resource_start(pdev, map->barno);
@@ -90,7 +112,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 
 		addr = phys_addr + map->device_map.status.offset;
 		length = map->device_map.status.size;
-		regs->status = devm_ioremap(dev, addr, length);
+		regs->status = cxl_ioremap_block(pdev, addr, length);
+		if (!regs->status)
+			return -ENOMEM;
 	}
 
 	if (map->device_map.mbox.valid) {
@@ -99,7 +123,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 
 		addr = phys_addr + map->device_map.mbox.offset;
 		length = map->device_map.mbox.size;
-		regs->mbox = devm_ioremap(dev, addr, length);
+		regs->mbox = cxl_ioremap_block(pdev, addr, length);
+		if (!regs->mbox)
+			return -ENOMEM;
 	}
 
 	if (map->device_map.memdev.valid) {
@@ -108,7 +134,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 
 		addr = phys_addr + map->device_map.memdev.offset;
 		length = map->device_map.memdev.size;
-		regs->memdev = devm_ioremap(dev, addr, length);
+		regs->memdev = cxl_ioremap_block(pdev, addr, length);
+		if (!regs->memdev)
+			return -ENOMEM;
 	}
 
 	return 0;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 3ffd5fad74b4..776cb8e28c2d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1110,6 +1110,8 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 			goto free_maps;
 	}
 
+	pci_release_mem_regions(pdev);
+
 	list_for_each_entry(map, &register_maps, list) {
 		ret = cxl_map_regs(cxlm, map);
 		if (ret)
@@ -1547,10 +1549,6 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct cxl_mem *cxlm;
 	int rc;
 
-	rc = pcim_enable_device(pdev);
-	if (rc)
-		return rc;
-
 	cxlm = cxl_mem_create(pdev);
 	if (IS_ERR(cxlm))
 		return PTR_ERR(cxlm);
-- 
2.28.0.rc0.12.gb6a658bd00c9

