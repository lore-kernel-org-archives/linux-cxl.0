Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D114ECAAD8
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 23:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiIPXLJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Sep 2022 19:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiIPXLH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Sep 2022 19:11:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD8E78BF3
        for <linux-cxl@vger.kernel.org>; Fri, 16 Sep 2022 16:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663369867; x=1694905867;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dtCnVY9W81yc9vix7z4DELknnnqJJU5aJ9NAFNn5thk=;
  b=Mwa73/VaiJmN4IBuzVmRbsu4LO3mlEBparCxmNI8hK0aYddW9sKVAZBM
   LcKoXVswmghbUTc0Fv7WD/FQUC1dUjSPWHWgStyzLiFrD2SgX0L8ZNMPr
   HTiV+agl1wqqz1pIDU/TlOPhVvP48GqpZKIH41dbEOxpY4EpxFKIbVZWz
   SBOQ8HpqfDckXykXrQ9AiGAseY7wOR00rFvRwSzJnwvACsVCq03iVgqgS
   IC9xET00eBcxvb7s95e5N75BpVR+zqygMsYHBMh3RY051djcLIrcEJrWN
   GBIpBJYB5DVFwzXtXpmvQF9xWgrKxCpn+++hXn9p5gDdzaa2xeDHi/NqK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="300467066"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="300467066"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="686305144"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:06 -0700
Subject: [PATCH RFC v2 2/9] cxl/pci: Cleanup cxl_map_device_regs()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        jonathan.cameron@huawei.com, shiju.jose@huawei.com,
        rrichter@amd.com
Date:   Fri, 16 Sep 2022 16:11:05 -0700
Message-ID: <166336986590.3803215.8576219076379231069.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Use a loop to reduce the duplicated code in cxl_map_device_regs(). This
is in preparation for deleting cxl_map_regs().

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/regs.c |   51 ++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index bd6ae14b679e..f03ede86412d 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -211,42 +211,31 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 			struct cxl_device_regs *regs,
 			struct cxl_register_map *map)
 {
+	resource_size_t phys_addr =
+		pci_resource_start(pdev, map->barno) + map->block_offset;
 	struct device *dev = &pdev->dev;
-	resource_size_t phys_addr;
-
-	phys_addr = pci_resource_start(pdev, map->barno);
-	phys_addr += map->block_offset;
-
-	if (map->device_map.status.valid) {
-		resource_size_t addr;
+	struct mapinfo {
+		struct cxl_reg_map *rmap;
+		void __iomem **addr;
+	} mapinfo[] = {
+		{ &map->device_map.status, &regs->status, },
+		{ &map->device_map.mbox, &regs->mbox, },
+		{ &map->device_map.memdev, &regs->memdev, },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
+		struct mapinfo *mi = &mapinfo[i];
 		resource_size_t length;
-
-		addr = phys_addr + map->device_map.status.offset;
-		length = map->device_map.status.size;
-		regs->status = devm_cxl_iomap_block(dev, addr, length);
-		if (!regs->status)
-			return -ENOMEM;
-	}
-
-	if (map->device_map.mbox.valid) {
 		resource_size_t addr;
-		resource_size_t length;
 
-		addr = phys_addr + map->device_map.mbox.offset;
-		length = map->device_map.mbox.size;
-		regs->mbox = devm_cxl_iomap_block(dev, addr, length);
-		if (!regs->mbox)
-			return -ENOMEM;
-	}
-
-	if (map->device_map.memdev.valid) {
-		resource_size_t addr;
-		resource_size_t length;
+		if (!mi->rmap->valid)
+			continue;
 
-		addr = phys_addr + map->device_map.memdev.offset;
-		length = map->device_map.memdev.size;
-		regs->memdev = devm_cxl_iomap_block(dev, addr, length);
-		if (!regs->memdev)
+		addr = phys_addr + mi->rmap->offset;
+		length = mi->rmap->size;
+		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
+		if (!*(mi->addr))
 			return -ENOMEM;
 	}
 


