Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748428EC
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983308; cv=none; b=QS23osrHqCYHzG1XVyrL40UDR0THgCWiiKZz7+7vdlXjK5Q8XVVI2LSHCNMKjPZh/6agFIzp91hGGN7TQJjm0MW8O0xOcLBTU285SNhzcarSwi2FQVG6T/dT7wcW2k6ZlFc5oUb1MGV3KA4P0pQASz4MvdfVFtvnwRdjf4BjosA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983308; c=relaxed/simple;
	bh=zdCz3oy2OQmXxcxEMKbrgBfhEDXAElWP8tJ4bJAmWio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=midEamhagRd6owyVWM88qaP672UjuKRYrI7feAodcST8LRNdpmF+MOm+CKgoxyl4fm88LuwhH39SY2V8nQdGmR5+tzxLtv/vQKsWiE0LoF0okU/ZWXXg8e5vuYering50RmcvASLsaVWKsQeAG8NrWXZNEtQyPQu9f5fO/imeeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NViEIU8F; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NViEIU8F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724983306; x=1756519306;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zdCz3oy2OQmXxcxEMKbrgBfhEDXAElWP8tJ4bJAmWio=;
  b=NViEIU8F8jL2y3VT/I8XK5f59bAyQOcPLlNIWKBUOGe4yGsr79my2kDL
   hf1gkk8/t9gC/2a26wKdE3sMJXcLimM2XKXxix04BCm7K4QOTuviBnOgM
   P8OQMNVzuIreWUlONw1vmlP6dNGPtPVs4MxxTAlFuGWkMAPyQ01vD8Omy
   7CGBqt2ZaCq69bkxbi92FnKA5me/i+PeqRtmzN4jbHIvnVtwzvlnJEhSz
   p+7x0if8Zx48Th0LC8ESqSBQVcEd/tEiLGg7Gf3x9DxICs94tDi4FrljE
   ZAwmF9TnICy14Ggtz9FJtm28o1IkCF1FnjKI7A2p82etTc/CClgOffPpQ
   Q==;
X-CSE-ConnectionGUID: 4dOwM5DlRLyyT5kybOyDUg==
X-CSE-MsgGUID: 2dZOTuUpSMSedV0jp4mfkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="46122214"
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="46122214"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 19:01:45 -0700
X-CSE-ConnectionGUID: loqFmbKIRVaPXL4J4NEiCA==
X-CSE-MsgGUID: UubSgMV2TT++p5X4Xfo/Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="101267082"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 19:01:43 -0700
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
Subject: [PATCH v3 1/3] cxl/port: Use __free() to drop put_device() for cxl_port
Date: Fri, 30 Aug 2024 01:31:36 +0000
Message-Id: <20240830013138.2256244-1-ming4.li@intel.com>
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
v3:
- Jonathan: Keep the dereference sequence between port and parent port.
- Jonathan: Adjust the changelog of the patch 3.
Link to v2: https://lore.kernel.org/linux-cxl/0a815412-cd86-4d08-b93f-4ff4d88134c6@intel.com/T/#m49c20d7834114878c2e4ad03a55da8d4999caa59
v2:
- Use guard() instead of scoped_guard() in some cases.
- Ira: Check the return value of find_cxl_port_at().
Link to v1: https://lore.kernel.org/linux-cxl/8ac82c61-7871-4914-b376-32431868622c@intel.com/T/#m07695675435bf702311dfc40f64289b9623afa16
---
 drivers/cxl/core/pci.c  |  6 ++----
 drivers/cxl/core/port.c | 30 +++++++++++++-----------------
 drivers/cxl/cxl.h       |  1 +
 drivers/cxl/mem.c       |  5 ++---
 drivers/cxl/pci.c       |  7 ++-----
 5 files changed, 20 insertions(+), 29 deletions(-)

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
index 1d5007e3795a..ffd322aaed42 100644
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
@@ -1540,7 +1538,6 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			      struct device *dport_dev)
 {
 	struct device *dparent = grandparent(dport_dev);
-	struct cxl_port *port, *parent_port = NULL;
 	struct cxl_dport *dport, *parent_dport;
 	resource_size_t component_reg_phys;
 	int rc;
@@ -1556,12 +1553,18 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		return -ENXIO;
 	}
 
-	parent_port = find_cxl_port(dparent, &parent_dport);
+	struct cxl_port *parent_port __free(put_cxl_port) =
+		find_cxl_port(dparent, &parent_dport);
 	if (!parent_port) {
 		/* iterate to create this parent_port */
 		return -EAGAIN;
 	}
 
+	/*
+	 * Definition with __free() here to keep the sequence of
+	 * dereferencing the device of the port before the parent_port releasing.
+	 */
+	struct cxl_port *port __free(put_cxl_port) = NULL;
 	device_lock(&parent_port->dev);
 	if (!parent_port->dev.driver) {
 		dev_warn(&cxlmd->dev,
@@ -1596,10 +1599,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			 */
 			rc = -ENXIO;
 		}
-		put_device(&port->dev);
 	}
 
-	put_device(&parent_port->dev);
 	return rc;
 }
 
@@ -1630,7 +1631,6 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 		struct device *dport_dev = grandparent(iter);
 		struct device *uport_dev;
 		struct cxl_dport *dport;
-		struct cxl_port *port;
 
 		/*
 		 * The terminal "grandparent" in PCI is NULL and @platform_bus
@@ -1649,7 +1649,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
 			dev_name(iter), dev_name(dport_dev),
 			dev_name(uport_dev));
-		port = find_cxl_port(dport_dev, &dport);
+		struct cxl_port *port __free(put_cxl_port) =
+			find_cxl_port(dport_dev, &dport);
 		if (port) {
 			dev_dbg(&cxlmd->dev,
 				"found already registered port %s:%s\n",
@@ -1664,18 +1665,13 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
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

