Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C5241671
	for <linux-cxl@vger.kernel.org>; Wed,  9 Jul 2025 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093388; cv=none; b=Xqo+Y1H2PCi8ntxUEK1mCVZJz8AV4XUeyut+KyotfOLQvwWD27J7ffY0nCV4OioD1LQMi737AdRVupLlr2gmyCW/adrJekXlyDidv7/p5SYoJhpnICza0Ojj3ojJ9obdCRDId10WwxpiebPntt7mqI+6drMwa0Dc2eJuumnzgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093388; c=relaxed/simple;
	bh=wzx6djGb29go9PBWUjhfPQpkduubQE8ehgCJqU2aPlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2yHfLsLuwhBy1pI0MoTA+v70S9wEqJxq/5SY9Ksdi1LGUuDr4/9sxfxOvKudm0b8qGTPFzpoLJR1WtG+q/jCmIZJ8C8WFOw+ITluWbNsGgRUTHbNH5RGogTAwMriVBMPvBzuFMqeklKBI5FzwA0IHAAYxPDhx/PhXFooYKq+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD08C4CEEF;
	Wed,  9 Jul 2025 20:36:28 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v6 04/10] cxl: Defer dport allocation for switch ports
Date: Wed,  9 Jul 2025 13:36:13 -0700
Message-ID: <20250709203619.2607133-5-dave.jiang@intel.com>
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

The current implementation enumerates the dports during the cxl_port
driver probe. Without an endpoint connected, the dport may not be
active during port probe. This scheme may prevent a valid hardware
dport id to be retrieved and MMIO registers to be read when an endpoint
is hot-plugged. Move the dport allocation and setup to behind memdev
probe so the endpoint is guaranteed to be connected.

In the original enumeration behavior, there are 3 phases (or 2 if no CXL
switches) for port creation. cxl_acpi() creates a Root Port (RP) from the
ACPI0017.N device. Through that it enumerate downstream ports composed
of ACPI0016.N devices through add_host_bridge_dport(). Once done, it
use add_host_bridge_uport() to create the ports that enumerates the PCI
RPs as the dports of these ports. Every time a port is created, the port
driver is attached and drv->probe() is called and
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
path for an endpoint device to the RP will be probed. This happens
naturally by the code walking up the device hierarchy and identifying the
upstream device and the downstream device.

There are two points where the interception of dport creation happens
during the devm_cxl_enumerate_ports() path. The first location is right
before the function calls add_port_attach_ep() where it does the dport
allocation for the RP. Once the dport is allocated, the iteration path
is reset to the beginning to try again. The second location happens
in add_port_attach_ep() after the location where either the port is
discovered or allocated new if it does not exist.

Locking of port device during __cxl_port_add_dport() protects modifications
against the port and its dports while multiple endpoints can be probing at
the same time and the same port is being modified concurrently.

While the decoders are allocated during the port driver probe,
The decoders must also be updated since previously it's all done when all
the dports are setup and now every time a dport is setup per endpoint, the
switch target listing need to be updated with new dport. A
guard(rwsem_write) is used to update decoder targets. This is similar to
when decoder_populate_target() is called and the decoder programming
must be protected.

Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- Return -EEXIST when dport is already established. (Jonathan)
- Check !pport instead of !port. (Ming)
- branch devm_cxl_add_dport_by_uport() vs add_port_attach_ep(). (Ming)
---
 drivers/cxl/core/core.h |   2 +
 drivers/cxl/core/pci.c  |  88 ++++++++++++++++++
 drivers/cxl/core/port.c | 193 ++++++++++++++++++++++++++++++++++++----
 drivers/cxl/cxl.h       |   5 ++
 drivers/cxl/port.c      |   8 +-
 5 files changed, 275 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 29b61828a847..8cfead6f3b08 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -122,6 +122,8 @@ void cxl_ras_exit(void);
 int cxl_gpf_port_setup(struct cxl_dport *dport);
 int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
 					    int nid, resource_size_t *size);
+struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
+					    struct device *dport_dev);
 
 #ifdef CONFIG_CXL_FEATURES
 struct cxl_feat_entry *
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index b50551601c2e..336451b9144a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -24,6 +24,44 @@ static unsigned short media_ready_timeout = 60;
 module_param(media_ready_timeout, ushort, 0644);
 MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
 
+/**
+ * devm_cxl_add_dport_by_dev - allocate a dport by dport device
+ * @port: cxl_port that hosts the dport
+ * @dport_dev: 'struct device' of the dport
+ *
+ * Returns the allocate dport on success or ERR_PTR() of -errno on error
+ */
+struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
+					    struct device *dport_dev)
+{
+	struct cxl_register_map map;
+	struct pci_dev *pdev;
+	u32 lnkcap, port_num;
+	int type;
+	int rc;
+
+	if (!dev_is_pci(dport_dev))
+		return ERR_PTR(-EINVAL);
+
+	device_lock_assert(&port->dev);
+
+	pdev = to_pci_dev(dport_dev);
+	type = pci_pcie_type(pdev);
+	if (type != PCI_EXP_TYPE_DOWNSTREAM && type != PCI_EXP_TYPE_ROOT_PORT)
+		return ERR_PTR(-EINVAL);
+
+	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
+				  &lnkcap))
+		return ERR_PTR(-ENXIO);
+
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		dev_dbg(&port->dev, "failed to find component registers\n");
+
+	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
+	return devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
+}
+
 struct cxl_walk_context {
 	struct pci_bus *bus;
 	struct cxl_port *port;
@@ -1169,3 +1207,53 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
 
 	return 0;
 }
+
+static int match_dport(struct pci_dev *pdev, void *data)
+{
+	struct cxl_walk_context *ctx = data;
+	int type = pci_pcie_type(pdev);
+
+	if (pdev->bus != ctx->bus)
+		return 0;
+	if (!pci_is_pcie(pdev))
+		return 0;
+	if (type != ctx->type)
+		return 0;
+
+	ctx->count++;
+	return 0;
+}
+
+int cxl_port_update_total_dports(struct cxl_port *port)
+{
+	struct pci_bus *bus = cxl_port_to_pci_bus(port);
+	struct cxl_walk_context ctx;
+	int type;
+
+	if (!bus) {
+		dev_err(&port->dev, "No PCI bus found for port %s\n",
+			dev_name(&port->dev));
+		return -ENXIO;
+	}
+
+	if (pci_is_root_bus(bus))
+		type = PCI_EXP_TYPE_ROOT_PORT;
+	else
+		type = PCI_EXP_TYPE_DOWNSTREAM;
+
+	ctx = (struct cxl_walk_context) {
+		.bus = bus,
+		.type = type,
+	};
+	pci_walk_bus(bus, match_dport, &ctx);
+
+	port->total_dports = ctx.count;
+	if (port->total_dports == 0) {
+		dev_warn(&port->dev, "No dports found for port %s on bus %s\n",
+			 dev_name(&port->dev), bus->name);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_update_total_dports, "CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 9691da831224..ae3e66b914eb 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1551,6 +1551,116 @@ static resource_size_t find_component_registers(struct device *dev)
 	return map.resource;
 }
 
+static int match_port_by_uport(struct device *dev, const void *data)
+{
+	const struct device *uport_dev = data;
+	struct cxl_port *port;
+
+	if (!is_cxl_port(dev))
+		return 0;
+
+	port = to_cxl_port(dev);
+	return uport_dev == port->uport_dev;
+}
+
+/*
+ * Function takes a device reference on the port device. Caller should do a
+ * put_device() when done.
+ */
+static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&cxl_bus_type, NULL, uport_dev, match_port_by_uport);
+	if (dev)
+		return to_cxl_port(dev);
+	return NULL;
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
+		if (cxlsd->target_map[i] == dport->port_id) {
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
+static int cxl_port_setup_with_dport(struct cxl_port *port,
+				     struct cxl_dport *dport)
+{
+	device_lock_assert(&port->dev);
+
+	cxl_switch_parse_cdat(port);
+
+	return update_decoders_with_dport(port, dport);
+}
+
+static struct cxl_dport *devm_cxl_port_add_dport(struct cxl_port *port,
+						 struct device *dport_dev)
+{
+	struct cxl_dport *dport;
+	int rc;
+
+	device_lock_assert(&port->dev);
+
+	/* Port driver not attached yet, wait for cxl_acpi reprobe */
+	if (!port->dev.driver)
+		return ERR_PTR(-ENODEV);
+
+	dport = cxl_find_dport_by_dev(port, dport_dev);
+	if (dport)
+		return ERR_PTR(-EEXIST);
+
+	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
+	if (IS_ERR(dport))
+		return dport;
+
+	rc = cxl_port_setup_with_dport(port, dport);
+	if (rc) {
+		reap_dport(port, dport);
+		return ERR_PTR(rc);
+	}
+
+	return dport;
+}
+
+static struct cxl_dport *devm_cxl_add_dport_by_uport(struct device *uport_dev,
+						     struct device *dport_dev)
+{
+	struct cxl_port *port __free(put_cxl_port) =
+		find_cxl_port_by_uport(uport_dev);
+
+	if (!port)
+		return ERR_PTR(-ENODEV);
+
+	guard(device)(&port->dev);
+	return devm_cxl_port_add_dport(port, dport_dev);
+}
+
 static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			      struct device *uport_dev,
 			      struct device *dport_dev)
