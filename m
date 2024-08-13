Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6134963A
	for <linux-cxl@vger.kernel.org>; Tue, 13 Aug 2024 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534566; cv=none; b=nFSjhvXeIwyuBenD4VpH3G1MdMXCrPC0Kuf0TJ6b7Vk7hKX95J7hr5zCKnhS2d4Pd5uvPiO1RBPSTiCeM74iEsUUrPgOX9n/OmlQ4nogschuO+pMJLtRiWRmc0ASxFExKh2mrxuOUMEeWYVNWEsUht9rGH1mSqUwg7ay0MixLbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534566; c=relaxed/simple;
	bh=qkCCzMKvIVo7gJTKoEPhqTEwqbKBYk+u3Ll82XoY5ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ShXclB43Dg9XcBtxayJTvxuRTkJvXovNx/9+GJIYSDj97hFz7NQhR+sEGO2EgA7c0HZ/N3V8y0twCPVZA+Y4vW/bSq6+gi3NTpe1Xkx3tS4b8OPsd3kGbMQTzWEPPTpRnhurwdy9/DcuNimWDNIeA3Ji8mxBdJseYreJV+uPPHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EypcZTle; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EypcZTle"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723534564; x=1755070564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qkCCzMKvIVo7gJTKoEPhqTEwqbKBYk+u3Ll82XoY5ZQ=;
  b=EypcZTleB0WfkoPCVi4v9luB8HULiKDMPsOFvuK3o3ntRYUPQ7UgdiyE
   4N6bCVEz2BIR8vSLk68+v+Rq5ks2/gSt2LCVnmbtkiiOlwiRDW3d+k97b
   Np2XdYrvJJXUa55ekqf5NUKj4aRdiJ/J33IuCI8haO4IAmoNRJIi2N808
   TEOuVqXKhZyPXJgINX/DNvDR4vxK/eoRSjV9MSKKeCRR2QS0P2TBIByjz
   cEx1x8jy7UCiBLfVL4srP2nf8R1xu5mjGPIirLK5Mrk5q/CXXnC5BL0Lr
   iOf1UVIlcgJeY1uFYpMF+hjyJ2ZlkpDQo86EikA0Vj0AfissYar+tgFQs
   w==;
X-CSE-ConnectionGUID: 8dETtUulRQiSbtOB6Eth3A==
X-CSE-MsgGUID: c7MFVrBqRvmRPduB3thdCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="24588493"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="24588493"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:36:04 -0700
X-CSE-ConnectionGUID: oCW/xDJuQuK6GJHxtylJmw==
X-CSE-MsgGUID: VOVGSfZoS9G9+7m5yOY/ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58525596"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:36:01 -0700
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
Subject: [PATCH 1/3] cxl/port: Use __free() to drop put_device() for cxl_port
Date: Tue, 13 Aug 2024 07:05:50 +0000
Message-Id: <20240813070552.3353530-1-ming4.li@intel.com>
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
dereference the 'struct device' of a cxl_port.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/cxl/core/pci.c  |  6 ++----
 drivers/cxl/core/port.c | 25 +++++++++----------------
 drivers/cxl/cxl.h       |  2 ++
 drivers/cxl/mem.c       |  5 ++---
 drivers/cxl/pci.c       |  7 ++-----
 5 files changed, 17 insertions(+), 28 deletions(-)

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
index 1d5007e3795a..6119cb3ad25c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1472,7 +1472,7 @@ static void cxl_detach_ep(void *data)
 	struct cxl_memdev *cxlmd = data;
 
 	for (int i = cxlmd->depth - 1; i >= 1; i--) {
-		struct cxl_port *port, *parent_port;
+		struct cxl_port *parent_port;
 		struct detach_ctx ctx = {
 			.cxlmd = cxlmd,
 			.depth = i,
@@ -1485,7 +1485,7 @@ static void cxl_detach_ep(void *data)
 				      port_has_memdev);
 		if (!dev)
 			continue;
-		port = to_cxl_port(dev);
+		struct cxl_port *port __free(put_cxl_port) = to_cxl_port(dev);
 
 		parent_port = to_cxl_port(port->dev.parent);
 		device_lock(&parent_port->dev);
@@ -1512,7 +1512,6 @@ static void cxl_detach_ep(void *data)
 				dev_name(&port->dev));
 			delete_switch_port(port);
 		}
-		put_device(&port->dev);
 		device_unlock(&parent_port->dev);
 	}
 }
@@ -1539,8 +1538,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			      struct device *uport_dev,
 			      struct device *dport_dev)
 {
+	struct cxl_port *port __free(put_cxl_port) = NULL;
 	struct device *dparent = grandparent(dport_dev);
-	struct cxl_port *port, *parent_port = NULL;
 	struct cxl_dport *dport, *parent_dport;
 	resource_size_t component_reg_phys;
 	int rc;
@@ -1556,7 +1555,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		return -ENXIO;
 	}
 
-	parent_port = find_cxl_port(dparent, &parent_dport);
+	struct cxl_port *parent_port __free(put_cxl_port) =
+		find_cxl_port(dparent, &parent_dport);
 	if (!parent_port) {
 		/* iterate to create this parent_port */
 		return -EAGAIN;
@@ -1596,10 +1596,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			 */
 			rc = -ENXIO;
 		}
-		put_device(&port->dev);
 	}
 
-	put_device(&parent_port->dev);
 	return rc;
 }
 
@@ -1630,7 +1628,6 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 		struct device *dport_dev = grandparent(iter);
 		struct device *uport_dev;
 		struct cxl_dport *dport;
-		struct cxl_port *port;
 
 		/*
 		 * The terminal "grandparent" in PCI is NULL and @platform_bus
@@ -1649,7 +1646,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
 			dev_name(iter), dev_name(dport_dev),
 			dev_name(uport_dev));
-		port = find_cxl_port(dport_dev, &dport);
+		struct cxl_port *port __free(put_cxl_port) =
+			find_cxl_port(dport_dev, &dport);
 		if (port) {
 			dev_dbg(&cxlmd->dev,
 				"found already registered port %s:%s\n",
@@ -1664,18 +1662,13 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
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
index 9afb407d438f..cad297fba700 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -744,6 +744,8 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
 void put_cxl_root(struct cxl_root *cxl_root);
 DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
 
+DEFINE_FREE(put_cxl_port, struct cxl_port *,
+	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
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

