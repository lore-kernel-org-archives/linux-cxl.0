Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF7826AC0
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 23:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7rW5OCY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C04DD
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 15:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700003159; x=1731539159;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jc2F56u+9AdSoHZrfDvdsAWkwXMOOLlf6woInj4LXeg=;
  b=K7rW5OCYNuNZncjesdd2cTiUVZvm3hwUuhRkheDusHhnSILAKiZ76a2+
   FPMmM38Q+EwOXBB4qwKHolNs7OZF2tPHtbYjClWuyE4ssBu7Fxsqx1mMO
   rI0bgNsROgmJURiSLxJU7HpMhpWesaRm6p0eeCDgJbp6zpPN3VjlAX6A6
   XT1ajl0J55i8YEqtGyScL+WpBzxUZf9hDe59bI1kwE1CBKBfJkVNb1DYC
   Uf/49Jhj4AlNo5ZBH2hLKTweQEKRkl8FE2dH2IvnRgeYkTjjemGaOloO2
   bNW+tSHCCBMwvOT/eRK5raHQaa32QxU0d4F8sASkk6wD7JGxFrdZyWad3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12308587"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="12308587"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="12586033"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.87.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:58 -0800
Subject: [PATCH v12 18/18] cxl: Check qos_class validity on memdev probe
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 14 Nov 2023 16:05:57 -0700
Message-ID: <170000315736.1974471.2536413193288738547.stgit@djiang5-mobl3>
In-Reply-To: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
References: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
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
v12:
- Add support to match all QTG IDs (Dan)
- Do not stop probe if match fails. (Jonathan)
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


