Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E31DC2B9F4
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D03613BD
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhFRAyR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:54:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:2055 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233270AbhFRAyQ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 20:54:16 -0400
IronPort-SDR: NdKkNJJFoW7jYWwPqKRbud02vTeT3g23Gu0whPJQHRhx43VDLg+I9j+E14vL1f9PlYTrzMOeE9
 tKdLqqGSookw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="292105422"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="292105422"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 17:52:07 -0700
IronPort-SDR: 8424V+xkcdHipxZgc4JNLOscn/XD1fREMBxT3hVU+p9GbbmGBnnCYIuoByhFP2ttBTpFbMmMut
 7BXxE2y44nnw==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="622223132"
Received: from mkalyani-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 17:52:07 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 5/5] cxl/mem: Check that the device is CXL.mem capable
Date:   Thu, 17 Jun 2021 17:52:00 -0700
Message-Id: <20210618005200.997804-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618005200.997804-1-ben.widawsky@intel.com>
References: <20210618005200.997804-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c | 18 ++++++++++++++++++
 drivers/cxl/pci.h |  5 ++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index cbf18df24109..7f26937c7151 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -4,6 +4,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include "mem.h"
+#include "pci.h"
 
 /**
  * DOC: cxl mem
@@ -41,14 +42,31 @@ static int cxl_memdev_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_mem *cxlm = cxlmd->cxlm;
+	struct pci_dev *pdev = cxlm->pdev;
 	struct device *pdev_parent = cxlm->pdev->dev.parent;
 	struct device *port_dev;
+	int pcie_dvsec;
+	u16 dvsec_ctrl;
 
 	port_dev =
 		bus_find_device(&cxl_bus_type, NULL, pdev_parent, port_match);
 	if (!port_dev)
 		return -ENODEV;
 
+	pcie_dvsec = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_PCIE_DVSEC_CXL_DVSEC_ID);
+	if (!pcie_dvsec) {
+		dev_err(dev, "Unable to determine CXL protocol support");
+		return -ENODEV;
+	}
+
+	pci_read_config_word(pdev,
+			     pcie_dvsec + PCI_DVSEC_ID_CXL_PCIE_CTRL_OFFSET,
+			     &dvsec_ctrl);
+	if (!(dvsec_ctrl & CXL_PCIE_MEM_ENABLE)) {
+		dev_err(dev, "CXL.cache protocol not supported on device");
+		return -ENODEV;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index 0d6f50f725bc..ee26bc8c2ec8 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -11,7 +11,10 @@
  */
 #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
 #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
-#define PCI_DVSEC_ID_CXL		0x0
+
+#define PCI_DVSEC_ID_PCIE_DVSEC_CXL_DVSEC_ID	0x0
+#define PCI_DVSEC_ID_CXL_PCIE_CTRL_OFFSET	0xC
+#define   CXL_PCIE_MEM_ENABLE			BIT(2)
 
 #define PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID	0x8
 #define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC
-- 
2.32.0

