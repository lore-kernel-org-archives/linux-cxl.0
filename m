Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3324ECAAA1
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 23:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIPXLc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Sep 2022 19:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIPXLa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Sep 2022 19:11:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868CD8275B
        for <linux-cxl@vger.kernel.org>; Fri, 16 Sep 2022 16:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663369889; x=1694905889;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uS1g/Sz87ibNZ66Sfid55eY8k+J8IN+yR2u95PQLPy8=;
  b=gwlUhZjC9OG5qQqSoHVa+f5ZSbU5WuUE7m+bCaYaytD/fL1M3QSW65kM
   0bhMoqlS1KHk2h8wRW7seglrt2Z5ziftWK1TucjOXUDcitKuXztyHTD+N
   5TvioCmLHo/qeZkB9hvFodHOGZLAkSwmsU22rNarUo5igy2Byuk0y0752
   Juy/cPbP6sXPtY7LB68YhiBDarmSOEuS160LhBTb5/eSiWk0nqq6AmHgO
   AMddGsjL1Lwhr8cUDF14xC/rZrulHesxGbvmxS++Pzk02p7c5FAxiluW1
   eD15yVBiyBzf9awiTlzNuxvfowe+gcOXYIEHLPHypiCUmn5D0a2k1F0DB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="279480158"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="279480158"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="686305341"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:28 -0700
Subject: [PATCH RFC v2 6/9] cxl/pci: Prepare for mapping RAS Capability
 Structure
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        jonathan.cameron@huawei.com, shiju.jose@huawei.com,
        rrichter@amd.com
Date:   Fri, 16 Sep 2022 16:11:28 -0700
Message-ID: <166336988849.3803215.9304329275216442016.stgit@djiang5-desk3.ch.intel.com>
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

The RAS Capabilitiy Structure is a CXL Component register capability
block. Unlike the HDM Decoder Capability, it will be referenced by the
cxl_pci driver in response to PCIe AER events. Due to this it is no
longer the case that cxl_map_component_regs() can assume that it should
map all component registers. Plumb a bitmask of capability ids to map
through cxl_map_component_regs().

For symmetry cxl_probe_device_regs() is updated to populate @id in
'struct cxl_reg_map' even though cxl_map_device_regs() does not have a
need to map a subset of the device registers per caller.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c  |    3 ++-
 drivers/cxl/core/regs.c |   36 ++++++++++++++++++++++++++----------
 drivers/cxl/cxl.h       |    4 +++-
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 061551148cfe..100d0881bde4 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -97,7 +97,8 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
 		return -ENXIO;
 	}
 
-	return cxl_map_component_regs(&port->dev, regs, &map);
+	return cxl_map_component_regs(&port->dev, regs, &map,
+				      BIT(CXL_CM_CAP_CAP_ID_HDM));
 }
 
 /**
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e4b0d52ac3a1..97e8f4201493 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -92,6 +92,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 		if (!rmap)
 			continue;
 		rmap->valid = true;
+		rmap->id = cap_id;
 		rmap->offset = CXL_CM_OFFSET + offset;
 		rmap->size = length;
 	}
@@ -159,6 +160,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		if (!rmap)
 			continue;
 		rmap->valid = true;
+		rmap->id = cap_id;
 		rmap->offset = offset;
 		rmap->size = length;
 	}
@@ -187,17 +189,31 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 }
 
 int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
-			   struct cxl_register_map *map)
+			   struct cxl_register_map *map, unsigned long map_mask)
 {
-	resource_size_t phys_addr;
-	resource_size_t length;
-
-	phys_addr = map->resource;
-	phys_addr += map->component_map.hdm_decoder.offset;
-	length = map->component_map.hdm_decoder.size;
-	regs->hdm_decoder = devm_cxl_iomap_block(dev, phys_addr, length);
-	if (!regs->hdm_decoder)
-		return -ENOMEM;
+	struct mapinfo {
+		struct cxl_reg_map *rmap;
+		void __iomem **addr;
+	} mapinfo[] = {
+		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
+		struct mapinfo *mi = &mapinfo[i];
+		resource_size_t phys_addr;
+		resource_size_t length;
+
+		if (!mi->rmap->valid)
+			continue;
+		if (!test_bit(mi->rmap->id, &map_mask))
+			continue;
+		phys_addr = map->resource + mi->rmap->offset;
+		length = mi->rmap->size;
+		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
+		if (!*(mi->addr))
+			return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 75506286f39c..c2bf1759d55c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -170,6 +170,7 @@ struct cxl_regs {
 
 struct cxl_reg_map {
 	bool valid;
+	int id;
 	unsigned long offset;
 	unsigned long size;
 };
@@ -209,7 +210,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
 int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
-			   struct cxl_register_map *map);
+			   struct cxl_register_map *map,
+			   unsigned long map_mask);
 int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
 			struct cxl_register_map *map);
 


