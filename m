Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B8513AD3F
	for <linux-cxl@vger.kernel.org>; Mon, 26 Aug 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662882; cv=none; b=m/UjxoXBEdwveSalRo0f+kUDW+fcZtn/pt6MG22bvQNSw9lTIa6iRLXxMFULv9W4ZKoGzWpOBweOe3iGtLl+pQ2txUos5WdcXq1n5KUO22hYFjGiYpBg0T08KlEILJFf7qFbTIjtBl2yoj0/RM3WUyjV5s268NvDAQIlm5Png1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662882; c=relaxed/simple;
	bh=KSF6fghZFI0nvIWmC9N8+8VVHqN3oLJKucuVkjYAaV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q/cvnYdBkk15F8vgfLdWrG5zdXk1NnFy6PRhvxv5M/1//VTarBeEnOi8/uRYVVrVkm4aelJPVfWUfb8gpoPB0r+pu2tcULQxJdNppNbJ1J+LpQbrynQxggfb9XMTHnynEV2f339F5sDR5xjnsBXBoTIPzoNbVb/xvRQU5wCbqns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdA9Ltcq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdA9Ltcq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724662881; x=1756198881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KSF6fghZFI0nvIWmC9N8+8VVHqN3oLJKucuVkjYAaV0=;
  b=gdA9Ltcq4Y8L8AgWdNoTq4zjvvu+Oc3t3lNRxrp5Y3q9leNNpCEBV29t
   AYt2MMSHVVCBCABcV9MaoU8g6DubJKFcy8iDSdXvHBGSdjFbG73icr1z2
   B2gLd68ku0M66TnKHrRD5oH4YMGSR7e2RNmB0g2SJbD7wp6mZoVoL3efr
   //L8u50wgS80aRDkmkNflQKZPBSQ4mbCIyyfnmSKAa79jsCSIEQCXPsVY
   p69BHBQbHYfQTSQ/9bz430uVmxpCSJaz0KNpm4XBEvtNyKvTjqxF+hDJT
   ABvP144hQREpYKlNZGC8XNu0QFJrNGCVoXryrjc6po3TF5IVonQfJSgaI
   A==;
X-CSE-ConnectionGUID: 16DixPNWSGqoWLsQznRvcQ==
X-CSE-MsgGUID: VIlM0tivSryr3d0XCa3WxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="33737713"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="33737713"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 02:01:20 -0700
X-CSE-ConnectionGUID: 2eSBGo6PTAGFGiwEG1KPCQ==
X-CSE-MsgGUID: 8zmyfklPQx26weWpzeNRYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="66617145"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 02:01:18 -0700
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
Subject: [PATCH v2 2/3] cxl/port: Use scoped_guard()/guard() to drop device_lock() for cxl_port
Date: Mon, 26 Aug 2024 08:30:57 +0000
Message-Id: <20240826083058.1509232-2-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240826083058.1509232-1-ming4.li@intel.com>
References: <20240826083058.1509232-1-ming4.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A device_lock() and device_unlock() pair can be replaced by a cleanup
helper scoped_guard() or guard(), that can enhance code readability. In
CXL subsystem, still use device_lock() and device_unlock() pairs for cxl
port resource protection, most of them can be replaced by a
scoped_guard() or a guard() simply.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/cxl/core/mbox.c   |  3 +-
 drivers/cxl/core/port.c   | 93 +++++++++++++++++----------------------
 drivers/cxl/core/region.c | 25 ++++++-----
 drivers/cxl/mem.c         | 22 +++++----
 drivers/cxl/pmem.c        | 16 +++----
 5 files changed, 72 insertions(+), 87 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e5cdeafdf76e..0a913b30c7fc 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1214,7 +1214,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	int rc;
 
 	/* synchronize with cxl_mem_probe() and decoder write operations */
