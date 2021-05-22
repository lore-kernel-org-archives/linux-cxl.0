Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC0FC4707E
	for <linux-cxl@archiver.kernel.org>; Sat, 22 May 2021 00:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062D4613E4
	for <linux-cxl@archiver.kernel.org>; Sat, 22 May 2021 00:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhEVANX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 May 2021 20:13:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:2007 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhEVANX (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 21 May 2021 20:13:23 -0400
IronPort-SDR: A3XZkcUtwD/+h4iQPGOdqf40Uij6azLmX9JY9YAt1aOY65YCGAY8X1MlTabdVVEQqV92kBUfMk
 M8YsvCLtVhUw==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="188727598"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="188727598"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 17:11:58 -0700
IronPort-SDR: KZeADDi4YzmldFp6lVoMkdgqVvdrSeRFD/fO7QR6WsotFDtbCffqfPYIW6Ad+JkY9GXt0OesR7
 pTySJGwMJ1vw==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="631990653"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 17:11:57 -0700
From:   ira.weiny@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] cxl/mem: Reserve all device regions at once
Date:   Fri, 21 May 2021 17:11:51 -0700
Message-Id: <20210522001154.2680157-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210522001154.2680157-1-ira.weiny@intel.com>
References: <20210522001154.2680157-1-ira.weiny@intel.com>
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

NOTE pci_request_mem_regions() does not need a corresponding
pci_release_mem_regions() because the pci device is managed via
pcim_enable_device().

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V2:
	Rebased on https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?h=pending
	Clarify why pci_release_mem_regions() does not need to be
	called.
	Adjust for the different return code between pcim_iomap_regions() and
	pcim_iomap()
	Change print specifier.
---
 drivers/cxl/pci.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b2f978954daa..33fc6e1634e3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -927,7 +927,7 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm,
 {
 	struct pci_dev *pdev = cxlm->pdev;
 	struct device *dev = &pdev->dev;
-	int rc;
+	void __iomem *addr;
 
 	/* Basic sanity check that BAR is big enough */
 	if (pci_resource_len(pdev, bar) < offset) {
@@ -936,13 +936,14 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm,
 		return IOMEM_ERR_PTR(-ENXIO);
 	}
 
-	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
-	if (rc) {
+	addr = pcim_iomap(pdev, bar, 0);
+	if (!addr) {
 		dev_err(dev, "failed to map registers\n");
-		return IOMEM_ERR_PTR(rc);
+		return addr;
 	}
 
-	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
+	dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ %#llx\n",
+		bar, offset);
 
 	return pcim_iomap_table(pdev)[bar] + offset;
 }
@@ -1003,6 +1004,9 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		return -ENXIO;
 	}
 
+	if (pci_request_mem_regions(pdev, pci_name(pdev)))
+		return -ENODEV;
+
 	/* Get the size of the Register Locator DVSEC */
 	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
 	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
@@ -1028,8 +1032,8 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 
 		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
 			base = cxl_mem_map_regblock(cxlm, bar, offset);
-			if (IS_ERR(base))
-				return PTR_ERR(base);
+			if (!base)
+				return -ENOMEM;
 			break;
 		}
 	}
-- 
2.28.0.rc0.12.gb6a658bd00c9

