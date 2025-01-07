Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884641428E7;
	Tue,  7 Jan 2025 03:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222268; cv=pass; b=oyz0GRkm9N0xTVUDm+3HPeqXPazxQ59XmtKrqOvIg5wX58Z+IThnCA9P+UYz0VPpAIpf0JhoD2/hxoWaxa8vpIH/L3lVFH7F4lByHzMp/HNzpXPPsHVc0X2n2SVxagJIj18zEXg/nuqBpnPGSPeJn5sq6a5rPeERVDjMTnn2nV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222268; c=relaxed/simple;
	bh=0Mwsm2U+HxFCFxxFksT1mRHsc/C4xXgqogE5S3Mzu3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJ12KiAl78WDjZAMRp+PdsUIprECs5qAjLTSKbgCNBkPhkWdVTpQjxC10T/p9/XMbB4XEJpp2PxGRIAtwhjRBJ94kQqXwuQQgm6K9tDhByqYsnwB90rf3nyaPCyGfsozpJ5qTpFN5BZy0CmKtlEYnhVc9IedgWSvHizbQT7uJ5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=EokBLaPQ; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="EokBLaPQ"
ARC-Seal: i=1; a=rsa-sha256; t=1736222249; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gzmKvJe9miKZepezJE0GAdwGGB8RrH+CRBnFQsqk/KH+h4P/08xv0Nt6axhgMIgW6YlBURGmZcLYTtcCjD90l/WZ5tIw2W/TqJqOTpkczwUsic3A2j+g32QjE9G6TzB6Z3Yqn5kRRyknO0u7FiaOW0GI72yY+tEUQqsQD0LRXA8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736222249; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3fHPNLQX3+/YAAB44PMrBbiNoska5PAw4ZhbhhYu9nU=; 
	b=N3mtXWeHqbfHPqSwYoofDFStaYx4ya5NzgxEmksWfc7I9BcNBJafw1WV7G+/6YLL23eufC9ZfV8GYOfLt5JCacu8qj75ErUi7ytx5kO2ecWFXRI8Ia4pO30HYx7SclsxGQLDBFxmEyQVmA9ux39ng+Wlu6HT90ikTEfeHU4eNFI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736222249;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=3fHPNLQX3+/YAAB44PMrBbiNoska5PAw4ZhbhhYu9nU=;
	b=EokBLaPQP3EEAKr4nSWIRPH4eFDPaHAQHn6bA/Q8Wnbv6yKnsjntHaICzoxRPSE1
	CR1eA2/0yNDgFjtKDAuk+GAtD4mZ1TEKXjzVp8YFs+2xDV/r1STTswsQqhCPNVnKjEb
	7nE1dNRCCG7zWyN9W+lRUSHor8KczZWBKusT0mNI=
Received: by mx.zohomail.com with SMTPS id 1736222247707626.4086841253875;
	Mon, 6 Jan 2025 19:57:27 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [RFC PATCH 1/8] cxl/port: Enumerate port component regs when endpoint attaching
Date: Tue,  7 Jan 2025 11:57:01 +0800
Message-Id: <20250107035708.1134954-2-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107035708.1134954-1-ming.li@zohomail.com>
References: <20250107035708.1134954-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112273ce3ae1c79c562c7b4114c090000d8d6538b819bddcb63b73e67e4d892b9be91ff787d9def1ca1:zu08011227aa2caf80c888f70197d00983000097fce6194b4c70446ae487d46e9404bd25a58777cf0681ae31:rf0801122deafdd4e088c58c70bd45aa690000c5bb6e66483d2230c935b45c2f3cd4f0c2daa8495a6126ea21923e7f68a883:ZohoMail
X-ZohoMailClient: External

In some hardware platform, CXL host bridge does not expose its component
registers if no CXL device/switch is under it. in this case, CXL
subsystem will fail to enumerate component registers on such CXL host
bridge during CXL host bridge port attaching, because a CXL port
component registers are enumerated during adding the port to the
hierarchy.

To solve above issue, CXL port component registers enumeration should be
delayed until the first endpoint attaching, the implementations is
moving port component registers enumeration from devm_cxl_add_port() to
devm_cxl_add_endpoint().

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/port.c | 102 ++++++++++++++++++++++++++--------------
 drivers/cxl/cxl.h       |   4 ++
 drivers/cxl/port.c      |  19 ++++++++
 3 files changed, 91 insertions(+), 34 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 78a5c2c25982..1022c0775daa 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -596,6 +596,12 @@ struct cxl_port *to_cxl_port(const struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_port, "CXL");
 
+static void cxl_register_map_reset(struct cxl_register_map *map)
+{
+	*map = (struct cxl_register_map){ 0 };
+	map->resource = CXL_RESOURCE_NONE;
+}
+
 static void unregister_port(void *_port)
 {
 	struct cxl_port *port = _port;
@@ -735,6 +741,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	ida_init(&port->decoder_ida);
 	port->hdm_end = -1;
 	port->commit_end = -1;
+	cxl_register_map_reset(&port->reg_map);
 	xa_init(&port->dports);
 	xa_init(&port->endpoints);
 	xa_init(&port->regions);
@@ -766,14 +773,52 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
 	return cxl_setup_regs(map);
 }
 
