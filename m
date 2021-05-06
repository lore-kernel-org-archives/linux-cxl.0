Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45B9C433ED
	for <linux-cxl@archiver.kernel.org>; Thu,  6 May 2021 22:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FFC61041
	for <linux-cxl@archiver.kernel.org>; Thu,  6 May 2021 22:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhEFWiM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 6 May 2021 18:38:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:7718 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231206AbhEFWiL (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 6 May 2021 18:38:11 -0400
IronPort-SDR: 7voYEGs7tKHRJeDXFN5Dt+Zf9ahIsytvQR0gga38s7io00hL0KFSuqj6XnSWlNIuzmEval8oKN
 aXxU9y2Fb/zg==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="185726271"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="185726271"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 15:37:12 -0700
IronPort-SDR: X+S2v99tFzIsN/cKSnb6kp1t+ywqQx3b8+C5mPQk4Z1YpvmC+Kb+iGEOgGXPlXBGF9WdcxNeca
 aloX9yTmrhkA==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="622630607"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 15:37:11 -0700
From:   ira.weiny@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] cxl/mem: Reserve all device regions at once
Date:   Thu,  6 May 2021 15:36:52 -0700
Message-Id: <20210506223654.1310516-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210506223654.1310516-1-ira.weiny@intel.com>
References: <20210506223654.1310516-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

In order to remap individual register sets each bar region must be
reserved prior to mapping.  Because the details of individual register
sets are contained within the BARs themselves, the bar must be mapped 2
times, once to extract this information and a second time for each
register set.

Rather than attempt to reserve each BAR individually and track if that
bar has been reserved.  Open code pcim_iomap_regions() by first
reserving all memory regions on the device and then mapping the bars
individually as needed.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/pci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 191603b4e10b..40016709b310 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -926,9 +926,9 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32
 {
 	struct pci_dev *pdev = cxlm->pdev;
 	struct device *dev = &pdev->dev;
+	void __iomem *rc;
 	u64 offset;
 	u8 bar;
-	int rc;
 
 	offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
 	bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
@@ -940,13 +940,14 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32
 		return (void __iomem *)ERR_PTR(-ENXIO);
 	}
 
-	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
-	if (rc) {
+	rc = pcim_iomap(pdev, bar, 0);
+	if (!rc) {
 		dev_err(dev, "failed to map registers\n");
-		return (void __iomem *)ERR_PTR(rc);
+		return (void __iomem *)ERR_PTR(-ENOMEM);
 	}
 
-	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
+	dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ 0x%llx\n",
+		bar, offset);
 
 	return pcim_iomap_table(pdev)[bar] + offset;
 }
@@ -999,6 +1000,9 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		return -ENXIO;
 	}
 
+	if (pci_request_mem_regions(pdev, pci_name(pdev)))
+		return -ENODEV;
+
 	/* Get the size of the Register Locator DVSEC */
 	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
 	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
-- 
2.28.0.rc0.12.gb6a658bd00c9

