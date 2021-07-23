Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2748FC4338F
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0182D60F23
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhGWU0D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:34284 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhGWU0D (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671184"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671184"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436110"
Received: from rfrederi-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.136.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:35 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 04/23] cxl/mem: Move character device region creation
Date:   Fri, 23 Jul 2021 14:06:04 -0700
Message-Id: <20210723210623.114073-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723210623.114073-1-ben.widawsky@intel.com>
References: <20210723210623.114073-1-ben.widawsky@intel.com>
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
index 4cf351a3cf99..0d9091379963 100644
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

