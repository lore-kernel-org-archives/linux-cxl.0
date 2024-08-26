Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F684D25
	for <linux-cxl@vger.kernel.org>; Mon, 26 Aug 2024 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662880; cv=none; b=nmR/y2FkxulJ5LqcixhMk1JAMBPaGXANIW8HjcgU0btVqvZTxVcqerpdrrqiLoOrtbk9FokJLzkFLpP0YFONcQm+44hNwhSLU1+v6xzkD8FltbTyNJ3pp79SRgqdNSvVi8Jk6ngLFuCRuHqgBz6GJytXdG75qpm+13SKMj12ufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662880; c=relaxed/simple;
	bh=X96A8Up2/uvkBq+JES0UGlSdxMmyx9I7lj+XEHliEW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H0o9sVk6PX+r+euU2n1CMsI++haNKk8AZcte7mew+nvZAlV14QicL7Yly5l8ndVHavYM5PTfJBjcWbGaLVMFbih4njpqC7EcBOOwneyR1t+eGy56HAmhdZif5WZIN1iGzIlt0NXEqOWV4HBtcjOaDxpRAI7va9o+zoFJXMppULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxkx8uTW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxkx8uTW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724662879; x=1756198879;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X96A8Up2/uvkBq+JES0UGlSdxMmyx9I7lj+XEHliEW0=;
  b=gxkx8uTWiAaitG426X0kKMjFKU5W1iCzUiBu19CxkRC23uCYl0bow+Ci
   KGbm5XkfA/BY8e6N3HC1OHqHmh3pG8GX1999MLmdrpydpu8uPr5qBzYsZ
   YUvm+ce0GU0RYJwozxNT14tJWOVgRchrBqptlcZ5sjXH9kNEd5ZYuQoYy
   YumoG5vyuzZVxJ8TrCTsYxMJtOBBu3N3H494iTIZHH7HJioND2DQ73/sK
   GZz3g9w/zTUK4FZbzMY44iDT8k5PElCTt9tsZhu6WGve9/JWCkg1/p4E3
   +y1goKMhp+LpKY7w+VG1EoJaTRaY7b6rNjgCyT8wXN2e/FXNfGu3vRybO
   w==;
X-CSE-ConnectionGUID: 5NN+8HBcSumgy1L0RJQH6A==
X-CSE-MsgGUID: Omsf9Dj1R/imXbKHqpmmBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="33737699"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="33737699"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 02:01:18 -0700
X-CSE-ConnectionGUID: ctBYGKjJQHCDvR7mELjMfA==
X-CSE-MsgGUID: 4brhqtYNQR+D04/Y8kbYxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="66617120"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 02:01:16 -0700
From: Li Ming <ming4.li@intel.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	Li Ming <ming4.li@intel.com>
Subject: [PATCH v2 1/3] cxl/port: Use __free() to drop put_device() for cxl_port
Date: Mon, 26 Aug 2024 08:30:56 +0000
Message-Id: <20240826083058.1509232-1-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using scope-based resource management __free() marco with a new helper
called put_cxl_port() to drop open coded the put_device() used to
dereference the 'struct device' in cxl_port.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming4.li@intel.com>
---
v2:
- Use guard() instead of scoped_guard() in some cases.
- Ira: Check the return value of find_cxl_port_at().
Link to v1: https://lore.kernel.org/linux-cxl/8ac82c61-7871-4914-b376-32431868622c@intel.com/T/#m07695675435bf702311dfc40f64289b9623afa16
---
 drivers/cxl/core/pci.c  |  6 ++----
 drivers/cxl/core/port.c | 26 +++++++++-----------------
 drivers/cxl/cxl.h       |  1 +
 drivers/cxl/mem.c       |  5 ++---
 drivers/cxl/pci.c       |  7 ++-----
 5 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 51132a575b27..4725e37d90fb 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -915,15 +915,13 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	struct aer_capability_regs aer_regs;
 	struct cxl_dport *dport;
-	struct cxl_port *port;
 	int severity;
 
-	port = cxl_pci_find_port(pdev, &dport);
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
 	if (!port)
 		return;
 
-	put_device(&port->dev);
-
 	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
 		return;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..b50dda6610e3 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1477,12 +1477,11 @@ static void cxl_detach_ep(void *data)
 			.cxlmd = cxlmd,
 			.depth = i,
 		};
-		struct device *dev;
 		struct cxl_ep *ep;
 		bool died = false;
 
