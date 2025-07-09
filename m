Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB6243374
	for <linux-cxl@vger.kernel.org>; Wed,  9 Jul 2025 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093396; cv=none; b=dh5dQ9boXnbxtsKBW+3cj2ZZenidQ8t9NvkdqYi8n/aPoTn+fRKny+yqPahO+DHRdw4fcwL648b2pV8gLVEJlY/Ge3pIZDZ43M2l9R/14jm0yK0kjnwI/ErHpRzDsvjj/DBy0MAPJM29lhF41bnCDLKs0xcFIseTfkDFQrPCCBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093396; c=relaxed/simple;
	bh=vtLnPX4RBDu52yDbfiK4RHpEx2BI+/x5za17lQpJSn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgzmECXBym2m769ZjjpugFyjMg+MPt8Dz5MqIZPPUb5YQVKz27qn9TLFhH3gqpABYgtc1Tc7B2lM9Tu1MdBpuVj53QsvCjvARXLYA+NmdMn8DKjxgvey49Ki1/FpmJU/OotlzbPUhGLFNSFfPwytn/UO/VtDvEgKgK2WpF0lCx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55F0C4CEEF;
	Wed,  9 Jul 2025 20:36:35 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v6 09/10] cxl: Move enumeration of hostbridge ports to the memdev probe path
Date: Wed,  9 Jul 2025 13:36:18 -0700
Message-ID: <20250709203619.2607133-10-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250709203619.2607133-1-dave.jiang@intel.com>
References: <20250709203619.2607133-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current enuemration scheme in cxl_acpi module creates the ports under the
root port by enumerating the hostbridges after the dports under the root
port is created. However error messages "cxl portN: Couldn't locate the
CXL.cache and CXL.mem capability array header" is observed when certain
platform has PCIe hotplug option turned on in BIOS. If the cxl_acpi module
probe is running before the CXL link between the endpoint device and the
RP is established, then the platform may not have exposed DVSEC ID 3 and/or
DVSEC ID 7 blocks which will trigger the error message. This behavior
is defined by the spec and not a hardware quirk.

Setup an association in cxl_port to tie the host bridge device to the
associated cxl_root. The cxl_root provides a callback that's setup
by the cxl_acpi probe function in order to create a port per host bridge
that was previously done during cxl_acpi probe. Add the calling of the
callback in devm_cxl_enumerate_ports(). The observed behavior is that
ports that are not connected to endpoint device(s) are no longer
enumerated. This should also remove any excessive noise of port probe
failing on those inactive ports.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- Deal with -EEXIST output for devm_cxl_port_add_dport()
- Set dport to NULL during declare. (Jonathan)
---
 drivers/cxl/acpi.c      | 137 ++++++++++++++++++++++++----------------
 drivers/cxl/core/port.c |  84 ++++++++++++++++++++++++
 drivers/cxl/cxl.h       |   2 +
 3 files changed, 168 insertions(+), 55 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index a1a99ec3f12c..badaa99ab33a 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -296,8 +296,80 @@ static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
 	return cxl_acpi_evaluate_qtg_dsm(handle, coord, entries, qos_class);
 }
 
+/* Note, @dev is used by mock_acpi_table_parse_cedt() */
+struct cxl_chbs_context {
+	struct device *dev;
+	unsigned long long uid;
+	resource_size_t base;
+	u32 cxl_version;
+	int nr_versions;
+	u32 saved_version;
+};
+
+static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
+			struct cxl_chbs_context *ctx);
+
+/*
+ * A host bridge is a dport to a CFMWS decoder and it is a uport to the
+ * dport (PCIe Root Ports) in the host bridge.
+ */
+static int cxl_acpi_setup_hostbridge_uport(struct cxl_root *cxl_root,
+					   struct device *bridge_dev)
+{
+	struct cxl_port *root_port = &cxl_root->port;
+	struct device *host = root_port->dev.parent;
+	struct acpi_device *hb = ACPI_COMPANION(bridge_dev);
+	resource_size_t component_reg_phys;
+	struct acpi_pci_root *pci_root;
+	struct cxl_chbs_context ctx;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+	int rc;
+
+	device_lock_assert(&cxl_root->port.dev);
+	pci_root = acpi_pci_find_root(hb->handle);
+	dport = cxl_find_dport_by_dev(root_port, bridge_dev);
+	if (!dport) {
+		dev_dbg(host, "Host bridge expected and not found\n");
+		return -ENODEV;
+	}
+
+	if (dport->rch) {
+		dev_info(bridge_dev, "host supports CXL (restricted)\n");
+		return 0;
+	}
+
+	rc = cxl_get_chbs(&hb->dev, hb, &ctx);
+	if (rc)
+		return rc;
+
+	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
+		dev_warn(bridge_dev,
+			 "CXL CHBS version mismatch, skip port registration\n");
+		return 0;
+	}
+
+	component_reg_phys = ctx.base;
+	if (component_reg_phys != CXL_RESOURCE_NONE)
+		dev_dbg(&hb->dev, "CHBRC found for UID %lld: %pa\n",
+			ctx.uid, &component_reg_phys);
+
+	rc = devm_cxl_register_pci_bus(host, bridge_dev, pci_root->bus);
+	if (rc && rc != -EBUSY)
+		return rc;
+
+	port = devm_cxl_add_port(host, bridge_dev, component_reg_phys, dport);
+	if (IS_ERR(port))
+		return PTR_ERR(port);
+
+	dev_info(bridge_dev, "host supports CXL\n");
+
+	return 0;
+}
+
 static const struct cxl_root_ops acpi_root_ops = {
 	.qos_class = cxl_acpi_qos_class,
+	.setup_hostbridge_uport = cxl_acpi_setup_hostbridge_uport,
 };
 
 static void del_cxl_resource(struct resource *res)
