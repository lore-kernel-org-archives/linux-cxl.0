Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWwOgsOe"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5CE185
	for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 08:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702485797; x=1734021797;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aU2LtPWhslWVLiwkxi8NyLXuaYYfupztAXVvhl+WoyM=;
  b=TWwOgsOed5db4zN50npRUP3m/27whBiBI8X5CNB5HybdSqIvv+oFo7o9
   2LoVlYP5kBzTTQNs0C3v6nJKWkHK28h7CzPpxnRVRqpLeTXzOuH4SwtoZ
   jSjtmxIQgRfpLUehu8eOYXNvNaebs6ML2CC5sIlwlWodY7w7lkQltwFUv
   oOhAtvfA8xR4lgaV3MsUNnlsaj/yoVoIEtdIPsumjIJX/wNota1WS39oJ
   b13w5CtyoV4IybOAGCy4UHgIPP+EqSbKH3+f5tcwdx7Um50Ubcg73rDSE
   3XPcSHPYc5z+EjkiYSeFOkeQ3RTcF98yNxTLRP5kMS3h024oZ89vL7T70
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="459310122"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="459310122"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:43:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="750178309"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="750178309"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.76.225])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:43:15 -0800
Subject: [PATCH v14 19/19] cxl: Check qos_class validity on memdev probe
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Wed, 13 Dec 2023 09:43:16 -0700
Message-ID: <170248579618.801570.17463788516390290503.stgit@djiang5-mobl3>
In-Reply-To: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
References: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
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
v14:
- Move unmatched entries to discard list (Dan)
- Update perf_prop_entry to cxl_dpa_perf (Dan)
- Use DEFINE_FREE() in cxl_qos_class_verify to clean up code (Dan)
- Move qos verify to core/cdat.c in order to be called before region setup
  (Dan)
---
 drivers/cxl/core/cdat.c |  137 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 8c561f1deec6..5fe57fe5e2ee 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -270,6 +270,142 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
 	devm_add_action_or_reset(&cxlds->cxlmd->dev, free_perf_ents, mds);
 }
 
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
+	struct cxl_dpa_perf *dpa_perf, *n;
+	struct qos_class_ctx ctx;
+	int rc;
+
+	if (list_empty(work_list))
+		return 0;
+
+	list_for_each_entry_safe(dpa_perf, n, work_list, list) {
+		ctx = (struct qos_class_ctx) {
+			.matched = false,
+			.dev_qos_class = dpa_perf->qos_class,
+		};
+		rc = device_for_each_child(&root_port->dev, &ctx, match_cxlrd_qos_class);
+		if (rc < 0)
+			return -ENOENT;
+
+		if (!ctx.matched)
+			list_move_tail(&dpa_perf->list, discard_list);
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
+static void discard_dpa_perf(struct list_head *list)
+{
+	struct cxl_dpa_perf *dpa_perf, *n;
+
+	list_for_each_entry_safe(dpa_perf, n, list, list) {
+		list_del(&dpa_perf->list);
+		kfree(dpa_perf);
+	}
+}
+DEFINE_FREE(dpa_perf, struct list_head *, if (_T) discard_dpa_perf(_T))
+
+static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_port *root_port __free(put_device) = NULL;
+	LIST_HEAD(__discard);
+	struct list_head *discard __free(dpa_perf) = &__discard;
+	struct qos_hb_ctx hbctx;
+	int rc;
+
+	root_port = find_cxl_root(cxlmd->endpoint);
+	if (!root_port)
+		return -ENODEV;
+
+	/* Check that the QTG IDs are all sane between end device and root decoders */
+	rc = cxl_qos_match(root_port, &mds->ram_perf_list, discard);
+	if (rc < 0)
+		return rc;
+
+	rc = cxl_qos_match(root_port, &mds->pmem_perf_list, discard);
+	if (rc < 0)
+		return rc;
+
+	/* Check to make sure that the device's host bridge is under a root decoder */
+	hbctx = (struct qos_hb_ctx) {
+		.matched = false,
+		.host_bridge = cxlmd->endpoint->host_bridge,
+	};
+	rc = device_for_each_child(&root_port->dev, &hbctx, match_cxlrd_hb);
+	if (rc < 0)
+		return rc;
+
+	if (!hbctx.matched) {
+		list_splice_tail_init(&mds->ram_perf_list, discard);
+		list_splice_tail_init(&mds->pmem_perf_list, discard);
+	}
+
+	return rc;
+}
+
 static void discard_dsmas(struct xarray *xa)
 {
 	unsigned long index;
@@ -308,6 +444,7 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
 	}
 
 	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
+	cxl_qos_class_verify(cxlmd);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
 


