Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910BEC6FD18
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Mar 2023 18:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjC1Sgi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Mar 2023 14:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjC1Sgg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Mar 2023 14:36:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ECE1BF4
        for <linux-cxl@vger.kernel.org>; Tue, 28 Mar 2023 11:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680028583; x=1711564583;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X9QS46FA3kQXYSY4QtBULGRaMXFrQLJAcb/XNfbltgs=;
  b=A2lb4a+y7IvL/VEm/4IQ8Gcjogeh2DaZzqUnQiODwm2ZfS3vtTQqhbw8
   14DgFhMxrHGSh5dMBVXT/O0Dpw/hUnTWnnBgEuIyGWsTXUqXTVXWfKIry
   gQtuJ6HFrxPIo5ETvKSGZn/dasPjDukMoArl0yye3e+a5lVi78weVK9hu
   p/i6YOvzRBY01JUTq2E1E6O+eYngYjphBwHpyK3FfwPKr1bHIZpkOtvoi
   fi4DyZNEZwDzVQCKO8vvldji6x1HfyV7amPbOG0SVwrh6xFdsTF8gwWN8
   m/pzoXXQGw/M5eY4I03cnmnIEDMw+jYOO+ndrasQareBUGHusRS3evtCV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="403273398"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="403273398"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 11:36:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="714356707"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="714356707"
Received: from liujimm1-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.164.112])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 11:36:22 -0700
Subject: [PATCH] cxl/region: Fix region setup/teardown for RCDs
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Tue, 28 Mar 2023 11:36:22 -0700
Message-ID: <168002858268.50647.728091521032131326.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

RCDs (CXL memory devices that link train without VH capability and show
up as root complex integrated endpoints), hide the presence of the link
between the endpoint and the host-bridge. The CXL region setup/teardown
paths assume that a link hop is present and go looking for at least one
'struct cxl_port' instance between the CXL root port-object and an
endpoint port-object leading to crashes of the form:

    BUG: kernel NULL pointer dereference, address: 0000000000000008
    [..]
    RIP: 0010:cxl_region_setup_targets+0x3e9/0xae0 [cxl_core]
    [..]
    Call Trace:
     <TASK>
     cxl_region_attach+0x46c/0x7a0 [cxl_core]
     cxl_create_region+0x20b/0x270 [cxl_core]
     cxl_mock_mem_probe+0x641/0x800 [cxl_mock_mem]
     platform_probe+0x5b/0xb0

Detect RCDs explicitly and skip walking the non-existent port hierarchy
between root and endpoint in that case.

While this has been a problem since:

commit 0a19bfc8de93 ("cxl/port: Add RCD endpoint port enumeration")

...it becomes a more reliable crash scenario with the new autodiscovery
implementation.

Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 808f23ec4e2b..52bbf6268d5f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -134,9 +134,13 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 		struct cxl_port *iter = cxled_to_port(cxled);
+		struct cxl_dev_state *cxlds = cxlmd->cxlds;
 		struct cxl_ep *ep;
 		int rc = 0;
 
+		if (cxlds->rcd)
+			goto endpoint_reset;
+
 		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
 			iter = to_cxl_port(iter->dev.parent);
 
@@ -153,6 +157,7 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 				return rc;
 		}
 
+endpoint_reset:
 		rc = cxled->cxld.reset(&cxled->cxld);
 		if (rc)
 			return rc;
@@ -1199,6 +1204,7 @@ static void cxl_region_teardown_targets(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled;
+	struct cxl_dev_state *cxlds;
 	struct cxl_memdev *cxlmd;
 	struct cxl_port *iter;
 	struct cxl_ep *ep;
@@ -1214,6 +1220,10 @@ static void cxl_region_teardown_targets(struct cxl_region *cxlr)
 	for (i = 0; i < p->nr_targets; i++) {
 		cxled = p->targets[i];
 		cxlmd = cxled_to_memdev(cxled);
+		cxlds = cxlmd->cxlds;
+
+		if (cxlds->rcd)
+			continue;
 
 		iter = cxled_to_port(cxled);
 		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
@@ -1229,14 +1239,24 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled;
+	struct cxl_dev_state *cxlds;
+	int i, rc, rch = 0, vh = 0;
 	struct cxl_memdev *cxlmd;
 	struct cxl_port *iter;
 	struct cxl_ep *ep;
-	int i, rc;
 
 	for (i = 0; i < p->nr_targets; i++) {
 		cxled = p->targets[i];
 		cxlmd = cxled_to_memdev(cxled);
+		cxlds = cxlmd->cxlds;
+
+		/* validate that all targets agree on topology */
+		if (!cxlds->rcd) {
+			vh++;
+		} else {
+			rch++;
+			continue;
+		}
 
 		iter = cxled_to_port(cxled);
 		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
@@ -1256,6 +1276,12 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
 		}
 	}
 
+	if (rch && vh) {
+		dev_err(&cxlr->dev, "mismatched CXL topologies detected\n");
+		cxl_region_teardown_targets(cxlr);
+		return -ENXIO;
+	}
+
 	return 0;
 }
 

