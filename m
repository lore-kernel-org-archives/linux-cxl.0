Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE7112B71
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983313; cv=none; b=Yh+KvcE1FcH89W1zwdvv/I7Eqmdb/p4ogQRKQVmNDIuXt6WbIWoW0zRjeDmw7lZzc3TtwEzBjOLQ9B4Q3YVgnmNbOTU3RG/09pynlsI8r8/K6DhkVtN/wW/SmHFJwvC8M1+3e4JMhevoZGTDsCPpjtD2ieu0FazcvVR3CVyk3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983313; c=relaxed/simple;
	bh=AZp8Y4svlxRlLRPVUdTF0INTgw8JVNVFIBL8zCgukek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pg/9r1Qwsrqyl+JpRsvddU+LwAiph48C11YgfWzC/1kGc7u2IXah7xy6tB8rZ9IFondeo88x/gv9mcYsvE6tuid8ekCmcjGTz4L1B5okIuP5//VTIqmRaDNjHLUBBNED76Cqptq/kox0NUou95GdwpODxx/By7zsZjiYuFeT50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0q4s4ir; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0q4s4ir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724983311; x=1756519311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AZp8Y4svlxRlLRPVUdTF0INTgw8JVNVFIBL8zCgukek=;
  b=Y0q4s4irkQa9cFi1R6ooxR9fBp0ycF9TH8BRu3h2XYiuUkGSKEKyDKOI
   6PLuR+3vNMCFgD3ZEFYtg469LzpU9On5/vEe6uRbUQaxpIkjfLN+U5VF5
   Mucimt1egveEZ9TAyAYnZcDolczLPpgOFTemKNKYn+OM625mhYV/2syti
   gdhPqyZvET/hLmkSY5P9hg0gJaSNtaVGis1NfnnyxxZ9mSOKt5wUydtg9
   ERjOy0PWukwUpxFSwlWoFkUhlAJTK9oEeVYcP4mlhp7AwW1Zg34YFXXNz
   xEeJWRjRqA7/hvvPqwsfbNZthYg/UJzI2jZDrVkvwmVZtB/r4W72wkvZi
   w==;
X-CSE-ConnectionGUID: n1dEtIg6QYC3BiApJgqPXQ==
X-CSE-MsgGUID: GCAL/i6FQxS636sc+v8i3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="46122230"
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="46122230"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 19:01:51 -0700
X-CSE-ConnectionGUID: tLqm4VSJSv6+T3k7KcKs8A==
X-CSE-MsgGUID: liFkZm23Sx6f8iZaOm+zpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="101267118"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 19:01:49 -0700
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
	Jonathan Cameron <Jonathan.Cameron@huwaei.com>
Subject: [PATCH v3 3/3] cxl/port: Refactor __devm_cxl_add_port() to drop goto pattern
Date: Fri, 30 Aug 2024 01:31:38 +0000
Message-Id: <20240830013138.2256244-3-ming4.li@intel.com>
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

In __devm_cxl_add_port(), there is a 'goto' to call put_device() for the
error cases between device_initialize() and device_add() to dereference
the 'struct device' of a new cxl_port. The 'goto' pattern in the case
can be removed by refactoring. Introducing a new function called
cxl_port_add() which is used to add the 'struct device' of a new
cxl_port to device hierarchy, moving the functions needing the help of
the 'goto' into cxl_port_add(), and using a scoped-based resource
management __free() to drop the open coded put_device() and the 'goto'
for the error cases.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming4.li@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwaei.com>
---
 drivers/cxl/core/port.c | 59 ++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d02fb85e8c8d..611da602bf8f 100644
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