@@ -1584,6 +1694,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	 */
 	struct cxl_port *port __free(put_cxl_port) = NULL;
 	scoped_guard(device, &parent_port->dev) {
+		struct cxl_dport *new_dport;
+
 		if (!parent_port->dev.driver) {
 			dev_warn(&cxlmd->dev,
 				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
@@ -1592,6 +1704,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		}
 
 		port = find_cxl_port_at(parent_port, dport_dev, &dport);
+		if (!port)
+			port = find_cxl_port_by_uport(uport_dev);
 		if (!port) {
 			component_reg_phys = find_component_registers(uport_dev);
 			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
@@ -1599,11 +1713,27 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			if (IS_ERR(port))
 				return PTR_ERR(port);
 
-			/* retry find to pick up the new dport information */
-			port = find_cxl_port_at(parent_port, dport_dev, &dport);
-			if (!port)
-				return -ENXIO;
+			/*
+			 * The port holds a device reference via find_cxl_port_at()
+			 * if the port is valid. But if the port is newly created
+			 * via devm_cxl_add_port(), no reference is held. Therefore
+			 * the driver needs to get a device reference here.
+			 */
+			get_device(&port->dev);
 		}
+
+		guard(device)(&port->dev);
+		new_dport = devm_cxl_port_add_dport(port, dport_dev);
+		if (IS_ERR(new_dport)) {
+			if (PTR_ERR(new_dport) != -EEXIST)
+				return PTR_ERR(new_dport);
+
+			new_dport = cxl_find_dport_by_dev(port, dport_dev);
+			if (!new_dport)
+				return -ENODEV;
+		}
+
+		dport = new_dport;
 	}
 
 	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
@@ -1620,11 +1750,14 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	return rc;
 }
 
