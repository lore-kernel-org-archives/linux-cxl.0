Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E1320E0
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 01:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1XqnG0f"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FAEA7
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 18:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696986433; x=1728522433;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fxo/ka0hXBZxQZj9XhZynHE7F7YsEUglaFDeaVmG1kI=;
  b=O1XqnG0fZgrr5qVBERxQHIzPP6wECq1WsEd0XEuhDiJWcqSa/ousqrCx
   EghuOd4Fh8q6KpE51MrO7PzVmz05A6xQnrkjvRK+0gPsVBPqOGP5QYvSe
   +lo5x7ColUSXY8/LX6XmIZRbdGkLqxua2agMQ7NYVKoLPDt0POGY9x06O
   szwQBf0aLgWIHzfkBrRwyigUvMpLL7EiNfVWB+qt2nxmd0Pxd1i1jhe3y
   XVA0sZ+tup+uVaWbLL0l+kl6ZVJnT4PbJgIlGSvnHJzrlwlUP04NtbM0S
   g971ntuPAM8Jky/qbJfe0ir809Q2C14m3YTa3mZmJtQlIfl6ToCnJ4+nu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388419719"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="388419719"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:07:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="823976664"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="823976664"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.35.251])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:07:12 -0700
Subject: [PATCH v10 22/22] cxl: Check qos_class validity on memdev probe
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 10 Oct 2023 18:07:11 -0700
Message-ID: <169698643180.1991735.11469426905286068135.stgit@djiang5-mobl3>
In-Reply-To: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a check to make sure the qos_class for the device will match one of
the root decoders qos_class. If no match is found, then the qos_class for
the device is set to invalid.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/mem.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 317c7548e4e9..3495119d2edf 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -104,6 +104,70 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
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
+	if (ctx->matched)
+		return 0;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(dev);
+	if (cxlrd->qos_class == CXL_QOS_CLASS_INVALID ||
+	    ctx->dev_qos_class == CXL_QOS_CLASS_INVALID)
+		return 0;
+
+	if (cxlrd->qos_class == ctx->dev_qos_class)
+		ctx->matched = 1;
+
+	return 0;
+}
+
+static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
+{
+	struct device *dev = &cxlmd->dev;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct qos_class_ctx ctx;
+	int rc;
+
+	if (mds->ram_qos_class != CXL_QOS_CLASS_INVALID) {
+		ctx.matched = false;
+		ctx.dev_qos_class =  mds->ram_qos_class;
+		rc = bus_for_each_dev(dev->bus, NULL, &ctx, match_cxlrd_qos_class);
+		if (rc)
+			return rc;
+
+		if (ctx.matched)
+			return 0;
+
+		mds->ram_qos_class = CXL_QOS_CLASS_INVALID;
+	}
+
+	if (mds->pmem_qos_class != CXL_QOS_CLASS_INVALID) {
+		ctx.matched = false;
+		ctx.dev_qos_class = mds->pmem_qos_class;
+		rc = bus_for_each_dev(dev->bus, NULL, &ctx, match_cxlrd_qos_class);
+		if (rc)
+			return rc;
+
+		if (ctx.matched)
+			return 0;
+
+		mds->ram_qos_class = CXL_QOS_CLASS_INVALID;
+	}
+
+	return 0;
+}
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -181,6 +245,10 @@ static int cxl_mem_probe(struct device *dev)
 			return rc;
 	}
 
+	rc = cxl_qos_class_verify(cxlmd);
+	if (rc)
+		return rc;
+
 	/*
 	 * The kernel may be operating out of CXL memory on this device,
 	 * there is no spec defined way to determine whether this device


