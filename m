Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA20C77B73
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjFDXbp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjFDXbo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:31:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DFAAC
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921503; x=1717457503;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=53YGUoA6Y5N62zL/kAlnp9LcCP/9ojoL4gRt1B4/8zU=;
  b=fgd/fpF2GM4UKwFk1kA80oPcLT8fCDP39WPcjR5DNxGcZNyMZsi69vlu
   mHJBCJpNk5bq9UJq1NFHP8cptduI7sJNK2lsSSq7T0A326YCpChGM4Wza
   rnU6e1mBBCLCv0LFVrX8f0ywg2HPWtl/ZX/irKRBNngCRny9jIjWj5FFJ
   sZdnqnRXbbUCLRqQkzRxSmz4ZWPICz+EmdiKgRDXoKn2p45/YdbIOVcPh
   WuSgElAHt3khnedmrQfo7k8fFPXDtHolceIAxLnph4h0Y3zFfrSPj4nhx
   3+c6uKhctGOBkEciEVB4YxVNgk4pbMV2WChSOlhUCNXhfcwb33k08Wzb9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="335860237"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="335860237"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:31:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="708466077"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="708466077"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:31:43 -0700
Subject: [PATCH 01/19] cxl/regs: Clarify when a 'struct cxl_register_map' is
 input vs output
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:31:43 -0700
Message-ID: <168592150323.1948938.2728742883585170051.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
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