-		dev = bus_find_device(&cxl_bus_type, NULL, &ctx,
-				      port_has_memdev);
+		struct device *dev __free(put_device) =
+			bus_find_device(&cxl_bus_type, NULL, &ctx, port_has_memdev);
 		if (!dev)
 			continue;
 		port = to_cxl_port(dev);
@@ -1512,7 +1511,6 @@ static void cxl_detach_ep(void *data)
 				dev_name(&port->dev));
 			delete_switch_port(port);
 		}
-		put_device(&port->dev);
 		device_unlock(&parent_port->dev);
 	}
 }
@@ -1539,8 +1537,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			      struct device *uport_dev,
 			      struct device *dport_dev)
 {
+	struct cxl_port *port __free(put_cxl_port) = NULL;
 	struct device *dparent = grandparent(dport_dev);
-	struct cxl_port *port, *parent_port = NULL;
 	struct cxl_dport *dport, *parent_dport;
 	resource_size_t component_reg_phys;
 	int rc;
@@ -1556,7 +1554,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		return -ENXIO;
 	}
 
-	parent_port = find_cxl_port(dparent, &parent_dport);
+	struct cxl_port *parent_port __free(put_cxl_port) =
+		find_cxl_port(dparent, &parent_dport);
 	if (!parent_port) {
 		/* iterate to create this parent_port */
 		return -EAGAIN;
@@ -1596,10 +1595,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			 */
 			rc = -ENXIO;
 		}
-		put_device(&port->dev);
 	}
 
-	put_device(&parent_port->dev);
 	return rc;
 }
 
@@ -1630,7 +1627,6 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 		struct device *dport_dev = grandparent(iter);
 		struct device *uport_dev;
 		struct cxl_dport *dport;
-		struct cxl_port *port;
 
 		/*
 		 * The terminal "grandparent" in PCI is NULL and @platform_bus
@@ -1649,7 +1645,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
 			dev_name(iter), dev_name(dport_dev),
 			dev_name(uport_dev));
-		port = find_cxl_port(dport_dev, &dport);
+		struct cxl_port *port __free(put_cxl_port) =
+			find_cxl_port(dport_dev, &dport);
 		if (port) {
 			dev_dbg(&cxlmd->dev,
 				"found already registered port %s:%s\n",
@@ -1664,18 +1661,13 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			 * the parent_port lock as the current port may be being
 			 * reaped.
 			 */
-			if (rc && rc != -EBUSY) {
-				put_device(&port->dev);
+			if (rc && rc != -EBUSY)
 				return rc;
-			}
 
 			/* Any more ports to add between this one and the root? */
-			if (!dev_is_cxl_root_child(&port->dev)) {
-				put_device(&port->dev);
+			if (!dev_is_cxl_root_child(&port->dev))
 				continue;
-			}
 
-			put_device(&port->dev);
 			return 0;
 		}
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9afb407d438f..84cf3b4d60a1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -744,6 +744,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
 void put_cxl_root(struct cxl_root *cxl_root);
 DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
 
+DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 7de232eaeb17..ab9b8ab8df44 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -109,7 +109,6 @@ static int cxl_mem_probe(struct device *dev)
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *endpoint_parent;
-	struct cxl_port *parent_port;
 	struct cxl_dport *dport;
 	struct dentry *dentry;
 	int rc;
@@ -146,7 +145,8 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	parent_port = cxl_mem_find_port(cxlmd, &dport);
+	struct cxl_port *parent_port __free(put_cxl_port) =
+		cxl_mem_find_port(cxlmd, &dport);
 	if (!parent_port) {
 		dev_err(dev, "CXL port topology not found\n");
 		return -ENXIO;
@@ -179,7 +179,6 @@ static int cxl_mem_probe(struct device *dev)
 	rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
 unlock:
 	device_unlock(endpoint_parent);
-	put_device(&parent_port->dev);
 	if (rc)
 		return rc;
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4be35dc22202..26e75499abdd 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -473,7 +473,6 @@ static bool is_cxl_restricted(struct pci_dev *pdev)
 static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 				  struct cxl_register_map *map)
 {
-	struct cxl_port *port;
 	struct cxl_dport *dport;
 	resource_size_t component_reg_phys;
 
@@ -482,14 +481,12 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 		.resource = CXL_RESOURCE_NONE,
 	};
 
-	port = cxl_pci_find_port(pdev, &dport);
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
 	if (!port)
 		return -EPROBE_DEFER;
 
 	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
-
-	put_device(&port->dev);
-
 	if (component_reg_phys == CXL_RESOURCE_NONE)
 		return -ENXIO;
 
-- 
2.40.1