+#define CXL_ITER_LEVEL_SWITCH	1
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 {
 	struct device *dev = &cxlmd->dev;
+	struct device *dgparent;
 	struct device *iter;
-	int rc;
+	int rc, i;
 
 	/*
 	 * Skip intermediate port enumeration in the RCH case, there
@@ -1643,7 +1776,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 	 * attempt fails.
 	 */
 retry:
-	for (iter = dev; iter; iter = grandparent(iter)) {
+	for (i = 0, iter = dev; iter; i++, iter = grandparent(iter)) {
 		struct device *dport_dev = grandparent(iter);
 		struct device *uport_dev;
 		struct cxl_dport *dport;
@@ -1686,16 +1819,41 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			if (!dev_is_cxl_root_child(&port->dev))
 				continue;
 
+			/*
+			 * This is a corner case where the rootport is setup but
+			 * the switch dport is not. It needs to go back to the
+			 * beginning to setup the switch port.
+			 */
+			if (i >= CXL_ITER_LEVEL_SWITCH) {
+				struct cxl_port *pport __free(put_cxl_port) =
+					cxl_mem_find_port(cxlmd, &dport);
+				if (!pport)
+					goto retry;
+			}
+
 			return 0;
 		}
 
-		rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
-		/* port missing, try to add parent */
-		if (rc == -EAGAIN)
-			continue;
-		/* failed to add ep or port */
-		if (rc)
-			return rc;
+		dgparent = grandparent(dport_dev);
+		/* Only go down this path if we are at the root port */
+		if (is_cxl_hierarchy_head(dgparent)) {
+			dport = devm_cxl_add_dport_by_uport(uport_dev,
+							    dport_dev);
+			/* Added a dport, restart enumeration */
+			if (!IS_ERR(dport) || PTR_ERR(dport) == -EEXIST)
+				goto retry;
+			if (IS_ERR(dport))
+				return PTR_ERR(dport);
+		} else {
+			rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
+			/* port missing, try to add parent */
+			if (rc == -EAGAIN)
+				continue;
+			/* failed to add ep or port */
+			if (rc)
+				return rc;
+		}
+
 		/* port added, new descendants possible, start over */
 		goto retry;
 	}
@@ -1727,16 +1885,19 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 		return 0;
 
 	device_lock_assert(&port->dev);
+	memcpy(cxlsd->target_map, target_map, sizeof(cxlsd->target_map));
 
 	if (xa_empty(&port->dports))
-		return -EINVAL;
+		return 0;
 
 	guard(rwsem_write)(&cxl_region_rwsem);
 	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
 		struct cxl_dport *dport = find_dport(port, target_map[i]);
 
-		if (!dport)
-			return -ENXIO;
+		if (!dport) {
+			/* dport may be activated later */
+			continue;
+		}
 		cxlsd->target[i] = dport;
 	}
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3f1695c96abc..de7883747555 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -403,6 +403,7 @@ struct cxl_endpoint_decoder {
  * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
  * @cxld: base cxl_decoder object
  * @nr_targets: number of elements in @target
+ * @target_map: map of target dport ids to interleave positions
  * @target: active ordered target list in current decoder configuration
  *
  * The 'switch' decoder type represents the decoder instances of cxl_port's that
@@ -414,6 +415,7 @@ struct cxl_endpoint_decoder {
 struct cxl_switch_decoder {
 	struct cxl_decoder cxld;
 	int nr_targets;
+	int target_map[CXL_DECODER_MAX_INTERLEAVE];
 	struct cxl_dport *target[];
 };
 
@@ -584,6 +586,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @total_dports: total possible dports in this port
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -604,6 +607,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	int total_dports;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
@@ -902,6 +906,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c2);
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
+int cxl_port_update_total_dports(struct cxl_port *port);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index fe4b593331da..ee7dcd7c4f24 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -65,12 +65,10 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	/* Cache the data early to ensure is_visible() works */
 	read_cdat_data(port);
 
-	rc = devm_cxl_port_enumerate_dports(port);
-	if (rc < 0)
+	rc = cxl_port_update_total_dports(port);
+	if (rc)
 		return rc;
 
-	cxl_switch_parse_cdat(port);
-
 	cxlhdm = devm_cxl_setup_hdm(port, NULL);
 	if (!IS_ERR(cxlhdm))
 		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
@@ -80,7 +78,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 		return PTR_ERR(cxlhdm);
 	}
 
-	if (rc == 1) {
+	if (port->total_dports == 1) {
 		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
 		return devm_cxl_add_passthrough_decoder(port);
 	}
-- 
2.50.0

