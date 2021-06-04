Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C512C47082
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Jun 2021 00:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 376A96140B
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Jun 2021 00:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFDAzH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Jun 2021 20:55:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:36109 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhFDAzH (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 3 Jun 2021 20:55:07 -0400
IronPort-SDR: LAyw6PEjh3JepxGL3BDae/1ACGkFmiuz3ganwjiJDNIwKLolQG8WCTyouM7nW8XyQbMfyH58Ee
 /0LoowOCc2cA==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="191303467"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="191303467"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 17:53:22 -0700
IronPort-SDR: Dt1yBIisBS7E7pnaPdDTaFMg8qtJ6qUEqvIhE4EYH32cYKF2/BohVcWZQQSBWnHSU1ycL3krxA
 3eRDbsvjvLUw==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="448072590"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 17:53:19 -0700
From:   ira.weiny@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3.1] cxl/mem: Reserve individual register block regions
Date:   Thu,  3 Jun 2021 17:53:16 -0700
Message-Id: <20210604005316.4187340-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210528004922.3980613-5-ira.weiny@intel.com>
References: <20210528004922.3980613-5-ira.weiny@intel.com>
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
Link: https://lore.kernel.org/r/20210528004922.3980613-5-ira.weiny@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>

---
Changes for v3.1

	Fix 0-day warnings:

>> drivers/cxl/core.c:96:4: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
                           addr, addr+length);
---
 drivers/cxl/core.c | 36 ++++++++++++++++++++++++++++++++----
 drivers/cxl/pci.c  |  2 ++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index f836aaab03e0..c1efa11207b5 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -79,11 +79,33 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
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
+		resource_size_t end = addr + length - 1;
+
+		dev_err(dev, "Failed to request region %pa-%pa\n", &addr, &end);
+		return NULL;
+	}
+
+	ret_val = devm_ioremap(dev, addr, length);
+	if (!ret_val)
+		dev_err(dev, "Failed to map region %pr\n", res);
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
@@ -95,7 +117,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 
 		addr = phys_addr + map->device_map.status.offset;
 		length = map->device_map.status.size;
-		regs->status = devm_ioremap(dev, addr, length);
+		regs->status = devm_cxl_iomap_block(pdev, addr, length);
+		if (!regs->status)
+			return -ENOMEM;
 	}
 
 	if (map->device_map.mbox.valid) {
@@ -104,7 +128,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 
 		addr = phys_addr + map->device_map.mbox.offset;
 		length = map->device_map.mbox.size;
-		regs->mbox = devm_ioremap(dev, addr, length);
+		regs->mbox = devm_cxl_iomap_block(pdev, addr, length);
+		if (!regs->mbox)
+			return -ENOMEM;
 	}
 
 	if (map->device_map.memdev.valid) {
@@ -113,7 +139,9 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 
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

