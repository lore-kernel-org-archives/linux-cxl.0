Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DD7C4167D
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3CE26126A
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbhJPFRs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:17:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:1736 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231582AbhJPFRr (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 16 Oct 2021 01:17:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225489601"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="225489601"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:40 -0700
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="442743267"
Received: from asimon-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.133.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:40 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 09/27] cxl/core: Store global list of root ports
Date:   Fri, 15 Oct 2021 22:15:13 -0700
Message-Id: <20211016051531.622613-10-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016051531.622613-1-ben.widawsky@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL root ports (the downstream port to a host bridge) are to be
enumerated by a platform specific driver. In the case of ACPI compliant
systems, this is like the cxl_acpi driver. Root ports are the first
CXL spec defined component that can be "found" by that platform specific
driver.

By storing a list of these root ports components in lower levels of the
topology (switches and endpoints), have a mechanism to walk up their
device hierarchy to find an enumerated root port. This will be necessary
for region programming.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c            |  4 ++--
 drivers/cxl/core/bus.c        | 34 +++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h             |  5 ++++-
 tools/testing/cxl/mock_acpi.c |  4 ++--
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 8cca0814dfb8..625c5d95b83f 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -231,7 +231,7 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
 		creg = cxl_reg_block(pdev, &map);
 
 	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	rc = cxl_add_dport(port, &pdev->dev, port_num, creg);
+	rc = cxl_add_dport(port, &pdev->dev, port_num, creg, true);
 	if (rc) {
 		ctx->error = rc;
 		return rc;
@@ -406,7 +406,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 		dev_dbg(host, "No CHBS found for Host Bridge: %s\n",
 			dev_name(match));
 
-	rc = cxl_add_dport(root_port, match, uid, get_chbcr(chbs));
+	rc = cxl_add_dport(root_port, match, uid, get_chbcr(chbs), false);
 	if (rc) {
 		dev_err(host, "failed to add downstream port: %s\n",
 			dev_name(match));
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 64d0157191d0..fa37115ef8e1 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -25,6 +25,8 @@
  */
 
 static DEFINE_IDA(cxl_port_ida);
+static LIST_HEAD(cxl_root_ports);
+static DECLARE_RWSEM(root_port_sem);
 
 static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
@@ -268,12 +270,31 @@ struct cxl_port *to_cxl_port(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(to_cxl_port);
 
+struct cxl_dport *cxl_get_root_dport(struct device *dev)
+{
+	struct cxl_dport *ret = NULL;
+	struct cxl_dport *dport;
+
+	down_read(&root_port_sem);
+	list_for_each_entry(dport, &cxl_root_ports, root_port_link) {
+		if (dport->dport == dev) {
+			ret = dport;
+			break;
+		}
+	}
+
+	up_read(&root_port_sem);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cxl_get_root_dport);
+
 static void unregister_port(void *_port)
 {
 	struct cxl_port *port = _port;
 	struct cxl_dport *dport;
 
 	device_lock(&port->dev);
+	down_read(&root_port_sem);
 	list_for_each_entry(dport, &port->dports, list) {
 		char link_name[CXL_TARGET_STRLEN];
 
@@ -281,7 +302,10 @@ static void unregister_port(void *_port)
 			     dport->port_id) >= CXL_TARGET_STRLEN)
 			continue;
 		sysfs_remove_link(&port->dev.kobj, link_name);
+
+		list_del_init(&dport->root_port_link);
 	}
+	up_read(&root_port_sem);
 	device_unlock(&port->dev);
 	device_unregister(&port->dev);
 }
@@ -431,12 +455,13 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
  * @dport_dev: firmware or PCI device representing the dport
  * @port_id: identifier for this dport in a decoder's target list
  * @component_reg_phys: optional location of CXL component registers
+ * @root_port: is this a root port (hostbridge downstream)
  *
  * Note that all allocations and links are undone by cxl_port deletion
  * and release.
  */
 int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
-		  resource_size_t component_reg_phys)
+		  resource_size_t component_reg_phys, bool root_port)
 {
 	char link_name[CXL_TARGET_STRLEN];
 	struct cxl_dport *dport;
@@ -451,6 +476,7 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&dport->list);
+	INIT_LIST_HEAD(&dport->root_port_link);
 	dport->dport = get_device(dport_dev);
 	dport->port_id = port_id;
 	dport->component_reg_phys = component_reg_phys;
@@ -464,6 +490,12 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
 	if (rc)
 		goto err;
 
+	if (root_port) {
+		down_write(&root_port_sem);
+		list_add_tail(&dport->root_port_link, &cxl_root_ports);
+		up_write(&root_port_sem);
+	}
+
 	return 0;
 err:
 	cxl_dport_release(dport);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ce05e805b597..260091f1ab6f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -291,6 +291,7 @@ struct cxl_port {
  * @component_reg_phys: downstream port component registers
  * @port: reference to cxl_port that contains this downstream port
  * @list: node for a cxl_port's list of cxl_dport instances
+ * @root_port_link: node for global list of root ports
  */
 struct cxl_dport {
 	struct device *dport;
@@ -298,6 +299,7 @@ struct cxl_dport {
 	resource_size_t component_reg_phys;
 	struct cxl_port *port;
 	struct list_head list;
+	struct list_head root_port_link;
 };
 
 struct cxl_port *to_cxl_port(struct device *dev);
@@ -306,7 +308,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   struct cxl_port *parent_port);
 
 int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
-		  resource_size_t component_reg_phys);
+		  resource_size_t component_reg_phys, bool root_port);
+struct cxl_dport *cxl_get_root_dport(struct device *dev);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
diff --git a/tools/testing/cxl/mock_acpi.c b/tools/testing/cxl/mock_acpi.c
index 4c8a493ace56..ddefc4345f36 100644
--- a/tools/testing/cxl/mock_acpi.c
+++ b/tools/testing/cxl/mock_acpi.c
@@ -57,7 +57,7 @@ static int match_add_root_port(struct pci_dev *pdev, void *data)
 
 	/* TODO walk DVSEC to find component register base */
 	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
+	rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE, true);
 	if (rc) {
 		dev_err(dev, "failed to add dport: %s (%d)\n",
 			dev_name(&pdev->dev), rc);
@@ -78,7 +78,7 @@ static int mock_add_root_port(struct platform_device *pdev, void *data)
 	struct device *dev = ctx->dev;
 	int rc;
 
-	rc = cxl_add_dport(port, &pdev->dev, pdev->id, CXL_RESOURCE_NONE);
+	rc = cxl_add_dport(port, &pdev->dev, pdev->id, CXL_RESOURCE_NONE, true);
 	if (rc) {
 		dev_err(dev, "failed to add dport: %s (%d)\n",
 			dev_name(&pdev->dev), rc);
-- 
2.33.1

