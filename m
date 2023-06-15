Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85373EB64DB
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 01:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbjFOBaW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbjFOBaW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 21:30:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D36F26A8
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 18:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686792620; x=1718328620;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kfC9e9hdSfLaMLgx4RojrLbIF/YbNbOm1Yck5JCEGF4=;
  b=G/3SXo+bIR2kE5hUBU+Z71mCrIGGNjSaexdfd3V2NUeUAmZzhWHqbSQ0
   PLBe8PgW4IYNAsReusEvnMIPB+Q4mYIjHgoAYKZMscf9B0eRjH8P8RmfS
   /i1m+PkrZZ4A8ZyYt2OOlYmP9zRU0b1spLN0LW0oiNRzjtcKpLujdLGct
   JqYRVv5wGq5ZgHRu2GFlmRYADJOxlR+wyazN+ZQxk/jrc8BxtT0+GuZtO
   PVG2hpizjHK4xjRo4egziIX6i0ZzDcfbrYwLBbdjTnRp5pd8nH6zYJbrb
   hQPzA7SRB07qv0T7q6h7XgkkkMKY4HDTNskhOUUWULeBtMz0SNzQYRFUr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338412388"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="338412388"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:30:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782307325"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="782307325"
Received: from rtpearso-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.87.28])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:30:20 -0700
Subject: [PATCH v2 08/12] cxl/hdm: Default CXL_DEVTYPE_DEVMEM decoders to
 CXL_DECODER_DEVMEM
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 14 Jun 2023 18:30:19 -0700
Message-ID: <168679261945.3436160.11673393474107374595.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for device-memory region creation, arrange for decoders
of CXL_DEVTYPE_DEVMEM memdevs to default to CXL_DECODER_DEVMEM for their
target type.

Revisit this if a device ever shows up that wants to offer mixed HDM-H
(Host-Only Memory) and HDM-DB support, or an CXL_DEVTYPE_DEVMEM device
that supports HDM-H.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |   35 ++++++++++++++++++++++++++---------
 drivers/cxl/cxl.h      |    2 +-
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 79170de13d89..715c1f103739 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -572,7 +572,7 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u32p_replace_bits(ctrl,
 			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
-			  CXL_HDM_DECODER0_CTRL_TYPE);
+			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
 }
 
 static int cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
@@ -794,8 +794,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    int *target_map, void __iomem *hdm, int which,
 			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
 {
+	struct cxl_endpoint_decoder *cxled = NULL;
 	u64 size, base, skip, dpa_size, lo, hi;
-	struct cxl_endpoint_decoder *cxled;
 	bool committed;
 	u32 remainder;
 	int i, rc;
@@ -828,6 +828,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		return -ENXIO;
 	}
 
+	if (info)
+		cxled = to_cxl_endpoint_decoder(&cxld->dev);
 	cxld->hpa_range = (struct range) {
 		.start = base,
 		.end = base + size - 1,
@@ -838,7 +840,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		cxld->flags |= CXL_DECODER_F_ENABLE;
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |= CXL_DECODER_F_LOCK;
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
 			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
@@ -857,12 +859,28 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		}
 		port->commit_end = cxld->id;
 	} else {
-		/* unless / until type-2 drivers arrive, assume type-3 */
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0) {
-			ctrl |= CXL_HDM_DECODER0_CTRL_TYPE;
+		if (cxled) {
+			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+			struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+			/*
+			 * Default by devtype until a device arrives that needs
+			 * more precision.
+			 */
+			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
+				cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+			else
+				cxld->target_type = CXL_DECODER_DEVMEM;
+		} else {
+			/* To be overridden by region type at commit time */
+			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+		}
+
+		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) &&
+		    cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
+			ctrl |= CXL_HDM_DECODER0_CTRL_HOSTONLY;
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
-		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	}
 	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
 			  &cxld->interleave_ways);
@@ -881,7 +899,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
 		cxld->interleave_ways, cxld->interleave_granularity);
 
-	if (!info) {
+	if (!cxled) {
 		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
 		target_list.value = (hi << 32) + lo;
@@ -904,7 +922,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
 	hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(which));
 	skip = (hi << 32) + lo;
-	cxled = to_cxl_endpoint_decoder(&cxld->dev);
 	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
 	if (rc) {
 		dev_err(&port->dev,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ae0965ac8c5a..f309b1387858 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -56,7 +56,7 @@
 #define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
 #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
 #define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
-#define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
+#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
 #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)

