Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79815C00140
	for <linux-cxl@archiver.kernel.org>; Mon, 15 Aug 2022 18:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiHOSLx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 Aug 2022 14:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHOSLu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 Aug 2022 14:11:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2611E22BF6
        for <linux-cxl@vger.kernel.org>; Mon, 15 Aug 2022 11:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660587110; x=1692123110;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=URYSP0wnd5ASq7yquhEf+kFoO/CkPhZo0x0j0rEhfPE=;
  b=WdNxKRxCjmr1tO0m7m/b1G+1epVvMh72hf0pVSGFO3MgBewgGZgMCMfa
   Tflp/CH1k/1Sbrtr+0jFw9Eu6nYOZ8q79gNMwsBWcDWy9uVAK9t9kvdnz
   onLYwZQ9Jrvl4Xp6CyZU77HV/jHUV5t4IYYpZ29nU0tergdlUcltadCNE
   l+QuYcf5P20KyDRmXcXlH+lQEUx/1nGy2VUop6HurFDh+5q2ehFsW0W42
   uknLgo0txco66HawFDLyV11v4OI94ar4KzGDUXRCumdGG9hekrj88AcZQ
   mlF5V1pKIxqWbQpaAx1MjY8/x9fxeM5kPo21Pcbdkq8sN86kf8aksSkaH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="353770112"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="353770112"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 11:11:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="635578159"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 11:11:49 -0700
Subject: [PATCH v3 1/3] cxl: Add check for result of interleave ways plus
 granularity combo
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 15 Aug 2022 11:11:49 -0700
Message-ID: <166058710897.1520730.9859948609285895778.stgit@djiang5-desk4.jf.intel.com>
In-Reply-To: <166058698949.1520730.1888371264289688061.stgit@djiang5-desk4.jf.intel.com>
References: <166058698949.1520730.1888371264289688061.stgit@djiang5-desk4.jf.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a helper function to check the combination of interleave ways and
interleave granularity together is sane against the interleave mask from
the HDM decoder. Add the check to cxl_region_attach() to make sure the
region config is sane. Add the check to cxl_port_setup_targets() to make
sure the port setup config is also sane.

Calculation refers to CXL spec v3 8.2.4.19.13 implementation note #3.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c |   47 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cf5d5811fe4c..5b7e909e937d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -997,6 +997,42 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
 	return 0;
 }
 
+static int cxl_interleave_capable(struct cxl_port *port, struct device *dev,
+				  int ways, int granularity)
+{
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	unsigned int addr_mask;
+	u16 eig;
+	u8 eiw;
+	int rc;
+
+	rc = granularity_to_cxl(granularity, &eig);
+	if (rc)
+		return rc;
+
+	rc = ways_to_cxl(ways, &eiw);
+	if (rc)
+		return rc;
+
+	if (eiw == 0)
+		return 0;
+
+	if (is_power_of_2(eiw))
+		addr_mask = GENMASK(eig + 8 + eiw - 1, eig + 8);
+	else
+		addr_mask = GENMASK((eig + eiw) / 3 - 1, eig + 8);
+
+	if (~cxlhdm->interleave_mask & addr_mask) {
+		dev_dbg(dev,
+			"%s:%s interleave (eig: %d eiw: %d mask: %#x) exceed cap (mask: %#x)\n",
+			dev_name(port->uport), dev_name(&port->dev), eig, eiw,
+			cxlhdm->interleave_mask, addr_mask);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
@@ -1081,6 +1117,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
+	rc = cxl_interleave_capable(port, &cxlr->dev, iw, ig);
+	if (rc)
+		return rc;
+
 	cxld->interleave_ways = iw;
 	cxld->interleave_granularity = ig;
 	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport),
@@ -1218,6 +1258,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -EBUSY;
 	}
 
+	ep_port = cxled_to_port(cxled);
+	rc = cxl_interleave_capable(ep_port, &cxlr->dev, p->interleave_ways,
+				    p->interleave_granularity);
+	if (rc)
+		return rc;
+
 	for (i = 0; i < p->interleave_ways; i++) {
 		struct cxl_endpoint_decoder *cxled_target;
 		struct cxl_memdev *cxlmd_target;
@@ -1236,7 +1282,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		}
 	}
 
-	ep_port = cxled_to_port(cxled);
 	root_port = cxlrd_to_port(cxlrd);
 	dport = cxl_find_dport_by_dev(root_port, ep_port->host_bridge);
 	if (!dport) {


