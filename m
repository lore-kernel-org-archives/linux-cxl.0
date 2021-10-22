Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C2EC4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C1560F22
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhJVSjh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:5577 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233962AbhJVSjf (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528949"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528949"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:17 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854659"
Received: from aagregor-mobl3.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.134.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:17 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH v2 14/28] cxl: Hide devm host for ports
Date:   Fri, 22 Oct 2021 11:36:55 -0700
Message-Id: <20211022183709.1199701-15-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Generally, a platform will only have a single instance of an  entity
which has a platform specific CXL driver. For the time being, this is
only the ACPI0017 device defined as part of the CXL specification and
ancillary specs (ACPI). With this in mind it becomes easy to drop the
need to pass this around for devm functions which want to know the root
host. That change allows future work with the mem/port driver to avoid
having to determine the root host for port creation for endpoints and
switches.

There's some technical dept leftover with regard to cxl_test.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c     | 15 ++++++++++++---
 drivers/cxl/core/bus.c | 33 +++++++++++++++++++++++++++++----
 drivers/cxl/cxl.h      |  5 ++++-
 3 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 1cc3a74c16bd..f6b78736c933 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -298,8 +298,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 		return -ENODEV;
 	}
 
-	port = devm_cxl_add_port(host, match, dport->component_reg_phys,
-				 root_port);
+	port = devm_cxl_add_port(match, dport->component_reg_phys, root_port);
 	if (IS_ERR(port))
 		return PTR_ERR(port);
 	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
@@ -467,7 +466,9 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	struct device *host = &pdev->dev;
 	struct acpi_device *adev = ACPI_COMPANION(host);
 
-	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
+	cxl_register_root(host);
+
+	root_port = devm_cxl_add_port(host, CXL_RESOURCE_NONE, NULL);
 	if (IS_ERR(root_port))
 		return PTR_ERR(root_port);
 	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
@@ -513,6 +514,13 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int cxl_acpi_remove(struct platform_device *pdev)
+{
+	cxl_unregister_root();
+
+	return 0;
+}
+
 static bool native_acpi0017 = true;
 
 static const struct acpi_device_id cxl_acpi_ids[] = {
@@ -523,6 +531,7 @@ MODULE_DEVICE_TABLE(acpi, cxl_acpi_ids);
 
 static struct platform_driver cxl_acpi_driver = {
 	.probe = cxl_acpi_probe,
+	.remove = cxl_acpi_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.acpi_match_table = cxl_acpi_ids,
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 03394a3ae75f..c7e1894d503b 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -27,6 +27,32 @@
 static DEFINE_IDA(cxl_port_ida);
 static LIST_HEAD(cxl_root_ports);
 static DECLARE_RWSEM(root_port_sem);
+static DECLARE_RWSEM(root_host_sem);
+
+static struct device *cxl_root_host;
+
+int cxl_register_root(struct device *host)
+{
+	down_write(&root_host_sem);
+	if (cxl_root_host)
+		return -EBUSY;
+
+	get_device(host);
+	cxl_root_host = host;
+	up_write(&root_host_sem);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_register_root);
+
+void cxl_unregister_root(void)
+{
+	down_write(&root_host_sem);
+	put_device(cxl_root_host);
+	cxl_root_host = NULL;
+	up_write(&root_host_sem);
+}
+EXPORT_SYMBOL_GPL(cxl_unregister_root);
 
 static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
@@ -375,12 +401,11 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 
 /**
  * devm_cxl_add_port - register a cxl_port in CXL memory decode hierarchy
- * @host: host device for devm operations
  * @uport: "physical" device implementing this upstream port
  * @component_reg_phys: (optional) for configurable cxl_port instances
  * @parent_port: next hop up in the CXL memory decode hierarchy
  */
-struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
+struct cxl_port *devm_cxl_add_port(struct device *uport,
 				   resource_size_t component_reg_phys,
 				   struct cxl_port *parent_port)
 {
@@ -404,11 +429,11 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 	if (rc)
 		goto err;
 
-	rc = devm_add_action_or_reset(host, unregister_port, port);
+	rc = devm_add_action_or_reset(cxl_root_host, unregister_port, port);
 	if (rc)
 		return ERR_PTR(rc);
 
-	rc = devm_cxl_link_uport(host, port);
+	rc = devm_cxl_link_uport(cxl_root_host, port);
 	if (rc)
 		return ERR_PTR(rc);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d26d97e1098d..419c2e2db6f0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -184,6 +184,9 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
 
+int cxl_register_root(struct device *host);
+void cxl_unregister_root(void);
+
 /*
  * cxl_decoder flags that define the type of memory / devices this
  * decoder supports as well as configuration lock status See "CXL 2.0
@@ -303,7 +306,7 @@ struct cxl_dport {
 };
 
 struct cxl_port *to_cxl_port(struct device *dev);
-struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
+struct cxl_port *devm_cxl_add_port(struct device *uport,
 				   resource_size_t component_reg_phys,
 				   struct cxl_port *parent_port);
 
-- 
2.33.1

