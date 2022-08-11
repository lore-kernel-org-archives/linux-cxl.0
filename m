Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09FCC25B06
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Aug 2022 23:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiHKX46 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Aug 2022 19:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiHKX45 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Aug 2022 19:56:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D7B9FABA
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660262216; x=1691798216;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=veC3xzGemXB2uVKBGQIWOkScK2u1aIifkusXF1Q1Dl4=;
  b=mZLikFXhyL+YykOZpt5ZglxK6y0HT0Bj9DwGL0xnhr74cKDBDlybwnhS
   c1XrYnV47AlTAAfETEd5m9pLX9Np04i4j3sNmAgK/f/fjgM/fqRA0jeGM
   pyhYXKrjKX8igmPq+H0oiQI0LzDGwTSbuLuIu3M4HeqDiHhHVFMvES5oH
   BQn/EkUl1BRtJDq3xG6O7tpKidk3C7JTZl4MQE2oFOw/mIc8elAUhha3c
   owFG+Xdsyq13dpTcByxccd9TwW1ZNHr4ap/c+TORmGCf3GfPtWmUQ+TpI
   Ccr+0lzTPQKdPi1BQhWsdGAhI+AGg0Fvg4lFpxtfj621K/gFXVtr4yzCS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="290241412"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="290241412"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 16:56:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="556329216"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 16:56:55 -0700
Subject: [PATCH v2 1/3] cxl: Add check for result of interleave ways plus
 granularity combo
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Thu, 11 Aug 2022 16:56:55 -0700
Message-ID: <166026221529.1454405.7141583168966440657.stgit@djiang5-desk4.jf.intel.com>
In-Reply-To: <166026184968.1454405.494690416353090765.stgit@djiang5-desk4.jf.intel.com>
References: <166026184968.1454405.494690416353090765.stgit@djiang5-desk4.jf.intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c |   11 ++++++++++-
 drivers/cxl/cxlmem.h      |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cf5d5811fe4c..6f77ad22d47d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1081,6 +1081,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
+	rc = cxl_interleave_capable(port, &cxlr->dev, iw, ig);
+	if (rc)
+		return rc;
+
 	cxld->interleave_ways = iw;
 	cxld->interleave_granularity = ig;
 	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport),
@@ -1218,6 +1222,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
@@ -1236,7 +1246,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		}
 	}
 
-	ep_port = cxled_to_port(cxled);
 	root_port = cxlrd_to_port(cxlrd);
 	dport = cxl_find_dport_by_dev(root_port, ep_port->host_bridge);
 	if (!dport) {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 88e3a8e54b6a..625fce0b6c2c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -401,6 +401,43 @@ struct cxl_hdm {
 	struct cxl_port *port;
 };
 
+static inline int cxl_interleave_capable(struct cxl_port *port,
+					 struct device *dev,
+					 int ways, int granularity)
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
+		dev_warn(dev,
+			 "%s:%s interleave (eig: %d eiw: %d mask: %#x) exceed cap (mask: %#x)\n",
+			 dev_name(port->uport), dev_name(&port->dev), eig, eiw,
+			 cxlhdm->interleave_mask, addr_mask);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);


