Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A774EB64DB
	for <linux-cxl@archiver.kernel.org>; Sat, 17 Jun 2023 01:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjFQBYp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 21:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFQBYo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 21:24:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F9C3A89
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 18:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686965083; x=1718501083;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K7tluqE3P57+t6+elFobmBO3ulslD61Io2yb0mi+Kt4=;
  b=AnUYvjFe9aifjAHXjZQ/cPAo0lE6V6fehMxx/Ba5tMmiDDeRvP94pf5P
   Gju7DUhx/SjUJc3w9GI4iYFfkcrFBSAVBcZ7TRurRwpRlO/wHrO47ndNq
   VADIF5F9bJZwuvUVkUUfOBzn7c3ZhDzm/PHmKdUrXQSwIFQxlRkMZ6joT
   U3FNfQ0bV3yyCsnUh5dN0tdlwdFPQhQqJ56+WLNhuUrBX46y8E9JQP7wy
   lPQTIwyamfyYUdcE7wASeHesT63NCwM9HgXNPwwLvlce8eyakytM3UtCd
   +cr/I9q27xf/A24ryHNz/V4xrHTCMtGNa/OK9u3H7ZQ0asKaCWXliahdo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="362762340"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="362762340"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 18:24:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="713073323"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="713073323"
Received: from slovely-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.23.80])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 18:24:34 -0700
Subject: [PATCH 2/3] cxl/region: Flag partially torn down regions as unusable
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date:   Fri, 16 Jun 2023 18:24:34 -0700
Message-ID: <168696507423.3590522.16254212607926684429.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168696506332.3590522.12981963617215460385.stgit@dwillia2-xfh.jf.intel.com>
References: <168696506332.3590522.12981963617215460385.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

cxl_region_decode_reset() walks all the decoders associated with a given
region and disables them. Due to decoder ordering rules it is possible
that a switch in the topology notices that a given decoder can not be
shutdown before another region with a higher HPA is shutdown first. That
can leave the region in a partially committed state.

Capture that state in a new CXL_REGION_F_NEEDS_RESET flag and require
that a successful cxl_region_decode_reset() attempt must be completed
before cxl_region_probe() accepts the region.

This is a corollary for the bug that Jonathan identified in "CXL/region
:  commit reset of out of order region appears to succeed." [1].

Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Link: http://lore.kernel.org/r/20230316171441.0000205b@Huawei.com [1]
Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   12 ++++++++++++
 drivers/cxl/cxl.h         |    8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d48c5916f2e9..31f498f0fb3a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -182,14 +182,19 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 				rc = cxld->reset(cxld);
 			if (rc)
 				return rc;
+			set_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
 		}
 
 endpoint_reset:
 		rc = cxled->cxld.reset(&cxled->cxld);
 		if (rc)
 			return rc;
+		set_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
 	}
 
+	/* all decoders associated with this region have been torn down */
+	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
+
 	return 0;
 }
 
@@ -2876,6 +2881,13 @@ static int cxl_region_probe(struct device *dev)
 		goto out;
 	}
 
+	if (test_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags)) {
+		dev_err(&cxlr->dev,
+			"failed to activate, re-commit region and retry\n");
+		rc = -ENXIO;
+		goto out;
+	}
+
 	/*
 	 * From this point on any path that changes the region's state away from
 	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 187abd8ba673..cd7bf6697a51 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -469,6 +469,14 @@ struct cxl_region_params {
  */
 #define CXL_REGION_F_AUTO 0
 
+/*
+ * Require that a committed region successfully complete a teardown once
+ * any of its associated decoders have been torn down. This maintains
+ * the commit state for the region since there are committed decoders,
+ * but blocks cxl_region_probe().
+ */
+#define CXL_REGION_F_NEEDS_RESET 1
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device

