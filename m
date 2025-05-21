Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ACE1A238F
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852500; cv=none; b=sAykZSG9ub5L7EwMo4R8oL4X6Rlw0g0MbypUm7TSl/garUnfLtnrR4jBpskOvp6uKdU+WePcCn3qASP5nOiID4H4DtTV+8yjvwWh5LKoj9PP2YM4vWXTnBWADr0H9dWi+ILgou97msRnjohtzKUTIoe/R5CFMeZbAoMCc7KgmFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852500; c=relaxed/simple;
	bh=MXjdq3S2KwZ2tp5wJQyDGrnHvGm8jhL//8VXenp3AJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4JsVyGfFA/cpqZ147jKiX4xTHjaPyD94mT7+5i3u1NcrVrtVlHpDQsqGOCWiilje1pNgS2FDsoJ/uQv1whLsVFnbbpC5/JwJpIgoRUuSEHnt/hx/a3T9y42sOd6bHSSvJigc+lQk8itChaHW94IRbcPr5Yg7Ich+v7seIOPl3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB36CC4CEE4;
	Wed, 21 May 2025 18:34:59 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v3 9/9] cxl: Move enumeration of hostbridge ports to the memdev probe path
Date: Wed, 21 May 2025 11:34:43 -0700
Message-ID: <20250521183443.3828320-10-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521183443.3828320-1-dave.jiang@intel.com>
References: <20250521183443.3828320-1-dave.jiang@intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Add comment in commit log WRT missing DVSEC is spec compliant. (Jonathan)
- Fix spelling mistake in cxl_acpi comment (Jonathan)
- Fix coding style for get_hostbridge_port_devices(). (Jonathan)
- Directly return ->setup_hostbridge_uport(). (Jonathan)
---
 drivers/cxl/acpi.c      | 136 ++++++++++++++++++++++++----------------
 drivers/cxl/core/port.c |  55 ++++++++++++++++
 drivers/cxl/cxl.h       |   2 +
 3 files changed, 138 insertions(+), 55 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 6f8630e50800..f193b62b744b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -298,8 +298,79 @@ static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
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
@@ -460,16 +531,6 @@ __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
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
@@ -588,7 +649,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	/*
 	 * In RCH mode, bind the component regs base to the dport. In
 	 * VH mode it will be bound to the CXL host bridge's port
-	 * object later in add_host_bridge_uport().
+	 * object later in cxl_acpi_setup_hostbridge_uport().
 	 */
 	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
 		dev_dbg(match, "RCRB found for UID %lld: %pa\n", ctx.uid,
@@ -611,22 +672,14 @@ static int add_host_bridge_dport(struct device *match, void *arg)
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
@@ -639,37 +692,12 @@ static int add_host_bridge_uport(struct device *match, void *arg)
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
@@ -843,6 +871,7 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 		return PTR_ERR(cxl_root);
 	root_port = &cxl_root->port;
 
+	 /* Root level scanned with host-bridge as dports */
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_dport);
 	if (rc < 0)
@@ -871,12 +900,9 @@ static int cxl_acpi_probe(struct platform_device *pdev)
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
index 7650254fdcb4..05f5c235934e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1802,6 +1802,57 @@ static int cxl_switch_port_dport_setup(struct cxl_port *port,
 	return update_decoders_with_dport(port, dport);
 }
 
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
+	struct cxl_dport *dport;
+	struct cxl_port *port;
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
+	port = find_cxl_port(hb_dport_dev, &dport);
+	if (port) {
+		/* Nothing to do if a port has been created already */
+		put_device(&port->dev);
+		return 0;
+	}
+
+	if (!cxl_root->ops || !cxl_root->ops->setup_hostbridge_uport)
+		return -EOPNOTSUPP;
+
+	return cxl_root->ops->setup_hostbridge_uport(cxl_root, hb_uport_dev);
+}
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 {
 	struct device *dev = &cxlmd->dev;
@@ -1815,6 +1866,10 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
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
index 443182146076..b813b54f13c9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -643,6 +643,8 @@ struct cxl_root_ops {
 	int (*qos_class)(struct cxl_root *cxl_root,
 			 struct access_coordinate *coord, int entries,
 			 int *qos_class);
+	int (*setup_hostbridge_uport)(struct cxl_root *cxl_root,
+				      struct device *bridge_dev);
 };
 
 static inline struct cxl_dport *
-- 
2.49.0

