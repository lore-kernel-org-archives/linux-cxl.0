Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAACC001DB
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 23:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjHDX1f (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 19:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHDX1e (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 19:27:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902F24EED
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 16:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691191649; x=1722727649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=joZXmGjPAxRZoRKr6hWOPeQbk/gmp8Fuufduol5rRh8=;
  b=XuCbwrUj9+zdzemxcT/37TXQYO4g8vXKLy15EKildNA8cm7Gmyj1uDc5
   uFZNhyD+gqzzEzglz/FZQJbmg77VhIl+3x8bFQNFdwV9jvWa47dXrxc7s
   Eu51Em+wwj7X1a40h4UTkmsXVW3+2Dbk1UeNkx7POvbJeFGN1XYKvWoip
   fm/NFO5ItQkxhHAzvpCa/7jqkbeEe7tMtCkiZHCSHArHKy2oJafB57sYE
   K41NlsKTFU2w+geJ6pwBLCuyAByDcqCwJFXEjIsnMNZiR4LLcE4YQ7DH4
   jUxYTP2622B8oL/6OQrP4syqiMmuWAelJCw0qE7re+LFfq5ubpW1Iwjwn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="349860921"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="349860921"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 16:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="795610398"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="795610398"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.168.219])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 16:27:28 -0700
From:   alison.schofield@intel.com
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/region: Refactor granularity select in cxl_port_setup_targets()
Date:   Fri,  4 Aug 2023 16:27:26 -0700
Message-Id: <20230804232726.1672782-1-alison.schofield@intel.com>
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

The existing calculations use the encrypted interleave granularity
value, the eig, to create an interleave granularity that properly
fans out when routing an x1 interleave to a greater than x1 interleave.

That all worked well, until this config came along:
Host Bridge: 2 way at 256 granularity
    Switch Decoder_A:	1 way at 512
        Endpoint_X:	2 way at 512
    Switch Decoder_B:	1 way at 512
        Endpoint_Y:	2 way at 512

When the Host Bridge interleave is greater that 1, and the root
decoder interleave is exactly 1, the region driver needs to
consider the number of targets in the region when calculating
the expected granularity.

While examining the existing logic, and trying to cover the case
above, a couple of simplifications appeared, hence this proposed
refactoring.

The first simplicfication is to apply the logic to the unencrypted
values and use the existing helper function granularity_to_eig() to
translate the desired granularity to the encrypted form. This means
the comment and code regarding setting address bits is discarded.
Although that logic was not wrong, it adds a level of complexity that
is not required in the granularity selection. The eig and eiw are
indeed part of the routing instructions programmed into the decoders.
Up-level the discussion to plain ways and granularity for clearer
analysis.

The second simplification reduces the logic to a single granularity
calculation that works for all cases. The new calculation doesn't
care if parent_iw => 1,  because parent_iw is used as a multiplier.

The refactor cleans up a useless assignment of eiw, made after the iw
is already calculated.

Regression testing included an examination of all of the ways and
granularity selections made during a run of the cxl_test unit tests.
There were no differences in selections before and after this patch.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
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