@@ -466,16 +538,6 @@ __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
 	return NULL;
 }
 
-/* Note, @dev is used by mock_acpi_table_parse_cedt() */
-struct cxl_chbs_context {
-	struct device *dev;
-	unsigned long long uid;
-	resource_size_t base;
-	u32 cxl_version;
-	int nr_versions;
-	u32 saved_version;
-};
-
 static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
 			     const unsigned long end)
 {
@@ -598,7 +660,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	/*
 	 * In RCH mode, bind the component regs base to the dport. In
 	 * VH mode it will be bound to the CXL host bridge's port
-	 * object later in add_host_bridge_uport().
+	 * object later in cxl_acpi_setup_hostbridge_uport().
 	 */
 	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
 		dev_dbg(match, "RCRB found for UID %lld: %pa\n", ctx.uid,
@@ -620,22 +682,14 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	return 0;
 }
 
-/*
- * A host bridge is a dport to a CFMWS decode and it is a uport to the
- * dport (PCIe Root Ports) in the host bridge.
- */
-static int add_host_bridge_uport(struct device *match, void *arg)
+static int set_cxl_root_to_hostbridge(struct device *match, void *arg)
 {
 	struct cxl_port *root_port = arg;
 	struct device *host = root_port->dev.parent;
 	struct acpi_device *hb = to_cxl_host_bridge(host, match);
-	struct acpi_pci_root *pci_root;
 	struct cxl_dport *dport;
-	struct cxl_port *port;
+	struct acpi_pci_root *pci_root;
 	struct device *bridge;
-	struct cxl_chbs_context ctx;
-	resource_size_t component_reg_phys;
-	int rc;
 
 	if (!hb)
 		return 0;
@@ -648,37 +702,12 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 		return 0;
 	}
 
-	if (dport->rch) {
-		dev_info(bridge, "host supports CXL (restricted)\n");
+	if (dport->rch)
 		return 0;
-	}
 
-	rc = cxl_get_chbs(match, hb, &ctx);
-	if (rc)
-		return rc;
-
-	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
-		dev_warn(bridge,
-			 "CXL CHBS version mismatch, skip port registration\n");
-		return 0;
-	}
-
-	component_reg_phys = ctx.base;
-	if (component_reg_phys != CXL_RESOURCE_NONE)
-		dev_dbg(match, "CHBCR found for UID %lld: %pa\n",
-			ctx.uid, &component_reg_phys);
-
-	rc = devm_cxl_register_pci_bus(host, bridge, pci_root->bus);
-	if (rc)
-		return rc;
-
-	port = devm_cxl_add_port(host, bridge, component_reg_phys, dport);
-	if (IS_ERR(port))
-		return PTR_ERR(port);
-
-	dev_info(bridge, "host supports CXL\n");
-
-	return 0;
+	bridge = pci_root->bus->bridge;
+	return devm_cxl_register_hb_uport_root_port(host, bridge,
+						    to_cxl_root(root_port));
 }
 
 static int add_root_nvdimm_bridge(struct device *match, void *data)
@@ -852,6 +881,7 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 		return PTR_ERR(cxl_root);
 	root_port = &cxl_root->port;
 
