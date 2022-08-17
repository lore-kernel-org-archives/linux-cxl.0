Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BF5C25B08
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Aug 2022 21:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241321AbiHQVVy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Aug 2022 17:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiHQVVx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 Aug 2022 17:21:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C6CA5992
        for <linux-cxl@vger.kernel.org>; Wed, 17 Aug 2022 14:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660771312; x=1692307312;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hHnadg+FQz/bxwMasnEh5F8RFZep1jQ+3pDdoqRodEM=;
  b=nLvNnoBSOzCWDGhBmRIV8LgQfOo0vvTM+M6o+yi2JmIfSisq7D5gW7H9
   yptpeFG1klXaXzCiRkMT+4F31VxnE6Uehjkpz0cBdjjEL6MeAMEmO2yI2
   xEVbkiI8pQFjS7oxcP/he+Ua5TGceP3Gkwd7DSd1Gz5DC4BnSGM551yAI
   8/Nip9azgGbB0Hr+bc4hiT/z0s7BKtRz/CJc2/SMzxJHnXVLr1d8HBkfq
   zDWcmsQ+6leNnROMQcMHp0SRYX+TCBEcOF63+JOqW92iAP4cFfFmEZWAm
   1s26Iq/eVmjKpZ+0VhUeuaYb3q3JcVqz2dPSvefkL4zLrWXHExfwlYOyJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="293397811"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="293397811"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:21:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="696929574"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:21:43 -0700
Subject: [PATCH v4 1/6] cxl: Add check for result of interleave ways plus
 granularity combo
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Wed, 17 Aug 2022 14:21:42 -0700
Message-ID: <166077130292.1743055.11442563469460270244.stgit@djiang5-desk4.jf.intel.com>
In-Reply-To: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
References: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
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
index 401148016978..28272b0196e6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -940,6 +940,42 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
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
@@ -1047,6 +1083,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
+	rc = cxl_interleave_capable(port, &cxlr->dev, iw, ig);
+	if (rc)
+		return rc;
+
 	cxld->interleave_ways = iw;
 	cxld->interleave_granularity = ig;
 	cxld->hpa_range = (struct range) {
@@ -1196,6 +1236,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
@@ -1214,7 +1260,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		}
 	}
 
-	ep_port = cxled_to_port(cxled);
 	root_port = cxlrd_to_port(cxlrd);
 	dport = cxl_find_dport_by_dev(root_port, ep_port->host_bridge);
 	if (!dport) {


