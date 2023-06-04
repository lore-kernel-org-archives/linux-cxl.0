Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D52AC7EE2D
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjFDXcy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjFDXcx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:32:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4E3CE
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921571; x=1717457571;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YV+9yom6H5fHWr32iXQ9au5Z8i5MUBxqlTuCkb/lWBY=;
  b=DCTlnEJI9tt3hbBy6cgy+cy/If8dyDFm8HyiJB4J7zN6amVqm+U1dMQK
   KaJpt0oHZ5yL2wNkI6jdCm0QkhQ2bQj5Yf+btExtmmRsndGU45x2kbCSL
   cdzXvCmOeA+KNUqbRZdjZi3UuVgmN0BPV0lnypCjfUAg051ylKMyQXOZf
   3s+LIUzLrZM9XSosys3GsKwXECx+V76OEB5OGLrvQiCUOYqbs2Ifr8FuH
   mmPmIwk3ejtw+HyD8EGWpjtaAwLLsOCnoJrc6/m91trVcMwmeUIo7dLx6
   cCYAo9sEFs96A/nsSm3T80A2O/yp3kUbkBxVRzn/SqZHyYUqhWLMN0r5w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="336596819"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336596819"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="1038572000"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="1038572000"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:50 -0700
Subject: [PATCH 13/19] cxl/region: Factor out interleave granularity setup
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:32:50 -0700
Message-ID: <168592157031.1948938.2150827780624190474.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave_granularity.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 821c2d90154f..4d8dbfedd64a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -414,21 +414,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return rc;
 }
 
-static ssize_t interleave_granularity_store(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf, size_t len)
+static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	int rc, val;
+	int rc;
 	u16 ig;
 
-	rc = kstrtoint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = granularity_to_eig(val, &ig);
 	if (rc)
 		return rc;
@@ -444,16 +437,30 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
+	lockdep_assert_held_write(&cxl_region_rwsem);
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
+
+	p->interleave_granularity = val;
+	return 0;
+}
+
+static ssize_t interleave_granularity_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	int rc, val;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc)
+		return rc;
+
 	rc = down_write_killable(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
 
-	p->interleave_granularity = val;
-out:
+	rc = set_interleave_granularity(cxlr, val);
 	up_write(&cxl_region_rwsem);
 	if (rc)
 		return rc;

