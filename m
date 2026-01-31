Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190DBDDAB
	for <linux-cxl@vger.kernel.org>; Sat, 31 Jan 2026 00:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769817774; cv=none; b=W0BGHknWquX6KZnOR7B06xmSbHR71SKWBOAzhUf+dzt4ldMZENvmqjbfJ+2c+cZTJm30Bh7wy17TlODXkZt2T2CsUdgw5sB64WD114von9O6ibWvOGaTFrGZNgn0sNGbhSj3JY011gkn7o1Yt8PID/YOJj6yDZFlwiuEyiAItIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769817774; c=relaxed/simple;
	bh=ValPpLYjM0IBRIDILkCPyJJXae9sf0ITHTFKiBguz5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNYvtUL6/0d1aByzzvuqxG6Xa60DncQNF5LiLde5W+v43QAKYjJK/Df78tTpbA3lqD1+Rm6Fl+i+MO9q83GWL7pQaZYYk3lqzkLf7a4ugdr3eo0GtZ0a4rjucSy+NhyCp4Z1oA12bk+0awPUYyuktJ0diqhbOb9wphfGeFV/+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKWZvpQ5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKWZvpQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769817773; x=1801353773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ValPpLYjM0IBRIDILkCPyJJXae9sf0ITHTFKiBguz5M=;
  b=lKWZvpQ5jJjNI9+cohgGzgmT2XcWqXDgOQ9g2KUmD8pr6xqwejvgw4TA
   wlw8FbHYJhvER0ghPl+HauzmyX+yDX16W5SM3SDhd6TUDxVo70KjhNVEt
   StZR5vHF8SaIssp2weuqpH9S+NK8SyqfwA/xsIlj8nHtkJpyxAHxU2JDB
   rzCg4iAwFZdkOqkoEMQCFTcBjE95qMy27f8LRMGnCZRhCBYWoU0Qa+r9x
   TLGxcgKZuTELfR+ovR0Hw6WBa9aw1Iz2HJ5zOsriIl66TlSAE0kNgnkai
   y9H01tX5hGl6D6/pcvbBBGZAfMo1+lrrvG/a5iNPSOG+64tHrYeBwm4Zf
   g==;
X-CSE-ConnectionGUID: qUiJUr1JRFSe73Ng7MH/kw==
X-CSE-MsgGUID: 7P4QEyGKTMOy/quqFn5Bfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71156904"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="71156904"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 16:02:50 -0800
X-CSE-ConnectionGUID: hMJK3ZVVTWyps226vtDXog==
X-CSE-MsgGUID: A2XqhcCRTFitAJqhItEWGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="208093716"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa006.jf.intel.com with ESMTP; 30 Jan 2026 16:02:49 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	alison.schofield@intel.com,
	dave.jiang@intel.com,
	terry.bowman@amd.com
Subject: [PATCH v2 3/9] cxl/port: Cleanup dport removal with a devres group
Date: Fri, 30 Jan 2026 16:03:57 -0800
Message-ID: <20260131000403.2135324-4-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131000403.2135324-1-dan.j.williams@intel.com>
References: <20260131000403.2135324-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding more setup actions like RAS register mapping,
introduce a devres group to collect all the dport creation / registration
actions. This replaces the maintenance tedium of open coding several
devm_release_action() calls in del_dport().

Tested-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c | 71 +++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d7b6f52d0adc..99bbcf9cf236 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1118,6 +1118,57 @@ static void cxl_dport_unlink(void *data)
 	sysfs_remove_link(&port->dev.kobj, link_name);
 }
 
+static struct device *dport_to_host(struct cxl_dport *dport)
+{
+	struct cxl_port *port = dport->port;
+
+	if (is_cxl_root(port))
+		return port->uport_dev;
+	return &port->dev;
+}
+
+static void free_dport(void *dport)
+{
+	kfree(dport);
+}
+
+/*
+ * Upon return either a group is established with one action (free_dport()), or
+ * no group established and @dport is freed.
+ */
+static void *cxl_dport_open_dr_group_or_free(struct cxl_dport *dport)
+{
+	int rc;
+	struct device *host = dport_to_host(dport);
+	void *group = devres_open_group(host, dport, GFP_KERNEL);
+
+	if (!group) {
+		kfree(dport);
+		return NULL;
+	}
+
+	rc = devm_add_action_or_reset(host, free_dport, dport);
+	if (rc) {
+		devres_release_group(host, group);
+		return NULL;
+	}
+
+	return group;
+}
+
+static void cxl_dport_close_dr_group(struct cxl_dport *dport, void *group)
+{
+	devres_close_group(dport_to_host(dport), group);
+}
+
+static void del_dport(struct cxl_dport *dport)
+{
+	devres_release_group(dport_to_host(dport), dport);
+}
+
+/* The dport group id is the dport */
+DEFINE_FREE(cxl_dport_release_dr_group, void *, if (_T) del_dport(_T))
+
 static struct cxl_dport *
 __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		     int port_id, resource_size_t component_reg_phys,
@@ -1143,14 +1194,20 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	    CXL_TARGET_STRLEN)
 		return ERR_PTR(-EINVAL);
 
-	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
+	dport = kzalloc(sizeof(*dport), GFP_KERNEL);
 	if (!dport)
 		return ERR_PTR(-ENOMEM);
 
+	/* Just enough init to manage the devres group */
 	dport->dport_dev = dport_dev;
 	dport->port_id = port_id;
 	dport->port = port;
 
+	void *dport_dr_group __free(cxl_dport_release_dr_group) =
+		cxl_dport_open_dr_group_or_free(dport);
+	if (!dport_dr_group)
+		return ERR_PTR(-ENOMEM);
+
 	if (rcrb == CXL_RESOURCE_NONE) {
 		rc = cxl_dport_setup_regs(&port->dev, dport,
 					  component_reg_phys);
@@ -1203,6 +1260,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
 	cxl_debugfs_create_dport_dir(dport);
 
+	/* keep the group, and mark the end of devm actions */
+	cxl_dport_close_dr_group(dport, no_free_ptr(dport_dr_group));
+
 	return dport;
 }
 
@@ -1429,15 +1489,6 @@ static void delete_switch_port(struct cxl_port *port)
 	devm_release_action(port->dev.parent, unregister_port, port);
 }
 
-static void del_dport(struct cxl_dport *dport)
-{
-	struct cxl_port *port = dport->port;
-
-	devm_release_action(&port->dev, cxl_dport_unlink, dport);
-	devm_release_action(&port->dev, cxl_dport_remove, dport);
-	devm_kfree(&port->dev, dport);
-}
-
 static void del_dports(struct cxl_port *port)
 {
 	struct cxl_dport *dport;
-- 
2.52.0

