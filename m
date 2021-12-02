Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39C4C433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 04:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355536AbhLBEnq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Dec 2021 23:43:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:61242 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355506AbhLBEnc (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 1 Dec 2021 23:43:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236438373"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="236438373"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:05 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="745717403"
Received: from liudanie-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:04 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 04/14] cxl: Introduce topology host registration
Date:   Wed,  1 Dec 2021 20:37:40 -0800
Message-Id: <20211202043750.3501494-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202043750.3501494-1-ben.widawsky@intel.com>
References: <20211202043750.3501494-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The description of the CXL topology will be conveyed by a platform
specific entity that is expected to be a singleton. For ACPI based
systems, this is ACPI0017. This cxl_topology_host is needed as a
constraint for when CXL.mem connectivity can be verified from root to
endpoint. Given that endpoints can attach at any point in time relative
to when the root arrives CXL.mem connectivity needs to be revalidated at
every topology host arrival / depart event.

cxl_test makes for an interesting case. cxl_test creates an alternate
universe where there are possibly two root topology hosts (a real
ACPI0017/CEDT, and a fake ACPI0017/CEDT). For this to work in the
future, cxl_acpi (or some future platform host driver) will need to be
unloaded first.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
Changes since v1
- Commit message overhaul (Dan)
---
 drivers/cxl/acpi.c     | 18 ++++++++++---
 drivers/cxl/core/bus.c | 57 +++++++++++++++++++++++++++++++++++++++---
 drivers/cxl/cxl.h      |  5 +++-
 3 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 9f88dec03b33..7bcb54e9fe00 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -225,8 +225,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 		return 0;
 	}
 
-	port = devm_cxl_add_port(host, match, dport->component_reg_phys,
-				 root_port);
+	port = devm_cxl_add_port(match, dport->component_reg_phys, root_port);
 	if (IS_ERR(port))
 		return PTR_ERR(port);
 	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
@@ -377,6 +376,11 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
 	return 1;
 }
 
+static void clear_topology_host(void *data)
+{
+	cxl_unregister_topology_host(data);
+}
+
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
 	int rc;
@@ -385,7 +389,15 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	struct acpi_device *adev = ACPI_COMPANION(host);
 	struct cxl_cfmws_context ctx;
 
-	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
+	rc = cxl_register_topology_host(host);
+	if (rc)
+		return rc;
+
+	rc = devm_add_action_or_reset(host, clear_topology_host, host);
+	if (rc)
+		return rc;
+
+	root_port = devm_cxl_add_port(host, CXL_RESOURCE_NONE, root_port);
 	if (IS_ERR(root_port))
 		return PTR_ERR(root_port);
 	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 4bf355a3e396..97cbd7132b15 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -25,6 +25,53 @@
  */
 
 static DEFINE_IDA(cxl_port_ida);
+static DECLARE_RWSEM(topology_host_sem);
+
+static struct device *cxl_topology_host;
+
+int cxl_register_topology_host(struct device *host)
+{
+	down_write(&topology_host_sem);
+	if (cxl_topology_host) {
+		up_write(&topology_host_sem);
+		pr_warn("%s host currently in use. Please try unloading %s",
+			dev_name(cxl_topology_host), host->driver->name);
+		return -EBUSY;
+	}
+
+	cxl_topology_host = host;
+	up_write(&topology_host_sem);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_register_topology_host, CXL);
+
+void cxl_unregister_topology_host(struct device *host)
+{
+	down_write(&topology_host_sem);
+	if (cxl_topology_host == host)
+		cxl_topology_host = NULL;
+	else
+		pr_warn("topology host in use by %s\n",
+			cxl_topology_host->driver->name);
+	up_write(&topology_host_sem);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_unregister_topology_host, CXL);
+
+static struct device *get_cxl_topology_host(void)
+{
+	down_read(&topology_host_sem);
+	if (cxl_topology_host)
+		return cxl_topology_host;
+	up_read(&topology_host_sem);
+	return NULL;
+}
+
+static void put_cxl_topology_host(struct device *dev)
+{
+	WARN_ON(dev != cxl_topology_host);
+	up_read(&topology_host_sem);
+}
 
 static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
@@ -362,17 +409,16 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 
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
+	struct device *dev, *host;
 	struct cxl_port *port;
-	struct device *dev;
 	int rc;
 
 	port = cxl_port_alloc(uport, component_reg_phys, parent_port);
@@ -391,7 +437,12 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 	if (rc)
 		goto err;
 
+	host = get_cxl_topology_host();
+	if (!host)
+		return ERR_PTR(-ENODEV);
+
 	rc = devm_add_action_or_reset(host, unregister_port, port);
+	put_cxl_topology_host(host);
 	if (rc)
 		return ERR_PTR(rc);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 762d8254c7c6..6bafc2cd8f7a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -152,6 +152,9 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
 
+int cxl_register_topology_host(struct device *host);
+void cxl_unregister_topology_host(struct device *host);
+
 /*
  * cxl_decoder flags that define the type of memory / devices this
  * decoder supports as well as configuration lock status See "CXL 2.0
@@ -279,7 +282,7 @@ struct cxl_dport {
 };
 
 struct cxl_port *to_cxl_port(struct device *dev);
-struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
+struct cxl_port *devm_cxl_add_port(struct device *uport,
 				   resource_size_t component_reg_phys,
 				   struct cxl_port *parent_port);
 
-- 
2.34.1

