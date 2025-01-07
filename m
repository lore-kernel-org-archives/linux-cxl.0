Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57615145B16;
	Tue,  7 Jan 2025 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222326; cv=pass; b=AUvGVeiqdmKaJFtsrrDda7Ba7jAEtdYr/qfVPIWnTFDSFYsNre0iNWijMZPP1wk3kFRV/ZcOvwQ3k5tQUNp+wG74ugy8BXyr8lrXFoeBsBQ9Tkl18fpCRH8adREExdqYeC30Gniq8gqFuBzhoeA4fbUDtsYO8pmyYoEOr1Kjkro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222326; c=relaxed/simple;
	bh=Cm/w/MPqgdPfaPmPB3glkVTDu6hhJaaWkEc7imgxwt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMc3aHltgJ7ZRwRAyasoSGLN0aewXOgJ4EEKM2wOgQqn1AF1sDhY5qpussNNeCuVLVilF/Etukxub77mQ4PStUkDRHmWINHMxcAPRCa8cHoee7UkWt1SHMSrJw8J/9ryyNbaF47s5jbXHHVusEOWj0PoYiRnoSBRZjY6ocxXptY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=CNwG1+Pc; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="CNwG1+Pc"
ARC-Seal: i=1; a=rsa-sha256; t=1736222294; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YNH7rIVXhbqKTZQECqbazmnfRtdR8Y/94bt4zUWiRiaTw8QQZJu9mR+yfvDRdcXXAdpiE7fscbIhvD33GRJ1vnMP869s2hr8QLsIigthrHCZCA4x5uzsIJPN4IZB8lEQQI+MUjbNpTlCy84eex9KrTB1V/t/8XqsqD8/GxswyYQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736222294; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q3AkgWCWMELI0m2SkQkpfDpVb4TefEBAixjvr5k18nc=; 
	b=WWo7L4GnbCzQLoUFeONabKx4Z4MOUsiFWT8nxYICi6knwj6C9jAm2MGDhjLJTl1qYkGeTiQtR/KuTXtNhBcdw7mubBu1EPTTwsUM1IU7fqsJMf4pcnzexbolJ2Zun/FW20dNP+V+1/9j3M+b56pdeOdxltpTzppLzaVnbAH2j5I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736222294;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=q3AkgWCWMELI0m2SkQkpfDpVb4TefEBAixjvr5k18nc=;
	b=CNwG1+PcjtuP2x526pdbWbAz9PYUI2k2Lpy3dhYIuqmE5XEDYOQsiZ/mnJlGB1zd
	keEMqvqf+o1S1SYG9U1OjRJe8jqjqgP4goyB/Q7FvldueYlmISIMWVDPDaCoeEAkTWg
	gnu3UP35a5KVGH2sg4zHOg+IhNsEcI0v6ncBuq/w=
Received: by mx.zohomail.com with SMTPS id 1736222291628441.67571042337863;
	Mon, 6 Jan 2025 19:58:11 -0800 (PST)
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
Subject: [RFC PATCH 6/8] cxl/port: Enumerate dport component registers when endpoint attaching
Date: Tue,  7 Jan 2025 11:57:06 +0800
Message-Id: <20250107035708.1134954-7-ming.li@zohomail.com>
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
Feedback-ID: rr080112274e0e11f59bd0ec48e93449720000aa66435feda7b2a1038ae9172849cdeaaf5f62f6dfa1d9a620:zu080112271002f11d785326de5d5c87d2000076fdf23c5a46dc93a629c470e23ac110fdab4495299ddeb427:rf0801122dd287280cd9382e1a4a759415000030698c35451985f9e315c2a6653fa208b7e55076aed61bdfea22715f050075:ZohoMail
X-ZohoMailClient: External

In some hardware platform, dport's component registers are exposed only
when the dport is working on CXL mode and connecting to a CXL switch/CXL
device.

Currently, CXL subsystem will probe a dport's component registers when
the dport added to its port. In VH case, a root port's component
registers are probed during the host bridge the root port belongs to
attaching. As mentioned above, if no CXL/switch/CXL device connected to
the root port, root port component registers setup will failed.

The solution is delaying all CXL non-RCH dport component registers
enumeration until the first endpoint attaching.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/pci.c  |  8 +------
 drivers/cxl/core/port.c | 53 ++++++++++++++++++++++++++---------------
 drivers/cxl/cxl.h       |  1 +
 drivers/cxl/port.c      | 20 ++++++++++------
 4 files changed, 49 insertions(+), 33 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d58ab9d33c5..3b22f3033484 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -37,10 +37,8 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 	struct cxl_walk_context *ctx = data;
 	struct cxl_port *port = ctx->port;
 	int type = pci_pcie_type(pdev);
-	struct cxl_register_map map;
 	struct cxl_dport *dport;
 	u32 lnkcap, port_num;
-	int rc;
 
 	if (pdev->bus != ctx->bus)
 		return 0;
@@ -52,12 +50,8 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 				  &lnkcap))
 		return 0;
 
-	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
-	if (rc)
-		dev_dbg(&port->dev, "failed to find component registers\n");
-
 	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
+	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
 	if (IS_ERR(dport)) {
 		ctx->error = PTR_ERR(dport);
 		return PTR_ERR(dport);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b406ba64f6bc..04617ab825ee 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -626,6 +626,8 @@ static void unregister_port(void *_port)
 		lock_dev = &parent->dev;
 
 	device_lock_assert(lock_dev);
+	if (port->parent_dport && !port->parent_dport->rch)
+		cxl_register_map_reset(&port->parent_dport->reg_map);
 	port->dead = true;
 	device_unregister(&port->dev);
 }
