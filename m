Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B822D02F
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cg/lu8Mh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704409256; x=1735945256;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Es4ejT9sleoHotEBCE40z7GdBdyilnAj+LR4S/+zqg=;
  b=Cg/lu8MhtLnU0wtelMAgwEgXNyG+i6Kr4ZcHJWExp9aoXpJZVT1Zz/Vo
   RftQXPv/5RfrT8Wf7O6Xi++UV7UI7aQ8f85E1hS+cy75IHw6T5c3bG44J
   mHsjE8/P7mcmnvo6JSPoisD1dtJZz34OVsEGJVYJ6y0QG5gb6BWfTqg5M
   rxS8xm0wOGJvEEsHkcDbc0oTvYQnEeoyjeXk6hhaC9anNQdYqGP9ZNk1d
   ryxgXxnHKJPlyZuL7msxIFS/Cy5Yd4UkACLWpzyc+4nzqA/n2zdRwL+0Y
   NEtoUvNG0LDJY22uMS0hJQqYEZcdYTLH9GIdecPpja1jOELT5zw+aAPPL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="387831548"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="387831548"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:00:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="846392346"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="846392346"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:00:55 -0800
Subject: [PATCH v3 3/4] cxl: Refactor usages of cxl_root from being referenced
 indirectly
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
Date: Thu, 04 Jan 2024 16:00:55 -0700
Message-ID: <170440925509.3570725.9669871754496155658.stgit@djiang5-mobl3>
In-Reply-To: <170440924347.3570725.6271367271629367301.stgit@djiang5-mobl3>
References: <170440924347.3570725.6271367271629367301.stgit@djiang5-mobl3>
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
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/acpi.c      |    3 ++-
 drivers/cxl/core/cdat.c |   19 ++++++++++---------
 drivers/cxl/core/pmem.c |    6 ++++--
 drivers/cxl/core/port.c |    4 ++--
 drivers/cxl/cxl.h       |   14 +++++++-------
 drivers/cxl/port.c      |   12 ++++++++----
 6 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index afc712264d1c..37cfd5516024 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -295,10 +295,11 @@ cxl_acpi_evaluate_qtg_dsm(acpi_handle handle, struct access_coordinate *coord,
 	return rc;
 }
 
-static int cxl_acpi_qos_class(struct cxl_port *root_port,
+static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
 			      struct access_coordinate *coord, int entries,
 			      int *qos_class)
 {
+	struct cxl_port *root_port = &cxl_root->port;
 	acpi_handle handle;
 	struct device *dev;
 
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index c5031e90bb96..280ca1508f21 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -162,7 +162,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 					struct xarray *dsmas_xa)
 {
 	struct access_coordinate c;
-	struct cxl_root *cxl_root;
 	struct dsmas_entry *dent;
 	int valid_entries = 0;
 	unsigned long index;
@@ -174,12 +173,10 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 		return rc;
 	}
 
-	struct cxl_port *root_port __free(put_device) = find_cxl_root(port);
-
-	if (!root_port)
+	struct cxl_root *cxl_root __free(put_device) = find_cxl_root(port);
+	if (!cxl_root)
 		return -ENODEV;
 
-	cxl_root = to_cxl_root(root_port);
 	if (!cxl_root->ops || !cxl_root->ops->qos_class)
 		return -EOPNOTSUPP;
 
@@ -196,7 +193,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 						    dent->coord.write_bandwidth);
 
 		dent->entries = 1;
-		rc = cxl_root->ops->qos_class(root_port, &dent->coord, 1, &qos_class);
+		rc = cxl_root->ops->qos_class(cxl_root, &dent->coord, 1, &qos_class);
 		if (rc != 1)
 			continue;
 
@@ -352,15 +349,19 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
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
+	struct cxl_root *cxl_root __free(put_device) =
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
index 8c00fd6be730..b8af09464363 100644
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
index 492dbf63935f..8f43a06c4f72 100644
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
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index da3c3a08bd62..656f2e03d2ea 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -94,8 +94,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_endpoint_dvsec_info info = { .port = port };
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_port *root_port;
 	struct cxl_hdm *cxlhdm;
-	struct cxl_port *root;
 	int rc;
 
 	rc = cxl_dvsec_rr_decode(cxlds->dev, cxlds->cxl_dvsec, &info);
@@ -130,14 +130,18 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	 * This can't fail in practice as CXL root exit unregisters all
 	 * descendant ports and that in turn synchronizes with cxl_port_probe()
 	 */
-	root = find_cxl_root(port);
+	struct cxl_root *cxl_root __free(put_device) = find_cxl_root(port);
+
+	if (!cxl_root)
+		return -ENODEV;
+
+	root_port = &cxl_root->port;
 
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
 	 * assemble regions from committed decoders
 	 */
-	device_for_each_child(&port->dev, root, discover_region);
-	put_device(&root->dev);
+	device_for_each_child(&root_port->dev, root_port, discover_region);
 
 	return 0;
 }


