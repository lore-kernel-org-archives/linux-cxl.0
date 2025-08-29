Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8671A21019E
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756491024; cv=none; b=c/P7KSpueOAPV3L4ysY9tzQiGcPdRY6XNxN73fCULqMQulDX9DvGw1lRWuPAZyrOY5PBIohEIj8FBjJY22dBG2rpmRoBR28UwiEzmdnxbjJ9Q7pw6oZLvpXPqLzOAB2tLQebPE4M7pSJuW2GggJi7dEOsYUQn7t6yt0fvdkyUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756491024; c=relaxed/simple;
	bh=3hJryS25LA+jsDEdBO5I3Q6SrAWBItk1ASLpEgSUYMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZnCeF/JY3zPDZTSDr1uk+QbLc33nqEO07vObr7Qs3AUVhVuQwj8KcZ/Y2hDCeFVvDoEGkbU+6AfmZLIFTNd4Re3XvjKM7W0iXZJTqoUZGMEGrn4btgsLcAeOmJWpOMMiZKZyN8vcN1Pvav2W627cv8/rs+T/vxyA44GKHIeywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6954CC4CEF6;
	Fri, 29 Aug 2025 18:10:22 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com
Subject: [PATCH v9 06/10] cxl: Defer dport allocation for switch ports
Date: Fri, 29 Aug 2025 11:09:24 -0700
Message-ID: <20250829180928.842707-7-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829180928.842707-1-dave.jiang@intel.com>
References: <20250829180928.842707-1-dave.jiang@intel.com>
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
ACPI0017.N device. Through that it enumerates downstream ports composed
of ACPI0016.N devices through add_host_bridge_dport(). Once done, it
uses add_host_bridge_uport() to create the ports that enumerate the PCI
RPs as the dports of these ports. Every time a port is created, the port
driver is attached, cxl_switch_porbe_probe() is called and
devm_cxl_port_enumerate_dports() is invoked to enumerate and probe
the dports.

The second phase is if there are any CXL switches. When the pci endpoint
device driver (cxl_pci) calls probe, it will add a mem device and triggers
the cxl_mem_probe(). cxl_mem_probe() calls devm_cxl_enumerate_ports()
and attempts to discovery and create all the ports represent CXL switches.
During this phase, a port is created per switch and the attached dports
are also enumerated and probed.

The last phase is creating endpoint port which happens for all endpoint
devices.

The new sequence is instead of creating all possible dports at initial
port creation, defer port instantiation until a memdev beneath that
dport arrives. Introduce devm_cxl_create_or_extend_port() to centralize
the creation and extension of ports with new dports as memory devices
arrive. As part of this rework, switch decoder target list is amended
at runtime as dports show up.

While the decoders are allocated during the port driver probe,
The decoders must also be updated since previously it's all done when all
the dports are setup and now every time a dport is setup per endpoint, the
switch target listing need to be updated with new dport. A
guard(rwsem_write) is used to update decoder targets. This is similar to
when decoder_populate_target() is called and the decoder programming
must be protected.

Also the port registers are probed the first time when the first dport
shows up. This ensures that the CXL link is established when the port
registers are probed.

Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v9:
- Dropped tested-by tag by Robert since significant code changes.
  Also dropped review tags.
- Rework iteration loop. (Robert)
- Dropped possible_ports in 'struct cxl_port' (Robert)
- Stop the update_decoder_targets() iteration when found. (Robert)
- Use number of decoders to gate decoder allocation.
- cxl_port_get_or_add_dport() ->cxl_port_add_dport(). (Robert)
- Unfold cxl_decoders_dport_update() (Robert)
- Remove devm_cxl_add_dport_by_uport() (Robert)
---
 drivers/cxl/core/cdat.c |   2 +-
 drivers/cxl/core/core.h |   2 +
 drivers/cxl/core/hdm.c  |   6 -
 drivers/cxl/core/pci.c  |  46 ++++++++
 drivers/cxl/core/port.c | 240 ++++++++++++++++++++++++++++++++--------
 drivers/cxl/port.c      |  11 +-
 6 files changed, 247 insertions(+), 60 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index c0af645425f4..b156b81a9b20 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -338,7 +338,7 @@ static int match_cxlrd_hb(struct device *dev, void *data)
 
 	guard(rwsem_read)(&cxl_rwsem.region);
 	for (int i = 0; i < cxlsd->nr_targets; i++) {
-		if (host_bridge == cxlsd->target[i]->dport_dev)
+		if (cxlsd->target[i] && host_bridge == cxlsd->target[i]->dport_dev)
 			return 1;
 	}
 
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index b07490aa93c7..e18425f119bd 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -146,6 +146,8 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
 int cxl_gpf_port_setup(struct cxl_dport *dport);
+struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
+					    struct device *dport_dev);
 
 struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 78bfe4f55b96..72594f84d2a1 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -52,8 +52,6 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
 static int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 {
 	struct cxl_switch_decoder *cxlsd;
-	struct cxl_dport *dport = NULL;
-	unsigned long index;
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 
 	/*
@@ -69,10 +67,6 @@ static int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 
 	device_lock_assert(&port->dev);
 
-	xa_for_each(&port->dports, index, dport)
-		break;
-	cxlsd->cxld.target_map[0] = dport->port_id;
-
 	return add_hdm_decoder(port, &cxlsd->cxld);
 }
 
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index fa02366d35f2..9ec288ed39ae 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -24,6 +24,52 @@ static unsigned short media_ready_timeout = 60;
 module_param(media_ready_timeout, ushort, 0644);
 MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
 
+static int pci_get_port_num(struct pci_dev *pdev)
+{
+	u32 lnkcap;
+	int type;
+
+	type = pci_pcie_type(pdev);
+	if (type != PCI_EXP_TYPE_DOWNSTREAM && type != PCI_EXP_TYPE_ROOT_PORT)
+		return -EINVAL;
+
+	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
+				  &lnkcap))
+		return -ENXIO;
+
+	return FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
+}
+
+/**
+ * devm_cxl_add_dport_by_dev - allocate a dport by the dport device
+ * @port: cxl_port that hosts the dport
+ * @dport_dev: 'struct device' of the dport
+ *
+ * Returns the allocated dport on success or ERR_PTR() of -errno on error
+ */
+struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
+					    struct device *dport_dev)
+{
+	struct cxl_register_map map;
+	struct pci_dev *pdev;
+	int port_num, rc;
+
+	if (!dev_is_pci(dport_dev))
+		return ERR_PTR(-EINVAL);
+
+	pdev = to_pci_dev(dport_dev);
+	port_num = pci_get_port_num(pdev);
+	if (port_num < 0)
+		return ERR_PTR(port_num);
+
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		return ERR_PTR(rc);
+
+	device_lock_assert(&port->dev);
+	return devm_cxl_add_dport(port, dport_dev, port_num, map.resource);
+}
+
 struct cxl_walk_context {
 	struct pci_bus *bus;
 	struct cxl_port *port;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f379e4c5121d..fa7ed5d50064 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1367,21 +1367,6 @@ static struct cxl_port *find_cxl_port(struct device *dport_dev,
 	return port;
 }
 
-static struct cxl_port *find_cxl_port_at(struct cxl_port *parent_port,
-					 struct device *dport_dev,
-					 struct cxl_dport **dport)
-{
-	struct cxl_find_port_ctx ctx = {
-		.dport_dev = dport_dev,
-		.parent_port = parent_port,
-		.dport = dport,
-	};
-	struct cxl_port *port;
-
-	port = __find_cxl_port(&ctx);
-	return port;
-}
-
 /*
  * All users of grandparent() are using it to walk PCIe-like switch port
  * hierarchy. A PCIe switch is comprised of a bridge device representing the
@@ -1557,13 +1542,154 @@ static resource_size_t find_component_registers(struct device *dev)
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
+static int update_decoder_targets(struct device *dev, void *data)
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
+	guard(rwsem_write)(&cxl_rwsem.region);
+
+	for (i = 0; i < cxld->interleave_ways; i++) {
+		if (cxld->target_map[i] == dport->port_id) {
+			cxlsd->target[i] = dport;
+			dev_dbg(dev, "dport%d found in target list, index %d\n",
+				dport->port_id, i);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+DEFINE_FREE(del_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) del_dport(_T))
+static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
+					    struct device *dport_dev)
+{
+	struct cxl_dport *dport;
+	int rc;
+
+	device_lock_assert(&port->dev);
+	if (!port->dev.driver)
+		return ERR_PTR(-ENXIO);
+
+	dport = cxl_find_dport_by_dev(port, dport_dev);
+	if (dport) {
+		dev_dbg(&port->dev, "dport%d:%s already exists\n",
+			dport->port_id, dev_name(dport_dev));
+		return ERR_PTR(-EBUSY);
+	}
+
+	struct cxl_dport *new_dport __free(del_cxl_dport) =
+		devm_cxl_add_dport_by_dev(port, dport_dev);
+	if (IS_ERR(new_dport))
+		return new_dport;
+
+	cxl_switch_parse_cdat(port);
+
+	if (ida_is_empty(&port->decoder_ida)) {
+		rc = devm_cxl_switch_port_decoders_setup(port);
+		if (rc)
+			return ERR_PTR(rc);
+		dev_dbg(&port->dev, "first dport%d:%s added with decoders\n",
+			new_dport->port_id, dev_name(dport_dev));
+		return no_free_ptr(new_dport);
+	}
+
+	/* New dport added, update the decoder targets */
+	device_for_each_child(&port->dev, new_dport, update_decoder_targets);
+
+	dev_dbg(&port->dev, "dport%d:%s added\n", new_dport->port_id,
+		dev_name(dport_dev));
+
+	return no_free_ptr(new_dport);
+}
+
+static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
+					      struct cxl_port *parent_port,
+					      struct cxl_dport *parent_dport,
+					      struct device *uport_dev,
+					      struct device *dport_dev)
+{
+	resource_size_t component_reg_phys;
+
+	device_lock_assert(&parent_port->dev);
+	if (!parent_port->dev.driver) {
+		dev_warn(ep_dev,
+			 "port %s:%s:%s disabled, failed to enumerate CXL.mem\n",
+			 dev_name(&parent_port->dev), dev_name(uport_dev),
+			 dev_name(dport_dev));
+	}
+
+	struct cxl_port *port __free(put_cxl_port) =
+		find_cxl_port_by_uport(uport_dev);
+	if (!port) {
+		component_reg_phys = find_component_registers(uport_dev);
+		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
+					 component_reg_phys, parent_dport);
+		if (IS_ERR(port))
+			return (struct cxl_dport *)port;
+
+		/*
+		 * retry to make sure a port is found. a port device
+		 * reference is taken.
+		 */
+		port = find_cxl_port_by_uport(uport_dev);
+		if (!port)
+			return ERR_PTR(-ENODEV);
+
+		dev_dbg(ep_dev, "created port %s:%s\n",
+			dev_name(&port->dev), dev_name(port->uport_dev));
+	} else {
+		/*
+		 * Port was created before right before this function is
+		 * called. Signal the caller to deal with it.
+		 */
+		return ERR_PTR(-EAGAIN);
+	}
+
+	guard(device)(&port->dev);
+	return cxl_port_add_dport(port, dport_dev);
+}
+
 static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			      struct device *uport_dev,
 			      struct device *dport_dev)
 {
 	struct device *dparent = grandparent(dport_dev);
 	struct cxl_dport *dport, *parent_dport;
-	resource_size_t component_reg_phys;
 	int rc;
 
 	if (is_cxl_host_bridge(dparent)) {
@@ -1578,42 +1704,31 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	}
 
 	struct cxl_port *parent_port __free(put_cxl_port) =
-		find_cxl_port(dparent, &parent_dport);
+		find_cxl_port_by_uport(dparent->parent);
 	if (!parent_port) {
 		/* iterate to create this parent_port */
 		return -EAGAIN;
 	}
 
-	/*
-	 * Definition with __free() here to keep the sequence of
-	 * dereferencing the device of the port before the parent_port releasing.
-	 */
-	struct cxl_port *port __free(put_cxl_port) = NULL;
 	scoped_guard(device, &parent_port->dev) {
-		if (!parent_port->dev.driver) {
-			dev_warn(&cxlmd->dev,
-				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
-				 dev_name(&parent_port->dev), dev_name(uport_dev));
-			return -ENXIO;
+		parent_dport = cxl_find_dport_by_dev(parent_port, dparent);
+		if (!parent_dport) {
+			parent_dport = cxl_port_add_dport(parent_port, dparent);
+			if (IS_ERR(parent_dport))
+				return PTR_ERR(parent_dport);
 		}
 
-		port = find_cxl_port_at(parent_port, dport_dev, &dport);
-		if (!port) {
-			component_reg_phys = find_component_registers(uport_dev);
-			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
-						 component_reg_phys, parent_dport);
-			if (IS_ERR(port))
-				return PTR_ERR(port);
-
-			/* retry find to pick up the new dport information */
-			port = find_cxl_port_at(parent_port, dport_dev, &dport);
-			if (!port)
-				return -ENXIO;
+		dport = devm_cxl_create_port(&cxlmd->dev, parent_port,
+					     parent_dport, uport_dev,
+					     dport_dev);
+		if (IS_ERR(dport)) {
+			/* Port already exists, restart iteration */
+			if (PTR_ERR(dport) == -EAGAIN)
+				return 0;
+			return PTR_ERR(dport);
 		}
 	}
 
-	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
-		dev_name(&port->dev), dev_name(port->uport_dev));
 	rc = cxl_add_ep(dport, &cxlmd->dev);
 	if (rc == -EBUSY) {
 		/*
@@ -1626,6 +1741,25 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	return rc;
 }
 
+static struct cxl_dport *find_or_add_dport(struct cxl_port *port,
+					   struct device *dport_dev)
+{
+	struct cxl_dport *dport;
+
+	device_lock_assert(&port->dev);
+	dport = cxl_find_dport_by_dev(port, dport_dev);
+	if (!dport) {
+		dport = cxl_port_add_dport(port, dport_dev);
+		if (IS_ERR(dport))
+			return dport;
+
+		/* New dport added, restart iteration */
+		return ERR_PTR(-EAGAIN);
+	}
+
+	return dport;
+}
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 {
 	struct device *dev = &cxlmd->dev;
@@ -1668,12 +1802,26 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			dev_name(iter), dev_name(dport_dev),
 			dev_name(uport_dev));
 		struct cxl_port *port __free(put_cxl_port) =
