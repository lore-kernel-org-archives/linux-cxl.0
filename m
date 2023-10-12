Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859BE2AB39
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYfinP+i"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A16083
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136944; x=1728672944;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Us4xbz1jEw5CIMuHHOMNuigmLVLkQCoc0iTk+tbOmYA=;
  b=TYfinP+iweWeeVwlYEFnVKa2ZG8Ii1GfFGBPwCOWfQHRMlKnOgEXNr/Z
   Mz9lTB7jA2WaRu6dOuhIRYkPUOFwavTMJ/Kx+0/MlgzuHJh8scSKtOMQX
   acMMXGYqcP/XUUusiwQQJPS1HnS4rYGW8x+SZFsSFgpqbkOGYFUd37N5M
   9y4BeLUzKIcAKdGy2wlI+Hnm0QfcXah7+OIyU+kc3F3AirHQhhJYDnktG
   B63rpUEj49ckPZv36mRc8bOiP7QRhGpnOQlao8Kp6dbiYOPkSLjK/cI+a
   YKTEzHJq+W6JVT4UBEEbS1DZV51wY004eOSSW2R1yIy34R6M/6fOW4U8u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="388880518"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="388880518"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:55:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="870711774"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="870711774"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.15.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:55:42 -0700
Subject: [PATCH v11 22/22] cxl: Check qos_class validity on memdev probe
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 12 Oct 2023 11:55:41 -0700
Message-ID: <169713694184.2205276.9863653630713216825.stgit@djiang5-mobl3>
In-Reply-To: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a check to make sure the qos_class for the device will match one of
the root decoders qos_class. If no match is found, then the qos_class for
the device is set to invalid. Also add a check to ensure that the device's
host bridge matches to one of the root decoder's downstream targets.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v11:
- Return when matched in match function (Jonathan)
- Don't return after matched in caller function, still need to check pmem. (Jonathan)
- Fix copy/paste error for pmem_qos_class. (Jonathan)
- Use device_for_each_child() instead of bus_for_each_dev(). (Dan)
- Add match of host_bridge to a root decoder target. (Dan)
---
 drivers/cxl/mem.c |  121 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 317c7548e4e9..74f72e37ccfc 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -104,6 +104,123 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
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
+	struct qos_class_ctx ctx;
+	struct qos_hb_ctx hbctx;
+	struct cxl_port *root_port;
+	int rc;
+
+	root_port = find_cxl_root(cxlmd->endpoint);
+	if (!root_port)
+		return -ENODEV;
+
+	/* Check that the QTG IDs are all sane between end device and root decoders */
+	if (mds->ram_qos_class != CXL_QOS_CLASS_INVALID) {
+		ctx = (struct qos_class_ctx) {
+			.matched = false,
+			.dev_qos_class =  mds->ram_qos_class,
+		};
+		rc = device_for_each_child(&root_port->dev, &ctx, match_cxlrd_qos_class);
+		if (rc < 0)
+			goto out;
+
+		if (!ctx.matched)
+			mds->ram_qos_class = CXL_QOS_CLASS_INVALID;
+	}
+
+	if (mds->pmem_qos_class != CXL_QOS_CLASS_INVALID) {
+		ctx = (struct qos_class_ctx) {
+			.matched = false,
+			.dev_qos_class =  mds->pmem_qos_class,
+		};
+		rc = device_for_each_child(&root_port->dev, &ctx, match_cxlrd_qos_class);
+		if (rc < 0)
+			goto out;
+
+		if (!ctx.matched)
+			mds->pmem_qos_class = CXL_QOS_CLASS_INVALID;
+	}
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
+		mds->ram_qos_class = CXL_QOS_CLASS_INVALID;
+		mds->pmem_qos_class = CXL_QOS_CLASS_INVALID;
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
@@ -173,6 +290,10 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	rc = cxl_qos_class_verify(cxlmd);
+	if (rc < 0)
+		return rc;
+
 	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
 		rc = devm_cxl_add_nvdimm(cxlmd);
 		if (rc == -ENODEV)


