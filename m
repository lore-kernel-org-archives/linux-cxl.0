Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA1FC43217
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD1861057
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347397AbhIBTvd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 15:51:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:41971 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347401AbhIBTva (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 2 Sep 2021 15:51:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="198778208"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="198778208"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="533451641"
Received: from kappusam-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:27 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 09/13] cxl/pci: Retain map information in cxl_mem_probe
Date:   Thu,  2 Sep 2021 12:50:13 -0700
Message-Id: <20210902195017.2516472-10-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902195017.2516472-1-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In order for a memdev to participate in cxl_core's port APIs, the
physical address of the memdev's component registers is needed. This is
accomplished by allocating the array of maps in probe so they can be
used after the memdev is created.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 244b99948c40..e4b3549c4580 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -407,21 +407,22 @@ static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
 /**
  * cxl_pci_setup_regs() - Setup necessary MMIO.
  * @cxlm: The CXL memory device to communicate with.
+ * @maps: Array of maps populated by this function.
  *
- * Return: 0 if all necessary registers mapped.
+ * Return: 0 if all necessary registers mapped. The results are stored in @maps.
  *
  * A memory device is required by spec to implement a certain set of MMIO
  * regions. The purpose of this function is to enumerate and map those
  * registers.
  */
-static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
+static int cxl_pci_setup_regs(struct cxl_mem *cxlm, struct cxl_register_map maps[])
 {
 	struct pci_dev *pdev = to_pci_dev(cxlm->dev);
 	struct device *dev = cxlm->dev;
 	u32 regloc_size, regblocks;
 	void __iomem *base;
 	int regloc, i, n_maps;
-	struct cxl_register_map *map, maps[CXL_REGLOC_RBI_TYPES];
+	struct cxl_register_map *map;
 	int ret = 0;
 
 	regloc = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
@@ -492,6 +493,7 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	struct cxl_register_map maps[CXL_REGLOC_RBI_TYPES];
 	struct cxl_memdev *cxlmd;
 	struct cxl_mem *cxlm;
 	int rc;
@@ -511,7 +513,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlm))
 		return PTR_ERR(cxlm);
 
-	rc = cxl_pci_setup_regs(cxlm);
+	rc = cxl_pci_setup_regs(cxlm, maps);
 	if (rc)
 		return rc;
 
-- 
2.33.0

