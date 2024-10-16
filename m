Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569014EC47
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729121049; cv=none; b=N/TUb4Ftnwt59I2NAXM/Q5ftrruozyeot3kXc5glgyKthKAQmW/YcANoU1sdr14HNabV+NN3ZKAnDn4ZAhlKlae5JuqCk+xR41BLjE4Tw05mW7jlpJiG8vceakHB+WpMEZeT5QR1HJs6lacogEUgX/nEde9SmCvSl4zVeKg/R7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729121049; c=relaxed/simple;
	bh=LaJASfqitH6xo46P8bMGN6tperndhZxXqmJI+u9mIVc=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=owUbmTtN79Pqs9xlot8MiSRfpb0KjSTYlK0mfDaX1TH5FMS7dSckT++SGBzmjJ18Fdvk5iT6H+R9FQbeJWTaIz1eHQMzBArB0ToRCb/QH6FlytCtl5l1Mt/cZ9GRBT4pZQA2P4RNDu8nhg3TWaNydVqnPbW8+pkIsDtfDcDBk44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5P7rGiO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5P7rGiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729121047; x=1760657047;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LaJASfqitH6xo46P8bMGN6tperndhZxXqmJI+u9mIVc=;
  b=g5P7rGiOLg/MGYsfXJFsU0lgp4Z+j8FpTGmHlIZvDoyf6f9kSSRxTDRO
   SHFqCPqlNZyT67ZKlhS//JrydhoOhtbyj1nBSxqyeKJO9MYBPWd7Ryriv
   tlshHi52Im9gMg+pIoUAvA0mEZiy2eL/l8zZbYq3PjDqDX8XkBgKuZM2f
   Ad+y9I3rNLnsorcna4fQzfGcL31ueNYKrJTiXT0zOlmfG9oh1aOrqPTUs
   P29gJ5ARb5ubGdoFCZlzQVkUA9o2l4fm2bHilZTugCGYoZQLfNbGF7J3w
   hANopBfOox48TTKHqlGcR+ylSMfYy6tg3fKqzlDRyPk2eaWeHmbqA46TQ
   Q==;
X-CSE-ConnectionGUID: KadigyTeRsS4pTTNKmM06A==
X-CSE-MsgGUID: Q6vGY5dVTVS4In7rr1bxEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="39222050"
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="39222050"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 16:24:07 -0700
X-CSE-ConnectionGUID: hN32Vp5cQPmeLkk4AATd7g==
X-CSE-MsgGUID: HXdLlNsvTi6n7bZLnPnlcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="78395919"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.108.250])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 16:24:06 -0700
Subject: [PATCH 1/2] cxl/port: Revert usage of scoped_guard()
From: Dan Williams <dan.j.williams@intel.com>
To: ira.weiny@intel.com, dave.jiang@intel.com
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Li Ming <ming4.li@intel.com>,
 linux-cxl@vger.kernel.org
Date: Wed, 16 Oct 2024 16:24:04 -0700
Message-ID: <172912104335.1414627.1377616790909088415.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Dan points out via smatch [1] that the conversion of
add_port_attach_ep() to use cleanup helpers does not correctly handle a
pointer reassignment case.

        drivers/cxl/core/port.c:1591 add_port_attach_ep()
        warn: re-assigning __cleanup__ ptr 'port'

The conversion to scoped_guard() complicates rather than simplifies code
readability, so just revert the scoped_guard() usage to make the next
patch that fixes the reassignment of port consistent with the approach
that either an entire function is converted at once, or none of it.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: http://lore.kernel.org/2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain [1]
Cc: Li Ming <ming4.li@intel.com>
Fixes: 7f569e917b78 ("cxl/port: Use scoped_guard()/guard() to drop device_lock() for cxl_port")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c   |   72 +++++++++++++++++++++++----------------------
 drivers/cxl/core/region.c |   25 ++++++++--------
 drivers/cxl/mem.c         |   22 ++++++++------
 drivers/cxl/pmem.c        |   16 ++++++----
 4 files changed, 70 insertions(+), 65 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b7828b6c7826..54dd2cd450ca 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1399,14 +1399,14 @@ static void delete_endpoint(void *data)
 	struct cxl_port *endpoint = cxlmd->endpoint;
 	struct device *host = endpoint_host(endpoint);
 
-	scoped_guard(device, host) {
-		if (host->driver && !endpoint->dead) {
-			devm_release_action(host, cxl_unlink_parent_dport, endpoint);
-			devm_release_action(host, cxl_unlink_uport, endpoint);
-			devm_release_action(host, unregister_port, endpoint);
-		}
-		cxlmd->endpoint = NULL;
+	device_lock(host);
+	if (host->driver && !endpoint->dead) {
+		devm_release_action(host, cxl_unlink_parent_dport, endpoint);
+		devm_release_action(host, cxl_unlink_uport, endpoint);
+		devm_release_action(host, unregister_port, endpoint);
 	}
+	cxlmd->endpoint = NULL;
+	device_unlock(host);
 	put_device(&endpoint->dev);
 	put_device(host);
 }
@@ -1571,38 +1571,40 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	 * dereferencing the device of the port before the parent_port releasing.
 	 */
 	struct cxl_port *port __free(put_cxl_port) = NULL;
