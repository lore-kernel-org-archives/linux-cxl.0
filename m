Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DD2C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Mar 2022 01:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbiCOBXv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241657AbiCOBXu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Mar 2022 21:23:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DDF473B2
        for <linux-cxl@vger.kernel.org>; Mon, 14 Mar 2022 18:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647307359; x=1678843359;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gEcZs4d1EX/UWX70naqyxJMPT2UTtp/Atn0rM70ynIY=;
  b=k3+MMBJUURbZzpVeWQMANtwqXLv9O9pvjpkS14jKSxUZM8ZuBVFNRHUk
   z2NpiHKTJSRbKkRDJtT58+udJND0u9+rulw+wKaNChfKlgS8x0jtAbc6h
   nCxcP+gV4Jr5snmJ5Tqu8ZLVvzjdwc87ZE/0U3SOU16Vg38kJO7X5+7q3
   qkPfN4MUT1siqiDEwljRhptSPD6H7BASHmyOM3LYry5bci7PFVIdqNnPU
   UDs0sd+I96nHqYymcxCpC+EyMo1V6rjytV/Ru2Um501fuLAQspU1tKaCH
   FFs14qlnRbLtBXTQzxDVQt19m+nllPZv6YmjohrDIW7IOG5O3+hmJgPbt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="238353731"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="238353731"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:22:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="549430520"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:22:39 -0700
Subject: [PATCH v2 4/6] cxl/pci: Make cxl_dvsec_ranges() failure not fatal
 to cxl_pci
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Krzysztof Zach <krzysztof.zach@intel.com>, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Date:   Mon, 14 Mar 2022 18:22:38 -0700
Message-ID: <164730735869.3806189.4032428192652531946.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

cxl_dvsec_ranges(), the helper for enumerating the presence of an active
legacy CXL.mem configuration on a CXL 2.0 Memory Expander, is not fatal
for cxl_pci because there is still value to enable mailbox operations
even if CXL.mem operation is disabled. Recall that the reason cxl_pci
does this initialization and not cxl_mem is to preserve the useful
property (for unit testing) that cxl_mem is cxl_memdev + mmio generic,
and does not require access to a 'struct pci_dev' to issue config
cycles.

Update 'struct cxl_endpoint_dvsec_info' to carry either a positive
number of non-zero size legacy CXL DVSEC ranges, or the negative error
code from __cxl_dvsec_ranges() in its @ranges member.

Reported-by: Krzysztof Zach <krzysztof.zach@intel.com>
Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 257cf735505d..994c79bf6afd 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -463,13 +463,18 @@ static int wait_for_media_ready(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
-static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
+/*
+ * Return positive number of non-zero ranges on success and a negative
+ * error code on failure. The cxl_mem driver depends on ranges == 0 to
+ * init HDM operation.
+ */
+static int __cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
+			      struct cxl_endpoint_dvsec_info *info)
 {
-	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int hdm_count, rc, i, ranges = 0;
 	struct device *dev = &pdev->dev;
 	int d = cxlds->cxl_dvsec;
-	int hdm_count, rc, i;
 	u16 cap, ctrl;
 
 	if (!d) {
@@ -546,10 +551,17 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
 		};
 
 		if (size)
-			info->ranges++;
+			ranges++;
 	}
 
-	return 0;
+	return ranges;
+}
+
+static void cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
+{
+	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
+
+	info->ranges = __cxl_dvsec_ranges(cxlds, info);
 }
 
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -618,10 +630,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_dvsec_ranges(cxlds);
-	if (rc)
-		dev_warn(&pdev->dev,
-			 "Failed to get DVSEC range information (%d)\n", rc);
+	cxl_dvsec_ranges(cxlds);
 
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))

