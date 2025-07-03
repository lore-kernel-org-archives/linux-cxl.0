Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EBC2D3757
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 23:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751585251; cv=none; b=sGRPP0IcYXpbSV9PABKeILYl1yjKjwO0Gc4ldGzplJy5W7m0mjmlmk4Zs0GNe9AJqFpLeoBQFejD2aBGIVrbN5or2kyRwm5yfVrA4pIQW2xn/QQX6d6ssr3a3jiBN5dN2nXrHr1YSdCTV0GJWeS9/xxFU+C1hQ3JwL65Jq34lzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751585251; c=relaxed/simple;
	bh=v/VY0C2IRQ/NMoYUO73aBM3MLfCyuVn00FKC6/li3cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCqdnCmLX7gjlBBu9j41D3ITrRrsSfxEokamX2vj+jRiA5lQoLMQcp77dYhKhG7zFj/QKR22yjbHq3pEEoduZuFm0xJOtZjfQj+a88CJrUkCJrsXwi7JjKlPxeQz3QX4XMc1NYszt6A9m+FXRiycQSsQUl7sfU4aLxrktM0Gb3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1620C4CEE3;
	Thu,  3 Jul 2025 23:27:30 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v5 10/10] cxl: Remove devm_cxl_port_enumerate_dports() that is no longer used
Date: Thu,  3 Jul 2025 16:27:10 -0700
Message-ID: <20250703232710.3141436-11-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703232710.3141436-1-dave.jiang@intel.com>
References: <20250703232710.3141436-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete function devm_cxl_port_enumerate_dports() which is no longer being
used anywhere. Also remove cxl_test support.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c        | 87 ++++-------------------------------
 drivers/cxl/cxlpci.h          |  1 -
 tools/testing/cxl/Kbuild      |  1 -
 tools/testing/cxl/test/cxl.c  | 31 -------------
 tools/testing/cxl/test/mock.c | 15 ------
 tools/testing/cxl/test/mock.h |  1 -
 6 files changed, 8 insertions(+), 128 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5594b0fcddb0..717e25131db7 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -63,85 +63,6 @@ struct cxl_dport *__devm_cxl_add_dport_by_dev(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_dport_by_dev, "CXL");
 
-struct cxl_walk_context {
-	struct pci_bus *bus;
-	struct cxl_port *port;
-	int type;
-	int error;
-	int count;
-};
-
-static int match_add_dports(struct pci_dev *pdev, void *data)
-{
-	struct cxl_walk_context *ctx = data;
-	struct cxl_port *port = ctx->port;
-	int type = pci_pcie_type(pdev);
-	struct cxl_register_map map;
-	struct cxl_dport *dport;
-	u32 lnkcap, port_num;
-	int rc;
-
-	if (pdev->bus != ctx->bus)
-		return 0;
-	if (!pci_is_pcie(pdev))
-		return 0;
-	if (type != ctx->type)
-		return 0;
-	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
-				  &lnkcap))
-		return 0;
-
-	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
-	if (rc)
-		dev_dbg(&port->dev, "failed to find component registers\n");
-
-	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
-	if (IS_ERR(dport)) {
-		ctx->error = PTR_ERR(dport);
-		return PTR_ERR(dport);
-	}
-	ctx->count++;
-
-	return 0;
-}
-
-/**
- * devm_cxl_port_enumerate_dports - enumerate downstream ports of the upstream port
- * @port: cxl_port whose ->uport_dev is the upstream of dports to be enumerated
- *
- * Returns a positive number of dports enumerated or a negative error
- * code.
- */
-int devm_cxl_port_enumerate_dports(struct cxl_port *port)
-{
-	struct pci_bus *bus = cxl_port_to_pci_bus(port);
-	struct cxl_walk_context ctx;
-	int type;
-
-	if (!bus)
-		return -ENXIO;
-
-	if (pci_is_root_bus(bus))
-		type = PCI_EXP_TYPE_ROOT_PORT;
-	else
-		type = PCI_EXP_TYPE_DOWNSTREAM;
-
-	ctx = (struct cxl_walk_context) {
-		.port = port,
-		.bus = bus,
-		.type = type,
-	};
-	pci_walk_bus(bus, match_add_dports, &ctx);
-
-	if (ctx.count == 0)
-		return -ENODEV;
-	if (ctx.error)
-		return ctx.error;
-	return ctx.count;
-}
-EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, "CXL");
-
 static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
