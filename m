Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD3CC4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Nov 2022 23:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiKVXID (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Nov 2022 18:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiKVXH7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Nov 2022 18:07:59 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737A157B46
        for <linux-cxl@vger.kernel.org>; Tue, 22 Nov 2022 15:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669158478; x=1700694478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uvjsPCrqpMeNvq17CbE59imaMx5SiBsvl2YfoBHFkUw=;
  b=KFbNv3CqvGiVmice+fvYcT6wswv6VNh0fwPotKb7GwWDym9GKiHp6jEV
   mUUZYagt+U8xJlyAMt7CtioeldrnIpd7W3N2DwKTaldRPWRyDuV6U/QO8
   d7mPti3uRIMzFPR3g8TPWd2DQMXiywonK7ARdmoKW/tkwZHwrty6V4sw4
   vjgn7fbK14EF+/4kp9tLL+cgHs03bOsC0C1w8meAN9pFVCrL6u4I6yrmq
   ScBmOcow/1k/dOqWBPY8tEVUocpjOjShpHf7xHGZRWZMJYWXGBbvvswME
   9ZsbtrUPcKIR9LF9WkoWRSmrvDNPofEWc4Elsk8pL1IB4RFFYTB0LgFtL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="376079344"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="376079344"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 15:07:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747542506"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="747542506"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.144.204])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 15:07:56 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 3/4] cxl/acpi: Move the target entry(n) calc to its own function
Date:   Tue, 22 Nov 2022 15:07:50 -0800
Message-Id: <1e39c68d7e8916eed215f5448ef1dcbb2eea0ece.1669153711.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1669153711.git.alison.schofield@intel.com>
References: <cover.1669153711.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

In preparation for reusing the calculation of a targets
entry (n) in the host bridge interleave set, move it to
a separate function.

Make it accept an HPA parameter so that it is useful for
validating DPA to HPA address translations.

No functional change.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/acpi.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 98c84942ed37..38b5f77164b0 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -19,6 +19,25 @@ struct cxl_cxims_data {
  * Find a targets entry (n) in the host bridge interleave list.
  * CXL Specfication 3.0 Table 9-22
  */
+static int cxl_xor_calc_n(u64 hpa, struct cxl_cxims_data *cximsd, int iw,
+			  int ig)
+{
+	int eiw, i = 0, n = 0;
+
+	/* IW: 2,4,6,8,12,16 begin building 'n' using xormaps */
+	if (iw != 3) {
+		for (i = 0; i < cximsd->nr_maps; i++)
+			n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
+	}
+	/* IW: 3,6,12 add a modulo calculation to 'n' */
+	if (!is_power_of_2(iw)) {
+		eiw = ilog2(iw / 3) + 8;
+		hpa &= GENMASK_ULL(51, eiw + ig);
+		n |= do_div(hpa, 3) << i;
+	}
+	return n;
+}
+
 static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
 {
 	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
@@ -26,7 +45,7 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
 	struct cxl_decoder *cxld = &cxlsd->cxld;
 	int ig = cxld->interleave_granularity;
 	int iw = cxld->interleave_ways;
-	int eiw, i = 0, n = 0;
+	int n = 0;
 	u64 hpa;
 
 	if (dev_WARN_ONCE(&cxld->dev,
@@ -34,26 +53,12 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
 			  "misconfigured root decoder\n"))
 		return NULL;
 
-	if (iw == 1)
-		/* Entry is always 0 for no interleave */
-		return cxlrd->cxlsd.target[0];
-
 	hpa = cxlrd->res->start + pos * ig;
 
-	if (iw == 3)
-		goto no_map;
+	/* Entry (n) is 0 for no interleave (iw == 1) */
+	if (iw != 1)
+		n = cxl_xor_calc_n(hpa, cximsd, iw, ig);
 
-	/* IW: 2,4,6,8,12,16 begin building 'n' using xormaps */
-	for (i = 0; i < cximsd->nr_maps; i++)
-		n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
-
-no_map:
-	/* IW: 3,6,12 add a modulo calculation to 'n' */
-	if (!is_power_of_2(iw)) {
-		eiw = ilog2(iw / 3) + 8;
-		hpa &= GENMASK_ULL(51, eiw + ig);
-		n |= do_div(hpa, 3) << i;
-	}
 	return cxlrd->cxlsd.target[n];
 }
 
-- 
2.37.3