-			find_cxl_port(dport_dev, &dport);
+			find_cxl_port_by_uport(uport_dev);
 		if (port) {
 			dev_dbg(&cxlmd->dev,
 				"found already registered port %s:%s\n",
 				dev_name(&port->dev),
 				dev_name(port->uport_dev));
+
+			/*
+			 * RP port enumerated by cxl_acpi without dport will
+			 * have the dport added here.
+			 */
+			scoped_guard(device, &port->dev) {
+				dport = find_or_add_dport(port, dport_dev);
+				if (IS_ERR(dport)) {
+					if (PTR_ERR(dport) == -EAGAIN)
+						goto retry;
+					return PTR_ERR(dport);
+				}
+			}
+
 			rc = cxl_add_ep(dport, &cxlmd->dev);
 
 			/*
@@ -1733,14 +1881,16 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 	device_lock_assert(&port->dev);
 
 	if (xa_empty(&port->dports))
-		return -EINVAL;
+		return 0;
 
 	guard(rwsem_write)(&cxl_rwsem.region);
 	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
 		struct cxl_dport *dport = find_dport(port, cxld->target_map[i]);
 
-		if (!dport)
-			return -ENXIO;
+		if (!dport) {
+			/* dport may be activated later */
+			continue;
+		}
 		cxlsd->target[i] = dport;
 	}
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d8cae2b5bac6..51c8f2f84717 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -59,18 +59,13 @@ static int discover_region(struct device *dev, void *unused)
 
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
-	int rc;
+	/* Reset nr_dports for rebind of driver */
+	port->nr_dports = 0;
 
 	/* Cache the data early to ensure is_visible() works */
 	read_cdat_data(port);
 
-	rc = devm_cxl_port_enumerate_dports(port);
-	if (rc < 0)
-		return rc;
-
-	cxl_switch_parse_cdat(port);
-
-	return devm_cxl_switch_port_decoders_setup(port);
+	return 0;
 }
 
 static int cxl_endpoint_port_probe(struct cxl_port *port)
-- 
2.50.1

