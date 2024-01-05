Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335AE1E527
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 22:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FD97iATr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704492462; x=1736028462;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VxoLGHubgUj8pTMXYOSnm2kASHL6aIjFNrmMC7W10rs=;
  b=FD97iATrJB6IencK4w9x3EWFNGpW++AwKPBhg4P/T6mAjACTvlu9UfU2
   BJcX5CxYNw9jfgW0Z/wLFjK9s65GhIgDj+7I2M3Mz2CSY1PFah06FSe7j
   7k4Du5d+G3V0A6rR2OObPjJgYCLhDn/WsFup4C5O52Estxogx49WL3q2+
   lOyUW8Zfs0JnUjQTlo0PyU8NhfuRAfvHLaAmwe6JNqON3HnPstq8GoY4G
   2qUhGHZyOkALQUjAPvlWPGrpRiYSEVP3jJoAXx114tiMgm7zO//Sgct9X
   AHOAg8bnuRugROVNEFDdcQ+Fsj4CdgzFqotubFpn/Zi9T0MQODFhZrA/d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="4957440"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="4957440"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 14:07:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="904260064"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="904260064"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.109.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 14:07:41 -0800
Subject: [PATCH v6 2/5] cxl: Convert find_cxl_root() to return a 'struct
 cxl_root *'
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 rrichter@amd.com
Date: Fri, 05 Jan 2024 15:07:40 -0700
Message-ID: <170449246044.3779673.13035770941393418591.stgit@djiang5-mobl3>
In-Reply-To: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Commit 790815902ec6 ("cxl: Add support for _DSM Function for retrieving QTG ID")
introduced 'struct cxl_root', however all usages have been worked
indirectly through cxl_port. Refactor code such as find_cxl_root()
function to use 'struct cxl_root' directly.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- Revert code that broke device_for_each_child() (Dan)
- Leave put_device() calls in this patch. (Dan)
v5:
- Squash in v4 3/6 to update the qos_class to cxl_root. (Dan)
- Moved the introduction of __free() for cxl_root_put from v4 1/6 to
  here. (Dan)
v4:
- Adjust ordering of patches to move this to 2nd place. (Dan)
---
 drivers/cxl/acpi.c      |    6 ++----
 drivers/cxl/core/cdat.c |   17 ++++++++++-------
 drivers/cxl/core/pmem.c |    6 ++++--
 drivers/cxl/core/port.c |    4 ++--
 drivers/cxl/cxl.h       |   14 +++++++-------
 drivers/cxl/port.c      |    4 +++-
 6 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index afc712264d1c..dcf2b39e1048 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -295,14 +295,12 @@ cxl_acpi_evaluate_qtg_dsm(acpi_handle handle, struct access_coordinate *coord,
 	return rc;
 }
 
-static int cxl_acpi_qos_class(struct cxl_port *root_port,
+static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
 			      struct access_coordinate *coord, int entries,
 			      int *qos_class)
 {
+	struct device *dev = cxl_root->port.uport_dev;
 	acpi_handle handle;
-	struct device *dev;
-
-	dev = root_port->uport_dev;
 
 	if (!dev_is_platform(dev))
 		return -ENODEV;
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index cd84d87f597a..0df5379cf02f 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -162,7 +162,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 					struct xarray *dsmas_xa)
 {
 	struct access_coordinate c;
-	struct cxl_port *root_port;
 	struct cxl_root *cxl_root;
 	struct dsmas_entry *dent;
 	int valid_entries = 0;
@@ -175,8 +174,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 		return rc;
 	}
 
-	root_port = find_cxl_root(port);
-	cxl_root = to_cxl_root(root_port);
+	cxl_root = find_cxl_root(port);
 	if (!cxl_root->ops || !cxl_root->ops->qos_class)
 		return -EOPNOTSUPP;
 
@@ -193,7 +191,8 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 						    dent->coord.write_bandwidth);
 
 		dent->entries = 1;
