Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4F31860
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQ83peCX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704417499; x=1735953499;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vj9rJKI85BEtA/Pm2urZFc3YXyZFQo/wBE5rIQ3T6LY=;
  b=OQ83peCXCC/J+8E3ZgPlHB1K9elYiVSRVj6PWiM8ogS9R3YtRVbckzq1
   AM/EUjjK3tUBPDvC66NHZoVxcJBtnkw/NHkEs58kLwjLj74+KClqXz5Up
   whG1hx7VLoXEMAaDu8VM8UoeaLzSN8AwC2+qKsm+MREqOhJJPcPQk1tvg
   NNhPeDqx/688aDdGdAmAB/7IMBie5yA4zRzRgjaDBTUpPLeNZA7EUvjBp
   uxr3gMJqUEcWU/QzqAHkMM3Jys5VkkgoyF8LyMJeA4TAu3Wg/x4kT1eJ5
   Gdz6NhNCobq0C4FEO3Azwil06Tqa5RjZQhkaV7Tk0wLGJWAzEzZywRSvg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="463802186"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="463802186"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:18:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1027613290"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="1027613290"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:18:14 -0800
Subject: [PATCH v4 2/6] cxl: Convert find_cxl_root() to return a 'struct
 cxl_root *'
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
Date: Thu, 04 Jan 2024 18:18:14 -0700
Message-ID: <170441749454.3632067.9603741384368361001.stgit@djiang5-mobl3>
In-Reply-To: <170441738812.3632067.2103652995360101907.stgit@djiang5-mobl3>
References: <170441738812.3632067.2103652995360101907.stgit@djiang5-mobl3>
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
v4:
- Adjust ordering of patches to move this to 2nd place. (Dan)
---
 drivers/cxl/core/cdat.c |   14 ++++++++------
 drivers/cxl/core/pmem.c |    8 +++++---
 drivers/cxl/core/port.c |   12 ++++++------
 drivers/cxl/cxl.h       |    6 +++---
 drivers/cxl/port.c      |   10 ++++++----
 5 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index c1085fcc5428..f9bc386f3043 100644
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
+		rc = cxl_root->ops->qos_class(&cxl_root->port, &dent->coord, 1,
+					      &qos_class);
 		if (rc != 1)
 			continue;
 
@@ -351,14 +350,17 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 	LIST_HEAD(__discard);
 	struct list_head *discard __free(dpa_perf) = &__discard;
+	struct cxl_port *root_port;
 	int rc;
 
-	struct cxl_port *root_port __free(put_cxl_root) =
+	struct cxl_root *cxl_root __free(put_cxl_root) =
 		find_cxl_root(cxlmd->endpoint);
 
-	if (!root_port)
+	if (!cxl_root)
 		return -ENODEV;
 
+	root_port = &cxl_root->port;
+
 	/* Check that the QTG IDs are all sane between end device and root decoders */
 	cxl_qos_match(root_port, &mds->ram_perf_list, discard);
 	cxl_qos_match(root_port, &mds->pmem_perf_list, discard);
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index fc94f5240327..57b777a088f6 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -64,14 +64,16 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
 
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
-	put_device(&port->dev);
+	put_cxl_root(cxl_root);
 
 	if (!dev)
 		return NULL;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f66650bb6128..63a4e3c2baed 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -972,7 +972,7 @@ static bool dev_is_cxl_root_child(struct device *dev)
 	return false;
 }
 
-struct cxl_port *find_cxl_root(struct cxl_port *port)
+struct cxl_root *find_cxl_root(struct cxl_port *port)
 {
 	struct cxl_port *iter = port;
 
@@ -982,18 +982,18 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
 	if (!iter)
 		return NULL;
 	get_device(&iter->dev);
-	return iter;
+	return to_cxl_root(iter);
 }
 EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
 
-void put_cxl_root(struct cxl_port *port)
+void put_cxl_root(struct cxl_root *cxl_root)
 {
-	if (!port)
+	if (!cxl_root)
 		return;
 
-	put_device(&port->dev);
+	put_device(&cxl_root->port.dev);
 }
-EXPORT_SYMBOL_NS_GPL(put_cxl_root);
+EXPORT_SYMBOL_NS_GPL(put_cxl_root, CXL);
 
 static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4e53604de041..70d5e6363399 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -734,9 +734,9 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 				   struct cxl_dport *parent_dport);
 struct cxl_root *devm_cxl_add_root(struct device *host,
 				   const struct cxl_root_ops *ops);
-struct cxl_port *find_cxl_root(struct cxl_port *port);
-void put_cxl_root(struct cxl_port *port);
-DEFINE_FREE(put_cxl_root, struct cxl_port *, if (_T) put_cxl_root(_T))
+struct cxl_root *find_cxl_root(struct cxl_port *port);
+void put_cxl_root(struct cxl_root *cxl_root);
+DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
 
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index da3c3a08bd62..ddbb42f0fd70 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -95,7 +95,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_hdm *cxlhdm;
-	struct cxl_port *root;
+	struct cxl_root *cxl_root;
+	struct cxl_port *root_port;
 	int rc;
 
 	rc = cxl_dvsec_rr_decode(cxlds->dev, cxlds->cxl_dvsec, &info);
@@ -130,14 +131,15 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	 * This can't fail in practice as CXL root exit unregisters all
 	 * descendant ports and that in turn synchronizes with cxl_port_probe()
 	 */
-	root = find_cxl_root(port);
+	cxl_root = find_cxl_root(port);
+	root_port = &cxl_root->port;
 
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
 	 * assemble regions from committed decoders
 	 */
-	device_for_each_child(&port->dev, root, discover_region);
-	put_device(&root->dev);
+	device_for_each_child(&root_port->dev, root_port, discover_region);
+	put_cxl_root(cxl_root);
 
 	return 0;
 }


