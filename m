Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68186C12002
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jul 2021 23:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46DE96128B
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jul 2021 23:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbhGPXS5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jul 2021 19:18:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:65193 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231293AbhGPXS4 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 16 Jul 2021 19:18:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="190479028"
X-IronPort-AV: E=Sophos;i="5.84,246,1620716400"; 
   d="scan'208";a="190479028"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 16:16:00 -0700
X-IronPort-AV: E=Sophos;i="5.84,246,1620716400"; 
   d="scan'208";a="431362196"
Received: from jhiga-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.135.195])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 16:16:00 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 3/3] cxl/pci: Retain map information in cxl_mem_probe
Date:   Fri, 16 Jul 2021 16:15:48 -0700
Message-Id: <20210716231548.174778-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716231548.174778-1-ben.widawsky@intel.com>
References: <20210716231548.174778-1-ben.widawsky@intel.com>
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
index 8be18daa1420..f924a8c5a831 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1066,21 +1066,22 @@ static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
 /**
  * cxl_mem_setup_regs() - Setup necessary MMIO.
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
-static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
+static int cxl_mem_setup_regs(struct cxl_mem *cxlm, struct cxl_register_map maps[])
 {
 	struct pci_dev *pdev = cxlm->pdev;
 	struct device *dev = &pdev->dev;
 	u32 regloc_size, regblocks;
 	void __iomem *base;
 	int regloc, i, n_maps;
-	struct cxl_register_map *map, maps[CXL_REGLOC_RBI_TYPES];
+	struct cxl_register_map *map;
 	int ret = 0;
 
 	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
@@ -1364,6 +1365,7 @@ static void cxl_memdev_shutdown(struct cxl_memdev *cxlmd)
 
 static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	struct cxl_register_map maps[CXL_REGLOC_RBI_TYPES];
 	struct cxl_memdev *cxlmd;
 	struct cxl_mem *cxlm;
 	int rc;
@@ -1376,7 +1378,7 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlm))
 		return PTR_ERR(cxlm);
 
-	rc = cxl_mem_setup_regs(cxlm);
+	rc = cxl_mem_setup_regs(cxlm, maps);
 	if (rc)
 		return rc;
 
-- 
2.32.0