-		rc = cxl_root->ops->qos_class(root_port, &dent->coord, 1, &qos_class);
+		rc = cxl_root->ops->qos_class(cxl_root, &dent->coord, 1,
+					      &qos_class);
 		if (rc != 1)
 			continue;
 
@@ -349,15 +348,19 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	struct cxl_port *root_port __free(put_device) = NULL;
 	LIST_HEAD(__discard);
 	struct list_head *discard __free(dpa_perf) = &__discard;
+	struct cxl_port *root_port;
 	int rc;
 
-	root_port = find_cxl_root(cxlmd->endpoint);
-	if (!root_port)
+	struct cxl_root *cxl_root __free(put_cxl_root) =
+		find_cxl_root(cxlmd->endpoint);
+
+	if (!cxl_root)
 		return -ENODEV;
 
+	root_port = &cxl_root->port;
+
 	/* Check that the QTG IDs are all sane between end device and root decoders */
 	cxl_qos_match(root_port, &mds->ram_perf_list, discard);
 	cxl_qos_match(root_port, &mds->pmem_perf_list, discard);
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index fc94f5240327..da92a901b9e8 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -64,12 +64,14 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
 
 struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
 {
-	struct cxl_port *port = find_cxl_root(cxlmd->endpoint);
+	struct cxl_root *cxl_root = find_cxl_root(cxlmd->endpoint);
+	struct cxl_port *port;
 	struct device *dev;
 
-	if (!port)
+	if (!cxl_root)
 		return NULL;
 
+	port = &cxl_root->port;
 	dev = device_find_child(&port->dev, NULL, match_nvdimm_bridge);
 	put_device(&port->dev);
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 64f30d5fe1f6..63a4e3c2baed 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -972,7 +972,7 @@ static bool dev_is_cxl_root_child(struct device *dev)
 	return false;
 }
 
-struct cxl_port *find_cxl_root(struct cxl_port *port)
+struct cxl_root *find_cxl_root(struct cxl_port *port)
 {
 	struct cxl_port *iter = port;
 
@@ -982,7 +982,7 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
 	if (!iter)
 		return NULL;
 	get_device(&iter->dev);
-	return iter;
+	return to_cxl_root(iter);
 }
 EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index df3db3e43913..3a5004aab97a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -617,12 +617,6 @@ struct cxl_port {
 	long pci_latency;
 };
 
-struct cxl_root_ops {
-	int (*qos_class)(struct cxl_port *root_port,
-			 struct access_coordinate *coord, int entries,
-			 int *qos_class);
-};
-
 /**
  * struct cxl_root - logical collection of root cxl_port items
  *
@@ -640,6 +634,12 @@ to_cxl_root(const struct cxl_port *port)
 	return container_of(port, struct cxl_root, port);
 }
 
+struct cxl_root_ops {
+	int (*qos_class)(struct cxl_root *cxl_root,
+			 struct access_coordinate *coord, int entries,
+			 int *qos_class);
+};
+
 static inline struct cxl_dport *
 cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
 {
@@ -734,7 +734,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 				   struct cxl_dport *parent_dport);
 struct cxl_root *devm_cxl_add_root(struct device *host,
 				   const struct cxl_root_ops *ops);
-struct cxl_port *find_cxl_root(struct cxl_port *port);
+struct cxl_root *find_cxl_root(struct cxl_port *port);
 void put_cxl_root(struct cxl_root *cxl_root);
 DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index da3c3a08bd62..4f3a08fdc9e9 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -94,6 +94,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_endpoint_dvsec_info info = { .port = port };
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_root *cxl_root;
 	struct cxl_hdm *cxlhdm;
 	struct cxl_port *root;
 	int rc;
@@ -130,7 +131,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	 * This can't fail in practice as CXL root exit unregisters all
 	 * descendant ports and that in turn synchronizes with cxl_port_probe()
 	 */
-	root = find_cxl_root(port);
+	cxl_root = find_cxl_root(port);
+	root = &cxl_root->port;
 
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to