@@ -1209,6 +1130,14 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
 	return 0;
 }
 
+struct cxl_walk_context {
+	struct pci_bus *bus;
+	struct cxl_port *port;
+	int type;
+	int error;
+	int count;
+};
+
 static int match_dport(struct pci_dev *pdev, void *data)
 {
 	struct cxl_walk_context *ctx = data;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 54e219b0049e..7827a183128d 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -127,7 +127,6 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
 	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
 }
 
-int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index d8c5f7df4866..4e3597d4ee9c 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -4,7 +4,6 @@ ldflags-y += --wrap=is_acpi_device_node
 ldflags-y += --wrap=acpi_evaluate_integer
 ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
-ldflags-y += --wrap=devm_cxl_port_enumerate_dports
 ldflags-y += --wrap=cxl_port_update_total_dports
 ldflags-y += --wrap=devm_cxl_setup_hdm
 ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 3e9c877fcff2..d52ae0be4941 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -996,36 +996,6 @@ static int mock_cxl_port_update_total_dports(struct cxl_port *port)
 	return 0;
 }
 
-static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
-{
-	struct platform_device **array;
-	int rc, i, array_size;
-
-	rc = get_port_array(port, &array, &array_size);
-	if (rc)
-		return rc;
-
-	for (i = 0; i < array_size; i++) {
-		struct platform_device *pdev = array[i];
-		struct cxl_dport *dport;
-
-		if (pdev->dev.parent != port->uport_dev) {
-			dev_dbg(&port->dev, "%s: mismatch parent %s\n",
-				dev_name(port->uport_dev),
-				dev_name(pdev->dev.parent));
-			continue;
-		}
-
-		dport = devm_cxl_add_dport(port, &pdev->dev, pdev->id,
-					   CXL_RESOURCE_NONE);
-
-		if (IS_ERR(dport))
-			return PTR_ERR(dport);
-	}
-
-	return 0;
-}
-
 static struct cxl_dport *mock_cxl_add_dport_by_dev(struct cxl_port *port,
 						   struct device *dport_dev)
 {
@@ -1112,7 +1082,6 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.acpi_table_parse_cedt = mock_acpi_table_parse_cedt,
 	.acpi_evaluate_integer = mock_acpi_evaluate_integer,
 	.acpi_pci_find_root = mock_acpi_pci_find_root,
-	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
 	.cxl_port_update_total_dports = mock_cxl_port_update_total_dports,
 	.devm_cxl_setup_hdm = mock_cxl_setup_hdm,
 	.devm_cxl_add_passthrough_decoder = mock_cxl_add_passthrough_decoder,
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 3c7190b7d5a4..8bb90d732332 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -188,21 +188,6 @@ int __wrap_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_enumerate_decoders, "CXL");
 
-int __wrap_devm_cxl_port_enumerate_dports(struct cxl_port *port)
-{
-	int rc, index;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-
-	if (ops && ops->is_mock_port(port->uport_dev))
-		rc = ops->devm_cxl_port_enumerate_dports(port);
-	else
-		rc = devm_cxl_port_enumerate_dports(port);
-	put_cxl_mock_ops(index);
-
-	return rc;
-}
-EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_port_enumerate_dports, "CXL");
-
 int __wrap_cxl_port_update_total_dports(struct cxl_port *port)
 {
 	int rc, index;
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index 0a440b9f544c..4d262a38dd51 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -19,7 +19,6 @@ struct cxl_mock_ops {
 	bool (*is_mock_bus)(struct pci_bus *bus);
 	bool (*is_mock_port)(struct device *dev);
 	bool (*is_mock_dev)(struct device *dev);
-	int (*devm_cxl_port_enumerate_dports)(struct cxl_port *port);
 	int (*cxl_port_update_total_dports)(struct cxl_port *port);
 	struct cxl_hdm *(*devm_cxl_setup_hdm)(
 		struct cxl_port *port, struct cxl_endpoint_dvsec_info *info);
-- 
2.50.0