-	device_lock(&cxlmd->dev);
+	guard(device)(&cxlmd->dev);
 	endpoint = cxlmd->endpoint;
 	down_read(&cxl_region_rwsem);
 	/*
@@ -1226,7 +1226,6 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	else
 		rc = -EBUSY;
 	up_read(&cxl_region_rwsem);
-	device_unlock(&cxlmd->dev);
 
 	return rc;
 }
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b50dda6610e3..7b87b5142fa7 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1258,18 +1258,13 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_rch_dport, CXL);
 static int add_ep(struct cxl_ep *new)
 {
 	struct cxl_port *port = new->dport->port;
-	int rc;
 
-	device_lock(&port->dev);
-	if (port->dead) {
-		device_unlock(&port->dev);
+	guard(device)(&port->dev);
+	if (port->dead)
 		return -ENXIO;
-	}
-	rc = xa_insert(&port->endpoints, (unsigned long)new->ep, new,
-		       GFP_KERNEL);
-	device_unlock(&port->dev);
 
-	return rc;
+	return xa_insert(&port->endpoints, (unsigned long)new->ep,
+			 new, GFP_KERNEL);
 }
 
 /**
@@ -1393,14 +1388,14 @@ static void delete_endpoint(void *data)
 	struct cxl_port *endpoint = cxlmd->endpoint;
 	struct device *host = endpoint_host(endpoint);
 
-	device_lock(host);
-	if (host->driver && !endpoint->dead) {
-		devm_release_action(host, cxl_unlink_parent_dport, endpoint);
-		devm_release_action(host, cxl_unlink_uport, endpoint);
-		devm_release_action(host, unregister_port, endpoint);
+	scoped_guard(device, host) {
+		if (host->driver && !endpoint->dead) {
+			devm_release_action(host, cxl_unlink_parent_dport, endpoint);
+			devm_release_action(host, cxl_unlink_uport, endpoint);
+			devm_release_action(host, unregister_port, endpoint);
+		}
+		cxlmd->endpoint = NULL;
 	}
-	cxlmd->endpoint = NULL;
-	device_unlock(host);
 	put_device(&endpoint->dev);
 	put_device(host);
 }
@@ -1561,40 +1556,38 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		return -EAGAIN;
 	}
 
-	device_lock(&parent_port->dev);
-	if (!parent_port->dev.driver) {
-		dev_warn(&cxlmd->dev,
-			 "port %s:%s disabled, failed to enumerate CXL.mem\n",
-			 dev_name(&parent_port->dev), dev_name(uport_dev));
-		port = ERR_PTR(-ENXIO);
-		goto out;
-	}
+	scoped_guard(device, &parent_port->dev) {
+		if (!parent_port->dev.driver) {
+			dev_warn(&cxlmd->dev,
+				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
+				 dev_name(&parent_port->dev), dev_name(uport_dev));
+			return -ENXIO;
+		}
+
+		port = find_cxl_port_at(parent_port, dport_dev, &dport);
+		if (!port) {
+			component_reg_phys = find_component_registers(uport_dev);
+			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
+						 component_reg_phys, parent_dport);
+			if (IS_ERR(port))
+				return PTR_ERR(port);
 
-	port = find_cxl_port_at(parent_port, dport_dev, &dport);
-	if (!port) {
-		component_reg_phys = find_component_registers(uport_dev);
-		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
-					 component_reg_phys, parent_dport);
-		/* retry find to pick up the new dport information */
-		if (!IS_ERR(port))
+			/* retry find to pick up the new dport information */
 			port = find_cxl_port_at(parent_port, dport_dev, &dport);
+			if (!port)
+				return -ENXIO;
+		}
 	}
-out:
-	device_unlock(&parent_port->dev);
 
-	if (IS_ERR(port))
-		rc = PTR_ERR(port);
-	else {
-		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
-			dev_name(&port->dev), dev_name(port->uport_dev));
-		rc = cxl_add_ep(dport, &cxlmd->dev);
-		if (rc == -EBUSY) {
-			/*
-			 * "can't" happen, but this error code means
-			 * something to the caller, so translate it.
-			 */
-			rc = -ENXIO;
-		}
+	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
+		dev_name(&port->dev), dev_name(port->uport_dev));
+	rc = cxl_add_ep(dport, &cxlmd->dev);
+	if (rc == -EBUSY) {
+		/*
+		 * "can't" happen, but this error code means
+		 * something to the caller, so translate it.
+		 */
+		rc = -ENXIO;
 	}
 
 	return rc;
