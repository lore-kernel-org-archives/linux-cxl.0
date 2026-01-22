Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C33EFD22
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 03:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052743; cv=none; b=r9oCuAbnab+dlWXV8kKgWfn3fq4wZEzpOxAK2mNk/pWr41kdrJCi1p3sdzLgF+fL4DQLtNqvdfVeOW6sIx/rXKSz6anUcvKOsqGfsB6/5xXhdFrpzba/wN6VLLcrrK9p2m8BqYlmSoGULFsxMJewQO3/OjNzl4/jUIKMrt5W2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052743; c=relaxed/simple;
	bh=QYWNd+F4svJhcvWBc+xpx0OyeQ9fa4IUPXSDCihBBoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSfVEo3IfCHDK51CSnxW9JDyjDx4bcxAd8j+m6VUm/yODFQDRDZGI7iI8JEIu9cUhbpYLaHWrUC3MBImsbzPtMTmIuWFOMs1NwxHPzGx0LssM6Skk1iEPr9oW3IunMfoqg/fcGqbhq+/ZdO+ol0Pf6eb8nA2WTl1UI87U0OqqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NqGvAOOm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NqGvAOOm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769052742; x=1800588742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QYWNd+F4svJhcvWBc+xpx0OyeQ9fa4IUPXSDCihBBoU=;
  b=NqGvAOOmrgTxmaYJVcm0/1c/SqBtQ+TgBhmGlcaGXz4arFgmvxlaNC9H
   7gBTi2cd7j0BYg/ImT9DciEV5VK9Vj2L0197uLRDg6RxPA80JV4xrhJev
   rEZ2nHSINZ4w/uMSHHpnJzHuw74k1DjqAP11ahpAs/am82wuByLY2+3hf
   3X032yqsqNANkKgpzS4c97sYxmhR2no7cuRWVrv/W5nyiQ/oKZyGiSEA+
   soE7O4PeI+PN8Wwcc4/ED3NO5tn0Oy4+zYVsl67hBvwUSNLy0lamOcwF3
   gcDX/NZjEmpnwGy37jgNVna7evsovRHhg5KvOohcWk4Ab+JhuYAaRL+I9
   w==;
X-CSE-ConnectionGUID: HHUfUjbaQX+Dfr/TMzLmwA==
X-CSE-MsgGUID: VxkXMfxOTSWnEvNH0sIHIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81734438"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="81734438"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 19:32:18 -0800
X-CSE-ConnectionGUID: CVFZ60L5T128yOoc9LvN5g==
X-CSE-MsgGUID: 1JakXNLSTQ2IhLg8t6qgeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="211064085"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa005.fm.intel.com with ESMTP; 21 Jan 2026 19:32:18 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	terry.bowman@amd.com
Subject: [PATCH 3/9] cxl/port: Cleanup dport removal with a devres group
Date: Wed, 21 Jan 2026 19:33:24 -0800
Message-ID: <20260122033330.1622168-4-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122033330.1622168-1-dan.j.williams@intel.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
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

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c | 62 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1637e97f6805..f2723bf948e2 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1118,6 +1118,51 @@ static void cxl_dport_unlink(void *data)
 	sysfs_remove_link(&port->dev.kobj, link_name);
 }
 
+static struct device *dport_to_host(struct cxl_dport *dport)
+{
+	if (is_cxl_root(dport->port))
+		return dport->port->uport_dev;
+	return &dport->port->dev;
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
+static void *cxl_dport_open_group_or_free(struct cxl_dport *dport)
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
+static void cxl_dport_close_group(struct cxl_dport *dport, void *group)
+{
+	devres_close_group(dport_to_host(dport), group);
+}
+
+/* The dport group id is the dport */
+DEFINE_FREE(cxl_dport_release_group, void *,
+	    if (_T) devres_release_group(dport_to_host(_T), _T))
+
 static struct cxl_dport *
 __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		     int port_id, resource_size_t component_reg_phys,
@@ -1143,14 +1188,20 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
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
 
+	void *dport_group __free(cxl_dport_release_group) =
+		cxl_dport_open_group_or_free(dport);
+	if (!dport_group)
+		return ERR_PTR(-ENOMEM);
+
 	if (rcrb == CXL_RESOURCE_NONE) {
 		rc = cxl_dport_setup_regs(&port->dev, dport,
 					  component_reg_phys);
@@ -1203,6 +1254,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
 	cxl_debugfs_create_dport_dir(dport);
 
+	/* keep the group, and mark the end of devm actions */
+	cxl_dport_close_group(dport, no_free_ptr(dport_group));
+
 	return dport;
 }
 
@@ -1431,11 +1485,7 @@ static void delete_switch_port(struct cxl_port *port)
 
 static void del_dport(struct cxl_dport *dport)
 {
-	struct cxl_port *port = dport->port;
-
-	devm_release_action(&port->dev, cxl_dport_unlink, dport);
-	devm_release_action(&port->dev, cxl_dport_remove, dport);
-	devm_kfree(&port->dev, dport);
+	devres_release_group(dport_to_host(dport), dport);
 }
 
 static void del_dports(struct cxl_port *port)
-- 
2.52.0

