Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B8C1A238F
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852494; cv=none; b=ZILPrau8RSUHl3adifl5NtrZmNWb0z5b5iCtcJbMssaILgyLQw1+C1A6JzPN0574i+Z0SAPjbFh8tlrb0hp22LQ/+lNQol8z2G0C1+Lji4qIiUt4ZKdnGRBae1WjU8/s56W5ZhJUrif6pBNx90h6SK6liCBaOyn5jLaOi0BaIC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852494; c=relaxed/simple;
	bh=vdOdESD5gOWVvoXQ5KTqrYxhtDf2BxwWgLHMBxpxD7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjVjsbu4B2PovbPANHLR/qD5B1EryIoMkuabf3P+2IMEqEL2Pzn1EhUzlJ0ntJM/KeiS9u+deTEUskNo7gLguHGeE66yz1W/Pcle4gOuo6clAjSRhupiDBxH9DtIjYhVvLHk1kmXwJpYjq4qLA+Aafaw5Q0gtSJNWYAxJzMlh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139C2C4CEE4;
	Wed, 21 May 2025 18:34:54 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v3 5/9] cxl: Defer hardware dport->port_id assignment and registers probing
Date: Wed, 21 May 2025 11:34:39 -0700
Message-ID: <20250521183443.3828320-6-dave.jiang@intel.com>
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

Current implementation only enumerates the dports during the port probe.
Without an endpoint connected, the dport may not be active during port
probe. This scheme may prevent a valid hardware dport id to be retrieved
and MMIO registers to be read when an endpoint is hot-plugged. Move the hw
dport id assignment and the register probing to behind memdev probe so the
endpoint is guaranteed to be connected.

In the original enumeration behavior, there are 3 phases (or 2 if no CXL
switches) for port creation. cxl_acpi() creates a root port from the
ACPI0017.N device. Through that it enumerate downstream ports composed
of ACPI0016.N devices through add_host_bridge_dport(). Once done, it
use add_host_bridge_uport() to create the ports that enumerates the PCI
root ports as the dports of these ports. Every time a port is created,
the port driver is attached and drv->probe() is called and
devm_cxl_port_enumerate_dports() is envoked to enumerate and probe
the dports.

The second phase is if there are any CXL switches. When the pci endpoint
device driver (cxl_pci) calls probe, it will add a mem device and triggers
the cxl_mem->probe(). cxl_mem->probe() calls devm_cxl_enumerate_ports()
and attempts to discovery and create all the ports represent CXL switches.
During this phase, a port is created per switch and the attached dports
are also enumerated and probed.

The last phase is creating endpoint port which happens for all endpoint
devices.

In this commit, the port create and its dport probing in cxl_acpi is not
changed. That will be handled in a different patch later on. The behavior
change is only for CXL switch ports. Only the dport that is part of the
path for an endpoint device to the RP will be probed and marked as active
by having a valid dport->port_num. This happens naturally by the code
walking up the device hierarchy and identifying the upstream device and
the downstream device.

Locking of port device wraps the cxl_switch_port_dport_setup() to
protect modifications against the port and its dports while multiple
endpoints can be probing at the same time and the same port is being
modified concurrently.

The detection of duplicate dport for add_dport() is removed. The port_id
is not read from the hw at this point any longer. The port->id will always
be unique since it's retrieved from an ida. The dup detection thus become
irrelevant. With this behavior, only a dport that points to a valid
endpoint path would be probed. Of course the decoder enumeration and
SSLBIS parsing is also delayed until the dport is probed since it needs to
know the port_num and also be able to read the registers.

The decoders must also be updated since previously it's all done when all
the dports are setup and now every time a dport is setup per endpoint, the
switch target listing need to be updated with new dport. A
guard(rwsem_write) is used to update decoder targets. This is similar to
when decoder_populate_target() is called and the decoder programming
must be protected.

