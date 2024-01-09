Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F12818
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmcNkAin"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704762441; x=1736298441;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CIW9IDmPn2INltOnU+chpBBMJnu7YXe25F83e0n/pcI=;
  b=dmcNkAinSWRv2+yrUVbYK5QEIi6nYZ4s3SMfHCPwfiOBpzKqvWgCtvm+
   GsEWgT16ZXXkIyJAi5aXN6O5/smAcyoYJqRwqXF7fUuFxyBg46ApC1P/y
   vy75X3XlVQ9/jEwlqdLhjLraBXELBYHMXbMDOJpUr1cZ0l7d/qzR6XGkw
   Umxv2UaOz8XuvGQ+YAMYVCOWENB2uwSTJ3/c12RXtOVK9DHRyTW3n3sM9
   RUQMSaihj2n5r8d2TWJn59muW/z01FNgqYKaDMVujb+bVHOe3BIXLzcf0
   FseIvNM2kGL9rsUW0DD7ISFc6GCT0ZnL0FChuMeaMRMhSq+hSsMAYPhmc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="395207013"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="395207013"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 17:07:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="851987302"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="851987302"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.152.7])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 17:07:21 -0800
Subject: [PATCH 3/3] cxl: Make calling of find_cxl_root() declaration uniform
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Robert Richter <rrichter@amd.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
Date: Mon, 08 Jan 2024 18:07:20 -0700
Message-ID: <170476244072.115624.16860571023685051383.stgit@djiang5-mobl3>
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

Move the calling find_cxl_port() and the variable declaration into the
var declaration block and remove line breaks in the declaration. There are
no ordering issues that would require the declaration to be in middle of
the code.

Suggested-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c |    7 ++-----
 drivers/cxl/core/pmem.c |    3 +--
 drivers/cxl/port.c      |   11 +++++------
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 140935511bab..1d830d088389 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -162,6 +162,7 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
 static int cxl_port_perf_data_calculate(struct cxl_port *port,
 					struct xarray *dsmas_xa)
 {
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct access_coordinate c;
 	struct dsmas_entry *dent;
 	int valid_entries = 0;
@@ -174,8 +175,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 		return rc;
 	}
 
-	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
-
 	if (!cxl_root->ops || !cxl_root->ops->qos_class)
 		return -EOPNOTSUPP;
 
@@ -344,15 +343,13 @@ DEFINE_FREE(dpa_perf, struct list_head *, if (!list_empty(_T)) discard_dpa_perf(
 
 static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
 {
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(cxlmd->endpoint);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 	LIST_HEAD(__discard);
 	struct list_head *discard __free(dpa_perf) = &__discard;
 	int rc;
 
-	struct cxl_root *cxl_root __free(put_cxl_root) =
-		find_cxl_root(cxlmd->endpoint);
-
 	/* Check that the QTG IDs are all sane between end device and root decoders */
 	cxl_qos_match(cxl_root, &mds->ram_perf_list, discard);
 	cxl_qos_match(cxl_root, &mds->pmem_perf_list, discard);
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index ed76d37e4fd9..976212e588bc 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -64,8 +64,7 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
 
 struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
 {
-	struct cxl_root *cxl_root __free(put_cxl_root) =
-		find_cxl_root(cxlmd->endpoint);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(cxlmd->endpoint);
 	struct device *dev;
 
 	dev = device_find_child(&cxl_root->port.dev, NULL, match_nvdimm_bridge);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c054e7b13bdd..2bacf48593e6 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -91,6 +91,11 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 
 static int cxl_endpoint_port_probe(struct cxl_port *port)
 {
+	/*
+	 * This can't fail in practice as CXL root exit unregisters all
+	 * descendant ports and that in turn synchronizes with cxl_port_probe()
+	 */
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct cxl_endpoint_dvsec_info info = { .port = port };
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -125,12 +130,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
-	/*
-	 * This can't fail in practice as CXL root exit unregisters all
-	 * descendant ports and that in turn synchronizes with cxl_port_probe()
-	 */
-	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
-
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
 	 * assemble regions from committed decoders


