Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18832C47089
	for <linux-cxl@archiver.kernel.org>; Fri, 28 May 2021 00:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1986613E3
	for <linux-cxl@archiver.kernel.org>; Fri, 28 May 2021 00:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhE1AvD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 May 2021 20:51:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:19706 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhE1AvC (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 27 May 2021 20:51:02 -0400
IronPort-SDR: WsqM6rcZjaTlEn0Qf0/0ihSxo9LdwxYPzTRJ9akH8QxIw/lm6i4I2qv8Yl4WOn0rrL2HBKAWQE
 M/NhbvLC7gBw==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="266753504"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="266753504"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:49:27 -0700
IronPort-SDR: 6jiLVmfEIWWEfGwHvjeIjiVtfkAEL9kgytIzhd40yANAhVAU0wBs6UEV9ALIL8aw57Yn96SKg9
 ed99YOkwLlfQ==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="443791890"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:49:27 -0700
From:   ira.weiny@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/5] cxl/mem: Reserve individual register block regions
Date:   Thu, 27 May 2021 17:49:21 -0700
Message-Id: <20210528004922.3980613-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210528004922.3980613-1-ira.weiny@intel.com>
References: <20210528004922.3980613-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Some hardware implementations mix component and device registers into
the same BAR and the driver stack is going to need independent mapping
implementations for those 2 cases.  Furthermore, it will be nice to have
finer grained mappings should user space want to map some register
blocks.

Now that individual register blocks are mapped; those blocks regions
should be reserved individually to fully separate the register blocks.

Release the 'global' memory reservation and create individual register
block region reservations through devm.

NOTE: pci_release_mem_regions() is still compatible with
pcim_enable_device() because it removes the automatic region release
when called.  So preserve the pcim_enable_device() so that the pcim
interface can be called if needed.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V3
	Dan
		Add pcim_enable_device() back in because it is needed
		and is not incompatible with pci_release_mem_regions()
		like I originally though.
		Change cxl_ioremap_block() to devm_cxl_iomap_block()
	Jonathan
		Update commit message with more details.
---
 drivers/cxl/core.c | 36 ++++++++++++++++++++++++++++++++----
 drivers/cxl/pci.c  |  2 ++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index ab8d6bce59c2..2b5aac6f76f2 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -82,11 +82,33 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 }
 EXPORT_SYMBOL_GPL(cxl_probe_device_regs);
 
+static void __iomem *devm_cxl_iomap_block(struct pci_dev *pdev,
+					  resource_size_t addr,
+					  resource_size_t length)
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
@@ -98,7 +120,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 
 		addr = phys_addr + map->device_map.status.offset;
 		length = map->device_map.status.size;
-		regs->status = devm_ioremap(dev, addr, length);
+		regs->status = devm_cxl_iomap_block(pdev, addr, length);
+		if (!regs->status)
+			return -ENOMEM;
 	}
 
 	if (map->device_map.mbox.valid) {
@@ -107,7 +131,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 
 		addr = phys_addr + map->device_map.mbox.offset;
 		length = map->device_map.mbox.size;
-		regs->mbox = devm_ioremap(dev, addr, length);
+		regs->mbox = devm_cxl_iomap_block(pdev, addr, length);
+		if (!regs->mbox)
+			return -ENOMEM;
 	}
 
 	if (map->device_map.memdev.valid) {
@@ -116,7 +142,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 
 		addr = phys_addr + map->device_map.memdev.offset;
 		length = map->device_map.memdev.size;
-		regs->memdev = devm_ioremap(dev, addr, length);
+		regs->memdev = devm_cxl_iomap_block(pdev, addr, length);
+		if (!regs->memdev)
+			return -ENOMEM;
 	}
 
 	return 0;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 3ffd5fad74b4..e1a2dbc2886b 100644
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
-- 
2.28.0.rc0.12.gb6a658bd00c9

