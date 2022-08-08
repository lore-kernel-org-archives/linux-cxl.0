Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720EFC00140
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Aug 2022 21:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbiHHVHB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 Aug 2022 17:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiHHVG7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 Aug 2022 17:06:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8121213D19
        for <linux-cxl@vger.kernel.org>; Mon,  8 Aug 2022 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659992818; x=1691528818;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXqGFMJZSj/Jpi/etgUjQTVM93znx9qzEIo7pFN6NdI=;
  b=RX//2BawZ3snZ9Cbh5HEaAcbCGInAxcJViNi1Rbz6aBjbVAHMpFLb0w7
   9gnW5JqFtv9oNiNGoSJxbaktdl0YDgODtS2SU/AnB/NJ1oUj9ZEbpZXB9
   6BEMkeVVRUzUa2OYCc1gPXQJ2APoSTWQ+HAFa27oupYTVegivV/6rUD7P
   09sxV54drChq+FIeYDgZQ9sAdmyilz5CbnSL7bauMmMvm+EEdFLIldPua
   fdCEIOk8GFWX/f/Vjy1+oILeoLP3RGiKI2BtR7Lz52w1PVrRlxOp/j+/8
   axaXc+3oGASOseX0q+HCTvoMQdJgFg2IXjur2Qr6ubPI8UqTz2kBbIt6a
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="273742102"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="273742102"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 14:06:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="607977901"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 14:06:57 -0700
Subject: [PATCH 1/3] cxl: Add check for result of interleave ways plus
 granularity combo
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 08 Aug 2022 14:06:57 -0700
Message-ID: <165999281717.493131.1159254270127915425.stgit@djiang5-desk4.jf.intel.com>
In-Reply-To: <165999244272.493131.1975513183227389633.stgit@djiang5-desk4.jf.intel.com>
References: <165999244272.493131.1975513183227389633.stgit@djiang5-desk4.jf.intel.com>
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
 drivers/cxl/core/region.c |   17 ++++++++++++++++-
 drivers/cxl/cxl.h         |   11 +++++++++++
 drivers/cxl/cxlmem.h      |   31 +++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cf5d5811fe4c..a209a8de31fd 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1081,6 +1081,13 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
+	rc = cxl_interleave_verify(port, iw, ig);
+	if (rc) {
+		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave & granularity combo: %d\n",
+			dev_name(port->uport), dev_name(&port->dev), rc);
+		return rc;
+	}
+
 	cxld->interleave_ways = iw;
 	cxld->interleave_granularity = ig;
 	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport),
@@ -1218,6 +1225,15 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -EBUSY;
 	}
 
+	ep_port = cxled_to_port(cxled);
+	rc = cxl_interleave_verify(ep_port, p->interleave_ways,
+				   p->interleave_granularity);
+	if (rc) {
+		dev_dbg(&cxlr->dev, "%s: invalid interleave & granularity combo: %d\n",
+			dev_name(&cxlmd->dev), rc);
+		return rc;
+	}
+
 	for (i = 0; i < p->interleave_ways; i++) {
 		struct cxl_endpoint_decoder *cxled_target;
 		struct cxl_memdev *cxlmd_target;
@@ -1236,7 +1252,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		}
 	}
 
-	ep_port = cxled_to_port(cxled);
 	root_port = cxlrd_to_port(cxlrd);
 	dport = cxl_find_dport_by_dev(root_port, ep_port->host_bridge);
 	if (!dport) {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index bc604b7e44fb..275979fbd15a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -61,6 +61,17 @@
 #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
 #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
 
+enum {
+	CXL_INTERLEAVE_1_WAY = 0,
+	CXL_INTERLEAVE_2_WAY,
+	CXL_INTERLEAVE_4_WAY,
+	CXL_INTERLEAVE_8_WAY,
+	CXL_INTERLEAVE_16_WAY,
+	CXL_INTERLEAVE_3_WAY = 8,
+	CXL_INTERLEAVE_6_WAY,
+	CXL_INTERLEAVE_12_WAY
+};
+
 static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 {
 	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 88e3a8e54b6a..d5f872ca62f9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -401,6 +401,37 @@ struct cxl_hdm {
 	struct cxl_port *port;
 };
 
+static inline int cxl_interleave_verify(struct cxl_port *port,
+					int ways, int granularity)
+{
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	unsigned int addr_mask;
+	u16 ig;
+	u8 iw;
+	int rc;
+
+	rc = granularity_to_cxl(granularity, &ig);
+	if (rc)
+		return rc;
+
+	rc = ways_to_cxl(ways, &iw);
+	if (rc)
+		return rc;
+
+	if (iw == 0)
+		return 0;
+
+	if (iw < CXL_INTERLEAVE_3_WAY)
+		addr_mask = GENMASK(ig + 8 + iw - 1, ig + 8);
+	else
+		addr_mask = GENMASK((ig + iw) / 3 - 1, ig + 8);
+
+	if (~cxlhdm->interleave_mask & addr_mask)
+		return -EINVAL;
+
+	return 0;
+}
+
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);


