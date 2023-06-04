Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7D4C7EE23
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjFDXcN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjFDXcM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:32:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1DACE
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921531; x=1717457531;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n9JmwHyG/mNbQY3LJZTac7A4xsahI3kdXqUrPYCGwnw=;
  b=AUOebZOZ/a9D3EuV1ZbxXfMFhIT8m0CXd+KdWXi1N8BulbeS95t2wxyZ
   R1PpN8Fnx1bUNTN4U05/5qfAuwQI9KKWyBiwFUvfFMlz1ovx49Fxg5sgK
   pyGH+gZrUj+xAX1jy78qgqrLLV2akCibM8P1x3N4foqzDoSWifgU3fFuP
   EwlXHS1kuURNyYcCRHZ8dAePCak8/kn35P1cjN7F2kXQ913Oje+7ytCj9
   bs6GBTl9aWNGjvf0pj7uxcXXI9+Mn4lhAmK6C4kE4fwfO+rpm9OcdZqAZ
   0eEwmqxFtph0fbVYwCjlN8SGgIXaDq5+2ecD+0BVL8lFR6xiNd3nEYOPI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="384534741"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="384534741"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="832611412"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="832611412"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:10 -0700
Subject: [PATCH 06/19] cxl/hdm: Default CXL_DEVTYPE_DEVMEM decoders to
 CXL_DECODER_DEVMEM
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:32:10 -0700
Message-ID: <168592153054.1948938.12344684637653088842.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
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

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index de8a3fb28331..ca3b99c6eacf 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -856,12 +856,22 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		}
 		port->commit_end = cxld->id;
 	} else {
-		/* unless / until type-2 drivers arrive, assume type-3 */
 		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0) {
 			ctrl |= CXL_HDM_DECODER0_CTRL_TYPE;
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
-		cxld->target_type = CXL_DECODER_HOSTMEM;
+		if (cxled) {
+			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+			struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
+				cxld->target_type = CXL_DECODER_HOSTMEM;
+			else
+				cxld->target_type = CXL_DECODER_DEVMEM;
+		} else {
+			/* To be overridden by region type at commit time */
+			cxld->target_type = CXL_DECODER_HOSTMEM;
+		}
 	}
 	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
 			  &cxld->interleave_ways);