@@ -1975,7 +1968,6 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_add_locked, CXL);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 {
 	struct cxl_port *port;
-	int rc;
 
 	if (WARN_ON_ONCE(!cxld))
 		return -EINVAL;
@@ -1985,11 +1977,8 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 
 	port = to_cxl_port(cxld->dev.parent);
 
-	device_lock(&port->dev);
-	rc = cxl_decoder_add_locked(cxld, target_map);
-	device_unlock(&port->dev);
-
-	return rc;
+	guard(device)(&port->dev);
+	return cxl_decoder_add_locked(cxld, target_map);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, CXL);
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..9a7c001eff1e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3094,11 +3094,11 @@ static void cxlr_release_nvdimm(void *_cxlr)
 	struct cxl_region *cxlr = _cxlr;
 	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
 
-	device_lock(&cxl_nvb->dev);
-	if (cxlr->cxlr_pmem)
-		devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
-				    cxlr->cxlr_pmem);
-	device_unlock(&cxl_nvb->dev);
+	scoped_guard(device, &cxl_nvb->dev) {
+		if (cxlr->cxlr_pmem)
+			devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
+					    cxlr->cxlr_pmem);
+	}
 	cxlr->cxl_nvb = NULL;
 	put_device(&cxl_nvb->dev);
 }
@@ -3134,13 +3134,14 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
 	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
 		dev_name(dev));
 
-	device_lock(&cxl_nvb->dev);
-	if (cxl_nvb->dev.driver)
-		rc = devm_add_action_or_reset(&cxl_nvb->dev,
-					      cxlr_pmem_unregister, cxlr_pmem);
-	else
-		rc = -ENXIO;
-	device_unlock(&cxl_nvb->dev);
+	scoped_guard(device, &cxl_nvb->dev) {
+		if (cxl_nvb->dev.driver)
+			rc = devm_add_action_or_reset(&cxl_nvb->dev,
+						      cxlr_pmem_unregister,
+						      cxlr_pmem);
+		else
+			rc = -ENXIO;
+	}
 
 	if (rc)
 		goto err_bridge;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index ab9b8ab8df44..ae94018a01bd 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -168,19 +168,17 @@ static int cxl_mem_probe(struct device *dev)
 
 	cxl_setup_parent_dport(dev, dport);
 
-	device_lock(endpoint_parent);
-	if (!endpoint_parent->driver) {
-		dev_err(dev, "CXL port topology %s not enabled\n",
-			dev_name(endpoint_parent));
-		rc = -ENXIO;
-		goto unlock;
-	}
+	scoped_guard(device, endpoint_parent) {
+		if (!endpoint_parent->driver) {
+			dev_err(dev, "CXL port topology %s not enabled\n",
+				dev_name(endpoint_parent));
+			return -ENXIO;
+		}
 
-	rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
-unlock:
-	device_unlock(endpoint_parent);
-	if (rc)
-		return rc;
+		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
+		if (rc)
+			return rc;
+	}
 
 	/*
 	 * The kernel may be operating out of CXL memory on this device,
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 4ef93da22335..647c7e25ef3a 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -233,15 +233,13 @@ static int detach_nvdimm(struct device *dev, void *data)
 	if (!is_cxl_nvdimm(dev))
 		return 0;
 
-	device_lock(dev);
-	if (!dev->driver)
-		goto out;
-
-	cxl_nvd = to_cxl_nvdimm(dev);
-	if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
-		release = true;
-out:
-	device_unlock(dev);
+	scoped_guard(device, dev) {
+		if (dev->driver) {
+			cxl_nvd = to_cxl_nvdimm(dev);
+			if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
+				release = true;
+		}
+	}
 	if (release)
 		device_release_driver(dev);
 	return 0;
-- 
2.40.1

