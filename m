Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA105C77B61
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 05:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjC0FD1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjC0FDX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 01:03:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EDF4230
        for <linux-cxl@vger.kernel.org>; Sun, 26 Mar 2023 22:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679893402; x=1711429402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bg78VwnU1HCF8UScppD8XxEXYi/d+QDJY+9Rr5LI/1w=;
  b=kqr1+nSRk/DSfziLMkga5n0SwhMM1E6zrgrZ/1lDKdJToKhmG0ycyV89
   eoIL4zW/6l2ho4KzGciHUH22uilCivwZHgf6EAqRArsJY4cwZoxAWvm7b
   +auhL+dGv2znGWjSrIPl0Fy/WminzmWwcqSEcAXbBbmL8jlq9cccsQRB4
   q3pIy7Cseqc806Sq24h6LgSg6fvnHIxK+P4InS2Q3/+xbrdJ43ZiBMUbM
   XkMbvvNGQO1aiSAzvAv/tSY1kf94RGIHrU33EASGlOPOsQRPlsjnsIPlZ
   +JfHPCroCMjZfA3+aEzIUBoJVpQYCE/Iwz2gy8ai8J4FnZBHJ/6HSsg7G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367920182"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="367920182"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="633492255"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="633492255"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.227.2])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:21 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 03/12] cxl/memdev: Warn of poison inject or clear to a mapped region
Date:   Sun, 26 Mar 2023 22:03:09 -0700
Message-Id: <fc7db7de4778803a3221d7fd5a203bf971fdac61.1679892337.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679892337.git.alison.schofield@intel.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
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
 drivers/cxl/core/memdev.c | 59 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 0e39c3c3fb09..a83619c31f61 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -213,6 +213,50 @@ ssize_t cxl_trigger_poison_list(struct device *dev,
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
+	return 0;
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
@@ -242,6 +286,7 @@ int cxl_inject_poison(struct device *dev, u64 dpa)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_mbox_inject_poison inject;
 	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_region *cxlr;
 	int rc;
 
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
@@ -261,6 +306,13 @@ int cxl_inject_poison(struct device *dev, u64 dpa)
 		.payload_in = &inject,
 	};
 	rc = cxl_internal_send_cmd(cxlmd->cxlds, &mbox_cmd);
+	if (rc)
+		goto out;
+
+	cxlr = cxl_dpa_to_region(cxlmd, dpa);
+	if (cxlr)
+		dev_warn_once(dev, "poison inject dpa:0x%llx region: %s\n",
+			      dpa, dev_name(&cxlr->dev));
 out:
 	up_read(&cxl_dpa_rwsem);
 
@@ -273,6 +325,7 @@ int cxl_clear_poison(struct device *dev, u64 dpa)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_mbox_clear_poison clear;
 	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_region *cxlr;
 	int rc;
 
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
@@ -303,7 +356,13 @@ int cxl_clear_poison(struct device *dev, u64 dpa)
 	};
 
 	rc = cxl_internal_send_cmd(cxlmd->cxlds, &mbox_cmd);
+	if (rc)
+		goto out;
 
+	cxlr = cxl_dpa_to_region(cxlmd, dpa);
+	if (cxlr)
+		dev_warn_once(dev, "poison clear dpa:0x%llx region: %s\n",
+			      dpa, dev_name(&cxlr->dev));
 out:
 	up_read(&cxl_dpa_rwsem);
 
-- 
2.37.3

