Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2D6C43217
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 04:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355532AbhLBEnx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Dec 2021 23:43:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:61245 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355538AbhLBEnq (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 1 Dec 2021 23:43:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236438387"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="236438387"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:10 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="745717491"
Received: from liudanie-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:09 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 12/14] cxl: Unify port enumeration for decoders
Date:   Wed,  1 Dec 2021 20:37:48 -0800
Message-Id: <20211202043750.3501494-13-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202043750.3501494-1-ben.widawsky@intel.com>
References: <20211202043750.3501494-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The port driver exists to do proper enumeration of the component
registers for ports, including HDM decoder resources. Any port which
follows the CXL specification to implement HDM decoder registers should
be handled by the port driver. This includes host bridge registers that
are currently handled within the cxl_acpi driver.

In moving the responsibility from cxl_acpi to cxl_port, three primary
things are accomplished here:
1. Multi-port host bridges are now handled by the port driver
2. Single port host bridges are handled by the port driver
3. Single port switches without component registers will be handled by
   the port driver.

While it's tempting to remove decoder APIs from cxl_core entirely, it is
still required that platform specific drivers are able to add decoders
which aren't specified in CXL 2.0+. An example of this is the CFMWS
parsing which is implementing in cxl_acpi.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c     | 36 +++----------------------------
 drivers/cxl/core/bus.c |  6 ++++--
 drivers/cxl/cxl.h      |  2 ++
 drivers/cxl/port.c     | 49 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 57 insertions(+), 36 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 8dee8ebdec9d..7bb5699fc1ce 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -211,8 +211,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
 	struct acpi_pci_root *pci_root;
 	struct cxl_walk_context ctx;
-	int single_port_map[1], rc;
-	struct cxl_decoder *cxld;
 	struct cxl_dport *dport;
 	struct cxl_port *port;
 
@@ -246,38 +244,9 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 		return -ENODEV;
 	if (ctx.error)
 		return ctx.error;
-	if (ctx.count > 1)
-		return 0;
 
-	/* TODO: Scan CHBCR for HDM Decoder resources */
-
-	/*
-	 * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability
-	 * Structure) single ported host-bridges need not publish a decoder
-	 * capability when a passthrough decode can be assumed, i.e. all
-	 * transactions that the uport sees are claimed and passed to the single
-	 * dport. Disable the range until the first CXL region is enumerated /
-	 * activated.
-	 */
-	cxld = cxl_root_decoder_alloc(port, 1);
-	if (IS_ERR(cxld))
-		return PTR_ERR(cxld);
-
-	device_lock(&port->dev);
-	dport = list_first_entry(&port->dports, typeof(*dport), list);
-	device_unlock(&port->dev);
-
-	single_port_map[0] = dport->port_id;
-
-	rc = cxl_decoder_add(cxld, single_port_map);
-	if (rc)
-		put_device(&cxld->dev);
-	else
-		rc = cxl_decoder_autoremove(host, cxld);
-
-	if (rc == 0)
-		dev_dbg(host, "add: %s\n", dev_name(&cxld->dev));
-	return rc;
+	/* Host bridge ports are enumerated by the port driver. */
+	return 0;
 }
 
 struct cxl_chbs_context {
@@ -444,3 +413,4 @@ module_platform_driver(cxl_acpi_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
 MODULE_IMPORT_NS(ACPI);
+MODULE_SOFTDEP("pre: cxl_port");
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index e2cdea990b81..34a308708a99 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -62,7 +62,7 @@ void cxl_unregister_topology_host(struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_unregister_topology_host, CXL);
 
-static struct device *get_cxl_topology_host(void)
+struct device *get_cxl_topology_host(void)
 {
 	down_read(&topology_host_sem);
 	if (cxl_topology_host)
@@ -70,12 +70,14 @@ static struct device *get_cxl_topology_host(void)
 	up_read(&topology_host_sem);
 	return NULL;
 }
+EXPORT_SYMBOL_NS_GPL(get_cxl_topology_host, CXL);
 
-static void put_cxl_topology_host(struct device *dev)
+void put_cxl_topology_host(struct device *dev)
 {
 	WARN_ON(dev != cxl_topology_host);
 	up_read(&topology_host_sem);
 }
+EXPORT_SYMBOL_NS_GPL(put_cxl_topology_host, CXL);
 
 static int decoder_match(struct device *dev, void *data)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index dd6c76ac89df..df25dd20ff95 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -170,6 +170,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 int cxl_register_topology_host(struct device *host);
 void cxl_unregister_topology_host(struct device *host);
+struct device *get_cxl_topology_host(void);
+void put_cxl_topology_host(struct device *dev);
 
 /*
  * cxl_decoder flags that define the type of memory / devices this
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 242e6374f4a1..527b027dcf24 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -221,12 +221,59 @@ static int enumerate_switch_decoders(struct cxl_port *port,
 	return 0;
 }
 
+/*
+ * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability Structure)
+ * single ported host-bridges need not publish a decoder capability when a
+ * passthrough decode can be assumed, i.e. all transactions that the uport sees
+ * are claimed and passed to the single dport. Disable the range until the first
+ * CXL region is enumerated / activated.
+ */
+static int add_passthrough_decoder(struct cxl_port *port)
+{
+	int single_port_map[1], rc;
+	struct cxl_decoder *cxld;
+	struct cxl_dport *dport;
+
+	device_lock_assert(&port->dev);
+
+	cxld = cxl_switch_decoder_alloc(port, 1);
+	if (IS_ERR(cxld))
+		return PTR_ERR(cxld);
+
+	dport = list_first_entry(&port->dports, typeof(*dport), list);
+	single_port_map[0] = dport->port_id;
+
+	rc = cxl_decoder_add_locked(cxld, single_port_map);
+	if (rc)
+		put_device(&cxld->dev);
+	else
+		rc = cxl_decoder_autoremove(&port->dev, cxld);
+
+	if (rc == 0)
+		dev_dbg(&port->dev, "add: %s\n", dev_name(&cxld->dev));
+
+	return rc;
+}
+
 static int cxl_port_probe(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
 	struct cxl_port_data *portdata;
 	void __iomem *crb;
-	int rc;
+	int rc = 0;
+
+	if (list_is_singular(&port->dports)) {
+		struct device *host_dev = get_cxl_topology_host();
+
+		/*
+		 * Root ports (single host bridge downstream) are handled by
+		 * platform driver
+		 */
+		if (port->uport != host_dev)
+			rc = add_passthrough_decoder(port);
+		put_cxl_topology_host(host_dev);
+		return rc;
+	}
 
 	/*
 	 * All ports should have component registers except for the platform
-- 
2.34.1

