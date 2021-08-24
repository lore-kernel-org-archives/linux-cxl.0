Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6229C432BE
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Aug 2021 16:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF856127B
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Aug 2021 16:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhHXQIs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:08:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:14283 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231176AbhHXQIq (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 24 Aug 2021 12:08:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="197590691"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="197590691"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:07:03 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="426161877"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:07:02 -0700
Subject: [PATCH v3 18/28] cxl/pci: Use module_pci_driver
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, vishal.l.verma@intel.com,
        alison.schofield@intel.com, nvdimm@lists.linux.dev,
        Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
        ben.widawsky@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Date:   Tue, 24 Aug 2021 09:07:02 -0700
Message-ID: <162982122234.1124374.8206618857845373193.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |   30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b8075b941a3a..425e821160b5 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -519,6 +519,13 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -573,27 +580,6 @@ static struct pci_driver cxl_mem_driver = {
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

