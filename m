Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBA161FDA
	for <linux-cxl@vger.kernel.org>; Tue, 13 Aug 2024 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534568; cv=none; b=U0GcMRRF6aJxWNRnxrj/UKM833U1/3ZcBfbPHrvmB8jyYDQ9RiOodSzFs2uMxT6myPs9mB29b94IpcuKhL/wzmiRT31RSsuD7NAIrh+yUPEE48+9qe2YgwfEQKhKayMJInhTvIWrfGFmxlBo975oLh0ub+A64l2Jqnqk3Oa/+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534568; c=relaxed/simple;
	bh=3zonyNo79bDkhNWhWfUBmDsC2ua1HvMKBZWz1unBAy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DsC5EsdTZDYKAVWRX3cv7RocJgU06IlCWx393wTtDyIsT8MlLi+j9s3rJT/idQCV3XZwa78mZSArpL3GnLzJ3y6L84vz3hq82ECSrMywoR/Uki3gUVF2ruStT0+rWRJfJI00wKpoyWansTpe3C/eF2Dvsehdj1E5Fze/dGLwlfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMJtN5+h; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMJtN5+h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723534566; x=1755070566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3zonyNo79bDkhNWhWfUBmDsC2ua1HvMKBZWz1unBAy8=;
  b=CMJtN5+hxJ99ZXsXaqo/3G200KkQlWlCEl0H6BWd8YkhVGu9LROEAFK3
   XYNnl5cfSc9ZTJaA+dPmVCSGWwiz+BY8mGR/gvjX3CAnzDkfIRGTepd7B
   96UvJkjHwubngaDPQVPURdNC4gCtuvZovWMSGSwdD4M/WQveP7a4xFtno
   5hA0oP/EiRsHpO2I8asxDy9if6qFrzkYb/PT8cnmKX8Wn/okQGBF3lbHw
   YAMiX36PQp/ROPPJxVN+t9O19YaLLb+eimy8HOv11Dqvsh8/gZIuX4NQ/
   DoA9DJfs1M925Choa/lBDPykZKr2lB3W42JgQN18YdJKmdtLBG48YPQgO
   A==;
X-CSE-ConnectionGUID: TL/ZrJcWTQuh/t5sZ+TGrw==
X-CSE-MsgGUID: 45Mx6O43RNC9+tlXEjlO1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="24588498"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="24588498"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:36:06 -0700
X-CSE-ConnectionGUID: pUCu0fTMQ1m+1uZo/H1Xkg==
X-CSE-MsgGUID: Y3xiJxAFRjGDA+/C2Fe+bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58525600"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:36:04 -0700
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
Subject: [PATCH 2/3] cxl/port: Use scoped_guard() to drop device_lock()/unlock pair
Date: Tue, 13 Aug 2024 07:05:51 +0000
Message-Id: <20240813070552.3353530-2-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240813070552.3353530-1-ming4.li@intel.com>
References: <20240813070552.3353530-1-ming4.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A device_lock() and device_unlock() pair can be replaced by a
scope-based resource management function scoped_guard() which can make
the code more readable and safer. Some device_lock() and device_unlock()
pairs in CXL subsystem can be simply replaced by a scoped_guard().

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/cxl/core/mbox.c   | 26 ++++++------
 drivers/cxl/core/port.c   | 87 ++++++++++++++++++---------------------
 drivers/cxl/core/region.c | 25 ++++++-----
 drivers/cxl/mem.c         | 22 +++++-----
 drivers/cxl/pmem.c        | 16 ++++---
 5 files changed, 82 insertions(+), 94 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e5cdeafdf76e..a8ab5f2697be 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1214,19 +1214,19 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	int rc;
 
 	/* synchronize with cxl_mem_probe() and decoder write operations */
-	device_lock(&cxlmd->dev);
-	endpoint = cxlmd->endpoint;
-	down_read(&cxl_region_rwsem);
-	/*
-	 * Require an endpoint to be safe otherwise the driver can not
-	 * be sure that the device is unmapped.
-	 */
-	if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
-		rc = __cxl_mem_sanitize(mds, cmd);
-	else
-		rc = -EBUSY;
-	up_read(&cxl_region_rwsem);
-	device_unlock(&cxlmd->dev);
+	scoped_guard(device, &cxlmd->dev) {
+		endpoint = cxlmd->endpoint;
+		down_read(&cxl_region_rwsem);
+		/*
+		 * Require an endpoint to be safe otherwise the driver can not
+		 * be sure that the device is unmapped.
+		 */
+		if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
+			rc = __cxl_mem_sanitize(mds, cmd);
+		else
+			rc = -EBUSY;
+		up_read(&cxl_region_rwsem);
+	}
 
 	return rc;
 }
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6119cb3ad25c..53e2593daa95 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1260,14 +1260,12 @@ static int add_ep(struct cxl_ep *new)
 	struct cxl_port *port = new->dport->port;
 	int rc;
 
-	device_lock(&port->dev);
-	if (port->dead) {
-		device_unlock(&port->dev);
-		return -ENXIO;
+	scoped_guard(device, &port->dev) {
+		if (port->dead)
+			return -ENXIO;
+		rc = xa_insert(&port->endpoints, (unsigned long)new->ep, new,
+			       GFP_KERNEL);
 	}
-	rc = xa_insert(&port->endpoints, (unsigned long)new->ep, new,
-		       GFP_KERNEL);
-	device_unlock(&port->dev);
 
 	return rc;
 }
@@ -1393,14 +1391,14 @@ static void delete_endpoint(void *data)
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
@@ -1562,40 +1560,36 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
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
 
-	port = find_cxl_port_at(parent_port, dport_dev, &dport);
-	if (!port) {
-		component_reg_phys = find_component_registers(uport_dev);
-		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
-					 component_reg_phys, parent_dport);
-		/* retry find to pick up the new dport information */
-		if (!IS_ERR(port))
+		port = find_cxl_port_at(parent_port, dport_dev, &dport);
+		if (!port) {
+			component_reg_phys = find_component_registers(uport_dev);
+			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
+						 component_reg_phys, parent_dport);
+			if (IS_ERR(port))
+				return PTR_ERR(port);
+
+			/* retry find to pick up the new dport information */
 			port = find_cxl_port_at(parent_port, dport_dev, &dport);
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
@@ -1986,9 +1980,8 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 
 	port = to_cxl_port(cxld->dev.parent);
 
-	device_lock(&port->dev);
-	rc = cxl_decoder_add_locked(cxld, target_map);
-	device_unlock(&port->dev);
+	scoped_guard(device, &port->dev)
+		rc = cxl_decoder_add_locked(cxld, target_map);
 
 	return rc;
 }
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..a3ce7cbe5c6c 100644
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
@@ -3134,14 +3134,13 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
 	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
 		dev_name(dev));
 
-	device_lock(&cxl_nvb->dev);
-	if (cxl_nvb->dev.driver)
-		rc = devm_add_action_or_reset(&cxl_nvb->dev,
-					      cxlr_pmem_unregister, cxlr_pmem);
-	else
-		rc = -ENXIO;
-	device_unlock(&cxl_nvb->dev);
-
+	scoped_guard(device, &cxl_nvb->dev) {
+		if (cxl_nvb->dev.driver)
+			rc = devm_add_action_or_reset(&cxl_nvb->dev,
+						      cxlr_pmem_unregister, cxlr_pmem);
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