-static int cxl_port_setup_regs(struct cxl_port *port,
-			resource_size_t component_reg_phys)
+static resource_size_t find_component_registers(struct device *dev)
 {
+	struct cxl_register_map map;
+	struct pci_dev *pdev;
+
+	/*
+	 * Theoretically, CXL component registers can be hosted on a
+	 * non-PCI device, in practice, only cxl_test hits this case.
+	 */
+	if (!dev_is_pci(dev))
+		return CXL_RESOURCE_NONE;
+
+	pdev = to_pci_dev(dev);
+
+	cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	return map.resource;
+}
+
+/**
+ * cxl_port_setup_regs - probe all component registers of a cxl port
+ * @port: target cxl port
+ */
+int cxl_port_setup_regs(struct cxl_port *port)
+{
+	resource_size_t component_reg_phys;
+
 	if (dev_is_platform(port->uport_dev))
 		return 0;
+	/* component registers have been set up */
+	if (port->reg_map.resource != CXL_RESOURCE_NONE)
+		return 0;
+
+	if (is_cxl_root(to_cxl_port(port->dev.parent)))
+		component_reg_phys = port->chbcr;
+	else
+		component_reg_phys = find_component_registers(port->uport_dev);
+
+	if (component_reg_phys == CXL_RESOURCE_NONE) {
+		dev_warn(&port->dev, "Invalid Component Registers");
+		return -ENXIO;
+	}
+
 	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
 				   component_reg_phys);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_port_setup_regs, "CXL");
 
 static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 				resource_size_t component_reg_phys)
@@ -856,9 +901,8 @@ static int cxl_port_add(struct cxl_port *port,
 		if (rc)
 			return rc;
 
-		rc = cxl_port_setup_regs(port, component_reg_phys);
-		if (rc)
-			return rc;
+		if (is_cxl_root(parent_dport->port))
+			port->chbcr = component_reg_phys;
 	} else {
 		rc = dev_set_name(dev, "root%d", port->id);
 		if (rc)
@@ -1499,16 +1543,26 @@ static void cxl_detach_ep(void *data)
 		dev_dbg(&cxlmd->dev, "disconnect %s from %s\n",
 			ep ? dev_name(ep->ep) : "", dev_name(&port->dev));
 		cxl_ep_remove(port, ep);
-		if (ep && !port->dead && xa_empty(&port->endpoints) &&
-		    !is_cxl_root(parent_port) && parent_port->dev.driver) {
+		if (ep && xa_empty(&port->endpoints)) {
 			/*
-			 * This was the last ep attached to a dynamically
-			 * enumerated port. Block new cxl_add_ep() and garbage
-			 * collect the port.
+			 * Reset component registers information on the port
+			 * during the last ep detaching. So that the next ep
+			 * attaching can trigger component registers probing
+			 * again.
 			 */
-			died = true;
-			port->dead = true;
-			reap_dports(port);
+			cxl_register_map_reset(&port->reg_map);
+
+			if (!port->dead && !is_cxl_root(parent_port) &&
+			    parent_port->dev.driver) {
+				/*
+				 * This was the last ep attached to a dynamically
+				 * enumerated port. Block new cxl_add_ep() and garbage
+				 * collect the port.
+				 */
+				died = true;
+				port->dead = true;
+				reap_dports(port);
+			}
 		}
 		device_unlock(&port->dev);
 
@@ -1521,31 +1575,12 @@ static void cxl_detach_ep(void *data)
 	}
 }
 
-static resource_size_t find_component_registers(struct device *dev)
-{
-	struct cxl_register_map map;
-	struct pci_dev *pdev;
-
-	/*
-	 * Theoretically, CXL component registers can be hosted on a
-	 * non-PCI device, in practice, only cxl_test hits this case.
-	 */
-	if (!dev_is_pci(dev))
-		return CXL_RESOURCE_NONE;
-
-	pdev = to_pci_dev(dev);
-
-	cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
-	return map.resource;
-}
-
 static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			      struct device *uport_dev,
 			      struct device *dport_dev)
 {
 	struct device *dparent = grandparent(dport_dev);
 	struct cxl_dport *dport, *parent_dport;
-	resource_size_t component_reg_phys;
 	int rc;
 
 	if (!dparent) {
@@ -1581,9 +1616,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 
 		port = find_cxl_port_at(parent_port, dport_dev, &dport);
 		if (!port) {
-			component_reg_phys = find_component_registers(uport_dev);
 			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
-						 component_reg_phys, parent_dport);
+						 CXL_RESOURCE_NONE, parent_dport);
 			if (IS_ERR(port))
 				return PTR_ERR(port);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f6015f24ad38..9877a0ddb5e9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -601,6 +601,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @chbcr: physical address of CXL host bridge component registers
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -621,6 +622,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	resource_size_t chbcr;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
@@ -771,6 +773,8 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 struct device *dport_dev, int port_id,
 					 resource_size_t rcrb);
 
+int cxl_port_setup_regs(struct cxl_port *port);
+
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 4c83f6a22e58..ae09bbbe0a17 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -91,6 +91,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 
 static int cxl_endpoint_port_probe(struct cxl_port *port)
 {
+	struct cxl_port *iter, *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_endpoint_dvsec_info info = { .port = port };
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -98,6 +99,24 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_port *root;
 	int rc;
 
+	for (iter = parent_port; !is_cxl_root(iter);
+	     iter = to_cxl_port(iter->dev.parent)) {
+		/*
+		 * The parent port of endpoint has been locked
+		 * during endpoint port attaching.
+		 * Holding the device lock of port to make sure
+		 * the setup not invoked in parallel.
+		 */
+		if (iter != parent_port) {
+			guard(device)(&iter->dev);
+			rc = cxl_port_setup_regs(iter);
+		} else {
+			rc = cxl_port_setup_regs(iter);
+		}
+		if (rc)
+			return rc;
+	}
+
 	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
 	if (rc < 0)
 		return rc;
-- 
2.34.1

