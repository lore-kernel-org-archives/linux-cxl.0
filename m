Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFF813DBA7
	for <linux-cxl@vger.kernel.org>; Mon, 26 Aug 2024 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662885; cv=none; b=vFdjLvoj1DBTqntLqFCHVnTpPTHrncuCX0GKs5BZbD8A5TzTIqcZDyYk4U2BZ8rYCoHO8TJKCk4RE4M+1BxFocNMTT5S7qzcajtsJwLDiTegIZWNEM3+I5t+0egXJoOvRgb9UlJ/FrLy3Rv7Y3mTQ3aLSdt+X3PG7+fzCrIl900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662885; c=relaxed/simple;
	bh=PphFVVe40szF5DgrHrVCu5L8eQfmggbruypBM/mxrTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFZbZ8Mq9YGhL1WSVQhl+gSpi+KqHjxu2zSbIHjRlwQInXn5TIUqcD/Qp1X6e5N20vN3FQFzzznU47hmBUIziQeO3EDGJbQZLbTgE7ch+IsCglYhckU7GmYefliXQT63byTRsDm0MAdGF79P8XmrA1Ao/ovbGtpdmmMdb5BAYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OV6www60; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OV6www60"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724662883; x=1756198883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PphFVVe40szF5DgrHrVCu5L8eQfmggbruypBM/mxrTU=;
  b=OV6www60uB6Ha0dHlZpy56W1dcWX2PSvYl2GTMNSdOAiepuU4ZTZPI6X
   uYF+TfjGrQR9FFOxKBeWsk+3EI8Ze8iJHC8ZrsAFWuP0LhnPc7eQXH0li
   hqX8K+Q0zaja8SwoQP6PFoPtHXlZf5dtZ3W5RIjbiaMLsoxP86nTB6pz/
   TfgcSeGNFEO2x/H51eE5wSL/UmlmPiIoW9I1Q4GG3HmkoRuDlzNrOLQBC
   dSByj3007w8Y/Ae7zxEfuYQIOqj1sBm0a36EmGHk9avnzAuDNWpOlKQkU
   FAqet/9NPNDtKOpXNHjZeH4UUOzGVB/iA4B2Ws7muNdp5mhUaz7z59nTl
   A==;
X-CSE-ConnectionGUID: pIU05o08Q0mWggHVDk9VpQ==
X-CSE-MsgGUID: hK839mgGSdStBD7HEDX+Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="33737720"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="33737720"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 02:01:23 -0700
X-CSE-ConnectionGUID: 1GwWhiQOSD6w92BTwNr8oA==
X-CSE-MsgGUID: wAJLSrk/RoaSeoxb0AmTWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="66617155"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 02:01:21 -0700
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
Subject: [PATCH v2 3/3] cxl/port: Refactor __devm_cxl_add_port() to drop goto pattern
Date: Mon, 26 Aug 2024 08:30:58 +0000
Message-Id: <20240826083058.1509232-3-ming4.li@intel.com>
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
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/port.c | 59 ++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 7b87b5142fa7..053ccd542ab6 100644
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

