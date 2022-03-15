Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DFDC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Mar 2022 01:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbiCOBXk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiCOBXj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Mar 2022 21:23:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06731473B5
        for <linux-cxl@vger.kernel.org>; Mon, 14 Mar 2022 18:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647307349; x=1678843349;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ekg3QkenQ6oQU9t/hc85Ktv8B5R0T7HshHJ+qzqcGxk=;
  b=VYLK649QrbG7RKTbfhE06LsSzkQelUEi3YRrVbWrrsuxhXPISBvJ4TJt
   syC9eO2DXC3cXAqQqgmQCr/jJMefoITUujm1d2ezVfQ/maqPevqvBVMqk
   X8g5qcSKIAwxloV7ugWxjYFxTxGRA6OUCMWWaATGJZBM68bwA1CpjdYZ5
   pQr4TsPuZVbRvzKU9Z1MRtnEDYXly1OkLJ0VYjiq2GwPWa0gZklQ167j9
   Oal7cB7Iz6eG4JLXxAPwlHpM0zg+36PRJKvGdRj+XCQw/fKOPwwzfLBej
   Egb+dv6hXP6+uIWy/cjEq1/g2eVD30mUwiMiu5DGFyU50w2TNodyItG3Y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255914710"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="255914710"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:22:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="540225755"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:22:28 -0700
Subject: [PATCH v2 2/6] cxl/pci: Add debug for DVSEC range init failures
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ben.widawsky@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Mon, 14 Mar 2022 18:22:28 -0700
Message-ID: <164730734812.3806189.2726330688692684104.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for not treating DVSEC range initialization failures as
fatal to cxl_pci_probe() add individual dev_dbg() statements for each of
the major failure reasons in cxl_dvsec_ranges().

The rationale for cxl_dvsec_ranges() failure not being fatal is that
there is still value for cxl_pci to enable mailbox operations even if
CXL.mem operation is disabled.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8a7267d116b7..257cf735505d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -467,12 +467,15 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
 {
 	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct device *dev = &pdev->dev;
 	int d = cxlds->cxl_dvsec;
 	int hdm_count, rc, i;
 	u16 cap, ctrl;
 
-	if (!d)
+	if (!d) {
+		dev_dbg(dev, "No DVSEC Capability\n");
 		return -ENXIO;
+	}
 
 	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
 	if (rc)
@@ -482,8 +485,10 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
 	if (rc)
 		return rc;
 
-	if (!(cap & CXL_DVSEC_MEM_CAPABLE))
+	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
+		dev_dbg(dev, "Not MEM Capable\n");
 		return -ENXIO;
+	}
 
 	/*
 	 * It is not allowed by spec for MEM.capable to be set and have 0 legacy
@@ -496,8 +501,10 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
 		return -EINVAL;
 
 	rc = wait_for_valid(cxlds);
-	if (rc)
+	if (rc) {
+		dev_dbg(dev, "Failure awaiting MEM_INFO_VALID (%d)\n", rc);
 		return rc;
+	}
 
 	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
 

