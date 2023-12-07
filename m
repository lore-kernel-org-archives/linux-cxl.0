Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1LF+oxN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC6F10EF
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 15:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701990024; x=1733526024;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=prHcGeVSecpmoEantUObn/owotRaczDNxyc4Bfs9cVU=;
  b=e1LF+oxNs4SCTviRgGOQR1G27QbwTPD7OS+g0OgZXYQY6iR8md7TvPrp
   ZOsUbu+olIF4tNtNU8XZ1oP57fYyCoN4m5ZbHDNNaBjOeJ/mug2487ips
   O71hLizCxTeDmtmXTJxBpUPizmnsnGFKLgzkkjUUMM1ojwLHIoDnw9eF9
   IRBuP1hXpmGV5enMJMoIzZWKmRPXQuiWIWy907nUuTu/YCnRH/XyTSFXa
   /i71i3YYBkmG3q2bttV+qzOzU15zOBBj+sK83JWFACoO3iBQubL2YS82Z
   ld7NS+XjA9lr5wrRbj16mp6vgFDH/eLZlSkeIgUnArslge0uxhH152xSL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="7679152"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="7679152"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:00:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="945216964"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="945216964"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:00:22 -0800
Subject: [PATCH v13 19/19] cxl: Check qos_class validity on memdev probe
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 16:00:21 -0700
Message-ID: <170199002143.3522351.186172408065772961.stgit@djiang5-mobl3>
In-Reply-To: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
References: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a check to make sure the qos_class for the device will match one of
the root decoders qos_class. If no match is found, then the qos_class for
the device is set to invalid. Also add a check to ensure that the device's
host bridge matches to one of the root decoder's downstream targets.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/mem.c |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index e087febf9af0..2bc5e7ec2723 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -103,6 +103,135 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
 			 cxl_debugfs_poison_clear, "%llx\n");
 
+struct qos_class_ctx {
+	bool matched;
+	int dev_qos_class;
+};
+
+static int match_cxlrd_qos_class(struct device *dev, void *data)
+{
+	struct qos_class_ctx *ctx = data;
+	struct cxl_root_decoder *cxlrd;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(dev);
+	if (cxlrd->qos_class == CXL_QOS_CLASS_INVALID ||
+	    ctx->dev_qos_class == CXL_QOS_CLASS_INVALID)
+		return 0;
+
+	if (cxlrd->qos_class == ctx->dev_qos_class) {
+		ctx->matched = 1;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int cxl_qos_match(struct cxl_port *root_port,
+			 struct list_head *work_list,
+			 struct list_head *discard_list)
+{
+	struct perf_prop_entry *perf, *n;
+	struct qos_class_ctx ctx;
+	int rc;
+
+	if (list_empty(work_list))
+		return 0;
+
+	list_for_each_entry_safe(perf, n, work_list, list) {
+		ctx = (struct qos_class_ctx) {
+			.matched = false,
+			.dev_qos_class = perf->qos_class,
+		};
+		rc = device_for_each_child(&root_port->dev, &ctx, match_cxlrd_qos_class);
+		if (rc < 0)
+			return -ENOENT;
+
+		if (!ctx.matched)
+			list_move_tail(&perf->list, discard_list);
+	}
+
+	return 0;
+}
+
+struct qos_hb_ctx {
+	bool matched;
+	struct device *host_bridge;
+};
+
+static int match_cxlrd_hb(struct device *dev, void *data)
+{
+	struct cxl_switch_decoder *cxlsd;
+	struct qos_hb_ctx *ctx = data;
+	struct cxl_root_decoder *cxlrd;
+	unsigned int seq;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(dev);
+	cxlsd = &cxlrd->cxlsd;
+
+	do {
+		seq = read_seqbegin(&cxlsd->target_lock);
+		for (int i = 0; i < cxlsd->nr_targets; i++) {
+			if (ctx->host_bridge ==
+			    cxlsd->target[i]->dport_dev) {
+				ctx->matched = true;
+				return 1;
+			}
+		}
+	} while (read_seqretry(&cxlsd->target_lock, seq));
+
+	return 0;
+}
+
+static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_port *root_port;
+	struct qos_hb_ctx hbctx;
+	int rc;
+
+	root_port = find_cxl_root(cxlmd->endpoint);
+	if (!root_port)
+		return -ENODEV;
+
+	/* Check that the QTG IDs are all sane between end device and root decoders */
+	rc = cxl_qos_match(root_port, &mds->ram_perf_list,
+			   &mds->unmatched_perf_list);
+	if (rc < 0)
+		goto out;
+
+	rc = cxl_qos_match(root_port, &mds->pmem_perf_list,
+			   &mds->unmatched_perf_list);
+	if (rc < 0)
+		goto out;
+
+	/* Check to make sure that the device's host bridge is under a root decoder */
+	hbctx = (struct qos_hb_ctx) {
+		.matched = false,
+		.host_bridge = cxlmd->endpoint->host_bridge,
+	};
+	rc = device_for_each_child(&root_port->dev, &hbctx, match_cxlrd_hb);
+	if (rc < 0)
+		goto out;
+
+	if (!hbctx.matched) {
+		list_splice_tail_init(&mds->ram_perf_list,
+				      &mds->unmatched_perf_list);
+		list_splice_tail_init(&mds->pmem_perf_list,
+				      &mds->unmatched_perf_list);
+	}
+
+out:
+	put_device(&root_port->dev);
+	return rc;
+}
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -174,6 +303,10 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	rc = cxl_qos_class_verify(cxlmd);
+	if (rc < 0)
+		dev_dbg(dev, "QoS Class verify failed\n");
+
 	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
 		rc = devm_cxl_add_nvdimm(cxlmd);
 		if (rc == -ENODEV)


