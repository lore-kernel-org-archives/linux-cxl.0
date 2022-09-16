Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F8FECAAD8
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 23:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiIPXLO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Sep 2022 19:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiIPXLN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Sep 2022 19:11:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A0B78BF3
        for <linux-cxl@vger.kernel.org>; Fri, 16 Sep 2022 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663369872; x=1694905872;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hNrYkKwQSE+7jv9mF65FLXwsqKUJeqVGVDw1l9G3nCs=;
  b=IBoJ9Qwhab9+8J0Nq9rt4MHSwNksTyDlq1jIvLVN1CxEymi+Cc9TImcn
   cZVOrHqpW6boPooaHl8luZeC5iWM6CexmPoeh6bfgaj/gnfvZvNcPaGYg
   gP1L5f43bZrD6zAVsuhYSOJ5G4haiUaa6c5BpHHHKJtSsh1U82tiET1J5
   hH+7iAcW1hwfRdpdwEI5CD4mPVjnqCpQwWzfEMsius0/IJJvEO5nFlsLx
   sHY7olFNqKGkJnNriGw5cTOdXtE1b9AJHMc5P/6YFK+BexYhdRZVdEx9x
   WtwnoIZ/qMZCiX5jfLcfoAUtDRLhCBiwZ6iAWoXKFNzNysTXA/8aMVC9q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="360836711"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="360836711"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="686305183"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:11 -0700
Subject: [PATCH RFC v2 3/9] cxl/pci: Kill cxl_map_regs()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        jonathan.cameron@huawei.com, shiju.jose@huawei.com,
        rrichter@amd.com
Date:   Fri, 16 Sep 2022 16:11:11 -0700
Message-ID: <166336987163.3803215.16274917380401720231.stgit@djiang5-desk3.ch.intel.com>
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

The component registers are currently unused by the cxl_pci driver.
Only the physical address base of the component registers is conveyed to
the cxl_mem driver. Just call cxl_map_device_registers() directly.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c |   23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index faeb5d9d7a7a..82023cf0cdcf 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -347,27 +347,6 @@ static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
 	return 0;
 }
 
-static int cxl_map_regs(struct cxl_dev_state *cxlds, struct cxl_register_map *map)
-{
-	struct device *dev = cxlds->dev;
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	switch (map->reg_type) {
-	case CXL_REGLOC_RBI_COMPONENT:
-		cxl_map_component_regs(pdev, &cxlds->regs.component, map);
-		dev_dbg(dev, "Mapping component registers...\n");
-		break;
-	case CXL_REGLOC_RBI_MEMDEV:
-		cxl_map_device_regs(pdev, &cxlds->regs.device_regs, map);
-		dev_dbg(dev, "Probing device registers...\n");
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
 static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 			  struct cxl_register_map *map)
 {
@@ -461,7 +440,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_map_regs(cxlds, &map);
+	rc = cxl_map_device_regs(pdev, &cxlds->regs.device_regs, &map);
 	if (rc)
 		return rc;
 


