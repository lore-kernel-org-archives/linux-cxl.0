Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE48C77B7A
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Apr 2023 03:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjDSD0q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSD0o (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 23:26:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1632D102
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 20:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681874803; x=1713410803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PtfKmG5rewyNXN/q4um6AZ9OEEkMeT5Kma42U4J6gRw=;
  b=cCoPFIghg0g+agqgSNodQ4ULgRvAg9utuSrILGseh2QW/U0YkYK7gD6h
   s6bV5mptHD5EzL7a6Yen106XMNvqm6oPmDDieBHKBgK+Mo+mpjIYlLzMG
   tFQ2QLnQqumWwfXniSMGSxhB9gdBXXjkR73YQCaMKXckg/RIFSDb67dm/
   utl+pAXpUUDjPEmwW/JyfMz9cSo6q3s23GuoI7/hUT4pBi/QNtKLglcoK
   2yjIM7NGybZiNJJrSdRwPAh9hv+vhx3eKBYcP7xmgpZ8ybfnrP3WNYuZs
   /M7FDg0w6sk06J3oRzUFb5lT1e1/jq8HJtnpmNhb7y+TPxpuIRek7c8AP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431621701"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="431621701"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780711103"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="780711103"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:42 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v6 03/10] cxl/memdev: Warn of poison inject or clear to a mapped region
Date:   Tue, 18 Apr 2023 20:26:27 -0700
Message-Id: <f911ca5277c9d0f9757b72d7e6842871bfff4fa2.1681874357.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1681874357.git.alison.schofield@intel.com>
References: <cover.1681874357.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Inject and clear poison capabilities and intended for debug usage only.
In order to be useful in debug environments, the driver needs to allow
inject and clear operations on DPAs mapped in regions.

dev_warn_once() when either operation occurs.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/memdev.c | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 3b48b6eec007..23ac8d322b37 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -160,6 +160,50 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_trigger_poison_list, CXL);
 
+struct cxl_dpa_to_region_context {
+	struct cxl_region *cxlr;
+	u64 dpa;
+};
+
+static int __cxl_dpa_to_region(struct device *dev, void *arg)
+{
+	struct cxl_dpa_to_region_context *ctx = arg;
+	struct cxl_endpoint_decoder *cxled;
+	u64 dpa = ctx->dpa;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
+		return 0;
+
+	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
+		return 0;
+
+	dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n", dpa,
+		dev_name(&cxled->cxld.region->dev));
+
+	ctx->cxlr = cxled->cxld.region;
+
+	return 1;
+}
+
+static struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
+{
+	struct cxl_dpa_to_region_context ctx;
+	struct cxl_port *port;
+
+	ctx = (struct cxl_dpa_to_region_context) {
+		.dpa = dpa,
+	};
+	port = dev_get_drvdata(&cxlmd->dev);
+	if (port && is_cxl_endpoint(port) && port->commit_end != -1)
+		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
+
+	return ctx.cxlr;
+}
+
 static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -189,6 +233,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_mbox_inject_poison inject;
 	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_region *cxlr;
 	int rc;
 
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
@@ -209,6 +254,13 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.payload_in = &inject,
 	};
 	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+	if (rc)
+		goto out;
+
+	cxlr = cxl_dpa_to_region(cxlmd, dpa);
+	if (cxlr)
+		dev_warn_once(cxlds->dev, "poison inject dpa:0x%llx region: %s\n",
+			      dpa, dev_name(&cxlr->dev));
 out:
 	up_read(&cxl_dpa_rwsem);
 
@@ -221,6 +273,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_mbox_clear_poison clear;
 	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_region *cxlr;
 	int rc;
 
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
@@ -252,6 +305,11 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
 	if (rc)
 		goto out;
+
+	cxlr = cxl_dpa_to_region(cxlmd, dpa);
+	if (cxlr)
+		dev_warn_once(cxlds->dev, "poison inject dpa:0x%llx region: %s\n",
+			      dpa, dev_name(&cxlr->dev));
 out:
 	up_read(&cxl_dpa_rwsem);
 
-- 
2.37.3