The success return value of devm_cxl_port_enumerate_dports() has been
changed to always 0 since no caller is using the return value of dports
enumerated for anything in the current code now.

Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- port_probe_dport() return dport() directly (Ming)
- cxl_switch_port_dport_setup() return rc directly. (Ming)
- Add more explanation in the commit log. (Gregory)
- Return 0 on success for devm_cxl_port_enumerate_dports. (Jonathan)
- comment on return !dev_is_pci() for cxl_dport_setup(). (Jonathan)
- Move retrieving port_num after reading lnkcap. (Jonathan)
- Optimize port_probe_dport code flow. (Jonathan)
- Optimize return of decoder setup. (Jonathan)
---
 drivers/cxl/core/core.h |   4 ++
 drivers/cxl/core/pci.c  |  66 +++++++++++++-----
 drivers/cxl/core/port.c | 146 +++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxl.h       |   4 ++
 drivers/cxl/port.c      |  26 +------
 5 files changed, 189 insertions(+), 57 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 17b692eb3257..8b1d9a8ab852 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -134,4 +134,8 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u16 *return_code);
 #endif
 
+int cxl_dport_setup(struct cxl_dport *dport);
+int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
+			 resource_size_t component_reg_phys);
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3b84b43ab194..dd204b6f7032 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -24,6 +24,53 @@ static unsigned short media_ready_timeout = 60;
 module_param(media_ready_timeout, ushort, 0644);
 MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
 
+int cxl_dport_setup(struct cxl_dport *dport)
+{
+	struct device *dport_dev = dport->dport_dev;
+	struct cxl_port *port = dport->port;
+	struct cxl_register_map map;
+	struct pci_dev *pdev;
+	u32 lnkcap, port_num;
+	int rc;
+
+	/* Skipping for cxl_test since it's platform device */
+	if (!dev_is_pci(dport_dev))
+		return 0;
+
+	/*
+	 * dport->port_id is valid means that dport has been probed and is
+	 * setup.
+	 */
+	if (dport->port_num != CXL_DPORT_NUM_INVALID)
+		return 0;
+
+	pdev = to_pci_dev(dport_dev);
+	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
+				  &lnkcap))
+		return -ENODEV;
+	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
+
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc) {
+		dev_dbg(&port->dev, "failed to find component registers\n");
+		return -ENODEV;
+	}
+
+	rc = cxl_dport_setup_regs(&port->dev, dport, map.resource);
+	if (rc)
+		return rc;
+
+	if (map.resource != CXL_RESOURCE_NONE) {
+		dev_dbg(dport->dport_dev,
+			"Component Register found for dport: %pa\n",
+			&map.resource);
+	}
+
+	dport->port_num = port_num;
+
+	return 0;
+}
+
 struct cxl_walk_context {
 	struct pci_bus *bus;
 	struct cxl_port *port;
@@ -37,10 +84,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 	struct cxl_walk_context *ctx = data;
 	struct cxl_port *port = ctx->port;
 	int type = pci_pcie_type(pdev);
-	struct cxl_register_map map;
 	struct cxl_dport *dport;
-	u32 lnkcap, port_num;
-	int rc;
 
 	if (pdev->bus != ctx->bus)
 		return 0;
@@ -48,22 +92,13 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 		return 0;
 	if (type != ctx->type)
 		return 0;
-	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
-				  &lnkcap))
-		return 0;
 
-	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
-	if (rc)
-		dev_dbg(&port->dev, "failed to find component registers\n");
-
-	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	dport = devm_cxl_add_dport(port, &pdev->dev, map.resource);
+	dport = devm_cxl_add_dport(port, &pdev->dev, CXL_RESOURCE_NONE);
 	if (IS_ERR(dport)) {
 		ctx->error = PTR_ERR(dport);
 		return PTR_ERR(dport);
 	}
 
-	dport->port_num = port_num;
 	ctx->count++;
 
 	return 0;
@@ -73,8 +108,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
  * devm_cxl_port_enumerate_dports - enumerate downstream ports of the upstream port
  * @port: cxl_port whose ->uport_dev is the upstream of dports to be enumerated
  *
- * Returns a positive number of dports enumerated or a negative error
- * code.
+ * Returns 0 on success or a negative error code.
  */
 int devm_cxl_port_enumerate_dports(struct cxl_port *port)
 {
@@ -101,7 +135,7 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port)
 		return -ENODEV;
 	if (ctx.error)
 		return ctx.error;