+	 /* Root level scanned with host-bridge as dports */
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_dport);
 	if (rc < 0)
@@ -880,12 +910,9 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	 */
 	device_for_each_child(&root_port->dev, cxl_res, pair_cxl_resource);
 
-	/*
-	 * Root level scanned with host-bridge as dports, now scan host-bridges
-	 * for their role as CXL uports to their CXL-capable PCIe Root Ports.
-	 */
+	/* Scan host-bridges and point the cxl root port struct to it */
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
-			      add_host_bridge_uport);
+			      set_cxl_root_to_hostbridge);
 	if (rc < 0)
 		return rc;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2a80749a1994..ff3a6a66333d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1805,6 +1805,86 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 
 #define CXL_ITER_LEVEL_SWITCH	1
 
+static int get_hostbridge_port_devices(struct cxl_memdev *cxlmd,
+				       struct device **hb_uport_dev,
+				       struct device **hb_dport_dev)
+{
+	struct device *dev = &cxlmd->dev;
+	struct device *iter;
+
+	for (iter = dev; iter; iter = grandparent(iter)) {
+		struct device *dport_dev = grandparent(iter);
+		struct device *uport_dev = dport_dev->parent;
+
+		if (is_cxl_hierarchy_head(uport_dev->parent)) {
+			*hb_uport_dev = uport_dev;
+			*hb_dport_dev = dport_dev;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+static int cxl_hostbridge_port_setup(struct cxl_memdev *cxlmd)
+{
+	struct device *hb_uport_dev, *hb_dport_dev;
+	struct cxl_dport *dport = NULL;
+	int rc;
+
+	rc = get_hostbridge_port_devices(cxlmd, &hb_uport_dev, &hb_dport_dev);
+	if (rc)
+		return -ENODEV;
+
+	struct cxl_root *cxl_root __free(put_cxl_root) =
+		cxl_hb_uport_dev_to_root(hb_uport_dev);
+	if (!cxl_root)
+		return -ENODEV;
+
+	guard(device)(&cxl_root->port.dev);
+	struct cxl_port *port __free(put_cxl_port) =
+		find_cxl_port(hb_dport_dev, &dport);
+	if (!port)
+		port = find_cxl_port_by_uport(hb_uport_dev);
+
+	/* Port already established, add the associated dport if needed. */
+	if (port) {
+		if (dport)
+			return 0;
+
+		guard(device)(&port->dev);
+		dport = devm_cxl_port_add_dport(port, hb_dport_dev);
+		if (IS_ERR(dport) && PTR_ERR(dport) != -EEXIST) {
+			dev_dbg(&cxlmd->dev,
+				"failed to add dport %s to port %s: %ld\n",
+				dev_name(hb_dport_dev), dev_name(&port->dev),
+				PTR_ERR(dport));
+			return PTR_ERR(dport);
+		}
+		return 0;
+	}
+
+	/* No port found, setup a port via the root port ops */
+	if (!cxl_root->ops || !cxl_root->ops->setup_hostbridge_uport)
+		return -EOPNOTSUPP;
+
+	rc = cxl_root->ops->setup_hostbridge_uport(cxl_root, hb_uport_dev);
+	if (rc)
+		return rc;
+
+	/* Add the dport that goes with the newly created port */
+	dport = devm_cxl_add_dport_by_uport(hb_uport_dev, hb_dport_dev);
+	if (IS_ERR(dport) && PTR_ERR(dport) != -EEXIST) {
+		dev_dbg(&cxlmd->dev,
+			"failed to add dport %s to port %s: %ld\n",
+			dev_name(hb_dport_dev), dev_name(&cxl_root->port.dev),
+			PTR_ERR(dport));
+		return PTR_ERR(dport);
+	}
+
+	return 0;
+}
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 {
 	struct device *dev = &cxlmd->dev;
@@ -1819,6 +1899,10 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 	if (cxlmd->cxlds->rcd)
 		return 0;
 
+	rc = cxl_hostbridge_port_setup(cxlmd);
+	if (rc)
+		return rc;
+
 	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_detach_ep, cxlmd);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f88a7ab8d94b..f9972fb4990f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -642,6 +642,8 @@ struct cxl_root_ops {
 	int (*qos_class)(struct cxl_root *cxl_root,
 			 struct access_coordinate *coord, int entries,
 			 int *qos_class);
+	int (*setup_hostbridge_uport)(struct cxl_root *cxl_root,
+				      struct device *bridge_dev);
 };
 
 static inline struct cxl_dport *
-- 
2.50.0

