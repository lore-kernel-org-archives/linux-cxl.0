Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD212B71
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 02:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983310; cv=none; b=IzJQ4kOqIkLNr/07DTfgQJTQy5jpc7e70GMnow82yelypLqo5dEd1eLz5Rs79TCkCy6TYoryOy8lPpqOM8Nm/oTuzqhK/TpN/wyRUxc3HfaP8ytU8q/bUVGl51aPGWSGAdGCR/iYp8z2MhBSq4Nss8iIVS/k81dI+PtxrlVy4Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983310; c=relaxed/simple;
	bh=fwilON6PW2qxiM48LCAuF2ZCedsqiAso2p6jGbhN2Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mUpTa/VtiKDHgcn/0cqPhO9EC53Ld6MAexes2joKKeNNaYq6RIzPSVD+Ng14EYZC1/NQGrtYEGwKe+6/qhG4QxAMPD9N8niiAOUUwGTAovqPiIPtz3ryl4uo+NuKACZxlro5Sk0coT17yXlIRUBvKecx5lnWSlzwuu7PSFRRmwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRTvdh8a; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRTvdh8a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724983308; x=1756519308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fwilON6PW2qxiM48LCAuF2ZCedsqiAso2p6jGbhN2Tg=;
  b=mRTvdh8a4qmGRj6N67yedtVE+6WDx81gf0lPiQUayGZr60975x7yeypA
   bOjJWNLy7nz4kOTowiHwU60bq3svgX8GS/ux3XosSZt3zSObQh+i3aBAe
   xAjYko6pGDBrR0f7wmsH9AnhRdCq4onSvKlv/0eZqt3WlFsr78P8Yc20v
   8966bDlALcIM31EJwqSmVtRP+gyGhax0BYXJsoC3FQuaB34Btwd10qp3U
   eD32AyvYaTiwzU2tS1QT3bk+ruzfYb9xZy8Ukl/1isDH7KdJY7oKbNiU+
   rvqbngLY0MqZ0gyDYDoQ9Lp7Quf9vcNkmHLjz18+UaPbd9aJW7w6Uyfyp
   w==;
X-CSE-ConnectionGUID: lnKFL44mRkinrRG0wYc+LQ==
X-CSE-MsgGUID: z3cIpG4jR9uM3GN5WbYOtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="46122218"
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="46122218"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 19:01:48 -0700
X-CSE-ConnectionGUID: iJ+2Ob7QQg+zuz5tRg8oTQ==
X-CSE-MsgGUID: fwE+c1e9RCShhoZ4kv5ibQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="101267097"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 19:01:46 -0700
From: Li Ming <ming4.li@intel.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	Li Ming <ming4.li@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 2/3] cxl/port: Use scoped_guard()/guard() to drop device_lock() for cxl_port
Date: Fri, 30 Aug 2024 01:31:37 +0000
Message-Id: <20240830013138.2256244-2-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240830013138.2256244-1-ming4.li@intel.com>
References: <20240830013138.2256244-1-ming4.li@intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
index ffd322aaed42..d02fb85e8c8d 100644
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
@@ -1565,40 +1560,38 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	 * dereferencing the device of the port before the parent_port releasing.
 	 */
 	struct cxl_port *port __free(put_cxl_port) = NULL;
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
@@ -1979,7 +1972,6 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_add_locked, CXL);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 {
 	struct cxl_port *port;
-	int rc;
 
 	if (WARN_ON_ONCE(!cxld))
 		return -EINVAL;
@@ -1989,11 +1981,8 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 
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