-	return ctx.count;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, "CXL");
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d62008583da2..2b3ec8436d3d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -791,8 +791,8 @@ static int cxl_port_setup_regs(struct cxl_port *port,
 				   component_reg_phys);
 }
 
-static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
-				resource_size_t component_reg_phys)
+int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
+			 resource_size_t component_reg_phys)
 {
 	int rc;
 
@@ -1013,7 +1013,7 @@ int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_register_pci_bus, "CXL");
 
-static bool dev_is_cxl_root_child(struct device *dev)
+bool dev_is_cxl_root_child(struct device *dev)
 {
 	struct cxl_port *port, *parent;
 
@@ -1030,6 +1030,7 @@ static bool dev_is_cxl_root_child(struct device *dev)
 
 	return false;
 }
+EXPORT_SYMBOL_NS_GPL(dev_is_cxl_root_child, "CXL");
 
 struct cxl_root *find_cxl_root(struct cxl_port *port)
 {
@@ -1068,19 +1069,9 @@ static struct cxl_dport *find_dport_by_num(struct cxl_port *port, int port_num)
 
 static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
 {
-	struct cxl_dport *dup;
 	int rc;
 
 	device_lock_assert(&port->dev);
-	dup = find_dport_by_num(port, dport->port_num);
-	if (dup) {
-		dev_err(&port->dev,
-			"unable to add dport%d-%s non-unique port num (%s)\n",
-			dport->port_num, dev_name(dport->dport_dev),
-			dev_name(dup->dport_dev));
-		return -EBUSY;
-	}
-
 	rc = xa_insert(&port->dports, (unsigned long)dport->dport_dev, dport,
 		       GFP_KERNEL);
 	if (rc)
@@ -1652,6 +1643,112 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	return rc;
 }
 
+static struct cxl_dport *port_probe_dport(struct cxl_port *port,
+					  struct device *dport_dev)
+{
+	struct cxl_dport *dport;
+	unsigned long index;
+	int rc;
+
+	device_lock_assert(&port->dev);
+	xa_for_each(&port->dports, index, dport) {
+		if (dport->dport_dev != dport_dev)
+			continue;
+
+		rc = cxl_dport_setup(dport);
+		if (rc)
+			return ERR_PTR(rc);
+
+		return dport;
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
+static int update_switch_decoder(struct device *dev, void *data)
+{
+	struct cxl_dport *dport = data;
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_decoder *cxld;
+	int i;
+
+	if (!is_switch_decoder(dev))
+		return 0;
+
+	cxlsd = to_cxl_switch_decoder(dev);
+	cxld = &cxlsd->cxld;
+	guard(rwsem_write)(&cxl_region_rwsem);
+	for (i = 0; i < cxld->interleave_ways; i++) {
+		if (cxlsd->target_map[i] == dport->port_num) {
+			cxlsd->target[i] = dport;
+			return 0;
+		}
+	}
+
+	dev_dbg(dev, "Updating decoder target_map with %s and none found\n",
+		dev_name(dport->dport_dev));
+
+	return 0;
+}
+
+static int update_decoders_with_dport(struct cxl_port *port, struct cxl_dport *dport)
+{
+	device_lock_assert(&port->dev);
+	return device_for_each_child(&port->dev, dport, update_switch_decoder);
+}
+
+int devm_cxl_port_setup_decoders(struct cxl_port *port)
+{
+	struct cxl_dport *dport;
+	struct cxl_hdm *cxlhdm;
+	unsigned long index;
+	int dports = 0;
+
+	cxlhdm = devm_cxl_setup_hdm(port, NULL);
+	if (!IS_ERR(cxlhdm))
+		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
+
+	if (PTR_ERR(cxlhdm) != -ENODEV) {
+		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
+		return PTR_ERR(cxlhdm);
+	}
+
+	xa_for_each(&port->dports, index, dport)
+		dports++;
+
+	if (dports == 1) {
+		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
+		return devm_cxl_add_passthrough_decoder(port);
+	}
+
+	dev_err(&port->dev, "HDM decoder capability not found\n");
+	return -ENXIO;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_port_setup_decoders, "CXL");
+
+static int cxl_switch_port_dport_setup(struct cxl_port *port,
+				       struct device *dport_dev)
+{
+	struct cxl_dport *dport;
+
+	device_lock_assert(&port->dev);
+
+	if (!port->dev.driver)
+		return -ENODEV;
+
+	dport = port_probe_dport(port, dport_dev);
+	if (IS_ERR(dport))
+		return PTR_ERR(dport);
+
+	cxl_switch_parse_cdat(port);
+
+	/* Make sure that no decoders have been allocated before proceeding. */
+	if (ida_is_empty(&port->decoder_ida))
+		return devm_cxl_port_setup_decoders(port);
+
+	return update_decoders_with_dport(port, dport);
+}
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 {
 	struct device *dev = &cxlmd->dev;
@@ -1700,6 +1797,19 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 				"found already registered port %s:%s\n",
 				dev_name(&port->dev),
 				dev_name(port->uport_dev));
+
+			/*
+			 * Attempt to do single pass dport setup by checking here
+			 * instead of doing it during port creation. Otherwise
+			 * it still needs to check here for dports that are
+			 * being probed with a port already created.
+			 */
+			scoped_guard(device, &port->dev) {
+				rc = cxl_switch_port_dport_setup(port, dport_dev);
+				if (rc)
+					return rc;
+			}
+
 			rc = cxl_add_ep(dport, &cxlmd->dev);
 
 			/*
@@ -1765,10 +1875,14 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 
 	guard(rwsem_write)(&cxl_region_rwsem);
 	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
-		struct cxl_dport *dport = find_dport_by_num(port, target_map[i]);
+		struct cxl_dport *dport;
 
-		if (!dport)
-			return -ENXIO;
+		cxlsd->target_map[i] = target_map[i];
+		dport = find_dport_by_num(port, target_map[i]);
+		if (!dport) {
+			/* dport may be activated later */
+			continue;
+		}
 		cxlsd->target[i] = dport;
 	}
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4ba3bbe9600b..6b85d5f23be0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -404,6 +404,7 @@ struct cxl_endpoint_decoder {
  * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
  * @cxld: base cxl_decoder object
  * @nr_targets: number of elements in @target
+ * @target_map: array of expected dport port_id mirror the target
  * @target: active ordered target list in current decoder configuration
  *
  * The 'switch' decoder type represents the decoder instances of cxl_port's that
@@ -415,6 +416,7 @@ struct cxl_endpoint_decoder {
 struct cxl_switch_decoder {
 	struct cxl_decoder cxld;
 	int nr_targets;
+	int target_map[CXL_DECODER_MAX_INTERLEAVE];
 	struct cxl_dport *target[];
 };
 
@@ -906,6 +908,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c2);
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
+int devm_cxl_port_setup_decoders(struct cxl_port *port);
+bool dev_is_cxl_root_child(struct device *dev);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index a35fc5552845..12394f280288 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -59,34 +59,10 @@ static int discover_region(struct device *dev, void *root)
 
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
-	struct cxl_hdm *cxlhdm;
-	int rc;
-
 	/* Cache the data early to ensure is_visible() works */
 	read_cdat_data(port);
 
-	rc = devm_cxl_port_enumerate_dports(port);
-	if (rc < 0)
-		return rc;
-
-	cxl_switch_parse_cdat(port);
-
-	cxlhdm = devm_cxl_setup_hdm(port, NULL);
-	if (!IS_ERR(cxlhdm))
-		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
-
-	if (PTR_ERR(cxlhdm) != -ENODEV) {
-		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
-		return PTR_ERR(cxlhdm);
-	}
-
-	if (rc == 1) {
-		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
-		return devm_cxl_add_passthrough_decoder(port);
-	}
-
-	dev_err(&port->dev, "HDM decoder capability not found\n");
-	return -ENXIO;
+	return devm_cxl_port_enumerate_dports(port);
 }
 
 static int cxl_endpoint_port_probe(struct cxl_port *port)
-- 
2.49.0

