Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39A9C636C9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jul 2021 19:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A8B613CC
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jul 2021 19:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244959AbhGOT6c (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:58:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:23897 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344364AbhGOTtX (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 15 Jul 2021 15:49:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="197803800"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="197803800"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 12:41:34 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="489564792"
Received: from cherrera-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.135.149])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 12:41:33 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 4/6] cxl/mem: Move character device region creation
Date:   Thu, 15 Jul 2021 12:41:23 -0700
Message-Id: <20210715194125.898305-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210715194125.898305-1-ben.widawsky@intel.com>
References: <20210715194125.898305-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In order to merge the memdev specific functionality of cxl_pci into
core, the character device creation currently handled by cxl_pci need to
be moved. The rest of the changes are largely cut/paste, the actual
functional change is done here in preparation.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/bus.c | 12 ++++++++++++
 drivers/cxl/mem.h      |  2 ++
 drivers/cxl/pci.c      | 14 +-------------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 33196813ebcb..8c2351c52d2b 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -22,6 +22,8 @@
  * instantiated by the core.
  */
 
+int cxl_mem_major;
+EXPORT_SYMBOL_GPL(cxl_mem_major);
 static DEFINE_IDA(cxl_port_ida);
 
 static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
@@ -632,12 +634,22 @@ EXPORT_SYMBOL_GPL(cxl_bus_type);
 
 static __init int cxl_core_init(void)
 {
+	dev_t devt;
+	int rc;
+
+	rc = alloc_chrdev_region(&devt, 0, CXL_MEM_MAX_DEVS, "cxl");
+	if (rc)
+		return rc;
+
+	cxl_mem_major = MAJOR(devt);
+
 	return bus_register(&cxl_bus_type);
 }
 
 static void cxl_core_exit(void)
 {
 	bus_unregister(&cxl_bus_type);
+	unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
 }
 
 module_init(cxl_core_init);
diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 8f02d02b26b4..2092f86beeb8 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -34,6 +34,8 @@
  */
 #define CXL_MEM_MAX_DEVS 65536
 
+extern int cxl_mem_major;
+
 /**
  * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
  * @dev: driver core device object
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index fe240e1504d5..6f10b19c9c83 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -94,7 +94,6 @@ struct mbox_cmd {
 #define CXL_MBOX_SUCCESS 0
 };
 
-static int cxl_mem_major;
 static DEFINE_IDA(cxl_memdev_ida);
 static DECLARE_RWSEM(cxl_memdev_rwsem);
 static struct dentry *cxl_debugfs;
@@ -1640,25 +1639,15 @@ static struct pci_driver cxl_mem_driver = {
 static __init int cxl_mem_init(void)
 {
 	struct dentry *mbox_debugfs;
-	dev_t devt;
 	int rc;
 
 	/* Double check the anonymous union trickery in struct cxl_regs */
 	BUILD_BUG_ON(offsetof(struct cxl_regs, memdev) !=
 		     offsetof(struct cxl_regs, device_regs.memdev));
 
-	rc = alloc_chrdev_region(&devt, 0, CXL_MEM_MAX_DEVS, "cxl");
-	if (rc)
-		return rc;
-
-	cxl_mem_major = MAJOR(devt);
-
 	rc = pci_register_driver(&cxl_mem_driver);
-	if (rc) {
-		unregister_chrdev_region(MKDEV(cxl_mem_major, 0),
-					 CXL_MEM_MAX_DEVS);
+	if (rc)
 		return rc;
-	}
 
 	cxl_debugfs = debugfs_create_dir("cxl", NULL);
 	mbox_debugfs = debugfs_create_dir("mbox", cxl_debugfs);
@@ -1672,7 +1661,6 @@ static __exit void cxl_mem_exit(void)
 {
 	debugfs_remove_recursive(cxl_debugfs);
 	pci_unregister_driver(&cxl_mem_driver);
-	unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
 }
 
 MODULE_LICENSE("GPL v2");
-- 
2.32.0

