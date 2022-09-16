Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ECAECAAA1
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 23:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiIPXLD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Sep 2022 19:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiIPXLC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Sep 2022 19:11:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ADA7AC29
        for <linux-cxl@vger.kernel.org>; Fri, 16 Sep 2022 16:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663369861; x=1694905861;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rhRR/mm1cOKPCO7PS3Aui4wKh7B/XjO7DTe4et01Dow=;
  b=EVs7nmU6GW4sdlaPgD8uIhR9frWiHkTHC+JoxzPM1De3p/FnNcFC59yJ
   8kovk9e7yEBzlqa1sNtVcu6AA77tXwUf2k5G2SEFjAcdlXgZ3n/JIOObG
   ZmY1jNkts5xV2CCs244y58yutmi6VcXgY8cUPHINlj/tfXBvEEU+zIj6/
   ELDMD/gfS4YVbjBze7CIxQooaIJpeiUzF5A5ririi97U1MRfRUb3i4/9b
   9nufOpX+BBJmw0tAH7m0+7ox6RwJ0sCGXYeQSpyl1SZCjlDgD9rYonNnY
   3Yq+rp0teYnUaQsGF7ktRVuuhWjcvaAb89i5DolUmJTIdAC3/ydnueXAB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="286138525"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="286138525"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="686305078"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:00 -0700
Subject: [PATCH RFC v2 1/9] cxl/pci: Cleanup repeated code in cxl_probe_regs()
 helpers
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        jonathan.cameron@huawei.com, shiju.jose@huawei.com,
        rrichter@amd.com
Date:   Fri, 16 Sep 2022 16:11:00 -0700
Message-ID: <166336986012.3803215.4343997952762297862.stgit@djiang5-desk3.ch.intel.com>
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

Rather then duplicating the setting of valid, length, and offset for
each type, just convey a pointer to the register map to common code.

Yes, the change in cxl_probe_component_regs() does not save
any lines of code, but it is preparation for adding another component
register type to map (RAS Capability Structure).

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/regs.c |   46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 39a129c57d40..bd6ae14b679e 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -59,36 +59,41 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 
 	for (cap = 1; cap <= cap_count; cap++) {
 		void __iomem *register_block;
-		u32 hdr;
-		int decoder_cnt;
+		struct cxl_reg_map *rmap;
 		u16 cap_id, offset;
-		u32 length;
+		u32 length, hdr;
 
 		hdr = readl(base + cap * 0x4);
 
 		cap_id = FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, hdr);
 		offset = FIELD_GET(CXL_CM_CAP_PTR_MASK, hdr);
 		register_block = base + offset;
+		hdr = readl(register_block);
 
+		rmap = NULL;
 		switch (cap_id) {
-		case CXL_CM_CAP_CAP_ID_HDM:
+		case CXL_CM_CAP_CAP_ID_HDM: {
+			int decoder_cnt;
+
 			dev_dbg(dev, "found HDM decoder capability (0x%x)\n",
 				offset);
 
-			hdr = readl(register_block);
-
 			decoder_cnt = cxl_hdm_decoder_count(hdr);
 			length = 0x20 * decoder_cnt + 0x10;
-
-			map->hdm_decoder.valid = true;
-			map->hdm_decoder.offset = CXL_CM_OFFSET + offset;
-			map->hdm_decoder.size = length;
+			rmap = &map->hdm_decoder;
 			break;
+		}
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
 			break;
 		}
+
+		if (!rmap)
+			continue;
+		rmap->valid = true;
+		rmap->offset = CXL_CM_OFFSET + offset;
+		rmap->size = length;
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
@@ -117,6 +122,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
 
 	for (cap = 1; cap <= cap_count; cap++) {
+		struct cxl_reg_map *rmap;
 		u32 offset, length;
 		u16 cap_id;
 
@@ -125,28 +131,22 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		offset = readl(base + cap * 0x10 + 0x4);
 		length = readl(base + cap * 0x10 + 0x8);
 
+		rmap = NULL;
 		switch (cap_id) {
 		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
 			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
-
-			map->status.valid = true;
-			map->status.offset = offset;
-			map->status.size = length;
+			rmap = &map->status;
 			break;
 		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
 			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
-			map->mbox.valid = true;
-			map->mbox.offset = offset;
-			map->mbox.size = length;
+			rmap = &map->mbox;
 			break;
 		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
 			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
 			break;
 		case CXLDEV_CAP_CAP_ID_MEMDEV:
 			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
-			map->memdev.valid = true;
-			map->memdev.offset = offset;
-			map->memdev.size = length;
+			rmap = &map->memdev;
 			break;
 		default:
 			if (cap_id >= 0x8000)
@@ -155,6 +155,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 				dev_dbg(dev, "Unknown cap ID: %#x offset: %#x\n", cap_id, offset);
 			break;
 		}
+
+		if (!rmap)
+			continue;
+		rmap->valid = true;
+		rmap->offset = offset;
+		rmap->size = length;
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_probe_device_regs, CXL);


