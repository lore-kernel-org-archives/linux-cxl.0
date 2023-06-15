Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D37DEB64DB
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 01:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbjFOB3w (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbjFOB3v (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 21:29:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22007212A
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 18:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686792591; x=1718328591;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WFFFr2unMqPE5BAyAgN/3ibvgsYdA3zH3wXefI9Y+sU=;
  b=eV/y+ppUempOWxJvjz0StieX4/nc+Y1gpQCv44vBY6jppb+8Ir2bBoWb
   stRBMXEV9W5WQNG8aDQi02lx5xBdAeF3q3kTyT5KNQ9Sf1lA+IQlojZOZ
   JnxWC+fBIq7reXCq0hlLef2TBrtpU75RLP212KRXHZneYFOHdzgH1i0pS
   3BxyXoXK0QEQZC5sdqXL/xpiLyx92Lh8zHom/9hWFVfGjlmHZqTRJpwc9
   cpwmj/5aft9+H8lGiY64E22t+CZ//PcFP+/Io+lDpHJqgaWeO0DHVXC8t
   JvCs99D/4945vmRK8AKB3R5yx+iQAu4vQBR56gtfFROeA08uRXG7o1WiC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="445150621"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="445150621"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:29:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="689599971"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="689599971"
Received: from rtpearso-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.87.28])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:29:41 -0700
Subject: [PATCH v2 01/12] cxl/regs: Clarify when a 'struct cxl_register_map'
 is input vs output
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Date:   Wed, 14 Jun 2023 18:29:41 -0700
Message-ID: <168679258103.3436160.4941603739448763855.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The @map parameter to cxl_probe_X_registers() is filled in with the
mapping parameters of the register block. The @map parameter to
cxl_map_X_registers() only reads that information to perform the
mapping. Mark @map const for cxl_map_X_registers() to clarify that it is
only an input to those helpers.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/regs.c |    8 ++++----
 drivers/cxl/cxl.h       |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 1476a0299c9b..52d1dbeda527 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -200,10 +200,10 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 }
 
 int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
-			   struct cxl_register_map *map, unsigned long map_mask)
+			   const struct cxl_register_map *map, unsigned long map_mask)
 {
 	struct mapinfo {
-		struct cxl_reg_map *rmap;
+		const struct cxl_reg_map *rmap;
 		void __iomem **addr;
 	} mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
@@ -233,11 +233,11 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
 
 int cxl_map_device_regs(struct device *dev,
 			struct cxl_device_regs *regs,
-			struct cxl_register_map *map)
+			const struct cxl_register_map *map)
 {
 	resource_size_t phys_addr = map->resource;
 	struct mapinfo {
-		struct cxl_reg_map *rmap;
+		const struct cxl_reg_map *rmap;
 		void __iomem **addr;
 	} mapinfo[] = {
 		{ &map->device_map.status, &regs->status, },
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f93a28538962..dfc94e76c7d6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -254,10 +254,10 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
 int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
-			   struct cxl_register_map *map,
+			   const struct cxl_register_map *map,
 			   unsigned long map_mask);
 int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
-			struct cxl_register_map *map);
+			const struct cxl_register_map *map);
 
 enum cxl_regloc_type;
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,