-	scoped_guard(device, &parent_port->dev) {
-		if (!parent_port->dev.driver) {
-			dev_warn(&cxlmd->dev,
-				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
-				 dev_name(&parent_port->dev), dev_name(uport_dev));
-			return -ENXIO;
-		}
-
-		port = find_cxl_port_at(parent_port, dport_dev, &dport);
-		if (!port) {
-			component_reg_phys = find_component_registers(uport_dev);
-			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
-						 component_reg_phys, parent_dport);
-			if (IS_ERR(port))
-				return PTR_ERR(port);
+	device_lock(&parent_port->dev);
+	if (!parent_port->dev.driver) {
+		dev_warn(&cxlmd->dev,
+			 "port %s:%s disabled, failed to enumerate CXL.mem\n",
+			 dev_name(&parent_port->dev), dev_name(uport_dev));
+		port = ERR_PTR(-ENXIO);
+		goto out;
+	}
 
-			/* retry find to pick up the new dport information */
+	port = find_cxl_port_at(parent_port, dport_dev, &dport);
+	if (!port) {
+		component_reg_phys = find_component_registers(uport_dev);
+		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
+					 component_reg_phys, parent_dport);
+		/* retry find to pick up the new dport information */
+		if (!IS_ERR(port))
 			port = find_cxl_port_at(parent_port, dport_dev, &dport);
-			if (!port)
-				return -ENXIO;
-		}
 	}
+out:
+	device_unlock(&parent_port->dev);
 
-	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
-		dev_name(&port->dev), dev_name(port->uport_dev));
-	rc = cxl_add_ep(dport, &cxlmd->dev);
-	if (rc == -EBUSY) {
-		/*
-		 * "can't" happen, but this error code means
-		 * something to the caller, so translate it.
-		 */
-		rc = -ENXIO;
+	if (IS_ERR(port))
+		rc = PTR_ERR(port);
+	else {
+		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
+			dev_name(&port->dev), dev_name(port->uport_dev));
+		rc = cxl_add_ep(dport, &cxlmd->dev);
+		if (rc == -EBUSY) {
+			/*
+			 * "can't" happen, but this error code means
+			 * something to the caller, so translate it.
+			 */
+			rc = -ENXIO;
+		}
 	}
 
 	return rc;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index dff618c708dc..77b301b0d269 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3083,11 +3083,11 @@ static void cxlr_release_nvdimm(void *_cxlr)
 	struct cxl_region *cxlr = _cxlr;
 	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
 
-	scoped_guard(device, &cxl_nvb->dev) {
-		if (cxlr->cxlr_pmem)
-			devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
-					    cxlr->cxlr_pmem);
-	}
+	device_lock(&cxl_nvb->dev);
+	if (cxlr->cxlr_pmem)
+		devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
+				    cxlr->cxlr_pmem);
+	device_unlock(&cxl_nvb->dev);
 	cxlr->cxl_nvb = NULL;
 	put_device(&cxl_nvb->dev);
 }
@@ -3123,14 +3123,13 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
 	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
 		dev_name(dev));
 
-	scoped_guard(device, &cxl_nvb->dev) {
-		if (cxl_nvb->dev.driver)
-			rc = devm_add_action_or_reset(&cxl_nvb->dev,
-						      cxlr_pmem_unregister,
-						      cxlr_pmem);
-		else
-			rc = -ENXIO;
-	}
+	device_lock(&cxl_nvb->dev);
+	if (cxl_nvb->dev.driver)
+		rc = devm_add_action_or_reset(&cxl_nvb->dev,
+					      cxlr_pmem_unregister, cxlr_pmem);
+	else
+		rc = -ENXIO;
+	device_unlock(&cxl_nvb->dev);
 
 	if (rc)
 		goto err_bridge;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index a9fd5cd5a0d2..6daca88845ca 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -168,18 +168,20 @@ static int cxl_mem_probe(struct device *dev)
 
 	cxl_dport_init_ras_reporting(dport, dev);
 
-	scoped_guard(device, endpoint_parent) {
-		if (!endpoint_parent->driver) {
-			dev_err(dev, "CXL port topology %s not enabled\n",
-				dev_name(endpoint_parent));
-			return -ENXIO;
-		}
-
-		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
-		if (rc)
-			return rc;
+	device_lock(endpoint_parent);
+	if (!endpoint_parent->driver) {
+		dev_err(dev, "CXL port topology %s not enabled\n",
+			dev_name(endpoint_parent));
+		rc = -ENXIO;
+		goto unlock;
 	}
 
+	rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
+unlock:
+	device_unlock(endpoint_parent);
+	if (rc)
+		return rc;
+
 	/*
 	 * The kernel may be operating out of CXL memory on this device,
 	 * there is no spec defined way to determine whether this device
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index d2d43a4fc053..94ce71952447 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -237,13 +237,15 @@ static int detach_nvdimm(struct device *dev, void *data)
 	if (!is_cxl_nvdimm(dev))
 		return 0;
 
-	scoped_guard(device, dev) {
-		if (dev->driver) {
-			cxl_nvd = to_cxl_nvdimm(dev);
-			if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
-				release = true;
-		}
-	}
+	device_lock(dev);
+	if (!dev->driver)
+		goto out;
+
+	cxl_nvd = to_cxl_nvdimm(dev);
+	if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
+		release = true;
+out:
+	device_unlock(dev);
 	if (release)
 		device_release_driver(dev);
 	return 0;

