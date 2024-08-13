Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D7B61FDA
	for <linux-cxl@vger.kernel.org>; Tue, 13 Aug 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534570; cv=none; b=qfWH9J+RM+Rx7kbKFnOy2Kr3HHwLMwbmOzX6GcNDSJ0BrHxqW4AAmrjYMkpHCEBc4EE+WlpkTTL2u0dZKZwEJZnUuVeNL+7+LwUMq7eXjioFa2tUQ4xX7o7iEkKgPHBuBwx9hepJfrT7oUCdMa9eD9gs6XYMvYZ8BkedX1EkksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534570; c=relaxed/simple;
	bh=CBCEHqbbzQV0YmWRtHUbLBZ9APjXGYueotu+Spiize4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Shytr/V6T9KhTi6/r1SI1gG/2d+prlGOtU72cL7NnTSNMfWZz8/SdZo7QCEznG6ziRgcuApy5GQH3pJ08iL7G++oh3eYFxfS8XK+rfdHWh06dYotCLQDdVCIExJrgDqv6CEVqXTnSMMdOXno93ZfM5FrP1Z1vea/WmYVrhjZC44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4xxWMss; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4xxWMss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723534569; x=1755070569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CBCEHqbbzQV0YmWRtHUbLBZ9APjXGYueotu+Spiize4=;
  b=d4xxWMssdCSXrG7sQW/VQQDL5iJWxQtz6ZU4BDrfFpc6+tcX0TsHvft9
   PaHDdD2ti8K+xafklqYL223+J8zHsq6XVitSLxUSDpU5xjhL13+O4CQmB
   18MYK2r4PU02Ykafb+nEyc0J4e7nVvwgwp+pL+wylYyhvCqzyUwboBXgg
   t6lGJ5uJHtvsfzqYCiJD+c7JpILDv1zFoZiwc0kGYA0sos6+tG5L8677b
   J2nRabgiGdnmuRwdvaZbPzUYKlRmir86fTafUeWZ3aj6b6tg9lkGt20/k
   qdCkTLffldSa7rjJCr4qHizMBV1GM/+3eTvs1TNPZXZ6bgebCqoasouH5
   A==;
X-CSE-ConnectionGUID: cou08cYtRvKkXQIGkVdqBw==
X-CSE-MsgGUID: WGIphQkeTWydw13EjxevIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="24588501"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="24588501"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:36:09 -0700
X-CSE-ConnectionGUID: ScNePn8ORDiwKV2DbZKAMA==
X-CSE-MsgGUID: AmbDMJZ0SOeSlzD6BcknoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58525608"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:36:06 -0700
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
Subject: [PATCH 3/3] cxl/port: Refactor __devm_cxl_add_port() to drop goto pattern
Date: Tue, 13 Aug 2024 07:05:52 +0000
Message-Id: <20240813070552.3353530-3-ming4.li@intel.com>
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

The "goto error" pattern is not recommended, it can be removed via
refactoring. In __devm_cxl_add_port(), there is a 'goto' to call
put_device() for the error cases between device_initialize() and
device_add() to dereference the 'struct device' of a new cxl_port.
The refactoring is introducing a new function called cxl_port_add()
which is used to add the 'struct device' of a new cxl_port to
device hierarchy, moving the functions needing the help of above
'goto' into cxl_port_add(), and using a scope-based resource management
__free() to drop the open coded put_device() and 'goto' for the error
cases.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/cxl/core/port.c | 59 ++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 53e2593daa95..a886b16b2610 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -828,27 +828,20 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 			    &cxl_einj_inject_fops);
 }
 
-static struct cxl_port *__devm_cxl_add_port(struct device *host,
-					    struct device *uport_dev,
-					    resource_size_t component_reg_phys,
-					    struct cxl_dport *parent_dport)
+static int cxl_port_add(struct cxl_port *port,
+			resource_size_t component_reg_phys,
+			struct cxl_dport *parent_dport)
 {
-	struct cxl_port *port;
-	struct device *dev;
+	struct device *dev __free(put_device) = &port->dev;
 	int rc;
 
-	port = cxl_port_alloc(uport_dev, parent_dport);
-	if (IS_ERR(port))
-		return port;
-
-	dev = &port->dev;
-	if (is_cxl_memdev(uport_dev)) {
-		struct cxl_memdev *cxlmd = to_cxl_memdev(uport_dev);
+	if (is_cxl_memdev(port->uport_dev)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 		struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
 		rc = dev_set_name(dev, "endpoint%d", port->id);
 		if (rc)
-			goto err;
+			return rc;
 
 		/*
 		 * The endpoint driver already enumerated the component and RAS
@@ -861,19 +854,41 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	} else if (parent_dport) {
 		rc = dev_set_name(dev, "port%d", port->id);
 		if (rc)
-			goto err;
+			return rc;
 
 		rc = cxl_port_setup_regs(port, component_reg_phys);
 		if (rc)
-			goto err;
-	} else
+			return rc;
+	} else {
 		rc = dev_set_name(dev, "root%d", port->id);
-	if (rc)
-		goto err;
+		if (rc)
+			return rc;
+	}
 
 	rc = device_add(dev);
 	if (rc)
-		goto err;
+		return rc;
+
+	/* Inhibit the cleanup function invoked */
+	dev = NULL;
+	return 0;
+}
+
+static struct cxl_port *__devm_cxl_add_port(struct device *host,
+					    struct device *uport_dev,
+					    resource_size_t component_reg_phys,
+					    struct cxl_dport *parent_dport)
+{
+	struct cxl_port *port;
+	int rc;
+
+	port = cxl_port_alloc(uport_dev, parent_dport);
+	if (IS_ERR(port))
+		return port;
+
+	rc = cxl_port_add(port, component_reg_phys, parent_dport);
+	if (rc)
+		return ERR_PTR(rc);
 
 	rc = devm_add_action_or_reset(host, unregister_port, port);
 	if (rc)
@@ -891,10 +906,6 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 		port->pci_latency = cxl_pci_get_latency(to_pci_dev(uport_dev));
 
 	return port;
-
-err:
-	put_device(dev);
-	return ERR_PTR(rc);
 }
 
 /**
-- 
2.40.1

