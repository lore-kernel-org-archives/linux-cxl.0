Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A652C433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 05:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F2A60F5B
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 05:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350581AbhIIFNt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Sep 2021 01:13:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:60465 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350580AbhIIFNr (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 9 Sep 2021 01:13:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="217522633"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="217522633"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 22:12:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="696079569"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 22:12:38 -0700
Subject: [PATCH v4 12/21] cxl/pci: Use module_pci_driver
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, nvdimm@lists.linux.dev,
        ben.widawsky@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Wed, 08 Sep 2021 22:12:38 -0700
Message-ID: <163116435825.2460985.7201322215431441130.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Now that cxl_mem_{init,exit} no longer need to manage debugfs, switch
back to the smaller form of the boiler plate.

Acked-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |   30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index c9f2ac134f4d..27f75b5a2ee2 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -517,6 +517,13 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct cxl_mem *cxlm;
 	int rc;
 
+	/*
+	 * Double check the anonymous union trickery in struct cxl_regs
+	 * FIXME switch to struct_group()
+	 */
+	BUILD_BUG_ON(offsetof(struct cxl_regs, memdev) !=
+		     offsetof(struct cxl_regs, device_regs.memdev));
+
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -571,27 +578,6 @@ static struct pci_driver cxl_mem_driver = {
 	},
 };
 
-static __init int cxl_mem_init(void)
-{
-	int rc;
-
-	/* Double check the anonymous union trickery in struct cxl_regs */
-	BUILD_BUG_ON(offsetof(struct cxl_regs, memdev) !=
-		     offsetof(struct cxl_regs, device_regs.memdev));
-
-	rc = pci_register_driver(&cxl_mem_driver);
-	if (rc)
-		return rc;
-
-	return 0;
-}
-
-static __exit void cxl_mem_exit(void)
-{
-	pci_unregister_driver(&cxl_mem_driver);
-}
-
 MODULE_LICENSE("GPL v2");
-module_init(cxl_mem_init);
-module_exit(cxl_mem_exit);
+module_pci_driver(cxl_mem_driver);
 MODULE_IMPORT_NS(CXL);

