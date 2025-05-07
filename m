Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F82E18C31
	for <linux-cxl@vger.kernel.org>; Wed,  7 May 2025 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746578607; cv=none; b=ushsG6DKqhwrxD7LSIhZK0FkpiiwOmniZ4FodvdRI/Z+DQyPiOgkVSfhszVvsEDmm+wphZbQfnowzhBOaAfP1wa8jQ0CxImnFbyc+40rLG/WU5ElSSo2gAzj3V+lD/vSFUgBTOkVhcACQ6MYd44WSv5ntZmjZt9K60qrzab1OBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746578607; c=relaxed/simple;
	bh=6yU1dcut8N+BpTjz3t8qBztvbpWar/nGnKHAU+eyggM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G87Nm7PXQTPj9ITBsnjQT7DhSNSdTfOWge2JJetQ25XtPrzSOKIOfx0GULJ/mJ8ULVY7YNvvXFgwiqKFcI5FDccouJ8Ik6lvQbWY7lgcFfVZovGqUv9eL7/5qRsHOywGcYzgxLYPxzcH3T0nIPrjUFeP1CxwRNHkAvbwwhYr2Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C25C4CEE4;
	Wed,  7 May 2025 00:43:26 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com
Subject: [PATCH v2 10/10] cxl: Move enumeration of hostbridge ports to the memdev probe path
Date: Tue,  6 May 2025 17:43:10 -0700
Message-ID: <20250507004310.3536991-11-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507004310.3536991-1-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
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
DVSEC ID 7 blocks which will trigger the error message.

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
 drivers/cxl/acpi.c      | 136 ++++++++++++++++++++++++----------------
 drivers/cxl/core/port.c |  58 +++++++++++++++++
 drivers/cxl/cxl.h       |   2 +
 3 files changed, 141 insertions(+), 55 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 6f8630e50800..1db4d308b4b7 100644
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
+ * A host bridge is a dport to a CFMWS decode and it is a uport to the
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
+	return devm_cxl_register_udev_root_port(host, bridge,
+						to_cxl_root(root_port));
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
index a5a673d789f3..bbecbb04b6be 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1808,6 +1808,60 @@ static int cxl_switch_port_dport_setup(struct cxl_port *port,
 	return 0;
 }
 
+static int get_hostbridge_port_devices(struct cxl_memdev *cxlmd,
+				       struct device **uport_dev,
+				       struct device **dport_dev)
+{
+	struct device *dev = &cxlmd->dev;
+	struct device *iter;
+
+	for (iter = dev; iter; iter = grandparent(iter)) {
+		struct device *ddev = grandparent(iter);
+		struct device *udev;
+
+		udev = ddev->parent;
+		if (is_cxl_hierarchy_head(udev->parent)) {
+			*uport_dev = udev;
+			*dport_dev = ddev;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+static int cxl_hostbridge_port_setup(struct cxl_memdev *cxlmd)
+{
+	struct device *uport_dev, *dport_dev;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+	int rc;
+
+	rc = get_hostbridge_port_devices(cxlmd, &uport_dev, &dport_dev);
+	if (rc)
+		return -ENODEV;
+
+	struct cxl_root *cxl_root __free(put_cxl_root) = cxl_udev_to_root(uport_dev);
+	if (!cxl_root)
+		return -ENODEV;
+
+	guard(device)(&cxl_root->port.dev);
+	port = find_cxl_port(dport_dev, &dport);
+	if (port) {
+		put_device(&port->dev);
+		return 0;
+	}
+
+	if (!cxl_root->ops || !cxl_root->ops->setup_hostbridge_uport)
+		return -EOPNOTSUPP;
+
+	rc = cxl_root->ops->setup_hostbridge_uport(cxl_root, uport_dev);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 {
 	struct device *dev = &cxlmd->dev;
@@ -1821,6 +1875,10 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
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
index e0cba91803cc..e4017328b05f 100644
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