@@ -820,13 +822,39 @@ int cxl_port_setup_regs(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_port_setup_regs, "CXL");
 
-static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
-				resource_size_t component_reg_phys)
+/**
+ * cxl_dport_setup_regs - probe all component registers of a cxl dport
+ * @dport: target cxl dport
+ */
+int cxl_dport_setup_regs(struct cxl_dport *dport)
 {
+	resource_size_t component_reg_phys;
+	struct device *host;
 	int rc;
 
 	if (dev_is_platform(dport->dport_dev))
 		return 0;
+	/* component registers have been set up */
+	if (dport->reg_map.resource != CXL_RESOURCE_NONE)
+		return 0;
+
+	if (dport->rcrb.base) {
+		component_reg_phys = __rcrb_to_component(dport->dport_dev, &dport->rcrb,
+							 CXL_RCRB_DOWNSTREAM);
+		host = NULL;
+	} else {
+		component_reg_phys = find_component_registers(dport->dport_dev);
+		host = &dport->port->dev;
+	}
+
+	if (component_reg_phys == CXL_RESOURCE_NONE) {
+		dev_warn(dport->dport_dev, "Invalid Component Registers%s",
+			 dport->rcrb.base ? " in RCRB" : "");
+		return -ENXIO;
+	}
+
+	dev_dbg(dport->dport_dev, "Component Registers found for dport: %pa\n",
+		&component_reg_phys);
 
 	/*
 	 * use @dport->dport_dev for the context for error messages during
@@ -838,6 +866,7 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	dport->reg_map.host = host;
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dport_setup_regs, "CXL");
 
 DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
 
@@ -1176,39 +1205,25 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (!dport)
 		return ERR_PTR(-ENOMEM);
 
+	cxl_register_map_reset(&dport->reg_map);
 	dport->dport_dev = dport_dev;
 	dport->port_id = port_id;
 	dport->port = port;
 
-	if (rcrb == CXL_RESOURCE_NONE) {
-		rc = cxl_dport_setup_regs(&port->dev, dport,
-					  component_reg_phys);
-		if (rc)
-			return ERR_PTR(rc);
-	} else {
+	if (rcrb != CXL_RESOURCE_NONE) {
 		dport->rcrb.base = rcrb;
-		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
-							 CXL_RCRB_DOWNSTREAM);
-		if (component_reg_phys == CXL_RESOURCE_NONE) {
-			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
-			return ERR_PTR(-ENXIO);
-		}
 
 		/*
 		 * RCH @dport is not ready to map until associated with its
 		 * memdev
 		 */
-		rc = cxl_dport_setup_regs(NULL, dport, component_reg_phys);
+		rc = cxl_dport_setup_regs(dport);
 		if (rc)
 			return ERR_PTR(rc);
 
 		dport->rch = true;
 	}
 
-	if (component_reg_phys != CXL_RESOURCE_NONE)
-		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
-			&component_reg_phys);
-
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7763be02ef81..601818861441 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -773,6 +773,7 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 resource_size_t rcrb);
 
 int cxl_port_setup_regs(struct cxl_port *port);
+int cxl_dport_setup_regs(struct cxl_dport *dport);
 
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c59f198f6cb0..ec135628edcb 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -100,7 +100,7 @@ static int cxl_switch_port_setup_hdm(struct cxl_port *port)
 	return -ENXIO;
 }
 
-static int cxl_switch_port_setup(struct cxl_port *port)
+static int cxl_switch_port_setup(struct cxl_port *port, struct cxl_dport *dport)
 {
 	int rc;
 
@@ -108,12 +108,16 @@ static int cxl_switch_port_setup(struct cxl_port *port)
 	if (rc)
 		return rc;
 
-	return cxl_switch_port_setup_hdm(port);
+	rc = cxl_switch_port_setup_hdm(port);
+	if (rc)
+		return rc;
+
+	return cxl_dport_setup_regs(dport);
 }
 
 static int cxl_endpoint_port_probe(struct cxl_port *port)
 {
-	struct cxl_port *iter, *parent_port = to_cxl_port(port->dev.parent);
+	struct cxl_port *iter, *prev, *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_endpoint_dvsec_info info = { .port = port };
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -121,8 +125,10 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_port *root;
 	int rc;
 
-	for (iter = parent_port; !is_cxl_root(iter);
-	     iter = to_cxl_port(iter->dev.parent)) {
+	for (iter = parent_port, prev = NULL; !is_cxl_root(iter);
+	     prev = iter, iter = to_cxl_port(iter->dev.parent)) {
+		struct cxl_dport *dport = prev ? prev->parent_dport :
+					port->parent_dport;
 		/*
 		 * The parent port of endpoint has been locked
 		 * during endpoint port attaching.
@@ -131,9 +137,9 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		 */
 		if (iter != parent_port) {
 			guard(device)(&iter->dev);
-			rc = cxl_switch_port_setup(iter);
+			rc = cxl_switch_port_setup(iter, dport);
 		} else {
-			rc = cxl_switch_port_setup(iter);
+			rc = cxl_switch_port_setup(iter, dport);
 		}
 		if (rc)
 			return rc;
-- 
2.34.1

