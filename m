Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0A715E8B
	for <linux-cxl@vger.kernel.org>; Wed,  7 May 2025 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746578599; cv=none; b=qs80LXzEQLHr2dyYT76l8FUnUOqIPSvBdaZxCLe/ILRP9TmDPv0tvmgE7ZFuSXdOiEHr2g3TaO0VxNX1aB/hS58Qwfft7u7lSJTbah4AJm4gijm4UQxekpdusOSmjcN7K0GlAa/oqSNL03+6r1rkFKVXLVVv8+JhMEdqgurjOvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746578599; c=relaxed/simple;
	bh=G5u2Dqu0eNJzdYL5N3VtRZkJvZJRaEbMlZfrLPVxja4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wfqx6VsQQbs17DzmTZhFRWxZU3kKtgfXkcKGaHygB5eLz8Ozh047AhhVll45cchXGNXt2zw1yq0Zq071ScGNZQfzAHpwFwvAK4QBrZ6aYrvadVo0pY47P8JhIPrBH7zGYvGorLR4asc6Ys8DJw0I99lRlFWqgGjrsgudqzcbiW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3953AC4CEEF;
	Wed,  7 May 2025 00:43:19 +0000 (UTC)
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
Subject: [PATCH v2 05/10] cxl: Defer hardware dport->port_id assignment and registers probing
Date: Tue,  6 May 2025 17:43:05 -0700
Message-ID: <20250507004310.3536991-6-dave.jiang@intel.com>
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

Current implementation only enumerates the dports during the port probe.
Without an endpoint connected, the dport may not be active during port
probe. This scheme may prevent a valid hardware dport id to be retrieved
and MMIO registers to be read when an endpoint is hot-plugged. Move the hw
dport id assignment and the register probing to behind memdev probe so the
endpoint is guaranteed to be connected.

The detection of duplicate dport for add_dport() is removed. The port_id
is not read from the hw at this point any longer. The port->id will always
be unique since it's retrieved from an ida. The dup detection thus become
irrelevant.

The decoders must also be updated since previously it's all done when all
the dports are setup and now every time a dport is setup per endpoint, the
switch target listing need to be updated with new dport.

Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Fix spelling error in commit message. (Ming)
- Move probing to the specific dport. (Ming)
- Add decoder update.
- Return errors when setup dports. (Jonathan)
- Add driver check before setup dport. (Dan)
- Add comment on why location to do dport update. (Dan)
---
 drivers/cxl/core/core.h |   4 ++
 drivers/cxl/core/pci.c  |  60 ++++++++++++----
 drivers/cxl/core/port.c | 152 +++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxl.h       |   4 ++
 drivers/cxl/port.c      |  20 +-----
 5 files changed, 192 insertions(+), 48 deletions(-)

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
index 3b84b43ab194..16bd842904e5 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -24,6 +24,52 @@ static unsigned short media_ready_timeout = 60;
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
+
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc) {
+		dev_dbg(&port->dev, "failed to find component registers\n");
+		return -ENODEV;
+	}
+
+	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
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
@@ -37,10 +83,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 	struct cxl_walk_context *ctx = data;
 	struct cxl_port *port = ctx->port;
 	int type = pci_pcie_type(pdev);
-	struct cxl_register_map map;
 	struct cxl_dport *dport;
-	u32 lnkcap, port_num;
-	int rc;
 
 	if (pdev->bus != ctx->bus)
 		return 0;
@@ -48,22 +91,13 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
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
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 70173d23139c..04e18a102d26 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -782,8 +782,8 @@ static int cxl_port_setup_regs(struct cxl_port *port,
 				   component_reg_phys);
 }
 
-static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
-				resource_size_t component_reg_phys)
+int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
+			 resource_size_t component_reg_phys)
 {
 	int rc;
 
@@ -1004,7 +1004,7 @@ int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_register_pci_bus, "CXL");
 
-static bool dev_is_cxl_root_child(struct device *dev)
+bool dev_is_cxl_root_child(struct device *dev)
 {
 	struct cxl_port *port, *parent;
 
@@ -1021,6 +1021,7 @@ static bool dev_is_cxl_root_child(struct device *dev)
 
 	return false;
 }
+EXPORT_SYMBOL_NS_GPL(dev_is_cxl_root_child, "CXL");
 
 struct cxl_root *find_cxl_root(struct cxl_port *port)
 {
@@ -1059,19 +1060,9 @@ static struct cxl_dport *find_dport_by_num(struct cxl_port *port, int port_num)
 
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
@@ -1643,6 +1634,118 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	return rc;
 }
 
+static int port_probe_dport(struct cxl_port *port, struct device *dport_dev,
+			    struct cxl_dport **probed_dport)
+{
+	struct cxl_dport *dport;
+	unsigned long index;
+	int rc;
+
+	device_lock_assert(&port->dev);
+	xa_for_each(&port->dports, index, dport) {
+		if (dport->dport_dev == dport_dev) {
+			rc = cxl_dport_setup(dport);
+			if (rc)
+				return rc;
+			*probed_dport = dport;
+			return 0;
+		}
+	}
+
+	*probed_dport = NULL;
+
+	return -ENODEV;
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
+	int rc;
+
+	device_lock_assert(&port->dev);
+
+	if (!port->dev.driver)
+		return -ENODEV;
+
+	rc = port_probe_dport(port, dport_dev, &dport);
+	if (rc)
+		return rc;
+
+	cxl_switch_parse_cdat(port);
+
+	/* Make sure that no decoders have been allocated before proceeding. */
+	if (ida_is_empty(&port->decoder_ida))
+		rc = devm_cxl_port_setup_decoders(port);
+	else
+		rc = update_decoders_with_dport(port, dport);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 {
 	struct device *dev = &cxlmd->dev;
@@ -1695,6 +1798,19 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
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
@@ -1760,10 +1876,14 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 
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
index a35fc5552845..4d840a6ef802 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -59,7 +59,6 @@ static int discover_region(struct device *dev, void *root)
 
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
-	struct cxl_hdm *cxlhdm;
 	int rc;
 
 	/* Cache the data early to ensure is_visible() works */
@@ -69,24 +68,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	if (rc < 0)
 		return rc;
 
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
+	return 0;
 }
 
 static int cxl_endpoint_port_probe(struct cxl_port *port)
-- 
2.49.0

