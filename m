Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFC9C433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 23 Jul 2022 00:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiGWA6H (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Jul 2022 20:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbiGWA5z (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Jul 2022 20:57:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CE5CB752
        for <linux-cxl@vger.kernel.org>; Fri, 22 Jul 2022 17:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658537780; x=1690073780;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jtreZ0vyEu3MtyJw62wYNOL8iKexXJrWzcbQT/8vpY8=;
  b=Mmw62LI+y2C1jkRhmmXT2ogxeOAIoB9EjuqmiG/6rTqXtjdd7DX9HLDu
   gtloVhBwS+uuurrtVcOpPTzSAUCj1/hVRju28yI7WWp3LR1sjLqr73CTT
   Tc8mCLkDUogcWfIocsdMUuf9ktZInu1Bh15a/mm1nEk+5hINfOIMBM22O
   P/Z7BHCpCmwHG/iyfGZjR+bh+eJP5MsTKf50nNEg2IkWSmoIXgs9Go79l
   +s2qND3s8azTKWG8W6caEb2hv3Saf0WojpXIfKL/k15f71erKGejlEsH5
   WW0z5+kdDr7N0ZV1LqN3h6MT6v12TFzLOPxL2xXWme8mFBa4OE+07H/mj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="349131613"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="349131613"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 17:56:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="626761540"
Received: from jeescalx-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.116.64])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 17:56:20 -0700
Subject: [PATCH 5/5] cxl/region: Constrain region granularity scaling factor
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Fri, 22 Jul 2022 17:56:20 -0700
Message-ID: <165853778028.2430596.7493880465382850752.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Consider the scenario where a platform provides for a x2 host-bridge
interleave at a granularity of 256 bytes. The only permitted region
granularities for that configuration are 256 or 512. Anything larger
than 512 results in unmapped capacity within a given decoder. Also, if
the region granularity is 512 then the interleave_ways for the region
must be 4 to keep the scaling matched.

Here are the translations for the first (4) 256-byte blocks where an
endpoint decoder is configured for a 512-byte granularity:

Block[0] => HB0 => DPA: 0
Block[1] => HB1 => DPA: 0
Block[2] => HB0 => DPA: 0
Block[3] => HB1 => DPA: 0

In order for those translations to not alias the region interleave ways
must be 4 resulting in:

Block[0] => HB0 => Dev0 => DPA: 0
Block[1] => HB1 => Dev1 => DPA: 0
Block[2] => HB0 => Dev2 => DPA: 0
Block[3] => HB1 => Dev3 => DPA: 0

...not 2, resulting in:

Block[0] => HB0 => Dev0 => DPA: 0
Block[1] => HB1 => Dev1 => DPA: 0
Block[2] => HB0 => Dev0 => DPA: 0 !
Block[3] => HB1 => Dev1 => DPA: 0 !

Given tooling is already being built around this ABI allow for
granularity and ways to be set in either order and validate the
combination once both are set.

Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   63 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 05b6212e6399..a34e537e4cb2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -348,6 +348,25 @@ static ssize_t interleave_ways_store(struct device *dev,
 		goto out;
 	}
 
+	/*
+	 * If region granularity has been set and xHB interleave is active,
+	 * validate that granularity is compatible with specified ways.
+	 * Otherwise allow ways to be set now and depend on
+	 * interleave_granularity_store() to validate this constraint.
+	 */
+	if (cxld->interleave_ways > 1 &&
+	    p->interleave_granularity > cxld->interleave_granularity &&
+	    p->interleave_granularity / cxld->interleave_granularity !=
+		    val / cxld->interleave_ways) {
+		dev_dbg(dev,
+			"ways scaling factor %d mismatch with granularity %d\n",
+			val / cxld->interleave_ways,
+			p->interleave_granularity /
+				cxld->interleave_granularity);
+		rc = -EINVAL;
+		goto out;
+	}
+
 	save = p->interleave_ways;
 	p->interleave_ways = val;
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
@@ -386,7 +405,7 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	int rc, val;
+	int rc, val, ways;
 	u16 ig;
 
 	rc = kstrtoint(buf, 0, &val);
@@ -403,9 +422,29 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	 * granularity less than the root interleave result in needing
 	 * multiple endpoints to support a single slot in the
 	 * interleave.
+	 *
+	 * When the root interleave ways is 1 then the root granularity is a
+	 * don't care.
+	 *
+	 * Limit region granularity to cxld->interleave_granularity *
+	 * rounddown_pow_of_two(cxld->interleave_ways) otherwise holes result in
+	 * the decode at each endpoint. Note that rounddown_pow_of_two()
+	 * accounts for x3, x6, and x9 root intereleave.
 	 */
-	if (val < cxld->interleave_granularity)
-		return -EINVAL;
+	ways = rounddown_pow_of_two(cxld->interleave_ways);
+	if (ways > 1) {
+		if (val < cxld->interleave_granularity) {
+			dev_dbg(dev, "granularity %d must be >= %d\n", val,
+				cxld->interleave_granularity);
+			return -EINVAL;
+		}
+
+		if (val > cxld->interleave_granularity * ways) {
+			dev_dbg(dev, "granularity %d must be <= %d\n", val,
+				cxld->interleave_granularity * ways);
+			return -EINVAL;
+		}
+	}
 
 	rc = down_write_killable(&cxl_region_rwsem);
 	if (rc)
@@ -415,6 +454,24 @@ static ssize_t interleave_granularity_store(struct device *dev,
 		goto out;
 	}
 
+	/*
+	 * If region ways has been set and xHB interleave is active, validate
+	 * that ways is compatible with specified granularity.  Otherwise allow
+	 * granularity to be set now and depend on interleave_ways_store() to
+	 * validate this constraint.
+	 */
+	if (cxld->interleave_ways > 1 && p->interleave_ways &&
+	    val > cxld->interleave_granularity &&
+	    p->interleave_ways / cxld->interleave_ways !=
+		    val / cxld->interleave_granularity) {
+		dev_dbg(dev,
+			"granularity scaling factor %d mismatch with ways %d\n",
+			val / cxld->interleave_granularity,
+			p->interleave_ways / cxld->interleave_ways);
+		rc = -EINVAL;
+		goto out;
+	}
+
 	p->interleave_granularity = val;
 out:
 	up_write(&cxl_region_rwsem);

