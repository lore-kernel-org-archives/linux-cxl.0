Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652872C1B9
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceQUo+0X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704397435; x=1735933435;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GHHbh7Bik94oznTeNKUJNyvsPR0NJgXmyo4aNGB+6Go=;
  b=ceQUo+0XAKNwbp8iv5P2CNzuv3H9BPw5ExBtekxDEXU6jdpK7ePSUB4N
   xZ3/H2BOii580VKa3xkFgpOfGLdt8IfY+N6ti4Sfcb7pWBnawL+HAXlfl
   Qa0ym6TJX/mPoqtg7GqvxoDA1dq4+XQHMlNVgLxh7B/BQh+KkwYUDAW6d
   nloyDyewVl5Llkt53yOM4gHgthDbLV2Ach7wkF21gBkEcYWXDqrOHm7PV
   M/gVN5XY9kDJA3eURstG9EHzVZb3xsASa6bAKfSgOhTGBLtDeGOUKA1ap
   QG29hsyUAfhgb5ETCaFa2ui6N1X8EIiluahi2JL+YhrOl/8jO//Vmu1Lh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4454346"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="4454346"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 11:43:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="899408801"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="899408801"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 11:43:54 -0800
Subject: [PATCH v2 3/3] cxl: Introduce put_cxl_root() helper function to have
 symmetry of find_cxl_root()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Robert Richter <rrichter@amd.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
Date: Thu, 04 Jan 2024 12:43:54 -0700
Message-ID: <170439743417.3519628.11381251582844385622.stgit@djiang5-mobl3>
In-Reply-To: <170439742132.3519628.18244037289884549403.stgit@djiang5-mobl3>
References: <170439742132.3519628.18244037289884549403.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a helper function put_cxl_root() to maintain symmetry for
find_cxl_root() function instead of relying on open coding of the
put_device() in order to dereference the 'struct device' that happens via
get_device() in find_cxl_root(). Add cleanups for all code paths that
calls put_device() after find_cxl_root().

In the process also clean up cdat code that uses __free() on the root_port.
The current __free() call for root_port in cxl_qos_class_verify() and
cxl_port_perf_data_calculate() depends on 'struct device' to be the first
member of 'struct cxl_port' and calls put_device() directly with the
root_port pointer passed in. Use the put_cxl_root() call instead to make
the code more precise.

Suggested-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Make put_cxl_root() an exported function to be symmetric to
  find_cxl_root(). (Robert)
---
 drivers/cxl/core/cdat.c |    6 ++++--
 drivers/cxl/core/pmem.c |    2 +-
 drivers/cxl/core/port.c |    9 +++++++++
 drivers/cxl/cxl.h       |    1 +
 drivers/cxl/port.c      |    2 +-
 5 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 701ed53ce337..18399baa45b8 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -158,11 +158,13 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
 	return cdat_table_parse_output(rc);
 }
 
+DEFINE_FREE(put_root_port, struct cxl_port *, put_cxl_root(_T))
+
 static int cxl_port_perf_data_calculate(struct cxl_port *port,
 					struct xarray *dsmas_xa)
 {
 	struct access_coordinate c;
-	struct cxl_port *root_port __free(put_device) = NULL;
+	struct cxl_port *root_port __free(put_root_port) = NULL;
 	struct cxl_root *cxl_root;
 	struct dsmas_entry *dent;
 	int valid_entries = 0;
@@ -352,7 +354,7 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	struct cxl_port *root_port __free(put_device) = NULL;
+	struct cxl_port *root_port __free(put_root_port) = NULL;
 	LIST_HEAD(__discard);
 	struct list_head *discard __free(dpa_perf) = &__discard;
 	int rc;
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index fc94f5240327..1b8d7f812f1a 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -71,7 +71,7 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
 		return NULL;
 
 	dev = device_find_child(&port->dev, NULL, match_nvdimm_bridge);
-	put_device(&port->dev);
+	put_cxl_root(port);
 
 	if (!dev)
 		return NULL;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8c00fd6be730..f989f88960bb 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -986,6 +986,15 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
 
+void put_cxl_root(struct cxl_port *port)
+{
+	if (!port || !is_cxl_root(port))
+		return;
+
+	put_device(&port->dev);
+}
+EXPORT_SYMBOL_NS_GPL(put_cxl_root, CXL);
+
 static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
 	struct cxl_dport *dport;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 492dbf63935f..ba82b2f89898 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -735,6 +735,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 struct cxl_root *devm_cxl_add_root(struct device *host,
 				   const struct cxl_root_ops *ops);
 struct cxl_port *find_cxl_root(struct cxl_port *port);
+void put_cxl_root(struct cxl_port *port);
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index da3c3a08bd62..398f5d50e942 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -137,7 +137,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	 * assemble regions from committed decoders
 	 */
 	device_for_each_child(&port->dev, root, discover_region);
-	put_device(&root->dev);
+	put_cxl_root(root);
 
 	return 0;
 }


