Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAC3ECAA24
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Aug 2022 16:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbiHYQJM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242947AbiHYQJI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 25 Aug 2022 12:09:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B211B941B
        for <linux-cxl@vger.kernel.org>; Thu, 25 Aug 2022 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661443748; x=1692979748;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DXPAPk5sgimghpSz3bZw0wPQ8/s6bGtqJP4TlhHMeEo=;
  b=AhaZroBNmcdBq2PdHV0JnrIhL+PG9kIuD3zRmck00BBcy+7txKLFBsLO
   CpGSFUpGepQwIjDXFqj5TD+vQ10FoLTG4yooTYG7C0chtTqAqeoc2pnUK
   YVgJF3CyhdOjSXoS4sz0ZHfb1dcRLFQy+3vLJISbfedHRs7kJbe3aNi6v
   TBo5Xr8h9pKd/+W0rpU66ZLTTqh44FjWjESP9deZdahAVveLm/jYKjgeM
   CbX2ddnJdhOifaRlatf+FAuuzjApAXHT0gzHsdOQGpLMsUsoPbKZMZ8Ei
   WMYgfBDgMBH0/Em0MBV8cIjO/WauCph0OtMCcI7LgUMbwVDe/f7bBN2bS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="274034747"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="274034747"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:07:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="586932563"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:07:40 -0700
Subject: [PATCH v5 1/6] cxl: Add check for result of interleave ways plus
 granularity combo
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Thu, 25 Aug 2022 09:07:40 -0700
Message-ID: <166144366038.745916.13425367025352369885.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166144343809.745916.16054560464363829844.stgit@djiang5-desk3.ch.intel.com>
References: <166144343809.745916.16054560464363829844.stgit@djiang5-desk3.ch.intel.com>
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

Calculation refers to CXL spec rev3.0 8.2.4.19.13 implementation note #3.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c    |   47 +++++++++++++++++++++++++++++++++++++++++-
 tools/testing/cxl/test/cxl.c |    1 +
 2 files changed, 47 insertions(+), 1 deletion(-)

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
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index a072b2d3e726..4b361ed63333 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -398,6 +398,7 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port)
 		return ERR_PTR(-ENOMEM);
 
 	cxlhdm->port = port;
+	dev_set_drvdata(&port->dev, cxlhdm);
 	return cxlhdm;
 }
 


