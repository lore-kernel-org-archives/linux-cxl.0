Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD643A49
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 01:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkTbN4kv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704762435; x=1736298435;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X8vkL3GwBiVtKokP1geHDRhoKwip6Rz4K1hopcJw0Go=;
  b=SkTbN4kvQza7oTMD3U0rflIkACoiqw061DQzhFB0cAoZLbk0W4/tQHka
   BT8R6ABbGzWpmA5xPqC23rxsk+7kKudE+/y+/z7U+4Oq/8kusrRIudc/z
   SHop9J9qO4JvxpQwZFjvSCjVqNo5mBQ+URrY+3KDw9OXCT9qBksW5k9FT
   2G0nfe1TNUS22Q6qRoGLLkk4riOgs9LGTUNI3n3EENiL85jQfmrLpFFul
   FFOMYFOPFcM17WXMzN0/XWRk88AS2lxTrk99tdU7AbBX0hvQUmm2FXYsE
   mu6IJLJJ4d9DXmU6lCOuGu80HNAFGGCapf2tMkNekGNh3JsPIskYNqeNM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="395207000"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="395207000"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 17:07:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="851987275"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="851987275"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.152.7])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 17:07:15 -0800
Subject: [PATCH 2/3] cxl: Cleanup unnecessary uages of cxl_port local vars
 from cxl_root
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Robert Richter <rrichter@amd.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
Date: Mon, 08 Jan 2024 18:07:14 -0700
Message-ID: <170476243490.115624.648453218819673314.stgit@djiang5-mobl3>
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

Remove the local vars that points to the 'struct cxl_port' withint 'struct
cxl_root' and refer to the port directly.

Suggested-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c |   13 +++++--------
 drivers/cxl/port.c      |    5 +----
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index f7ba7bd2e459..140935511bab 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -290,7 +290,7 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
 	return 0;
 }
 
-static void cxl_qos_match(struct cxl_port *root_port,
+static void cxl_qos_match(struct cxl_root *cxl_root,
 			  struct list_head *work_list,
 			  struct list_head *discard_list)
 {
@@ -302,7 +302,7 @@ static void cxl_qos_match(struct cxl_port *root_port,
 		if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
 			return;
 
-		rc = device_for_each_child(&root_port->dev,
+		rc = device_for_each_child(&cxl_root->port.dev,
 					   (void *)&dpa_perf->qos_class,
 					   match_cxlrd_qos_class);
 		if (!rc)
@@ -348,20 +348,17 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 	LIST_HEAD(__discard);
 	struct list_head *discard __free(dpa_perf) = &__discard;
-	struct cxl_port *root_port;
 	int rc;
 
 	struct cxl_root *cxl_root __free(put_cxl_root) =
 		find_cxl_root(cxlmd->endpoint);
 
-	root_port = &cxl_root->port;
-
 	/* Check that the QTG IDs are all sane between end device and root decoders */
-	cxl_qos_match(root_port, &mds->ram_perf_list, discard);
-	cxl_qos_match(root_port, &mds->pmem_perf_list, discard);
+	cxl_qos_match(cxl_root, &mds->ram_perf_list, discard);
+	cxl_qos_match(cxl_root, &mds->pmem_perf_list, discard);
 
 	/* Check to make sure that the device's host bridge is under a root decoder */
-	rc = device_for_each_child(&root_port->dev,
+	rc = device_for_each_child(&cxl_root->port.dev,
 				   (void *)cxlmd->endpoint->host_bridge,
 				   match_cxlrd_hb);
 	if (!rc) {
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 97c21566677a..c054e7b13bdd 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -95,7 +95,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_hdm *cxlhdm;
-	struct cxl_port *root;
 	int rc;
 
 	rc = cxl_dvsec_rr_decode(cxlds->dev, cxlds->cxl_dvsec, &info);
@@ -132,13 +131,11 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	 */
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 
-	root = &cxl_root->port;
-
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
 	 * assemble regions from committed decoders
 	 */
-	device_for_each_child(&port->dev, root, discover_region);
+	device_for_each_child(&port->dev, &cxl_root->port, discover_region);
 
 	return 0;
 }


