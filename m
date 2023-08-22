Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FCBEE49AE
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Aug 2023 18:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjHVSJf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Aug 2023 14:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHVSJf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Aug 2023 14:09:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB95196
        for <linux-cxl@vger.kernel.org>; Tue, 22 Aug 2023 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692727772; x=1724263772;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2l/axvsWrj1cIq+9nWiU0DCIXBolbV++92OP6x5N5dY=;
  b=AZHR5WNV1HcQOBD1HN194TYb4KYSZInkqVoRLSi/0xYfLvsF6M6mEVvy
   bp023rOx5Tv2hAgZy9ROddSNmRfqgV3xTkloRUdZo4CVmpG0PO8KI4KHF
   tKTjI7O+an/NwPdfDlU1X69u5KLNrsKbdCtE3RvRT7jQ1V3dJisJ3eGhi
   5EiZUvGpo1gG3xSvIFNvRECLGvXPRBpHjouveLdxL3nyVtXH2aNIs5kLP
   /mQZlGQSRpOoeFmMzfzhshg6jmF7vfiV1UXO6x7kekpB9slKComlKRsLQ
   9qRb/mxLlD4DlZvjPxYkoalVRBv4rh9XkH9dd0e3OIpSFD1oaeiQDamA4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="353515446"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="353515446"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 11:09:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="713273015"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="713273015"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.133.51])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 11:09:30 -0700
From:   alison.schofield@intel.com
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl/region: Refactor granularity select in cxl_port_setup_targets()
Date:   Tue, 22 Aug 2023 11:09:28 -0700
Message-Id: <20230822180928.117596-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

In cxl_port_setup_targets() the region driver validates the
configuration of auto-discovered region decoders, as well
as decoders the driver is preparing to program.

The existing calculations use the encoded interleave granularity
value to create an interleave granularity that properly fans out
when routing an x1 interleave to a greater than x1 interleave.

That all worked well, until this config came along:
Host Bridge: 2 way at 256 granularity
    Switch Decoder_A:	1 way at 512
        Endpoint_X:	2 way at 256
    Switch Decoder_B:	1 way at 512
        Endpoint_Y:	2 way at 256

When the Host Bridge interleave is greater than 1 and the root
decoder interleave is exactly 1, the region driver needs to
consider the number of targets in the region when calculating
the expected granularity.

While examining the existing logic, and trying to cover the case
above, a couple of simplifications appeared, hence this proposed
refactoring.

The first simplification is to apply the logic to the nominal
values and use the existing helper function granularity_to_eig() to
translate the desired granularity to the encoded form. This means
the comment and code regarding setting address bits is discarded.
Although that logic is not wrong, it adds a level of complexity that
is not required in the granularity selection. The eig and eiw are
indeed part of the routing instructions programmed into the decoders.
Up-level the discussion to nominal ways and granularity for clearer
analysis.

The second simplification reduces the logic to a single granularity
calculation that works for all cases. The new calculation doesn't
care if parent_iw => 1 because parent_iw is used as a multiplier.

The refactor cleans up a useless assignment of eiw made after the
iw is already calculated.

Regression testing included an examination of all of the ways and
granularity selections made during a run of the cxl_test unit tests.
There were no differences in selections before and after this patch.

Fixes: ("27b3f8d13830 cxl/region: Program target lists")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
- No changes to the code. Commit log fixups only.
- Correct the commit log example. Endpoints are 2 * 256 (Jonathan)
- Use 'encoded' and 'nominal' when referring to the interleave
  granularity format (Dan, DaveJ) 
- Commit log grammar & spelling fixups (Dan, DaveJ)
- Add Fixes Tag (Dan)
- v1: https://lore.kernel.org/linux-cxl/20230804232726.1672782-1-alison.schofield@intel.com/

 drivers/cxl/core/region.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e115ba382e04..5a1cc59cca99 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1154,16 +1154,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	}
 
 	/*
-	 * If @parent_port is masking address bits, pick the next unused address
-	 * bit to route @port's targets.
+	 * Interleave granularity is a multiple of @parent_port granularity.
+	 * Multiplier is the parent port interleave ways.
 	 */
-	if (parent_iw > 1 && cxl_rr->nr_targets > 1) {
-		u32 address_bit = max(peig + peiw, eiw + peig);
-
-		eig = address_bit - eiw + 1;
-	} else {
-		eiw = peiw;
-		eig = peig;
+	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
+	if (rc) {
+		dev_dbg(&cxlr->dev,
+			"%s: invalid granularity calculation (%d * %d)\n",
+			dev_name(&parent_port->dev), parent_ig, parent_iw);
+		return rc;
 	}
 
 	rc = eig_to_granularity(eig, &ig);

base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
-- 
2.37.3

