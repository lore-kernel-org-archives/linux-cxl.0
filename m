Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9D9C4332F
	for <linux-cxl@archiver.kernel.org>; Mon,  5 Dec 2022 00:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiLEA34 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Dec 2022 19:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLEA3z (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Dec 2022 19:29:55 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6261114F
        for <linux-cxl@vger.kernel.org>; Sun,  4 Dec 2022 16:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670200195; x=1701736195;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=odoLeU2CVjQSChFXqWhvaFoSYDULb4IsN+qpK8sEVE0=;
  b=jLEtsidJfSbZ4JiW2kF60dSaGv7MJ5YdExzJdO3r+UrJnfFNGJrIhVYa
   hHiJ12fnzVWGSyCMEOww4g5zGy+w0HnNoEychGuM/mC3DsyzF04SjlDtg
   QwVHRH1/vseHcQlxzKw/thrm9fxDLJkiou458qp7qZZmDQLkU1AheshNd
   yB584PQjsK/deMuMMh93t6+uiOh5Aj4Ujh6Z7QwF85QEe8tOO4JVvurit
   iw48VFyRVC4uGeb0kx2u0enSx2uhSuaDLzelTz896yWMvujajNJz9L7kP
   4rPaXKL8ohvRs/qIYtm7uP02YtmzSHaWx0bTRmVP1aTwn433fmqRaEVMT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="378389859"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="378389859"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 16:29:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="623307863"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="623307863"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.88.173])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 16:29:54 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/acpi: Fail decoder add if CXIMS for HBIG is missing
Date:   Sun,  4 Dec 2022 16:29:51 -0800
Message-Id: <20221205002951.1788783-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The BIOS provided CXIMS (CXL XOR Interleave Math Structure) is required
for calculating a targets position in an interleave list during region
creation. The CXL driver expects to discover a CXIMS that matches the
HBIG (Host Bridge Interleave Granularity) and stores the xormaps found
in that CXIMS for retrieval during region creation.

If there is no CXIMS for an HBIG, no maps are stored. That leads to a
NULL pointer dereference at xormap retrieval during region creation.

Add a check during ACPI probe for the case of no matching CXIMS. Emit
an error message and fail to add the decoder.

Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Not sure the Commit-ID in Fixes tag will persist. (from cxl/pending)

 drivers/cxl/acpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 657ef250d848..420e322c85a1 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -282,6 +282,11 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 						   cxl_parse_cxims, &cxims_ctx);
 			if (rc < 0)
 				goto err_xormap;
+			if (!cxlrd->platform_data) {
+				dev_err(dev, "No CXIMS for HBIG %u\n", ig);
+				rc = -EINVAL;
+				goto err_xormap;
+			}
 		}
 	}
 	rc = cxl_decoder_add(cxld, target_map);

base-commit: d72a5b810410c076d4dd63fe542a5a4d6c145cfa
-- 
2.37.3

